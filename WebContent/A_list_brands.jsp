<%@page import="BusinessLogic.BrandLogic"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Brands | Admin</title>
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
	
    <div class="container-fluid">
      <div class="row-fluid">
      
      <!-- side menu -->
        <div class="span3">
          <div class="well sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header"><i class="icon-wrench"></i> Administration</li>
              <li><a href="A_list_users.jsp">Users</a></li>
              <li class="active"><a href="A_list_brands.jsp">Brands</a></li>
              <li><a href="A_list_kinds.jsp">Kinds</a></li>
              <li><a href="A_list_products.jsp">Products</a></li>
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
        
        <%
        	BrandLogic bl = new BrandLogic();
        	List<Entity.Brand> brands = bl.findAllBrand();
        %>
        
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>Brands </h1>
			</div>
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>ID</th>
						<th>Brand</th>
						<th>Products</th>
						<th>Orders</th>
					</tr>
				</thead>
				<tbody>
				<%
					for(int i = 0; i<brands.size(); i++){
				%>
					<tr class="list-roles">
						<td><%out.print(brands.get(i).getBId()); %></td>
						<td><%out.print(brands.get(i).getBName()); %></td>
						<%
							int count1 = bl.countProduct(brands.get(i).getBId());
							int count2 = bl.countOrder(brands.get(i).getBId());
							out.print("<td>"+ count1 +"</td>");
							out.print("<td>"+ count2 +"</td>");
						%>
					</tr>
				<%
					}
				%>				
				</tbody>
			</table>
			<a href="A_new_brand.jsp" class="btn btn-success">New Brand</a>
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
