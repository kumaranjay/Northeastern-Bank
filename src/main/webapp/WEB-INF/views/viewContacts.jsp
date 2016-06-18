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

						<li><a href="logout">Logout<span style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-off"></span></a></li>
					</ul>
				</div>


				<div class="col-md-offset-1 col-md-8" style="margin-top: 40px;">
					<p id="error">${error}</p>

					<form action="deleteContact" method="post">
						<div class="panel panel-success">
							<div class="panel-heading"
								style="background: #2980B9; color: white">
								<h3 class="panel-title">Contacts</h3>
							</div>
							<table class="table table-hover" id="dev-table">
								<thead style="background: #f3f3f3; color: gray">
									<tr>
										<th>Name</th>
										<th>Email ID</th>
										<th>Account Number</th>
										<th>Delete</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="c" items="${contacts}">
										<tr>
											<td>${c.firstName}${c.lastName}</td>
											<td>${c.email}</td>
											<td>${c.accountNumber}</td>
											<td><input type="checkbox" name="delete"
												value="${c.contactsID}"></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<input type="submit" value="Delete Contact(s)"
							class="btn btn-danger" style="margin-left: 700px">
					</form>
				</div>
			</div>
		</div>

	</div>

</body>
</html>