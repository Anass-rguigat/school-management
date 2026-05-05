package controller;

import dao.StudentDAO;
import dao.impl.StudentDAOImpl;
import model.Student;
import util.LoggerUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                req.getRequestDispatcher("/views/students/add.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("student", studentDAO.getById(id));
                req.getRequestDispatcher("/views/students/edit.jsp").forward(req, resp);
                break;
            case "delete":
                int deleteId = Integer.parseInt(req.getParameter("id"));
                studentDAO.softDelete(deleteId);
                LoggerUtil.log(req, "Delete", "Students", "Student ID " + deleteId + " moved to archive");
                resp.sendRedirect(req.getContextPath() + "/students");
                break;
            case "search":
                String query = req.getParameter("query");
                req.setAttribute("students", studentDAO.search(query));
                req.getRequestDispatcher("/views/students/list.jsp").forward(req, resp);
                break;
            default:
                req.setAttribute("students", studentDAO.getAllActive());
                req.getRequestDispatcher("/views/students/list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action != null) {
            action = action.trim();
        }
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String field = req.getParameter("field");

        if ("add".equals(action)) {
            studentDAO.add(new Student(0, name, email, field, false));
            LoggerUtil.log(req, "Create", "Students", "New student added: " + name + " (" + email + ")");
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            studentDAO.update(new Student(id, name, email, field, false));
            LoggerUtil.log(req, "Update", "Students", "Student ID " + id + " updated: " + name);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            studentDAO.softDelete(id);
            LoggerUtil.log(req, "Delete", "Students", "Student ID " + id + " moved to archive (POST)");
        }
        resp.sendRedirect(req.getContextPath() + "/students");
    }
}
