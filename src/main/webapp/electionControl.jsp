<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if(session.getAttribute("adminId") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String action = request.getParameter("action");
    String message = "";
    String messageType = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/votingdb", "root", "root");

        if(action != null) {
            if(action.equals("start")) {
                PreparedStatement ps = con.prepareStatement("UPDATE election_status SET status='active' WHERE id=1");
                ps.executeUpdate();
                message = "Election started successfully!";
                messageType = "success";
            } else if(action.equals("stop")) {
                PreparedStatement ps = con.prepareStatement("UPDATE election_status SET status='inactive' WHERE id=1");
                ps.executeUpdate();
                message = "Election stopped successfully!";
                messageType = "warning";
            } else if(action.equals("reset")) {
                PreparedStatement ps1 = con.prepareStatement("UPDATE election_status SET status='inactive' WHERE id=1");
                ps1.executeUpdate();
                PreparedStatement ps2 = con.prepareStatement("DELETE FROM votes");
                ps2.executeUpdate();
                message = "Election reset successfully! All votes cleared.";
                messageType = "danger";
            }
        }

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT status FROM election_status WHERE id=1");
        String currentStatus = rs.next() ? rs.getString("status") : "inactive";
        con.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Election Control | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
            color: #1f2d3d;
            animation: gradientShift 15s ease infinite;
            background-size: 200% 200%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Animated Background Particles */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 20% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
        }

        .control-box {
            max-width: 700px;
            width: 100%;
            background: rgba(255, 255, 255, 0.98);
            padding: 50px 45px;
            border-radius: 30px;
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.3);
            text-align: center;
            animation: fadeUp 0.8s ease forwards;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            z-index: 1;
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
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 30px;
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

        .title i {
            margin-right: 10px;
            font-size: 2.3rem;
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

        /* Status Display */
        .status-container {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 25px;
            border-radius: 20px;
            margin-bottom: 35px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .status-label {
            font-size: 1rem;
            color: #4a5568;
            margin-bottom: 10px;
            font-weight: 500;
        }

        .status-value {
            font-size: 1.8rem;
            font-weight: 700;
            padding: 10px 25px;
            border-radius: 12px;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .status-active {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(56, 239, 125, 0.4);
            animation: pulse 2s ease infinite;
        }

        .status-inactive {
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(235, 51, 73, 0.4);
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        /* Alert Messages */
        .alert-custom {
            border-radius: 15px;
            padding: 18px 25px;
            margin-bottom: 30px;
            border: none;
            font-weight: 500;
            animation: slideIn 0.5s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
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
        }

        .alert-warning {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .alert-danger {
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
            color: white;
        }

        .alert-custom i {
            font-size: 1.5rem;
        }

        /* Button Styling */
        .button-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 20px;
            margin-bottom: 35px;
        }

        .btn-main {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 15px;
            padding: 16px 28px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .btn-main::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.2);
            transition: left 0.5s ease;
        }

        .btn-main:hover::before {
            left: 100%;
        }

        .btn-main:hover {
            transform: translateY(-3px);
            color: white;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.6);
        }

        .btn-main i {
            font-size: 2.5rem;
        }

        .btn-main span {
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Button Specific Colors */
        .btn-start {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            box-shadow: 0 6px 20px rgba(56, 239, 125, 0.4);
        }

        .btn-start:hover {
            box-shadow: 0 10px 30px rgba(56, 239, 125, 0.6);
        }

        .btn-stop {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            box-shadow: 0 6px 20px rgba(245, 87, 108, 0.4);
        }

        .btn-stop:hover {
            box-shadow: 0 10px 30px rgba(245, 87, 108, 0.6);
        }

        .btn-reset {
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
            box-shadow: 0 6px 20px rgba(235, 51, 73, 0.4);
        }

        .btn-reset:hover {
            box-shadow: 0 10px 30px rgba(235, 51, 73, 0.6);
        }

        /* Warning Section for Reset */
        .warning-section {
            background: linear-gradient(135deg, #fff5f5 0%, #ffe5e5 100%);
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 25px;
            border-left: 5px solid #eb3349;
        }

        .warning-section h6 {
            color: #eb3349;
            font-weight: 700;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .warning-section p {
            color: #991b1b;
            font-size: 0.9rem;
            margin: 0;
        }

        /* Back Link */
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-top: 25px;
            font-weight: 600;
            color: #667eea;
            text-decoration: none;
            font-size: 1rem;
            padding: 10px 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            color: #764ba2;
            background: rgba(102, 126, 234, 0.1);
            transform: translateX(-5px);
        }

        .back-link i {
            font-size: 1.3rem;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .control-box {
                padding: 35px 25px;
            }

            .title {
                font-size: 2rem;
            }

            .title i {
                font-size: 1.8rem;
            }

            .status-value {
                font-size: 1.4rem;
            }

            .button-grid {
                grid-template-columns: 1fr;
            }

            .btn-main {
                padding: 18px 24px;
            }
        }

        @media (max-width: 576px) {
            .title {
                font-size: 1.6rem;
            }

            .btn-main i {
                font-size: 2rem;
            }
        }

        /* Confirmation Modal Styling */
        .confirmation-required {
            position: relative;
        }

        /* Loading State */
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>

    <script>
        function confirmAction(action) {
            if(action === 'reset') {
                return confirm('⚠️ WARNING: This will permanently delete all votes and stop the election. Are you sure?');
            } else if(action === 'stop') {
                return confirm('Are you sure you want to stop the election?');
            }
            return true;
        }
    </script>
</head>

<body>
<div class="control-box">
    <div class="title">
        <i class="bi bi-gear-fill"></i>
        Election Control Panel
    </div>

    <% if(!message.isEmpty()) { %>
        <div class="alert-custom alert-<%= messageType %>">
            <i class="bi bi-<%= messageType.equals("success") ? "check-circle-fill" : messageType.equals("warning") ? "exclamation-triangle-fill" : "x-circle-fill" %>"></i>
            <span><%= message %></span>
        </div>
    <% } %>

    <!-- Current Status Display -->
    <div class="status-container">
        <div class="status-label">
            <i class="bi bi-circle-fill"></i> Current Election Status
        </div>
        <div class="status-value <%= currentStatus.equals("active") ? "status-active" : "status-inactive" %>">
            <%= currentStatus.equals("active") ? "🟢 ACTIVE" : "🔴 INACTIVE" %>
        </div>
    </div>

    <!-- Control Buttons -->
    <div class="button-grid">
        <a href="electionControl.jsp?action=start" class="btn-main btn-start" onclick="return confirmAction('start');">
            <i class="bi bi-play-circle-fill"></i>
            <span>Start Election</span>
        </a>

        <a href="electionControl.jsp?action=stop" class="btn-main btn-stop" onclick="return confirmAction('stop');">
            <i class="bi bi-stop-circle-fill"></i>
            <span>Stop Election</span>
        </a>

        <a href="electionControl.jsp?action=reset" class="btn-main btn-reset" onclick="return confirmAction('reset');">
            <i class="bi bi-arrow-repeat"></i>
            <span>Reset Election</span>
        </a>
    </div>

    <!-- Warning Section -->
    <div class="warning-section">
        <h6>
            <i class="bi bi-exclamation-triangle-fill"></i>
            Important Notice
        </h6>
        <p>
            Resetting the election will permanently delete all votes and cannot be undone. Please use with caution!
        </p>
    </div>

    <a href="adminDashboard.jsp" class="back-link">
        <i class="bi bi-arrow-left-circle-fill"></i>
        Back to Dashboard
    </a>
</div>
</body>
</html>

<%
    } catch(Exception e){
        out.println("<div style='color:red; text-align:center; padding: 20px; background: white; border-radius: 15px; margin: 20px;'><i class='bi bi-exclamation-circle'></i> Error: " + e.getMessage() + "</div>");
    }
%>
