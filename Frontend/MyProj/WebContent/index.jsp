<jsp:include page="/header.jsp" />
<html><head><style type="text/css"><%@include file="main.css" %></style></head>
<body style="text-align: center; margin-left: auto; margin-right: auto;">
<br><br><br><br><br>
<form method="get" action="employeeLogin.jsp">
<font size="5">Personal ID</font>
<input type="text" id="id" name = "id" size = "8"/><br>
<font size="2"><a href="addPerson.jsp">(Sign Up)</a></font>
</form><br><br><br>
<form method="get" action="companyLogin.jsp">
<font size="5">Company ID</font>
<input type="text" id="id" name = "id" size = "8"/><br>
<font size="2"><a href="addCompany.jsp">(Sign Up)</a></font>
</form>

</body>
</html>