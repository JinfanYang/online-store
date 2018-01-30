<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="BusinessLogic.ProductLogic" %>
<%@ page import="Entity.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="js/simpleCart.min.js"> </script>
<title>Catalog</title>
</head>
<body>
<%@include file="Head.jsp" %>
<!-- content -->
<div class="container">
<div class="women_main">
	<!-- start sidebar -->
	<%@include file="Menu.jsp" %>
	
	<!-- start content -->
	<%
		List<Product> products = (List<Product>)request.getSession().getAttribute("PRODUCTS");
		String kind = (String)request.getSession().getAttribute("KIND");

	%>
	<div id="content">
	<div class="col-md-9 w_content">
		<div class="women">
			<%
				if(products != null){
					out.print("<a href='#'><h4>"+kind+" - <span>"+products.size()+" items</span> </h4></a>");
				}
				else{
					out.print("<a href='#'><h4>"+kind+" - <span>0 items</span> </h4></a>");
				}
			%>
		     <div class="clearfix"></div>	
		</div>
		<!-- grids_of_4 -->
		<%
			if(products != null && products.size()>0){
				for(int i =0; i<products.size(); i++){
					if(i%4 == 0 ){
						out.print("<div class='grids_of_4'>");
					}
					out.print("<div class='grid1_of_4'>");
					out.print("<div class='content_box'><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahrefimg'>");
					out.print("<img src='images/"+products.get(i).getPPics().get(0)+"' class='img-responsive' alt='' id='imgsrc'/></a>");
					out.print("<h4><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahref'>"+products.get(i).getPName()+"</a></h4>");
					out.print("<div class='grid_1 simpleCart_shelfItem'>");
					out.print("<div class='item_add'><span class='item_price'><h6 id='price'>ONLY "+products.get(i).getPPrice()+"</h6></span></div>");
					out.print("</div></div></div>");
					if(i%4 == 0 && i/4 > 1){
						out.print("<div class='clearfix'></div></div>");
					}
				}
			}
		%>
		<!-- end grids_of_4 -->		
	</div>
	</div>
	<div class="clearfix"></div>
	<!-- end content -->
</div>
</div>
<div class="clearfix"> </div>
<%@include file="Foot.jsp" %>
</body>
</html>