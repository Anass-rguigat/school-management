package controller;

import dao.LogDAO;
import dao.impl.LogDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/logs")
public class LogServlet extends HttpServlet {
    private LogDAO logDAO = new LogDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("logs", logDAO.getAll());
        req.getRequestDispatcher("/views/logs/list.jsp").forward(req, resp);
    }
}
