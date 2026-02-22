<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="dbTest.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>NextGen Voting System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --primary: #7c68ee;
    --primary-dark: #6854d9;
    --soft-purple: #8b7bef;
    --light-purple: #a855f7;
    --text-dark: #2d3748;
    --text-muted: #718096;
}

body {
    font-family: 'Plus Jakarta Sans', sans-serif;
    background: linear-gradient(135deg, #7c68ee 0%, #9b8ff3 50%, #bdb4f7 100%);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    color: var(--text-dark);
    position: relative;
    overflow-x: hidden;
}

/* Animated Background Elements */
body::before {
    content: '';
    position: fixed;
    top: -20%;
    right: -10%;
    width: 800px;
    height: 800px;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.15) 0%, transparent 60%);
    border-radius: 50%;
    animation: floatGlow 18s infinite ease-in-out;
    z-index: 0;
}

body::after {
    content: '';
    position: fixed;
    bottom: -15%;
    left: -5%;
    width: 600px;
    height: 600px;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.12) 0%, transparent 60%);
    border-radius: 50%;
    animation: floatGlow 22s infinite ease-in-out reverse;
    z-index: 0;
}

@keyframes floatGlow {
    0%, 100% { 
        transform: translate(0, 0) scale(1);
        opacity: 0.8;
    }
    50% { 
        transform: translate(-30px, 30px) scale(1.1);
        opacity: 1;
    }
}

/* Decorative Particles */
.purple-particles {
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
    width: 5px;
    height: 5px;
    background: rgba(255, 255, 255, 0.5);
    border-radius: 50%;
    animation: floatParticle 15s infinite ease-in-out;
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
}

.particle:nth-child(1) { top: 20%; left: 15%; animation-delay: 0s; }
.particle:nth-child(2) { top: 60%; left: 85%; animation-delay: 2s; }
.particle:nth-child(3) { top: 40%; left: 70%; animation-delay: 4s; }
.particle:nth-child(4) { top: 80%; left: 25%; animation-delay: 1s; }
.particle:nth-child(5) { top: 10%; left: 90%; animation-delay: 3s; }
.particle:nth-child(6) { top: 70%; left: 50%; animation-delay: 5s; }

@keyframes floatParticle {
    0%, 100% { 
        transform: translateY(0) scale(1);
        opacity: 0.4;
    }
    50% { 
        transform: translateY(-60px) scale(1.3);
        opacity: 1;
    }
}

/* Decorative Grid Pattern */
.grid-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: 
        linear-gradient(rgba(255, 255, 255, 0.05) 1px, transparent 1px),
        linear-gradient(90deg, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
    background-size: 50px 50px;
    pointer-events: none;
    z-index: 1;
}

/* Navbar */
.navbar {
    background: rgba(255, 255, 255, 0.18);
    backdrop-filter: blur(25px) saturate(180%);
    border-bottom: 1px solid rgba(255, 255, 255, 0.3);
    padding: 24px 0;
    position: relative;
    z-index: 100;
    box-shadow: 0 4px 30px rgba(124, 104, 238, 0.2);
}

.navbar::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.5), transparent);
}

.navbar-brand {
    font-family: 'Syne', sans-serif;
    font-weight: 800;
    font-size: 28px;
    color: #fff;
    text-decoration: none;
    letter-spacing: -0.5px;
    position: relative;
    display: inline-block;
    text-shadow: 0 2px 15px rgba(124, 104, 238, 0.4);
}

.navbar-brand::after {
    content: '';
    position: absolute;
    bottom: -8px;
    left: 0;
    width: 50%;
    height: 3px;
    background: linear-gradient(90deg, rgba(255, 255, 255, 0.8), transparent);
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
    border-radius: 2px;
}

.nav-links {
    display: flex;
    gap: 36px;
    align-items: center;
}

.nav-link-custom {
    color: rgba(255, 255, 255, 0.95);
    font-weight: 600;
    font-size: 15px;
    text-decoration: none;
    position: relative;
    transition: all 0.3s ease;
    letter-spacing: 0.3px;
}

.nav-link-custom::before {
    content: '';
    position: absolute;
    bottom: -6px;
    left: 0;
    width: 0;
    height: 2px;
    background: rgba(255, 255, 255, 0.9);
    transition: width 0.3s ease;
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.7);
}

.nav-link-custom:hover {
    color: #fff;
    text-shadow: 0 0 15px rgba(255, 255, 255, 0.8);
}

.nav-link-custom:hover::before {
    width: 100%;
}

/* Hero Section */
.hero-section {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 90px 20px;
    position: relative;
    z-index: 10;
}

.hero-container {
    max-width: 1400px;
    width: 100%;
}

.glass-card {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(35px) saturate(160%);
    border-radius: 36px;
    border: 2px solid rgba(255, 255, 255, 0.3);
    box-shadow: 
        0 25px 70px rgba(124, 104, 238, 0.25),
        inset 0 1px 3px rgba(255, 255, 255, 0.4),
        0 0 60px rgba(255, 255, 255, 0.1);
    padding: 85px 70px;
    position: relative;
    overflow: hidden;
}

.glass-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.6), transparent);
}

.glass-card::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
}

/* Popup Alert */
#popupMessage {
    background: linear-gradient(135deg, rgba(239, 68, 68, 0.2), rgba(220, 38, 38, 0.25));
    backdrop-filter: blur(15px);
    border: 1px solid rgba(239, 68, 68, 0.5);
    border-radius: 18px;
    padding: 22px 28px;
    color: #fff;
    font-weight: 600;
    max-width: 650px;
    margin: 0 auto 45px;
    animation: slideDown 0.6s ease;
    box-shadow: 0 10px 40px rgba(220, 38, 38, 0.3);
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

/* Content Grid */
.hero-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 90px;
    align-items: center;
}

/* Image Side */
.vote-img-container {
    position: relative;
    animation: fadeInLeft 1.2s ease;
}

@keyframes fadeInLeft {
    from {
        opacity: 0;
        transform: translateX(-40px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.vote-img-wrapper {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
}

.vote-img-wrapper::before {
    content: '';
    position: absolute;
    width: 450px;
    height: 450px;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.3) 0%, transparent 70%);
    border-radius: 50%;
    animation: pulseGlow 4s infinite ease-in-out;
}

@keyframes pulseGlow {
    0%, 100% { 
        transform: scale(1); 
        opacity: 0.6; 
    }
    50% { 
        transform: scale(1.2); 
        opacity: 1; 
    }
}

.vote-img {
    width: 100%;
    max-width: 480px;   /* was 380px */
    position: relative;
    z-index: 2;
    filter: drop-shadow(0 30px 70px rgba(124, 104, 238, 0.6));
    animation: floatImage 7s infinite ease-in-out;
}


@keyframes floatImage {
    0%, 100% { transform: translateY(0) rotate(0deg); }
    50% { transform: translateY(-25px) rotate(2deg); }
}

/* Text Side */
.hero-content {
    animation: fadeInRight 1.2s ease 0.3s backwards;
}

@keyframes fadeInRight {
    from {
        opacity: 0;
        transform: translateX(40px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.hero-title {
    font-family: 'Syne', sans-serif;
    font-size: 68px;
    font-weight: 800;
    line-height: 1.1;
    color: #fff;
    margin-bottom: 28px;
    letter-spacing: -2px;
    text-shadow: 0 4px 25px rgba(124, 104, 238, 0.3);
}

.hero-title .highlight {
    background: linear-gradient(135deg, #fff 0%, rgba(255, 255, 255, 0.8) 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    position: relative;
    display: inline-block;
    filter: drop-shadow(0 0 20px rgba(255, 255, 255, 0.8));
}

.hero-subtitle {
    font-size: 19px;
    line-height: 1.8;
    color: rgba(255, 255, 255, 0.95);
    margin-bottom: 45px;
    font-weight: 500;
    letter-spacing: 0.3px;
    text-shadow: 0 2px 10px rgba(124, 104, 238, 0.2);
}

/* Login Button */
.login-btn {
    display: inline-flex;
    align-items: center;
    gap: 14px;
    padding: 20px 52px;
    background: #fff;
    color: var(--primary);
    font-weight: 700;
    font-size: 17px;
    border: none;
    border-radius: 50px;
    text-decoration: none;
    position: relative;
    overflow: hidden;
    cursor: pointer;
    transition: all 0.4s ease;
    box-shadow: 
        0 15px 40px rgba(255, 255, 255, 0.3),
        0 0 30px rgba(255, 255, 255, 0.2);
    letter-spacing: 0.5px;
}

.login-btn::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--primary), var(--soft-purple));
    transform: translate(-50%, -50%);
    transition: width 0.7s ease, height 0.7s ease;
    z-index: 0;
}

.login-btn:hover::before {
    width: 400px;
    height: 400px;
}

.login-btn:hover {
    transform: translateY(-3px) scale(1.02);
    box-shadow: 
        0 20px 50px rgba(255, 255, 255, 0.4),
        0 0 50px rgba(255, 255, 255, 0.3);
    color: #fff;
}

.login-btn:active {
    transform: translateY(-1px) scale(1);
}

.login-btn i {
    font-size: 22px;
    position: relative;
    z-index: 1;
}

.login-btn span {
    position: relative;
    z-index: 1;
}

/* Footer */
footer {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(25px);
    border-top: 1px solid rgba(255, 255, 255, 0.3);
    text-align: center;
    padding: 26px;
    color: rgba(255, 255, 255, 0.95);
    font-size: 14px;
    position: relative;
    z-index: 100;
    box-shadow: 0 -4px 30px rgba(124, 104, 238, 0.15);
    letter-spacing: 0.3px;
    font-weight: 500;
}

/* Responsive Design */
@media (max-width: 992px) {
    .hero-grid {
        grid-template-columns: 1fr;
        gap: 70px;
        text-align: center;
    }

    .hero-title {
        font-size: 52px;
    }

    .vote-img {
        max-width: 300px;
    }

    .glass-card {
        padding: 70px 50px;
    }

    .nav-links {
        gap: 24px;
    }

    .navbar-brand {
        font-size: 26px;
    }
}

@media (max-width: 576px) {
    .hero-title {
        font-size: 40px;
        letter-spacing: -1px;
    }

    .hero-subtitle {
        font-size: 17px;
    }

    .navbar-brand {
        font-size: 24px;
    }

    .glass-card {
        padding: 50px 30px;
    }

    .login-btn {
        padding: 18px 40px;
        font-size: 16px;
        gap: 10px;
    }

    .nav-links {
        flex-direction: column;
        gap: 18px;
        align-items: flex-start;
    }

    .vote-img {
        max-width: 250px;
    }

    body::before,
    body::after {
        width: 500px;
        height: 500px;
    }
}

@media (max-width: 400px) {
    .hero-title {
        font-size: 34px;
    }

    .navbar {
        padding: 20px 0;
    }

    .glass-card {
        padding: 40px 24px;
        border-radius: 28px;
    }
}
</style>
</head>

<body>

<!-- Decorative Grid -->
<div class="grid-overlay"></div>

<!-- Purple Particles -->
<div class="purple-particles">
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
    <div class="particle"></div>
</div>

<!-- NAVBAR -->
<nav class="navbar">
    <div class="container-fluid px-5">
        <a href="adminLogin.jsp" class="navbar-brand">NEXTGEN VOTING</a>
        <div class="nav-links">
            <a href="about.jsp" class="nav-link-custom">About</a>
            <a href="studentRegister.jsp" class="nav-link-custom">Student Register</a>
        </div>
    </div>
</nav>

<%
    String electionStatus = "inactive";
    try {
        java.sql.Statement stmt = con.createStatement();
        java.sql.ResultSet rs = stmt.executeQuery("SELECT status FROM election_status WHERE id=1");
        if (rs.next()) {
            electionStatus = rs.getString("status");
        }
        rs.close();
        stmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!-- HERO -->
<div class="hero-section">
    <div class="hero-container">
        <div class="glass-card">

            <!-- POPUP MESSAGE -->
            <div id="popupMessage" style="display:none;">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                Election is not active. Student login is disabled, please come when it's active.
            </div>

            <div class="hero-grid">

                <!-- Image Side -->
                <div class="vote-img-container">
                    <div class="vote-img-wrapper">
                        <img src="images/vote-box1.png" class="vote-img" alt="Vote Box">
                    </div>
                </div>

                <!-- Content Side -->
                <div class="hero-content">
                    <h1 class="hero-title">
                        Your Voice,<br>
                        Your <span class="highlight">Vote</span>
                    </h1>

                    <p class="hero-subtitle">
                        A secure and transparent platform to shape the future of your university. 
                        Cast your vote with confidence and make your voice heard.
                    </p>

                    <a href="#" class="login-btn" onclick="handleLoginClick('<%= electionStatus %>'); return false;">
                        <i class="bi bi-person-check"></i>
                        <span>Student Login</span>
                    </a>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer>
    © 2025 NextGen Voting System • Secured by Student Election Committee
</footer>

<script>
function handleLoginClick(status) {
    if (status.toLowerCase() === "active") {
        window.location.href = "studentLogin.jsp";
    } else {
        const popup = document.getElementById("popupMessage");
        popup.style.display = "block";
        popup.style.opacity = "0";
        popup.style.transition = "opacity 0.5s ease";

        setTimeout(() => popup.style.opacity = "1", 10);

        setTimeout(() => {
            popup.style.opacity = "0";
            setTimeout(() => popup.style.display = "none", 500);
        }, 5000);
    }
}
</script>

</body>
</html>
