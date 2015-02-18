<jsp:include page="/header.jsp"/>
<html><head><style type="text/css"><%@include file="main.css" %></style></head>
<body>
<form method="get" action="saveCompany.jsp">
<h2 align="left">Create a New Profile</h2>
<div>
<table><tr><td>*Company ID:</td><td><input type="text" value="" name="company_id" size="20"></td></tr>
       <tr><td>*Company Name:</td><td><input type="text" value="" name="company_name" size="20"></td></tr>
       <tr><td>Street Address:</td><td><input type="text" value="" name="street_address" size="20"></td></tr>
       <tr><td>Zip Code:</td><td><input type="text" value="" name="zip" size="20"></td></tr>
       <tr><td>City:</td><td><input type="text" value="" name="city" size="20"></td></tr>
       <tr><td>State:</td><td><input type="text" value="" name="state" size="20"></td></tr>
       <tr><td>Website:</td><td><input type="text" value="" name="website" size="20"></td></tr>
       <tr><td>GSA:</td><td><input type="text" value="" name="GSA" size="20"></td></tr>
       <tr><td colspan=2 align="center"><input type="submit" id="addCompany" name="addCompany" value="Submit"></td></tr>
</table>
<p align="left">* indicates required field.</p>
</div>
</form>
<form method="get" action="index.jsp">
<table><tr><td><input type="submit" id="submit" name="submit" value="Back"></td></tr></table>
</form>
</body>
</html>
