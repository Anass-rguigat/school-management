package dao.impl;

import dao.BorrowDAO;
import model.Borrow;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BorrowDAOImpl implements BorrowDAO {

    @Override
    public List<Borrow> getAll() {
        List<Borrow> list = new ArrayList<>();
        String sql = "SELECT b.*, s.name as student_name, bk.title as book_title " +
                     "FROM borrow b " +
                     "JOIN students s ON b.student_id = s.id " +
                     "JOIN books bk ON b.book_id = bk.id " +
                     "ORDER BY b.borrow_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Borrow b = new Borrow();
                b.setId(rs.getInt("id"));
                b.setStudentId(rs.getInt("student_id"));
                b.setBookId(rs.getInt("book_id"));
                b.setBorrowDate(rs.getTimestamp("borrow_date"));
                b.setReturnDate(rs.getTimestamp("return_date"));
                b.setStudentName(rs.getString("student_name"));
                b.setBookTitle(rs.getString("book_title"));
                list.add(b);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public boolean borrowBook(int studentId, int bookId) {
        String sql = "INSERT INTO borrow (student_id, book_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean returnBook(int borrowId) {
        String sql = "UPDATE borrow SET return_date = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, borrowId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
}
