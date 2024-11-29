package com.project.security;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final int ITERATIONS = 10000;
    private static final int KEY_LENGTH = 256;
    
    private static final String DB_URL = "jdbc:mariadb://localhost:3310/project";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin"; // Change based on your configuration

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        if (username == null || username.isEmpty()) {
            out.println("Username cannot be empty!");
        } else if (email == null || email.isEmpty()) {
            out.println("Email cannot be empty!");
        } else if (password == null || password.isEmpty()) {
            out.println("Password cannot be empty!");
        } else if (isEmailRegistered(email)) {
            out.println("Email is already registered! Try logging in.");
        } else {

            String salt = generateSalt();
            String hashedPassword = hashPassword(password, salt);
            String result = storeUser(username, email, hashedPassword, salt);
            
            if (result.equals("true")) {
                out.println("User registered successfully!");
                RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
                rd.include(request, response);
            } else {
                out.println("Error: " + result);
                RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
                rd.include(request, response);
            }
        }
    }

    private String generateSalt() {
        SecureRandom sr = new SecureRandom();
        byte[] salt = new byte[16];
        sr.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    private String hashPassword(String password, String salt) {
        try {
            PBEKeySpec spec = new PBEKeySpec(password.toCharArray(), Base64.getDecoder().decode(salt), ITERATIONS, KEY_LENGTH);
            SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            byte[] hash = skf.generateSecret(spec).getEncoded();
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new RuntimeException(e);
        }
    }

    private boolean isEmailRegistered(String email) {
        try {
         
            Class.forName("org.mariadb.jdbc.Driver");

            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT email FROM users WHERE email = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, email);

            ResultSet rs = statement.executeQuery();
            return rs.next();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String storeUser(String username, String email, String passwordHash, String salt) {
        try {
        	
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO users (username, email, password_hash, salt) VALUES (?, ?, ?, ?)";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, email);
            statement.setString(3, passwordHash);
            statement.setString(4, salt);
            statement.executeUpdate();
            
            return "true";
        } catch (SQLException e) {
            return e.getMessage();
        } catch (ClassNotFoundException e) {
            return "MariaDB JDBC Driver not found.";
        }
    }
}
