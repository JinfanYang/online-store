<%@page import="Entity.Order"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.Order"%>
<%@ page import="BusinessLogic.OrderLogic" %>
<!DOCTYPE html>
<html>
<head>
<script src="http://api.map.baidu.com/api?v=1.5&ak=jFFGKTR0YGbeFvAXfn36ydqK" type="text/javascript"></script>
<title>Order Comment</title>
<%@ include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=1.5&amp;ak=jFFGKTR0YGbeFvAXfn36ydqK&amp;services=&amp;t=20150522094656"></script>

</head>
<body>
<%@ include file="Head.jsp" %>

<%
	String oid = request.getParameter("oid");
	OrderLogic ol = new OrderLogic();
	List<Order> orders = ol.findById(oid);
%>

<div class="container">
<form action="Comment?action=add" method="post">
<div>
<%
	out.print("<input type='hidden' id='itemnumber' name='itemnumber' value='"+orders.size()+"'>");
	out.print("<input type='hidden' id='hiddenoid' name='hiddenoid' value='"+oid+"'>");
	for(int i = 0; i<orders.size(); i++)
	{
%>
	<div>
		<div style='padding:10px;'>
			<div style="float:left; width:150px">
				<% 
					out.print("<img src='images/"+orders.get(i).getOPic()+"' width=100px><br>"); 
					out.print("<span>"+orders.get(i).getOName()+"</span>");
					out.print("<input type='hidden' id='orderid' name='orderid"+String.valueOf(i)+"' value='"+orders.get(i).getOId()+"'>");
				%>
			</div>
			<div style="float:left">
				<div>
					<ul style="list-style:none; width:100%;">
						<li style="float:left;">
							<label for="good">
								<%out.print("<input type='radio' name='commentradio"+String.valueOf(i)+"' id='good' value='1'>"); %>
								<img alt="" src="images/good.png">
							</label>
						</li>
						<li style="float:left;">
							<label for="normal">
								<%out.print("<input type='radio' name='commentradio"+String.valueOf(i)+"' id='normal' value='2'>"); %>
								<img alt="" src="images/normal.png">
							</label>
						</li>
						<li style="float:left;">
							<label for="bad">
								<%out.print("<input type='radio' name='commentradio"+String.valueOf(i)+"' id='bad' value='3'>"); %>
								<img alt="" src="images/bad.png">
							</label>
						</li>
					</ul>
				</div>
				<%out.print("<textarea  name='comment"+String.valueOf(i)+"' id='comment' rows='5' style='width: 900px; border: 1px solid #d6d6d6 '></textarea>"); %>
			</div>
		</div>
		<div class="clearfix"></div>
	</div>

	<div style="border-bottom:1px solid #ebebeb; padding:5px;"></div>
<%
	}
%>

</div>
<div style="width:100px;">
<div class="create_btn1" style="margin-left: 30px; padding: 30px">
	<!-- <a href="Comment?action=add">Comment</a>  -->
	<input type="submit" value="Comment">
</div>
<div class="clearfix"></div>
</form>
</div>
<div class="clearfix"></div>
<%@ include file="Foot.jsp" %>
</body>
</html>