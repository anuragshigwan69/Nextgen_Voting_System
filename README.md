# 🗳️ NextGen Voting System

<div align="center">
### A secure, web-based college election management system built with Java Servlets, JSP, and MySQL.

<br/>

![Java](https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-Dynamic%20Web-007396?style=for-the-badge&logo=java&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Database-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Tomcat](https://img.shields.io/badge/Apache%20Tomcat%2011-Server-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=black)
![Eclipse](https://img.shields.io/badge/Eclipse%20IDE-Dynamic%20Web%20Project-2C2255?style=for-the-badge&logo=eclipseide&logoColor=white)
![Security](https://img.shields.io/badge/OTP-Verified%20Secure-28a745?style=for-the-badge&logo=shield&logoColor=white)

</div>

---

## 📌 Table of Contents

- [About the Project](#-about-the-project)
- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Database Setup](#-database-setup)
- [Installation & Setup](#-installation--setup)
- [How It Works](#-how-it-works)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

---

## 📖 About the Project

**NextGen Voting System** is a full-featured, secure online voting platform designed specifically for **college elections**. It enables students to register, verify their identity via OTP, and cast votes for candidates running for specific posts — all within a controlled and transparent environment.

The system is divided into two main sides:

- 🎓 **Student Side** — Register, verify via OTP, login, and cast votes securely.
- 🛠️ **Admin Side** — Manage students, candidates, classes, and control the entire election lifecycle.

> The goal is to eliminate manual ballot-based voting and replace it with a **tamper-proof, OTP-secured digital election system** that ensures every vote is authentic and traceable.

---

## ✨ Features

### 🎓 Student Features

- ✅ Register with College ID, Email, and Password
- ✅ OTP-based email verification during registration
- ✅ Secure login with college credentials
- ✅ View all candidates for each election post
- ✅ Cast vote for preferred candidates
- ✅ Change or reset password via OTP verification
- ✅ Forgot password flow with email OTP

### 🛠️ Admin Features

- ✅ Secure admin login panel
- ✅ Full election lifecycle control:
  - ▶️ Start election
  - ⏹️ Stop election
  - 🔄 Reset election
- ✅ Add and remove candidates for specific posts
- ✅ Add and manage students
- ✅ Assign students to their respective classes
- ✅ Manually set or reset student passwords
- ✅ View real-time vote counts per candidate
- ✅ View results by position / post

### 🔒 Security Features

- ✅ OTP sent to registered college email for every sensitive action
- ✅ OTP-verified registration, login, and password changes
- ✅ Session-based authentication (separate sessions for admin and students)
- ✅ Admin-only access to election controls and sensitive data

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Project Type | Dynamic Web Project (Eclipse IDE) |
| Backend | Java 17 — Servlets |
| Frontend | JSP, HTML, CSS, JavaScript |
| Database | MySQL 8+ |
| Server | Apache Tomcat 11 |
| Email / OTP | Jakarta Mail (angus-mail-2.0.2) |
| Build | Eclipse Java EE Builder (no Maven) |

**External JARs (placed manually in `WEB-INF/lib/`):**

| JAR File | Purpose |
|---|---|
| `angus-mail-2.0.2.jar` | SMTP email sending for OTP |
| `jakarta.activation-api-2.1.3.jar` | Mail activation API |
| `jakarta.mail-2.0.1.jar` | Jakarta Mail implementation |
| `jakarta.mail-api-2.1.3.jar` | Jakarta Mail API |
| `jakarta.servlet-api-6.0.0.jar` | Servlet & JSP support |
| `mysql-connector-j-9.5.0.jar` | MySQL JDBC driver |

> ⚠️ This is **not a Maven project**. All JARs are added manually to `WEB-INF/lib/` and managed through Eclipse's build path.

---

## 📁 Project Structure

```
Nextgen_Voting_System/
│
├── src/
│   └── main/
│       └── java/
│           └── com/votingsystem/
│               ├── AddCandidateServlet.java    ← Handles candidate addition logic
│               └── VoteServlet.java            ← Handles vote submission logic
│
├── WebContent/  (or webapp/)
│   │
│   ├── index.jsp                               ← Landing / Home page
│   ├── about.jsp                               ← About page
│   ├── logout.jsp                              ← Student logout
│   ├── dbTest.jsp                              ← DB connection test utility
│   │
│   ├── ── Student Flow ──────────────────────
│   ├── studentRegister.jsp                     ← Student registration form
│   ├── studentRegisterProcess.jsp              ← Registration backend process
│   ├── studentLogin.jsp                        ← Student login page
│   ├── studentLoginProcess.jsp                 ← Login backend process
│   ├── studentDashboard.jsp                    ← Student dashboard
│   ├── viewCandidates.jsp                      ← View all election candidates
│   ├── voteProcess.jsp                         ← Vote submission handler
│   │
│   ├── ── OTP & Password Flow ───────────────
│   ├── sendOtp.jsp                             ← Send OTP (login verification)
│   ├── sendOtpRegister.jsp                     ← Send OTP (registration)
│   ├── verifyOtp.jsp                           ← Verify OTP (login)
│   ├── verifyOtpProcess.jsp                    ← OTP verification process
│   ├── verifyOtpRegister.jsp                   ← OTP verification (registration)
│   ├── otp.jsp                                 ← OTP entry page
│   ├── setPassword.jsp                         ← Set new password after OTP
│   ├── setPasswordProcess.jsp                  ← Set password backend process
│   ├── forgotPassword.jsp                      ← Forgot password entry page
│   ├── sendForgotOtp.jsp                       ← Send OTP for forgot password
│   ├── verifyForgotOtp.jsp                     ← Verify forgot password OTP
│   ├── verifyForgotOtpProcess.jsp              ← OTP process for forgot password
│   ├── resetPassword.jsp                       ← Reset password form
│   ├── resetPasswordProcess.jsp                ← Reset password backend process
│   │
│   ├── ── Admin Flow ────────────────────────
│   ├── adminLogin.jsp                          ← Admin login page
│   ├── adminLoginProcess.jsp                   ← Admin login processing
│   ├── adminDashboard.jsp                      ← Admin control dashboard
│   ├── adminLogout.jsp                         ← Admin logout
│   ├── electionControl.jsp                     ← Start / Stop / Reset election
│   ├── addCandidate.jsp                        ← Add new candidate
│   ├── removeCandidate.jsp                     ← Remove a candidate
│   ├── addStudent.jsp                          ← Add new student
│   ├── viewStudents.jsp                        ← View all registered students
│   ├── removeStudent.jsp                       ← Remove a student
│   ├── removeClass.jsp                         ← Manage student classes
│   ├── viewResults.jsp                         ← View overall election results
│   ├── viewPositionResult.jsp                  ← Results filtered by post/position
│   │
│   ├── WEB-INF/
│   │   ├── web.xml                             ← Servlet configuration & URL mappings
│   │   └── lib/                                ← All external JAR dependencies
│   │       ├── angus-mail-2.0.2.jar
│   │       ├── jakarta.activation-api-2.1.3.jar
│   │       ├── jakarta.mail-2.0.1.jar
│   │       ├── jakarta.mail-api-2.1.3.jar
│   │       ├── jakarta.servlet-api-6.0.0.jar
│   │       └── mysql-connector-j-9.5.0.jar
│   │
│   └── images/                                 ← Image assets (logos, candidate photos)
│
├── build/
│   └── classes/                                ← Compiled .class files (auto-generated)
│
├── .classpath                                  ← Eclipse build path configuration
├── .project                                    ← Eclipse project descriptor
└── .settings/                                  ← Eclipse workspace settings
```

---

## 🗄️ Database Setup

> ⚠️ **Database schema coming soon.** The SQL dump file will be added to this repository shortly.

Once the file is available, import it using:

```bash
mysql -u root -p < database/votingd.sql
```

Or create the database manually:

```sql
CREATE DATABASE votingdb;
USE votingdb;
-- Tables will be listed here once the schema file is added
```

After setting up the database, update the DB credentials inside the JSP files wherever you see a connection string like this:

```java
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/nextgen_voting_system", "root", "your_password"
);
```

---

## ⚙️ Installation & Setup

### ✅ Prerequisites

Make sure the following are installed on your machine:

- Java JDK 17
- Apache Tomcat 11
- MySQL 8+
- Eclipse IDE for Enterprise Java and Web Developers

> ⚠️ This project does **not** use Maven or Gradle. It is a plain **Dynamic Web Project** managed entirely through Eclipse IDE.

---

### 🚀 Steps

**1. Clone the repository**

```bash
git clone https://github.com/anuragshigwan69/Nextgen_Voting_System.git
```

**2. Open Eclipse and import the project**

- Go to `File` → `Import` → `Existing Projects into Workspace`
- Click `Browse` and select the cloned project folder
- Click `Finish`

**3. Add JARs to the Build Path**

All required JARs are already inside `WEB-INF/lib/`. To confirm Eclipse recognises them:

- Right-click the project → `Build Path` → `Configure Build Path`
- Go to the `Libraries` tab
- Click `Add JARs` → navigate to `WEB-INF/lib/` → select all JARs
- Click `Apply and Close`

**4. Configure the Database**

- Create your MySQL database (see [Database Setup](#-database-setup))
- Open the relevant JSP files and update the DB connection credentials:

```java
Connection conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/nextgen_voting_system", "root", "your_password"
);
```

**5. Configure Email / OTP Settings**

- Open `sendOtp.jsp`, `sendOtpRegister.jsp`, and `sendForgotOtp.jsp`
- Update the Gmail credentials:

```java
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.port", "587");
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.starttls.enable", "true");

String senderEmail    = "your-email@gmail.com";
String senderPassword = "your-app-password";
```

> 💡 Use a **Gmail App Password**, not your regular Gmail password.
> Generate one here → [myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords)

**6. Add Tomcat Server in Eclipse**

- Go to `Window` → `Preferences` → `Server` → `Runtime Environments`
- Click `Add` → select `Apache Tomcat v11.0`
- Browse to your Tomcat installation directory → click `Finish`

**7. Deploy and Run**

- Right-click the project → `Run As` → `Run on Server`
- Select your Tomcat 11 server
- Click `Finish`
- Open your browser and navigate to:

```
http://localhost:8080/Nextgen_Voting_System/
```

---

## 🔄 How It Works

### 🎓 Student Registration & Login Flow

```
1. Student opens Registration Form
         (College ID + Email + Password)
                    ↓
2. OTP is automatically sent to the registered college email
                    ↓
3. Student enters OTP → Verified → Sets Password
                    ↓
4. Student logs in with College ID + Password
                    ↓
5. Student Dashboard → View Candidates → Cast Vote
```

### 🛠️ Admin Flow

```
1. Admin logs in with secure credentials
                    ↓
2. Admin Dashboard opens
                    ↓
      ┌──────────────────────────────────────┐
      │  Manage Students & Assign Classes    │
      │  Add / Remove Election Candidates    │
      │  Election Control (Start/Stop/Reset) │
      │  Set or Reset Student Passwords      │
      │  View Vote Counts & Results          │
      └──────────────────────────────────────┘
```

### 🔑 Forgot Password Flow

```
1. Student clicks "Forgot Password"
                    ↓
2. Enters College ID / Registered Email
                    ↓
3. OTP is sent to the registered email
                    ↓
4. Student enters and verifies OTP
                    ↓
5. Student sets a new password successfully
```

---

## 📸 Screenshots

> 🖼️ *Screenshots will be added soon. Contributions welcome!*

| Page | Preview |
|---|---|
| 🏠 Home Page | *Coming soon* |
| 🎓 Student Dashboard | *Coming soon* |
| 🛠️ Admin Dashboard | *Coming soon* |
| 🏅 View Candidates | *Coming soon* |
| 📊 Election Results | *Coming soon* |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

**1.** Fork the repository

**2.** Create your feature branch:
```bash
git checkout -b feature/your-feature-name
```

**3.** Commit your changes:
```bash
git commit -m "Add: your feature description"
```

**4.** Push to the branch:
```bash
git push origin feature/your-feature-name
```

**5.** Open a **Pull Request**

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Author
anurag , vinayak , kaustubh

<div align="center">

Built with ❤️ for secure and transparent college elections.

⭐ **If you found this project useful, please give it a star!** ⭐

*For any issues or suggestions, feel free to open an [issue](https://github.com/anuragshigwan69/Nextgen_Voting_System/issues).*

</div>
