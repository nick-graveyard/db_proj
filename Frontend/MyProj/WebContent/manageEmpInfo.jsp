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
if(id!=null && !id.isEmpty()) { 
	JobDAO jobDAO = new JobDAO();
	ArrayList<Job> jobList = jobDAO.getPersonJobs(id);
	%><h4 align="left">> Current Employment Information</h4><%
	if(!jobList.isEmpty()){
		%>
		<table class="sortable">
		<thead>
		<tr><td>Company Name</td><td>Position</td><td>Job Code</td><td>Pay Rate</td><td>Pay Type</td></tr></thead><tbody><%
		Iterator<Job> jobIterator = jobList.iterator();
		while(jobIterator.hasNext()){
			Job job = jobIterator.next();
		%>
		<tr>
		<td><%= job.getCompany_name() %></td>
		<td><%= job.getPosition()%></td>
		<td><%= job.getJob_code()%></td>
		<td><%= job.getPay_rate()%></td>
		<td><%= job.getPay_type()%></td>
		</tr>
		<%
		}
	%>
	</tbody>
	</table>
	<%} else {%> <p align="left">No results found.</p><%}

	
	ArrayList<Job> appliedJobList = jobDAO.getAppliedJobs(id);
	%><h4 align="left">> Applied Jobs</h4><%
	if(!appliedJobList.isEmpty()){
		%>
		<table class="sortable">
		<thead>
		<tr><td>Company Name</td><td>Position</td><td>Job Code</td><td>Pay Rate</td><td>Pay Type</td><td>Status</td></tr></thead><tbody><%
		Iterator<Job> jobIterator = appliedJobList.iterator();
		while(jobIterator.hasNext()){
			Job job = jobIterator.next();
		%>
		<tr>
		<td><%= job.getCompany_name() %></td>
		<td><%= job.getPosition()%></td>
		<td><%= job.getJob_code()%></td>
		<td><%= job.getPay_rate()%></td>
		<td><%= job.getPay_type()%></td>
		<td><%= job.getStatus() %></td>
		<td><a href="removeApplication.jsp?job_code=<%= job.getJob_code()%>">&nbsp;&nbsp;Remove</a>
		</tr>
		<%
		}
	%>
	</tbody>
	</table>
	<%} else {%> <p align="left">No results found.</p><%}
}
}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
%>
</form>
</body></html>