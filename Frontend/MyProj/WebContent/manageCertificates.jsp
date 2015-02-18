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
<form method="get" action="manageCertificates.jsp"> 
<%
try{
String id = session.getAttribute("id").toString();	
if(id!=null && !id.isEmpty())  
{PersonDAO personDAO = new PersonDAO();
ArrayList<Certificate> certificateList = personDAO.getCertificates(id);
%><h4 align="left">> Current Certificates</h4><%
	if(!certificateList.isEmpty()){
		%>
		<table class="sortable">
		<thead><tr><td>Name</td><td>Expiration Date</td></tr></thead><tbody><%
	Iterator<Certificate> iterator = certificateList.iterator();
	while(iterator.hasNext()){
		Certificate certificate = iterator.next();
		%>
			<tr>
			<td><%= certificate.getName() %></td>
			<td><%= certificate.getExp_date()%></td>
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
%><h4 align="left">> Missing Certificates for a Job</h4>
<p align = "left">Enter Job Code: <input type="text" name="job_code" id="job_code">
<input type="submit" name="submit" id="submit" value="Submit"></p><%
String job_code = request.getParameter("job_code");
if(job_code!=null && job_code!="") {
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