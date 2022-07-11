<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.connectionProvider"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>

<%
User user = (User) session.getAttribute("currentUser");

if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./css/myStyle.css" type="text/css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
	<style>
	body{
background:url(img/b.jpg);
background-size: cover;
background-attachment:fixed; 
}
	</style>
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<div class="container-fluid">
			<a class="navbar-brand" href="index.jsp"><span
				class="fa fa-asterisk"></span> Tech Blog</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#"><span class=" fa  fa-bell-o"></span>
							Learn code with Jayesh</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							<span class="fa fa-check-square-o"></span> Category
					</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="#">Programming
									Language</a></li>
							<li><a class="dropdown-item" href="#">Project
									Implementation</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="#">Data Structure</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link" href="#"><span
							class="fa fa-address-card-o"></span> Contact</a></li>

					<li class="nav-item"><a class="nav-link" href="#!"
						data-toggle="modal" data-target="#add-post-model"><span
							class="fa fa-asterisk"></span> Do post</a></li>

				</ul>
				<ul class="navbar-nav mr-right">

					<li class="nav-item"><a class="nav-link" href="#!"
						data-toggle="modal" data-target="#profile-modal"><span
							class="fa fa-user-circle"></span> <%=user.getName()%></a></li>

					<li class="nav-item"><a class="nav-link" href=LogoutServlet><span
							class="fa fa-sign-out"></span> Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Navbar -->

	<!-- User Details Modal -->
	<%
	Message m = (Message) session.getAttribute("msg");
	if (m != null) {
	%>

	<div class="alert <%=m.getCssClass()%>" role="alert"><%=m.getContent()%></div>
	<%
	session.removeAttribute("msg");
	}
	%>
	<!-- Main body of page -->

	<main>
		<div class="container">
			<div class="row mt-4">
				<!--FIrst col  -->
				<div class="col-md-4">
					<!--category  -->

					<div class="list-group">
					
  <a href="#" class="c-link border border-primary list-group-item list-group-item-saction"  onclick="getPosts(0,this)">All posts</a>
  <!-- categories -->
  <%
  PostDao d = new PostDao(connectionProvider.getConnection());
  ArrayList<Category> list1  =d.getAllCategories();
  for(Category cc: list1){
	  %>
	  <a href="#" onclick="getPosts(<%= cc.getCid() %>,this)" class="c-link border  list-group-item list-group-item-saction"><%=cc.getName() %></a>

  <% }
  
  %>
</div>

				</div>

				<!--second column  -->

				<div class="col-md-8" >

					<!--Posts  -->
	<div class="container text-center" id="loader">
	<i class="fa fa-refresh fa-4x fa-spin"></i>
	<h3>Loading</h3>
	</div>
<div class="container-fluid" id="post-container">


</div>
				</div>
			</div>
		</div>
	</main>

	<!--MAin body of page  -->

	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="./pics/<%=user.getProfile()%>" class="img-fluid"
							style="border-radius: 50%; height: 200px; max-width: 150px;">
						<br>
						<h5 class="modal-title mt-3" id="exampleModalLabel">
							<%=user.getName()%></h5>
						<!-- details -->
						<div id="profile-details">
							<table class="table">
								<tbody>
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>
									</tr>
									<tr>
										<th scope="row">About :</th>
										<td><%=user.getAbout()%></td>
									</tr>
									<tr>
										<th scope="row">Registered on :</th>
										<td><%=user.getDatetime()%></td>
									</tr>
								</tbody>
							</table>
						</div>
						<!--Profile Edit  -->
						<div id="profile-edit" style="display: none">
							<h3 class="mt-2">Please Edit Carefully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>ID :</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td>Email :</td>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>" /></td>
									</tr>

									<tr>
										<td>Name :</td>
										<td><input type="text" class="form-control"
											name="user_name" value="<%=user.getName()%>" /></td>
									</tr>
									<tr>
										<td>Password :</td>
										<td><input type="password" class="form-control"
											name="user_password" value="<%=user.getPassword()%>" /></td>
									</tr>
									<tr>
										<td>Gender :</td>

										<td><input type="" class="form-control" name=""
											value="<%=user.getGender()%>" /></td>
									</tr>
									<tr>
										<td>About :</td>
										<td><textarea rows="5" class="form-control"
												name="user_about"><%=user.getAbout()%></textarea></td>
									</tr>
									<tr>
										<td>New Profile:</td>
										<td><input type="file" name="images" class="form-control"></td>
									</tr>
								</table>
								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>
							</form>

						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" id="edit-profile-button"
						class="btn btn-primary">Edit</button>
				</div>
			</div>
		</div>
	</div>
	<!-- User Details Modal -->


	<!--add post model  -->

	<!-- Modal -->
	<div class="modal fade" id="add-post-model" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide Post
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form id="add-post-form" action="AddPostServlet" method="post">

						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected disabled>---Select Category---</option>
								<%
								PostDao post = new PostDao(connectionProvider.getConnection());
								ArrayList<Category> list = post.getAllCategories();
								for (Category c : list) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>
								<%
								}
								%>
							</select>
						</div>

						<div class="form-group">
							<input type="text" name="pTitle" placeholder="Enter post Title"
								class="form-control">
						</div>
						<div class="form-group">
							<textarea type="text" name="pContent" style="height: 200px"
								placeholder="Enter Your Content" class="form-control"></textarea>
						</div>
						<div class="form-group">
							<textarea type="text" name="pCode" style="height: 200px"
								placeholder="Enter Your Program (if any)" class="form-control"></textarea>
						</div>
						<div class="form-group">
							select your pic: <br> <input type="file" name="pic" />
						</div>
						<div>
							<button type="submit"
								class="btn btn-primary text-white text-center">Post</button>
						</div>
					</form>

				</div>

			</div>
		</div>
	</div>
	<!--end post model  -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"
		integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI="
		crossorigin="anonymous"></script>
	<script>
		$(document).ready(function() {
			let editStatus = false;

			$('#edit-profile-button').click(function() {

				if (editStatus == false) {
					$('#profile-details').hide()
					$('#profile-edit').show()
					editStatus = true;
					$(this).text("Back")
				} else {
					$('#profile-details').show()
					$('#profile-edit').hide()
					editStatus = false;
					$(this).text("Edit")

				}
			})
		});
		</script>
	<!-- Now add post js -->
	<script>
		$(document).ready(function(e) {
			$("#add-post-form").on("submit",function(event){
				event.preventDefault();
				console.log("submit button click")
				let form = new FormData(this);
				
				//now requesting to server
				$.ajax({
					url:"AddPostServlet",
					type:"POST",
					data:form,
					success:function(data,textStatus,jqXHR){
					//success....
					swal("Post Added Successfully..","we are redirecting to Profile page","success")
						.then((value)=>{
							window.location ="profile.jsp;"
						});
					},
					error:function(jqXHR,textStatus,errorThrown){
						//error
						swal("Error","You clicked the button!","error");
					},
					processData: false,
					contentType:false
				})
			})
		})
		
		</script>
		<!--load post using ajax  -->
		<script>
		function getPosts(catId,temp){
			
			$("#loader").show();
			$("#post-container").hide();
			
			$(".c-link").removeClass('active')
			$.ajax({
				url:"load_posts.jsp",
				data:{cid:catId},
				success:function(data,textStatus, jqXHR){
					console.log(data);
					$("#loader").hide();
					$("#post-container").show();
					$('#post-container').html(data)
					$(temp).addClass("active");
				}
			})
		}
		
		$(document).ready(function(){
			
			let allPostRef =$(".c-link")[0]
			getPosts(0,allPostRef);
			
		})
		</script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>