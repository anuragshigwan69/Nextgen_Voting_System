<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<%
    if(session.getAttribute("adminId") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    int positionId = Integer.parseInt(request.getParameter("position_id"));
%>

<!DOCTYPE html>
<html>
<head>
    <title>Position Results | Admin</title>
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
            color: #1f2d3d;
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

        /* Container */
        .container-box {
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Header Section */
        .header-section {
            text-align: center;
            margin: 30px 0 40px 0;
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
            font-size: 2.8rem;
            color: #fff;
            margin-bottom: 10px;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .header-section h2 i {
            font-size: 2.8rem;
        }

        .header-section p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 1.1rem;
            font-weight: 400;
        }

        /* Results Box */
        .results-box {
            background: rgba(255, 255, 255, 0.98);
            padding: 45px;
            border-radius: 30px;
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.3);
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

        /* Table Container */
        .table-container {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
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
            padding: 20px 15px;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
            border: none;
        }

        table tbody td {
            padding: 20px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #e2e8f0;
            color: #4a5568;
            font-size: 1rem;
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

        /* Rank Badge */
        .rank-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .rank-1 {
            background: linear-gradient(135deg, #ffd700 0%, #ffed4e 100%);
            color: #8b6914;
            box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);
        }

        .rank-2 {
            background: linear-gradient(135deg, #c0c0c0 0%, #e8e8e8 100%);
            color: #5a5a5a;
            box-shadow: 0 4px 15px rgba(192, 192, 192, 0.4);
        }

        .rank-3 {
            background: linear-gradient(135deg, #cd7f32 0%, #e8a87c 100%);
            color: #5c3a1f;
            box-shadow: 0 4px 15px rgba(205, 127, 50, 0.4);
        }

        .rank-other {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        /* Candidate Name */
        .candidate-name {
            font-weight: 700;
            color: #1e293b;
            font-size: 1.1rem;
        }

        /* Position Name */
        .position-badge {
            display: inline-block;
            padding: 6px 16px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: #4a5568;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
        }

        /* Photo Styling */
        .candidate-photo {
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            object-fit: cover;
        }

        .candidate-photo:hover {
            transform: scale(1.1);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        /* Vote Count */
        .vote-count {
            font-weight: 800;
            font-size: 1.4rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .vote-count-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .vote-count-wrapper i {
            color: #667eea;
            font-size: 1.2rem;
        }

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            margin-top: 35px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 14px 32px;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            font-size: 1rem;
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            transform: translateY(-3px);
            color: white;
            box-shadow: 0 10px 30px rgba(56, 239, 125, 0.5);
        }

        .back-btn i {
            font-size: 1.3rem;
        }

        /* Error Message */
        .error-message {
            padding: 40px 20px;
            text-align: center;
            color: #eb3349;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .error-message i {
            font-size: 3rem;
            display: block;
            margin-bottom: 15px;
        }

        /* Trophy Icons for Top 3 */
        .trophy-icon {
            margin-left: 8px;
            font-size: 1.2rem;
        }

        .trophy-gold {
            color: #ffd700;
        }

        .trophy-silver {
            color: #c0c0c0;
        }

        .trophy-bronze {
            color: #cd7f32;
        }

        /* Stats Summary Section */
        .stats-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 35px;
        }

        .stat-card {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 25px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .stat-card i {
            font-size: 2.5rem;
            color: #667eea;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: #1e293b;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 0.9rem;
            color: #6B7280;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .header-section h2 {
                font-size: 2.2rem;
            }

            .results-box {
                padding: 30px;
            }
        }

        @media (max-width: 768px) {
            .header-section h2 {
                font-size: 1.8rem;
                flex-direction: column;
                gap: 10px;
            }

            .header-section h2 i {
                font-size: 2rem;
            }

            .results-box {
                padding: 25px 20px;
            }

            table thead th,
            table tbody td {
                padding: 15px 10px;
                font-size: 0.85rem;
            }

            .candidate-photo {
                width: 60px !important;
                height: 60px !important;
            }

            .vote-count {
                font-size: 1.2rem;
            }

            .rank-badge {
                width: 35px;
                height: 35px;
                font-size: 1rem;
            }

            .table-container {
                overflow-x: auto;
            }
        }

        @media (max-width: 576px) {
            body {
                padding: 15px;
            }

            .header-section h2 {
                font-size: 1.5rem;
            }

            .stats-summary {
                grid-template-columns: 1fr;
            }
        }

        /* Smooth Scrolling */
        html {
            scroll-behavior: smooth;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 10px;
            height: 10px;
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
    <div class="container container-box">
        <!-- Header Section -->
        <div class="header-section">
            <h2>
                <i class="bi bi-trophy-fill"></i>
                Election Results
            </h2>
            <p>Voting statistics and candidate rankings</p>
        </div>

        <!-- Results Box -->
        <div class="results-box">
            <div class="table-container">
                <table class="table table-hover mb-0 text-center">
                    <thead>
                        <tr>
                            <th><i class="bi bi-hash"></i> Rank</th>
                            <th><i class="bi bi-person-badge"></i> Candidate</th>
                            <th><i class="bi bi-award"></i> Position</th>
                            <th><i class="bi bi-image"></i> Photo</th>
                            <th><i class="bi bi-graph-up"></i> Total Votes</th>
                        </tr>
                    </thead>
                    <tbody>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/votingdb", "root", "root");

        String sql =
            "SELECT c.name, p.position_name, c.photo, COUNT(v.vote_id) AS votes " +
            "FROM candidates c " +
            "JOIN positions p ON c.position_id = p.position_id " +
            "LEFT JOIN votes v ON c.candidate_id = v.candidate_id " +
            "WHERE c.position_id = ? " +
            "GROUP BY c.candidate_id, c.name, p.position_name, c.photo " +
            "ORDER BY votes DESC";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, positionId);
        ResultSet rs = ps.executeQuery();

        int count = 1;
        String rankClass = "";
        String trophyIcon = "";

        while(rs.next()) {
            // Determine rank styling
            if(count == 1) {
                rankClass = "rank-1";
                trophyIcon = "<i class='bi bi-trophy-fill trophy-gold trophy-icon'></i>";
            } else if(count == 2) {
                rankClass = "rank-2";
                trophyIcon = "<i class='bi bi-trophy-fill trophy-silver trophy-icon'></i>";
            } else if(count == 3) {
                rankClass = "rank-3";
                trophyIcon = "<i class='bi bi-trophy-fill trophy-bronze trophy-icon'></i>";
            } else {
                rankClass = "rank-other";
                trophyIcon = "";
            }
%>
                        <tr>
                            <td>
                                <span class="rank-badge <%= rankClass %>"><%= count++ %></span>
                            </td>
                            <td>
                                <span class="candidate-name"><%= rs.getString("name") %></span>
                                <%= trophyIcon %>
                            </td>
                            <td>
                                <span class="position-badge"><%= rs.getString("position_name") %></span>
                            </td>
                            <td>
                                <img src="images/<%= rs.getString("photo") %>" width="80" height="80" class="candidate-photo" alt="Candidate Photo">
                            </td>
                            <td>
                                <div class="vote-count-wrapper">
                                    <i class="bi bi-hand-thumbs-up-fill"></i>
                                    <span class="vote-count"><%= rs.getInt("votes") %></span>
                                </div>
                            </td>
                        </tr>
<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch(Exception e) {
%>
                        <tr>
                            <td colspan="5" class="error-message">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                <div>Error: <%= e.getMessage() %></div>
                            </td>
                        </tr>
<%
    }
%>
                    </tbody>
                </table>
            </div>

            <!-- Back Button -->
            <div class="text-center">
                <a href="viewResults.jsp" class="back-btn">
                    <i class="bi bi-arrow-left-circle-fill"></i>
                    Back to Positions
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
