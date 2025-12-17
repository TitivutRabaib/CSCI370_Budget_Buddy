<%--Adewole--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Budget Buddy</title>
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
        
        /* main white login card in the middle */
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 40px;
            width: 100%;
            max-width: 400px;
        }
        
        /* logo section at the top */
        .logo {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo h1 {
            color: #667eea;
            font-size: 2.5em;
            margin-bottom: 5px;
        }
        
        .logo p {
            color: #666;
            font-size: 0.9em;
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
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e1e1e1;
            border-radius: 10px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        
        /* purple border on focus */
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        /* purple gradient login button */
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
        
        /* green success message box */
        .success-message {
            background: #e6ffe6;
            color: #00b894;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        /* signup link at the bottom */
        .signup-link {
            text-align: center;
            margin-top: 25px;
            color: #666;
        }
        
        .signup-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .signup-link a:hover {
            text-decoration: underline;
        }
        
        /* features section showing what the app does */
        .features {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        
        .features h3 {
            text-align: center;
            color: #333;
            margin-bottom: 15px;
            font-size: 0.95em;
        }
        
        /* three feature icons in a row */
        .feature-list {
            display: flex;
            justify-content: space-around;
            text-align: center;
        }
        
        .feature-item {
            font-size: 0.8em;
            color: #666;
        }
        
        .feature-item .icon {
            font-size: 1.5em;
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <%-- logo and tagline --%>
        <div class="logo">
            <h1>💰 Budget Buddy</h1>
            <p>Think before you spend</p>
        </div>
        
        <%-- show error message if login failed --%>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <%-- show success message after logout --%>
        <% if ("logged_out".equals(request.getParameter("message"))) { %>
            <div class="success-message">
                You have been logged out successfully.
            </div>
        <% } %>
        
        <%-- login form --%>
        <form action="${pageContext.request.contextPath}/auth" method="post">
            <input type="hidden" name="action" value="login">
            
            <%-- username input --%>
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" 
                       value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                       placeholder="Enter your username" required>
            </div>
            
            <%-- password input --%>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" 
                       placeholder="Enter your password" required>
            </div>
            
            <%-- submit button --%>
            <button type="submit" class="btn">Login</button>
        </form>
        
        <%-- link to signup page --%>
        <div class="signup-link">
            Don't have an account? <a href="${pageContext.request.contextPath}/auth?action=signup">Sign up</a>
        </div>
        
        <%-- features preview --%>
        <div class="features">
            <h3>Why Budget Buddy?</h3>
            <div class="feature-list">
                <div class="feature-item">
                    <div class="icon">⏱️</div>
                    <div>Work Hours</div>
                </div>
                <div class="feature-item">
                    <div class="icon">🎯</div>
                    <div>Goals</div>
                </div>
                <div class="feature-item">
                    <div class="icon">🔥</div>
                    <div>Streaks</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
