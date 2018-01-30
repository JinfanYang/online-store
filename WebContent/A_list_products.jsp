<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="BusinessLogic.ProductLogic" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Products | Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">

    <link href="css1/bootstrap.css" rel="stylesheet">
	<link href="css1/site.css" rel="stylesheet">
    <link href="css1/bootstrap-responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="js/html5.js"></script>
    <![endif]-->
  </head>
  <body>
  	<%@include file="A_HeadMenu.jsp" %>

	<script>
		function search(){
			var pid = document.getElementById("pidtextbox").value;
			if(pid == ""){
				alert("Please input product Id");
			}
			else{
				var url = "Product?action=findoneByPid&pid="+pid;
				$.post(url, null, function(data){
					if(data != ""){
						$("#tablebody").html(data)
					}
				})
			}
		}
		
		function allProduct(){
			var url = "Product?action=allinfo";
			$.post(url, null, function(data){
				if(data != ""){
					$("#tablebody").html(data)
				}
			})
		}
		
		
	</script>
	
    <div class="container-fluid">
      <div class="row-fluid">
      
      <!-- side menu -->
        <div class="span3">
          <div class="well sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header"><i class="icon-wrench"></i> Administration</li>
              <li><a href="A_list_users.jsp">Users</a></li>
              <li><a href="A_list_brands.jsp">Brands</a></li>
              <li><a href="A_list_kinds.jsp">Kinds</a></li>
              <li class="active"><a href="A_list_products.jsp">Products</a></li>
              <li><a href="A_list_orders.jsp">Orders</a></li>
              <li class="nav-header"><i class="icon-signal"></i> Statistics</li>
              <li><a href="A_static_general.jsp">General</a></li>
              <li><a href="A_static_kind.jsp">Kind</a></li>
              <li><a href="A_static_brand.jsp">Brand</a></li>
              <li class="nav-header"><i class="icon-user"></i> Profile</li>
              <li><a href="A_my_profile.jsp">My profile</a></li>
			  <li><a href="Admin?action=logout">Logout</a></li> 
            </ul>
          </div>
        </div>
        <!-- end side menu -->
        
        <!-- content -->
        <%
        	BusinessLogic.ProductLogic bl = new BusinessLogic.ProductLogic();
        	List<ArrayList<String>> products = bl.findAllProducts();
        %>
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>Products </h1>
			</div>
			<div>
				<input type="text" id="pidtextbox">
				<input type="button" id="searchButton" value="Search" onclick="search()">
				<input type="button" id="allButton" value="All" onclick="allProduct()">
			</div>
			<table class="table table-striped table-bordered table-condensed " style="text-align:center;">
				<thead>
					<tr>
						<th style="text-align:center;vertical-align:middle;">Picture</th>
						<th style="text-align:center;vertical-align:middle;">SKU</th>
						<th style="text-align:center;vertical-align:middle;">ProductId</th>
						<th style="text-align:center;vertical-align:middle;">Name</th>
						<th style="text-align:center;vertical-align:middle;">Gender</th>
						<th style="text-align:center;vertical-align:middle;">Kind</th>
						<th style="text-align:center;vertical-align:middle;">Brand</th>
						<th style="text-align:center;vertical-align:middle;">Price</th>
						<th style="text-align:center;vertical-align:middle;">Discount Price</th>
						<th style="text-align:center;vertical-align:middle;">Size</th>
						<th style="text-align:center;vertical-align:middle;">Color</th>
						<th style="text-align:center;vertical-align:middle;">Storage</th>
						<th style="text-align:center;vertical-align:middle;">InDate</th>
						<th></th>
						
					</tr>
				</thead>
				<tbody id="tablebody">
				<%
				for(int i=0; i<products.size(); i++){
					out.print("<tr class='list-roles' >");
					out.print("<td><img src='images/"+products.get(i).get(12)+"' width=50px></td>");//image
					for(int j = 0; j<products.get(i).size()-1; j++){
						out.print("<td style='text-align:center;vertical-align:middle;'>"+products.get(i).get(j)+"</td>");
					}
					out.print("<td style='vertical-align:middle;'>");
					out.print("<div class='btn-group'>");
					out.print("<a class='btn btn-mini dropdown-toggle' data-toggle='dropdown' href='#'>Actions<span class='caret'></span></a>");
					out.print("<ul class='dropdown-menu pull-right'>");
					out.print("<li><a href='A_modify_product.jsp?sku="+products.get(i).get(0)+"'><i class='icon-pencil'></i> Edit</a></li>");
					out.print("</ul></div></td></tr>");
				}
				%>
				</tbody>
			</table>
			<a href="A_new_product.jsp" class="btn btn-success">New Product</a>
		  </div>
        </div>
        <!-- content -->
      </div>

      <hr>
      
    </div>

    <script src="js1/jquery.js"></script>
	<script src="js1/bootstrap.min.js"></script>
	<script>
	$(document).ready(function() {
		$('.dropdown-menu li a').hover(
		function() {
			$(this).children('i').addClass('icon-white');
		},
		function() {
			$(this).children('i').removeClass('icon-white');
		});
	});
	</script>
  </body>
</html>
