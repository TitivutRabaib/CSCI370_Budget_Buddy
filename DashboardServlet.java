package edu.cs.budgetbuddy.servlet;

import edu.cs.budgetbuddy.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        // Set placeholder stats
        request.setAttribute("user", user);
        request.setAttribute("currentStreak", 0);
        request.setAttribute("totalSaved", "0.00");
        request.setAttribute("skipRate", "0.0");
        request.setAttribute("monthlySpent", "0.00");
        
        request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
    }
}
