package controller;

import dao.BookDAO;
import dao.DocumentDAO;
import dao.StudentDAO;
import dao.impl.BookDAOImpl;
import dao.impl.DocumentDAOImpl;
import dao.impl.StudentDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/archive")
public class ArchiveServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAOImpl();
    private BookDAO bookDAO = new BookDAOImpl();
    private DocumentDAO documentDAO = new DocumentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String module = req.getParameter("module");
        String action = req.getParameter("action");

        if ("restore".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            if ("student".equals(module)) studentDAO.restore(id);
            if ("book".equals(module)) bookDAO.restore(id);
            if ("document".equals(module)) documentDAO.restore(id);
            
            resp.sendRedirect(req.getContextPath() + "/archive?module=" + module);
            return;
        }

        if (module == null) module = "student";

        switch (module) {
            case "book":
                req.setAttribute("books", bookDAO.getAllArchived());
                req.getRequestDispatcher("/views/books/archive.jsp").forward(req, resp);
                break;
            case "document":
                req.setAttribute("documents", documentDAO.getAllArchived());
                req.getRequestDispatcher("/views/documents/archive.jsp").forward(req, resp);
                break;
            default:
                req.setAttribute("students", studentDAO.getAllArchived());
                req.getRequestDispatcher("/views/students/archive.jsp").forward(req, resp);
                break;
        }
    }
}
