<%@page import="com.adwb.dao.entity.CompanyData"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<title>User Panel</title>
</head>
<body>
	<%
		@SuppressWarnings("unchecked")
		List<CompanyData> companyDatas = (List<CompanyData>) request.getAttribute("listOfCompanies");
		session.setAttribute("companyDatas", companyDatas);
	%>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<ul class="navbar-nav navbar-brand ml-auto">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="/register"
				data-toggle="dropdown"><span class="fa fa-user"></span> Welcome
					<%=request.getAttribute("username")%></a>
				<div class="dropdown-menu bg-light">
					<a class="dropdown-item" href="/">Logout</a>
				</div></li>
		</ul>
	</nav>
	<br>
	<div class="container" style="width: 100%">
		<table class="table table-striped">
			<thead class="thead-dark">
				<tr>
					<th>SNo.</th>
					<th>Company Name</th>
					<th>Created By.</th>
					<th>Company Address</th>
					<th>Status</th>
				</tr>
			</thead>
			<c:set var = "count" value = "1"></c:set>
			<c:forEach var="compData" items="${companyDatas}" varStatus="loop">
				<c:if test="${compData.creatorName == username || not compData.creatorName == 'Admin'}">
					<tr>
						<td><c:out value="${count}"></c:out></td>
						<c:set var="count" value="${count+1}"></c:set>
						<td>${compData.compName}</td>
						<td>${compData.creatorName}</td>
						<td>${compData.compAddress}</td>
						<td><c:if test="${not compData.status}">
								<c:out value="Unapproved"></c:out>
							</c:if> <c:if test="${compData.status}">
								<c:out value="Approved"></c:out>
							</c:if></td>
					</tr>
				</c:if>
			</c:forEach>

		</table>
		<button class="btn btn-primary" data-toggle="modal"
			data-target="#create" id="newComp" style="width:20%;">Add New Company</button>
	</div>
	<div class="modal" id="create">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modalTitle">Add New Company</h4>
					<button class="close" data-dismiss="modal">&times;</button>
				</div>
				<form action="/compCreatebyUser" method="post" id="form1">
					<div class="modal-body">
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">Name</span>
							</div>
							<input type="text" class="form-control" name="compName"
								id="compName" placeholder="Company Name"
								pattern="[A-za-z0-9\s]+" title="Alphanumics are allowed!"
								required>
						</div>
						<br>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">Address</span>
							</div>
							<input type="text" class="form-control"
								placeholder="Company Address" pattern="[A-za-z0-9\s,]+"
								name="compAddress" id="compAddress"
								title="Alphanumeric and comma(,) are allowed!" required>
						</div>
						<br>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">Created by</span>
							</div>
							<input type="text" class="form-control"
								placeholder="<%=request.getAttribute("username")%>" id="creator"
								disabled="disabled">
						</div>
					</div>
					<br>
					<div class="modal-footer">
						<input type="submit" class="btn btn-success text-white"
							value="Submit">
						<button class="btn btn-danger" data-dismiss="modal">Close</button>
					</div>
					<input type="hidden" id="id" name="id"
						value="<%=request.getAttribute("uid")%>">
				</form>
			</div>
		</div>

	</div>

</body>
</html>