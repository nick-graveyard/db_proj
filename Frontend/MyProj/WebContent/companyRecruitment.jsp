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
<form method="get" action="companyRecruitment.jsp">
	<h4 align="left">> Search Candidates for a Job</h4>
	<p align = "left">Enter Job Code: <input type="text" name="job_code" id="job_code">
						&nbsp;&nbsp;&nbsp;&nbsp;Return <select name="candidateResultType" id="candidateResultType">
									<option value="qualified" selected>qualified only</option>
									<option value="top10">10</option>
									<option value="top50">50</option>
									<option value="top100">100</option>
									</select> candidates&nbsp;&nbsp;
	<input type="submit" name="submit" id="submit" value="Submit"></p>
</form>
<form method="get" action="companyRecruitment.jsp"> 
<%
try{
String id = session.getAttribute("id").toString();
if(id!=null && !id.isEmpty())  
{CompanyDAO companyDAO = new CompanyDAO();
String job_code = request.getParameter("job_code");
String candidateResultType = request.getParameter("candidateResultType");
if(job_code!=null && !job_code.isEmpty()) { 
%>
<h4 align="left">> Results</h4>
<%
ArrayList<Person> personList = companyDAO.getCandidates(job_code, candidateResultType);

if(!personList.isEmpty()){
	%><table class="sortable">
	<thead><tr><td>ID</td><td>Last Name</td><td>First Name</td><td>Email</td></tr></thead><tbody><%
	Iterator<Person> iterator = personList.iterator();
	while(iterator.hasNext()){
		Person person = iterator.next();
		%>
			<tr>
			<td><%= person.getPerson_id() %></td>
			<td><%= person.getlName()%></td>
			<td><%= person.getfName()%></td>
			<td><%= person.getEmail()%></td>
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
}}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
%>

</form>
</body></html>