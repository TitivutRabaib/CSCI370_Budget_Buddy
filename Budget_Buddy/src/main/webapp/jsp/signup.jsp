<%--Adewole--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Budget Buddy</title>
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
        
        /* main white signup card in the middle */
        .signup-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
            width: 100%;
            max-width: 500px;
        }
        
        /* logo section at the top */
        .logo {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo h1 {
            color: #667eea;
            font-size: 2em;
            margin-bottom: 5px;
        }
        
        .logo p {
            color: #666;
            font-size: 0.9em;
        }
        
        /* wrapper for each form input */
        .form-group {
            margin-bottom: 18px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 6px;
            color: #333;
            font-weight: 500;
            font-size: 0.95em;
        }
        
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e1e1;
            border-radius: 10px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        
        /* purple border on focus */
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        
        /* two inputs side by side */
        .form-row {
            display: flex;
            gap: 15px;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        /* small helper text under inputs */
        .form-group small {
            display: block;
            margin-top: 5px;
            color: #888;
            font-size: 0.8em;
        }
        
        /* purple gradient signup button */
        .btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-top: 10px;
        }
        
        /* lift up and glow on hover */
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        
        /* red error message box */
        .error-message {
            background: #ffe6e6;
            color: #d63031;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        /* login link at the bottom */
        .login-link {
            text-align: center;
            margin-top: 25px;
            color: #666;
        }
        
        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .login-link a:hover {
            text-decoration: underline;
        }
        
        /* section dividers with purple text */
        .section-title {
            font-size: 1em;
            color: #667eea;
            margin: 25px 0 15px 0;
            padding-bottom: 8px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        /* red asterisk for required fields */
        .required {
            color: #d63031;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <%-- logo and tagline --%>
        <div class="logo">
            <h1>💰 Join Budget Buddy</h1>
            <p>Start your journey to smarter spending</p>
        </div>
        
        <%-- show error message if signup failed --%>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <%-- signup form --%>
        <form action="${pageContext.request.contextPath}/auth" method="post">
            <input type="hidden" name="action" value="signup">
            
            <div class="section-title">Account Information</div>
            
            <%-- username input --%>
            <div class="form-group">
                <label for="username">Username <span class="required">*</span></label>
                <input type="text" id="username" name="username" 
                       value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                       placeholder="Choose a username" required>
            </div>
            
            <%-- email input --%>
            <div class="form-group">
                <label for="email">Email <span class="required">*</span></label>
                <input type="email" id="email" name="email" 
                       value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                       placeholder="your@email.com" required>
            </div>
            
            <%-- password and confirm password side by side --%>
            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password <span class="required">*</span></label>
                    <input type="password" id="password" name="password" 
                           placeholder="Min 6 characters" required minlength="6">
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                    <input type="password" id="confirmPassword" name="confirmPassword" 
                           placeholder="Repeat password" required>
                </div>
            </div>
            
            <div class="section-title">Financial Profile</div>
            
            <%-- hourly wage and monthly budget side by side --%>
            <div class="form-row">
                <div class="form-group">
                    <label for="hourlyWage">Hourly Wage ($)</label>
                    <input type="number" id="hourlyWage" name="hourlyWage" 
                           value="<%= request.getAttribute("hourlyWage") != null ? request.getAttribute("hourlyWage") : "15.00" %>"
                           step="0.01" min="1" placeholder="15.00">
                    <small>Used to calculate work hours</small>
                </div>
                
                <div class="form-group">
                    <label for="monthlyBudget">Monthly Budget ($)</label>
                    <input type="number" id="monthlyBudget" name="monthlyBudget" 
                           value="<%= request.getAttribute("monthlyBudget") != null ? request.getAttribute("monthlyBudget") : "500.00" %>"
                           step="0.01" min="1" placeholder="500.00">
                    <small>Your spending limit</small>
                </div>
            </div>
            
            <%-- knowledge level dropdown --%>
            <div class="form-group">
                <label for="knowledgeLevel">Financial Knowledge Level</label>
                <select id="knowledgeLevel" name="knowledgeLevel">
                    <option value="beginner">Beginner - I'm just learning</option>
                    <option value="intermediate" selected>Intermediate - I know the basics</option>
                    <option value="advanced">Advanced - I'm financially savvy</option>
                </select>
                <small>Affects the detail level of nudge messages</small>
            </div>
            
            <%-- submit button --%>
            <button type="submit" class="btn">Create Account</button>
        </form>
        
        <%-- link to login page --%>
        <div class="login-link">
            Already have an account? <a href="${pageContext.request.contextPath}/auth?action=login">Login</a>
        </div>
    </div>
</body>
</html>
