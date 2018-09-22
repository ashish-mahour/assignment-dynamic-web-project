<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link href="/res/custom.css" rel="stylesheet">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">

<script src='https://www.google.com/recaptcha/api.js'></script>


<title>Login</title>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<ul class="navbar-nav navbar-brand ml-auto">
			<li class="nav-item"><a class="nav-link" href="/register"><span
					class="fa fa-user"></span> Sign Up</a></li>
			<li class="nav-item"><a class="nav-link active" href="/"><span
					class="fa fa-unlock-alt"></span> Login</a></li>
		</ul>

	</nav>
	<br>
	<div class="container" style="width: 50%;">
		<div class="card">
			<div class="main-div card-body">
				<form id="login" method="post" action="/checkLogin?id=0&name=''">
					<div class="form-group">
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fa fa-users fa"
									aria-hidden="true"></i></span>
							</div>
							<input type="text" class="form-control input-sm"
								name="inputUsername" placeholder="Username"
								pattern="[A-za-z0-9@]+"
								title="Alphanumeric and @ symbol are allowed!" required>
						</div>
					</div>

					<div class="form-group">
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"><i
									class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
							</div>
							<input type="password" class="form-control input-sm"
								name="inputPassword" placeholder="Password"
								pattern="[A-za-z0-9@#]+"
								title="Alphanumeric , # and @ symbol are allowed!" required>
						</div>
					</div>
					<div class="g-recaptcha"
						data-sitekey="6Lc_N24UAAAAAKEP4_ZsrNUGN4GpJxNBjfnhnL6w"></div>
					<br> <label><span
						class="badge badge-pill badge-danger" id="status"><%=request.getAttribute("status")%></span></label>
					<br>
					<button type="submit" class="btn btn-md login-btn">Login</button>
					<br>
					


				</form>
			</div>

		</div>
	</div>


</body>
</html>