<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
if(session.getAttribute("adminId") == null){
    response.sendRedirect("adminLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | NextGen Voting System</title>

    <!-- Bootstrap -->
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

        /* NAVBAR */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            padding: 20px 40px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.3);
            animation: slideDown 0.6s ease;
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

        .navbar-brand {
            font-weight: 800;
            font-size: 24px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .navbar-brand i {
            font-size: 28px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        /* LOGOUT BUTTON */
        .logout-btn {
            background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
            color: #fff;
            border-radius: 12px;
            padding: 10px 24px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(235, 51, 73, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            background: linear-gradient(135deg, #f45c43 0%, #eb3349 100%);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(235, 51, 73, 0.5);
        }

        .logout-btn i {
            font-size: 16px;
        }

        /* HEADER */
        .welcome-section {
            text-align: center;
            margin: 50px 0 40px 0;
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

        .welcome-section h2 {
            font-weight: 800;
            font-size: 2.8rem;
            color: #fff;
            margin-bottom: 12px;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }

        .welcome-section p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 1.2rem;
            font-weight: 400;
        }

        /* DASHBOARD CARDS */
        .dashboard-container {
            padding: 0 20px 60px 20px;
        }

        .card-box {
            background: rgba(255, 255, 255, 0.98);
            border-radius: 25px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            height: 100%;
            border: 1px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .card-box::before {
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

        .card-box:hover::before {
            transform: scaleX(1);
        }

        .card-box:hover {
            transform: translateY(-12px) scale(1.02);
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.25);
        }

        /* Card Animation on Load */
        .card-box {
            animation: cardFadeIn 0.6s ease forwards;
            opacity: 0;
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

        .card-box:nth-child(1) { animation-delay: 0.1s; }
        .card-box:nth-child(2) { animation-delay: 0.2s; }
        .card-box:nth-child(3) { animation-delay: 0.3s; }
        .card-box:nth-child(4) { animation-delay: 0.4s; }

        .card-icon-wrapper {
            width: 90px;
            height: 90px;
            margin: 0 auto 25px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            transition: all 0.3s ease;
            position: relative;
        }

        .card-box:hover .card-icon-wrapper {
            transform: rotateY(360deg);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.6);
        }

        .card-icon {
            font-size: 42px;
            color: #fff;
        }

        .card-title {
            font-size: 22px;
            font-weight: 700;
            color: #1F2937;
            margin-bottom: 12px;
        }

        .card-text {
            font-size: 14px;
            color: #6B7280;
            margin-bottom: 25px;
            line-height: 1.6;
            min-height: 42px;
        }

        /* ACTION BUTTON */
        .action-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            border: none;
            border-radius: 12px;
            padding: 12px 32px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-block;
            font-size: 14px;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .action-btn:hover {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            transform: translateY(-2px);
            color: #fff;
            box-shadow: 0 10px 30px rgba(56, 239, 125, 0.5);
        }

        /* Specific Card Color Themes */
        .card-box:nth-child(1) .card-icon-wrapper {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .card-box:nth-child(2) .card-icon-wrapper {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .card-box:nth-child(3) .card-icon-wrapper {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .card-box:nth-child(4) .card-icon-wrapper {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }

        /* Responsive Grid */
        .row.g-4 {
            row-gap: 30px;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .welcome-section h2 {
                font-size: 2.2rem;
            }

            .welcome-section p {
                font-size: 1rem;
            }

            .card-box {
                margin-bottom: 20px;
            }
        }

        @media (max-width: 768px) {
            .navbar {
                padding: 15px 20px;
                flex-direction: column;
                gap: 15px;
            }

            .navbar-brand {
                font-size: 20px;
            }

            .welcome-section h2 {
                font-size: 1.8rem;
            }

            .welcome-section p {
                font-size: 0.95rem;
            }

            .card-icon-wrapper {
                width: 75px;
                height: 75px;
            }

            .card-icon {
                font-size: 36px;
            }

            .card-title {
                font-size: 20px;
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

        /* Footer Section */
        .dashboard-footer {
            text-align: center;
            padding: 30px 0;
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
        }

        /* Badge for Active Status */
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            background: rgba(16, 185, 129, 0.2);
            color: #10B981;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 10px;
        }
    </style>
</head>

<body>
<div class="content-wrapper">
    <!-- NAVBAR -->
    <nav class="navbar d-flex justify-content-between align-items-center">
        <span class="navbar-brand">
            <i class="bi bi-shield-check"></i>
            NextGen Voting System
        </span>

        <!-- Logout Button -->
        <a href="adminLogout.jsp" class="logout-btn">
            <i class="bi bi-box-arrow-right"></i> Logout
        </a>
    </nav>

    <!-- HEADER -->
    <div class="welcome-section">
        <h2>Welcome Back, <%= session.getAttribute("adminUser") %> 👋</h2>
        <p>Manage elections, candidates and results with ease</p>
    </div>

    <!-- DASHBOARD CARDS -->
    <div class="container dashboard-container">
        <div class="row g-4">

            <div class="col-lg-3 col-md-6">
                <div class="card-box">
                    <div class="card-icon-wrapper">
                        <i class="bi bi-person-plus card-icon"></i>
                    </div>
                    <div class="card-title">Add Candidate</div>
                    <div class="card-text">
                        Add new candidates for election positions.
                    </div>
                    <a href="addCandidate.jsp" class="action-btn">
                        Add Candidate
                    </a>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card-box">
                    <div class="card-icon-wrapper">
                        <i class="bi bi-bar-chart-line card-icon"></i>
                    </div>
                    <div class="card-title">View Results</div>
                    <div class="card-text">
                        View live election results and vote count.
                    </div>
                    <a href="viewResults.jsp" class="action-btn">
                        View Results
                    </a>
                </div>
            </div>

            <div class="col-lg-3 col-md-6">
                <div class="card-box">
                    <div class="card-icon-wrapper">
                        <i class="bi bi-shield-lock card-icon"></i>
                    </div>
                    <div class="card-title">Election Control</div>
                    <div class="card-text">
                        Start or stop the election securely.
                    </div>
                    <a href="electionControl.jsp" class="action-btn">
                        Manage Election
                    </a>
                </div>
            </div>

            <!-- View Students Card -->
            <div class="col-lg-3 col-md-6">
                <div class="card-box">
                    <div class="card-icon-wrapper">
                        <i class="bi bi-people card-icon"></i>
                    </div>
                    <div class="card-title">View Students</div>
                    <div class="card-text">
                        Browse student list by class and division.
                    </div>
                    <a href="viewStudents.jsp" class="action-btn">
                        View Students
                    </a>
                </div>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <div class="dashboard-footer">
        <p>© 2026 NextGen Voting System. All rights reserved.</p>
    </div>
</div>

</body>
</html>
