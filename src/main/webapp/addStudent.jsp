<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.util.Base64" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("adminId") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String success = "";
    String error = "";

    if("POST".equalsIgnoreCase(request.getMethod())){
        String name = request.getParameter("name");
        String zprn = request.getParameter("zprn");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String usePassword = request.getParameter("usePassword");
        String studentClass = request.getParameter("class");
        String division = request.getParameter("division");

        Connection con = null;
        PreparedStatement ps = null;

        try{
            String hashedPassword = null;
            if("on".equals(usePassword) && password != null && !password.trim().isEmpty()){
                MessageDigest md = MessageDigest.getInstance("SHA-256");
                byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
                hashedPassword = Base64.getEncoder().encodeToString(hashBytes);
            }

            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/votingdb","root","root");

            String sql = "INSERT INTO students (name, zprn, email, password, class, division) VALUES (?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, zprn);
            ps.setString(3, email);
            ps.setString(4, hashedPassword);
            ps.setString(5, studentClass);
            ps.setString(6, division);

            int i = ps.executeUpdate();
            if(i > 0){
                success = (hashedPassword == null) ? "Student added successfully! (No password set)" : "Student added successfully!";
            } else {
                error = "Failed to add student!";
            }

        }catch(SQLIntegrityConstraintViolationException e){
            error = "ZPRN already exists!";
        }catch(Exception e){
            error = "Error: " + e.getMessage();
        }finally{
            try{ if(ps != null) ps.close(); }catch(Exception e){}
            try{ if(con != null) con.close(); }catch(Exception e){}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Student | NextGen Voting System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            animation: gradientShift 15s ease infinite;
            background-size: 200% 200%;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .form-box {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 30px;
            padding: 45px;
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 550px;
            animation: fadeUp 0.8s ease forwards;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(40px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .title {
            font-weight: 700;
            font-size: 2.2rem;
            margin-bottom: 30px;
            text-align: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            animation: slideDown 0.8s ease;
            position: relative;
            padding-bottom: 15px;
        }

        .title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
        }

        .title i {
            margin-right: 10px;
            font-size: 2rem;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Form Styling */
        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .form-label i {
            color: #667eea;
        }

        .form-control, .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #f8fafc;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            outline: none;
            background-color: white;
        }

        .form-control:hover, .form-select:hover {
            border-color: #cbd5e0;
            background-color: white;
        }

        /* Switch Styling */
        .form-check-input {
            width: 3em;
            height: 1.5em;
            cursor: pointer;
            border: 2px solid #cbd5e0;
            transition: all 0.3s ease;
        }

        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }

        .form-check-input:focus {
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.15);
        }
.form-switch {
    padding-left: -1.0em; /* aligns switch properly */
}

.form-switch .form-check-input {
    margin-left: 1.0em;
}

        .form-check-label {
            font-weight: 500;
            color: #4a5568;
            margin-left: 8px;
        }

        .form-check {
            padding-left: 0;
            display: flex;
            align-items: center;
        }

        /* Button Styling */
        .btn-custom {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 14px 24px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-custom:hover {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(56, 239, 125, 0.5);
        }

        .btn-custom:active {
            transform: translateY(-1px);
        }

        .btn-custom i {
            margin-right: 8px;
        }

        /* Back Link */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: #667eea;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            padding: 8px 16px;
            border-radius: 8px;
        }

        .back-link:hover {
            color: #764ba2;
            background: rgba(102, 126, 234, 0.1);
            transform: translateX(-5px);
        }

        .back-link i {
            font-size: 1.2rem;
        }

        /* Alert Styling */
        .alert {
            border-radius: 15px;
            text-align: center;
            border: none;
            padding: 16px 20px;
            font-weight: 500;
            margin-bottom: 25px;
            animation: slideIn 0.5s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(56, 239, 125, 0.4);
        }

        .alert-danger {
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(235, 51, 73, 0.4);
        }

        .alert i {
            font-size: 1.3rem;
        }

        /* Input Group Icons */
        .input-icon-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 1.1rem;
        }

        .input-with-icon {
            padding-left: 45px;
        }

        /* Small Text */
        .text-muted {
            font-size: 0.85rem;
            color: #718096;
            margin-top: 6px;
            display: block;
        }

        .mb-3 {
            margin-bottom: 1.5rem;
        }

        /* Password Field Disabled State */
        .form-control:disabled {
            background-color: #e2e8f0;
            cursor: not-allowed;
            opacity: 0.6;
        }

        /* Responsive Design */
        @media (max-width: 576px) {
            .form-box {
                padding: 30px 25px;
            }

            .title {
                font-size: 1.8rem;
            }

            .title i {
                font-size: 1.6rem;
            }
        }

        /* Password Field Container */
        .password-section {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 1.5rem;
        }

        .password-section .form-label {
            margin-bottom: 12px;
        }

        /* Smooth Transitions */
        * {
            transition: background-color 0.3s ease;
        }

        /* Loading Animation for Submit */
        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        .btn-custom.loading::after {
            content: '';
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: spin 0.6s linear infinite;
        }
    </style>
</head>

<body>
<div class="form-box">
    <h3 class="title"><i class="bi bi-person-plus-fill"></i>Add Student</h3>

    <% if(!success.isEmpty()){ %>
        <div class="alert alert-success">
            <i class="bi bi-check-circle-fill"></i>
            <span><%= success %></span>
        </div>
    <% } %>
    <% if(!error.isEmpty()){ %>
        <div class="alert alert-danger">
            <i class="bi bi-exclamation-triangle-fill"></i>
            <span><%= error %></span>
        </div>
    <% } %>

    <form method="post">
        <div class="mb-3">
            <label class="form-label">
                <i class="bi bi-person-badge"></i>
                Student Name
            </label>
            <input type="text" name="name" class="form-control" placeholder="Enter full name" required>
        </div>

        <div class="mb-3">
            <label class="form-label">
                <i class="bi bi-credit-card-2-front"></i>
                ZPRN
            </label>
            <input type="text" name="zprn" class="form-control" placeholder="Enter ZPRN number" required>
        </div>

        <div class="mb-3">
            <label class="form-label">
                <i class="bi bi-envelope"></i>
                Email
            </label>
            <input type="email" name="email" class="form-control" placeholder="student@example.com" required>
        </div>

        <div class="mb-3">
            <label class="form-label">
                <i class="bi bi-bookmark"></i>
                Class
            </label>
            <select name="class" class="form-select" required>
                <option value="" disabled selected>Select Class</option>
                <option value="First Year">First Year</option>
                <option value="Second Year">Second Year</option>
                <option value="Third Year">Third Year</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">
                <i class="bi bi-grid-3x3"></i>
                Division
            </label>
            <select name="division" class="form-select" required>
                <option value="" disabled selected>Select Division</option>
                <option value="A">Division A</option>
                <option value="B">Division B</option>
                <option value="C">Division C</option>
                <option value="D">Division D</option>
            </select>
        </div>

        <div class="password-section">
            <label class="form-label">
                <i class="bi bi-key"></i>
                Password Settings
            </label>
            <div class="form-check form-switch mb-3">
                <input class="form-check-input" type="checkbox" id="usePassword" name="usePassword" checked onchange="togglePassword()">
                <label class="form-check-label" for="usePassword">Enable Password Protection</label>
            </div>
            <input type="password" id="password" name="password" class="form-control" placeholder="Enter secure password">
            <small class="text-muted">
                <i class="bi bi-info-circle"></i> Turn off the switch if you don't want to set a password for this student.
            </small>
        </div>

        <button type="submit" class="btn btn-custom w-100">
            <i class="bi bi-person-plus"></i> Add Student
        </button>

        <div class="text-center mt-4">
            <a href="viewStudents.jsp" class="back-link">
                <i class="bi bi-arrow-left-circle-fill"></i>
                Back to Dashboard
            </a>
        </div>
    </form>
</div>

<script>
function togglePassword(){
    const checkbox = document.getElementById("usePassword");
    const passwordField = document.getElementById("password");
    passwordField.disabled = !checkbox.checked;
    if(!checkbox.checked){
        passwordField.value = "";
    }
}
</script>
</body>
</html>
