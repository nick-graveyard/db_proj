<%@ page import="com.Person.PersonDAO" %>

<jsp:include page="/header.jsp"/>
<jsp:useBean id="person" class="com.Person.Person" scope="session"/> 
<jsp:setProperty name="person" property="*"/>
<html><body>
<%
try{
PersonDAO personDAO = new PersonDAO();
String dob = request.getParameter("DOB");
person.setDOB(dob);
personDAO.addPerson(person);
}
catch (Exception e){
	response.sendRedirect("error.jsp");
}
%>
<b> A new profile has been created.</b><br>
<a href="index.jsp">Login</a>
</body></html>