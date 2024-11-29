<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
/* Basic styling */
body {
    font-family: Arial, sans-serif;
    background-color: #f0f2f5;
    color: #333;
}

/* Navigation bar */
.navbar {
    background-color: #333;
    padding: 1em;
    text-align: center;
}

.navbar ul {
    list-style-type: none;
}

.navbar ul li {
    display: inline;
    margin: 0 15px;
}

.navbar ul li a {
    color: #fff;
    text-decoration: none;
    padding: 8px 15px;
    transition: background 0.3s;
}

.navbar ul li a:hover {
    background-color: #575757;
    border-radius: 5px;
}

/* Container styling */
.container {
    max-width: 500px;
    margin: 30px auto;
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

/* Form styling */
form {
    display: flex;
    flex-direction: column;
}

label {
    margin-bottom: 5px;
    font-weight: bold;
}

input[type="text"], input[type="password"] {
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 100%;
}

input[type="submit"] {
    background-color: #333;
    color: #fff;
    border: none;
    padding: 10px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1.1em;
}

input[type="submit"]:hover {
    background-color: #575757;
}

/* Error message */
.error-message {
    color: #ff0000;
    margin-bottom: 15px;
}
</style>
    
</head>
<body>
    <nav class="navbar">
        <ul>
            <li><a href="homepage.jsp">Home</a></li>
            <li><a href="Info.jsp">Learn</a></li>
            <li><a href="feedback.jsp">Feedback</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="register.jsp">Sign Up</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Sign In</h2>
        <c:if test="${not empty errorMessage}">
            <p class="error-message">${errorMessage}</p>
        </c:if>
        <form action="login" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
    
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
    
            <input type="submit" value="Login">
        </form>
        <p><a href="register.jsp">Don't have an account? Sign up here</a></p>
    </div>
</body>
</html>