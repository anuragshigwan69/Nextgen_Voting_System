<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    if(session.getAttribute("adminId") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Results | Admin</title>
    <!-- Bootstrap, Icons, Fonts -->
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
            color: #1F2937;
            animation: gradientShift 15s ease infinite;
            background-size: 200% 200%;
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

        .content-wrapper {
            position: relative;
            z-index: 1;
        }

        /* Header Section */
        .header-section {
            text-align: center;
            margin: 40px 0 50px 0;
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header-section h2 {
            font-weight: 800;
            font-size: 3rem;
            color: #fff;
            margin-bottom: 15px;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .header-section h2 i {
            font-size: 3rem;
        }

        .header-section p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 1.2rem;
            font-weight: 400;
        }

        /* Container */
        .container-box {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Dashboard Cards */
        .dashboard-card {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 25px;
            padding: 45px 30px;
            text-align: center;
            height: 100%;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            opacity: 0;
            animation: cardFadeIn 0.6s ease forwards;
            text-decoration: none;
            display: block;
        }

        @keyframes cardFadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Staggered animation delay */
        .dashboard-card:nth-child(1) { animation-delay: 0.1s; }
        .dashboard-card:nth-child(2) { animation-delay: 0.15s; }
        .dashboard-card:nth-child(3) { animation-delay: 0.2s; }
        .dashboard-card:nth-child(4) { animation-delay: 0.25s; }
        .dashboard-card:nth-child(5) { animation-delay: 0.3s; }
        .dashboard-card:nth-child(6) { animation-delay: 0.35s; }
        .dashboard-card:nth-child(7) { animation-delay: 0.4s; }
        .dashboard-card:nth-child(8) { animation-delay: 0.45s; }
        .dashboard-card:nth-child(9) { animation-delay: 0.5s; }
        .dashboard-card:nth-child(10) { animation-delay: 0.55s; }

        /* Card Gradient Top Border */
        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .dashboard-card:hover::before {
            transform: scaleX(1);
        }

        /* Card Hover Effects */
        .dashboard-card:hover {
            transform: translateY(-15px) scale(1.03);
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.25);
        }

        /* Icon Wrapper */
        .icon-wrapper {
            width: 100px;
            height: 100px;
            margin: 0 auto 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            transition: all 0.3s ease;
            animation: floatIcon 4s ease-in-out infinite;
        }

        @keyframes floatIcon {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        .dashboard-card:hover .icon-wrapper {
            transform: rotateY(360deg) translateY(0);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6);
            animation: none;
        }

        .dashboard-card i {
            font-size: 48px;
            color: #fff;
        }

        /* Card Title */
        .dashboard-card h4 {
            font-weight: 700;
            font-size: 1.3rem;
            color: #1e293b;
            margin-top: 10px;
            margin-bottom: 15px;
            transition: color 0.3s ease;
        }

        .dashboard-card:hover h4 {
            color: #667eea;
        }

        /* Card Description */
        .dashboard-card p {
            font-size: 0.95rem;
            color: #6B7280;
            margin-bottom: 0;
            font-weight: 500;
        }

        /* Specific Icon Colors */
        .icon-wrapper.icon-purple {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .icon-wrapper.icon-pink {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .icon-wrapper.icon-blue {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .icon-wrapper.icon-green {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }

        .icon-wrapper.icon-orange {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        }

        .icon-wrapper.icon-red {
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
        }

        .icon-wrapper.icon-teal {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }

        .icon-wrapper.icon-indigo {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .icon-wrapper.icon-cyan {
            background: linear-gradient(135deg, #30cfd0 0%, #330867 100%);
        }

        .icon-wrapper.icon-yellow {
            background: linear-gradient(135deg, #fdbb2d 0%, #22c1c3 100%);
        }

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin: 60px auto 40px;
            background: rgba(255, 255, 255, 0.95);
            color: #667eea;
            padding: 14px 36px;
            border-radius: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            animation: fadeUp 1s ease forwards;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            font-size: 1rem;
            backdrop-filter: blur(10px);
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            transform: translateY(-3px);
            color: #fff;
            box-shadow: 0 12px 35px rgba(56, 239, 125, 0.4);
        }

        .back-btn i {
            font-size: 1.3rem;
        }

        .back-btn-container {
            text-align: center;
        }

        /* Error Message */
        .error-message {
            background: rgba(255, 255, 255, 0.95);
            color: #eb3349;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            margin: 20px auto;
            max-width: 600px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            font-weight: 600;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .header-section h2 {
                font-size: 2.5rem;
            }

            .header-section p {
                font-size: 1rem;
            }
        }

        @media (max-width: 768px) {
            .header-section h2 {
                font-size: 2rem;
                flex-direction: column;
                gap: 10px;
            }

            .header-section h2 i {
                font-size: 2.5rem;
            }

            .header-section p {
                font-size: 0.95rem;
            }

            .icon-wrapper {
                width: 85px;
                height: 85px;
            }

            .dashboard-card i {
                font-size: 42px;
            }

            .dashboard-card h4 {
                font-size: 1.1rem;
            }

            .dashboard-card {
                padding: 35px 25px;
            }
        }

        @media (max-width: 576px) {
            .header-section h2 {
                font-size: 1.6rem;
            }

            body {
                padding: 15px;
            }
        }

        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 10px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 5px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        }
    </style>
</head>

<body>
<div class="content-wrapper">
    <!-- Header Section -->
    <div class="header-section">
        <h2>
            <i class="bi bi-bar-chart-fill"></i>
            Election Results
        </h2>
        <p>Select a position to view detailed voting results</p>
    </div>

    <!-- Results Cards -->
    <div class="container container-box">
        <div class="row g-4 justify-content-center">

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/votingdb", "root", "root");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM positions");
        ResultSet rs = ps.executeQuery();

        String[] icons = {
            "bi-award", "bi-people", "bi-journal-text", "bi-clipboard-check",
            "bi-brush", "bi-camera-video", "bi-cpu",
            "bi-music-note-beamed", "bi-pencil-square", "bi-cash-coin"
        };

        String[] iconColors = {
            "icon-purple", "icon-pink", "icon-blue", "icon-green",
            "icon-orange", "icon-red", "icon-teal", "icon-indigo",
            "icon-cyan", "icon-yellow"
        };

        int iconIndex = 0;

        while(rs.next()) {
%>
        <div class="col-lg-3 col-md-4 col-sm-6">
            <a href="viewPositionResult.jsp?position_id=<%= rs.getInt("position_id") %>" class="dashboard-card">
                <div class="icon-wrapper <%= iconColors[iconIndex % iconColors.length] %>">
                    <i class="bi <%= icons[iconIndex % icons.length] %>"></i>
                </div>
                <h4><%= rs.getString("position_name") %></h4>
                <p><i class="bi bi-arrow-right-circle"></i> Click to view results</p>
            </a>
        </div>
<%
            iconIndex++;
        }

        rs.close();
        ps.close();
        con.close();
    } catch(Exception e) {
        out.println("<div class='error-message'><i class='bi bi-exclamation-triangle'></i> " + e.getMessage() + "</div>");
    }
%>

        </div>

        <!-- Back Button -->
        <div class="back-btn-container">
            <a href="adminDashboard.jsp" class="back-btn">
                <i class="bi bi-arrow-left-circle-fill"></i>
                Back to Dashboard
            </a>
        </div>
    </div>
</div>

</body>
</html>
