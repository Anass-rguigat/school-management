package controller;

import dao.BookDAO;
import dao.impl.BookDAOImpl;
import model.Book;
import util.LoggerUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private BookDAO bookDAO = new BookDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "new":
                req.getRequestDispatcher("/views/books/add.jsp").forward(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("book", bookDAO.getById(id));
                req.getRequestDispatcher("/views/books/edit.jsp").forward(req, resp);
                break;
            case "delete":
                int deleteId = Integer.parseInt(req.getParameter("id"));
                bookDAO.softDelete(deleteId);
                LoggerUtil.log(req, "Delete", "Books", "Book ID " + deleteId + " moved to archive");
                resp.sendRedirect(req.getContextPath() + "/books");
                break;
            default:
                req.setAttribute("books", bookDAO.getAllActive());
                req.getRequestDispatcher("/views/books/list.jsp").forward(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String title = req.getParameter("title");
        String author = req.getParameter("author");

        if ("add".equals(action)) {
            bookDAO.add(new Book(0, title, author, true, false));
            LoggerUtil.log(req, "Create", "Books", "New book added: " + title + " by " + author);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            bookDAO.update(new Book(id, title, author, true, false));
            LoggerUtil.log(req, "Update", "Books", "Book ID " + id + " updated: " + title);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            bookDAO.softDelete(id);
            LoggerUtil.log(req, "Delete", "Books", "Book ID " + id + " moved to archive (POST)");
        }
        resp.sendRedirect(req.getContextPath() + "/books");
    }
}
