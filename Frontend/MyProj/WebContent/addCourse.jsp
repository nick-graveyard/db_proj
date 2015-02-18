<jsp:include page="/header.jsp"/>
<html><head><style type="text/css"><%@include file="main.css" %></style></head>
<body>
<form method="get" action="saveCourse.jsp">
<h2>Add a New Course</h2>
<div>
<table><tr><td>Course Code:</td><td><input type="text" value="" name="c_code" size="20"></td></tr>
       <tr><td>Title:</td><td><input type="text" value="" name="title" size="20"></td></tr>
       <tr><td>Type:</td><td><input type="text" value="" name="type" size="20"></td></tr>
       <tr><td>Category:</td><td><input type="text" value="" name="category" size="20"></td></tr>
       <tr><td>Retail Price:</td><td><input type="text" value="" name="retail_price" size="20"></td></tr>
       <tr><td>Level:</td><td><input type="text" value="" name="level" size="20"></td></tr>
       <tr><td>Status:</td><td><input type="text" value="" name="status" size="20"></td></tr>
       <tr><td colspan=2 align="center"><input type="submit" id="addCourse" name="addCourse" value="Add Course"></td></tr>
</table>
</div>
</form>
</body>
</html>
