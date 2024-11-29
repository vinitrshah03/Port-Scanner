<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    max-width: 500px;
    margin: 30px auto;
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

form {
    display: flex;
    flex-direction: column;
}

label {
    margin-bottom: 5px;
    font-weight: bold;
}

input[type="text"], input[type="email"], input[type="password"] {
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
</style>
 	
    <title>Register</title>
</head>
<body>
	<nav class="navbar">
        <ul>
            <li><a href="homepage.jsp">Home</a></li>
            <li><a href="Info.jsp">Learn</a></li>
            <li><a href="feedback.jsp">Feedback</a></li>
            <li><a href="login.jsp">Login</a></li>
        </ul>
    </nav>
    
    <div class="container">
	    <h2>Sign Up</h2>
	    <form action="register" method="post">
	        <label for="username">Username:</label>
	        <input type="text" id="username" name="username" required>
			<br>
	        <label for="email">Email:</label>
	        <input type="email" id="email" name="email" required>
			<br>
	        <label for="password">Password:</label>
	        <input type="password" id="password" name="password" required>
			<br><br>
	        <input type="submit" value="Register">
	    </form>
	    <p><a href="login.jsp">Already have an account? Sign in here</a></p>
	</div>
</body>
</html>