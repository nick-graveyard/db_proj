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
<head>
<script type="text/JavaScript">
function updateTotal(){
	personnel = document.getElementById("personnel");
	var personnelCost = 0;
	for (var i=0;i<=personnel.options.length-1;i++) {
		if (personnel.options[i].selected) {
			personnelCost = personnelCost + ((personnel.options[i].value - 0) * (document.getElementById("num_hrs").value - 0));
		}
	}
	document.getElementById("personnelCost").value = personnelCost;
	document.getElementById("totalCost").value = (document.getElementById("capital").value - 0) +
		(document.getElementById("personnelCost").value - 0) + (document.getElementById("miscCost").value - 0);
}
</script></head>
<body>
<form method="get" action="showCompanyDetails.jsp"> 
<%
try{
String id = session.getAttribute("id").toString();
if(id!=null && !id.isEmpty())  
{CompanyDAO companyDAO = new CompanyDAO();
%>
<h4 align="left">> New Project</h4>
<table><tr><td>*Project ID:</td><td><input type="text" value="" name="project_id" size="20"></td></tr>
       <tr><td>Title:</td><td><input type="text" value="" name="project_title" size="20"></td></tr>
       <tr><td>Director ID:</td><td><input type="text" value="" name="director" size="20"></td></tr>
       <tr><td>Total Hours:</td><td><input type="text" value=0 id="num_hrs" name="num_hrs" size="20" onChange="updateTotal();"></td></tr>
</table>
<h4 align="left">> Personnel</h4>
<%
ArrayList<Employee> workerList = companyDAO.getEmployees(id,"wage");

if(!workerList.isEmpty()){
	%> <p align="left"><select id="personnel" multiple onChange="updateTotal();"><%
	Iterator<Employee> iterator = workerList.iterator();
	while(iterator.hasNext()){
		Employee employee = iterator.next();
		%>
		<option value=<%=employee.getPay_rate() %>><%=employee.getlName() %>,&nbsp;<%=employee.getfName() %>&nbsp;&nbsp;&nbsp;<%=employee.getPosition() %>&nbsp;&nbsp;&nbsp;$<%=employee.getPay_rate() %>/hr</option>
		<%
	}
%>
</select></p>
<h4 align="left">> Cost Breakdown</h4>
<table>   
		<tr><td>Working Capital:</td><td><input type="text" id="capital" name="capital" size="20" value=0 onChange="updateTotal();"></td></tr>    
       <tr><td>Personnel Cost:</td><td><input type="text" id="personnelCost" name="personnelCost" size="20" value=0 onChange="updateTotal();"></td></tr>
       <tr><td>Misc Cost:</td><td><input type="text" id="miscCost" name="miscCost" size="20" value=0 onChange="updateTotal();"></td></tr>
       <tr><td>Total Cost:</td><td><input type="text" id="totalCost" name="totalCost" size="20" value=0 disabled></td></tr>
       <tr><td colspan=2 align="center"><input type="submit" id="addProject" name="addProject" value="Submit" disabled></td></tr>
</table>
<%
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