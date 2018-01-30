<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>New Address</title>
</head>
<body>
<%@include file="Head.jsp" %>
<!-- content -->
<div class="container">
<div class="main">
	<!-- start registration -->
	<div class="registration">
	<div class="registration_left">
		<h2>New Address</h2>
		 <div class="registration_form">
		 <!-- Form -->
			<form id="registration_form" action="DeliveryAddress?action=add" method="post">
				<div>
					<label>Name: </label>
					<input type="text" id="nametextbox" name="nametextbox" required>
				</div>
				<div>
					<label>Phone: </label>
						<input type="text" name="phone" required>
				</div>	
				<div>
					<label>Address: </label>
					<textarea  name="address" rows="5" clos="50" style="width: 510px; border: 1px solid #d6d6d6 "></textarea>
				</div>						
				<div>
					<input type="submit" value="Submit" id="newAddress-submit" name="newAddress-submit">
				</div>
				<%
					out.print("<input type='hidden' id='uid' name='uid' value='"+request.getSession().getAttribute("USERID")+"'>");
					out.print("<input type='hidden' id='product' name='product' value='"+request.getParameter("product")+"'>");
				%>
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