<%--Adewole: Sprint 2 dashboard with friction calculator stats--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.cs.budgetbuddy.model.User" %>
<%@ page import="edu.cs.budgetbuddy.model.NudgeLog" %>
<%@ page import="java.util.List" %>
<%
    // check if user is logged in
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/auth?action=login");
        return;
    }
    // grab recent nudge history
    List<NudgeLog> recentNudges = (List<NudgeLog>) request.getAttribute("recentNudges");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budget Buddy - Dashboard</title>
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
        
        /* main container */
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 30px;
        }
        
        /* welcome section at top */
        .welcome {
            background: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 25px;
            text-align: center;
        }
        .welcome-subtitle {
            color: #666;
            margin-top: 10px;
        }
        
        /* grid of stat cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }
        
        /* individual stat card */
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-card .icon { font-size: 32px; margin-bottom: 10px; }
        .stat-card .value { font-size: 28px; font-weight: 700; color: #333; }
        .stat-card .label { color: #666; margin-top: 5px; }
        
        /* skip rate progress card */
        .skip-rate-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 25px;
        }
        .skip-rate-card h3 { margin-bottom: 15px; }
        
        /* the bar background */
        .skip-rate-bar {
            height: 20px;
            background: #e9ecef;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 10px;
        }
        
        /* the green fill inside bar */
        .skip-rate-fill {
            height: 100%;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border-radius: 10px;
            transition: width 0.5s ease;
        }
        
        /* text under the bar */
        .skip-rate-text { display: flex; justify-content: space-between; color: #666; }
        
        /* status colors */
        .status-success { color: #28a745; }
        .status-warning { color: #ffc107; }
        .status-danger { color: #dc3545; }
        
        /* big calculator button */
        .quick-action {
            display: inline-block;
            padding: 15px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            margin-right: 10px;
        }
        
        /* button wrapper */
        .action-wrapper {
            margin-bottom: 25px;
        }
        
        /* recent activity section */
        .recent-activity {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .recent-activity h3 { margin-bottom: 15px; }
        
        /* individual activity row */
        .activity-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        .activity-item:last-child { border-bottom: none; }
        
        /* skip = green, buy = red */
        .activity-skip { color: #28a745; }
        .activity-buy { color: #dc3545; }
        
        /* activity category text */
        .activity-category { color: #999; }
        
        /* empty state text */
        .empty-state {
            color: #666;
            text-align: center;
            padding: 20px;
        }
    </style>
</head>
<body>
    <%-- top navbar --%>
    <nav class="navbar">
        <h1>💰 Budget Buddy</h1>
        <div>
            <a href="${pageContext.request.contextPath}/calculator">Calculator</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">Logout</a>
        </div>
    </nav>
    
    <%-- main content --%>
    <div class="container">
        <%-- welcome message --%>
        <div class="welcome">
            <h2>Welcome back, <%= user.getUsername() %>! 👋</h2>
            <p class="welcome-subtitle">Sprint 2 - Friction Calculator is now live!</p>
        </div>
        
        <%-- the four main stats --%>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="icon">🔥</div>
                <div class="value">${currentStreak}</div>
                <div class="label">Day Streak</div>
            </div>
            <div class="stat-card">
                <div class="icon">💵</div>
                <div class="value">$${totalSaved}</div>
                <div class="label">Total Saved</div>
            </div>
            <div class="stat-card">
                <div class="icon">✅</div>
                <div class="value">${skipCount}</div>
                <div class="label">Skips</div>
            </div>
            <div class="stat-card">
                <div class="icon">💸</div>
                <div class="value">${buyCount}</div>
                <div class="label">Buys</div>
            </div>
        </div>
        
        <%-- skip rate with progress bar --%>
        <div class="skip-rate-card">
            <h3>📊 Skip Rate (Target: 60%+)</h3>
            <div class="skip-rate-bar">
                <div class="skip-rate-fill" style="width: ${skipRate}%;"></div>
            </div>
            <div class="skip-rate-text">
                <span class="status-${skipRateClass}">${skipRateStatus}</span>
                <span><strong>${skipRate}%</strong> (${totalNudges} decisions)</span>
            </div>
        </div>
        
        <%-- big button to calculator --%>
        <div class="action-wrapper">
            <a href="${pageContext.request.contextPath}/calculator" class="quick-action">
                🧮 Use Friction Calculator
            </a>
        </div>
        
        <%-- recent activity list --%>
        <div class="recent-activity">
            <h3>Recent Decisions</h3>
            <%-- check if there are any nudges --%>
            <% if (recentNudges != null && !recentNudges.isEmpty()) { %>
                <%-- loop through and show each one --%>
                <% for (NudgeLog nudge : recentNudges) { %>
                    <div class="activity-item">
                        <span class="<%= nudge.isSkip() ? "activity-skip" : "activity-buy" %>">
                            <%= nudge.isSkip() ? "✅ Skipped" : "💸 Bought" %>
                            $<%= nudge.getAmount() %>
                        </span>
                        <span class="activity-category"><%= nudge.getCategory() %></span>
                    </div>
                <% } %>
            <% } else { %>
                <%-- no activity yet --%>
                <p class="empty-state">
                    No decisions yet. Try the Friction Calculator!
                </p>
            <% } %>
        </div>
    </div>
</body>
</html>
