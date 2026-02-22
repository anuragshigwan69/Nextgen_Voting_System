<%@ page import="java.sql.*" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page import="java.util.Base64" %>

<%
String p1 = request.getParameter("pass1");
String p2 = request.getParameter("pass2");
String email = (String) session.getAttribute("forgotEmail");

/* Safety checks */
if(email == null){
    out.println("Session expired. Please try again.");
    return;
}

if(p1 == null || p2 == null || p1.trim().equals("") || p2.trim().equals("")){
    out.println("Password cannot be empty!");
    return;
}

if(!p1.equals(p2)){
    out.println("Passwords do not match!");
    return;
}

/* ===== HASH PASSWORD (SAME AS LOGIN) ===== */
MessageDigest md = MessageDigest.getInstance("SHA-256");
byte[] hashBytes = md.digest(p1.getBytes("UTF-8"));
String hashedPassword = Base64.getEncoder().encodeToString(hashBytes);

/* DB connection */
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/votingdb","root","root");

/* Update password */
PreparedStatement ps = con.prepareStatement(
    "UPDATE students SET password=? WHERE email=?");

ps.setString(1, hashedPassword);
ps.setString(2, email);
ps.executeUpdate();

/* Clear session */
session.invalidate();

/* Redirect to correct login page */
response.sendRedirect("studentLogin.jsp?msg=Password+updated+successfully");
%>
