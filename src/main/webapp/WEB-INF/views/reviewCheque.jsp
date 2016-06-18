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

<link rel="stylesheet" type="text/css" href="resources/css/teller.css"></link>
<script src="resources/js/customerWelcome.js"></script>

<title>Northeastern Bank</title>


<script>

function approve(cheque){
	
	$.ajax({
		type: "POST",
		url: "approveCheque",
		data: "imageID=" + cheque,
		 
		success:function(response){
			
			if(response == "success"){
				$('#mainbody').html("");
				$('#mainbody').html("<p class='lead'>The Cheque has been approved and the customer's account has been credited</p>");
			}
		}
		
	
	});
	
}

function reject(cheque){
	
	$.ajax({
		type: "POST",
		url: "rejectCheque",
		data: "imageID=" + cheque,
		 
		success:function(response){
			
			if(response == "success"){
				$('#mainbody').html("");
				$('#mainbody').html("<p class='lead'>The Cheque has been rejected and the customer has been notified about it</p>");
			}
		}
		
	
	});
	
}


</script>

<style>
#img-bg {
	background: white;
	padding: 20px;
}
</style>
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
				<div id="mainbody" class="col-md-offset-1 col-md-8"
					style="margin-top: 50px;">
					<div class="col-md-10" id="img-bg">
						<div id="image">
							<img src="${imagePath}">
						</div>
					</div>
					<br> <br>
					<div class="col-md-10">
						<p class="lead">
							Name : ${chequeUser.firstName} ${chequeUser.lastName}<br>
							Account# :${chequeUser.accountNumber}<br>
						</p>
					</div>
					<br>
					<div class="col-md-12">
						<div class="col-md-offset-1 col-md-2">
							<button class="btn btn-block btn-success" type="button"
								onclick="approve(${cheque.imageID})">Approve</button>
						</div>
						<div class="col-md-offset-1 col-md-2">
							<button class="btn btn-block btn-danger" type="button"
								onclick="reject(${cheque.imageID})">Reject</button>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

</body>
</html>