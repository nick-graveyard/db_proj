<%@ page import="com.Security.SecurityDAO" %>
<html>
<head>
<style type="text/css">
<%@include file="/main.css" %>
</style>
</head>
<body style="text-align: center; margin-left: auto; margin-right: auto;">
<br><br><br><br><br><h3>Loading...</h3>
<% 
try{
String id= request.getParameter("id");
	SecurityDAO securityDAO = new SecurityDAO();
	if(id!=null && id!="" && securityDAO.verifyCompanyID(id)){
		session.setAttribute("id",id);
		response.sendRedirect("showCompanyDetails.jsp");
	}
	else{
		response.sendRedirect("index.jsp");
	}
}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
	%>
</body>
</html>