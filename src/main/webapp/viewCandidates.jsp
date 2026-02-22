<%@ page import="java.sql.*" %>

<%
    if(session.getAttribute("studentId") == null){
        response.sendRedirect("index.jsp");
        return;
    }

    String pid = request.getParameter("positionId");
    if(pid == null){
        out.println("<h3 style='color:red'>Position not selected!</h3>");
        return;
    }

    int positionId = Integer.parseInt(pid);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Choose Candidate | NextGen Voting System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

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
            color: #1f2d3d;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated Background Pattern */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 30%, rgba(255, 255, 255, 0.12) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            pointer-events: none;
            animation: pulseBackground 15s ease-in-out infinite;
        }

        @keyframes pulseBackground {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.8; }
        }

        /* Floating Particles */
        .floating-particles {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 1;
        }

        .particle {
            position: absolute;
            width: 6px;
            height: 6px;
            background: rgba(255, 255, 255, 0.4);
            border-radius: 50%;
            animation: float 20s infinite ease-in-out;
        }

        .particle:nth-child(1) { top: 10%; left: 10%; animation-delay: 0s; animation-duration: 18s; }
        .particle:nth-child(2) { top: 20%; left: 80%; animation-delay: 2s; animation-duration: 22s; }
        .particle:nth-child(3) { top: 70%; left: 20%; animation-delay: 4s; animation-duration: 20s; }
        .particle:nth-child(4) { top: 80%; left: 70%; animation-delay: 1s; animation-duration: 19s; }
        .particle:nth-child(5) { top: 40%; left: 50%; animation-delay: 3s; animation-duration: 21s; }
        .particle:nth-child(6) { top: 60%; left: 90%; animation-delay: 5s; animation-duration: 17s; }

        @keyframes float {
            0%, 100% { 
                transform: translateY(0) translateX(0) scale(1);
                opacity: 0.3;
            }
            25% {
                transform: translateY(-30px) translateX(20px) scale(1.2);
                opacity: 0.6;
            }
            50% { 
                transform: translateY(-60px) translateX(-10px) scale(1);
                opacity: 0.8;
            }
            75% {
                transform: translateY(-30px) translateX(-20px) scale(1.1);
                opacity: 0.5;
            }
        }

        /* NAVBAR */
        .navbar {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(25px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.25);
            padding: 18px 40px;
            box-shadow: 0 4px 30px rgba(124, 104, 238, 0.2);
            position: relative;
            z-index: 100;
        }

        .navbar::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 20px;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 10px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand i {
            font-size: 24px;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        .nav-btn {
            background: rgba(255, 255, 255, 0.25);
            color: white;
            border-radius: 12px;
            padding: 10px 24px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .nav-btn:hover {
            background: rgba(255, 255, 255, 0.35);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.25);
        }

        /* HEADER */
        .page-title {
            text-align: center;
            margin-top: 50px;
            margin-bottom: 45px;
            position: relative;
            z-index: 10;
            animation: fadeDown 0.6s ease;
        }

        @keyframes fadeDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .page-title h2 {
            font-weight: 700;
            font-size: 38px;
            color: #fff;
            margin-bottom: 10px;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            position: relative;
            display: inline-block;
        }

        .page-title h2::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.8), transparent);
            border-radius: 2px;
        }

        .page-title p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 16px;
            font-weight: 500;
        }

        /* CANDIDATES CONTAINER */
        .candidates-container {
            position: relative;
            z-index: 10;
            padding-bottom: 40px;
        }

        /* CARD - FIXED HEIGHT WITH FLEXBOX */
        .card {
            background: #fff;
            border: none;
            border-radius: 24px;
            padding: 28px;
            box-shadow: 0 8px 30px rgba(124, 104, 238, 0.18);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            height: 100%;
            animation: fadeUp 0.6s ease backwards;
            position: relative;
            overflow: hidden;
            
            /* CRITICAL FIX: Use flexbox to keep button at bottom */
            display: flex;
            flex-direction: column;
        }

        /* Decorative gradient border */
        .card::before {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: 24px;
            padding: 2px;
            background: linear-gradient(135deg, rgba(124, 104, 238, 0.3), rgba(155, 143, 243, 0.3));
            -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .card:hover::before {
            opacity: 1;
        }

        .card:hover {
            transform: translateY(-12px) scale(1.02);
            box-shadow: 0 20px 50px rgba(124, 104, 238, 0.3);
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

        /* Stagger animation for cards */
        .col-md-4:nth-child(1) .card { animation-delay: 0.1s; }
        .col-md-4:nth-child(2) .card { animation-delay: 0.2s; }
        .col-md-4:nth-child(3) .card { animation-delay: 0.3s; }
        .col-md-4:nth-child(4) .card { animation-delay: 0.4s; }
        .col-md-4:nth-child(5) .card { animation-delay: 0.5s; }
        .col-md-4:nth-child(6) .card { animation-delay: 0.6s; }

        /* IMAGE */
        .img-box {
            width: 100%;
            height: 280px;
            overflow: hidden;
            border-radius: 18px;
            margin-bottom: 20px;
            background: linear-gradient(135deg, #f3f4f6, #e5e7eb);
            position: relative;
            flex-shrink: 0;
        }

        .img-box::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(180deg, transparent 60%, rgba(0, 0, 0, 0.1));
            pointer-events: none;
        }

        /* Shimmer effect */
        .img-box::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                45deg,
                transparent 30%,
                rgba(255, 255, 255, 0.3) 50%,
                transparent 70%
            );
            transform: rotate(45deg);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        .img-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .card:hover .img-box img {
            transform: scale(1.1) rotate(2deg);
        }

        /* CONTENT AREA - GROWS TO FILL SPACE */
        .card-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        /* TEXT */
        .candidate-name {
            font-weight: 700;
            font-size: 20px;
            color: #1e293b;
            margin-bottom: 8px;
        }

        .candidate-desc {
            font-size: 14px;
            color: #64748b;
            line-height: 1.6;
            margin-bottom: 20px;
            font-weight: 500;
            flex-grow: 1; /* Pushes button to bottom */
        }

        /* BUTTON FORM - STAYS AT BOTTOM */
        .vote-form {
            margin-top: auto; /* Always sticks to bottom */
        }

        /* BUTTON */
        .vote-btn {
            background: linear-gradient(135deg, #7c68ee, #9b8ff3);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 14px;
            font-weight: 700;
            font-size: 15px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(124, 104, 238, 0.35);
            cursor: pointer;
            letter-spacing: 0.3px;
            position: relative;
            overflow: hidden;
        }

        /* Button shine effect */
        .vote-btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s ease, height 0.6s ease;
        }

        .vote-btn:hover::before {
            width: 300px;
            height: 300px;
        }

        .vote-btn:hover {
            background: linear-gradient(135deg, #6854d9, #8b7bef);
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(124, 104, 238, 0.5);
        }

        .vote-btn:active {
            transform: translateY(-1px);
        }

        .vote-btn i {
            position: relative;
            z-index: 1;
        }

        /* BACK BUTTON */
        .back-btn-container {
            text-align: center;
            margin-top: 50px;
            margin-bottom: 40px;
            position: relative;
            z-index: 10;
        }

        .back-btn {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.4);
            color: white;
            border-radius: 12px;
            padding: 14px 40px;
            font-weight: 700;
            font-size: 15px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            letter-spacing: 0.3px;
        }

        .back-btn:hover {
            background: rgba(255, 255, 255, 0.35);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 255, 255, 0.3);
        }

        .back-btn i {
            font-size: 18px;
            transition: transform 0.3s ease;
        }

        .back-btn:hover i {
            transform: translateX(-3px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: #fff;
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.8;
        }

        .empty-state h3 {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .empty-state p {
            font-size: 16px;
            opacity: 0.9;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                padding: 16px 24px;
                flex-wrap: wrap;
            }

            .navbar-brand {
                font-size: 18px;
            }

            .page-title {
                margin-top: 40px;
                margin-bottom: 35px;
            }

            .page-title h2 {
                font-size: 30px;
            }

            .page-title p {
                font-size: 15px;
            }

            .card {
                padding: 24px;
            }

            .img-box {
                height: 240px;
            }

            .candidate-name {
                font-size: 18px;
            }

            .back-btn-container {
                margin-top: 40px;
            }
        }

        @media (max-width: 576px) {
            .navbar-brand {
                font-size: 16px;
            }

            .navbar-brand i {
                font-size: 20px;
            }

            .nav-btn {
                padding: 8px 18px;
                font-size: 13px;
            }

            .page-title h2 {
                font-size: 26px;
            }

            .img-box {
                height: 200px;
            }

            .candidate-name {
                font-size: 17px;
            }

            .candidate-desc {
                font-size: 13px;
            }

            .vote-btn {
                padding: 12px;
                font-size: 14px;
            }

            .back-btn {
                padding: 12px 32px;
                font-size: 14px;
            }
        }
    </style>
</head>

<body>

<!-- Floating Particles -->
<div class="floating-particles">
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
</div>

<!-- NAVBAR -->
<nav class="navbar d-flex justify-content-between align-items-center">
    <span class="navbar-brand">
        <i class="bi bi-shield-check"></i>
        <span>NextGen Voting System</span>
    </span>
    <a href="studentDashboard.jsp" class="nav-btn">
        <i class="bi bi-arrow-left"></i>
        Dashboard
    </a>
</nav>

<!-- HEADER -->
<div class="page-title">
    <h2>Select Your Candidate</h2>
    <p>Choose carefully before casting your vote</p>
</div>

<!-- CANDIDATES -->
<div class="container candidates-container">
    <div class="row g-4">

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    boolean hasCandidates = false;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/votingdb","root","root");

        ps = con.prepareStatement(
            "SELECT * FROM candidates WHERE position_id = ?");
        ps.setInt(1, positionId);
        rs = ps.executeQuery();

        while(rs.next()){
            hasCandidates = true;
%>

        <div class="col-md-4 d-flex">
            <div class="card w-100">

                <div class="img-box">
                    <img src="images/<%= rs.getString("photo") %>" alt="<%= rs.getString("name") %>">
                </div>

                <div class="card-content text-center">
                    <h5 class="candidate-name">
                        <%= rs.getString("name") %>
                    </h5>

                    <p class="candidate-desc">
                        <%= rs.getString("description") %>
                    </p>

                    <form action="VoteServlet" method="post" class="vote-form">
                        <input type="hidden" name="candidate_id" value="<%= rs.getInt("candidate_id") %>">
                        <input type="hidden" name="position_id" value="<%= positionId %>">
                        <button type="submit" class="vote-btn w-100">
                            <i class="bi bi-check-circle"></i> Cast Vote
                        </button>
                    </form>
                </div>

            </div>
        </div>

<%
        }
        
        if(!hasCandidates){
%>
        <div class="col-12">
            <div class="empty-state">
                <i class="bi bi-inbox"></i>
                <h3>No Candidates Found</h3>
                <p>There are no candidates registered for this position yet.</p>
            </div>
        </div>
<%
        }
        
    }catch(Exception e){
        out.println("<div class='col-12'><div class='alert alert-danger'>Error: " + e.getMessage() + "</div></div>");
        e.printStackTrace();
    }finally{
        try{
            if(rs!=null) rs.close();
            if(ps!=null) ps.close();
            if(con!=null) con.close();
        }catch(SQLException se){
            se.printStackTrace();
        }
    }
%>

    </div>

    <div class="back-btn-container">
        <a href="studentDashboard.jsp" class="back-btn">
            <i class="bi bi-arrow-left-circle"></i>
            Back to Dashboard
        </a>
    </div>
</div>

</body>
</html>
