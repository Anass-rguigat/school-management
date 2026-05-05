package dao.impl;

import dao.LogDAO;
import model.Log;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LogDAOImpl implements LogDAO {

    @Override
    public boolean add(Log log) {
        String sql = "INSERT INTO logs (username, action, module, url, details) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, log.getUsername());
            ps.setString(2, log.getAction());
            ps.setString(3, log.getModule());
            ps.setString(4, log.getUrl());
            ps.setString(5, log.getDetails());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public List<Log> getAll() {
        List<Log> list = new ArrayList<>();
        String sql = "SELECT * FROM logs ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Log l = new Log();
                l.setId(rs.getInt("id"));
                l.setUsername(rs.getString("username"));
                l.setAction(rs.getString("action"));
                l.setModule(rs.getString("module"));
                l.setUrl(rs.getString("url"));
                l.setDetails(rs.getString("details"));
                l.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(l);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
