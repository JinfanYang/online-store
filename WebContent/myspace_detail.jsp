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
<title>Order Details</title>
<%@ include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="js/simpleCart.min.js"> </script>
</head>
<body>
<%@ include file="Head.jsp" %>

<%
	String oid = request.getParameter("oid");
	OrderLogic ol = new OrderLogic();
	List<Order> orders = ol.findById(oid);
%>

<div class="container">
<div class="grids_of_4">
	<div style='text-align:left; border:1px solid #ebebeb; padding:10px;'>
		<h4>Delivery Address</h4>
		<%
			out.print("<span>Name : "+ orders.get(0).getODeliveryName() +"</span><br>");
			out.print("<span>Address : "+ orders.get(0).getODeliveryAddress() +"</span><br>");
			out.print("<span>Phone : "+ orders.get(0).getODeliveryPhone() +"</span>");
		%>
	</div>
	<div class="clearfix"></div>
</div>

<div style="border-bottom:1px solid #ebebeb; padding:5px;"></div>

<div style="padding-top: 20px;">
	<div style="padding-left: 30px;">
	<%
		String[] aoid = oid.split("-");
		out.print("<span>OrderId : " + aoid[0]+"</span><br>");
		out.print("<span>CreateTime : " + orders.get(0).getODate().toString() + "</span><br>");
		if(orders.get(0).getOSentDate() == null){
			out.print("<span>SentTime : </span><br>");
		}
		else{
			out.print("<span>SentTime : " + orders.get(0).getOSentDate().toString() + "</span><br>");
		}
		if(orders.get(0).getOConfirmDate() == null){
			out.print("<span>ConfirmTime : </span><br>");
		}
		else{
		out.print("<span>ConfirmTime : " + orders.get(0).getOConfirmDate().toString() + "</span><br>");
		}
	%>
	<div>
	
	<div style="padding:30px;">
		<table width=100% border="1" bordercolor="#ebebeb" >
			<tbody align="center" valign="middle">
				<tr style="">
				<td></td>
				<td>Name</td>
				<td>Price</td>
				<td>Quantity</td>
				<td>Total</td>
				</tr>
				<%
					for(int i = 0; i<orders.size(); i++)
					{
						
						out.print("<tr>");
						out.print("<td>");
						out.print("<img src='images/"+orders.get(i).getOPic()+"' width=80px>");
						out.print("</td>");
						out.print("<td>");
						out.print("<a href='Product?action=detail&SKU="+orders.get(i).getSKU()+"'>"+orders.get(i).getOName()+"</a>");
						out.print("</td><td>");
						out.print(orders.get(i).getOPrice());
						out.print("</td><td>");
						out.print(orders.get(i).getONumber());
						out.print("</td><td>");
						out.print(orders.get(i).getONumber() * orders.get(i).getOPrice());
						out.print("</td>");
						out.print("</tr>");
					}
				%>
			</tbody>
		</table>
	</div>
</div>

<div class="clearfix"></div>

</div>

<div class="clearfix"></div>

<%@ include file="Foot.jsp" %>
</body>
</html>