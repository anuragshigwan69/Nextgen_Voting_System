<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP | NextGen Voting</title>
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
}

/* Navbar */
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
    text-decoration: none;
    letter-spacing: -0.5px;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

/* Auth Section */
.auth-section {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
    position: relative;
    z-index: 10;
}

/* Card */
.glass-card {
    background: #ffffff;
    border-radius: 28px;
    padding: 50px 45px;
    max-width: 480px;
    width: 100%;
    box-shadow: 
        0 30px 70px rgba(124, 104, 238, 0.3),
        0 0 1px rgba(0, 0, 0, 0.1);
    text-align: center;
    animation: fadeIn 0.6s ease;
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

/* Icon */
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

/* Titles */
.card-title {
    font-size: 30px;
    font-weight: 700;
    margin-top: 24px;
    color: #1e293b;
    letter-spacing: -0.5px;
}

.card-subtitle {
    font-size: 15px;
    color: #64748b;
    margin-top: 8px;
    font-weight: 500;
    line-height: 1.6;
}

/* OTP Input */
.otp-input {
    text-align: center;
    font-size: 24px;
    font-weight: 600;
    padding: 18px;
    border-radius: 14px;
    border: 2px solid #e2e8f0;
    letter-spacing: 8px;
    font-family: 'Poppins', sans-serif;
    transition: all 0.3s ease;
    background: #f8fafc;
    color: #1e293b;
}

.otp-input::placeholder {
    letter-spacing: normal;
    font-size: 15px;
    color: #a0aec0;
    font-weight: 500;
}

.otp-input:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 4px rgba(124, 104, 238, 0.15);
    background: #fff;
    outline: none;
}

/* Button */
.verify-btn {
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
    position: relative;
    overflow: hidden;
    letter-spacing: 0.3px;
    cursor: pointer;
}

.verify-btn::before {
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

.verify-btn:hover::before {
    width: 300px;
    height: 300px;
}

.verify-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 35px rgba(124, 104, 238, 0.45);
    background: linear-gradient(135deg, var(--primary-dark), var(--primary));
}

.verify-btn:active {
    transform: translateY(0);
}

.verify-btn i {
    position: relative;
    z-index: 1;
}

.verify-btn span {
    position: relative;
    z-index: 1;
}

/* Info Text */
.info-text {
    font-size: 14px;
    color: #64748b;
    margin-top: 16px;
    font-weight: 500;
}

/* Resend Link */
.resend-link {
    margin-top: 20px;
    font-size: 14px;
    color: #64748b;
}

.resend-link a {
    color: var(--primary);
    font-weight: 600;
    text-decoration: none;
    transition: all 0.3s ease;
}

.resend-link a:hover {
    color: var(--primary-dark);
    text-decoration: underline;
}

/* Security Badge */
.security-badge {
    margin-top: 24px;
    padding: 12px;
    background: linear-gradient(135deg, #f0f4ff, #f5f3ff);
    border-radius: 12px;
    border: 1px solid #e9d5ff;
    font-size: 13px;
    color: #64748b;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.security-badge i {
    color: var(--primary);
    font-size: 16px;
}

/* Footer */
footer {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border-top: 1px solid rgba(255, 255, 255, 0.2);
    text-align: center;
    padding: 24px;
    font-size: 14px;
    color: rgba(255, 255, 255, 0.9);
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
        font-size: 26px; 
    }

    .card-subtitle {
        font-size: 14px;
    }

    .otp-input { 
        font-size: 20px; 
        letter-spacing: 6px;
        padding: 16px;
    }

    .verify-btn { 
        font-size: 15px; 
        padding: 14px; 
    }
}
</style>
</head>

<body>

<nav class="navbar">
    <a href="index.jsp" class="navbar-brand">NEXTGEN VOTING</a>
</nav>

<div class="auth-section">
    <div class="glass-card">

        <div class="icon-wrap">
            <i class="bi bi-shield-check"></i>
        </div>

        <div class="card-title">OTP Verification</div>
        <div class="card-subtitle">
            Enter the OTP sent to your registered email
        </div>

        <form action="verifyOtpProcess.jsp" method="post" class="mt-4">
            <input type="text"
                   name="otp"
                   class="form-control otp-input mb-3"
                   placeholder="Enter 6-digit OTP"
                   maxlength="6"
                   required>

            <button type="submit" class="verify-btn">
                <i class="bi bi-check-circle me-1"></i>
                <span>Verify OTP</span>
            </button>
        </form>

        <div class="security-badge">
            <i class="bi bi-lock-fill"></i>
            <span>Secure encrypted verification</span>
        </div>

        <div class="info-text">
            Please verify to complete your registration
        </div>

    </div>
</div>

<footer>
    © 2025 NextGen Voting System • Secure Registration
</footer>

</body>
</html>
