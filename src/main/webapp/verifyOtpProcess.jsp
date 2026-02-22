<%
int enteredOtp = Integer.parseInt(request.getParameter("otp"));
int sessionOtp = (int)session.getAttribute("reg_otp");

if(enteredOtp == sessionOtp){
    response.sendRedirect("setPassword.jsp");
}else{
    out.println("<h3 style='color:red;text-align:center'>Invalid OTP</h3>");
}
%>
