<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP | NextGen Voting</title>
    <meta charset="UTF-8">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
body {
    font-family: 'Inter', sans-serif;
    background: linear-gradient(135deg, #eef4ff, #f8faff);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    color: #1e293b;
    animation: fadeInBody 1s ease-in;
}

/* NAVBAR */
.navbar {
    background: rgba(255,255,255,0.9);
    backdrop-filter: blur(18px);
    box-shadow: 0 12px 30px rgba(37,99,235,0.15);
    padding: 18px 40px;
}
.navbar-brand {
    font-weight: 700;
    font-size: 20px;
    background: linear-gradient(90deg,#2563eb,#9333ea);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
    letter-spacing: 1px;
    text-decoration: none;
}

/* AUTH SECTION */
.auth-section {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 15px;
}
.glass-card {
    background: rgba(255,255,255,0.94);
    backdrop-filter: blur(24px);
    border-radius: 30px;
    padding: 48px 46px;
    max-width: 430px;
    width: 100%;
    box-shadow: 0 45px 95px rgba(37,99,235,0.25);
    animation: fadeIn 0.8s ease;
    text-align: center;
}

/* ICON */
.icon-wrap {
    width: 76px;
    height: 76px;
    margin: 0 auto;
    border-radius: 50%;
    background: linear-gradient(135deg, #2563eb, #9333ea);
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 18px 40px rgba(37,99,235,0.5);
}
.icon-wrap i {
    font-size: 32px;
    color: white;
}

/* HEADINGS */
.card-title {
    font-size: 26px;
    font-weight: 700;
    background: linear-gradient(90deg,#2563eb,#9333ea);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
    margin-top: 22px;
}
.card-subtitle {
    font-size: 14px;
    color: #64748b;
    margin-top: 8px;
    line-height: 1.6;
}

/* OTP INPUT */
.otp-input {
    text-align: center;
    font-size: 22px;
    letter-spacing: 14px;
    padding: 14px;
    border-radius: 16px;
    border: 1px solid #dbe3ff;
}
.otp-input::placeholder {
    letter-spacing: 8px;
}
.otp-input:focus {
    border-color: #2563eb;
    box-shadow: 0 0 0 4px rgba(37,99,235,0.2);
}

/* BUTTON */
.verify-btn {
    background: linear-gradient(135deg, #2563eb, #9333ea);
    color: white;
    border-radius: 18px;
    padding: 14px;
    font-size: 15px;
    font-weight: 600;
    width: 100%;
    border: none;
    transition: all 0.35s ease;
    box-shadow: 0 16px 35px rgba(37,99,235,0.45);
}
.verify-btn:hover {
    transform: translateY(-3px) scale(1.01);
    box-shadow: 0 24px 48px rgba(37,99,235,0.6);
}

/* INFO + BACK */
.info-text {
    font-size: 12.5px;
    color: #64748b;
    margin-top: 14px;
}
.back-link {
    text-decoration: none;
    font-size: 14px;
    color: #2563eb;
    font-weight: 500;
    transition:0.3s;
}
.back-link:hover {
    color:#9333ea;
    text-decoration: underline;
}

/* FOOTER */
footer {
    background: rgba(255,255,255,0.9);
    backdrop-filter: blur(15px);
    color: #6c757d;
    text-align: center;
    padding: 14px;
    font-size: 13px;
    border-top: 1px solid #e9ecef;
}

/* ANIMATIONS */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(25px); }
    to { opacity: 1; transform: translateY(0); }
}
@keyframes fadeInBody {
    from { opacity: 0; }
    to { opacity: 1; }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">
    <a href="index.jsp" class="navbar-brand">NEXTGEN VOTING</a>
</nav>

<!-- VERIFY OTP -->
<div class="auth-section">
    <div class="glass-card">

        <div class="icon-wrap">
            <i class="bi bi-shield-check"></i>
        </div>

        <div class="card-title">
            Verify OTP
        </div>

        <div class="card-subtitle">
            Enter the 6-digit verification code sent to your registered email
        </div>

        <form action="verifyForgotOtpProcess.jsp" method="post" class="mt-4">

            <input type="text"
                   name="otp"
                   class="form-control otp-input mb-3"
                   placeholder="••••••"
                   maxlength="6"
                   required>

            <button type="submit" class="verify-btn">
                <i class="bi bi-check-circle me-1"></i> Verify OTP
            </button>
        </form>

        <div class="info-text">
            Didn’t receive the OTP? Check your spam or junk folder.
        </div>

        <div class="mt-4">
            <a href="forgotPassword.jsp" class="back-link">
                <i class="bi bi-arrow-left"></i> Back
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
