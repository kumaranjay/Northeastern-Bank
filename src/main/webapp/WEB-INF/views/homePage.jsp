<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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

<title>Northeastern Bank</title>

<style type="text/css">
body {
	background-image: url("resources/images/homepage1.jpg");
	background-size: 100%;
}

#header {
 	background-color: rgba(255, 255, 255, 0.7); 
	height: 100px;
	color: #5C5A5A;
}

/* #header h3{ */
/* height:100px; */
/* background-color: rgba(0,0,0,0.5); */
/* padding-left: 30px; */
/* padding-top:30px; */
/* } */

/* #headerBand{ */
/* 	background-color: rgba(255, 255, 255, 0.5); */
/* 	height: 100px; */
/* 	color: #3498DB; */
/* } */

/* #headerBandEmpty{ */
/* 	background-color: rgba(255, 255, 255, 0.5); */
/* 	height: 100px; */
/* } */
.login-form {
	background-color: rgba(110, 112, 112, 0.6) !important;
	width: 300px;
	height: 350px;
	margin-top: 50px;
}

.login-link {
	color: white;
}

.login-link:hover { 
	color: white !important;
	font-size: 120%;
}
</style>
</head>
<body>
	<div id="frame">
		<div id="header" class="col-md-12">
			<div class="col-md-4" id="headerBand">
				<h3>Northeastern Bank</h3>
			</div>
		</div>
		<div id="main1">
			<div id="login" class="login-form col-md-offset-8 col-md-4">
				<form method="POST" action="login">
					<div id="uname" class="form-group">
						<input type="text" name="userName"
							class="form-control login-field" value="" placeholder="User Name"
							id="login-name" /> <label class="login-field-icon fui-user"
							for="login-name"></label>
					</div>

					<div class="form-group">
						<input type="password" name="password"
							class="form-control login-field" value="" placeholder="Password"
							id="login-pass" /> <label class="login-field-icon fui-lock"
							for="login-pass"></label>
					</div>
					<div
						style="padding-left: 20px; color: #E74C3C; font-size: 80%; background-color: rgba(251, 210, 210, 0.8)">${error}</div><br>
					<label class="checkbox" for="checkbox1" style="color: white">
						<input type="checkbox" value="remember" name="remember"
						id="checkbox1" data-toggle="checkbox"> Keep me logged in
						for 30 min
					</label>
					<div>
						<div class="col-md-12">
							<button type="submit" class="btn btn-primary btn-lg btn-block">Log
								in</button>
						</div>
					</div>
					<br> <br> <a class="login-link" href="forgotPassword">Forgot
						password?</a>
				</form>
			</div>
		</div>
		<div id="main2"></div>
	</div>

</body>
</html>
