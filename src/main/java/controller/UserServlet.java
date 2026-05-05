package controller;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import model.User;
import util.LoggerUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/users")
public class UserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("toggle".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean status = Boolean.parseBoolean(req.getParameter("status"));
            userDAO.toggleStatus(id, !status);
            LoggerUtil.log(req, "Toggle Status", "Users", "User ID " + id + " status changed to " + (!status));
            resp.sendRedirect("users");
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("userToEdit", userDAO.getUserById(id));
            req.setAttribute("users", userDAO.getAllUsers());
            req.getRequestDispatcher("/views/users/list.jsp").forward(req, resp);
        } else {
            req.setAttribute("users", userDAO.getAllUsers());
            req.getRequestDispatcher("/views/users/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String username = req.getParameter("username");
        String pass = req.getParameter("password");
        String role = req.getParameter("role");
        
        if ("add".equals(action)) {
            userDAO.addUser(new User(0, username, pass, role, true));
            LoggerUtil.log(req, "Create", "Users", "New user added: " + username + " with role " + role);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            User user = new User(id, username, pass, role, true);
            if (pass != null && !pass.isEmpty()) {
                userDAO.updateWithPassword(user);
            } else {
                userDAO.updateUser(user);
            }
            LoggerUtil.log(req, "Update", "Users", "User ID " + id + " updated: " + username);
        }
        resp.sendRedirect("users");
    }
}
