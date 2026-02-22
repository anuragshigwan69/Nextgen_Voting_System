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
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Students | NextGen Voting System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

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
            padding: 20px 0;
            animation: gradientShift 15s ease infinite;
            background-size: 200% 200%;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .container {
            max-width: 1200px;
        }

        .form-box {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 30px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: fadeUp 0.8s ease forwards;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .title {
            font-weight: 700;
            font-size: 2.5rem;
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
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
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

        /* Enhanced Form Styling */
        .filter-section {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-select {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: white;
        }

        .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        /* Enhanced Button Styling */
        .btn {
            border-radius: 12px;
            padding: 12px 28px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }

        .btn-success {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(56, 239, 125, 0.4);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(56, 239, 125, 0.6);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #3a3a52 0%, #5b5b76 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(58, 58, 82, 0.4);
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(58, 58, 82, 0.6);
        }

        .btn-warning {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(245, 87, 108, 0.4);
            border: none;
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(245, 87, 108, 0.6);
        }

        .btn-danger {
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
            color: white;
            box-shadow: 0 3px 10px rgba(235, 51, 73, 0.4);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(235, 51, 73, 0.6);
        }

        /* Table Styling */
        .table-container {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            margin-top: 25px;
        }

        .table-header {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 20px;
            border-radius: 20px 20px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }

        .table-header h5 {
            margin: 0;
            font-weight: 600;
            color: #2d3748;
            font-size: 1.2rem;
        }

        table {
            width: 100%;
            margin: 0;
        }

        table thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        table thead th {
            padding: 18px 15px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            border: none;
        }

        table tbody td {
            padding: 16px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #e2e8f0;
            color: #4a5568;
            font-size: 0.95rem;
        }

        table tbody tr {
            transition: all 0.3s ease;
        }

        table tbody tr:hover {
            background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
            transform: scale(1.01);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Action Buttons Container */
        .action-buttons {
            margin-top: 35px;
            padding-top: 25px;
            border-top: 2px solid #e2e8f0;
        }

        /* Alert Styling */
        .alert {
            border-radius: 15px;
            padding: 15px 20px;
            border: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .alert-danger {
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
            color: white;
        }

        /* No Data Message */
        .no-data-message {
            padding: 60px 20px;
            text-align: center;
        }

        .no-data-message i {
            font-size: 4rem;
            color: #cbd5e0;
            margin-bottom: 15px;
        }

        .no-data-message p {
            color: #718096;
            font-size: 1.1rem;
            margin: 0;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .form-box {
                padding: 25px;
            }

            .title {
                font-size: 2rem;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                font-size: 0.85rem;
            }

            .btn {
                width: 100%;
                margin-bottom: 10px;
            }

            .action-buttons .d-flex {
                flex-direction: column;
            }
        }

        /* Icon Styling */
        .btn i {
            margin-right: 6px;
        }

        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Loading Animation */
        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.5;
            }
        }
    </style>
    <script>
        function confirmDelete(zprn) {
            return confirm("Are you sure you want to remove student with ZPRN " + zprn + "?");
        }
    </script>
</head>
<body>

<div class="container mt-5">
    <div class="form-box">
        <h3 class="title"><i class="bi bi-people-fill"></i> View Students</h3>

        <!-- Filter Form -->
        <div class="filter-section">
            <form method="get" class="row g-3">
                <div class="col-md-6">
                    <label class="form-label"><i class="bi bi-bookmark-fill"></i> Class</label>
                    <select name="class" class="form-select" required>
                        <option value="" disabled <%= (studentClass == null) ? "selected" : "" %>>Select Class</option>
                        <option value="First Year" <%= "First Year".equals(studentClass) ? "selected" : "" %>>First Year</option>
                        <option value="Second Year" <%= "Second Year".equals(studentClass) ? "selected" : "" %>>Second Year</option>
                        <option value="Third Year" <%= "Third Year".equals(studentClass) ? "selected" : "" %>>Third Year</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label"><i class="bi bi-grid-3x3-gap-fill"></i> Division</label>
                    <select name="division" class="form-select" required>
                        <option value="" disabled <%= (division == null) ? "selected" : "" %>>Select Division</option>
                        <option value="A" <%= "A".equals(division) ? "selected" : "" %>>Division A</option>
                        <option value="B" <%= "B".equals(division) ? "selected" : "" %>>Division B</option>
                        <option value="C" <%= "C".equals(division) ? "selected" : "" %>>Division C</option>
                        <option value="D" <%= "D".equals(division) ? "selected" : "" %>>Division D</option>
                    </select>
                </div>
                <div class="col-12 text-center">
                    <button type="submit" class="btn btn-primary btn-lg px-5">
                        <i class="bi bi-search"></i> View Students
                    </button>
                </div>
            </form>
        </div>

        <!-- Student Table -->
        <%
            if(studentClass != null && division != null){
                try{
                    String sql = "SELECT * FROM students WHERE class = ? AND division = ?";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, studentClass);
                    ps.setString(2, division);
                    rs = ps.executeQuery();
        %>
        <div class="table-container">
            <div class="table-header">
                <h5><i class="bi bi-list-ul"></i> Showing Students: <%= studentClass %> - Division <%= division %></h5>
                <a href="removeClass.jsp?class=<%= studentClass %>&division=<%= division %>" class="btn btn-warning btn-sm">
                    <i class="bi bi-exclamation-triangle"></i> Remove Entire Class
                </a>
            </div>
            <table class="table table-hover mb-0 text-center">
                <thead>
                    <tr>
                        <th><i class="bi bi-person-badge"></i> Name</th>
                        <th><i class="bi bi-credit-card-2-front"></i> ZPRN</th>
                        <th><i class="bi bi-bookmark"></i> Class</th>
                        <th><i class="bi bi-grid-3x3"></i> Division</th>
                        <th><i class="bi bi-gear"></i> Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        boolean hasData = false;
                        while(rs.next()){
                            hasData = true;
                            String zprn = rs.getString("zprn");
                    %>
                    <tr>
                        <td><strong><%= rs.getString("name") %></strong></td>
                        <td><%= zprn %></td>
                        <td><%= rs.getString("class") %></td>
                        <td><%= rs.getString("division") %></td>
                        <td>
                            <form method="post" action="removeStudent.jsp" onsubmit="return confirmDelete('<%= zprn %>');" style="margin: 0;">
                                <input type="hidden" name="zprn" value="<%= zprn %>">
                                <button type="submit" class="btn btn-sm btn-danger">
                                    <i class="bi bi-trash"></i> Remove
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                        if(!hasData){
                    %>
                    <tr>
                        <td colspan="5">
                            <div class="no-data-message">
                                <i class="bi bi-inbox"></i>
                                <p>No students found for this filter.</p>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <%
                }catch(Exception e){
                    out.println("<div class='alert alert-danger mt-3'><i class='bi bi-exclamation-triangle'></i> Error: " + e.getMessage() + "</div>");
                }finally{
                    try{ if(rs != null) rs.close(); }catch(Exception e){}
                    try{ if(ps != null) ps.close(); }catch(Exception e){}
                }
            }
        %>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <div class="d-flex justify-content-center flex-wrap gap-3">
                <a href="adminDashboard.jsp" class="btn btn-secondary btn-lg px-4">
                    <i class="bi bi-arrow-left-circle"></i> Back to Dashboard
                </a>
                <a href="addStudent.jsp" class="btn btn-success btn-lg px-4">
                    <i class="bi bi-person-plus"></i> Add Student
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
