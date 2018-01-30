<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="Entity.DeliveryAddress" %>
<%@ page import="BusinessLogic.DeliveryAddressLogic" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.Product"%>
<%@ page import="BusinessLogic.ProductLogic" %>
<%@ page import="BusinessLogic.CartLogic" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Order</title>
<%@ include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="js/simpleCart.min.js"> </script>
</head>
<body>
<script type="text/javascript">
	function addNewAddress(){
		var userid = document.getElementById("userId").value;
		var product = document.getElementById("product").value;
		window.location.href="addNewAddress.jsp?userId="+userid+"&product="+product;
	}
	
	function placeOrder(){
		var userid = document.getElementById("userId").value;
		var product = document.getElementById("product").value;
		
		var addresses = document.getElementsByName("radio");
		var address="";
		for(var i =0; i<addresses.length; i++){
			if(addresses[i].checked){
				address = address + "/" + addresses[i].getAttribute("value");
			}
		}

		var waytopays = document.getElementsByName("payradio");
		var waytopay = "";
		for(var i =0; i<waytopays.length; i++){
			if(waytopays[i].checked){
				waytopay = waytopay + "/" + waytopays[i].getAttribute("value");
			}
		}
		
		var payway = new Array();
		payway = waytopay.split("/");
		
		var url1="Order?action=add&userId="+userid+"&product="+product+"&address="+address;	
		
		$.post(url1, null, function(data){
			if(data != "0"){
				if(payway[1] == "delivery"){
					var r = confirm("You already place an order! Do you want to go to your space?");
					if(r){
						window.location.href="myspace_index.jsp?userId="+userid;
					}
					else{
						window.location.href="cart.jsp?userId="+userid;
					}
				}
				else{
					var price = document.getElementById("total").innerHTML;
					var prices = price.split(':');
					var r = confirm("You already place an order! Do you want to pay now?");
					if(r){
						window.location.href="alipayindex.jsp?oid="+data+"&price="+prices[1];
					}
					else{
						window.location.href="myspace_index.jsp?userId="+userid;
					}	
				}
			}
		});
	}
	
</script>
<%@ include file="Head.jsp" %>
<%
	String userId = request.getParameter("userId");
	String product = request.getParameter("product");
	String[] products = product.split("/");
	DeliveryAddressLogic dal = new DeliveryAddressLogic();
	List<DeliveryAddress> addressList = dal.findAddress(Integer.parseInt(userId));
	List<Product> productList = new ArrayList<Product>();
	ProductLogic pl = new ProductLogic();
	double price;
	for(int i = 1; i<products.length; i++){
		Product temp = pl.findBySKU(products[i]);
		productList.add(temp);
	}
	
%>
<%
	out.print("<input type='hidden' id='product' value='"+product+"'>");
%>
<input type="hidden" value>
<div class="container">
<div class="grids_of_4">
	<div class="women1">
		<div class="create_btn1">
			<a href="javascript:;" onclick="addNewAddress();">Add New Address</a>
		</div>
		<br>
		<div class="clearfix"></div>
	</div>
	
	<!-- grids_of_4 -->
		<%
			if(addressList != null && addressList.size() > 0){
				for(int i =0; i< addressList.size(); i++){
					if(i%4 == 0 ){
						out.print("<div class='grids_of_4'>");
					}
					out.print("<div class='grid1_of_4' style='text-align:left; border:1px solid #ebebeb; padding:10px;'>");
					if(i == 0){
						out.print("<input type='radio' name='radio' style='float:left;' checked='checked' value='"+addressList.get(i).getDNo()+"'>");
					}
					else{
						out.print("<input type='radio' name='radio' style='float:left;' value='"+addressList.get(i).getDNo()+"'>");
					}
					out.print("<div class='content_box'>");
					out.print("<div class='price'>");
					out.print("<span class='points'>Name : "+addressList.get(i).getDName()+"</span>");
					out.print("<br>");
					out.print("<span class='points'>Address : "+addressList.get(i).getDAddress()+"</span>");
					out.print("<br>");
					out.print("<span class='points'>Phone : "+addressList.get(i).getDPhone()+"</span>");
					out.print("<br></div></div></div>");
					if(i%4 == 0 && i/4 > 1){
						out.print("<div class='clearfix'></div></div>");
					}
				}
			}
		%>
	<!-- end grids_of_4 -->	
	<div class="clearfix"></div>
</div>

<div style="border-bottom:1px solid #ebebeb; padding:5px;"></div>

<div style="padding-top: 20px;">
	<% for(int i=0; i<productList.size(); i++){ %>
	<div class="cart-sec simpleCart_shelfItem">
		<div class="cart-item cyc">
			<% out.print("<img src='images/"+productList.get(i).getPPics().get(0)+"' class='img-responsive' alt=''>"); %>
		</div>
		<div class="cart-item-info">
			<h3>
				<% out.print("<a href='Product?action=detail&SKU="+productList.get(i).getSKU()+"'>"+productList.get(i).getPName()+"</a>"); %>
				<span>SKU: <%out.print(productList.get(i).getSKU()); %></span>
			</h3>
			<ul class="qty">
				<%
					switch(productList.get(i).getPSize()){
					case 0 : out.print("<li><p>Size : S</p></li>");break;
					case 1 : out.print("<li><p>Size : M</p></li>");break;
					case 2 : out.print("<li><p>Size : L</p></li>");break;
					default: out.print("<li><p>Size : XL</p></li>");
					}
				%>
				<li><p>Color : <%out.print(productList.get(i).getPColor()); %></p></li>
				<%
					if(productList.get(i).getPDiscountPrice() != 0){
						out.print("<li><p>Price : "+productList.get(i).getPDiscountPrice()+"</p></li>");
					}
					else{
						out.print("<li><p>Price : "+productList.get(i).getPPrice()+"</p></li>");
					}
				
					CartLogic cln = new CartLogic();
					int quantity = cln.getNumber(Integer.parseInt(userId), productList.get(i).getSKU());
					out.print("<li><p>Qty : "+quantity+"</p></li>");
				%>
			</ul>
		</div>
		<div class="clearfix"></div>				
	</div>
	<%} %>
</div>

<div style="border-bottom:1px solid #ebebeb;"></div>

<div style="padding: 10px;">
	<h3>Type of Payment</h3>
	<div style="padding: 10px">
		<div style="margin: 10px">
		<input type="radio" name="payradio" checked="checked" value='delivery'> Pay on Delivery</input>
		</div>
		<div style="margin: 10px">
		<input type="radio" name="payradio" value='online' > Pay on Online</input>
		</div>
	</div>
</div>

<div style="padding: 10px;">
	<div class="total_price">
		<div class="last_price"> 
			<h4 id="total">TOTAL : <% out.print(pl.getTotalPrice(productList, Integer.parseInt(userId)) + 150); %></h4>
		</div>	
		<div class="clearfix"> </div>
	</div>
</div>

<div style="padding-bottom: 20px;float: right;">
	<div class="create_btn1">
			<a href="javascript:;" onclick="placeOrder()">Place Order</a>
	</div>
</div>

<div class="clearfix"></div>

</div>

<div class="clearfix"></div>

<%@ include file="Foot.jsp" %>
</body>
</html>