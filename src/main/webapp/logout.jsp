<%
    // Destroy admin session
    session.invalidate();

    // Redirect to login page
    response.sendRedirect("index.jsp");
%>
