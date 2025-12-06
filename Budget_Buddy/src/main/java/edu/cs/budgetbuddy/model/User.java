public class User {

    private int userId;
    private String username;
    private String email;
    private String passwordHash;
    private BigDecimal hourlyWage;
    private BigDecimal monthlyBudget;
    private String knowledgeLevel;
    private Timestamp createdAt;
    private Timestamp lastLogin;
    
    // Default constructor
    public User() {
        this.hourlyWage = new BigDecimal("15.00");
        this.monthlyBudget = new BigDecimal("500.00");
        this.knowledgeLevel = "beginner";
    }
}