<%@page import="com.adwb.controller.BaseController"%>
<%@page import="com.adwb.dao.entity.CompanyData"%>
<%@page import="java.util.List"%>
<%@page
	import="org.springframework.web.servlet.mvc.support.RedirectAttributes"%>
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
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
	
</script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>


<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
<title>Administrator Panel</title>
</head>
<body>
	<%
		@SuppressWarnings("unchecked")
		List<CompanyData> companyDatas = (List<CompanyData>) request.getAttribute("listOfCompanies");
		session.setAttribute("companyDatas", companyDatas);
	%>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<ul class="navbar-nav navbar-brand ml-auto">
			<li class="nav-item"><a class="nav-link"
				href="/adminpanel?id=<%=request.getAttribute("uid")%>"><span
					class="fa fa-user"></span> Welcome <%=request.getAttribute("username")%></a></li>
		</ul>
	</nav>
	<br>
	<div class="container">
		<div class="bg-dark d-flex justify-content-end">
				<div class="input-group mb-2" style="width: 50%; padding: 10px;">
					<input type="text" class="form-control input-sm" name="search" id="search"
						placeholder="Search" pattern="[A-za-z0-9\s]+"
						title="Alphanumics are allowed!">
					<div class="input-append">
						<button class="btn btn-success" id="searchBtn">Search</button>
						<button class="btn btn-info" id="restoreBtn">Restore</button>
					</div>
				</div>
		</div>
		<table class="table table-striped">
			<thead class="thead-dark">
				<tr>
					<th>SNo.</th>
					<th>Company Name</th>
					<th>Created By.</th>
					<th>Company Address</th>
					<th>Actions</th>
				</tr>
			</thead>
			<c:forEach var="compData" items="${companyDatas}">
				<tr>
					<td>${compData.id}</td>
					<td>${compData.compName}</td>
					<td>${compData.creatorName}</td>
					<td>${compData.compAddress}</td>
					<td>
						<button class="btn btn-primary" id="edit${compData.id}"
							data-toggle="modal" data-target="#createOrUpdate">Edit</button>
						<button class="btn btn-danger" id="delete${compData.id}">Delete</button>
						<c:if test="${not compData.status}">
							<button class="btn btn-success" id="approve${compData.id}">Approve</button>	
						</c:if>
					</td>
				</tr>
			</c:forEach>

		</table>
		<button class="btn btn-success" data-toggle="modal"
			data-target="#createOrUpdate" id="newComp">New Company</button>
	</div>
	<script>
		<c:forEach var="compData" items="${companyDatas}">
		$("#edit${compData.id}").click(function() {
			var element = $(this).closest("tr");
			var id = element.find("td:eq(0)").text();
			var name = element.find("td:eq(1)").text();
			var address = element.find("td:eq(3)").text();
			$("#compId").val(id);
			$("#compName").val(name);
			$("#compAddress").val(address);
			$("#modalTitle").text("Update Company Details");
			$("#form1").attr("action", "/compUpdatebyAdmin");
		});

		$("#delete${compData.id}").click(function() {
			var element = $(this).closest("tr");
			var id = element.find("td:eq(0)").text();
			$("#compId").val(id);
			$("#form1").attr("action", "/compDeletebyAdmin");
			$("#form1").submit();
		});

		</c:forEach>

		$("#newComp").click(function() {
			$("#compName").val("");
			$("#compAddress").val("");
			$("#modalTitle").text("Add New Company");
		});

		$("#searchBtn")
				.click(
						function() {
							$("table tr")
									.each(
											function() {
												if ($(this).find("th").eq("1")
														.text() == "Company Name"
														|| $(this).find("td")
																.eq("1").text() == $(
																"#search")
																.val()
														|| $(this).find("td")
																.eq("2").text() == $(
																"#search")
																.val()) {
													$(this).show();
												} else {
													$(this).hide();
												}
											});
						});

		$("#restoreBtn").click(function() {
			$("table tr").each(function() {
				$(this).show();
			});
		});
	</script>

	<div class="modal" id="createOrUpdate">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modalTitle">Add New Company</h4>
					<button class="close" data-dismiss="modal">&times;</button>
				</div>
				<form action="/compCreatebyAdmin" method="post" id="form1">
					<input type="hidden" id="compId" name="compId" value="0"> <input
						type="hidden" id="status" name="status" value="true">
					<div class="modal-body">
						<div class="input-group">
							<div class="input-prepend">
								<span class="input-group-text">Name</span>
							</div>
							<input type="text" class="form-control" name="compName"
								id="compName" placeholder="Company Name"
								pattern="[A-za-z0-9\s]+" title="Alphanumics are allowed!"
								required>
						</div>
						<br>
						<div class="input-group">
							<div class="input-prepend">
								<span class="input-group-text">Address</span>
							</div>
							<input type="text" class="form-control"
								placeholder="Company Address" pattern="[A-za-z0-9\s,]+"
								name="compAddress" id="compAddress"
								title="Alphanumeric and comma(,) are allowed!" required>
						</div>
						<br>
						<div class="input-group">
							<div class="input-prepend">
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
	<script>
		
	</script>

</body>
</html>