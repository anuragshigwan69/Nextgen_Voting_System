<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Registration | NextGen Voting</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Fonts -->
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
    --light-bg: #f8f9fa;
    --white: #ffffff;
    --text-dark: #2d3748;
    --text-muted: #718096;
}

/* ===== BODY ===== */
body {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #7c68ee 0%, #9b8ff3 50%, #bdb4f7 100%);
    padding: 30px 20px;
    position: relative;
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

/* ===== MAIN CONTAINER ===== */
.register-container {
    max-width: 980px;
    width: 100%;
    display: flex;
    border-radius: 24px;
    overflow: hidden;
    background: var(--white);
    box-shadow: 
        0 20px 60px rgba(124, 104, 238, 0.3),
        0 0 1px rgba(0, 0, 0, 0.1);
    position: relative;
    z-index: 1;
    animation: slideUp 0.6s ease;
}

/* ===== LEFT INFO PANEL ===== */
.info-panel {
    flex: 1;
    background: linear-gradient(135deg, #7c68ee 0%, #8b7bef 100%);
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
    top: -100px;
    right: -100px;
    width: 300px;
    height: 300px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 50%;
}

.info-panel::after {
    content: '';
    position: absolute;
    bottom: -80px;
    left: -80px;
    width: 250px;
    height: 250px;
    background: rgba(255, 255, 255, 0.08);
    border-radius: 50%;
}

.badge-live {
    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px);
    padding: 8px 18px;
    border-radius: 50px;
    font-size: 13px;
    font-weight: 600;
    margin-bottom: 28px;
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
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 16px;
    line-height: 1.3;
    position: relative;
    z-index: 1;
}

.info-panel p {
    font-size: 16px;
    line-height: 1.7;
    opacity: 0.95;
    position: relative;
    z-index: 1;
    font-weight: 400;
}

.info-icon {
    width: 80px;
    height: 80px;
    background: rgba(255, 255, 255, 0.15);
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 24px;
    position: relative;
    z-index: 1;
}

.info-icon i {
    font-size: 38px;
    color: #fff;
}

/* ===== RIGHT FORM PANEL ===== */
.form-panel {
    flex: 1;
    padding: 50px 45px;
    background: var(--white);
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
    border-radius: 12px;
    padding: 10px 20px;
    font-weight: 600;
    border: 2px solid #e2e8f0;
    color: var(--text-dark);
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
    background: var(--white);
}

.home-btn a:hover {
    background: var(--primary);
    color: #fff;
    border-color: var(--primary);
    box-shadow: 0 4px 12px rgba(124, 104, 238, 0.3);
    transform: translateY(-2px);
}

/* HEADERS */
.logo {
    font-size: 24px;
    font-weight: 800;
    color: var(--primary);
    margin-bottom: 10px;
    letter-spacing: -0.5px;
}

.headline {
    font-size: 26px;
    font-weight: 700;
    margin-bottom: 8px;
    color: var(--text-dark);
}

.sub-text {
    font-size: 14px;
    color: var(--text-muted);
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
    color: var(--primary);
    z-index: 2;
}

.form-control,
.form-select {
    height: 52px;
    border-radius: 12px;
    padding-left: 48px;
    border: 2px solid #e2e8f0;
    font-size: 15px;
    background: #f8fafc;
    transition: all 0.3s ease;
    font-weight: 500;
    color: var(--text-dark);
}

.form-control:focus,
.form-select:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 4px rgba(124, 104, 238, 0.1);
    background: var(--white);
    outline: none;
}

.form-control::placeholder {
    color: #a0aec0;
    font-weight: 400;
}

/* BUTTON */
.btn-register {
    width: 100%;
    height: 54px;
    border-radius: 12px;
    border: none;
    background: linear-gradient(135deg, var(--primary) 0%, var(--soft-purple) 100%);
    color: #fff;
    font-weight: 700;
    font-size: 16px;
    box-shadow: 0 8px 20px rgba(124, 104, 238, 0.35);
    transition: all 0.3s ease;
    cursor: pointer;
    letter-spacing: 0.3px;
}

.btn-register:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 30px rgba(124, 104, 238, 0.45);
    background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
}

.btn-register:active {
    transform: translateY(0);
}

/* FOOTER */
.footer-links {
    text-align: center;
    font-size: 14px;
    margin-top: 18px;
    color: var(--text-muted);
}

.footer-links a {
    color: var(--primary);
    font-weight: 600;
    text-decoration: none;
    margin-left: 6px;
    transition: all 0.3s ease;
}

.footer-links a:hover {
    color: var(--primary-dark);
    text-decoration: underline;
}

/* ANIMATIONS */
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

/* RESPONSIVE */
@media (max-width: 768px) {
    body {
        padding: 20px 15px;
    }

    .register-container { 
        flex-direction: column;
        border-radius: 20px;
    }
    
    .info-panel, 
    .form-panel { 
        width: 100%; 
    }

    .info-panel {
        padding: 40px 35px;
    }

    .info-panel h2 {
        font-size: 26px;
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
        font-size: 23px;
    }
}

@media (max-width: 576px) {
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

    .btn-register {
        height: 52px;
        font-size: 15px;
    }

    .info-icon {
        width: 70px;
        height: 70px;
    }

    .info-icon i {
        font-size: 32px;
    }
}
</style>
</head>

<body>

<div class="register-container">

    <!-- LEFT PANEL -->
    <div class="info-panel">
        <div class="badge-live">Election Live</div>
        <div class="info-icon">
            <i class="bi bi-person-plus-fill"></i>
        </div>
        <h2>Register & Make Your Voice Count</h2>
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
        <div class="headline">Student Registration</div>
        <div class="sub-text">OTP verification required to continue</div>

        <form action="sendOtpRegister.jsp" method="post">

            <div class="input-wrapper">
                <i class="bi bi-person"></i>
                <input type="text" name="name" class="form-control" placeholder="Full Name" required>
            </div>

            <div class="input-wrapper">
                <i class="bi bi-card-text"></i>
                <input type="text" name="zprn" class="form-control" placeholder="ZPRN Number" required>
            </div>

            <div class="input-wrapper">
                <i class="bi bi-envelope"></i>
                <input type="email" name="email" class="form-control" placeholder="Email Address" required>
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

            <button type="submit" class="btn-register mt-2">
                Send OTP & Continue
            </button>

        </form>

        <div class="footer-links mt-3">
            <span>Already registered?</span>
            <a href="studentLogin.jsp">Login</a>
        </div>

    </div>
</div>

</body>
</html>
