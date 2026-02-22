<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    // 1️⃣ Session check
    if(session.getAttribute("studentId") == null){
        response.sendRedirect("index.jsp");
        return;
    }

    // 2️⃣ Election status check
    String electionStatus = "inactive";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/votingdb", "root", "root"
        );

        ps = con.prepareStatement(
            "SELECT status FROM election_status WHERE id=1"
        );
        rs = ps.executeQuery();

        if(rs.next()){
            electionStatus = rs.getString("status");
        }

    } catch(Exception e){
        e.printStackTrace();
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception e){}
        try { if(ps != null) ps.close(); } catch(Exception e){}
        try { if(con != null) con.close(); } catch(Exception e){}
    }

    // 3️⃣ Block access if election is NOT active
    if(!"active".equalsIgnoreCase(electionStatus)){
        response.sendRedirect("index.jsp?msg=Election has not started yet");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard | NextGen Voting System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #7c68ee 0%, #9b8ff3 50%, #bdb4f7 100%);
            min-height: 100vh;
            color: #1e293b;
            position: relative;
            overflow-x: hidden;
        }

        /* Background Pattern */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 30%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(255, 255, 255, 0.08) 0%, transparent 50%);
            pointer-events: none;
        }

        /* NAVBAR */
        .navbar {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 20px rgba(124, 104, 238, 0.15);
            padding: 18px 40px;
            position: relative;
            z-index: 100;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 20px;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar-brand i {
            font-size: 24px;
        }

        .logout-btn {
            background: rgba(239, 68, 68, 0.9);
            border: none;
            border-radius: 12px;
            padding: 10px 24px;
            font-weight: 600;
            color: #fff;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            background: rgba(220, 38, 38, 1);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
        }

        /* HEADER */
        .welcome-box {
            margin-top: 60px;
            margin-bottom: 50px;
            text-align: center;
            animation: fadeUp 0.8s ease;
            position: relative;
            z-index: 1;
        }

        .welcome-box h1 {
            font-weight: 700;
            font-size: 42px;
            color: #fff;
            margin-bottom: 12px;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        }

        .welcome-box p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 16px;
            font-weight: 500;
            line-height: 1.6;
        }

        .welcome-box strong {
            color: #fff;
            font-weight: 700;
        }

        /* VOTE CARDS */
        .vote-card {
            background: #fff;
            border-radius: 20px;
            padding: 40px 24px;
            text-align: center;
            height: 100%;
            transition: all 0.3s ease;
            box-shadow: 0 8px 24px rgba(124, 104, 238, 0.15);
            position: relative;
            overflow: hidden;
            cursor: pointer;
        }

        .vote-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 16px 40px rgba(124, 104, 238, 0.25);
        }

        /* Icon Container with Gradient Backgrounds */
        .icon-container {
            width: 80px;
            height: 80px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            transition: all 0.3s ease;
        }

        .vote-card:hover .icon-container {
            transform: scale(1.1) rotate(5deg);
        }

        .icon-container i {
            font-size: 36px;
            color: #fff;
        }

        /* Gradient Colors for Each Position */
        .gradient-purple { background: linear-gradient(135deg, #8b5cf6, #6366f1); }
        .gradient-pink { background: linear-gradient(135deg, #ec4899, #f472b6); }
        .gradient-cyan { background: linear-gradient(135deg, #06b6d4, #22d3ee); }
        .gradient-green { background: linear-gradient(135deg, #10b981, #34d399); }
        .gradient-orange { background: linear-gradient(135deg, #f59e0b, #fbbf24); }
        .gradient-red { background: linear-gradient(135deg, #ef4444, #f87171); }
        .gradient-teal { background: linear-gradient(135deg, #14b8a6, #2dd4bf); }
        .gradient-indigo { background: linear-gradient(135deg, #6366f1, #818cf8); }
        .gradient-blue { background: linear-gradient(135deg, #3b82f6, #60a5fa); }
        .gradient-lime { background: linear-gradient(135deg, #84cc16, #a3e635); }

        .vote-card h4 {
            font-weight: 600;
            font-size: 17px;
            color: #1e293b;
            margin-bottom: 8px;
        }

        .vote-card p {
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        /* Container */
        .positions-container {
            position: relative;
            z-index: 1;
            padding-bottom: 60px;
        }

        /* Footer */
        footer {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            font-size: 14px;
            color: rgba(255, 255, 255, 0.9);
            padding: 24px;
            position: relative;
            z-index: 1;
            font-weight: 500;
        }

        /* Animations */
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

        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                padding: 16px 24px;
            }

            .navbar-brand {
                font-size: 18px;
            }

            .welcome-box {
                margin-top: 40px;
                margin-bottom: 40px;
            }

            .welcome-box h1 {
                font-size: 32px;
            }

            .welcome-box p {
                font-size: 15px;
            }

            .vote-card {
                padding: 32px 20px;
            }

            .icon-container {
                width: 70px;
                height: 70px;
            }

            .icon-container i {
                font-size: 32px;
            }

            .vote-card h4 {
                font-size: 16px;
            }
        }

        @media (max-width: 576px) {
            .navbar-brand {
                font-size: 16px;
            }

            .navbar-brand i {
                font-size: 20px;
            }

            .logout-btn {
                padding: 8px 18px;
                font-size: 14px;
            }

            .welcome-box h1 {
                font-size: 28px;
            }

            .icon-container {
                width: 64px;
                height: 64px;
            }

            .icon-container i {
                font-size: 28px;
            }
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg">
    <span class="navbar-brand">
        <i class="bi bi-shield-check"></i>
        <span>NextGen Voting System</span>
    </span>

    <div class="ms-auto">
        <a href="logout.jsp" class="logout-btn">
            <i class="bi bi-box-arrow-right"></i>
            <span>Logout</span>
        </a>
    </div>
</nav>

<!-- HEADER -->
<div class="container welcome-box">
    <h1>Election is Live</h1>
    <p>
        Welcome, <strong><%= session.getAttribute("studentName") %></strong><br>
        Select a position below to cast your vote
    </p>
</div>

<!-- POSITIONS -->
<div class="container positions-container">
    <div class="row g-4 justify-content-center">

<%
    String[] positionNames = {
        "President","Vice President","General Secretary","Joint Secretary",
        "Creative Head","Media Head","Technical Head",
        "Cultural Secretary","Content Head","Treasurer"
    };

    int[] positionIds = {1,2,3,4,5,6,7,8,9,10};

    String[] icons = {
        "bi-award","bi-people","bi-journal-text","bi-clipboard-check",
        "bi-brush","bi-camera-video","bi-cpu",
        "bi-music-note-beamed","bi-pencil-square","bi-cash-coin"
    };

    String[] gradients = {
        "gradient-purple","gradient-pink","gradient-cyan","gradient-green",
        "gradient-orange","gradient-red","gradient-teal",
        "gradient-indigo","gradient-blue","gradient-lime"
    };

    for(int i=0;i<positionNames.length;i++){
%>

        <div class="col-lg-3 col-md-4 col-sm-6">
            <a href="viewCandidates.jsp?positionId=<%= positionIds[i] %>">
                <div class="vote-card">
                    <div class="icon-container <%= gradients[i] %>">
                        <i class="bi <%= icons[i] %>"></i>
                    </div>
                    <h4><%= positionNames[i] %></h4>
                    <p>Click to view candidates</p>
                </div>
            </a>
        </div>

<% } %>

    </div>
</div>

<footer>
    © 2025 NextGen Voting System | Secure College Elections
</footer>

</body>
</html>
