<%@ page import="com.Course.CourseDAO" %>

<jsp:include page="/header.jsp"/>
<jsp:useBean id="course" class="com.Course.Course" scope="session"/> 
<jsp:setProperty name="course" property="*"/>
<html><body>
<%
try{
CourseDAO courseDAO = new CourseDAO();
courseDAO.addCourse(course);
}
catch (Exception e){
	response.sendRedirect("error.jsp");
}
%>
<b> A new course has been added.</b>
</body></html>