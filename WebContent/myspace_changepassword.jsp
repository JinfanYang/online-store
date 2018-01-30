<%@page import="Entity.User"%>
<%@page import="BusinessLogic.UserLogic"%>
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
	<%
		int uid = (int)request.getSession().getAttribute("USERID");
		UserLogic usl = new UserLogic();
		User auser = usl.findById(uid);
	%>
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
		
		function checkOldPassword(){
			var inputoldpassword = document.getElementById("oldpassword").value;
			var uid = document.getElementById("userId").value;
			var url="User?action=getPassword&uid="+uid;
			$.post(url, null, function(data){
				if(data != inputoldpassword){
					document.getElementById("message2").innerHTML="Wrong Old Password !";
				}
				else{
					document.getElementById("message2").innerHTML=" ";
				}
			});
		}
		</script>
		 <div class="registration_form">
		 <!-- Form -->
			<form id="registration_form" action="User?action=save" method="post">
					<%
						out.print("<input type='hidden' name='ruserid' id='ruserid' value='"+auser.getUserId()+"'>");
					%>
				<div>
					<label>
					<%
						out.print("<input type='text' name='rusername' id='rusername' value='"+auser.getUserName()+"' readonly>");
					%>
					</label>
				</div>
				<div>
					<label>
					<%
						out.print("<input type='email' name='remail' id='remail' value='"+auser.getEmail()+"' readonly>");
					%>
					</label>
				</div>
				<div>
					<label>
					<%
						out.print("<input type='text' name='rphone' id='rphone' value='"+auser.getPhone()+"'>");
					%>
					</label>
				</div>
				<div class="sky-form">
					<div class="sky_form1">
						<ul>
							<%
								if(auser.getGender() == 0){
									out.print("<li><label class='radio left'><input type='radio' name='rgender' value='Male' checked=''><i></i>Male</label></li>");
									out.print("<li><label class='radio'><input type='radio' name='rgender' value='Female'><i></i>Female</label></li>");
								}
								else{
									out.print("<li><label class='radio left'><input type='radio' name='rgender' value='Male'><i></i>Male</label></li>");
									out.print("<li><label class='radio'><input type='radio' name='rgender' value='Female' checked=''><i></i>Female</label></li>");
								}
							%>
							
							<div class="clearfix"></div>
						</ul>
					</div>
				</div>
				<div>
					<label>
						<input placeholder="old password" type="password" name="oldpassword" id="oldpassword" required onblur="checkOldPassword()">
						<div id="message2" style="color:#F00"></div>
					</label>
				</div>	
				<div>
					<label>
						<input placeholder="new password" type="password" name="rpassword1" id="rpassword1" required>
						<div></div>
					</label>
				</div>						
				<div>
					<label>
						<input placeholder="retype new password" type="password" name="rpassword2" id="rpassword2" required onblur="checkPassword()">
						<div id="message3" style="color:#F00"></div>
					</label>
				</div>	
				<div>
					<input type="submit" value="Save" id="register-submit">
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