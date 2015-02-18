<%@ page import="com.Person.PersonDAO" %>
<%@ page import="com.Course.Session" %>
<%@ page import="com.Job.JobDAO" %>
<%@ page import="com.Person.Person" %>
<%@ page import="com.Person.Skill" %>
<%@ page import="com.Person.Certificate" %>
<%@ page import="com.Job.Job" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="/employeeHeader.jsp"/>
<html>
<head><script src="sortable.js"></script>
<link href="CalendarControl.css" rel="stylesheet" type="text/css">
<script src="CalendarControl.js"></script></head>
<body>
<form method="get" action="jobTraining.jsp">
	<h4 align="left">> Job Training</h4>
	<p align = "left">Enter Job Code: <input type="text" name="job_code" id="job_code">
					  Target Date: <input type="text" name="target_date" id="target_date" onfocus="showCalendarControl(this);" >
	<input type="submit" name="submit" id="submit" value="Submit"></p>
</form>
<form>
<%
try{
String id = session.getAttribute("id").toString();	
if(id!=null && !id.isEmpty())  
{PersonDAO personDAO = new PersonDAO();
	String job_code = request.getParameter("job_code");
	String target_date = request.getParameter("target_date");		
	if(job_code!=null && job_code!="") {
	ArrayList<Skill> missingSkillList = personDAO.getMissingSkills(id,job_code);
	%><h4 align="left">> Missing Skills for the Job</h4><%
	//ArrayList<Skill> missingSkillList = personDAO.getMissingSessions(id,job_code,new java.sql.Date((new GregorianCalendar(2014, 0, 1)).getTime().getTime()));
	if(!missingSkillList.isEmpty()){		
		%>
		<table class="sortable">
		<thead><tr><td>Title</td><td>Description</td><td>Level</td></tr></thead><tbody>
		 <%
	Iterator<Skill> iterator = missingSkillList.iterator();
		 
	while(iterator.hasNext()){
		Skill skill = iterator.next();
		%>
			<tr>
			<td><%= skill.getTitle() %></td>
			<td><%= skill.getDescription()%></td>
			<td><%= skill.getLevel()%></td>
			</tr>
		<%
	}
	%>
	</tbody>
	</table><%
	
	ArrayList<Session> missingSessions = personDAO.getMissingSessions(id,job_code,target_date);
	%><h4 align="left">> Training for the Missing Skills</h4><%
	if(!missingSessions.isEmpty()){		
		%>
		<table class="sortable">
		<thead><tr><td>Course Code</td><td>Session ID</td><td>Semester</td>
					<td>Start Date</td><td>End Date</td><td>Price</td></tr></thead><tbody>
		 <%
	Iterator<Session> missingSessioniterator = missingSessions.iterator();
		 
	while(missingSessioniterator.hasNext()){
		Session missingSession = missingSessioniterator.next();
		%>
			<tr>
			<td><%= missingSession.getC_code() %></td>
			<td><%= missingSession.getSession_id() %></td>
			<td><%= missingSession.getSemester()%></td>
			<td><%= missingSession.getStart_date()%></td>
			<td><%= missingSession.getEnd_date()%></td>
			<td><%= missingSession.getPrice()%></td>			
			</tr>
		<%
	}
	%>
	</tbody>
	</table><%
	
	}
	else{
		%><p align = "left"> No results found.</p><%
	}
	
	}
	else{
		%><p align = "left"> No results found.</p><%
	}
	
	%><h4 align="left">> Missing Certificates for the Job</h4><%
	ArrayList<Certificate> missingCertificateList = personDAO.getMissingCertificates(id,job_code);

	//ArrayList<Skill> missingSkillList = personDAO.getMissingSessions(id,job_code,new java.sql.Date((new GregorianCalendar(2014, 0, 1)).getTime().getTime()));
	if(!missingCertificateList.isEmpty()){		
		%>
		<table class="sortable">
		<thead><tr><td>Name</td></tr></thead><tbody>
		 <%
	Iterator<Certificate> iterator = missingCertificateList.iterator();
		 
	while(iterator.hasNext()){
		Certificate certificate = iterator.next();
		%>
			<tr>
			<td><%= certificate.getName() %></td>
			</tr>
		<%
	}
	%>
	</tbody>
	</table><%

	}
	else{
		%><p align = "left"> No results found.</p><%
	}
	
	
	
	}
	}}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
%>
</form>

</body></html>