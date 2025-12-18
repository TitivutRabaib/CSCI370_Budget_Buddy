<%--Adewole--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.cs.budgetbuddy.model.User" %>
<%@ page import="edu.cs.budgetbuddy.model.Goal" %>
<%@ page import="edu.cs.budgetbuddy.model.Transaction.Category" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Think About It - Budget Buddy</title>
    <style>
        /* basic resets */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        /* dark gradient background + center everything */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #2d3436 0%, #000000 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        /* main white card in the middle */
        .result-container {
            background: white;
            border-radius: 25px;
            box-shadow: 0 25px 80px rgba(0, 0, 0, 0.5);
            padding: 50px;
            width: 100%;
            max-width: 550px;
            text-align: center;
        }
        
        /* big red amount at the top */
        .amount-display {
            margin-bottom: 30px;
        }
        
        .amount-display .label {
            color: #666;
            font-size: 1em;
            margin-bottom: 5px;
        }
        
        .amount-display .amount {
            font-size: 3.5em;
            font-weight: 700;
            color: #d63031;
        }
        
        /* purple box showing work hours equivalent */
        .work-hours {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 30px;
        }
        
        .work-hours .label {
            font-size: 1em;
            opacity: 0.9;
            margin-bottom: 10px;
        }
        
        .work-hours .hours {
            font-size: 2.5em;
            font-weight: 700;
        }
        
        .work-hours .sub {
            font-size: 0.9em;
            opacity: 0.8;
            margin-top: 10px;
        }
        
        /* gray box with the nudge message */
        .nudge-message {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            text-align: left;
            white-space: pre-line;
            line-height: 1.8;
            color: #333;
            font-size: 1em;
        }
        
        .nudge-message .bullet {
            color: #667eea;
        }
        
        /* yellow streak warning box */
        .streak-warning {
            background: #fff3cd;
            border: 2px solid #ffc107;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 25px;
            color: #856404;
        }
        
        .streak-warning .icon {
            font-size: 1.5em;
            margin-right: 10px;
        }
        
        /* blue goal impact box */
        .goal-impact {
            background: #e8f4fd;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 25px;
            color: #0c5460;
        }
        
        /* two big buttons at the bottom */
        .decision-buttons {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .decision-btn {
            flex: 1;
            padding: 20px;
            border: none;
            border-radius: 15px;
            font-size: 1.2em;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        /* lift up on hover */
        .decision-btn:hover {
            transform: translateY(-3px);
        }
        
        /* green "skip it" button (recommended choice) */
        .btn-skip {
            background: linear-gradient(135deg, #00b894 0%, #00cec9 100%);
            color: white;
            box-shadow: 0 5px 20px rgba(0, 184, 148, 0.4);
        }
        
        .btn-skip:hover {
            box-shadow: 0 10px 30px rgba(0, 184, 148, 0.5);
        }
        
        /* gray "buy anyway" button */
        .btn-buy {
            background: #f8f9fa;
            color: #666;
            border: 2px solid #ddd;
        }
        
        /* turns red on hover */
        .btn-buy:hover {
            background: #fff;
            border-color: #d63031;
            color: #d63031;
        }
        
        /* countdown timer text */
        .countdown {
            margin-top: 20px;
            color: #888;
            font-size: 0.9em;
        }
        
        .countdown span {
            font-weight: 600;
            color: #667eea;
        }
        
        /* back link */
        .cancel-link {
            display: block;
            margin-top: 25px;
            color: #888;
            text-decoration: none;
            font-size: 0.9em;
        }
        
        .cancel-link:hover {
            color: #667eea;
        }
        
        /* gentle pulsing animation on the skip button */
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }
        
        .btn-skip {
            animation: pulse 2s infinite;
        }
    </style>
</head>
<body>
    <%-- grab all the calculation data from servlet --%>
    <%
        User user = (User) request.getAttribute("user");
        Goal goal = (Goal) request.getAttribute("goal");
        BigDecimal amount = (BigDecimal) request.getAttribute("amount");
        String formattedWorkHours = (String) request.getAttribute("formattedWorkHours");
        String nudgeMessage = (String) request.getAttribute("nudgeMessage");
        int currentStreak = (Integer) request.getAttribute("currentStreak");
        int goalDelayDays = (Integer) request.getAttribute("goalDelayDays");
        Category category = (Category) request.getAttribute("category");
    %>

    <%-- main result card --%>
    <div class="result-container">
        <%-- big red amount display --%>
        <div class="amount-display">
            <div class="label">You're about to spend</div>
            <div class="amount">$<%= String.format("%.2f", amount) %></div>
        </div>
        
        <%-- purple box showing work hours equivalent --%>
        <div class="work-hours">
            <div class="label">That's equivalent to</div>
            <div class="hours"><%= formattedWorkHours %></div>
            <div class="sub">of your work at $<%= String.format("%.2f", user.getHourlyWage()) %>/hour</div>
        </div>
        
        <%-- yellow warning if user has an active streak --%>
        <% if (currentStreak > 0) { %>
            <div class="streak-warning">
                <span class="icon">🔥</span>
                <strong>You have a <%= currentStreak %>-transaction streak!</strong>
                Buying this will reset your progress.
            </div>
        <% } %>
        
        <%-- blue box showing how this affects their goal --%>
        <% if (goal != null && goalDelayDays > 0) { %>
            <div class="goal-impact">
                <strong>🎯 Goal Impact:</strong> This purchase delays your 
                "<%= goal.getGoalName() %>" goal by <strong><%= goalDelayDays %> day(s)</strong>
            </div>
        <% } %>
        
        <%-- gray box with personalized nudge message --%>
        <div class="nudge-message">
            <%= nudgeMessage %>
        </div>
        
        <%-- decision form with two buttons --%>
        <form action="${pageContext.request.contextPath}/calculator" method="post">
            <input type="hidden" name="action" value="decide">
            
            <div class="decision-buttons">
                <%-- green pulsing "skip it" button (recommended) --%>
                <button type="submit" name="decision" value="skip" class="decision-btn btn-skip">
                    ✓ Skip It
                </button>
                <%-- gray "buy anyway" button --%>
                <button type="submit" name="decision" value="buy" class="decision-btn btn-buy">
                    Buy Anyway
                </button>
            </div>
        </form>
        
        <%-- 30 second countdown timer --%>
        <div class="countdown">
            Take a moment to think... <span id="timer">30</span> seconds
        </div>
        
        <%-- link to go back and enter different amount --%>
        <a href="${pageContext.request.contextPath}/calculator" class="cancel-link">← Enter different amount</a>
    </div>
    
    <%-- javascript countdown timer --%>
    <script>
        // counts down from 30 to encourage user to think before deciding
        let seconds = 30;
        const timerElement = document.getElementById('timer');
        
        const countdown = setInterval(() => {
            seconds--;
            timerElement.textContent = seconds;
            
            // when timer hits 0, change the message
            if (seconds <= 0) {
                clearInterval(countdown);
                timerElement.parentElement.innerHTML = 'Take your time to decide wisely.';
            }
        }, 1000);
    </script>
</body>
</html>
