<%@ page import="java.sql.*, java.util.*, javax.mail.*, javax.mail.internet.*" %>
<%
String name = request.getParameter("name").trim();
String zprn = request.getParameter("zprn").trim();
String email = request.getParameter("email").trim();
String password = request.getParameter("password").trim();

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/votingdb", "root", "root");

    // Check if student exists
    ps = con.prepareStatement("SELECT password FROM students WHERE zprn=?");
    ps.setString(1, zprn);
    rs = ps.executeQuery();

    if (!rs.next()) {
        response.sendRedirect("studentRegister.jsp?msg=Student not found. Contact admin.");
        return;
    }

    // Already registered
    if (rs.getString("password") != null) {
        response.sendRedirect("studentRegister.jsp?msg=Already registered. Please login.");
        return;
    }

    // Store details in session for OTP verification
    session.setAttribute("name", name);
    session.setAttribute("zprn", zprn);
    session.setAttribute("email", email);
    session.setAttribute("password", password);

    // Generate OTP
    int otp = 100000 + new Random().nextInt(900000);
    session.setAttribute("otp", otp);

    // Send OTP via email (JavaMail API)
    try {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("yourEmail@gmail.com", "yourAppPassword");
            }
        });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress("yourEmail@gmail.com"));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("Your OTP for NextGen Voting");
        message.setText("Your OTP is: " + otp);

        Transport.send(message);
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("studentRegister.jsp?msg=Failed to send OTP.");
        return;
    }

    // Redirect to OTP verification page
    response.sendRedirect("verifyOtp.jsp");

} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("studentRegister.jsp?msg=Something went wrong.");
} finally {
    if (rs != null) try { rs.close(); } catch (Exception ignore) {}
    if (ps != null) try { ps.close(); } catch (Exception ignore) {}
    if (con != null) try { con.close(); } catch (Exception ignore) {}
}
%>