<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Properties" %>

<%@ page import="jakarta.mail.*" %>
<%@ page import="jakarta.mail.internet.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
String name = request.getParameter("name").trim();
String zprn = request.getParameter("zprn").trim();
String email = request.getParameter("email").trim();
String password = request.getParameter("password").trim();

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    /* ===== PASSWORD HASH (UNCHANGED) ===== */
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
    String hashedPassword = Base64.getEncoder().encodeToString(hashBytes);

    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/votingdb", "root", "root");

    String sql = "SELECT student_id, has_voted, email FROM students " +
                 "WHERE name=? AND zprn=? AND password=?";
    ps = con.prepareStatement(sql);
    ps.setString(1, name);
    ps.setString(2, zprn);
    ps.setString(3, hashedPassword);

    rs = ps.executeQuery();

    if(rs.next()) {

        if(rs.getInt("has_voted") == 1){
            response.sendRedirect("studentLogin.jsp?msg=You+have+already+voted");
            return;
        }

        String dbEmail = rs.getString("email");
        if(dbEmail == null || !dbEmail.equalsIgnoreCase(email)){
            response.sendRedirect("studentLogin.jsp?msg=Email+does+not+match");
            return;
        }

        /* ===== OTP ===== */
        int otp = (int)(Math.random() * 900000) + 100000;

        session.setAttribute("otp", otp);
        session.setAttribute("otpTime", System.currentTimeMillis());
        session.setAttribute("studentId", rs.getInt("student_id"));
        session.setAttribute("studentName", name);

        /* ===== MAIL CONFIG ===== */
        final String fromEmail = "next.genvoting25@gmail.com";
        final String appPassword = "drjrwlfzoduaisyx";   // change

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        jakarta.mail.Session mailSession =
            jakarta.mail.Session.getInstance(props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(fromEmail, appPassword);
                    }
                });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(
            Message.RecipientType.TO,
            InternetAddress.parse(email)
        );
        message.setSubject("NextGen Voting System - OTP Verification");

        message.setText(
            "Dear " + name + ",\n\n" +
            "Your OTP is: " + otp + "\n\n" +
            "Valid for 5 minutes.\n\n" +
            "NextGen Voting System"
        );

        Transport.send(message);

        response.sendRedirect("otp.jsp");

    } else {
        response.sendRedirect("studentLogin.jsp?msg=Invalid+credentials");
    }

} catch(Exception e){
    e.printStackTrace();
    response.sendRedirect("studentLogin.jsp?msg=Server+Error");
} finally {
    try{ if(rs!=null) rs.close(); }catch(Exception e){}
    try{ if(ps!=null) ps.close(); }catch(Exception e){}
    try{ if(con!=null) con.close(); }catch(Exception e){}
}
%>
