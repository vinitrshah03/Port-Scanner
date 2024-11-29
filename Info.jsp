<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Port Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5; /* Match background color */
            color: #333; /* Match text color */
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

        h1 {
            color: #333;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #4CAF50; /* Green background */
            color: white; /* White text color */
        }

        tr:nth-child(even) {
            background-color: #f2f2f2; /* Zebra striping */
        }

        tr:hover {
            background-color: #ddd; /* Highlight on hover */
        }

        p {
            text-align: center;
            color: #555;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <ul>
            <li><a href="homepage.jsp">Home</a></li>
            <li><a href="feedback.jsp">Feedback</a></li>
            <li><a href="login.jsp">Log Out</a></li>
        </ul>
    </nav>
    
    <div class="container">
    	<h1>Active Hosts</h1>
    	<p>Active hosts refer to devices or systems on a network that are currently online and capable of responding to network requests. These hosts have established network connections and can communicate with other devices, such as computers, servers, routers, and IoT devices. Active hosts are typically identified through various network scanning techniques that check for open ports and services, enabling network administrators to monitor activity, assess performance, and manage resources effectively. Understanding which hosts are active is crucial for network management, security assessments, and troubleshooting.</p>
		<br><br>
		<h1>Inactive Hosts</h1>
<p>Inactive hosts are devices on a network that are currently not operational or unable to respond to network requests. This could be due to various reasons, such as being powered off, disconnected from the network, or configured to not respond to certain types of network traffic (e.g., firewalls blocking requests). Identifying inactive hosts is important for network inventory management, as it helps administrators recognize devices that may need maintenance, replacement, or removal from the network. Furthermore, it can aid in security assessments, as inactive hosts might represent potential vulnerabilities if not properly managed.
</p>	
		<br><br>
        <h1>Port Information (1-1024)</h1>

        <sql:setDataSource var="myDataSource" driver="org.mariadb.jdbc.Driver" 
                           url="jdbc:mariadb://localhost:3310/project" 
                           user="root" password="admin"/>
        
        <sql:query var="portQuery" dataSource="${myDataSource}">
            SELECT Portno, Service 
            FROM ports 
            WHERE Portno BETWEEN 1 AND 1024
            ORDER BY Portno;
        </sql:query>
        
        <c:if test="${not empty portQuery.rows}">
            <table>
                <thead>
                    <tr>
                        <th>Port Number</th>
                        <th>Service Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="port" items="${portQuery.rows}">
                        <tr>
                            <td>${port.portno}</td>
                            <td>${port.service}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty portQuery.rows}">
            <p>No port information found for the specified range.</p>
        </c:if>
    </div>
</body>
</html>
