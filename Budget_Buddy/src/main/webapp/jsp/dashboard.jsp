<%--Adewole--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="edu.cs.budgetbuddy.model.User" %>
<%@ page import="edu.cs.budgetbuddy.model.Goal" %>
<%@ page import="edu.cs.budgetbuddy.model.Transaction" %>
<%@ page import="edu.cs.budgetbuddy.model.Transaction.Category" %>
<%@ page import="edu.cs.budgetbuddy.model.NudgeLog" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Budget Buddy</title>
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
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        .navbar h1 {
            color: white;
            font-size: 1.5em;
        }
        
        .navbar-links {
            display: flex;
            gap: 20px;
            align-items: center;
        }
        
        /* nav links that light up on hover */
        .navbar-links a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 8px;
            transition: background 0.3s;
        }
        
        .navbar-links a:hover {
            background: rgba(255,255,255,0.2);
        }
        
        /* white calculator button (stands out from other links) */
        .navbar-links .btn-calculator {
            background: white;
            color: #667eea;
            font-weight: 600;
        }
        
        /* main content container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 30px;
        }
        
        /* green welcome banner for new users */
        .welcome-banner {
            background: linear-gradient(135deg, #00b894 0%, #00cec9 100%);
            color: white;
            padding: 20px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        /* grid of four stat cards at the top */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        /* individual stat card */
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        .stat-card h3 {
            color: #666;
            font-size: 0.9em;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .stat-card .value {
            font-size: 2.5em;
            font-weight: 700;
            color: #333;
        }
        
        .stat-card .sub-value {
            color: #888;
            font-size: 0.9em;
            margin-top: 5px;
        }
        
        /* different colors for each stat type */
        .stat-card.streak .value { color: #e17055; }
        .stat-card.saved .value { color: #00b894; }
        .stat-card.skip-rate .value { color: #667eea; }
        .stat-card.budget .value { color: #fdcb6e; }
        
        /* colored left border based on status */
        .stat-card.success { border-left: 4px solid #00b894; }
        .stat-card.warning { border-left: 4px solid #fdcb6e; }
        .stat-card.danger { border-left: 4px solid #d63031; }
        .stat-card.neutral { border-left: 4px solid #b2bec3; }
        
        /* white section card */
        .section {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        .section h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 1.3em;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .goal-progress {
            margin-top: 15px;
        }
        
        /* gray progress bar container */
        .progress-bar {
            background: #e1e1e1;
            border-radius: 10px;
            height: 25px;
            overflow: hidden;
            margin: 10px 0;
        }
        
        /* purple gradient progress fill */
        .progress-fill {
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 10px;
            transition: width 0.5s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 0.85em;
        }
        
        /* goal details under progress bar */
        .goal-details {
            display: flex;
            justify-content: space-between;
            color: #666;
            font-size: 0.9em;
        }
        
        /* grid of quick action buttons */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        
        /* action button styling */
        .action-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            padding: 15px 25px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        /* lift up and shadow on hover */
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.15);
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
        
        /* list of recent items (transactions, nudges) */
        .recent-list {
            list-style: none;
        }
        
        .recent-list li {
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .recent-list li:last-child {
            border-bottom: none;
        }
        
        .recent-list .description {
            color: #333;
        }
        
        .recent-list .meta {
            color: #888;
            font-size: 0.85em;
        }
        
        .recent-list .amount {
            font-weight: 600;
        }
        
        /* red for expenses */
        .recent-list .amount.negative { color: #d63031; }
        /* green for income/savings */
        .recent-list .amount.positive { color: #00b894; }
        
        /* small colored badge (skip/buy) */
        .badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75em;
            font-weight: 600;
        }
        
        /* green skip badge */
        .badge.skip { background: #d4edda; color: #155724; }
        /* red buy badge */
        .badge.buy { background: #f8d7da; color: #721c24; }
        
        /* shown when sections are empty */
        .empty-state {
            text-align: center;
            padding: 30px;
            color: #888;
        }
        
        .empty-state .icon {
            font-size: 3em;
            margin-bottom: 15px;
        }
        
        /* mobile responsive */
        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .navbar {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <%-- grab all dashboard data from servlet --%>
    <%
        User user = (User) request.getAttribute("user");
        Goal goal = (Goal) request.getAttribute("goal");
        List<Transaction> recentTransactions = (List<Transaction>) request.getAttribute("recentTransactions");
        List<NudgeLog> recentNudges = (List<NudgeLog>) request.getAttribute("recentNudges");
    %>

    <%-- top navigation bar --%>
    <nav class="navbar">
        <h1>💰 Budget Buddy</h1>
        <div class="navbar-links">
            <a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/transaction">Transactions</a>
            <a href="${pageContext.request.contextPath}/goal">Goal</a>
            <a href="${pageContext.request.contextPath}/auth?action=profile">Profile</a>
            <a href="${pageContext.request.contextPath}/calculator" class="btn-calculator">🧮 Calculator</a>
            <a href="${pageContext.request.contextPath}/auth?action=logout">Logout</a>
        </div>
    </nav>
    
    <div class="container">
        <%-- green welcome banner (only shows for new users) --%>
        <% if (request.getAttribute("welcomeMessage") != null) { %>
            <div class="welcome-banner">
                <h2>🎉 Welcome to Budget Buddy, <%= user.getUsername() %>!</h2>
                <p>Your account is set up. Start using the calculator to track impulse decisions!</p>
            </div>
        <% } %>
        
        <%-- four stat cards showing key metrics --%>
        <div class="stats-grid">
            <div class="stat-card streak">
                <h3>🔥 Current Streak</h3>
                <div class="value"><%= request.getAttribute("currentStreak") %></div>
                <div class="sub-value">Longest: <%= request.getAttribute("longestStreak") %> days</div>
            </div>
            
            <div class="stat-card saved">
                <h3>💵 Total Saved</h3>
                <div class="value">$<%= String.format("%.2f", request.getAttribute("totalSaved")) %></div>
                <div class="sub-value"><%= request.getAttribute("totalWorkHoursSaved") %> hours of work</div>
            </div>
            
            <div class="stat-card skip-rate <%= request.getAttribute("skipRateClass") %>">
                <h3>📊 Skip Rate</h3>
                <div class="value"><%= request.getAttribute("skipRateFormatted") %>%</div>
                <div class="sub-value"><%= request.getAttribute("skipRateStatus") %></div>
            </div>
            
            <div class="stat-card budget <%= request.getAttribute("budgetClass") %>">
                <h3>📅 Monthly Budget</h3>
                <div class="value">$<%= String.format("%.2f", request.getAttribute("budgetRemaining")) %></div>
                <div class="sub-value"><%= String.format("%.0f", request.getAttribute("budgetUsedPercent")) %>% used of $<%= String.format("%.2f", request.getAttribute("monthlyBudget")) %></div>
            </div>
        </div>
        
        <%-- goal section with progress bar --%>
        <div class="section">
            <h2>🎯 Savings Goal</h2>
            <% if (goal != null) { %>
                <h3><%= goal.getGoalName() %></h3>
                <div class="goal-progress">
                    <%-- purple progress bar --%>
                    <div class="progress-bar">
                        <div class="progress-fill" style="width: <%= Math.min(100, (Double) request.getAttribute("goalProgressPercent")) %>%">
                            <%= String.format("%.1f", request.getAttribute("goalProgressPercent")) %>%
                        </div>
                    </div>
                    <%-- goal stats under progress bar --%>
                    <div class="goal-details">
                        <span><%= goal.getFormattedCurrentAmount() %> saved</span>
                        <span><%= goal.getFormattedTargetAmount() %> target</span>
                    </div>
                    <div class="goal-details" style="margin-top: 10px;">
                        <span>$<%= String.format("%.2f", request.getAttribute("goalAmountRemaining")) %> remaining</span>
                        <span><%= request.getAttribute("daysUntilDeadline") %> days left</span>
                    </div>
                </div>
            <% } else { %>
                <%-- empty state when no goal exists --%>
                <div class="empty-state">
                    <div class="icon">🎯</div>
                    <p>No goal set yet</p>
                    <a href="${pageContext.request.contextPath}/goal?action=setup" class="action-btn primary" style="display: inline-flex; margin-top: 15px;">Set a Goal</a>
                </div>
            <% } %>
        </div>
        
        <%-- quick action buttons --%>
        <div class="section">
            <h2>⚡ Quick Actions</h2>
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/calculator" class="action-btn primary">
                    🧮 Friction Calculator
                </a>
                <a href="${pageContext.request.contextPath}/transaction?action=add" class="action-btn secondary">
                    ➕ Add Transaction
                </a>
                <a href="${pageContext.request.contextPath}/goal?action=edit" class="action-btn secondary">
                    ✏️ Edit Goal
                </a>
                <a href="${pageContext.request.contextPath}/auth?action=profile" class="action-btn secondary">
                    👤 Update Profile
                </a>
            </div>
        </div>
        
        <%-- two columns: recent decisions and recent transactions --%>
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 25px;">
            <%-- recent nudge decisions (skip/buy) --%>
            <div class="section">
                <h2>🧠 Recent Decisions</h2>
                <% if (recentNudges != null && !recentNudges.isEmpty()) { %>
                    <ul class="recent-list">
                        <% for (NudgeLog nudge : recentNudges) { %>
                            <li>
                                <div>
                                    <div class="description">
                                        $<%= String.format("%.2f", nudge.getAmount()) %> - <%= nudge.getCategory() %>
                                    </div>
                                    <div class="meta"><%= nudge.getFormattedWorkHours() %> of work</div>
                                </div>
                                <span class="badge <%= nudge.getDecision().getDbValue() %>">
                                    <%= nudge.getDecision().getDbValue().toUpperCase() %>
                                </span>
                            </li>
                        <% } %>
                    </ul>
                <% } else { %>
                    <div class="empty-state">
                        <div class="icon">🧮</div>
                        <p>No decisions yet. Use the calculator!</p>
                    </div>
                <% } %>
            </div>
            
            <%-- recent transactions list --%>
            <div class="section">
                <h2>💳 Recent Transactions</h2>
                <% if (recentTransactions != null && !recentTransactions.isEmpty()) { %>
                    <ul class="recent-list">
                        <% for (Transaction tx : recentTransactions) { %>
                            <li>
                                <div>
                                    <div class="description"><%= tx.getDescription() != null && !tx.getDescription().isEmpty() ? tx.getDescription() : tx.getCategory().getDisplayName() %></div>
                                    <div class="meta"><%= tx.getTransactionDate() %></div>
                                </div>
                                <span class="amount negative">-<%= tx.getFormattedAmount() %></span>
                            </li>
                        <% } %>
                    </ul>
                    <a href="${pageContext.request.contextPath}/transaction" style="display: block; text-align: center; margin-top: 15px; color: #667eea;">View All →</a>
                <% } else { %>
                    <div class="empty-state">
                        <div class="icon">💳</div>
                        <p>No transactions recorded yet</p>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
