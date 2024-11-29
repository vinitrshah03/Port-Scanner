package com.project.security;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/feedback")
public class Feedback extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mariadb://localhost:3310/project";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        if (storeFeedback(name, email, message).equals("True")) {
        	response.sendRedirect("feedback_success.jsp");
        } else {
        	response.sendRedirect("feedback_error.jsp");
        }
    }

    private String storeFeedback(String name, String email, String message) {
        Connection conn = null;
        try {
            // Load the MariaDB JDBC driver
            Class.forName("org.mariadb.jdbc.Driver");

            // Get a connection to the database
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL query to insert feedback
            String sql = "INSERT INTO feedback (name, email, message) VALUES (?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, message);
            statement.executeUpdate();

            return "True";
        } catch (SQLException | ClassNotFoundException e) {
            return "False";
        } finally {
            // Close the connection
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}