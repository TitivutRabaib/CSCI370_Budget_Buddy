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

# **SPRINT 2: Core Feature (Week 2\) Due by Saturday, December 13th at 11:59 PM latest**

**Sprint 2 Roles:**

- **Person A** (Backend/Auth-Core Logic Developer): Allan Zhang **Scrum Master**   
- **Person B** (Backend \[Data-Layer\] Developer): Titivut (Jeffy) Rabaib **Product Owner**  
- **Person C** (Frontend Developer): Adewole Adeoshun  

## **Sprint Goal**

*"Users can use the friction calculator to make Skip/Buy decisions and see their stats."*

## **Sprint Backlog**

### **US-03: Friction Calculator** 

* T-3.1: Create FrictionNudgeServlet (GET \- show form) \- Person A  
* T-3.2: Implement work hours calculation \- Person A  
* T-3.3: Create calculator.jsp (input form) \- Person C  
* T-3.4: Create result.jsp (show nudge) \- Person C  
* T-3.5: Generate basic nudge message \- Person A


### **US-04: Skip/Buy Decision**

* T-4.1: Create NudgeLog.java model \- Person B  
* T-4.2: Create NudgeLogDAO.java \- Person B  
* T-4.3: Add decision processing to FrictionNudgeServlet \- Person A  
* T-4.4: Create decision.jsp (confirmation page) \- Person C  
* T-4.5: Update user stats on Skip (streak, total\_saved) \- Person B

### **US-10: Streak Counter**

* T-10.1: Add recordSkip() to UserDAO \- Person B  
* T-10.2: Add recordBuy() to UserDAO \- Person B  
* T-10.3: Display streak on dashboard \- Person C

### **US-05: Dashboard Stats \- Full** 

* T-5.4: Add skip rate calculation to NudgeLogDAO \- Person B  
* T-5.5: Update DashboardServlet with real data \- Person A  
* T-5.6: Update dashboard.jsp with real stats \- Person C

## **Sprint 2 \- Task Completion Checklist (Testing)**

* User can enter purchase amount  
* System displays work hours calculation  
* User sees nudge message  
* User can click "Skip It" \- streak increases, amount saved  
* User can click "Buy Anyway" \- streak resets  
* Dashboard shows real skip rate  
* Dashboard shows real total saved  
* Dashboard shows current streak

