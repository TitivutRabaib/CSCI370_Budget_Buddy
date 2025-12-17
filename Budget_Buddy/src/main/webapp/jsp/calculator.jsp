<%--Adewole--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.cs.budgetbuddy.model.User" %>
<%@ page import="edu.cs.budgetbuddy.model.Transaction.Category" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Friction Calculator - Budget Buddy</title>
    <style>
        /* basic resets */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        /* purple gradient background + center everything */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        /* main white card in the middle */
        .calculator-container {
            background: white;
            border-radius: 25px;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.3);
            padding: 50px;
            width: 100%;
            max-width: 500px;
        }
        
        /* header with calculator emoji and title */
        .header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .header .icon {
            font-size: 4em;
            margin-bottom: 15px;
        }
        
        .header h1 {
            color: #333;
            font-size: 1.8em;
            margin-bottom: 10px;
        }
        
        .header p {
            color: #666;
            font-size: 1em;
        }
        
        /* gray box showing hourly wage and streak */
        .user-info {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            font-size: 0.9em;
        }
        
        .user-info span {
            color: #666;
        }
        
        .user-info strong {
            color: #333;
        }
        
        /* wrapper for each form input */
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #333;
            font-weight: 600;
            font-size: 1.1em;
        }
        
        /* all inputs, selects, and textareas get the same styling */
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e1e1e1;
            border-radius: 12px;
            font-size: 1.1em;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        
        /* purple border and glow on focus */
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        
        /* big centered amount input */
        .amount-input {
            font-size: 2em !important;
            text-align: center;
            font-weight: 700;
            color: #333;
        }
        
        .amount-input::placeholder {
            color: #ccc;
        }
        
        /* purple gradient calculate button */
        .btn {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.2em;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        /* lift up and glow on hover */
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }
        
        /* red error message box */
        .error-message {
            background: #ffe6e6;
            color: #d63031;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            text-align: center;
        }
        
        /* back to dashboard link */
        .back-link {
            display: block;
            text-align: center;
            margin-top: 25px;
            color: #667eea;
            text-decoration: none;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
        
        /* red-orange streak badge with fire emoji */
        .streak-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: linear-gradient(135deg, #e17055 0%, #d63031 100%);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }
        
        /* yellow tip box at the bottom */
        .tip {
            background: #fff3cd;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            font-size: 0.9em;
            color: #856404;
        }
        
        .tip strong {
            display: block;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <%-- grab user data and categories from servlet --%>
    <%
        User user = (User) request.getAttribute("user");
        Category[] categories = (Category[]) request.getAttribute("categories");
    %>

    <%-- main calculator card --%>
    <div class="calculator-container">
        <%-- header with calculator emoji --%>
        <div class="header">
            <div class="icon">🧮</div>
            <h1>Friction Calculator</h1>
            <p>Think before you spend</p>
        </div>
        
        <%-- gray box showing user's hourly wage and current streak --%>
        <div class="user-info">
            <div>
                <span>Hourly Wage:</span>
                <strong>$<%= String.format("%.2f", user.getHourlyWage()) %></strong>
            </div>
            <div>
                <%-- show streak badge if user has a streak going --%>
                <% if (user.getCurrentStreak() > 0) { %>
                    <span class="streak-badge">🔥 <%= user.getCurrentStreak() %> day streak</span>
                <% } else { %>
                    <span>Start your streak!</span>
                <% } %>
            </div>
        </div>
        
        <%-- show error message if something went wrong --%>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <%-- calculator form --%>
        <form action="${pageContext.request.contextPath}/calculator" method="post">
            <%-- big amount input (main field) --%>
            <div class="form-group">
                <label for="amount">How much are you about to spend?</label>
                <input type="number" id="amount" name="amount" 
                       class="amount-input"
                       step="0.01" min="0.01" 
                       placeholder="$0.00" 
                       required autofocus>
            </div>
            
            <%-- category dropdown --%>
            <div class="form-group">
                <label for="category">Category</label>
                <select id="category" name="category">
                    <% for (Category cat : categories) { %>
                        <option value="<%= cat.getDbValue() %>"><%= cat.getDisplayName() %></option>
                    <% } %>
                </select>
            </div>
            
            <%-- optional description field --%>
            <div class="form-group">
                <label for="description">What is it? (optional)</label>
                <input type="text" id="description" name="description" 
                       placeholder="e.g., DoorDash order, new shoes...">
            </div>
            
            <%-- purple gradient submit button --%>
            <button type="submit" class="btn">Calculate Work Hours 🕐</button>
        </form>
        
        <%-- yellow tip box explaining what this does --%>
        <div class="tip">
            <strong>💡 Tip</strong>
            This calculator translates money into time. Seeing how long you'd have to work 
            to afford something helps make better spending decisions.
        </div>
        
        <%-- link back to dashboard --%>
        <a href="${pageContext.request.contextPath}/dashboard" class="back-link">← Back to Dashboard</a>
    </div>
</body>
</html>
