<%@ page import="java.sql.*" %>
<%@ include file="dbTest.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
if(session.getAttribute("adminId") == null){
    response.sendRedirect("adminLogin.jsp");
    return;
}

String zprn = request.getParameter("zprn");
if(zprn == null || zprn.trim().isEmpty()){
    response.sendRedirect("viewStudents.jsp?msg=Invalid+ZPRN");
    return;
}

PreparedStatement ps = null;
try {
    ps = con.prepareStatement("DELETE FROM students WHERE zprn = ?");
    ps.setString(1, zprn);
    int rows = ps.executeUpdate();
    ps.close();

    if(rows > 0){
        response.sendRedirect("viewStudents.jsp?msg=Student+removed+successfully");
    } else {
        response.sendRedirect("viewStudents.jsp?msg=Student+not+found");
    }
} catch(Exception e){
    response.sendRedirect("viewStudents.jsp?msg=Error+removing+student");
} finally {
    try{ if(ps != null) ps.close(); }catch(Exception e){}
}
%>