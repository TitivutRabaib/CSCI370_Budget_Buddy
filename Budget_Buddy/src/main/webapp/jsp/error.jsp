<%--Adewole--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%-- telling JSP this is the error page so it can handle exceptions --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Budget Buddy</title>
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
        
        /* main white error card in the middle */
        .error-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 50px;
            text-align: center;
            max-width: 500px;
        }
        
        /* big emoji at the top */
        .error-icon {
            font-size: 5em;
            margin-bottom: 20px;
        }
        
        h1 {
            color: #333;
            margin-bottom: 15px;
        }
        
        /* friendly error message */
        p {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        /* purple gradient button to go back */
        .btn {
            display: inline-block;
            padding: 15px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            transition: transform 0.2s;
        }
        
        /* little bounce on hover */
        .btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <%-- the actual error card --%>
    <div class="error-container">
        <div class="error-icon">😅</div>
        <h1>Oops! Something went wrong</h1>
        <p>
            Don't worry, your savings streak is still intact! 
            Let's get you back on track.
        </p>
        <%-- link back to dashboard --%>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn">Back to Dashboard</a>
    </div>
</body>
</html>
