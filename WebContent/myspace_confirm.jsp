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
<script>
	function orderConfirm(){
		var r = confirm("Do you want to confirm this order?");
		if(r){
			var oid = document.getElementById("orderId").value;
			var url = "Order?action=confirm&oid="+oid;
			$.post(url, null, function(data){
				if(data != "0"){
					window.location.href="myspace_confirmsuccess.jsp?oid="+oid;
				}
				else{
					alert("Confirm failed!");
				}
			});
		}
	}
</script>
<%@ include file="Head.jsp" %>

<%
	String oid = request.getParameter("oid");
	OrderLogic ol = new OrderLogic();
	List<Order> orders = ol.findById(oid);
%>

<div class="container">
	<div style="padding:30px;">
	<h4>Order Information</h4>
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
					double total=0;
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
						total += orders.get(i).getONumber() * orders.get(i).getOPrice();
						out.print("</td>");
						out.print("</tr>");
					}
				%>
			</tbody>
		</table>
		<span style="float:left; margin-top:10px;font-weight:bold; color:#ff6978">Total : <%out.print(total); %></span>
	</div>

	<div style="border-bottom:1px solid #ebebeb; padding:5px;"></div>

	<div style="padding-top: 20px;">
		<div style="padding-left: 30px;">
		<%
			String[] aoid = oid.split("-");
			out.print("<input type='hidden' id='orderId' value='"+aoid[0]+"'>");
			out.print("<span>OrderId : " + aoid[0]+"</span><br>");
			out.print("<span>CreateTime : " + orders.get(0).getODate().toString() + "</span><br>");
			out.print("<span>Address : "+ orders.get(0).getODeliveryName() + "&nbsp;&nbsp;"+ orders.get(0).getODeliveryAddress() + "&nbsp;&nbsp;" + orders.get(0).getODeliveryPhone() +"</span>");
		%>
		</div>
	</div>
	
	<div class="create_btn1" style="margin: 30px;">
			<a href="javascript:;" onclick="orderConfirm();">Confirm</a>
		</div>
	<div class="clearfix"></div>
</div>
<div class="clearfix"></div>
</div>

<div class="clearfix"></div>

<%@ include file="Foot.jsp" %>
</body>
</html>