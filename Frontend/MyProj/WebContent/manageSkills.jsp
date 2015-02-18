<%@ page import="com.Person.PersonDAO" %>
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
<form method="get" action="manageSkills.jsp"> 
<%
try{
String id = session.getAttribute("id").toString();	
if(id!=null && !id.isEmpty())  
{PersonDAO personDAO = new PersonDAO();
	ArrayList<Skill> skillList = personDAO.getSkills(id);
	%><h4 align="left">> Current Skill-set</h4><%
	if(!skillList.isEmpty()){		
		%>
		<table class="sortable">
		<thead><tr><td>Title</td><td>Description</td><td>Level</td></tr></thead><tbody>
		 <%
	Iterator<Skill> iterator = skillList.iterator();
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
	</table>
	<%
	}
	else{
		%><p align = "left"> No results found.</p><%
	}
	%><h4 align="left">> Missing Skills for a Job</h4>
	<p align = "left">Enter Job Code: <input type="text" name="job_code" id="job_code">
	<input type="submit" name="submit" id="submit" value="Submit"></p><%
	String job_code = request.getParameter("job_code");
	if(job_code!=null && job_code!="") {
	ArrayList<Skill> missingSkillList = personDAO.getMissingSkills(id,job_code);
	
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
	
	}
	else{
		%><p align = "left"> No results found.</p><%
	}}
	
	
	
	}
	}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
%>
</form>

</body></html>