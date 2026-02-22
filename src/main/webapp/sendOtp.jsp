<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.mail.*" %>
<%@ page import="jakarta.mail.internet.*" %>

<%
    // 1️⃣ Get email
    String toEmail = request.getParameter("email");

    if (toEmail == null || toEmail.trim().equals("")) {
        response.sendRedirect("studentLogin.jsp?msg=Email+required");
        return;
    }

    // 2️⃣ Generate OTP
    int otp = new Random().nextInt(900000) + 100000;

    // 3️⃣ Store OTP in session
    session.setAttribute("otp", otp);
    session.setAttribute("otpTime", System.currentTimeMillis());

    // 4️⃣ Sender credentials
    final String fromEmail = "next.genvoting25@gmail.com";
    final String appPassword = "drjrwlfzoduaisyx";   // 🔴 Replace with your actual App Password

    // 5️⃣ Mail properties
    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");

    Session mailSession = Session.getInstance(props,
        new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

    try {
        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(fromEmail, "NextGen Voting System"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("OTP Verification | NextGen Voting System");

        // ✅ Professional HTML Email Content
        String emailContent =
            "<div style='font-family: Helvetica, Arial, sans-serif; background-color: #f4f4f4; padding: 40px; text-align: center;'>"
          + "  <div style='background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); max-width: 500px; margin: 0 auto;'>"
          + "    <h2 style='color: #2c3e50; margin-top: 0;'>Identity Verification</h2>"
          + "    <p style='color: #555555; font-size: 16px;'>Dear User,<br><br>"
          + "    We received a request to access your <strong>NextGen Voting System</strong> account.<br>"
          + "    Please verify your identity using the One-Time Password (OTP) below:</p>"
          + "    <div style='margin: 25px 0;'>"
          + "      <h1 style='color: #1abc9c; font-size: 36px; margin: 0; letter-spacing: 5px; font-weight: bold;'>" + otp + "</h1>"
          + "    </div>"
          + "    <p style='color: #777777; font-size: 14px;'>This code is valid for <strong>5 minutes</strong>. Do not share this code with anyone.</p>"
          + "    <hr style='border: none; border-top: 1px solid #eeeeee; margin: 25px 0;'>"
          + "    <p style='color: #999999; font-size: 12px;'>If you did not initiate this request, please secure your account by contacting support immediately.</p>"
          + "  </div>"
          + "  <div style='margin-top: 20px; color: #aaaaaa; font-size: 12px;'>&copy; 2026 NextGen Voting System Security Team</div>"
          + "</div>";

        message.setContent(emailContent, "text/html; charset=UTF-8");
        Transport.send(message);

        response.sendRedirect("otp.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("studentLogin.jsp?msg=Mail+Error");
    }
%>