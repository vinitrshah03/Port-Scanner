<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback</title>
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

input[type="text"], input[type="email"], textarea {
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 100%;
}

textarea {
    resize: vertical;
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
</style>
    
</head>
<body>
    <nav class="navbar">
        <ul>
            <li><a href="homepage.jsp">Home</a></li>
            <li><a href="Info.jsp">Learn</a></li>
            <li><a href="login.jsp">Log Out</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Submit Your Feedback</h2>
        <form action="feedback" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            
            <label for="message">Feedback:</label>
            <textarea id="message" name="message" rows="4" required></textarea>
            
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>