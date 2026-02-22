<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login | NextGen Voting System</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --primary: #667eea;
    --secondary: #764ba2;
    --glass: rgba(255, 255, 255, 0.95);
}

body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #1f2d3d;
    position: relative;
    animation: gradientShift 15s ease infinite;
    background-size: 200% 200%;
    overflow: hidden;
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

/* Floating Shapes */
.shape {
    position: absolute;
    border-radius: 50%;
    opacity: 0.1;
    animation: float 20s infinite ease-in-out;
}

.shape1 {
    width: 300px;
    height: 300px;
    background: white;
    top: 10%;
    left: 10%;
    animation-delay: 0s;
}

.shape2 {
    width: 200px;
    height: 200px;
    background: white;
    bottom: 20%;
    right: 15%;
    animation-delay: 4s;
}

.shape3 {
    width: 150px;
    height: 150px;
    background: white;
    top: 50%;
    right: 20%;
    animation-delay: 2s;
}

@keyframes float {
    0%, 100% {
        transform: translateY(0) rotate(0deg);
    }
    25% {
        transform: translateY(-30px) rotate(5deg);
    }
    50% {
        transform: translateY(-60px) rotate(-5deg);
    }
    75% {
        transform: translateY(-30px) rotate(3deg);
    }
}

/* Top Left Branding */
.brand {
    position: absolute;
    top: 30px;
    left: 40px;
    font-size: 24px;
    font-weight: 800;
    color: white;
    display: flex;
    align-items: center;
    gap: 10px;
    z-index: 10;
    animation: slideDown 0.8s ease;
    text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
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

.brand i {
    font-size: 28px;
}

/* Login Card */
.login-card {
    width: 450px;
    padding: 50px 45px;
    border-radius: 30px;
    background: var(--glass);
    backdrop-filter: blur(20px);
    box-shadow: 0 30px 80px rgba(0, 0, 0, 0.3);
    animation: fadeUp 0.8s ease;
    position: relative;
    z-index: 1;
    border: 1px solid rgba(255, 255, 255, 0.3);
}

@keyframes fadeUp {
    from {
        opacity: 0;
        transform: translateY(40px) scale(0.95);
    }
    to {
        opacity: 1;
        transform: translateY(0) scale(1);
    }
}

/* Icon Header */
.icon-header {
    width: 90px;
    height: 90px;
    margin: 0 auto 25px;
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    border-radius: 25px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
    animation: iconPulse 2s ease infinite;
}

@keyframes iconPulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.05);
    }
}

.icon-header i {
    font-size: 48px;
    color: white;
}

/* Titles */
.login-title {
    font-size: 2rem;
    font-weight: 800;
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    text-align: center;
    margin-bottom: 10px;
}

.login-subtitle {
    text-align: center;
    font-size: 1rem;
    color: #64748b;
    margin-bottom: 35px;
    font-weight: 500;
}

/* Input Wrappers */
.input-wrapper {
    position: relative;
    margin-bottom: 25px;
}

.input-label {
    font-weight: 600;
    color: #2d3748;
    margin-bottom: 8px;
    font-size: 0.95rem;
    display: flex;
    align-items: center;
    gap: 6px;
}

.input-label i {
    color: var(--primary);
    font-size: 1rem;
}

.input-field-wrapper {
    position: relative;
}

.input-icon {
    position: absolute;
    top: 50%;
    left: 16px;
    transform: translateY(-50%);
    color: var(--primary);
    font-size: 1.2rem;
    pointer-events: none;
}

/* Form Controls */
.form-control {
    border-radius: 12px;
    padding: 14px 16px 14px 48px;
    border: 2px solid #e2e8f0;
    font-size: 1rem;
    transition: all 0.3s ease;
    background-color: #f8fafc;
}

.form-control:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
    outline: none;
    background-color: white;
}

.form-control:hover {
    border-color: #cbd5e0;
    background-color: white;
}

.form-control::placeholder {
    color: #a0aec0;
}

/* Login Button */
.login-btn {
    width: 100%;
    border-radius: 12px;
    padding: 16px;
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    border: none;
    font-weight: 700;
    color: white;
    font-size: 1rem;
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    cursor: pointer;
}

.login-btn::before {
    content: "";
    position: absolute;
    inset: 0;
    background: linear-gradient(120deg, transparent, rgba(255, 255, 255, 0.4), transparent);
    transform: translateX(-100%);
    transition: transform 0.6s ease;
}

.login-btn:hover::before {
    transform: translateX(100%);
}

.login-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(102, 126, 234, 0.5);
    background: linear-gradient(135deg, #764ba2, #667eea);
}

.login-btn:active {
    transform: translateY(-1px);
}

.login-btn i {
    margin-right: 8px;
}

/* Back Link */
.back-link {
    text-align: center;
    margin-top: 25px;
    font-size: 0.95rem;
}

.back-link a {
    text-decoration: none;
    color: var(--primary);
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.back-link a:hover {
    background: rgba(102, 126, 234, 0.1);
    color: var(--secondary);
    transform: translateX(-5px);
}

.back-link a i {
    font-size: 1.1rem;
}

/* Divider */
.divider {
    display: flex;
    align-items: center;
    margin: 25px 0;
    color: #94a3b8;
    font-size: 0.9rem;
}

.divider::before,
.divider::after {
    content: '';
    flex: 1;
    height: 1px;
    background: #e2e8f0;
}

.divider::before {
    margin-right: 10px;
}

.divider::after {
    margin-left: 10px;
}

/* Alert Message */
.alert-message {
    background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);
    color: white;
    padding: 14px 20px;
    border-radius: 12px;
    margin-bottom: 25px;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 10px;
    animation: slideIn 0.5s ease;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.alert-message i {
    font-size: 1.3rem;
}

/* Responsive Design */
@media (max-width: 576px) {
    .login-card {
        width: 90%;
        padding: 35px 30px;
    }

    .brand {
        top: 20px;
        left: 20px;
        font-size: 20px;
    }

    .login-title {
        font-size: 1.6rem;
    }

    .icon-header {
        width: 75px;
        height: 75px;
    }

    .icon-header i {
        font-size: 40px;
    }
}

/* Loading Animation */
@keyframes spin {
    to { transform: rotate(360deg); }
}

.login-btn.loading::after {
    content: '';
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
    width: 18px;
    height: 18px;
    border: 2px solid rgba(255, 255, 255, 0.3);
    border-top-color: white;
    border-radius: 50%;
    animation: spin 0.6s linear infinite;
}
</style>
</head>

<body>
<!-- Floating Shapes -->
<div class="shape shape1"></div>
<div class="shape shape2"></div>
<div class="shape shape3"></div>

<!-- Top Left Brand -->
<div class="brand">
    <i class="bi bi-shield-lock-fill"></i>
    NextGen Voting
</div>

<div class="login-card">
    <!-- Icon Header -->
    <div class="icon-header">
        <i class="bi bi-person-badge-fill"></i>
    </div>

    <!-- Titles -->
    <div class="login-title">Admin Login</div>
    <div class="login-subtitle">Secure Administrator Access</div>

    <!-- Login Form -->
    <form action="adminLoginProcess.jsp" method="post">
        <div class="input-wrapper">
            <label class="input-label">
                <i class="bi bi-person-circle"></i>
                Admin Username
            </label>
            <div class="input-field-wrapper">
                <i class="input-icon bi bi-person-badge"></i>
                <input type="text" name="username" class="form-control" placeholder="Enter admin username" required autofocus>
            </div>
        </div>

        <div class="input-wrapper">
            <label class="input-label">
                <i class="bi bi-shield-lock"></i>
                Admin Code
            </label>
            <div class="input-field-wrapper">
                <i class="input-icon bi bi-key-fill"></i>
                <input type="password" name="adminCode" class="form-control" placeholder="Enter admin code" required>
            </div>
        </div>

        <button type="submit" class="login-btn mt-3">
            <i class="bi bi-shield-check"></i>
            Login as Admin
        </button>
    </form>

    <!-- Divider -->
    <div class="divider">or</div>

    <!-- Back Link -->
    <div class="back-link">
        <a href="index.jsp">
            <i class="bi bi-arrow-left-circle-fill"></i>
            Back to Home
        </a>
    </div>
</div>

<script>
// Add loading state to button on submit
document.querySelector('form').addEventListener('submit', function(e) {
    const btn = document.querySelector('.login-btn');
    btn.classList.add('loading');
    btn.disabled = true;
});
</script>

</body>
</html>
