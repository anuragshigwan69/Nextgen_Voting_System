<%@ page import="java.sql.*" %>
<%@ include file="dbTest.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    if(session.getAttribute("adminId") == null){
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String idParam = request.getParameter("id");
    String message = null;

    if(idParam != null){
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            // 1. Check if election is active
            String statusSql = "SELECT status FROM election_status LIMIT 1";
            ps = con.prepareStatement(statusSql);
            rs = ps.executeQuery();
            boolean electionActive = false;
            if(rs.next()){
                String status = rs.getString("status");
                electionActive = "active".equalsIgnoreCase(status);
            }
            rs.close();
            ps.close();

            if(electionActive){
                message = "Cannot remove candidate while election is ACTIVE.";
            } else {
                // 2. Proceed with removal
                int candidateId = Integer.parseInt(idParam);
                String sql = "DELETE FROM candidates WHERE candidate_id = ?";
                ps = con.prepareStatement(sql);
                ps.setInt(1, candidateId);
                int rows = ps.executeUpdate();

                if(rows > 0){
                    message = "Candidate removed successfully.";
                } else {
                    message = "No candidate found with ID " + candidateId;
                }
            }
        }catch(Exception e){
            message = "Error: " + e.getMessage();
        }finally{
            try{ if(ps != null) ps.close(); }catch(Exception e){}
        }

        // Redirect back to addCandidate.jsp with message
        session.setAttribute("removeCandidateMessage", message);
        response.sendRedirect("addCandidate.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Remove Candidate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="alert alert-warning text-center">
        No candidate ID provided. Please go back and try again.
    </div>
    <div class="text-center">
        <a href="addCandidate.jsp" class="btn btn-secondary">← Back to Candidates</a>
    </div>
</div>
</body>
</html>