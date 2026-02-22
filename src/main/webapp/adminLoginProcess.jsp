<%@ page import="java.sql.*" %>

<%
    String username = request.getParameter("username");
    String adminCode = request.getParameter("adminCode");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/votingdb",
            "root",
            "root"
        );

        ps = con.prepareStatement(
            "SELECT * FROM admins WHERE username=? AND admin_code=?"
        );
        ps.setString(1, username);
        ps.setString(2, adminCode);

        rs = ps.executeQuery();

        if(rs.next()){
            // Create session
            session.setAttribute("adminId", rs.getInt("admin_id"));
            session.setAttribute("adminUser", rs.getString("username"));

            response.sendRedirect("adminDashboard.jsp");
        } else {
%>
            <script>
                alert("Invalid Admin Credentials!");
                window.location.href="adminLogin.jsp";
            </script>
<%
        }
    } catch(Exception e){
        out.println("Error: " + e);
    }
%>
