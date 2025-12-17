<%--Adewole--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.cs.budgetbuddy.model.User" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Decision Made - Budget Buddy</title>
    <style>
        /* basic resets */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        /* center everything */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        /* green gradient background when user skips */
        body.skip-bg {
            background: linear-gradient(135deg, #00b894 0%, #00cec9 100%);
        }
        
        /* dark gray gradient background when user buys */
        body.buy-bg {
            background: linear-gradient(135deg, #636e72 0%, #2d3436 100%);
        }
        
        /* main white card in the middle */
        .decision-container {
            background: white;
            border-radius: 25px;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.3);
            padding: 50px;
            width: 100%;
            max-width: 500px;
            text-align: center;
        }
        
        /* big emoji at the top */
        .icon {
            font-size: 5em;
            margin-bottom: 20px;
        }
        
        /* bounce animation for skip emoji */
        .icon.skip { animation: bounce 0.5s ease; }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }
        
        h1 {
            font-size: 2em;
            margin-bottom: 15px;
        }
        
        /* green title for skip */
        h1.skip { color: #00b894; }
        /* gray title for buy */
        h1.buy { color: #636e72; }
        
        /* message text */
        .message {
            font-size: 1.2em;
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        /* gray box showing updated stats */
        .stats-box {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .stats-box h3 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.1em;
        }
        
        /* three stats in a row */
        .stats-row {
            display: flex;
            justify-content: space-around;
            gap: 20px;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-item .value {
            font-size: 2em;
            font-weight: 700;
            color: #667eea;
        }
        
        .stat-item .label {
            font-size: 0.85em;
            color: #888;
            margin-top: 5px;
        }
        
        /* green for total saved */
        .stat-item.success .value { color: #00b894; }
        /* orange for streak */
        .stat-item.streak .value { color: #e17055; }
        
        /* purple encouragement box (only for skip) */
        .encouragement {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-size: 1.1em;
        }
        
        /* two buttons at the bottom */
        .action-buttons {
            display: flex;
            gap: 15px;
        }
        
        .action-btn {
            flex: 1;
            padding: 15px 25px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.2s;
            display: inline-block;
        }
        
        /* little bounce on hover */
        .action-btn:hover {
            transform: translateY(-2px);
        }
        
        /* purple gradient button */
        .action-btn.primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        /* gray outline button */
        .action-btn.secondary {
            background: #f8f9fa;
            color: #333;
            border: 2px solid #e1e1e1;
        }
        
        /* yellow streak reset message (only for buy) */
        .reset-message {
            background: #fff3cd;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 25px;
            color: #856404;
        }
        
        /* blue tip box at the bottom */
        .tip {
            margin-top: 25px;
            padding: 15px;
            background: #e8f4fd;
            border-radius: 10px;
            font-size: 0.9em;
            color: #0c5460;
        }
    </style>
</head>
<body class="<%= "skip".equals(request.getAttribute("decision")) ? "skip-bg" : "buy-bg" %>">
    <%-- grab decision result data from servlet --%>
    <%
        User user = (User) request.getAttribute("user");
        String decision = (String) request.getAttribute("decision");
        String message = (String) request.getAttribute("message");
        double skipRate = (Double) request.getAttribute("skipRate");
        BigDecimal totalSaved = (BigDecimal) request.getAttribute("totalSaved");
        boolean isSkip = "skip".equals(decision);
    %>

    <%-- main decision result card --%>
    <div class="decision-container">
        <%-- different icon and title based on skip vs buy --%>
        <% if (isSkip) { %>
            <div class="icon skip">🎉</div>
            <h1 class="skip">Great Choice!</h1>
        <% } else { %>
            <div class="icon">📝</div>
            <h1 class="buy">Purchase Recorded</h1>
        <% } %>
        
        <%-- personalized message from servlet --%>
        <p class="message"><%= message %></p>
        
        <%-- purple encouragement box (only shows when user skips) --%>
        <% if (isSkip) { %>
            <div class="encouragement">
                🔥 Your streak is now <strong><%= user.getCurrentStreak() %> days</strong>!
                Keep up the great work!
            </div>
        <% } else { %>
            <%-- yellow reset message (only shows when user buys) --%>
            <div class="reset-message">
                Your streak has been reset. Don't worry - you can start building it again with your next decision!
            </div>
        <% } %>
        
        <%-- gray box showing updated stats --%>
        <div class="stats-box">
            <h3>Your Progress</h3>
            <div class="stats-row">
                <div class="stat-item streak">
                    <div class="value"><%= user.getCurrentStreak() %></div>
                    <div class="label">Day Streak</div>
                </div>
                <div class="stat-item success">
                    <div class="value">$<%= String.format("%.0f", totalSaved) %></div>
                    <div class="label">Total Saved</div>
                </div>
                <div class="stat-item">
                    <div class="value"><%= String.format("%.0f", skipRate) %>%</div>
                    <div class="label">Skip Rate</div>
                </div>
            </div>
        </div>
        
        <%-- two action buttons --%>
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/calculator" class="action-btn primary">
                🧮 New Calculation
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="action-btn secondary">
                📊 Dashboard
            </a>
        </div>
        
        <%-- different tip based on skip vs buy --%>
        <% if (isSkip) { %>
            <div class="tip">
                <strong>💡 Tip:</strong> The money you saved has been added to your goal progress. 
                Check your dashboard to see how close you are!
            </div>
        <% } else { %>
            <div class="tip">
                <strong>💡 Tip:</strong> It's okay to spend sometimes. The key is being mindful. 
                Each decision you make through the calculator helps build awareness.
            </div>
        <% } %>
    </div>
</body>
</html>
