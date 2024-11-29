<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Network Scan Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .navbar {
            background-color: #333;
            color: white;
            padding: 15px;
            text-align: center;
        }

        .navbar ul {
            list-style-type: none;
            padding: 0;
        }

        .navbar ul li {
            display: inline;
            margin-right: 20px;
        }

        .navbar ul li a {
            color: white;
            text-decoration: none;
        }

        .navbar ul li a:hover {
            text-decoration: underline;
        }

        .container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        h1 {
            color: #333;
        }

        h3 {
            color: #444;
        }

        .summary {
            margin-bottom: 20px;
        }

        .hosts-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .hosts-table th, .hosts-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .hosts-table th {
            background-color: #f2f2f2;
        }

        .host-active {
            color: green;
        }

        .host-inactive {
            color: red;
        }

        .results-section {
            margin-top: 20px;
        }

        .host-result {
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .host-result h4 {
            margin: 0;
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
        <h1>Network Scan Report</h1>
        
        <div class="summary">
            <h3>Scanned Network:</h3>
            <p class="network">${targetNetwork}</p>
        </div>

        <div class="results-section">
            <h3>Active Hosts</h3>
            <table class="hosts-table">
                <thead>
                    <tr>
                        <th>IP Address</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="host" items="${activeHosts}">
                        <tr>
                            <td class="host-active">${host}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="results-section">
            <h3>Inactive Hosts</h3>
            <table class="hosts-table">
                <thead>
                    <tr>
                        <th>IP Address</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="host" items="${inactiveHosts}">
                        <tr>
                            <td class="host-inactive">${host}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="results-section">
            <h3>Port Scan Results</h3>
            <c:forEach var="host" items="${hostList}">
                <div class="host-result">
                    <h4>${host.ip}</h4>
                    <p><strong>Open Ports:</strong> <c:forEach var="port" items="${host.openPorts}">${port} </c:forEach></p>
                    <p><strong>Closed Ports:</strong> Remaining ports are closed.</p>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
