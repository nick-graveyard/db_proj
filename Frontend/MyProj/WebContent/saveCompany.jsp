<%@ page import="com.Company.CompanyDAO" %>

<jsp:include page="/header.jsp"/>
<jsp:useBean id="company" class="com.Company.Company" scope="session"/> 
<jsp:setProperty name="company" property="*"/>
<html><body>
<%
try{
CompanyDAO companyDAO = new CompanyDAO();
companyDAO.addCompany(company);
}
catch (Exception e){
	response.sendRedirect("error.jsp");
}
%>
<b> A new profile has been created.</b>
</body></html>