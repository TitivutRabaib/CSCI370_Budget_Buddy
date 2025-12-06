package edu.cs.budgetbuddy.dao;

import edu.cs.budgetbuddy.model.User;
import edu.cs.budgetbuddy.util.DatabaseUtil;

import java.sql.*;

public class UserDAO {


    // Create a new user
    public static User create(User user) {
        String sql = "INSERT INTO users (username, email, password_hash, hourly_wage, monthly_budget, knowledge_level) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseUtil.getConnection();
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPasswordHash());
            stmt.setBigDecimal(4, user.getHourlyWage());
            stmt.setBigDecimal(5, user.getMonthlyBudget());
            stmt.setString(6, user.getKnowledgeLevel());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    user.setUserId(rs.getInt(1));
                    return user;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DatabaseUtil.close(conn, stmt, rs);
        }
        return null;
    }
}
