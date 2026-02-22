<%
int enteredOtp = Integer.parseInt(request.getParameter("otp"));
int sessionOtp = (int) session.getAttribute("forgotOtp");

if(enteredOtp == sessionOtp){
    response.sendRedirect("resetPassword.jsp");
}else{
    out.println("Invalid OTP!");
}
%>
