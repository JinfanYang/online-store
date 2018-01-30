<%@page import="Entity.Product"%>
<%@page import="BusinessLogic.ProductLogic"%>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@include file="Reference.jsp"%>
	<script src="js/simpleCart.min.js"> </script>
	<title>Home</title>	
</head>
<body>
<%@include file="Head.jsp" %>
<div class="arriv">
	<div class="container">
		<div class="arriv-top">
			<div class="col-md-6 arriv-left">
				<img src="images/1.jpg" class="img-responsive" alt="">
				<div class="arriv-info">
					<h3>New ARRIVALS</h3>
					<div class="crt-btn">
						<a href="Product?action=new">TAKE A LOOK</a>
					</div>
				</div>
			</div>
			<div class="col-md-6 arriv-right">
				<img src="images/2.jpg" class="img-responsive" alt="">
				<div class="arriv-info">
					<h3>TUXEDO</h3>
					<div class="crt-btn">
						<a href="Product?action=catalog&kind=tuxedo">SHOP NOW</a>
					</div>
				</div>
			</div>
			<div class="clearfix"> </div>
		</div>
		<div class="arriv-bottm">
			<div class="col-md-8 arriv-left1">
				<img src="images/3.jpg" class="img-responsive" alt="">
				<div class="arriv-info1">
					<h3>SWEATER</h3>
					<div class="crt-btn">
						<a href="Product?action=catalog&kind=sweater">SHOP NOW</a>
					</div>
				</div>
			</div>
			<div class="col-md-4 arriv-right1">
				<img src="images/4.jpg" class="img-responsive" alt="">
				<div class="arriv-info2">
					<a href="Product?action=catalog&kind=pants"><h3>Pants<i class="ars"></i></h3></a>
				</div>
			</div>
			<div class="clearfix"> </div>
		</div>
		<div class="arriv-las">
			<div class="col-md-4 arriv-left2">
				<img src="images/5.jpg" class="img-responsive" alt="">
				<div class="arriv-info2">
					<a href="Product?action=catalog&kind=jacket"><h3>Jacket<i class="ars"></i></h3></a>
				</div>
			</div>
			<div class="col-md-4 arriv-middle">
				<img src="images/6.jpg" class="img-responsive" alt="">
				<div class="arriv-info3">
					<h3>FRESH LOOK T-SHIRT</h3>
					<div class="crt-btn">
						<a href="Product?action=catalog&kind=T-shirt">SHOP NOW</a>
					</div>
				</div>
			</div>
			<div class="col-md-4 arriv-right2">
				<img src="images/7.jpg" class="img-responsive" alt="">
				<div class="arriv-info2">
					<a href="Product?action=catalog&kind=coat"><h3>Coat<i class="ars"></i></h3></a>
				</div>
			</div>
			<div class="clearfix"> </div>
		</div>
	</div>
</div>
<div class="special">
	<div class="container">
		<h3><a href="catalog.jsp&catalog=specials">Special Offers</a></h3>
		<div class="specia-top">
			<ul class="grid_2">
			<%
				ProductLogic svc = new ProductLogic();
				List<Product> specials = svc.findSpecial();
				for(int i=0; i<4; i++){
					out.print("<li>");
					out.print("<a href='Product?action=detail&SKU="+specials.get(i).getSKU()+"'><img src='images/"+specials.get(i).getPPics().get(0)+"' class='img-responsive' alt=''></a>");
					out.print("<div class='special-info grid_1 simpleCart_shelfItem'>");
					out.print("<h5>"+specials.get(i).getPName()+"</h5>");
					out.print("<div class='item_add'><span class='item_price'><h6>ONLY $"+specials.get(i).getPDiscountPrice()+"</h6></span></div>");
					out.print("</div>");
					out.print("</li>");
				}
			%>
		<div class="clearfix"> </div>
	</ul>
		</div>
	</div>
</div>
<%@include file="Foot.jsp" %>
</body>
</html>