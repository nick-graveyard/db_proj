<%@ page import="com.Company.CompanyDAO" %>
<%@ page import="com.Job.JobDAO" %>
<%@ page import="com.Job.Job" %>
<%@ page import="com.Company.Company" %>
<%@ page import="com.Person.Person" %>
<%@ page import="java.util.*" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="/companyHeader.jsp"/>
<html>
<head><script src="sortable.js"></script></head>
<body>
<form method="get" action="showCompanyDetails.jsp"> 
<%
try{
String id = session.getAttribute("id").toString();
if(id!=null && !id.isEmpty())  
{CompanyDAO companyDAO = new CompanyDAO();
Company company = companyDAO.getCompanyDetails(id);
%>
<h4 align="left">> Basic Information</h4>
<table>
		<tr><td>Company ID: </td><td><%= company.getCompany_id() %></td></tr>
		<tr><td>Company Name: </td><td><%= company.getCompany_name() %></td></tr>
		<tr><td>Street Address: </td><td><%= company.getStreet_address() %></td></tr>
		<tr><td>Zip Code: </td><td><%= company.getZip() %></td></tr>
		<tr><td>City: </td><td><%= company.getCity() %></td></tr>
		<tr><td>State: </td><td><%= company.getState() %></td></tr>
		<tr><td>Website: </td><td><%= company.getWebsite() %></td></tr>
		<tr><td>GSA: </td><td><%= company.getGSA() %></td></tr>
</table>	<%
}
}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
%>

</form>
</body></html>