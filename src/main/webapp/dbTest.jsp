<%@ page import="java.sql.*" %>
<%! Connection con = null; %>   <!-- Global declaration -->
<%
    try {
        if (con == null || con.isClosed()) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/votingdb",
                "root",   // DB username
                "root"    // DB password
            );
        }
    } catch(Exception e) {
        out.println("<h2 style='color:red'> Database connection error: " + e.getMessage() + "</h2>");
    }
%>