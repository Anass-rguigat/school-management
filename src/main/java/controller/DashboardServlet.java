package controller;

import dao.StudentDAO;
import dao.BookDAO;
import dao.impl.StudentDAOImpl;
import dao.impl.BookDAOImpl;
import listener.ActiveSessionListener;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAOImpl();
    private BookDAO bookDAO = new BookDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("totalStudents", studentDAO.countActive());
        req.setAttribute("totalBooks", bookDAO.countActive());
        req.setAttribute("activeUsers", ActiveSessionListener.getActiveSessions());
        req.getRequestDispatcher("/views/dashboard.jsp").forward(req, resp);
    }
}
