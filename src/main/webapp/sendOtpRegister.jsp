<%@ page import="java.util.*, java.sql.*, jakarta.mail.*, jakarta.mail.internet.*" %>
<%
String name = request.getParameter("name");
String zprn = request.getParameter("zprn");
String email = request.getParameter("email");
String sclass = request.getParameter("class");
String division = request.getParameter("division");

/* DB CONNECT */
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/votingdb", "root", "root");

/* MATCH STUDENT DETAILS */
PreparedStatement ps = con.prepareStatement(
    "SELECT student_id, password FROM students " +
    "WHERE name=? AND zprn=? AND email=? AND class=? AND division=?"
);

ps.setString(1, name);
ps.setString(2, zprn);
ps.setString(3, email);
ps.setString(4, sclass);
ps.setString(5, division);

ResultSet rs = ps.executeQuery();

/* STUDENT NOT FOUND */
if (!rs.next()) {
%>
    <div style="text-align:center; margin-top:60px;">
        <a href="studentRegister.jsp" class="btn btn-outline-primary mb-3">
            <i class="bi bi-arrow-left"></i> Back
        </a>
        <h3 style="color:red;">Your details are not found in records. Contact Admin.</h3>
    </div>
<%
    return;
}

/* PASSWORD ALREADY SET */
if (rs.getString("password") != null) {
%>
    <div style="text-align:center; margin-top:60px;">
        <a href="studentLogin.jsp" class="btn btn-outline-primary mb-3">
            <i class="bi bi-arrow-left"></i> Back
        </a>
        <h3 style="color:red;">Account already activated. Please login.</h3>
    </div>
<%
    return;
}

/* DETAILS MATCHED — SEND OTP */
int otp = new Random().nextInt(900000) + 100000;

/* SAVE SESSION */
session.setAttribute("reg_student_id", rs.getInt("student_id"));
session.setAttribute("reg_otp", otp);

/* EMAIL CONFIG */
final String from = "next.genvoting25@gmail.com";
final String pass = "tppbvigkepblyfak";

Properties props = new Properties();
props.put("mail.smtp.host", "smtp.gmail.com");
props.put("mail.smtp.port", "587");
props.put("mail.smtp.auth", "true");
props.put("mail.smtp.starttls.enable", "true");

Session mailSession = Session.getInstance(props, new Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(from, pass);
    }
});

Message msg = new MimeMessage(mailSession);
msg.setFrom(new InternetAddress(from));
msg.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
msg.setSubject("NextGen Voting - OTP Verification");
msg.setText("Your OTP is : " + otp);

Transport.send(msg);

response.sendRedirect("verifyOtpRegister.jsp");
%>