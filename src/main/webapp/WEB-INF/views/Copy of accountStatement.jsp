<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<!-- <link rel="stylesheet" type="text/css" -->
<!-- 	href="resources/css/customerWelcome.css"></link> -->
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

						<li class="active"><a href="accountStatement">Account
								Statement<span style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-list-alt"></span>
						</a></li>

						<li><a href="transferMoney">Transfer Money<span
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
				<div class="col-md-offset-1 col-md-8" style="margin-top: 40px;">
					<div class="panel panel-success">
						<div class="panel-heading"
							style="background: #33ADD6; color: white">
							<h3 class="panel-title">Account Statement</h3>
						</div>
						<table class="table table-hover" id="dev-table">
							<thead style="background: #f3f3f3; color: gray">
								<tr>
									<th>Date</th>
									<th>Description</th>
									<th>Type</th>
									<th>Amount</th>
									<th>Balance</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="tx" items="${transactions}">
									<tr>
										<td>${tx.date}</td>
										<td>${tx.status}</td>
										<td>${tx.type}</td>
										<td>${tx.amount}</td>
										<td>${tx.balance}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<a href="generatePDF" style="float: right;"><button type="button"
							class="btn btn-success">Generate PDF</button></a>
				</div>
			</div>
		</div>

	</div>

</body>
</html>