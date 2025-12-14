import edu.cs.budgetbuddy.dao.GoalDAO;
import edu.cs.budgetbuddy.model.Goal;
import edu.cs.budgetbuddy.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

@WebServlet("/goal")
public class GoalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Must be logged in
        User user = getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("setup".equals(action)) {
            showSetupForm(request, response, user);
        } else if ("edit".equals(action)) {
            showEditForm(request, response, user);
        } else {
            showGoalStatus(request, response, user);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Must be logged in
        User user = getLoggedInUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("save".equals(action)) {
            processSaveGoal(request, response, user);
        } else if ("delete".equals(action)) {
            processDeleteGoal(request, response, user);
        } else if ("addProgress".equals(action)) {
            processAddProgress(request, response, user);
        } else {
            response.sendRedirect(request.getContextPath() + "/goal");
        }
    }

    private User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("user");
        }
        return null;
    }
}