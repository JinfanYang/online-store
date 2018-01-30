<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="BusinessLogic.OrderLogic" %>
<%@ page import="Entity.Order" %>
<!DOCTYPE html>
<html>
<head>
<title>My Space</title>
<%@include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="js/simpleCart.min.js"> </script>
<script>
	function change(str){
		var uid = document.getElementById("userId").value;
		
		if(str =="all"){
			var url = "Order?action=all&userId="+uid;
			$.post(url, null, function(data){
				if(data != ""){
					$("#tablebody").html(data);
				}
				else{
					$("#tablebody").html("No product!");
				}
			});
		}
		else if(str == "pay"){
			var url = "Order?action=allpay&userId="+uid;
			$.post(url, null, function(data){
				if(data != ""){
					$("#tablebody").html(data);
				}
				else{
					$("#tablebody").html("No product!");
				}
			});
			
		}
		else if(str == "remind"){
			var url = "Order?action=allremind&userId="+uid;
			$.post(url, null, function(data){
				if(data != ""){
					$("#tablebody").html(data);
				}
				else{
					$("#tablebody").html("No product!");
				}
			});
			
		}
		else if(str == "confirm"){
			var url = "Order?action=allconfirm&userId="+uid;
			$.post(url, null, function(data){
				if(data != ""){
					$("#tablebody").html(data);
				}
				else{
					$("#tablebody").html("No product!");
				}
			});
			
		}
		else{
			var url = "Order?action=allcomment&userId="+uid;
			$.post(url, null, function(data){
				if(data != ""){
					$("#tablebody").html(data);
				}
				else{
					$("#tablebody").html("No product!");
				}
			});
		}	
		
	}
	
	function cancel(str){
		var uid = document.getElementById("userId").value;
		var r = confirm("Do you want to cancel this order?");
		if(r){
			var url="Order?action=cancel&oid="+str;
			$.post(url, null, function(data){
				if(data != ""){
					window.location.href="myspace_index.jsp?userId="+uid;
				}
			});
		}
	}
	
</script>
</head>
<body>
<%@include file="Head.jsp" %>
<!-- content -->
<%
	int userId = (int)request.getSession().getAttribute("USERID");
	OrderLogic ol = new OrderLogic();
	List<String> oids = ol.findOid(userId);
%>
<div class="container">
	<!-- side menu -->
	<div>
		<div class="col-md-3 s-d">
			<div class="w_sidebar">
				<div class="w_nav1">
					<ul>
						<%
							out.print("<li><a href='myspace_index.jsp'>My Order</a></li>");
						%>
						
						<li><a href="myspace_changepassword.jsp">Change profile</a></li>
					</ul>	
				</div>
			</div>
		</div>
	</div>
	<!-- content -->
	<div class="col-md-9 w_content">
		<div style="width: 100%; margin: 15px; padding: 10px">
			<ul style="float:left;">
				<li style="float:left; list-style:none; width: 100px;"><input type="radio" name="orderradio" checked="checked" onclick="change('all')">All Order</li>
				<li style="float:left; list-style:none; width: 150px;"><input type="radio" name="orderradio" onclick="change('pay')">Wait to Pay</li>
				<li style="float:left; list-style:none; width: 150px;"><input type="radio" name="orderradio" onclick="change('remind')">Wait to Send</li>
				<li style="float:left; list-style:none; width: 150px;"><input type="radio" name="orderradio" onclick="change('confirm')">Wait to Confirm</li>
				<li style="float:left; list-style:none; width: 150px;"><input type="radio" name="orderradio" onclick="change('comment')">Wait to Comment</li>
			</ul>
		</div>
		
		<div style="margin: 30px; padding:10px;">
			<table width=100% border="1" bordercolor="#ebebeb">
				<tbody align="center" valign="middle" id="tablebody">
				<%
					for(int i=0;i<oids.size();i++){
						if(i == 0){
							String oid = oids.get(i);
							String[] oid1 = oid.split("-");
							List<Order> items = ol.findItems(userId, oid);
							out.print("<tr style='border-bottom : 1px, solid, #ebebeb;' align='left' >");
							out.print("<td  colspan='7' >");
							out.print("<span padding= 10px>&nbsp; &nbsp; Date : "+items.get(0).getODate()+"</span>");
							out.print("<span padding=10px > &nbsp; &nbsp; OrderId : "+ oid1[0] + "</span>");
							out.print("</td>");
							out.print("</tr>");
							
							for(int j = 0; j<items.size(); j++){
								out.print("<tr>");
								out.print("<td>");
								out.print("<img src='images/"+items.get(j).getOPic()+"' width=80px>");
								out.print("</td>");
								out.print("<td>");
								out.print("<a href='Product?action=detail&SKU="+items.get(j).getSKU()+"'>"+items.get(j).getOName()+"</a>");
								out.print("</td><td>");
								out.print(items.get(j).getOPrice());
								out.print("</td><td>");
								out.print(items.get(j).getONumber());
								out.print("</td><td>");
								out.print(items.get(j).getONumber() * items.get(j).getOPrice());
								out.print("</td>");
								if(j == 0){
									out.print("<td rowspan='"+items.size()+"'>");
									out.print("<a href='myspace_detail.jsp?oid="+oid+"'>Detail</a>");
									if(items.get(0).getOStatus() != 5){
										out.print("<br>");
										out.print("<a href='myspace_logistics.jsp?oid="+oid+"'>Location</a>");
									}
									switch(items.get(0).getOStatus()){
										case 0 : out.print("<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>");break;
										case 1 : out.print("<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>");break;
										case 2 : out.print("<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>");break;
									}
									out.print("</td>");
									out.print("<td rowspan='"+items.size()+"'>");
									switch(items.get(0).getOStatus()){
										case 0 : out.print("<a id='orderStatus' href='alipayindex.jsp?oid="+oid+"&price="+items.get(j).getONumber() * items.get(j).getOPrice()+"''>To Pay</a>");break;
										case 1 : out.print("<a id='orderStauts' href='#'>Remind Delivery</a>");break;
										case 2 : out.print("<a href='#'>Remind Delivery</a>");break;
										case 3 : out.print("<a href='myspace_confirm.jsp?oid="+oid+"'>Confirm</a>");break;
										case 4 : out.print("<a href='myspace_comment.jsp?oid="+oid+"'>Comment</a>");break;
										case 5 : out.print("<a href='#2'>Canceled</a>");break;
										default : out.print("<a href='#2'>Finished</a>");
									}
									out.print("</td></tr>");
								}
								else{
									out.print("</tr>");
								}
							}
						}
						else{
							String oid = oids.get(i);
							String[] oid1 = oids.get(i).split("-");
							String[] oid2 = oids.get(i-1).split("-");
							if(oid1[0].equals(oid2[0])){
								continue;
							}
							else{
								String oida = oid1[0];
								List<Order> items = ol.findItems(userId, oid);
								out.print("<tr style='border-bottom : 1px, solid, #ebebeb;' align='left' >");
								out.print("<td  colspan='7' >");
								out.print("<span padding= 10px>&nbsp; &nbsp; Date : "+items.get(0).getODate()+"</span>");
								out.print("<span padding=10px > &nbsp; &nbsp; OrderId : "+ oida + "</span>");
								out.print("</td>");
								out.print("</tr>");
								
								for(int j = 0; j<items.size(); j++){
									out.print("<tr>");
									out.print("<td>");
									out.print("<img src='images/"+items.get(j).getOPic()+"' width=80px>");
									out.print("</td>");
									out.print("<td>");
									out.print("<a href='Product?action=detail&SKU="+items.get(j).getSKU()+"'>"+items.get(j).getOName()+"</a>");
									out.print("</td><td>");
									out.print(items.get(j).getOPrice());
									out.print("</td><td>");
									out.print(items.get(j).getONumber());
									out.print("</td><td>");
									out.print(items.get(j).getONumber() * items.get(j).getOPrice());
									out.print("</td>");
									if(j == 0){
										out.print("<td rowspan='"+items.size()+"'>");
										out.print("<a href='myspace_detail.jsp?oid="+oid+"'>Detail</a>");;
										if(items.get(0).getOStatus() != 5){
											out.print("<br>");
											out.print("<a href='myspace_logistics.jsp?oid="+oid+"'>Location</a>");
										}
										switch(items.get(0).getOStatus()){
										case 0 : out.print("<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>");break;
										case 1 : out.print("<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>");break;
										case 2 : out.print("<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>");break;
										}
										out.print("</td>");
										out.print("<td rowspan='"+items.size()+"'>");
										switch(items.get(0).getOStatus()){
										case 0 : out.print("<a href='#'>To Pay</a>");break;
										case 1 : out.print("<a href='#'>Remind Delivery</a>");break;
										case 2 : out.print("<a href='#'>Remind Delivery</a>");break;
										case 3 : out.print("<a href='myspace_confirm.jsp?oid="+oid+"'>Confirm</a>");break;
										case 4 : out.print("<a href='myspace_comment.jsp?oid="+oid+"'>Comment</a>");break;
										case 5 : out.print("<a href='#2'>Canceled</a>");break;
										default : out.print("<a href='#2'>Finished</a>");
										}
										out.print("</td></tr>");
									}
									else{
										out.print("</tr>");
									}
								}
							}
									
						}
					}
						
				%>
			</table>
		</div>
		
	</div>
</div>

<%@include file="Foot.jsp" %>
</body>
</html>