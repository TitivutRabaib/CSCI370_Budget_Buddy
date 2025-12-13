# **Budget Buddy**

SCRUM Project Plan

3-Person Team | 2 Weeks 

# **Team Roles:**

| Person | Role | Technical Focus | Responsibilities |
| :---: | ----- | ----- | ----- |
| Person A | Developer | Backend (Auth & Core Logic) | Prioritizes backlog, defines acceptance criteria, builds authentication & friction calculator |
| Person B | Developer | Backend (Data Layer) | Facilitates ceremonies, removes blockers, builds database & DAO layer |
| Person C | Developer | Frontend (UI/UX) | Builds all JSP pages, CSS styling, testing |

# **\*Scrum Master and Product Owner Role will cycle between each sprint and will be marked.**

# **Stakeholder Requirements/Product Backlog:**

| ID | User Story |
| ----- | ----- |
| US-01 | As a user, I can create an account so I can track my spending |
| US-02 | As a user, I can log in/out so my data is secure |
| US-03 | As a user, I can enter a purchase amount and see work hours so I understand the real cost |
| US-04 | As a user, I can click Skip/Buy so my decision is recorded |
| US-05 | As a user, I can see my dashboard with stats so I know my progress |
| US-06 | As a user, I can set a savings goal so I have something to work toward |
| US-07 | As a user, I can add transactions manually so I track all spending |
| US-08 | As a user, I can see my transaction history so I review past spending |
| US-09 | As a user, I can see adaptive nudges based on my level so advice is relevant |
| US-10 | As a user, I can see my streak count so I stay motivated |
| US-11 | As a user, I can update my profile (wage, budget) so calculations are accurate |
| US-12 | As a user, I can see goal progress in nudges so I understand impact |

## **Functional Requirements:**

The following functional requirements support the user stories above:

**User Authentication**

1. System shall allow users to create an account with username and password  
2. System shall authenticate users and create a session upon successful login  
3. System shall collect hourly wage and monthly budget during profile setup

**Friction Calculator**

1. System shall provide input field for purchase amount and validate it is numeric  
2. System shall calculate work hours by dividing purchase amount by hourly wage  
3. System shall display Skip It and Buy Anyway buttons and log user decision  
4. System shall update user statistics (streak, total saved) based on decision

**Transaction Management**

1. System shall allow users to manually add transactions with amount, category, and date  
2. System shall display transaction history in reverse chronological order  
3. System shall calculate and display monthly spending total on dashboard

**Goal Management**

1. System shall allow user to create one savings goal with name and target amount  
2. System shall calculate progress as (Total Saved / Target Amount) x 100%  
3. System shall update goal progress after each Skip/Buy decision

**Dashboard**

1. System shall display current streak count and total saved amount  
2. System shall display goal progress as a percentage  
3. System shall display skip rate (skips / total decisions)

# 

# **SPRINT 3: Complete Features & Polishing (Week 3\) due by Thursday, December 18th at 11:59 PM latest**

**Sprint 3 Roles:**

- **Person A** (Backend/Auth-Core Logic Developer): Allan Zhang **Product Owner**  
- **Person B** (Backend \[Data-Layer\] Developer): Titivut (Jeffy) Rabaib  
- **Person C** (Frontend Developer): Adewole Adeoshun **Scrum Master** 

## **Sprint Goal**

*"App is fully functional with goals, transactions, adaptive nudges, and ready for user testing."*

## 

## **Sprint Backlog**

### **US-06: Savings Goal**

* T-6.1: Create Goal.java model \- Person B  
* T-6.2: Create GoalDAO.java \- Person B  
* T-6.3: Create GoalServlet.java \- Person A  
* T-6.4: Create setGoal.jsp \- Person C  
* T-6.5: Create goal.jsp (view progress) \- Person C  
* 

### **US-07: Add Transactions**

* T-7.1: Create Transaction.java model \- Person B  
* T-7.2: Create TransactionDAO.java \- Person B  
* T-7.3: Create TransactionServlet.java \- Person A  
* T-7.4: Create addTransaction.jsp \- Person C

### **US-08: Transaction History** 

* T-8.1: Add findByUserId() to TransactionDAO \- Person B  
* T-8.2: Add history view to TransactionServlet \- Person A  
* T-8.3: Create transactions.jsp \- Person C

### **US-09: Adaptive Nudges**

* T-9.1: Implement 3-tier nudge messages \- Person A  
* T-9.2: Add goal impact to nudges \- Person A  
* T-9.3: Update result.jsp for different levels \- Person C

### **US-11: Profile Settings**

* T-11.1: Add updateProfile() to UserDAO \- Person B  
* T-11.2: Add profile action to AuthServlet \- Person A  
* T-11.3: Create profile.jsp \- Person C

### **Testing & Polishing**

* T-T.1: Deploy to test server \- Person B  
* T-T.2: Conduct user testing (3-5 people) \- Person C  
* T-T.3: Fix critical bugs \- ALL  
* T-T.4: Final UI polish \- Person C

## **Sprint 3 \- Task Completion Checklist (Testing)**

* User can create/edit savings goal  
* User can add manual transactions  
* User can view transaction history  
* Nudges adapt to user's knowledge level  
* Nudges show goal impact  
* User can update profile settings  
* App deployed and accessible  
* User testing completed (3-5 people)  
* Critical bugs fixed  
* Skip rate tracking functional

