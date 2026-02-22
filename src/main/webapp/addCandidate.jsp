<%@ page import="java.sql.*" %>
<%@ include file="dbTest.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
if(session.getAttribute("adminId") == null){
    response.sendRedirect("adminLogin.jsp");
    return;
}

PreparedStatement ps = null;
ResultSet rs = null;

// Check election status
boolean electionActive = false;
try {
    String statusSql = "SELECT status FROM election_status LIMIT 1";
    ps = con.prepareStatement(statusSql);
    rs = ps.executeQuery();
    if(rs.next()){
        electionActive = "active".equalsIgnoreCase(rs.getString("status"));
    }
    rs.close();
    ps.close();
} catch(Exception e){
    out.println("<div class='alert alert-danger text-center'>Error checking election status: " + e.getMessage() + "</div>");
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Candidate | Admin</title>

    <!-- Bootstrap & Icons & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body{
            font-family:'Poppins',sans-serif;
            background: linear-gradient(180deg,#eaf6ff,#cfe9fb);
            min-height:100vh;
            color:#1f2d3d;
        }

        .form-box {
            max-width: 600px;
            margin: 60px auto;
            background: #eaf6ff;
            padding: 40px 30px;
            border-radius: 25px;
            box-shadow: 8px 8px 25px rgba(0,0,0,0.08),
                        -8px -8px 25px rgba(255,255,255,0.9);
        }

        .title {
            font-size: 28px;
            font-weight: 700;
            color: #1f3c88;
            text-align: center;
            margin-bottom: 30px;
        }

        .form-control {
            border-radius: 15px;
            padding: 12px 15px;
            border: 1px solid #b6dcf7;
        }

        .btn-main {
            background-color: #1f3c88;
            color: white;
            border-radius: 25px;
            padding: 12px;
            font-weight: 600;
        }

        .btn-main:disabled {
            background-color: #9aa7c7;
        }

        .back-link {
            text-decoration: none;
            color: #1f3c88;
            font-weight: 500;
        }
        /* BUTTON */
.btn-main {
    background: linear-gradient(135deg,#1E40AF,#6366F1);
    color: #fff;
    border-radius: 25px;
    padding: 12px;
    font-weight: 600;
    transition: 0.3s;
}
.btn-main:hover {
    background: #10B981;
    transform: scale(1.03);
}

/* BACK LINK */
.back-link {
    text-decoration: none;
    color: #1E40AF;
    font-weight: 500;
}
.back-link:hover {
    text-decoration: underline;
    color: #10B981;
}

/* TABLE */
.table thead {
    background: #f3f4f6;
}
.table th {
    color: #1F2937;
}
.table td {
    color: #374151;
}
        
    </style>
</head>

<body>

<!-- Election Status Banner -->
<div class="container mt-3">
    <% if(electionActive){ %>
        <div class="alert alert-warning text-center">
            🚨 Election is ACTIVE — Adding or Removing candidates is disabled.
        </div>
    <% } else { %>
        <div class="alert alert-info text-center">
            ✅ Election is INACTIVE — You can manage candidates.
        </div>
    <% } %>
</div>
<div class="form-box">
    <div class="title">Add New Candidate</div>

    <form action="AddCandidateServlet" method="post" enctype="multipart/form-data">

        <div class="mb-3">
            <input type="text"
                   name="name"
                   class="form-control"
                   placeholder="Candidate Name"
                   required
                   <%= electionActive ? "disabled" : "" %>>
        </div>

        <div class="mb-3">
            <select name="position"
                    class="form-control"
                    required
                    <%= electionActive ? "disabled" : "" %>>
                <option value="">Select Position</option>
                <option value="1">President</option>
                <option value="2">Vice President</option>
                <option value="3">General Secretary</option>
                <option value="4">Joint Secretary</option>
                <option value="5">Creative Head</option>
                <option value="6">Media Head</option>
                <option value="7">Technical Head</option>
                <option value="8">Cultural Secretary</option>
                <option value="9">Content Head</option>
                <option value="10">Treasurer</option>
            </select>
        </div>

        <div class="mb-3">
            <textarea name="description"
                      class="form-control"
                      rows="4"
                      placeholder="Candidate Description / Achievements"
                     ></textarea>
        </div>

        <div class="mb-3">
            <input type="file"
                   name="photo"
                   class="form-control"
                   accept="image/*"
                   required
                  >
        </div>

        <button type="submit"
                class="btn btn-main w-100"
                >
            Add Candidate
        </button>

        <div class="text-center mt-3">
            <a href="adminDashboard.jsp" class="back-link">
                ← Back to Dashboard
            </a>
        </div>
        <div class="container mt-5">
    <h3 class="text-center text-primary mb-4">Candidate List</h3>
    <table class="table table-bordered table-striped">
        <thead class="table-light">
            <tr>
                <th style="width:180px; text-align:center;">Photo</th>
                <th>Name</th>
                <th>Position</th>
                <th>Description</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    String sql = "SELECT c.candidate_id, c.name, c.photo, c.description, p.position_name " +
                                 "FROM candidates c JOIN positions p ON c.position_id = p.position_id";
                    ps = con.prepareStatement(sql);
                    rs = ps.executeQuery();
                    boolean hasData = false;
                    while(rs.next()){
                        hasData = true;
            %>
            <tr>
                <td style="text-align:center;">
                    <img src="images/<%= rs.getString("photo") %>" 
                         alt="Photo" 
                         width="150" height="150" 
                         class="rounded shadow-sm border border-2">
                </td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("position_name") %></td>
                <td><%= rs.getString("description") %></td>
                <td>
                    <% if(electionActive){ %>
                        <button class="btn btn-sm btn-secondary" disabled>Remove Disabled</button>
                    <% } else { %>
                        <form method="post" action="removeCandidate.jsp" onsubmit="return confirm('Remove candidate <%= rs.getString("name") %>?');">
                            <input type="hidden" name="id" value="<%= rs.getInt("candidate_id") %>">
                            <button type="submit" class="btn btn-sm btn-danger">🗑 Remove</button>
                        </form>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                    if(!hasData){
            %>
            <tr>
                <td colspan="5" class="text-center">No candidates added yet.</td>
            </tr>
            <%
                    }
                } catch(Exception e){
                    out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    try{ if(rs != null) rs.close(); }catch(Exception e){}
                    try{ if(ps != null) ps.close(); }catch(Exception e){}
                }
            %>
        </tbody>
    </table>

    <!-- Back to Dashboard option in between -->
    
</div>
    </form>
</div>

</body>
</html>
