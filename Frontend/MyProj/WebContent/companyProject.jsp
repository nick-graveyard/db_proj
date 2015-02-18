<%@ page import="com.Company.CompanyDAO" %>
<%@ page import="com.Job.JobDAO" %>
<%@ page import="com.Job.Job" %>
<%@ page import="com.Company.Company" %>
<%@ page import="com.Company.Project" %>
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
<p align="left"><a href="companyNewProject.jsp">Plan and Create a New Project</a></p>
<%
try{
String id = session.getAttribute("id").toString();
if(id!=null && !id.isEmpty())  
{CompanyDAO companyDAO = new CompanyDAO();
%>
<h4 align="left">> Projects</h4>
<%
ArrayList<Project> projectList = companyDAO.getProjects(id);

if(!projectList.isEmpty()){
	%><table class="sortable">
	<thead><tr><td>Project Code</td><td>Title</td><td>Budget</td><td>Start Date</td><td>End Date</td></tr></thead><tbody><%
	Iterator<Project> iterator = projectList.iterator();
	while(iterator.hasNext()){
		Project project = iterator.next();
		%>
			<tr>
			<td><%= project.getProject_id() %></td>
			<td><%= project.getTitle()%></td>
			<td><%= project.getBudget()%></td>
			<td><%= project.getStart_Date()%></td>
			<td><%= project.getEnd_date()%></td>
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
<!-- <h4 align="left">> Project Staff</h4> -->
<%

}
}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
%>

</form>
</body></html>