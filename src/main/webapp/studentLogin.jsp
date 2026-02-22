<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Login | NextGen Voting</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
:root {
    --royal-purple: #6b21a8;
    --deep-purple: #4c1d95;
    --light-purple: #a855f7;
    --purple-glow: rgba(168, 85, 247, 0.4);
    --accent: #8b5cf6;
    --soft-bg: #faf5ff;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* ===== BODY ===== */
body {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'Plus Jakarta Sans', sans-serif;
    background: linear-gradient(135deg, #1e1b4b 0%, #4c1d95 35%, #6b21a8 70%, #7c3aed 100%);
    position: relative;
    overflow: hidden;
    padding: 20px;
}

/* Animated Background Elements */
body::before {
    content: '';
    position: fixed;
    top: -20%;
    right: -10%;
    width: 700px;
    height: 700px;
    background: radial-gradient(circle, var(--purple-glow) 0%, transparent 65%);
    border-radius: 50%;
    animation: floatGlow 20s infinite ease-in-out;
    z-index: 0;
}

body::after {
    content: '';
    position: fixed;
    bottom: -15%;
    left: -5%;
    width: 600px;
    height: 600px;
    background: radial-gradient(circle, rgba(139, 92, 246, 0.3) 0%, transparent 65%);
    border-radius: 50%;
    animation: floatGlow 18s infinite ease-in-out reverse;
    z-index: 0;
}

@keyframes floatGlow {
    0%, 100% { 
        transform: translate(0, 0) scale(1);
        opacity: 0.6;
    }
    50% { 
        transform: translate(-30px, 30px) scale(1.1);
        opacity: 0.8;
    }
}

/* Grid Overlay */
.grid-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: 
        linear-gradient(rgba(168, 85, 247, 0.03) 1px, transparent 1px),
        linear-gradient(90deg, rgba(168, 85, 247, 0.03) 1px, transparent 1px);
    background-size: 50px 50px;
    pointer-events: none;
    z-index: 0;
}

/* ===== MAIN CARD ===== */
.login-container {
    max-width: 1000px;
    width: 100%;
    display: flex;
    border-radius: 32px;
    overflow: hidden;
    background: rgba(255, 255, 255, 0.04);
    backdrop-filter: blur(40px) saturate(180%);
    border: 1px solid rgba(168, 85, 247, 0.2);
    box-shadow: 
        0 30px 80px rgba(107, 33, 168, 0.6),
        0 0 60px rgba(139, 92, 246, 0.3),
        inset 0 1px 2px rgba(255, 255, 255, 0.1);
    animation: slideUp 0.8s ease;
    position: relative;
    z-index: 10;
}

.login-container::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, rgba(168, 85, 247, 0.6), transparent);
}

/* ===== LEFT INFO PANEL ===== */
.info-panel {
    flex: 1;
    background: linear-gradient(135deg, var(--royal-purple) 0%, var(--light-purple) 100%);
    color: #fff;
    padding: 50px 45px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

.info-panel::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -30%;
    width: 400px;
    height: 400px;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
    border-radius: 50%;
}

.info-panel::after {
    content: '';
    position: absolute;
    bottom: -30%;
    left: -20%;
    width: 300px;
    height: 300px;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.08) 0%, transparent 70%);
    border-radius: 50%;
}

.badge-live {
    background: rgba(255, 255, 255, 0.25);
    backdrop-filter: blur(10px);
    padding: 8px 18px;
    border-radius: 50px;
    font-size: 13px;
    font-weight: 700;
    margin-bottom: 30px;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    width: fit-content;
    border: 1px solid rgba(255, 255, 255, 0.3);
    position: relative;
    z-index: 1;
}

.badge-live::before {
    content: '';
    width: 8px;
    height: 8px;
    background: #22c55e;
    border-radius: 50%;
    animation: pulse 2s infinite;
}

@keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.5; }
}

.info-panel h2 {
    font-family: 'Syne', sans-serif;
    font-size: 34px;
    font-weight: 800;
    margin-bottom: 16px;
    line-height: 1.2;
    position: relative;
    z-index: 1;
    text-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
}

.info-panel p {
    font-size: 16px;
    line-height: 1.7;
    opacity: 0.95;
    position: relative;
    z-index: 1;
    font-weight: 500;
}

/* ===== RIGHT FORM PANEL ===== */
.form-panel {
    flex: 1;
    padding: 50px 45px;
    background: rgba(255, 255, 255, 0.98);
    position: relative;
}

/* HOME BUTTON */
.home-btn {
    position: absolute;
    top: 24px;
    right: 24px;
}

.home-btn a {
    font-size: 14px;
    border-radius: 50px;
    padding: 10px 20px;
    font-weight: 600;
    border: 2px solid var(--royal-purple);
    color: var(--royal-purple);
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
    background: transparent;
}

.home-btn a:hover {
    background: var(--royal-purple);
    color: #fff;
    box-shadow: 0 8px 20px rgba(107, 33, 168, 0.4);
    transform: translateY(-2px);
}

/* HEADERS */
.logo {
    font-family: 'Syne', sans-serif;
    font-size: 26px;
    font-weight: 800;
    background: linear-gradient(135deg, var(--royal-purple), var(--light-purple));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin-bottom: 12px;
    letter-spacing: -0.5px;
}

.headline {
    font-family: 'Syne', sans-serif;
    font-size: 28px;
    font-weight: 800;
    margin-bottom: 8px;
    color: #1e1b4b;
    letter-spacing: -0.5px;
}

.sub-text {
    font-size: 15px;
    color: #6b7280;
    margin-bottom: 28px;
    font-weight: 500;
}

/* INPUTS */
.input-wrapper {
    position: relative;
    margin-bottom: 18px;
}

.input-wrapper i {
    position: absolute;
    top: 50%;
    left: 16px;
    transform: translateY(-50%);
    font-size: 18px;
    color: var(--royal-purple);
    z-index: 2;
}

.form-control,
.form-select {
    height: 52px;
    border-radius: 16px;
    padding-left: 48px;
    border: 2px solid #e9d5ff;
    font-size: 15px;
    background: #faf5ff;
    transition: all 0.3s ease;
    font-weight: 500;
    color: #1e1b4b;
}

.form-control:focus,
.form-select:focus {
    border-color: var(--royal-purple);
    box-shadow: 0 0 0 4px rgba(107, 33, 168, 0.15);
    background: #fff;
}

.form-control::placeholder {
    color: #9ca3af;
}

/* ALERT */
.alert {
    border-radius: 16px;
    animation: slideDown 0.5s ease;
    border: none;
    background: linear-gradient(135deg, rgba(239, 68, 68, 0.15), rgba(220, 38, 38, 0.2));
    color: #991b1b;
    font-weight: 600;
    padding: 14px 18px;
}

@keyframes slideDown {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* FORGOT PASSWORD */
.forgot {
    text-align: right;
    margin-bottom: 12px;
}

.forgot a {
    font-size: 14px;
    color: var(--royal-purple);
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.forgot a:hover {
    color: var(--light-purple);
    text-decoration: underline;
}

/* BUTTON */
.btn-login {
    width: 100%;
    height: 54px;
    border-radius: 16px;
    border: none;
    background: linear-gradient(135deg, var(--royal-purple) 0%, var(--light-purple) 100%);
    color: #fff;
    font-weight: 700;
    font-size: 16px;
    box-shadow: 
        0 15px 35px rgba(107, 33, 168, 0.5),
        0 0 25px rgba(168, 85, 247, 0.3);
    transition: all 0.3s ease;
    cursor: pointer;
    letter-spacing: 0.5px;
    position: relative;
    overflow: hidden;
}

.btn-login::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 0;
    height: 0;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.2);
    transform: translate(-50%, -50%);
    transition: width 0.6s ease, height 0.6s ease;
}

.btn-login:hover {
    transform: translateY(-3px);
    box-shadow: 
        0 20px 45px rgba(107, 33, 168, 0.65),
        0 0 35px rgba(168, 85, 247, 0.5);
}

.btn-login:hover::before {
    width: 300px;
    height: 300px;
}

.btn-login:active {
    transform: translateY(-1px);
}

/* FOOTER */
.footer-links {
    text-align: center;
    font-size: 14px;
    margin-top: 16px;
}

.footer-links a {
    color: var(--royal-purple);
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.footer-links a:hover {
    color: var(--light-purple);
    text-decoration: underline;
}

.secure-text {
    margin-top: 20px;
    text-align: center;
    font-size: 13px;
    color: #6b7280;
    font-weight: 500;
}

/* ANIMATIONS */
@keyframes slideUp {
    from { 
        opacity: 0; 
        transform: translateY(40px); 
    }
    to { 
        opacity: 1; 
        transform: translateY(0); 
    }
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .login-container { 
        flex-direction: column;
        border-radius: 24px;
    }
    
    .info-panel, 
    .form-panel { 
        width: 100%; 
    }
    
    .info-panel {
        padding: 40px 35px;
    }
    
    .info-panel h2 {
        font-size: 28px;
    }
    
    .form-panel { 
        padding: 40px 35px; 
    }
    
    .home-btn { 
        position: static; 
        text-align: right; 
        margin-bottom: 16px; 
    }
    
    .headline {
        font-size: 24px;
    }
    
    body::before,
    body::after {
        width: 400px;
        height: 400px;
    }
}

@media (max-width: 576px) {
    body {
        padding: 15px;
    }
    
    .login-container {
        border-radius: 20px;
    }
    
    .info-panel {
        padding: 35px 28px;
    }
    
    .info-panel h2 {
        font-size: 24px;
    }
    
    .info-panel p {
        font-size: 15px;
    }
    
    .form-panel {
        padding: 35px 28px;
    }
    
    .logo {
        font-size: 22px;
    }
    
    .headline {
        font-size: 22px;
    }
    
    .form-control,
    .form-select {
        height: 50px;
        font-size: 14px;
    }
    
    .btn-login {
        height: 52px;
        font-size: 15px;
    }
}
</style>

</head>

<body>

<!-- Grid Overlay -->
<div class="grid-overlay"></div>

<div class="login-container">

    <!-- LEFT PANEL -->
    <div class="info-panel">
        <div class="badge-live">Election Live</div>
        <h2>Your Vote Matters.</h2>
        <p>
            Secure, transparent and verified online voting system designed
            exclusively for academic elections.
        </p>
    </div>

    <!-- RIGHT PANEL -->
    <div class="form-panel">

        <div class="home-btn">
            <a href="index.jsp">
                <i class="bi bi-house-door"></i> Home
            </a>
        </div>

        <div class="logo">NEXTGEN</div>
        <div class="headline">Student Login</div>
        <div class="sub-text">Access your voting dashboard</div>

        <% if(request.getParameter("msg") != null){ %>
            <div class="alert text-center">
                <%= request.getParameter("msg") %>
            </div>
        <% } %>

        <form action="studentLoginProcess.jsp" method="post">

            <div class="input-wrapper">
                <i class="bi bi-person"></i>
                <input type="text" name="name" class="form-control"
                       placeholder="Student Full Name (First Middle Surname)" required>
            </div>

            <div class="input-wrapper">
                <i class="bi bi-card-text"></i>
                <input type="text" name="zprn" class="form-control"
                       placeholder="ZPRN Number" required>
            </div>

            <div class="input-wrapper">
                <i class="bi bi-envelope"></i>
                <input type="email" name="email" class="form-control"
                       placeholder="Registered Email Address" required>
            </div>

            <div class="input-wrapper">
                <i class="bi bi-mortarboard"></i>
                <select name="class" class="form-select" required>
                    <option value="">Select Class</option>
                    <option>First Year</option>
                    <option>Second Year</option>
                    <option>Third Year</option>
                </select>
            </div>

            <div class="input-wrapper">
                <i class="bi bi-diagram-3"></i>
                <select name="division" class="form-select" required>
                    <option value="">Select Division</option>
                    <option>A</option>
                    <option>B</option>
                    <option>C</option>
                </select>
            </div>

            <div class="input-wrapper">
                <i class="bi bi-lock"></i>
                <input type="password" name="password" class="form-control"
                       placeholder="Password" required>
            </div>

            <div class="forgot">
                <a href="forgotPassword.jsp">Forgot Password?</a>
            </div>

            <button type="submit" class="btn-login mt-2">
                Enter Voting Portal
            </button>

        </form>

        <div class="footer-links mt-3">
            <a href="studentRegister.jsp">New Student? Register Here</a>
        </div>

        <div class="secure-text">
            © 2025 NextGen Voting System. All rights reserved.
        </div>

    </div>
</div>

</body>
</html>
