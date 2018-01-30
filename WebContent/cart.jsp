<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="BusinessLogic.CartLogic" %>
<%@ page import="Entity.Cart" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="js/simpleCart.min.js"> </script>
<%@include file="Reference.jsp" %>
<title>Check Out</title>
</head>
<body>
<%@include file="Head.jsp" %>
<!-- content -->
<%
	String uid = request.getParameter("userId");
	CartLogic clc = new CartLogic();
	List<ArrayList<String>> cartProducts = clc.findCPInfo(Integer.parseInt(uid));
	double total = clc.totalByUserId(Integer.parseInt(uid));
	double all = total + 150;
			 	
%>
<script>
	function modifyQuantity(sku, no){
		var number = document.getElementById(no).value;
		var uid = document.getElementById("userId").value;
		var url = "Cart?action=modifyQuantity&userId="+uid+"&sku="+sku+"&no="+number;
		$.post(url, null, function(data){
			if(data != null){
				var str = new Array();
				str = data.split('/');
				document.getElementById('simpleCart_total').innerHTML = str[1];
				document.getElementById('total1').innerHTML = str[1];
				document.getElementById('last_price').innerHTML = str[2];
			}
		});
	}
	
	function placeOrder(){
		var products = document.getElementsByName("cartcheck");	
		var product="";
		for(var i =0; i<products.length; i++){
			if(products[i].checked){
				product = product + "/" + products[i].getAttribute("value");
			}
		}
		var userId = document.getElementById("userId").value;
		
		if(product == ""){
			alert("You didn't choose any products!");
		}
		else{
			window.location.href="order.jsp?product="+product+"&userId="+userId;
		}
		
	}
	
</script>

<div class="container">
	<div class="check">	 
			 <div class="col-md-3 cart-total">
			 	<a class="continue" href="index.jsp">Continue to basket</a>
			 
			 	<div class="price-details">
					<h3>Price Details</h3>
					<span>Total</span>
					<span class="total1" id="total1"><%out.print(total); %></span>
					<span>Discount</span>
					<span class="total1">---</span>
					<span>Delivery Charges</span>
					<span class="total1">150.00</span>
					<div class="clearfix"></div>				 
			 	</div>	
			 	<ul class="total_price">
			   		<li class="last_price"> <h4>TOTAL</h4></li>	
			   		<li class="last_price" id="last_price"><span><%out.print(all); %></span></li>
			   		<div class="clearfix"> </div>
			 	</ul>
			
				<a class="order" href="#2" onclick="placeOrder()">Place Order</a>
			 	<div class="clearfix"></div>
			 
			</div>
		 	<div class="col-md-9 cart-items">
				<h1 id="items">My Shopping Bag (<%out.print(cartProducts.size()); %>)</h1>
			 	<%
			 		if(cartProducts.size() > 0){
			 			for(int i = 0; i<cartProducts.size(); i++){
			 				out.print("<script>$(document).ready(function(c){");
			 				out.print("$('#close"+String.valueOf(i)+"').on(\'click\', function(c){");
			 				out.print("var sku"+String.valueOf(i)+" = document.getElementById('sku"+String.valueOf(i)+"').innerHTML;");
			 				out.print("var url"+String.valueOf(i)+" = 'Cart?action=delete&uid="+uid+"&sku='+sku"+String.valueOf(i)+";");
			 				out.print("$.post(url"+String.valueOf(i)+", null, function(data){");
			 				out.print("if(data != 0){");
			 				out.print("var str = new Array();");
			 				out.print("str = data.split('/');");
			 				out.print("document.getElementById('simpleCart_total').innerHTML = str[2];");
			 				out.print("document.getElementById('simpleCart_quantity').innerHTML = str[1];");
			 				out.print("document.getElementById('total1').innerHTML = str[2];");
			 				out.print("document.getElementById('items').innerHTML = 'My Shopping Bag ('+str[1]+')';");
			 				out.print("document.getElementById('last_price').innerHTML = str[3];");
			 		
			 				out.print("$(\'#cart-header"+String.valueOf(i)+"\').fadeOut(\'slow\', function(c){");
			 				out.print("$('#cart-header"+String.valueOf(i)+"').remove();");
			 				out.print("});} });});})</script>");
			 			
			 				out.print("<div class='cart-header' id='cart-header"+String.valueOf(i)+"'>");
			 				out.print("<input type='checkbox' name='cartcheck' value='"+cartProducts.get(i).get(0)+"' />");
			 				out.print("<div class='close' id='close"+String.valueOf(i)+"'></div>");
			 	%>
			 
				 			<div class="cart-sec simpleCart_shelfItem">
								<div class="cart-item cyc">
									<%out.print("<img src='images/"+cartProducts.get(i).get(6)+"' class='img-responsive' alt=''>"); %>
								</div>
					   		<div class="cart-item-info">
								<h3>
									<% out.print("<a href='Product?action=detail&SKU="+cartProducts.get(i).get(0)+"'>"+cartProducts.get(i).get(1)+"</a>"); %>
									<span>SKU: </span>
									<% out.print("<span id=sku"+String.valueOf(i)+">"+cartProducts.get(i).get(0)+"</span>"); %>
								</h3>
								<ul class="qty">
								<%
									switch(cartProducts.get(i).get(4)){
									case "0" : out.print("<li><p>Size : S</p></li>");break;
									case "1" : out.print("<li><p>Size : M</p></li>");break;
									case "2" : out.print("<li><p>Size : L</p></li>");break;
									default : out.print("<li><p>Size : XL</p></li>");
									}
								%>
							
									<li><p>Color : <%out.print(cartProducts.get(i).get(5)); %></p></li>
									<li><p>Prize : <%out.print(cartProducts.get(i).get(2)); %></p></li>
									<li>
										<% out.print("<span>Qty : <input type='text' id='"+String.valueOf(i)+"' value='"+cartProducts.get(i).get(3)+"' onblur=\" modifyQuantity(\'"+cartProducts.get(i).get(0)+"\',\'"+String.valueOf(i)+"\') \" /></span>"); %>
									</li>
								</ul>
						
							 	<div class="delivery">
							 		<span>Delivered in 2-3 bussiness days</span>
							 		<div class="clearfix"></div>
				        		</div>	
					   		</div>
					   		<div class="clearfix"></div>				
				  			</div>
			 <%
			 			out.print("</div>");
			 		}
			 	}
			 %>
		 </div>
		 
		
			<div class="clearfix"> </div>
	 </div>
	 </div>
	<%@include file="Foot.jsp" %>
</body>
</html>