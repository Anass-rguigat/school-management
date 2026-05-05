package dao.impl;

import dao.DocumentDAO;
import model.Document;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DocumentDAOImpl implements DocumentDAO {

    @Override
    public List<Document> getAllActive() {
        return getList("SELECT d.*, s.name as student_name FROM documents d LEFT JOIN students s ON d.student_id = s.id WHERE d.deleted = 0");
    }

    @Override
    public List<Document> getAllArchived() {
        return getList("SELECT d.*, s.name as student_name FROM documents d LEFT JOIN students s ON d.student_id = s.id WHERE d.deleted = 1");
    }

    private List<Document> getList(String sql) {
        List<Document> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Document(rs.getInt("id"), rs.getString("title"), 
                        rs.getString("file_path"), rs.getInt("student_id"), 
                        rs.getString("student_name"), rs.getBoolean("deleted")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<Document> getByStudentId(int studentId) {
        List<Document> list = new ArrayList<>();
        String sql = "SELECT * FROM documents WHERE student_id = ? AND deleted = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Document(rs.getInt("id"), rs.getString("title"), 
                        rs.getString("file_path"), rs.getInt("student_id"), rs.getBoolean("deleted")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public boolean add(Document doc) {
        String sql = "INSERT INTO documents (title, file_path, student_id) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doc.getTitle());
            ps.setString(2, doc.getFilePath());
            ps.setInt(3, doc.getStudentId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean update(Document doc) {
        String sql = "UPDATE documents SET title = ?, file_path = ?, student_id = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doc.getTitle());
            ps.setString(2, doc.getFilePath());
            ps.setInt(3, doc.getStudentId());
            ps.setInt(4, doc.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean softDelete(int id) {
        String sql = "UPDATE documents SET deleted = 1 WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean restore(int id) {
        String sql = "UPDATE documents SET deleted = 0 WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public Document getById(int id) {
        String sql = "SELECT * FROM documents WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Document(rs.getInt("id"), rs.getString("title"), 
                        rs.getString("file_path"), rs.getInt("student_id"), rs.getBoolean("deleted"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public List<Document> search(String query) {
        List<Document> list = new ArrayList<>();
        String sql = "SELECT d.*, s.name as student_name FROM documents d " +
                     "LEFT JOIN students s ON d.student_id = s.id " +
                     "WHERE (d.title LIKE ? OR s.name LIKE ?) AND d.deleted = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String q = "%" + query + "%";
            ps.setString(1, q);
            ps.setString(2, q);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Document(rs.getInt("id"), rs.getString("title"), 
                        rs.getString("file_path"), rs.getInt("student_id"), 
                        rs.getString("student_name"), rs.getBoolean("deleted")));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
