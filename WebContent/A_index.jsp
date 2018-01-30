<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="BusinessLogic.*" %>
<%@ page import="Entity.*" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Admin </title>
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
              <li><a href="A_list_brands.jsp">Brands</a></li>
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
       		UserLogic ul = new UserLogic();
       		ProductLogic pl = new ProductLogic();
       		OrderLogic ol = new OrderLogic();
       		int usercount = ul.count();
       		int productcount = pl.count();
       		int ordercount = ol.count();
       %>
       
       <!-- content -->
        <div class="span9">
          <div class="well hero-unit">
            <h1>Welcome, Admin</h1>
            <div style="height: 50px;"></div>
            <p><a class="btn btn-success btn-large" href="A_list_products.jsp">Manage Products &raquo;</a></p>
          </div>
          <div class="row-fluid">
            <div class="span3">
              <h3>Total Users</h3>
              <p><a href="list_users.jsp" class="badge badge-inverse"><%out.print(usercount); %></a></p>
            </div>
            <div class="span3">
              <h3>Total Product</h3>
              <p><a href="list_products.jsp" class="badge badge-inverse"><%out.print(productcount); %></a></p>
            </div>
            <div class="span3">
              <h3>Total Order</h3>
			  <p><a href="list_orders.jsp" class="badge badge-inverse"><%out.print(ordercount); %></a></p>
            </div>
          </div>
		  <br />
        </div>
      <!-- end content -->
      </div>
      <hr>
    </div>

    <script src="js1/jquery.js"></script>
	<script src="js1/bootstrap.min.js"></script>
  </body>
</html>
