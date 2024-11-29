package com.project.security;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
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

@WebServlet("/login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final int ITERATIONS = 10000;
    private static final int KEY_LENGTH = 256;
    private static final String DB_URL = "jdbc:mariadb://localhost:3310/project";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	String username = request.getParameter("username");
        String password = request.getParameter("password");

        String[] userInfo = getUserInfo(username);

        if (userInfo != null) {
            String storedHash = userInfo[0];
            String salt = userInfo[1];
            String hashedPassword = hashPassword(password, salt);

            if (storedHash.equals(hashedPassword)) {
                response.sendRedirect("homepage.jsp");
            } else {
            	request.setAttribute("errorMessage", "Invalid Credentials!");
                RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request, response);
            }
        } else {
        	request.setAttribute("errorMessage", "User Not Found!");
        	RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
    		rd.include(request, response);
        }
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

    private String[] getUserInfo(String username) {
        try {
           
            Class.forName("org.mariadb.jdbc.Driver");

            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT password_hash, salt FROM users WHERE username = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, username);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String passwordHash = resultSet.getString("password_hash");
                String salt = resultSet.getString("salt");
                return new String[]{passwordHash, salt};
            } else {
                return null;
            }
        } catch (SQLException | ClassNotFoundException e) {
            return null;
        }
    }
}
