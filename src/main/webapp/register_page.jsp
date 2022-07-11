<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


<link rel="stylesheet" href="./css/myStyle.css" type="text/css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 94%, 68% 91%, 31% 96%, 0 89%, 0 0);
}
</style>
<title>Register Page</title>
</head>
<body>
	<%@include file="/normalNavBar.jsp"%>

	<main class="primary-background banner-background"
		style="padding-bottom: 80px;">
		<div class="container">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card">
						<div
							class="card-header primary-background text-white text-center ">
							<p>Register here</p>
							<span class="fa fa-3x fa-user-circle  "></span>
						</div>
						<div class="card-body">

							<form id="reg-form" Method="post">
								<div class="form-group">
									<label for="user_name">User Name</label> <input type="text"
										class="form-control" id="user_name" name="user_name"
										aria-describedby="emailHelp" placeholder="Enter Name">

								</div>
								<div class="form-group">
									<label for="user_name">Email Address</label> <input
										type="email" class="form-control" id="user_email"
										name="user_email" aria-describedby="emailHelp"
										placeholder="Enter email">

								</div>
								<div class="form-group">
									<label for="user_password">Password</label> <input
										type="password" class="form-control" id="user_password"
										name="user_password" placeholder="Password">
								</div>

								<div class="form-group">
									<label for="gender">Select Gender</label> <br> <input
										type="radio" id="gender" name="user_gender" value="male">
									Male <input type="radio" id="user_gender" name="user_gender"
										value="female"> Female
								</div>

								<div class="form-group">
									<label for="user_about">About</label> <br>
									<textarea name="user_about" class="form-control"
										id="user_about" rows="5"
										placeholder="Enter something about yourself"></textarea>
								</div>


								<div class="form-group form-check">
									<input name="check" id="check" type="checkbox"
										class="form-check-input" id="exampleCheck1"> <label
										class="form-check-label" for="exampleCheck1">agree
										terms and conditions</label>
								</div>
								<br>
								<div class="container text-center id="loader" style="display:none;">
								<span class="fa fa-refresh fa-spin fa-4x "></span>
								<h4>please wait</h4>
								</div>
								<button id='submitbtn' type="submit" class="btn btn-primary text-white">Submit</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

	</main>

	<script>
		$(document).ready(function() {
			console.log("loaded......")

			$('#reg-form').on('submit', function(event) {
				event.preventDefault();
				let form = new FormData(this);
				
				$('#submitbtn').hide();
				$('#loader').show();
			
				

				//send register servlet
				$.ajax({
					url : "RegisterServlet",
					type : 'POST',
					data : form,
					success : function(data, textStatus, jqXHR) {
						console.log(data)
						
						$('#submitbtn').show();
						$('#loader').hide();
						
						if(data.trim() === "done")
							{
						swal("Register Successfully.. we are redirecting to login page")
						.then((value)=>{
							window.location ="login_page.jsp"
						});
							}
						else{
							swal(data);

						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log(jqXHR)
						$('#submitbtn').show();
						$('#loader').hide();
						swal("something went wrong.. Try again");
						
					},
					processData : false,
					contentType : false

				});
			});
		});
	</script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
		integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous">
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
		
</body>
</html>