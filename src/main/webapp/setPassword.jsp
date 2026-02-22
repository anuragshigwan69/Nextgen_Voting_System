<!DOCTYPE html>
<html>
<head>
    <title>Set Password | NextGen Voting</title>
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
    --text-dark: #2d3748;
    --text-muted: #718096;
}

body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #7c68ee 0%, #9b8ff3 50%, #bdb4f7 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--text-dark);
    padding: 20px;
    position: relative;
    overflow: hidden;
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

/* CARD */
.password-card {
    background: #ffffff;
    backdrop-filter: blur(24px);
    padding: 50px 45px;
    width: 100%;
    max-width: 500px;
    border-radius: 28px;
    box-shadow: 
        0 30px 70px rgba(124, 104, 238, 0.3),
        0 0 1px rgba(0, 0, 0, 0.1);
    text-align: center;
    animation: fadeUp 0.6s ease;
    position: relative;
    z-index: 10;
}

@keyframes fadeUp {
    from {
        opacity: 0; 
        transform: translateY(30px);
    } 
    to {
        opacity: 1; 
        transform: translateY(0);
    }
}

/* ICON */
.icon-box {
    width: 95px;
    height: 95px;
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

.icon-box::before {
    content: '';
    position: absolute;
    inset: -3px;
    border-radius: 22px;
    background: linear-gradient(135deg, var(--primary), var(--soft-purple));
    z-index: -1;
    opacity: 0.3;
    filter: blur(10px);
}

.icon-box i {
    font-size: 42px;
    color: white;
}

/* HEADINGS */
h4 {
    font-weight: 800;
    font-size: 32px;
    margin-top: 24px;
    color: #1e293b;
    letter-spacing: -0.5px;
}

.subtitle {
    font-size: 15px;
    color: #64748b;
    margin-top: 8px;
    font-weight: 500;
    line-height: 1.6;
}

/* INPUTS */
.input-wrapper {
    position: relative;
    margin-top: 20px;
    text-align: left;
}

.input-label {
    font-size: 14px;
    font-weight: 600;
    color: #475569;
    margin-bottom: 8px;
    display: block;
}

.input-wrapper i {
    position: absolute;
    top: 50%;
    left: 16px;
    transform: translateY(-50%);
    color: var(--primary);
    font-size: 20px;
    z-index: 2;
}

.form-control {
    height: 54px;
    border-radius: 14px;
    font-size: 15px;
    padding-left: 50px;
    padding-right: 50px;
    border: 2px solid #e2e8f0;
    transition: all 0.3s ease;
    background: #f8fafc;
    font-weight: 500;
    color: var(--text-dark);
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

/* Toggle Password Visibility */
.toggle-password {
    position: absolute;
    top: 50%;
    right: 16px;
    transform: translateY(-50%);
    color: #94a3b8;
    font-size: 18px;
    cursor: pointer;
    transition: all 0.3s ease;
    z-index: 2;
}

.toggle-password:hover {
    color: var(--primary);
}

/* Password Strength Indicator */
.password-strength {
    margin-top: 10px;
    height: 4px;
    background: #e2e8f0;
    border-radius: 2px;
    overflow: hidden;
    display: none;
}

.password-strength.show {
    display: block;
}

.strength-bar {
    height: 100%;
    transition: all 0.3s ease;
    border-radius: 2px;
}

.strength-weak { 
    width: 33%; 
    background: #ef4444; 
}

.strength-medium { 
    width: 66%; 
    background: #f59e0b; 
}

.strength-strong { 
    width: 100%; 
    background: #10b981; 
}

.strength-text {
    font-size: 12px;
    margin-top: 6px;
    font-weight: 600;
}

.strength-text.weak { color: #ef4444; }
.strength-text.medium { color: #f59e0b; }
.strength-text.strong { color: #10b981; }

/* BUTTON */
.finish-btn {
    background: linear-gradient(135deg, var(--primary), var(--soft-purple));
    color: white;
    border-radius: 12px;
    padding: 16px;
    font-size: 16px;
    font-weight: 700;
    width: 100%;
    border: none;
    margin-top: 28px;
    transition: all 0.3s ease;
    box-shadow: 0 10px 25px rgba(124, 104, 238, 0.35);
    position: relative;
    overflow: hidden;
    cursor: pointer;
    letter-spacing: 0.3px;
}

.finish-btn::before {
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

.finish-btn:hover::before {
    width: 300px;
    height: 300px;
}

.finish-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 35px rgba(124, 104, 238, 0.45);
    background: linear-gradient(135deg, var(--primary-dark), var(--primary));
}

.finish-btn:active {
    transform: translateY(0);
}

.finish-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.finish-btn i {
    position: relative;
    z-index: 1;
}

.finish-btn span {
    position: relative;
    z-index: 1;
}

/* HINT */
.hint-text {
    font-size: 13px;
    color: #64748b;
    margin-top: 10px;
    font-weight: 500;
}

/* Requirements List */
.requirements-list {
    margin-top: 16px;
    text-align: left;
    background: linear-gradient(135deg, #f0f4ff, #f5f3ff);
    padding: 16px;
    border-radius: 12px;
    border: 1px solid #e9d5ff;
}

.requirements-list h6 {
    font-size: 13px;
    font-weight: 700;
    color: #475569;
    margin-bottom: 10px;
}

.requirement-item {
    font-size: 12px;
    color: #64748b;
    margin-bottom: 6px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.requirement-item i {
    font-size: 14px;
    color: #cbd5e1;
}

.requirement-item.met i {
    color: #10b981;
}

/* RESPONSIVE */
@media (max-width: 768px) {
    .password-card { 
        max-width: 90%; 
        padding: 40px 35px; 
    }

    .icon-box { 
        width: 85px; 
        height: 85px; 
    }

    .icon-box i { 
        font-size: 38px; 
    }

    h4 { 
        font-size: 28px; 
    }

    .form-control { 
        height: 52px; 
        font-size: 14px; 
    }

    .finish-btn { 
        font-size: 15px; 
        padding: 14px; 
    }
}

@media (max-width: 480px) {
    body { 
        padding: 15px; 
    }

    .password-card { 
        max-width: 100%; 
        padding: 35px 28px; 
        border-radius: 24px; 
    }

    .icon-box {
        width: 75px;
        height: 75px;
    }

    .icon-box i {
        font-size: 34px;
    }

    h4 { 
        font-size: 26px; 
    }

    .subtitle { 
        font-size: 14px; 
    }

    .form-control { 
        font-size: 14px; 
        padding-left: 45px;
        height: 50px;
    }

    .input-wrapper i {
        font-size: 18px;
    }

    .finish-btn { 
        font-size: 15px; 
        padding: 14px; 
    }

    .hint-text { 
        font-size: 12px; 
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

<div class="password-card">

    <div class="icon-box">
        <i class="bi bi-lock-fill"></i>
    </div>

    <h4>Create Password</h4>
    <div class="subtitle">
        Secure your account to complete registration
    </div>

    <form action="setPasswordProcess.jsp" method="post" id="passwordForm">

        <div class="input-wrapper">
            <label class="input-label">New Password</label>
            <i class="bi bi-key"></i>
            <input type="password"
                   name="password"
                   id="password"
                   class="form-control"
                   placeholder="Enter your password"
                   minlength="8"
                   required>
            <i class="bi bi-eye toggle-password" id="togglePassword1"></i>
            <div class="password-strength" id="strengthBar">
                <div class="strength-bar" id="strengthProgress"></div>
            </div>
            <div class="strength-text" id="strengthText"></div>
        </div>

        <div class="input-wrapper">
            <label class="input-label">Confirm Password</label>
            <i class="bi bi-shield-lock"></i>
            <input type="password"
                   name="confirm"
                   id="confirmPassword"
                   class="form-control"
                   placeholder="Re-enter your password"
                   minlength="8"
                   required>
            <i class="bi bi-eye toggle-password" id="togglePassword2"></i>
        </div>

        <div class="requirements-list">
            <h6><i class="bi bi-shield-check me-1"></i> Password Requirements</h6>
            <div class="requirement-item" id="req-length">
                <i class="bi bi-circle"></i>
                <span>At least 8 characters</span>
            </div>
            <div class="requirement-item" id="req-letter">
                <i class="bi bi-circle"></i>
                <span>Contains letters</span>
            </div>
            <div class="requirement-item" id="req-number">
                <i class="bi bi-circle"></i>
                <span>Contains numbers</span>
            </div>
        </div>

        <button type="submit" class="finish-btn">
            <i class="bi bi-check-circle me-1"></i>
            <span>Finish Registration</span>
        </button>

    </form>

    <div class="hint-text">
        <i class="bi bi-info-circle me-1"></i>
        Choose a strong password for better security
    </div>

</div>

<script>
// Toggle password visibility
document.getElementById('togglePassword1').addEventListener('click', function() {
    const passwordInput = document.getElementById('password');
    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordInput.setAttribute('type', type);
    this.classList.toggle('bi-eye');
    this.classList.toggle('bi-eye-slash');
});

document.getElementById('togglePassword2').addEventListener('click', function() {
    const confirmInput = document.getElementById('confirmPassword');
    const type = confirmInput.getAttribute('type') === 'password' ? 'text' : 'password';
    confirmInput.setAttribute('type', type);
    this.classList.toggle('bi-eye');
    this.classList.toggle('bi-eye-slash');
});

// Password strength checker
document.getElementById('password').addEventListener('input', function() {
    const password = this.value;
    const strengthBar = document.getElementById('strengthBar');
    const strengthProgress = document.getElementById('strengthProgress');
    const strengthText = document.getElementById('strengthText');
    
    // Show strength bar
    strengthBar.classList.add('show');
    
    // Check requirements
    const hasLength = password.length >= 8;
    const hasLetter = /[a-zA-Z]/.test(password);
    const hasNumber = /[0-9]/.test(password);
    
    // Update requirement indicators
    document.getElementById('req-length').classList.toggle('met', hasLength);
    document.getElementById('req-letter').classList.toggle('met', hasLetter);
    document.getElementById('req-number').classList.toggle('met', hasNumber);
    
    // Calculate strength
    let strength = 0;
    if (hasLength) strength++;
    if (hasLetter) strength++;
    if (hasNumber) strength++;
    
    // Update visual feedback
    strengthProgress.className = 'strength-bar';
    strengthText.className = 'strength-text';
    
    if (strength === 1) {
        strengthProgress.classList.add('strength-weak');
        strengthText.classList.add('weak');
        strengthText.textContent = 'Weak password';
    } else if (strength === 2) {
        strengthProgress.classList.add('strength-medium');
        strengthText.classList.add('medium');
        strengthText.textContent = 'Medium password';
    } else if (strength === 3) {
        strengthProgress.classList.add('strength-strong');
        strengthText.classList.add('strong');
        strengthText.textContent = 'Strong password';
    }
    
    if (password.length === 0) {
        strengthBar.classList.remove('show');
        strengthText.textContent = '';
    }
});

// Form validation
document.getElementById('passwordForm').addEventListener('submit', function(e) {
    const password = document.getElementById('password').value;
    const confirm = document.getElementById('confirmPassword').value;
    
    if (password !== confirm) {
        e.preventDefault();
        alert('Passwords do not match!');
        return false;
    }
    
    if (password.length < 8) {
        e.preventDefault();
        alert('Password must be at least 8 characters long!');
        return false;
    }
});
</script>

</body>
</html>
