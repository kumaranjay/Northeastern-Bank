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

<link rel="stylesheet" type="text/css" href="resources/css/teller.css"></link>
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

						<li><a href="tellerHomePage">Home<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-home"></span></a></li>

						<li class="active"><a href="pendingCheques">Pending
								Cheques<span style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-list-alt"></span>
						</a></li>


						<li><a href="editTellerProfile">Edit Profile<span
								style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></span></a></li>
								
						<li><a href="logout">Logout<span style="font-size: 14px;"
								class="pull-right hidden-xs showopacity glyphicon glyphicon-off"></span></a></li>
					</ul>
				</div>
				<div class="col-md-offset-2 col-md-7" style="margin-top: 40px;">

					<c:choose>
						<c:when test="${size > 0}">
							<div class="panel panel-success">
								<div class="panel-heading"
									style="background: #27ae60; color: white">
									<h3 class="panel-title">Account Statement</h3>
								</div>
								<table class="table table-hover" id="dev-table">
									<thead style="background: #f3f3f3; color: gray">
										<tr>
											<th>Date</th>
											<th>Description</th>
											<th>Action</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="c" items="${cheques}">
											<tr>
												<td>${c.uploadDate}</td>
												<td>Cheque ID# ${c.imageID}<br>Uploaded by
													${c.userName}
												</td>
												<td><a href="reviewCheque?imageID=${c.imageID}"><button
															type="button" class="btn btn-block btn-primary"
															style="width: 80px">Review</button></a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:when>
						<c:otherwise>
							<p class="lead">You have no cheques to review</p>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>

	</div>

</body>
</html>