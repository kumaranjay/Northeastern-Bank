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
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<!-- <script -->
<!-- 	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script> -->

<!-- Loading Bootstrap -->
<link href="resources/flatUI/dist/css/vendor/bootstrap.min.css"
	rel="stylesheet">

<!-- Loading Flat UI -->
<link href="resources/flatUI/dist/css/flat-ui.css" rel="stylesheet">
<link href="resources/flatUI/docs/assets/css/demo.css" rel="stylesheet">

<link rel="shortcut icon" href="resources/flatUI/img/favicon.ico">

<link rel="stylesheet" type="text/css" href="resources/css/sidebar.css"></link>
<script src="resources/js/customerWelcome.js"></script>
<style>
.ui-dialog .ui-widget-header {
	background-color: #3498db !important;
}
</style>

<script>
	$(function() {
		var dialog, form, firstName = $("#firstName"), lastName = $("#lastName"), email = $("#email"), accountNumber = $("#accountNumber"), ifsc_main = $("#ifsc"), allFields = $(
				[]).add(firstName).add(lastName).add(email).add(accountNumber)
				.add(ifsc_main), tips = $("#validateTips");

		$("#addContact").button().on("click", function() {
			dialog.dialog("open");
		});

		dialog = $("#dialog-form").dialog({
			autoOpen : false,
			height : 500,
			width : 500,
			modal : true,
			buttons : {
				"Add Contact" : addUser,
				Cancel : function() {
					dialog.dialog("close");
				}
			},
			close : function() {
				form[0].reset();
				allFields.removeClass("ui-state-error");
			}
		});

		form = dialog.find("form").on("submit", function(event) {
			event.preventDefault();
			addUser();
		});

		function checkLength(o) {
			if (o.val().length < 1) {
				o.addClass("ui-state-error");
				o.val("This Field can't be empty");
				return false;
			} else {
				return true;
			}
		}

		function checkRegexp(o, regexp, n) {
			if (!(regexp.test(o.val()))) {
				o.addClass("ui-state-error");
				o.val(n);
				return false;
			} else {
				return true;
			}
		}

		function addUser() {

			var valid = true;
			allFields.removeClass("ui-state-error");

			var fn = $('#firstName').val();
			var ln = $('#lastName').val();
			var e = $('#email').val();
			var an = $('#accountNumber').val();
			var ifsc = $('#ifsc').val();

			valid = valid && checkLength(firstName);
			valid = valid && checkLength(lastName);
			valid = valid && checkLength(email);
			valid = valid && checkLength(accountNumber);
			valid = valid && checkLength(ifsc_main);

			valid = valid
					&& checkRegexp(
							email,
							/^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
							"Invalid email format");
			valid = valid
					&& checkRegexp(accountNumber, /^([0-9])/,
							"Only Numbers Allowed");
			valid = valid
					&& checkRegexp(ifsc_main, /^([0-9])/,
							"Only Numbers Allowed");
			if (valid) {
				$.ajax({
					type : "POST",
					url : "addContact",
					data : "firstName=" + fn + "&lastName=" + ln + "&email="
							+ e + "&accountNumber=" + an + "&ifsc=" + ifsc,
					success : function(response) {

						if (response == "success") {

							$('#dialog-form').html("");
							$('#dialog-form')
									.html("Contact Added Successfully");
							$('#dialog-form').css({
								color : green
							});
							$('#dialog-form').dialog("option", "buttons", {});

						} else if (response == "failure") {

							$('#dialog-form').html("");
							$('#dialog-form').html("Invalid Contact Details");
							$('#dialog-form').css({
								color : red
							});
							$('#dialog-form').dialog("option", "buttons", {});

						}
					}

				});
			}
		}

	});
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

						<li><a href="transferMoney">Transfer Money<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-transfer"></span></a></li>

						<li><a href="depositCheck">Deposit Check<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-import"></span></a></li>

						<li class="active"><a href="contactsHome">Contacts<span
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
				<div id="transferBody" class="col-md-offset-3 col-md-7"
					style="margin-top: 100px;">

					<div class="col-md-3">
						<a href="viewContact"><button id="viewContact"
								class="btn btn-primary" style="height: 50px; width: 150px">View
								Contacts</button></a>
					</div>
					<div class="col-md-offset-1 col-md-3">
						<button id="addContact" class="btn btn-primary">Add
							Contacts</button>

					</div>

				</div>

				<div id="dialog-form" title="Add New Contact" style="font-size: 80%">
					<p id="validateTips" />
					<form>
						<fieldset>
							<input type="text" name="firstName" id="firstName"
								class="form-control" placeholder="First Name"
								required="required" /><br> <input type="text"
								name="lastName" id="lastName" class="form-control"
								placeholder="Last Name" required="required" /><br> <input
								type="email" name="email" id="email" class="form-control"
								placeholder="Email ID" required="required" /> <br> <input
								type="test" name="accountNumber" id="accountNumber"
								class="form-control" placeholder="AccountNumber"
								required="required" /><br> <input type="text" name="ifsc"
								id="ifsc" class="form-control" placeholder="IFSC Code"
								required="required" /><br> <input type="submit"
								tabindex="-1" style="position: absolute; top: -1000px">
						</fieldset>
					</form>

				</div>


			</div>
		</div>

	</div>

</body>
</html>