<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>About | NextGen Voting System</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(135deg, #eef4ff, #f8faff);
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        color: #1f2d3d;
        animation: fadeInBody 1s ease-in;
    }

    .navbar {
        background: rgba(255,255,255,0.85);
        backdrop-filter: blur(18px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        padding: 18px 40px;
    }

    .navbar-brand {
        font-weight: 700;
        font-size: 20px;
        background: linear-gradient(90deg,#2563eb,#9333ea);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        letter-spacing: 1px;
        text-decoration: none;
    }

    .nav-link-custom {
        text-decoration: none;
        color: #495057;
        font-weight: 500;
        margin-left: 24px;
        transition: color 0.3s ease;
    }

    .nav-link-custom:hover {
        color: #2563eb;
    }

    .about-section {
        flex: 1;
        padding: 70px 0;
        animation: fadeUp 0.9s ease forwards;
    }

    .glass-card {
        background: rgba(255,255,255,0.92);
        backdrop-filter: blur(22px);
        border-radius: 28px;
        padding: 60px;
        box-shadow: 0 30px 70px rgba(0,0,0,0.12);
    }

    .about-title {
        font-size: 40px;
        font-weight: 700;
        text-align: center;
        margin-bottom: 30px;
        background: linear-gradient(90deg,#2563eb,#9333ea);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: slideDown 0.8s ease;
    }

    .about-text {
        font-size: 15.5px;
        line-height: 1.9;
        color: #495057;
        margin-bottom: 18px;
        text-align: justify;
    }

    .section-head {
        font-size: 22px;
        font-weight: 600;
        color: #2563eb;
        margin-top: 28px;
        margin-bottom: 16px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .info-box {
        background: #f4f7ff;
        border-left: 6px solid #2563eb;
        padding: 24px;
        border-radius: 16px;
        margin-top: 30px;
        font-size: 15px;
        color: #1f2d3d;
        box-shadow: 0 10px 25px rgba(37,99,235,0.15);
    }

    footer {
        background: rgba(255,255,255,0.85);
        backdrop-filter: blur(15px);
        color: #6c757d;
        text-align: center;
        padding: 14px;
        font-size: 13px;
        border-top: 1px solid #e9ecef;
    }

    @keyframes fadeInBody { from {opacity:0;} to {opacity:1;} }
    @keyframes slideDown { from {opacity:0; transform:translateY(-20px);} to {opacity:1; transform:translateY(0);} }
    @keyframes fadeUp { from {opacity:0; transform:translateY(30px);} to {opacity:1; transform:translateY(0);} }
</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a href="adminLogin.jsp" class="navbar-brand" title="Admin Login">NEXTGEN VOTING</a>
        <div>
            <a href="index.jsp" class="nav-link-custom">Home</a>
            <a href="about.jsp" class="nav-link-custom fw-semibold">About</a>
            <a href="studentRegister.jsp" class="nav-link-custom">Student Register</a>
        </div>
    </div>
</nav>

<!-- ABOUT CONTENT -->
<div class="about-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">

                <div class="glass-card">

                    <div class="about-title">
                        About Zeal Polytechnic, Pune
                    </div>

                    <p class="about-text">
                        Established in 2008 under the esteemed Zeal Education Society, Zeal Polytechnic is a premier
                        technical institute located in Narhe, Pune. The institute offers a range of diploma engineering
                        programs designed to provide students with strong technical knowledge, practical skills, and industry
                        relevance. Zeal Polytechnic is approved by AICTE and affiliated with the Maharashtra State Board of
                        Technical Education (MSBTE). The institute emphasizes academic excellence, ethical values, and holistic
                        development of its students.
                    </p>

                    <div class="section-head"><i class="bi bi-lightbulb"></i> Vision & Mission</div>
                    <p class="about-text">
                        The institute aspires to become a leading center of technical education by imparting quality education
                        with ethical values and preparing students to meet societal and industrial needs. Its mission includes
                        promoting academic excellence, industry interaction, teamwork, entrepreneurial spirit, and lifelong learning
                        skills.
                    </p>

                    <div class="section-head"><i class="bi bi-book"></i> Academic Programs</div>
                    <p class="about-text">
                        Zeal Polytechnic offers diploma courses in several engineering disciplines including Artificial Intelligence
                        & Machine Learning, Automation & Robotics, Civil Engineering, Computer Engineering, Electrical Engineering,
                        Electronics & Telecommunication Engineering, and Mechanical Engineering, among others. The institute also
                        facilitates short-term advanced diploma programs to enhance specialized skills.
                    </p>

                    <div class="section-head"><i class="bi bi-building"></i> Departments & Labs</div>
                    <p class="about-text">
                        The departments at Zeal Polytechnic are equipped with modern laboratories to support hands-on learning.
                        For example, the Computer Engineering department has multiple well-equipped labs with state-of-the-art
                        software and high-speed internet connectivity.
                    </p>

                    <div class="section-head"><i class="bi bi-house-door"></i> Campus & Facilities</div>
                    <p class="about-text">
                        The campus is spread over several acres and includes facilities such as spacious classrooms, Wi-Fi enabled
                        campus-wide internet, a digital library with e-resources, sports grounds, auditorium, modern gym, and
                        cafeteria. Separate hostel accommodation is available for girls, featuring modern amenities and mess
                        facilities.
                    </p>

                    <div class="section-head"><i class="bi bi-briefcase"></i> Training & Placement</div>
                    <p class="about-text">
                        Zeal Polytechnic has a dedicated Training & Placement cell that prepares students for job interviews
                        through workshops, mock sessions, and industry exposure activities. The institute works with recruiters
                        across various sectors and helps students gain opportunities for internships and campus placements.
                    </p>

                    <div class="section-head"><i class="bi bi-people"></i> Student Life & Activities</div>
                    <p class="about-text">
                        Beyond academics, students participate in extracurricular and social initiatives such as tree plantation
                        drives, sustainability programs, and technical workshops. Zeal also has cultural and recreational clubs,
                        balancing academic growth with personal development.
                    </p>

                    <div class="info-box">
                        <strong><i class="bi bi-award"></i> Key Highlights</strong><br><br>
                        • Founded in 2008 under Zeal Education Society<br>
                        • Approved by AICTE & Affiliated with MSBTE<br>
                        • Offers numerous engineering diploma programs<br>
                        • Well-equipped labs and modern infrastructure<br>
                        • Central & digital libraries with broadband internet<br>
                        • Hostels, gym, sports facilities, and canteen<br>
                        • Comprehensive Training & Placement support
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer>
    © 2025 NextGen Voting System • Developed for