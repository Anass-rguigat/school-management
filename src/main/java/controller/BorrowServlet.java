package controller;

import dao.BookDAO;
import dao.BorrowDAO;
import dao.StudentDAO;
import dao.impl.BookDAOImpl;
import dao.impl.BorrowDAOImpl;
import dao.impl.StudentDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/borrow")
public class BorrowServlet extends HttpServlet {
    private BorrowDAO borrowDAO = new BorrowDAOImpl();
    private BookDAO bookDAO = new BookDAOImpl();
    private StudentDAO studentDAO = new StudentDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("new".equals(action)) {
            req.setAttribute("students", studentDAO.getAllActive());
            req.setAttribute("books", bookDAO.getAllActive());
            req.getRequestDispatcher("/views/borrow/add.jsp").forward(req, resp);
        } else if ("return".equals(action)) {
            int borrowId = Integer.parseInt(req.getParameter("id"));
            int bookId = Integer.parseInt(req.getParameter("bookId"));
            borrowDAO.returnBook(borrowId);
            bookDAO.updateAvailability(bookId, true);
            resp.sendRedirect("borrow");
        } else {
            req.setAttribute("borrows", borrowDAO.getAll());
            req.getRequestDispatcher("/views/borrow/list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int studentId = Integer.parseInt(req.getParameter("studentId"));
        int bookId = Integer.parseInt(req.getParameter("bookId"));

        if (borrowDAO.borrowBook(studentId, bookId)) {
            bookDAO.updateAvailability(bookId, false);
        }
        resp.sendRedirect("borrow");
    }
}
