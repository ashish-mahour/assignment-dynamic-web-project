<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Custom CSS -->
<link href="/res/custom.css" rel="stylesheet">

<!-- BoootStrap links -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<!-- Google and Bootstrap fonts -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">

<script src='https://www.google.com/recaptcha/api.js'></script>

<title>Registration</title>

</head>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<ul class="navbar-nav navbar-brand ml-auto">
			<li class="nav-item"><a class="nav-link active" href="/register"><span
					class="fa fa-user"></span> Sign Up</a></li>
			<li class="nav-item"><a class="nav-link " href="/"><span
					class="fa fa-unlock-alt"></span> Login</a></li>
		</ul>

	</nav>
	<br>
	<div class="container" style="width: 50%">
		<div class="card">
			<div class="main-div card-body">
				<form id="registration" method="post" action="/insertData">
					<div class="form-group">
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fa fa-users fa"
									aria-hidden="true"></i></span>
							</div>
							<input type="text" class="form-control input-sm" name="inputName"
								placeholder="Full Name" pattern="[A-za-z\s]+"
								title="Alphabets are allowed!" required>
						</div>
					</div>

					<div class="form-group">
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fa fa-envelope "
									aria-hidden="true"></i></span>
							</div>
							<input type="email" class="form-control input-sm" name="inputEmail"
								placeholder="Email" required>
						</div>
					</div>

					<div class="form-group">
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="material-icons"
									aria-hidden="true" style="font-size: 20px">phone_android</i></span>
							</div>
							<input type="text" class="form-control input-sm" name="inputMobile"
								placeholder="Mobile" pattern="[0-9+]{10,13}"
								title="Numeric and + symbol are allowed!" required>
						</div>
					</div>

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
						<div class="input-group mb-2">
							<div class="input-group-prepend">
								<span class="input-group-text"><i class="fa fa-lock fa"
									aria-hidden="true" style="font-size: 20px"></i></span>
							</div>
							<input type="password" class="form-control input-sm"
								name="inputPassword" placeholder="Password"
								pattern="[A-za-z0-9@#]+"
								title="Alphanumeric , # and @ symbol are allowed!" required>
						</div>
					</div>

					<div class="form-group">
						<div class="input-group mb-2">
							<div class="form-check-inline">
								<div class="input-group-prepend">
									<span class="input-group-text"><input type="radio"
										name="role" value="user" checked="checked"></span>
								</div>
								<label class="form-check-label" style="margin-left: 5px">
									User </label>
							</div>
							<div class="form-check-inline">
								<div class="input-group-prepend">
									<span class="input-group-text"><input type="radio"
										name="role" value="admin"></span>
								</div>
								<label class="form-check-label" style="margin-left: 5px">
									Admin </label>
							</div>
						</div>
					</div>

					<div class="g-recaptcha"
						data-sitekey="6Lc_N24UAAAAAKEP4_ZsrNUGN4GpJxNBjfnhnL6w"></div>
					<br>
					<label><span class="badge badge-pill badge-success"><%=request.getAttribute("status") %></span></label>
					<br>
					<button type="submit" class="btn btn-md login-btn">Register</button>
					
				</form>
			</div>

		</div>
	</div>
</body>
</html>