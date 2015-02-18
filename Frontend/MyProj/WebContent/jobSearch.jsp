<%@ page import="com.Person.PersonDAO" %>
<%@ page import="com.Job.JobDAO" %>
<%@ page import="com.Person.Person" %>
<%@ page import="com.Person.Skill" %>
<%@ page import="com.Person.Certificate" %>
<%@ page import="com.Job.Job" %>
<%@ page import="com.Job.Position" %>
<%@ page import="java.util.*" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="/employeeHeader.jsp"/>
<html>
<head><script src="sortable.js"></script></head>
<body>
<form>
<%
try{
String id = session.getAttribute("id").toString();
JobDAO jobDAO = new JobDAO();
ArrayList<Job> qualifiedJobList = jobDAO.getQualifiedJobs(id);
if(id!=null && !id.isEmpty()) { 
	%><h4 align="left">> Qualified Jobs</h4><%
	if(qualifiedJobList!=null){
		%>
		<table class="sortable">
		<thead>
		<tr><td>Company Name</td><td>Position</td><td>Job Code</td><td>Pay Rate</td><td>Pay Type</td></tr></thead><tbody><%
		Iterator<Job> qualifiedJobIterator = qualifiedJobList.iterator();
		ArrayList<Job> appliedJobList = jobDAO.getAppliedJobs(id);
		while(qualifiedJobIterator.hasNext()){
		Job job = qualifiedJobIterator.next();
		%>
		<tr>
		<td><%= job.getCompany_name() %></td>
		<td><%= job.getPosition()%></td>
		<td><%= job.getJob_code()%></td>
		<td><%= job.getPay_rate()%></td>
		<td><%= job.getPay_type()%></td>
		<td><% 
		String status = null;
		Iterator<Job> appliedJobIterator = appliedJobList.iterator();
		while(appliedJobIterator.hasNext()){
			Job appliedJob = appliedJobIterator.next();
			if(appliedJob.getJob_code().toString().equals(job.getJob_code().toString())){
				status = appliedJob.getStatus();
			}
		}
		if(status==null){%><a href="addApplication.jsp?job_code=<%=job.getJob_code()%>">Apply</a><%}
		else{%><%=status %><%} %></td>
		</tr>
		<%
		}
	%>
	</tbody>
	</table>
	<%} else {%> <p align="left">No results found.</p><%}}}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}%>
</form>
<form>
<%
try{
	JobDAO jobDAO = new JobDAO();
	ArrayList<Position> positionList = jobDAO.getAllPositions();	

%>
<h4 align="left">> Job Search</h4>
<p align="left">Company Name: <input type="text" name="company_name" id="company_name">&nbsp;&nbsp;
				Position: <select name="position_code" id="position_code">
								<option value="ALL">ALL</option>
								<%		Iterator<Position> positionIterator = positionList.iterator();
								while(positionIterator.hasNext()){
									Position position = positionIterator.next();
								%>
								<option value="<%=position.getPosition_code()%>"><%=position.getTitle() %></option>
								<%} %>
						  </select>
<input type="submit" name="submit" id="submit" value="Search"></p>	
<%}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
} %>			
				
</form>
<form method="get" action="showPersonDetails.jsp"> 
<%
try{
String id = session.getAttribute("id").toString();
String company_name = request.getParameter("company_name");
String position_code = request.getParameter("position_code");
if(id!=null && !id.isEmpty() && position_code!=null) { 

	JobDAO jobDAO = new JobDAO();
	ArrayList<Job> jobList = jobDAO.getJobListForCriteria(company_name,position_code);
	ArrayList<Job> appliedJobList = jobDAO.getAppliedJobs(id);
	%><h4 align="left">> Results of Job Search</h4><%
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
		<td><% 
		String status = null;
		Iterator<Job> appliedJobIterator = appliedJobList.iterator();
		while(appliedJobIterator.hasNext()){
			Job appliedJob = appliedJobIterator.next();
			if(appliedJob.getJob_code().toString().equals(job.getJob_code().toString())){
				status = appliedJob.getStatus();
			}
		}
		if(status==null){%><a href="addApplication.jsp?job_code=<%=job.getJob_code()%>">Apply</a><%}
		else{%><%=status %><%} %></td>
		</tr>
		<%
		}
	%>
	</tbody>
	</table>
	<%} else {%> <p align="left">No results found.</p><%}
	
}}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
%>
</form>
</body></html>