package com.votingsystem;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/VoteServlet")
public class VoteServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("studentLogin.jsp");
            return;
        }

        int studentId = (int) session.getAttribute("studentId");
        int candidateId = Integer.parseInt(request.getParameter("candidate_id"));
        int positionId = Integer.parseInt(request.getParameter("position_id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb", "root", "root");

            //  CHECK IF STUDENT ALREADY VOTED FOR THIS POSITION
            PreparedStatement checkPs = con.prepareStatement(
                "SELECT * FROM votes WHERE student_id = ? AND position_id = ?");
            checkPs.setInt(1, studentId);
            checkPs.setInt(2, positionId);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                response.getWriter().println("<script>"
                        + "alert('You have already voted for this position!');"
                        + "window.location.href='studentDashboard.jsp';"
                        + "</script>");
                return;
            }

            //  INSERT VOTE
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO votes (student_id, candidate_id, position_id) VALUES (?, ?, ?)");
            ps.setInt(1, studentId);
            ps.setInt(2, candidateId);
            ps.setInt(3, positionId);

            ps.executeUpdate();
            con.close();

            response.getWriter().println("<script>"
                    + "alert('Vote cast successfully!');"
                    + "window.location.href='studentDashboard.jsp';"
                    + "</script>");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
