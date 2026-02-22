<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>OTP Verification | NextGen Voting System</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">

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
    --text-dark: #2d3748;
    --text-muted: #718096;
}

body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #7c68ee 0%, #9b8ff3 50%, #bdb4f7 100%);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    flex-direction: column;
    position: relative;
    padding: 20px;
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
    padding: 20px 42px;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    box-shadow: 0 4px 20px rgba(124, 104, 238, 0.15);
}

.navbar-brand {
    font-weight: 800;
    font-size: 24px;
    color: #fff;
    text-decoration: none;
    letter-spacing: -0.5px;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.nav-link-custom {
    color: rgba(255, 255, 255, 0.9);
    font-weight: 600;
    margin-left: 26px;
    text-decoration: none;
    transition: all 0.3s ease;
}

.nav-link-custom:hover {
    color: #fff;
}

/* OTP Wrapper */
.otp-wrapper {
    width: 480px;
    max-width: 95%;
    background: #fff;
    padding: 50px 40px;
    border-radius: 24px;
    box-shadow: 
        0 30px 70px rgba(124, 104, 238, 0.3),
        0 0 1px rgba(0, 0, 0, 0.1);
    text-align: center;
    position: relative;
    z-index: 1;
    margin-top: 100px;
    animation: slideUp 0.6s ease;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Icon Container */
.icon-container {
    width: 80px;
    height: 80px;
    background: linear-gradient(135deg, var(--primary), var(--soft-purple));
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 24px;
}

.icon-container i {
    font-size: 38px;
    color: #fff;
}

/* Brand */
.brand h5 {
    font-size: 20px;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 24px;
}

/* Titles */
.otp-title {
    font-size: 28px;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 10px;
    letter-spacing: -0.5px;
}

.otp-subtitle {
    font-size: 15px;
    color: var(--text-muted);
    margin-bottom: 28px;
    font-weight: 500;
}

/* Security Note */
.security-note {
    background: linear-gradient(135deg, #f0f4ff, #f5f3ff);
    border-radius: 14px;
    padding: 16px;
    font-size: 14px;
    color: var(--text-dark);
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 28px;
    border: 1px solid #e9d5ff;
    text-align: left;
}

.security-note i {
    color: var(--primary);
    font-size: 22px;
    flex-shrink: 0;
}

.security-note span {
    font-weight: 500;
    line-height: 1.6;
}

/* Form Control */
.form-control {
    height: 60px;
    font-size: 24px;
    letter-spacing: 8px;
    border-radius: 14px;
    border: 2px solid #e2e8f0;
    background-color: #f8fafc;
    margin-bottom: 20px;
    font-weight: 600;
    color: var(--text-dark);
    transition: all 0.3s ease;
}

.form-control:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 4px rgba(124, 104, 238, 0.15);
    background-color: #fff;
    outline: none;
}

.form-control::placeholder {
    letter-spacing: normal;
    font-size: 15px;
    font-weight: 500;
    color: #a0aec0;
}

/* Button */
.btn-primary {
    height: 54px;
    border-radius: 12px;
    font-weight: 700;
    font-size: 16px;
    background: linear-gradient(135deg, var(--primary), var(--soft-purple));
    border: none;
    color: white;
    transition: all 0.3s ease;
    box-shadow: 0 8px 20px rgba(124, 104, 238, 0.35);
    letter-spacing: 0.3px;
}

.btn-primary:hover {
    background: linear-gradient(135deg, var(--primary-dark), var(--primary));
    transform: translateY(-2px);
    box-shadow: 0 12px 30px rgba(124, 104, 238, 0.45);
}

.btn-primary:active {
    transform: translateY(0);
}

/* Alert */
.alert {
    font-size: 14px;
    border-radius: 12px;
    font-weight: 600;
    border: none;
    background: linear-gradient(135deg, rgba(239, 68, 68, 0.15), rgba(220, 38, 38, 0.2));
    color: #991b1b;
    padding: 14px 18px;
    margin-bottom: 20px;
}

/* Footer Text */
.footer-text {
    font-size: 13px;
    color: var(--text-muted);
    margin-top: 24px;
    font-weight: 500;
}

/* Resend Link */
.resend-wrapper {
    margin-top: 20px;
    font-size: 14px;
    color: var(--text-muted);
}

.resend-wrapper a {
    color: var(--primary);
    font-weight: 600;
    text-decoration: none;
    margin-left: 6px;
    transition: all 0.3s ease;
}

.resend-wrapper a:hover {
    color: var(--primary-dark);
    text-decoration: underline;
}

/* Timer Display */
.timer-display {
    font-size: 14px;
    color: var(--primary);
    font-weight: 600;
    margin-top: 12px;
}

/* Responsive */
@media (max-width: 576px) {
    .navbar {
        padding: 16px 24px;
    }

    .navbar-brand {
        font-size: 20px;
    }

    .otp-wrapper {
        padding: 40px 30px;
        margin-top: 90px;
    }

    .icon-container {
        width: 70px;
        height: 70px;
    }

    .icon-container i {
        font-size: 32px;
    }

    .otp-title {
        font-size: 24px;
    }

    .otp-subtitle {
        font-size: 14px;
    }

    .form-control {
        height: 56px;
        font-size: 20px;
        letter-spacing: 6px;
    }

    .btn-primary {
        height: 52px;
        font-size: 15px;
    }

    .security-note {
        padding: 14px;
        font-size: 13px;
    }

    .security-note i {
        font-size: 20px;
    }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">
        <a class="navbar-brand">NEXTGEN VOTING</a>
    </div>
</nav>

<div class="otp-wrapper">

    <!-- Icon -->
    <div class="icon-container">
        <i class="bi bi-shield-lock-fill"></i>
    </div>

    <div class="otp-box">

        <h4 class="otp-title">OTP Verification</h4>
        <div class="otp-subtitle">
            Secure verification required to continue
        </div>

        <div class="security-note">
            <i class="bi bi-info-circle-fill"></i>
            <span>
                A one-time password has been sent to your registered email address.
            </span>
        </div>

        <% if(request.getParameter("msg") != null){ %>
            <div class="alert">
                <%= request.getParameter("msg") %>
            </div>
        <% } %>

        <form action="verifyOtp.jsp" method="post">
            <input type="text"
                   name="otp"
                   class="form-control text-center mb-3"
                   placeholder="Enter 6-digit OTP"
                   maxlength="6"
                   required>

            <button class="btn btn-primary w-100">
                Verify & Continue
            </button>
        </form>

    </div>

    <div class="footer-text">
        © 2025 NextGen Voting • Secure Student Authentication
    </div>

</div>

</body>
</html>
