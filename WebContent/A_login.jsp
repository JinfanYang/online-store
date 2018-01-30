<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Admin Login</title>
	<link rel="stylesheet" href="css1/reset.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="css1/style.css" type="text/css" media="screen" />
	<link rel="stylesheet" href="css1/invalid.css" type="text/css" media="screen" />
	
</head>
<body id="login">
		<div id="login-wrapper" class="png_bg">
			<div id="login-top">
				<h1>Admin Login</h1>
			</div>
			<div id="login-content">
			<form action="Admin?action=login" method="post">
				<p>
					<label>UserName :</label>
					<input class="text-input" type="text" name="loginName">
				</p>
				<div class="clear"></div>
				<p>
					<label>Password:</label>
					<input type="password" class="text-input" name="password">
				</p>
				<div class="clear"></div>
				<p>
					<input class="button" type="submit" value="Login in">
				<p>
			</form>
			</div>
		</div>
</body>
</html>