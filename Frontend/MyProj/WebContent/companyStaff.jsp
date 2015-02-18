<%@ page import="com.Company.CompanyDAO" %>
<%@ page import="com.Job.JobDAO" %>
<%@ page import="com.Job.Job" %>
<%@ page import="com.Company.Company" %>
<%@ page import="com.Person.Person" %>
<%@ page import="com.Person.Employee" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.ResultSet" %>
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
%>
<h4 align="left">> Employees</h4>
<%
ArrayList<Employee> employeeList = companyDAO.getEmployees(id,"salary");

if(!employeeList.isEmpty()){
	%><table class="sortable">
	<thead><tr><td>Last Name</td><td>First Name</td><td>Position</td><td>Salary</td></tr></thead><tbody><%
	Iterator<Employee> iterator = employeeList.iterator();
	while(iterator.hasNext()){
		Employee employee = iterator.next();
		%>
			<tr>
			<td><%= employee.getlName() %></td>
			<td><%= employee.getfName()%></td>
			<td><%= employee.getPosition()%></td>
			<td><%= employee.getPay_rate()%></td>
			</tr>
		<%
	}
%>
</tbody>
</table>
<%
}
else{
	%><p align = "left"> No results found.</p><%
}
%>
<h4 align="left">> Workers</h4>
<%
ArrayList<Employee> workerList = companyDAO.getEmployees(id,"wage");

if(!workerList.isEmpty()){
	%><table class="sortable">
	<thead><tr><td>Last Name</td><td>First Name</td><td>Position</td><td>Wage</td></tr></thead><tbody><%
	Iterator<Employee> iterator = workerList.iterator();
	while(iterator.hasNext()){
		Employee employee = iterator.next();
		%>
			<tr>
			<td><%= employee.getlName() %></td>
			<td><%= employee.getfName()%></td>
			<td><%= employee.getPosition()%></td>
			<td><%= employee.getPay_rate()%></td>
			</tr>
		<%
	}
%>
</tbody>
</table>
<%
}
else{
	%><p align = "left"> No results found.</p><%
}
}
}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
%>

</form>
</body></html>