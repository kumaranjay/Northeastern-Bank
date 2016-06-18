<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

						<li><a href="logout">Logout<span style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-off"></span></a></li>
					</ul>
				</div>
				<div id="transferBody" class="col-md-offset-2 col-md-5"
					style="margin-top: 100px; height: 300px; padding: 20px;">

					<c:choose>
						<c:when test="${size > 0}">



							<form action="sendMoney" method="post">
								<div class="col-md-12">
									<div class="col-md-5">
										<p class="lead">Send To:</p>
									</div>
									<div class="col-md-7">
										<select class="form-control toDrop" name="receiver">
											<c:forEach var="c" items="${contacts}">
												<option value="${c.email}" selected>${c.firstName}</option>
											</c:forEach>
										</select>
									</div>
								</div>

								<div class="col-md-12">
									<div class="col-md-5">
										<p class="lead">Amount:</p>
									</div>
									<div class="col-md-5">
										<input type="text" class="form-control toDrop" name="amount"
											required="required" />
									</div>
								</div>

								<div class="col-md-12">
									<div class="col-md-5">
										<p class="lead">Note:</p>
									</div>
									<div class="col-md-5">
										<input type="textarea" class="form-control toDrop" name="note"
											required="required" />
									</div>
								</div>
								<div class="col-md-5" style="float: right;">
									<input type="submit" class="btn btn-success" value="Send Money">
								</div>
							</form>

						</c:when>
						<c:otherwise>
							<p class="lead">You don't have any contacts</p>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
		</div>

	</div>

</body>
</html>