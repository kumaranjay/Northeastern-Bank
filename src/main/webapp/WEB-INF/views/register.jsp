<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%HttpSession s = request.getSession(false);
if(s==null ||s.isNew())
{
	response.sendRedirect(request.getContextPath() + "/");
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<!-- Loading Bootstrap -->
<link href="resources/flatUI/dist/css/vendor/bootstrap.min.css"
	rel="stylesheet">

<!-- Loading Flat UI -->
<link href="resources/flatUI/dist/css/flat-ui.css" rel="stylesheet">
<link href="resources/flatUI/docs/assets/css/demo.css" rel="stylesheet">

<link rel="shortcut icon" href="resources/flatUI/img/favicon.ico">

<title>Register</title>
<link rel="stylesheet" type="text/css" href="resources/css/home.css"></link>
</head>
<body>
	<div id="frame">
		<div id="header">
			<h3>Register</h3>
		</div>
		<div id="registerBody">
			<form:form method="POST" action="register" commandName="user">
				<div class="col-md-offset-2 col-md-9 col-md-offset-1 form-group"
					id="registerForm">

					<div class="col-md-6">
						<form:input path="firstName" class="col-md-3 form-control"
							placeholder="First Name" required="required" />
						<br> <br>
					</div>
					<div class="col-md-6">
						<form:input path="lastName" class="col-md-3 form-control"
							placeholder="Last Name" required="required" />
						<br> <br>
					</div>

					<div class="col-md-6">
						<form:input type="email" path="email"
							class="col-md-7 form-control" placeholder="Email ID"
							required="required" />
						<br> <br>
					</div>

					<div class="col-md-6">
						<form:input path="userName" class="col-md-3 form-control"
							placeholder="User Name" required="required" />
						<br> <br>
					</div>
					<div class="col-md-6">
						<input type="password" name="password"
							class="col-md-7 form-control" placeholder="Password" required />
						<br> <br>
					</div>
					<div class="col-md-6">
						<input type="password" name="password2"
							class="col-md-7 form-control" placeholder="Confirm Password"
							required /><br> <br>
					</div>
					<div class="col-md-6">
						<form:input path="accountNumber" class="col-md-7 form-control"
							placeholder="Account Number" required="required" />
						<br> <br>
					</div>
					<div class="col-md-12">
						<input type="submit" class="col-md-offset-4 col-md-4 btn btn-primary" value="Register">
					</div>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>