<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Register</title>
</head>
<body>
<%@include file="Head.jsp" %>
<!-- content -->
<div class="container">
<div class="main">
	<!-- start registration -->
	<div class="registration">
		<div class="registration_left">
		<h2>new user? <span> create an account </span></h2>
		<!-- [if IE] 
		    < link rel='stylesheet' type='text/css' href='ie.css'/>  
		 [endif] -->  
		  
		<!-- [if lt IE 7]>  
		    < link rel='stylesheet' type='text/css' href='ie6.css'/>  
		<! [endif] -->  
		<script>
			(function() {
		
			// Create input element for testing
			var inputs = document.createElement('input');
			
			// Create the supports object
			var supports = {};
			
			supports.autofocus   = 'autofocus' in inputs;
			supports.required    = 'required' in inputs;
			supports.placeholder = 'placeholder' in inputs;
		
			// Fallback for autofocus attribute
			if(!supports.autofocus) {
				
			}
			
			// Fallback for required attribute
			if(!supports.required) {
				
			}
		
			// Fallback for placeholder attribute
			if(!supports.placeholder) {
				
			}
			
			// Change text inside send button on submit
			var send = document.getElementById('register-submit');
			if(send) {
				send.onclick = function () {
					this.innerHTML = '...Sending';
				}
			}
		
		})();
			
			
		function checkPassword(){
			var rpassword1=document.getElementById("rpassword1").value;
			var rpassword2=document.getElementById("rpassword2").value;
			if(rpassword1!= rpassword2){
				document.getElementById("message3").innerHTML="two passwords different!";
				document.getElementById("rpassword2").focus;
			}
			else{
				document.getElementById("message3").innerHTML=" ";
			}
		}
			
		
		function checkUsername(){
			var username=document.getElementById("rusername").value;
			if(username != "")
			{
				var url="User?action=checkUsername&rusername="+username;
				$.post(url,null,function(data){
					if(data!="0"){
						document.getElementById("message1").innerHTML="name already exists!";
						document.getElementById("rusername").focus;
					}
					else{
						document.getElementById("message1").innerHTML=" ";
					}
				});
			}
		}
		
		
		function checkEmail(){
			var email=document.getElementById("remail").value;
			if(email != "")
			{
				var url="User?action=checkEmail&remail="+email;
				$.post(url,null,function(data){
					if(data!="0"){
						document.getElementById("message2").innerHTML="email already exists!";
						document.getElementById("remail").focus;
					}
					else{
						document.getElementById("message2").innerHTML=" ";
					}
				});
			}
		}
			
		</script>
		 <div class="registration_form">
		 <!-- Form -->
			<form id="registration_form" action="User?action=register" method="post">
				<div>
					<label>
						<input placeholder="user name:" type="text" name="rusername" id="rusername" required autofocus onblur="checkUsername()">
						<div id="message1" style="color:#F00"></div>
					</label>
				</div>
				<div>
					<label>
						<input placeholder="email address:" type="email" name="remail" id="remail" required autofocus onblur="checkEmail()">
						<div id="message2" style="color:#F00"></div>
					</label>
				</div>
				<div>
					<label>
						<input placeholder="phone:" type="text" name="rphone" required>
					</label>
				</div>
				<div class="sky-form">
					<div class="sky_form1">
						<ul>
							<li><label class="radio left"><input type="radio" name="rgender" value="Male" checked=""><i></i>Male</label></li>
							<li><label class="radio"><input type="radio" name="rgender" value="Female"><i></i>Female</label></li>
							<div class="clearfix"></div>
						</ul>
					</div>
				</div>
				<div>
					<label>
						<input placeholder="password" type="password" name="rpassword1" id="rpassword1" required>
					</label>
				</div>						
				<div>
					<label>
						<input placeholder="retype password" type="password" name="rpassword2" id="rpassword2" required onblur="checkPassword()">
						<div id="message3" style="color:#F00"></div>
					</label>
				</div>	
				<div>
					<input type="submit" value="create an account" id="register-submit">
				</div>
			</form>
			<!-- /Form -->
		</div>
	</div>
	<div class="clearfix"></div>
	</div>
	<!-- end registration -->
</div>
</div>
<%@include file="Foot.jsp" %>
</body>
</html>