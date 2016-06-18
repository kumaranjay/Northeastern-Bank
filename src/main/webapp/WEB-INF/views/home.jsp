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
<link rel="stylesheet" type="text/css" href="resources/css/home.css"></link>
<script type="text/javascript">
	$(document).ready(function() {
	
		// Activate carousel
		$("#myCarousel").carousel();

		// Enable carousel control
		$(".left").click(function() {
			$("#myCarousel").carousel('prev');
		});
		$(".right").click(function() {
			$("#myCarousel").carousel('next');
		});

		// Enable carousel indicators
		$(".slide-one").click(function() {
			$("#myCarousel").carousel(0);
		});
		$(".slide-two").click(function() {
			$("#myCarousel").carousel(1);
		});
		$(".slide-three").click(function() {
			$("#myCarousel").carousel(2);
		});
	});
</script>
</head>
<body>
	<div id="frame">
		<div id="header">
			<h3>Northeastern Bank</h3>
		</div>
		<div id="main1">
			<div id="corousal" class="col-md-8">
				<div id="carousel">
					<div id="myCarousel" class="carousel slide" data-interval="3000"
						data-ride="carousel">
						<!-- Carousel indicators -->
						<ol class="carousel-indicators">
							<li class="slide-one active"></li>
							<li class="slide-two"></li>
							<li class="slide-three"></li>
							<li class="slide-four"></li>
						</ol>
						<!-- Carousel items -->
						<div class="carousel-inner">
							<div class="active item">
								<img src="resources/images/carousal3.jpg">
							</div>
							<div class="item">
								<img src="resources/images/carousal4.jpg">
							</div>
							<div class="item">
								<img src="resources/images/carousal5.jpg">
							</div>
							<div class="item">
								<img src="resources/images/carousal6.jpg">
							</div>
						</div>
						<!-- Carousel nav -->
						<a class="carousel-control left"> <span
							class="glyphicon glyphicon-chevron-left"></span>
						</a> <a class="carousel-control right"> <span
							class="glyphicon glyphicon-chevron-right"></span>
						</a>
					</div>
				</div>
			</div>
			<div id="login" class="login-form col-md-4">
				<form method="POST" action="login">
					<div id="uname" class="form-group">
						<input type="text" name="userName" class="form-control login-field" value=""
							placeholder="User Name" id="login-name" /> <label
							class="login-field-icon fui-user" for="login-name"></label>
					</div>

					<div class="form-group">
						<input type="password" name="password" class="form-control login-field" value=""
							placeholder="Password" id="login-pass" /> <label
							class="login-field-icon fui-lock" for="login-pass"></label>
					</div>
					<div style="color:red; font-weight: bold;margin-left: 10px">${error}</div>
					<label class="checkbox" for="checkbox1"> <input
						type="checkbox" value="remember" name="remember" id="checkbox1"
						data-toggle="checkbox"> Keep me logged in for 30 min
					</label>
					<div>
						<div class="col-md-4">
							<button type="submit" class="btn btn-info btn-lg btn-block">Log
								in</button>
						</div>
						<div class="col-md-offset-2 col-md-6">
							<a href="goToRegister"><button type="button" class="btn btn-info btn-lg btn-block">Register</button></a>
						</div>
					</div>
					<br>
					<br>
					<a class="login-link" href="#">Forgot password?</a>
				</form>
			</div>
			<!-- 			<div id="login" class="col-md-4"> -->
			<%-- 				<form:form method="POST" commandName="user"> --%>
			<!-- 					<div class="col-md-12"> -->
			<%-- 						<form:input path="userName" class="form-control" --%>
			<%-- 							placeholder="Enter User Name" /> --%>
			<!-- 					</div> -->
			<!-- 					<br> -->
			<!-- 					<br> -->
			<!-- 					<div class="col-md-12"> -->
			<%-- 						<form:input path="password" class="form-control" --%>
			<%-- 							placeholder="Enter Password" /> --%>
			<!-- 					</div> -->
			<!-- 					<br> -->
			<!-- 					<br> -->
			<!-- 					<div class="col-md-12"> -->
			<!-- 						<input type="checkbox" name="remember" value="remember"> -->
			<!-- 						Keep me signed in for 1 hour -->
			<!-- 					</div> -->
			<!-- 					<br> -->
			<!-- 					<br> -->
			<!-- 					<div> -->
			<!-- 						<div class="col-md-4"> -->
			<!-- 							<button type="submit" class="btn btn-primary"> -->
			<!-- 								<span class="glyphicon glyphicon-lock"></span> Login -->
			<!-- 							</button> -->
			<!-- 						</div> -->
			<!-- 						<div class="col-md-offset-1 col-md-7"> -->
			<!-- 							<button type="button" class="btn btn-success"> -->
			<!-- 								<span class="glyphicon glyphicon-user"></span> Sign up -->
			<!-- 							</button> -->
			<!-- 						</div> -->
			<!-- 					</div> -->
			<!-- 					<br> -->
			<!-- 					<br> -->
			<!-- 					<div class="col-md-12"> -->
			<!-- 						<a href="#">Forgot Password?</a> -->
			<!-- 					</div> -->
			<%-- 				</form:form> --%>
			<!-- 			</div> -->
		</div>
		<div id="main2"></div>
	</div>

</body>
</html>
