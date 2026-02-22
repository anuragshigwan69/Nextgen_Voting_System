<%@ page import="java.sql.*" %>
<%@ include file="dbTest.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    if(session.getAttribute("adminId") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String studentClass = request.getParameter("class");
    String division = request.getParameter("division");

    PreparedStatement ps = null;
    int rowsAffected = 0;
    String message = null;

    if(studentClass != null && division != null && "true".equals(request.getParameter("confirmed"))){
        try{
            String sql = "DELETE FROM students WHERE class = ? AND division = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, studentClass);
            ps.setString(2, division);
            rowsAffected = ps.executeUpdate();

            if(rowsAffected > 0){
                message = rowsAffected + " student(s) removed from " + studentClass + " - Division " + division;
                // ✅ Only redirect if something was actually deleted
                session.setAttribute("removeClassMessage", message);
                response.sendRedirect("viewStudents.jsp?class=" + studentClass + "&division=" + division);
                return;
            } else {
                // ✅ No students found, stay on this page
                message = "No students found for " + studentClass + " - Division " + division;
            }
        }catch(Exception e){
            message = "Error: " + e.getMessage();
        }finally{
            try{ if(ps != null) ps.close(); }catch(Exception e){}
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Confirm Remove Class | NextGen Voting System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        body {
            font-family:'Poppins',sans-serif;
            background: linear-gradient(135deg,#fdfbfb,#ebedee);
            min-height:100vh;
            display:flex;
            align-items:center;
            justify-content:center;
            animation: fadeInBody 1s ease-in;
        }
        .form-box {
            background:#fff;
            border-radius:25px;
            padding:40px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            width:100%;
            max-width:600px;
            animation: fadeUp 0.9s ease forwards;
        }
        .title {
            font-weight:700;
            font-size:1.8rem;
            margin-bottom:25px;
            text-align:center;
            background: linear-gradient(90deg,#ef4444,#9333ea);
            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;
            animation: slideDown 0.8s ease;
        }
        .btn-danger, .btn-secondary {
            border-radius:30px;
            font-weight:600;
            transition:0.3s;
        }
        .btn-danger:hover {
            background:#dc2626;
            transform:scale(1.05);
            box-shadow:0 8px 20px rgba(239,68,68,0.35);
        }
        .btn-secondary:hover {
            background:#64748b;
            transform:scale(1.05);
            color:#fff;
        }
        @keyframes fadeInBody { from {opacity:0;} to {opacity:1;} }
        @keyframes slideDown { from {opacity:0; transform:translateY(-20px);} to {opacity:1; transform:translateY(0);} }
        @keyframes fadeUp { from {opacity:0; transform:translateY(30px);} to {opacity:1; transform:translateY(0);} }
    </style>

    <script>
        function doubleConfirm(className, division) {
            if(confirm("Are you sure you want to remove Class " + className + " - Division " + division + "?")) {
                return confirm("⚠️ This will delete ALL students in " + className + " - Division " + division + ". Confirm again?");
            }
            return false;
        }
    </script>
</head>
<body>
<div class="form-box">
    <h3 class="title">Confirm Remove Class</h3>

    <% if(studentClass != null && division != null){ %>
        <% if(message != null && rowsAffected == 0){ %>
            <!-- Show info alert if no students found -->
            <div class="alert alert-info text-center">
                <i class="bi bi-info-circle"></i> <%= message %>
            </div>
            <div class="text-center mt-3">
                <a href="viewStudents.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left-circle"></i> Back to Students</a>
            </div>
        <% } else { %>
            <!-- Normal confirmation form -->
            <form method="post" onsubmit="return doubleConfirm('<%= studentClass %>', '<%= division %>');">
                <input type="hidden" name="class" value="<%= studentClass %>">
                <input type="hidden" name="division" value="<%= division %>">
                <input type="hidden" name="confirmed" value="true">
                <div class="alert alert-warning text-center">
                    <i class="bi bi-exclamation-triangle"></i> You are about to remove <strong><%= studentClass %> - Division <%= division %></strong>.
                </div>
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-danger btn-lg px-4"><i class="bi bi-trash"></i> Confirm Remove Class</button>
                    <a href="viewStudents.jsp?class=<%= studentClass %>&division=<%= division %>" class="btn btn-secondary btn-lg px-4 ms-3"><i class="bi bi-x-circle"></i> Cancel</a>
                </div>
            </form>
        <% } %>
    <% } else { %>
        <div class="alert alert-info text-center"><i class="bi bi-info-circle"></i> No class/division specified. Please go back and try again.</div>
        <div class="text-center mt-3">
            <a href="viewStudents.jsp" class="btn btn-secondary"><i class="bi bi-arrow-left-circle"></i> Back to Students</a>
        </div>
    <% } %>
</div>
</body>
</html>
