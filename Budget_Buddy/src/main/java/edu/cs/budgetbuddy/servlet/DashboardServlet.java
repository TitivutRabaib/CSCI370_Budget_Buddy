package edu.cs.budgetbuddy.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.cs.budgetbuddy.dao.NudgeLogDAO;
import edu.cs.budgetbuddy.dao.UserDAO;
import edu.cs.budgetbuddy.model.NudgeLog;
import edu.cs.budgetbuddy.model.User;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        int userId = user.getUserId();

        user = UserDAO.findById(userId);
        session.setAttribute("user", user);

        double skipRate = NudgeLogDAO.getSkipRate(userId);
        int totalNudges = NudgeLogDAO.getNudgeCount(userId);
        List<NudgeLog> recentNudges = NudgeLogDAO.findRecent(userId, 5);

        request.setAttribute("user", user);
        request.setAttribute("currentStreak", user.getCurrentStreak());
        request.setAttribute("longestStreak", user.getLongestStreak());
        request.setAttribute("totalSaved", user.getTotalSaved());
        request.setAttribute("skipCount", user.getSkipCount());
        request.setAttribute("buyCount", user.getBuyCount());
        request.setAttribute("skipRate", String.format("%.1f", skipRate));
        request.setAttribute("totalNudges", totalNudges);
        request.setAttribute("recentNudges", recentNudges);

        String skipRateStatus;
        String skipRateClass;
        if (totalNudges == 0) {
            skipRateStatus = "No data yet - use the calculator!";
            skipRateClass = "neutral";
        } else if (skipRate >= 60) {
            skipRateStatus = "Excellent! You're beating impulses!";
            skipRateClass = "success";
        } else if (skipRate >= 40) {
            skipRateStatus = "Good progress - keep it up!";
            skipRateClass = "warning";
        } else {
            skipRateStatus = "Room for improvement";
            skipRateClass = "danger";
        }
        request.setAttribute("skipRateStatus", skipRateStatus);
        request.setAttribute("skipRateClass", skipRateClass);
        
        request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
    }
}
