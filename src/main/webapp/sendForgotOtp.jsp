<%@ page import="java.util.*,java.sql.*,jakarta.mail.*,jakarta.mail.internet.*" %>

<%
String email = request.getParameter("email");

if(email == null || email.trim().equals("")){
    out.println("Email is required");
    return;
}

/* DB CHECK */
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/votingdb","root","root");

PreparedStatement ps = con.prepareStatement(
    "select * from students where email=?");
ps.setString(1,email);
ResultSet rs = ps.executeQuery();

if(!rs.next()){
    out.println("Email not registered");
    return;
}

/* OTP GENERATION */
int otp = new Random().nextInt(900000) + 100000;

/* SAVE OTP */
session.setAttribute("forgotOtp", otp);
session.setAttribute("forgotEmail", email);

/* MAIL CONFIG */
final String fromEmail = "next.genvoting25@gmail.com";   //  your gmail
final String appPassword = "nxldsnwxusnfnfwx";        //  16 digit app password

Properties props = new Properties();
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.port", "587");
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.starttls.enable", "true");

Session mailSession = Session.getInstance(props,
    new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(fromEmail, appPassword);
        }
    });

Message message = new MimeMessage(mailSession);
message.setFrom(new InternetAddress(fromEmail, "NextGen Voting"));
message.setRecipients(Message.RecipientType.TO,
        InternetAddress.parse(email));
message.setSubject("NextGen Voting | Password Reset OTP");

String html =
"<div style='font-family:Poppins,Arial;padding:20px'>" +
"<h2 style='color:#3b5bdb'>Password Reset OTP</h2>" +
"<p>Your One-Time Password is:</p>" +
"<h1 style='letter-spacing:4px;'>" + otp + "</h1>" +
"<p>This OTP is valid for one session only.</p>" +
"<hr>" +
"<small>NextGen Voting System</small>" +
"</div>";


message.setContent(html, "text/html");

Transport.send(message);

response.sendRedirect("verifyForgotOtp.jsp");
%>
