<%@ page import="com.Course.CourseDAO" %>
<%@ page import="com.Course.Course" %>
<%@ page import="java.util.*" %>
<jsp:include page="/header.jsp"/>
<html><body>
<form method="get" action="deleteCourse.jsp"> 
<table>
	<tr><td></td>
		<td>Course Code</td>
		<td>Title</td>
		<td>Type</td>
		<td>Category</td>
		<td>Retail Price</td>
		<td>Level</td>
		<td>Status</td>
		</tr>
<%
try{
CourseDAO courseDAO = new CourseDAO();
ArrayList<Course> courseList = courseDAO.getAllCourses();
Iterator<Course> iterator = courseList.iterator();
while(iterator.hasNext()){
	Course course = iterator.next();
	%>
		<tr><td><input type="checkbox" name="courseid" value="<%= course.getC_code()%>"/></td>
		<td><%= course.getC_code() %></td>
		<td><%= course.getTitle()%></td>
		<td><%= course.getType()%></td>
		<td><%= course.getCategory()%></td>
		<td><%= course.getRetail_price()%></td>
		<td><%= course.getC_level()%></td>
		<td><%= course.getStatus()%></td>
		</tr>
	<%
}
}
catch (Exception e){
	e.printStackTrace();
	response.sendRedirect("error.jsp");
}
%>

<tr><td colspan=8 align="center"><input type="submit" id="deleteCourse" name="deleteCourse" value="Delete"></td></tr>
</table>
</form>
</body></html>