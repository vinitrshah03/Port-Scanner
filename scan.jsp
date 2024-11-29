<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced Network Scanner</title>
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
    max-width: 600px;
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

input[type="text"], input[type="number"] {
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
    
</head>
<body>
    <nav class="navbar">
        <ul>
            <li><a href="homepage.jsp">Home</a></li>
            <li><a href="Ports.jsp">Ports</a></li>
            <li><a href="feedback.jsp">Feedback</a></li>
            <li><a href="login.jsp">Login</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Network Scanner</h2>
        <form action="networkscan" method="post">
            <h2>Network Scanner</h2>
		    <div class="form-group">
		        <label for="network">Target IP:</label>
		        <input type="text" id="network" name="network" placeholder="e.g., 192.168.1.0/24 or 192.168.1.*" required>
		    </div>
		
		    <div class="form-group">
		        <label for="startPort">Start Port:</label>
		        <input type="number" id="startPort" name="startPort" min="1" max="65535" required>
		    </div>
		
		    <div class="form-group">
		        <label for="endPort">End Port:</label>
		        <input type="number" id="endPort" name="endPort" min="1" max="65535" required>
		    </div>
		
		    <div class="form-group">
		        <input type="submit" value="Scan Network">
		    </div>
        </form>
    </div>
</body>
</html>