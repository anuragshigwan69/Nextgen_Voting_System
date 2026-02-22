<%@ page import="java.sql.*, java.security.MessageDigest, java.util.Base64" %>
<%
String pass = request.getParameter("password");
String confirm = request.getParameter("confirm");

if(pass == null || !pass.equals(confirm)){
    out.println("<h3 style='color:red'>Password mismatch</h3>");
    return;
}

/* HASH PASSWORD */
MessageDigest md = MessageDigest.getInstance("SHA-256");
String hashed = Base64.getEncoder()
        .encodeToString(md.digest(pass.getBytes()));

/* DB */
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/votingdb","root","root");

/* UPDATE PASSWORD ONLY ONCE */
PreparedStatement ps = con.prepareStatement(
    "UPDATE students SET password=? " +
    "WHERE student_id=? AND password IS NULL"
);

ps.setString(1, hashed);
ps.setInt(2, (Integer)session.getAttribute("reg_student_id"));

int updated = ps.executeUpdate();

if(updated == 0){
    out.println("<h3 style='color:red'>Invalid session or password already set</h3>");
    return;
}

ps.close();
con.close();
session.invalidate();

response.sendRedirect("studentLogin.jsp");
%>
