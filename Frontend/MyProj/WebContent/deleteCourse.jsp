<%@ page import="com.Course.CourseDAO" %>
<jsp:include page="/header.jsp"/>
<html><body>
<%
try{
	CourseDAO courseDAO = new CourseDAO();
	String[] courseIdList = request.getParameterValues("courseid");
	for (int i = 0; i < courseIdList.length; i++) {
        courseDAO.deleteCourse(courseIdList[i]);
	}
}
catch (Exception e){
	response.sendRedirect("error.jsp");
}
response.sendRedirect("showCourses.jsp");
%>

</body></html>