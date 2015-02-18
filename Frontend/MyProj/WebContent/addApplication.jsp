<%@ page import="com.Job.JobDAO" %>
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
String job_code = request.getParameter("job_code");
if(id!=null && !id.isEmpty() && job_code!=null) { 

	JobDAO jobDAO = new JobDAO();
	jobDAO.saveApplication(id,job_code);
	}
}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
response.sendRedirect("manageEmpInfo.jsp");
%>
</form>
</body></html>