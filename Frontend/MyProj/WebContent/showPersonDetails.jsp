<%@ page import="com.Person.PersonDAO" %>
<%@ page import="com.Job.JobDAO" %>
<%@ page import="com.Person.Person" %>
<%@ page import="com.Person.Skill" %>
<%@ page import="com.Person.Certificate" %>
<%@ page import="com.Job.Job" %>
<%@ page import="java.util.*" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="/employeeHeader.jsp"/>
<html>
<head><script src="sortable.js"></script></head>
<body>
<form method="get" action="showPersonDetails.jsp"> 
<%
try{
String id = session.getAttribute("id").toString();
if(id!=null && !id.isEmpty())  
{PersonDAO personDAO = new PersonDAO();
Person person = personDAO.getPersonDetails(id);

if(person != null){

%>
<h4 align="left">> Basic Information</h4>
<table>
		<tr><td>Personal ID: </td><td><%= person.getPerson_id() %></td></tr>
		<tr><td>First Name: </td><td><%= person.getfName() %></td></tr>
		<tr><td>Last Name: </td><td><%= person.getlName() %></td></tr>
		<tr><td>Gender: </td><td><%= person.getGender() %></td></tr>
		<tr><td>DOB: </td><td><%= person.getDOB() %></td></tr>
		<tr><td>Designation: </td><td><%= person.getDesignation() %></td></tr>
</table>	

<h4 align="left">> Contact Information</h4>
<table>
		<tr><td>Street Address: </td><td><%= person.getStreet_address() %></td></tr>
		<tr><td>Zip Code: </td><td><%= person.getZip() %></td></tr>
		<tr><td>City: </td><td><%= person.getCity() %></td></tr>
		<tr><td>State: </td><td><%= person.getState() %></td></tr>
		<tr><td>Email: </td><td><%= person.getEmail() %></td></tr>
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