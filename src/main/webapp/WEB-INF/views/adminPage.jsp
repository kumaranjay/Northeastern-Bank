<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
<link rel="stylesheet" type="text/css" href="resources/css/sidebar.css"></link>

<script>
	function validate() {
		var firstName = $('#firstName').val().trim();
		var lastName = $('#lastName').val().trim();
		var phoneNumber = $('#phoneNumber').val().trim();
		var userName = $('#userName').val().trim();
		var address = $('#address').val().trim();
		var state = $('#state').val().trim();
		var city = $('#city').val().trim();
		var zip = $('#zip').val().trim();
		var password = $('#password').val().trim();
		var password2 = $('#password2').val().trim();
		var secretAnswer = $('#secretAnswer').val().trim();

		if (firstName.length == 0) {
			$('#firstName').val("Invalid entry");
			$('#firstNameDiv').addClass("has-error");
			return false;
		}

		if (lastName.length == 0) {
			$('#lastName').val("Invalid entry");
			$('#lastNameDiv').addClass("has-error");
			return false;
		}

		if (phoneNumber.length != 10) {
			$('#phoneNumber').val("Enter 10 Digit Number");
			$('#phoneNumberDiv').addClass("has-error");
			return false;
		}

		if (address.length == 0) {
			$('#address').val("Invalid entry");
			$('#addressDiv').addClass("has-error");
			return false;
		}

		if (city.length == 0) {
			$('#city').val("Invalid entry");
			$('#cityDiv').addClass("has-error");
			return false;
		}

		if (state.length == 0) {
			$('#state').val("Invalid entry");
			$('#stateDiv').addClass("has-error");
			return false;
		}

		if (zip.length != 5) {
			$('#zip').val("Enter 5 digit ZIP");
			$('#zipDiv').addClass("has-error");
			return false;
		}

		if (balance.length == 0) {
			$('#balance').val("Invalid Entry");
			$('#balanceDiv').addClass("has-error");
			return false;
		}

		if (secretAnswer.length == 0) {
			$('#secretAnswer').val("Invalid Entry");
			$('#secretAnswerDiv').addClass("has-error");
			return false;
		}

		if (password != password2) {
			$('#password2').val("");
			$('#password2Div').addClass("has-error");
			$('#errorLabel').html("The Passwords don't match");
			$('#errorLabel').addClass("errorNotification");
			return false;
		}

		return true;
	}
	$(document)
			.ready(
					function() {
						$('#email')
								.change(
										function() {

											var email = $('#email').val();

											$s.ajax({
														type : "POST",
														url : "checkExistingEmail",
														data : "email=" + email,

														success : function(
																response) {

															if (response == "available") {
																$('#emailAvail')
																		.html(
																				"This Email is already registered with us");
																$('#emailAvail')
																		.css(
																				"color",
																				"red");
																$('#emailAvail')
																		.css(
																				"font-size",
																				"80%");
																$('#emailDiv')
																		.addClass(
																				"has-error");
															} else if (response == "no") {
																$('#emailAvail')
																		.html(
																				"");
																$('#emailDiv')
																		.removeClass(
																				"has-error");
															}
														}

													});

										});

						$('#userName')
								.keyup(
										function() {

											var userName = $('#userName').val();

											$
													.ajax({
														type : "POST",
														url : "checkExistingUserName",
														data : "userName="
																+ userName,

														success : function(
																response) {

															if (response == "available") {
																$(
																		'#userNameAvail')
																		.html(
																				"This UserName is not available");
																$(
																		'#userNameAvail')
																		.css(
																				"color",
																				"red");
																$(
																		'#userNameAvail')
																		.css(
																				"font-size",
																				"80%");
																$(
																		'#userNameDiv')
																		.addClass(
																				"has-error");
															} else if (response == "no") {
																$(
																		'#userNameAvail')
																		.html(
																				"This Username is available!");
																$(
																		'#userNameAvail')
																		.css(
																				"color",
																				"green");
																$(
																		'#userNameAvail')
																		.css(
																				"font-size",
																				"80%");
																$(
																		'#userNameDiv')
																		.removeClass(
																				"has-error");
															}
														}

													});

										});

						$('#password2').keyup(function() {

							var password = $('#password').val();
							var password2 = $('#password2').val();

							if (password == password2) {
								$('#passAvail').html("Passwords match");
								$('#passAvail').css("color", "green");
								$('#passAvail').css("font-size", "80%");
								$('#password2Div').removeClass("has-error");
							} else {
								$('#passAvail').html("Passwords don't match");
								$('#passAvail').css("color", "red");
								$('#passAvail').css("font-size", "80%");
								$('#password2Div').addClass("has-error");
							}

						});

					});
</script>

<style>
.errorNotification {
	background-color: rgba(251, 210, 210, 0.5);
	color: #E74C3C;
	padding-left: 220px;
}
</style>
</head>
<body>
	<div id="frame" style="height: 1500px">
		<div id="header" style="background: #7f8c8d">
			<p class="lead">Register</p>
		</div>
		<div id="registerBody" style="margin-left: 50px; margin-top: 10px">
			<form:form method="POST" action="register" commandName="user"
				onsubmit="return(validate())">
				<div class="col-md-offset-2 col-md-9 col-md-offset-1 form-group"
					id="registerForm">
					<div class="col-md-12" id="errorLabel">${errorBand}</div>
					<c:choose>
						<c:when test="${success == 1}">
							<div class="col-md-12" id="successBand"
								style="color: green; background: #EBFAEB; padding-left: 200px">User
								Registration Successfully Done</div>
						</c:when>
					</c:choose>
					<br> <br>
					<div class="col-md-6" id="firstNameDiv">
						<form:input path="firstName" class="col-md-3 form-control"
							id="firstName" placeholder="First Name" required="required" />
						<br> <br> <br> <br>
					</div>
					<div class="col-md-6" id="lastNameDiv">
						<form:input path="lastName" class="col-md-3 form-control"
							id="lastName" placeholder="Last Name" required="required" />
						<br> <br> <br> <br>
					</div>

					<div class="col-md-12" id="emailDiv">
						<form:input type="email" path="email" id="email"
							class="col-md-7 form-control" placeholder="Email ID"
							required="required" />
						<br> <span id="emailAvail" style="color: red; font-size: 80%">${error}</span>
						<br> <br>
					</div>
					<div class="col-md-6" id="phoneNumberDiv">
						<form:input type="number" path="phoneNumber" id="phoneNumber"
							class="col-md-7 form-control" placeholder="Phone Number"
							required="required" />
						<br> <br> <br> <br>
					</div>
					<div class="col-md-6" id="userNameDiv">
						<form:input path="userName" class="col-md-3 form-control"
							id="userName" placeholder="User Name" required="required" />
						<br> <span id="userNameAvail"
							style="color: red; font-size: 80%">${error}</span> <br> <br>
						<br>
					</div>
					<div class="col-md-6">
						<input type="password" name="password" id="password"
							class="col-md-7 form-control" placeholder="Password" required />
						<br> <br> <br> <br>
					</div>
					<div class="col-md-6" id="password2Div">
						<input type="password" name="password2" id="password2"
							class="col-md-7 form-control" placeholder="Confirm Password"
							required /><br> <span id="passAvail"><br> <br>
							<br>
					</div>

					<div class="col-md-12" id="addressDiv">
						<form:input path="address" class="col-md-7 form-control"
							id="address" placeholder="Address" required="required" />
						<br> <br> <br> <br>
					</div>
					<div class="col-md-4" id="cityDiv">
						<form:input path="city" class="col-md-7 form-control" id="city"
							placeholder="City" required="required" />
						<br> <br>
					</div>
					<div class="col-md-4" id="stateDiv">
						<form:input path="state" class="col-md-7 form-control" id="state"
							placeholder="State" required="required" />
						<br> <br> <br> <br>
					</div>
					<div class="col-md-4" id="zipDiv">
						<form:input type="number" path="zip" class="col-md-7 form-control"
							id="zip" placeholder="ZIP" required="required" />
						<br> <br> <br> <br>
					</div>

					<div class="col-md-6">
						<form:select path="userType" class="col-md-7 form-control"
							required="required">
							<form:option value="" cssStyle="color:#f7f7f7">Select User Type</form:option>
							<form:option value="Customer">Customer</form:option>
							<form:option value="Teller">Teller</form:option>
							<form:option value="Support">Support</form:option>
						</form:select>
						<br> <br> <br> <br>
					</div>
					<div class="col-md-6" id="balanceDiv">
						<form:input type="number" path="balance" id="balance"
							class="col-md-7 form-control" placeholder="Initial Deposit"
							required="required" />
						<br> <br> <br> <br>
					</div>
					<div class="col-md-12" id="secretQuestionDiv">
						<form:select path="secretQuestion" id="secretQuestion"
							class="col-md-7 form-control" required="required">
							<form:option value="">Select a secret question</form:option>
							<form:option value="What is the name of your first pet?">What is the name of your first pet?</form:option>
							<form:option value="What is the your mother's maiden name?">What is the your mother's maiden name?</form:option>
							<form:option value="What is your favourite movie?">What is your favourite movie?</form:option>
							<form:option value="What is your favourite food?">What is your favourite food?</form:option>
							<form:option value="What is your nickname?">What is your nickname?</form:option>
						</form:select>
						<br> <br> <br> <br>
					</div>
					<div class="col-md-12" id="secretAnswerDiv">
						<form:input type="text" path="secretAnswer" id="secretAnswer"
							class="col-md-7 form-control" placeholder="Secret Answer"
							required="required" />
						<br> <br> <br> <br>
					</div>
					<br> <br> <br> <br> <br> <br>
					<div class="col-md-12">
						<input type="submit"
							class="col-md-offset-4 col-md-4 btn btn-primary" value="Register">
					</div>
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>