<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
String enteredOtp = request.getParameter("otp");

Integer sessionOtp = (Integer) session.getAttribute("otp");
Long otpTime = (Long) session.getAttribute("otpTime");

if(sessionOtp == null || otpTime == null){
    response.sendRedirect("studentLogin.jsp?msg=Session+expired");
    return;
}

// ⏱ OTP expiry (5 minutes)
long currentTime = System.currentTimeMillis();
long diff = currentTime - otpTime;

if(diff > 5 * 60 * 1000){
    session.invalidate();
    response.sendRedirect("studentLogin.jsp?msg=OTP+expired+please+login+again");
    return;
}

if(enteredOtp.equals(String.valueOf(sessionOtp))){

    // ✅ OTP VERIFIED — FINAL LOGIN
    session.removeAttribute("otp");
    session.removeAttribute("otpTime");

    session.setAttribute("studentLoggedIn", true);

    response.sendRedirect("studentDashboard.jsp");

}else{
    response.sendRedirect("otp.jsp?msg=Invalid+OTP");
}
%>
