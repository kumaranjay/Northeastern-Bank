<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%HttpSession s = request.getSession(false);
if(s==null ||s.isNew())
{
	response.sendRedirect(request.getContextPath() + "/");
}
%>

<html>
<head>
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<!-- Loading Bootstrap -->
<link href="resources/flatUI/dist/css/vendor/bootstrap.min.css"
	rel="stylesheet">

<!-- Loading Flat UI -->
<link href="resources/flatUI/dist/css/flat-ui.css" rel="stylesheet">
<link href="resources/flatUI/docs/assets/css/demo.css" rel="stylesheet">

<link rel="shortcut icon" href="resources/flatUI/img/favicon.ico">

<link rel="stylesheet" type="text/css" href="resources/css/teller.css"></link>
<script src="resources/js/customerWelcome.js"></script>

<script>
	$(document).ready(function() {
		$('#updateProfile').accordion({
			heightStyle : "content"
		});

		$('#confirmPassword').keyup(function() {

			var newPassword = $('#newPassword').val().trim();
			var confirmPassword = $('#confirmPassword').val().trim();

			if (newPassword == confirmPassword) {
				$('#matchPassword').html("Passwords match");
				$('#matchPassword').css("color", "green");
				$('#matchPassword').css("font-size", "80%");
				$('#changePasswordDiv').removeClass("has-error");
			} else {
				$('#matchPassword').html("Passwords don't match");
				$('#matchPassword').css("color", "red");
				$('#matchPassword').css("font-size", "80%");
				$('#changePasswordDiv').addClass("has-error");
			}

		});
	});

	// 	$('#oldPassword').change(function() {

	// 		var oldPassword = $('#oldPassword').val().trim();

	// 		$.ajax({
	// 			type: "POST",
	// 			url: "checkOldPassword",
	// 			date: "oldPassword"
	// 		});

	// 	});

	function changeAddress() {
		var address = $('#address').val().trim();

		if (address.length == 0) {
			$('#address').val("Invalid entry");
			$('#changeAddressDiv').addClass("has-error");
		} else {

			$.ajax({
				type : "POST",
				url : "changeAddress",
				data : "address=" + address,

				success : function(response) {

					if (response == "success") {

						$('#changeAddressDiv').removeClass("has-error");
						$('#successMessage').html(
								"Address updated successfully");
						$('#address').val("");
					}

				}

			});
		}

	}

	function changeEmail() {
		var email = $('#email').val().trim();

		if (email.length == 0) {
			$('#email').val("Invalid entry");
			$('#changeEmailDiv').addClass("has-error");
		} else {

			$.ajax({
				type : "POST",
				url : "changeEmail",
				data : "email=" + email,

				success : function(response) {

					if (response == "success") {

						$('#changeEmailDiv').removeClass("has-error");
						$('#successMessageEmail').html(
								"Email updated successfully");
						$('#email').val("");
					} else if (response == "available") {
						$('#email').val("Email Already Exists");
						$('#changeEmailDiv').addClass("has-error");
					}

				}

			});
		}

	}

	function changePhoneNumber() {
		var phoneNumber = $('#phoneNumber').val().trim();

		if (phoneNumber.length != 10) {
			$('#changePhoneNumberDiv').addClass("has-error");
			$('#phoneNumber').val("");
			$('#phoneNumber').val("Enter valid 10 digit number");
		} else {

			$.ajax({
				type : "POST",
				url : "changePhoneNumber",
				data : "phoneNumber=" + phoneNumber,

				success : function(response) {

					if (response == "success") {

						$('#changePhoneNumberDiv').removeClass("has-error");
						$('#successMessagePhone').html(
								"Phone number updated successfully");
						$('#phoneNumber').val("");
					}

				}

			});
		}
	}

	function changePassword() {
		var oldPassword = $('#oldPassword').val().trim();
		var newPassword = $('#newPassword').val().trim();
		var confirmPassword = $('#confirmPassword').val().trim();

		if (oldPassword.length == 0 || newPassword.length == 0
				|| confirmPassword == 0) {
			$('#oldPassword').val("Invalid entry");
			$('#newPassword').val("Invalid entry");
			$('#confirmPassword').val("Invalid entry");
			$('#changePasswordDiv').addClass("has-error");
		} else if (newPassword == confirmPassword) {

			$.ajax({
				type : "POST",
				url : "changePassword",
				data : "oldPassword=" + oldPassword + "&newPassword="
						+ newPassword,

				success : function(response) {

					if (response == "success") {

						$('#changePasswordDiv').removeClass("has-error");
						$('#successMessagePassword').html(
								"Password updated successfully");
						$('#oldPassword').val("");
						$('#newPassword').val("");
						$('#confirmPassword').val("");
						$('#matchPassword').html("");
					} else {
						$('#oldPassword').val("");
						$('#oldPassword').css("color", "red");
						$('#newPassword').val("");
						$('#confirmPassword').val("");
						$('#changePasswordDiv').addClass("has-error");
						$('#matchPassword').html("The old password is wrong");
						$('#matchPassword').css("color", "red");
						$('#matchPassword').css("font-size", "80%");
					}

				}

			});
		}

	}
</script>

<style>
h3 {
	background: #2ecc71 !important;
	color: white !important;
}
</style>

<title>Northeastern Bank</title>
</head>
<body>

	<div id="frame">
		<div id="header">
			<p class="lead">Welcome ${user.firstName} ${user.lastName}</p>
		</div>

		<div class="container-fluid">
			<div class="row">
				<div class="col-md-2 sidebar" id="sidebar">
					<ul class="nav nav-sidebar">

						<li class="active"><a href="tellerHomePage">Home<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-home"></span></a></li>

						<li><a href="pendingCheques">Pending Cheques<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-list-alt"></span></a></li>

						<li><a href="editTellerProfile">Edit Profile<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></span></a></li>

						<li><a href="logout">Logout<span style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-off"></span></a></li>
					</ul>
				</div>
				<div class="col-md-offset-2 col-md-6" id="updateProfile"
					style="padding: 50px; font-size: 80%">

					<h3>Change Address</h3>
					<div id="changeAddressDiv">

						<input type="text" id="address" class="form-control"
							name="address" placeholder="Enter Address" required="required"><br>
						<button type="button" class="btn btn-block btn-sm btn-primary"
							onclick="changeAddress()" style="width: 100px">Update</button>
						<br>
						<div id="successMessage" style="color: green"></div>

					</div>

					<h3>Change Phone Number</h3>
					<div id="changePhoneNumberDiv">
						<input type="number" id="phoneNumber" class="form-control"
							name="phoneNumber" placeholder="Enter Phone Number"
							required="required"><br>
						<button type="button" class="btn btn-block btn-sm btn-primary"
							onclick="changePhoneNumber()" style="width: 100px">Update</button>
						<br>
						<div id="successMessagePhone" style="color: green"></div>
					</div>

					<h3>Change Email</h3>
					<div id="changeEmailDiv">
						<input type="email" id="email" class="form-control" name="email"
							placeholder="Enter Email ID" required="required"><br>
						<button type="button" class="btn btn-block btn-sm btn-primary"
							onclick="changeEmail()" style="width: 100px">Update</button>
						<br>
						<div style="color: green" id="successMessageEmail"></div>
					</div>

					<h3>Change Password</h3>
					<div id="changePasswordDiv">
						<input type="password" id="oldPassword" class="form-control"
							name="oldPassword" placeholder="Enter Old Password"
							required="required"><br> <input type="password"
							id="newPassword" class="form-control" name="newPassword"
							placeholder="Enter New Password" required="required"><br>
						<input type="password" id="confirmPassword" class="form-control"
							name="confirmPassword" placeholder="Confirm New Password"
							required="required"><br>
						<button type="button" class="btn btn-block btn-sm btn-primary"
							onclick="changePassword()" style="width: 100px">Update</button>
						<br>
						<div id="matchPassword"></div>
						<div style="color: green" id="successMessagePassword"></div>
					</div>


				</div>
			</div>
		</div>

	</div>

</body>
</html>