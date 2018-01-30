<%@page import="Entity.Order"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.Order"%>
<%@ page import="BusinessLogic.OrderLogic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Order Confirm</title>
<%@ include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="js/simpleCart.min.js"> </script>
</head>
<body>
<%@ include file="Head.jsp" %>
<script>
	function goback(){
		var userId = document.getElementById("userId").value;
		window.location.href="myspace_index.jsp?userId="+userId;
	}
</script>

<div style="width:100%; padding:30px; text-align:center">
	<div>
		<span style="text-align:center;">
			<strong>You already confirm this order !!!</strong>
		</span>
		<br>
		<span style="text-align:center;">
			<strong>Do you want to comment?</strong>
		</span>
	<div>
	<div style="text-align:center;">
		<div style="margin: 30px;text-align:center;">
		<%
			out.print("<a href='myspace_comment.jsp?oid="+request.getParameter("oid")+"' style='color:#ff6978;'>Go to Comment</a>");
		%>
		</div>
		<div style="margin: 30px;text-align:center;">
			<a href="javascript:;" onclick="goback();">Go Back to myspace</a>
		</div>
	</div>
	<div class="clearfix"></div>
</div>


<div class="clearfix"></div>

<%@ include file="Foot.jsp" %>
</body>
</html>