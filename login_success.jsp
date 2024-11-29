<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            color: #333;
        }

        .navbar {
            background-color: #333;
            padding: 1em;
            text-align: center;
        }

        .navbar ul {
            list-style-type: none;
            padding: 0;
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

        .container {
            max-width: 800px;
            margin: 30px auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <ul>
            <li><a href="homepage.jsp">Home</a></li>
            <li><a href="Info.jsp">Learn</a></li>
            <li><a href="feedback.jsp">Feedback</a></li>
            <li><a href="login.jsp">Log Out</a></li>
        </ul>
    </nav>
    
    <div class="container">
        <h2>Login Successful!</h2>
        <p>Welcome, user!</p>
    </div>
</body>
</html>
