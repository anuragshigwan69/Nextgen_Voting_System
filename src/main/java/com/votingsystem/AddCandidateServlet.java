package com.votingsystem;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
@WebServlet("/AddCandidateServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  // 1MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 15     // 15MB
)
public class AddCandidateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        int positionId = Integer.parseInt(request.getParameter("position"));
        String description = request.getParameter("description");

        Part filePart = request.getPart("photo");
        String fileName = System.currentTimeMillis() + "_" +
                filePart.getSubmittedFileName().replaceAll("[^a-zA-Z0-9\\.\\-_]", "_");

        // Save image in webapp/images
        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/votingdb", "root", "root");

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO candidates(name, position_id, description, photo) VALUES(?,?,?,?)");
            ps.setString(1, name);
            ps.setInt(2, positionId);
            ps.setString(3, description);
            ps.setString(4, fileName);

            ps.executeUpdate();
            con.close();

            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<script>"
                    + "alert('Candidate added successfully!');"
                    + "window.location.href='adminDashboard.jsp';"
                    + "</script>");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<div style='color:red;text-align:center;'>Error: "
                    + e.getMessage() + "</div>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("addCandidate.jsp");
    }
}
