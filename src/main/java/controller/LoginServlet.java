package controller;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import model.User;

import util.LoggerUtil;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                LoggerUtil.log(req, "Logout", "Auth", "User logged out successfully");
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userStr = req.getParameter("username");
        String passStr = req.getParameter("password");

        User user = userDAO.authenticate(userStr, passStr);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            LoggerUtil.log(req, "Login", "Auth", "User logged in successfully: " + user.getUsername());
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } else {
            req.setAttribute("error", "Invalid username or password, or account inactive.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
