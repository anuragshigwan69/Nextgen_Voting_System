<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password | NextGen Voting</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

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
}

body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #7c68ee 0%, #9b8ff3 50%, #bdb4f7 100%);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
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

/* NAVBAR */
.navbar {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(20px);
    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 4px 20px rgba(124, 104, 238, 0.15);
    padding: 20px 40px;
    position: relative;
    z-index: 100;
}

.navbar-brand {
    font-weight: 800;
    font-size: 24px;
    color: #fff;
    letter-spacing: -0.5px;
    text-decoration: none;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

/* AUTH SECTION */
.auth-section {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
    position: relative;
    z-index: 10;
}

.glass-card {
    background: #ffffff;
    backdrop-filter: blur(22px);
    border-radius: 28px;
    padding: 50px 45px;
    max-width: 500px;
    width: 100%;
    box-shadow: 
        0 30px 70px rgba(124, 104, 238, 0.3),
        0 0 1px rgba(0, 0, 0, 0.1);
    animation: fadeIn 0.6s ease;
    text-align: center;
    position: relative;
}

@keyframes fadeIn {
    from { 
        opacity: 0; 
        transform: translateY(30px); 
    }
    to { 
        opacity: 1; 
        transform: translateY(0); 
    }
}

.icon-wrap {
    width: 90px;
    height: 90px;
    margin: 0 auto;
    border-radius: 22px;
    background: linear-gradient(135deg, var(--primary), var(--soft-purple));
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 15px 35px rgba(124, 104, 238, 0.4);
    position: relative;
    animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.05); }
}

.icon-wrap::before {
    content: '';
    position: absolute;
    inset: -3px;
    border-radius: 22px;
    background: linear-gradient(135deg, var(--primary), var(--soft-purple));
    z-index: -1;
    opacity: 0.3;
    filter: blur(10px);
}

.icon-wrap i {
    font-size: 40px;
    color: white;
}

.card-title {
    font-size: 32px;
    font-weight: 800;
    color: #1e293b;
    margin-top: 24px;
    letter-spacing: -0.5px;
}

.card-subtitle {
    font-size: 15px;
    color: #64748b;
    margin-top: 10px;
    line-height: 1.6;
    font-weight: 500;
}

/* Info Badge */
.info-badge {
    background: linear-gradient(135deg, #f0f4ff, #f5f3ff);
    border-radius: 12px;
    border: 1px solid #e9d5ff;
    padding: 14px;
    margin-top: 20px;
    font-size: 13px;
    color: #64748b;
    display: flex;
    align-items: center;
    gap: 10px;
    text-align: left;
}

.info-badge i {
    color: var(--primary);
    font-size: 18px;
    flex-shrink: 0;
}

/* Form */
.form-label {
    font-weight: 600;
    font-size: 14px;
    color: #475569;
    margin-bottom: 8px;
}

.input-wrapper {
    position: relative;
}

.input-icon {
    position: absolute;
    left: 16px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--primary);
    font-size: 20px;
    z-index: 2;
}

.form-control {
    border-radius: 14px;
    padding: 16px 16px 16px 50px;
    font-size: 15px;
    border: 2px solid #e2e8f0;
    background: #f8fafc;
    font-weight: 500;
    color: #1e293b;
    transition: all 0.3s ease;
}

.form-control:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 4px rgba(124, 104, 238, 0.15);
    background: #fff;
    outline: none;
}

.form-control::placeholder {
    color: #a0aec0;
}

.send-btn {
    background: linear-gradient(135deg, var(--primary), var(--soft-purple));
    color: white;
    border-radius: 12px;
    padding: 16px;
    font-size: 16px;
    font-weight: 700;
    width: 100%;
    border: none;
    transition: all 0.3s ease;
    box-shadow: 0 10px 25px rgba(124, 104, 238, 0.35);
    cursor: pointer;
    position: relative;
    overflow: hidden;
    letter-spacing: 0.3px;
}

.send-btn::before {
    content: "";
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

.send-btn:hover::before {
    width: 300px;
    height: 300px;
}

.send-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 35px rgba(124, 104, 238, 0.45);
    background: linear-gradient(135deg, var(--primary-dark), var(--primary));
}

.send-btn:active {
    transform: translateY(0);
}

.send-btn i {
    position: relative;
    z-index: 1;
}

.send-btn span {
    position: relative;
    z-index: 1;
}

.back-link {
    text-decoration: none;
    font-size: 15px;
    color: var(--primary);
    font-weight: 600;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 6px;
}

.back-link:hover {
    color: var(--primary-dark);
    text-decoration: underline;
    gap: 8px;
}

.back-link i {
    transition: transform 0.3s ease;
}

.back-link:hover i {
    transform: translateX(-3px);
}

footer {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border-top: 1px solid rgba(255, 255, 255, 0.2);
    color: rgba(255, 255, 255, 0.9);
    text-align: center;
    padding: 24px;
    font-size: 14px;
    position: relative;
    z-index: 100;
    font-weight: 500;
}

/* Responsive */
@media (max-width: 576px) {
    .navbar {
        padding: 16px 24px;
    }

    .navbar-brand {
        font-size: 20px;
    }

    .auth-section {
        padding: 40px 20px;
    }

    .glass-card {
        padding: 40px 30px;
    }

    .icon-wrap {
        width: 80px;
        height: 80px;
    }

    .icon-wrap i {
        font-size: 36px;
    }

    .card-title {
        font-size: 28px;
    }

    .card-subtitle {
        font-size: 14px;
    }

    .form-control {
        padding: 14px 14px 14px 45px;
        font-size: 14px;
    }

    .input-icon {
        font-size: 18px;
        left: 14px;
    }

    .send-btn {
        padding: 14px;
        font-size: 15px;
    }

    .info-badge {
        font-size: 12px;
        padding: 12px;
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
</div>

<!-- NAVBAR -->
<nav class="navbar">
    <a href="index.jsp" class="navbar-brand">NEXTGEN VOTING</a>
</nav>

<!-- FORGOT PASSWORD -->
<div class="auth-section">
    <div class="glass-card">

        <div class="icon-wrap">
            <i class="bi bi-shield-lock-fill"></i>
        </div>

        <div class="card-title">
            Forgot Password?
        </div>

        <div class="card-subtitle">
            Enter your registered email to receive a one-time verification code
        </div>

        <div class="info-badge">
            <i class="bi bi-info-circle-fill"></i>
            <span>We'll send a secure OTP to your registered email address to verify your identity.</span>
        </div>

        <form action="sendForgotOtp.jsp" method="post" class="mt-4">

            <div class="mb-3 text-start">
                <label class="form-label">Registered Email</label>
                <div class="input-wrapper">
                    <i class="bi bi-envelope input-icon"></i>
                    <input type="email" 
                           name="email" 
                           class="form-control"
                           placeholder="example@student.edu" 
                           required>
                </div>
            </div>

            <button type="submit" class="send-btn">
                <i class="bi bi-envelope-check me-1"></i>
                <span>Send OTP</span>
            </button>
        </form>

        <div class="mt-4">
            <a href="studentLogin.jsp" class="back-link">
                <i class="bi bi-arrow-left"></i>
                <span>Back to Login</span>
            </a>
        </div>

    </div>
</div>

<!-- FOOTER -->
<footer>
    © 2025 NextGen Voting System • Secured by Student Election Committee
</footer>

</body>
</html>
