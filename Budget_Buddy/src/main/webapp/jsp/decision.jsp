<%--Adewole: confirmation page after user makes skip/buy decision--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.cs.budgetbuddy.model.User" %>
<%@ page import="java.math.BigDecimal" %>
<%
    // grab the decision data
    User user = (User) request.getAttribute("user");
    String decision = (String) request.getAttribute("decision");
    String message = (String) request.getAttribute("message");
    boolean isSkip = "skip".equals(decision);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budget Buddy - Decision Recorded</title>
    <style>
        /* basic resets */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        /* light background */
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: #f5f7fa;
            min-height: 100vh;
        }
        
        /* top navbar */
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar h1 { color: white; font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; }
        
        /* center container */
        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
        }
        
        /* main card */
        .card {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        /* big emoji at top */
        .emoji {
            font-size: 64px;
            margin-bottom: 20px;
        }
        
        /* title */
        h2 {
            color: #333;
            margin-bottom: 15px;
        }
        
        /* confirmation message */
        .message {
            color: #666;
            margin-bottom: 30px;
            font-size: 18px;
        }
        
        /* stats box */
        .stats {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
        }
        
        /* individual stat row */
        .stat-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e1e1e1;
        }
        .stat-row:last-child {
            border-bottom: none;
        }
        
        /* stat text */
        .stat-label {
            color: #666;
        }
        .stat-value {
            font-weight: 600;
            color: #333;
        }
        
        /* button container */
        .buttons {
            display: flex;
            gap: 15px;
        }
        
        /* base button style */
        .btn {
            flex: 1;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }
        
        /* purple button */
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        /* gray button */
        .btn-secondary {
            background: #e9ecef;
            color: #333;
        }
        
        /* green background if user skipped */
        .success-bg { background: #d4edda; }
        
        /* gray background if user bought */
        .neutral-bg { background: #f8f9fa; }
    </style>
</head>
<body>
    <%-- top navbar --%>
    <nav class="navbar">
        <h1>💰 Budget Buddy</h1>
        <div>
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">Logout</a>
        </div>
    </nav>
    
    <%-- main content --%>
    <div class="container">
        <%-- card changes color based on decision --%>
        <div class="card <%= isSkip ? "success-bg" : "neutral-bg" %>">
            <%-- party emoji if skip, pencil if buy --%>
            <div class="emoji"><%= isSkip ? "🎉" : "📝" %></div>
            
            <%-- different title based on choice --%>
            <h2><%= isSkip ? "Great Decision!" : "Purchase Recorded" %></h2>
            
            <%-- the message from servlet --%>
            <p class="message"><%= message %></p>
            
            <%-- updated stats --%>
            <div class="stats">
                <div class="stat-row">
                    <span class="stat-label">Current Streak</span>
                    <span class="stat-value"><%= user.getCurrentStreak() %> days 🔥</span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">Total Saved</span>
                    <span class="stat-value">$<%= user.getTotalSaved() %></span>
                </div>
                <div class="stat-row">
                    <span class="stat-label">Skip Rate</span>
                    <span class="stat-value">${skipRate}%</span>
                </div>
            </div>
            
            <%-- action buttons --%>
            <div class="buttons">
                <a href="${pageContext.request.contextPath}/calculator" class="btn btn-primary">
                    New Calculation
                </a>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">
                    Dashboard
                </a>
            </div>
        </div>
    </div>
</body>
</html>
