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

<link rel="stylesheet" type="text/css" href="resources/css/sidebar.css"></link>
<script src="resources/js/customerWelcome.js"></script>
<script>
	$(document).ready(function() {

		$('#bodyDiv2').hide();

	});

	function submitUserName() {

		var userName = $('#userName').val();

		$.ajax({
			type : "POST",
			url : "forgotPasswordGetSQ",
			data : "userName=" + userName,

			success : function(response) {
				if (response != "fail") {
					$('#userNameDiv').removeClass("has-error");
					$('#secretQuestion').html(response);
					$('#bodyDiv2').show();
				} else {
					$('#userNameDiv').addClass("has-error");
					$('#userName').val("Wrong username");
					$('#bodyDiv2').hide();
				}
			}

		});

	}
	
	function submitEverything() {

		var secretAnswer = $('#secretAnswer').val();
		var accountNumber = $('#accountNumber').val();
		var intRegex = /^\d+$/;
		
		if(intRegex.test(accountNumber)){

		$.ajax({
			type : "POST",
			url : "retreivePassword",
			data : "secretAnswer=" + secretAnswer +"&accountNumber="+accountNumber,

			success : function(response) {
				if (response != "fail") {
					$('#bodyDiv').html("The password has been sent to your mail ID<br><a href='/finalProj'><button type='text' class='btn btn-block btn-primary' style='width:100px'>Log in</button></a>");
					$('#bodyDiv2').hide();
				} else {
					$('#bodyDiv2').hide();
					$('#userNameDiv').addClass("has-error");
					$('#userName').val("Wrong details. Enter user name again");
					$('#secretAnswer').val("");
					$('#accountNumber').val("");
				}
			}

		});
		} else{
			//$('#accountNumber').css("color","red");
			$('#accountNumber').val("Only Numbers allowed");
			$('#accountNumber').css("color","black");
			
		}

	}
	
</script>

<style>
.lead2 {
	margin-bottom: 30px;
	font-size: 24px;
	font-weight: 300;
	line-height: 1.46428571;
}
</style>


<title>Northeastern Bank</title>
</head>
<body>

	<div id="frame">
		<div id="header">
			<p class="lead">Forgot Password</p>
		</div>

		<div class="col-md-offset-4 col-md-4" id="bodyDiv"
			style="margin-top: 50px;">
			<div id="userNameDiv">
				<input type="text" id="userName" class="form-control"
					placeholder="Enter User Name" required="required">
			</div>
			<br>
			<button type="button" class="btn btn-block btn-primary"
				style="width: 40px" onclick="submitUserName()" id="submitEverything">></button>
		</div>

		<div class="col-md-offset-4 col-md-4" id="bodyDiv2"
			style="margin-top: 50px;">
			<p class="lead2" id="secretQuestion"></p>
			<input type="text" id="secretAnswer" class="form-control"
				placeholder="Enter answer for the question" required="required"><br>
			<input type="number" id="accountNumber" class="form-control"
				placeholder="Enter your account number" required="required"><br>
			<button type="button" class="btn btn-block btn-primary"
				style="width: 100px" onclick="submitEverything()"
				id="submitEverything">submit</button>
			
		</div>



	</div>

</body>
</html>