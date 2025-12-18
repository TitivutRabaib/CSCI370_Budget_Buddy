<%--Adewole--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.cs.budgetbuddy.model.User" %>
<%@ page import="edu.cs.budgetbuddy.model.User.KnowledgeLevel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - Budget Buddy</title>
    <style>
        /* basic resets */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        /* light gray background for the whole page */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            min-height: 100vh;
        }
        
        /* purple gradient navbar at the top */
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .navbar h1 {
            color: white;
            font-size: 1.5em;
        }
        
        /* nav links that light up on hover */
        .navbar-links a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 8px;
            margin-left: 10px;
        }
        
        .navbar-links a:hover {
            background: rgba(255,255,255,0.2);
        }
        
        /* center container for the profile card */
        .container {
            max-width: 600px;
            margin: 40px auto;
            padding: 0 20px;
        }
        
        /* main white card holding the profile */
        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            padding: 40px;
        }
        
        /* profile header with avatar and name */
        .profile-header {
            text-align: center;
            margin-bottom: 35px;
        }
        
        /* circular purple avatar with first letter */
        .profile-header .avatar {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5em;
            color: white;
            margin: 0 auto 15px;
        }
        
        .profile-header h2 {
            color: #333;
            margin-bottom: 5px;
        }
        
        .profile-header p {
            color: #888;
        }
        
        /* gray box with three stats in a row */
        .stats-row {
            display: flex;
            justify-content: space-around;
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .stat {
            text-align: center;
        }
        
        /* purple stat value */
        .stat .value {
            font-size: 1.5em;
            font-weight: 700;
            color: #667eea;
        }
        
        .stat .label {
            font-size: 0.8em;
            color: #888;
            margin-top: 5px;
        }
        
        /* section dividers with purple text */
        .section-title {
            font-size: 1em;
            color: #667eea;
            margin: 25px 0 15px 0;
            padding-bottom: 8px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        /* wrapper for each form input */
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        
        /* all inputs, selects, and textareas get the same styling */
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e1e1;
            border-radius: 10px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        
        /* purple border on focus */
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .form-group textarea {
            resize: vertical;
            min-height: 80px;
        }
        
        /* small helper text under inputs */
        .form-group small {
            display: block;
            margin-top: 5px;
            color: #888;
            font-size: 0.85em;
        }
        
        /* two inputs side by side */
        .form-row {
            display: flex;
            gap: 15px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        /* purple gradient save button */
        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s;
            margin-top: 20px;
        }
        
        /* little bounce on hover */
        .btn:hover {
            transform: translateY(-2px);
        }
        
        /* red error message box */
        .error-message {
            background: #ffe6e6;
            color: #d63031;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        /* green success message box */
        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        /* blue info box explaining knowledge level */
        .knowledge-info {
            background: #e8f4fd;
            border-radius: 10px;
            padding: 15px;
            margin-top: 10px;
            font-size: 0.9em;
            color: #0c5460;
        }
    </style>
</head>
<body>
    <%-- grab user data from servlet --%>
    <%
        User user = (User) request.getAttribute("user");
    %>

    <%-- top navigation bar --%>
    <nav class="navbar">
        <h1>💰 Budget Buddy</h1>
        <div class="navbar-links">
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/transaction">Transactions</a>
            <a href="${pageContext.request.contextPath}/goal">Goal</a>
            <a href="${pageContext.request.contextPath}/calculator">Calculator</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <div class="profile-card">
            <%-- profile header with circular avatar --%>
            <div class="profile-header">
                <div class="avatar">
                    <%= user.getUsername().substring(0, 1).toUpperCase() %>
                </div>
                <h2><%= user.getUsername() %></h2>
                <p><%= user.getEmail() %></p>
            </div>
            
            <%-- three stats in a gray box --%>
            <div class="stats-row">
                <div class="stat">
                    <div class="value"><%= user.getCurrentStreak() %></div>
                    <div class="label">Transaction Streak</div>
                </div>
                <div class="stat">
                    <div class="value">$<%= String.format("%.0f", user.getTotalSaved()) %></div>
                    <div class="label">Total Saved</div>
                </div>
                <div class="stat">
                    <div class="value"><%= String.format("%.0f", user.getSkipRate()) %>%</div>
                    <div class="label">Skip Rate</div>
                </div>
            </div>
            
            <%-- show error message if something went wrong --%>
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <%-- show success message after saving --%>
            <% if (request.getAttribute("success") != null) { %>
                <div class="success-message">
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>
            
            <%-- profile edit form --%>
            <form action="${pageContext.request.contextPath}/auth" method="post">
                <input type="hidden" name="action" value="profile">
                
                <div class="section-title">Financial Settings</div>
                
                <%-- hourly wage and monthly budget side by side --%>
                <div class="form-row">
                    <div class="form-group">
                        <label for="hourlyWage">Hourly Wage ($)</label>
                        <input type="number" id="hourlyWage" name="hourlyWage" 
                               value="<%= user.getHourlyWage() %>"
                               step="0.01" min="1">
                        <small>Used to calculate work hours</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="monthlyBudget">Monthly Budget ($)</label>
                        <input type="number" id="monthlyBudget" name="monthlyBudget" 
                               value="<%= user.getMonthlyBudget() %>"
                               step="0.01" min="1">
                        <small>Your spending limit</small>
                    </div>
                </div>
                
                <%-- dropdown for knowledge level (beginner, intermediate, advanced) --%>
                <div class="form-group">
                    <label for="knowledgeLevel">Financial Knowledge Level</label>
                    <select id="knowledgeLevel" name="knowledgeLevel">
                        <option value="beginner" <%= user.getKnowledgeLevel() == KnowledgeLevel.BEGINNER ? "selected" : "" %>>
                            Beginner - Simple tips
                        </option>
                        <option value="intermediate" <%= user.getKnowledgeLevel() == KnowledgeLevel.INTERMEDIATE ? "selected" : "" %>>
                            Intermediate - More detail
                        </option>
                        <option value="advanced" <%= user.getKnowledgeLevel() == KnowledgeLevel.ADVANCED ? "selected" : "" %>>
                            Advanced - Full analysis
                        </option>
                    </select>
                    <%-- blue info box explaining what this does --%>
                    <div class="knowledge-info">
                        This affects how detailed your nudge messages are. Beginners see simple work hour calculations, 
                        while advanced users see budget percentages, projections, and more.
                    </div>
                </div>
                
                <div class="section-title">Commitment Contract</div>
                
                <%-- commitment message textarea --%>
                <div class="form-group">
                    <label for="commitmentMessage">Your Commitment</label>
                    <textarea id="commitmentMessage" name="commitmentMessage" 
                              placeholder="e.g., I will think twice before every impulse purchase."><%= user.getCommitmentMessage() != null ? user.getCommitmentMessage() : "" %></textarea>
                    <small>Write a promise to yourself about spending habits</small>
                </div>
                
                <%-- future self message textarea --%>
                <div class="form-group">
                    <label for="futureSelfMessage">Message to Future Self</label>
                    <textarea id="futureSelfMessage" name="futureSelfMessage" 
                              placeholder="e.g., Future me deserves financial freedom more than present me needs instant gratification."><%= user.getFutureSelfMessage() != null ? user.getFutureSelfMessage() : "" %></textarea>
                    <small>This appears when you're tempted to spend</small>
                </div>
                
                <%-- purple gradient save button --%>
                <button type="submit" class="btn">Save Changes</button>
            </form>
        </div>
    </div>
</body>
</html>
