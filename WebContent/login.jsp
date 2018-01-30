<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login</title>
</head>
<body>
<%@include file="Head.jsp" %>
<!-- content -->
<div class="container">
<div class="main">
	<!-- start registration -->
	<div class="registration">
	<div class="registration_left">
		<h2>existing user</h2>
		 <div class="registration_form">
		 <!-- Form -->
			<form id="registration_form" action="User?action=login" method="post">
				<div>
					<label>
						<input placeholder="email:" type="text" id="logintextbox" name="logintextbox" required>
					</label>
				</div>
				<div>
					<label>
					
						<input placeholder="password" type="password" name="password" required>
					</label>
				</div>						
				<div>
					<input type="submit" value="sign in" id="register-submit" name="register-submit">
				</div>
				<div class="forget">
					<a href="#">forgot your password</a>
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