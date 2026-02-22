<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // 1️⃣ Check if student is logged in
    if(session.getAttribute("studentId") == null){
        response.sendRedirect("studentLogin.jsp?msg=Please login first.");
        return;
    }

    int studentId = (Integer) session.getAttribute("studentId");
    int candidateId = 0;

    try {
        candidateId = Integer.parseInt(request.getParameter("candidate_id"));
    } catch(Exception e) {
        response.sendRedirect("studentDashboard.jsp?msg=Invalid candidate selection.");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/votingdb", "root", "root"
        );

        // 2️⃣ Check if election is active
        ps = con.prepareStatement("SELECT status FROM election_status WHERE id=1");
        rs = ps.executeQuery();

        if(rs.next()){
            String status = rs.getString("status");
            if(!"active".equalsIgnoreCase(status)){
                response.sendRedirect("studentDashboard.jsp?msg=Election is not active currently.");
                return;
            }
        } else {
            response.sendRedirect("studentDashboard.jsp?msg=Election status not found.");
            return;
        }

        // 3️⃣ Check if student has already voted
        ps = con.prepareStatement("SELECT has_voted FROM students WHERE student_id=?");
        ps.setInt(1, studentId);
        rs = ps.executeQuery();

        if(rs.next() && rs.getInt("has_voted") == 1){
            response.sendRedirect("studentDashboard.jsp?msg=You have already voted.");
            return;
        }

        // 4️⃣ Record vote in a transaction
        con.setAutoCommit(false);

        ps = con.prepareStatement("UPDATE candidates SET votes = votes + 1 WHERE candidate_id=?");
        ps.setInt(1, candidateId);
        int voteUpdated = ps.executeUpdate();

        if(voteUpdated == 0){
            con.rollback();
            response.sendRedirect("studentDashboard.jsp?msg=Invalid candidate. Vote not recorded.");
            return;
        }

        ps = con.prepareStatement("UPDATE students SET has_voted=1 WHERE student_id=?");
        ps.setInt(1, studentId);
        ps.executeUpdate();

        con.commit();

        response.sendRedirect("studentDashboard.jsp?msg=Vote submitted successfully!");

    } catch(Exception e){
        if(con != null) con.rollback();
        e.printStackTrace();
        response.sendRedirect("studentDashboard.jsp?msg=Vote failed due to an error.");
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(con != null) con.close();
    }
%>
