<jsp:include page="/header.jsp"/>
<html><head><style type="text/css"><%@include file="main.css" %></style>
<link href="CalendarControl.css" rel="stylesheet" type="text/css">
<script src="CalendarControl.js"></script></head>
<body>
<form method="get" action="savePerson.jsp">
<h2 align="left">Create a New Profile</h2>
<div>
<table><tr><td>*ID:</td><td><input type="text" value="" name="person_id" size="20"></td></tr>
       <tr><td>First Name:</td><td><input type="text" value="" name="fName" size="20"></td></tr>
       <tr><td>Last Name:</td><td><input type="text" value="" name="lName" size="20"></td></tr>
       <tr><td>Street Address:</td><td><input type="text" value="" name="street_address" size="20"></td></tr>
       <tr><td>Zip Code:</td><td><input type="text" value="" name="zip" size="20"></td></tr>
       <tr><td>City:</td><td><input type="text" value="" name="city" size="20"></td></tr>
       <tr><td>State:</td><td><input type="text" value="" name="state" size="20"></td></tr>
       <tr><td>Email:</td><td><input type="text" value="" name="email" size="20"></td></tr>
       <tr><td>Gender:</td><td><input type="text" value="" name="gender" size="20"></td></tr>
       <tr><td>DOB:</td><td><input type="text" name="DOB" onfocus="showCalendarControl(this);" ></td></tr>
       <tr><td>Designation:</td><td><input type="text" value="" name="Designation" size="20"></td></tr>
       <tr><td colspan=2 align="center"><input type="submit" id="addPerson" name="addPerson" value="Submit"></td></tr>
</table>
<p align="left">* indicates required field.</p>
</div>
</form>
<form method="get" action="index.jsp">
<table><tr><td><input type="submit" id="submit" name="submit" value="Back"></td></tr></table>
</form>
</body>
</html>
