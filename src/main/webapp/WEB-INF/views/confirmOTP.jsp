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
	function checkPin() {

		var pin = $('#pin').val();

		$.ajax({
			type : "POST",
			url : "sendMoneyConfirm",
			data : "pin=" + pin,

			success : function(response) {

				if (response == "error") {
					$('#error').html("Invalid OTP");
				} else if (response == "transactionSuccess") {

					$('#error').html("");
					$('#transferBody2').html("                  Transaction was successful. ");
					$("#transferBody2").css({
						color : "#2ECC71"
					});
					$("#transferBody2").css('font-weight', 'bold');
					windows.location.href = "transferMoney";

				}
				$('#pin').val('');
			}

		});

	}
</script>

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

						<li><a href="customerWelcome">Home<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-home"></span></a></li>

						<li><a href="accountStatement">Account Statement<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-list-alt"></span></a></li>

						<li class="active"><a href="transferMoney">Transfer Money<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-transfer"></span></a></li>

						<li><a href="depositCheck">Deposit Check<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-import"></span></a></li>

						<li><a href="contactsHome">Contacts<span
								style="font-size: 16px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-book"></span></a></li>

						<li><a href="nearestBank">Nearest Bank/ATM<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-map-marker"></span></a></li>

						<li><a href="editProfile">Edit Profile<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></span></a></li>

						<li><a href="logout">Logout<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-off"></span></a></li>
					</ul>
				</div>
				<div id="transferBody" class="col-md-offset-2 col-md-8"
					style="margin-top: 100px; height: 300px; padding: 20px;">

					<%-- 					<form action="sendMoneyConfirm" method="post"> --%>
					<div id="transferBody2" class="col-md-12">
						<div class="col-md-4">
							<p class="lead">Enter the OTP:</p>
						</div>
						<div class="col-md-8">
							<div class="col-md-3">
								<input type="number" class="form-control" style="width: 100px"
									id="pin" name="pin" required="required" />
							</div>
							<div class="col-md-2">
								<input type="submit" onclick="checkPin()"
									class="btn btn-success" value=">" />
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div id="error" class="col-md-offset-4" style="color: red">
						</div>
					</div>
					<%-- 					</form> --%>

				</div>
			</div>
		</div>

	</div>

</body>
</html>