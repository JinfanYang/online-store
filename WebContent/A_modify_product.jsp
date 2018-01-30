<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="BusinessLogic.KindLogic" %>
<%@ page import="BusinessLogic.BrandLogic" %>
<%@ page import="Entity.Kind" %>
<%@ page import="Entity.Brand" %>
<%@ page import="java.util.List" %>
<%@ page import="BusinessLogic.ProductLogic" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>New Product | Admin</title>
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
        <%
        	String sku = request.getParameter("sku");
        	ProductLogic pl = new ProductLogic();
        	List<String> productinfo = pl.findoneBySku(sku);
        %>
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>New Product</h1>
			</div>
			<form class="form-horizontal" action="Product?action=save" method="post" >
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="pid">ProductId</label>
						<div class="controls">
							<%out.print("<input type='text' class='input-xlarge' id='pid' name='pid' value='"+productinfo.get(1)+"' readonly/>"); %>
							<%out.print("<input type='hidden' class='input-xlarge' id='sku' name='sku' value='"+productinfo.get(0)+"' />"); %>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="name">Name</label>
						<div class="controls">
						 <%out.print("<input type='text' class='input-xlarge' id='name' name='name' value='"+productinfo.get(2)+"' />"); %>
							
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="gender">Gender</label>
						<div class="controls">								
							<%out.print("<input type='text' class='input-xlarge' id='gender' name='gender' value='"+productinfo.get(3)+"' readonly/>"); %>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="kind">Kind</label>
						<div class="controls">
							<%out.print("<input type='text' class='input-xlarge' id='kind' name='kind' value='"+productinfo.get(4)+"' readonly/>"); %>
						</div>
					</div>	
					<div class="control-group">
						<label class="control-label" for="brand">Brand</label>
						<div class="controls">
							<%out.print("<input type='text' class='input-xlarge' id='brand' name='brand' value='"+productinfo.get(5)+"' readonly/>"); %>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="size">Size</label>
						<div class="controls">
							<%out.print("<input type='text' class='input-xlarge' id='size' name='size' value='"+productinfo.get(8)+"' readonly />"); %>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="color">Color</label>
						<div class="controls">
							<%out.print("<input type='text' class='input-xlarge' id='color' name='color' value='"+productinfo.get(9)+"' readonly/>"); %>
						</div>
					</div>		
					<div class="control-group">
						<label class="control-label" for="price">Price</label>
						<div class="controls">
							<%out.print("<input type='text' class='input-xlarge' id='price' name='price' value='"+productinfo.get(6)+"' />"); %>
						</div>
					</div>	
					<div class="control-group">
						<label class="control-label" for="discountprice">DiscountPrice</label>
						<div class="controls">
							<%out.print("<input type='text' class='input-xlarge' id='discountprice' name='discountprice' value='"+productinfo.get(7)+"' />"); %>
						</div>
					</div>	
					<div class="control-group">
						<label class="control-label" for="storage">Storage</label>
						<div class="controls">
							<%out.print("<input type='text' class='input-xlarge' id='storage' name='storage' value='"+productinfo.get(10)+"' />"); %>
						</div>
					</div>
					<div class="form-actions">
						<input type="submit" class="btn btn-success btn-large" value="Save Product" /> <a class="btn" href="A_list_products.jsp">Cancel</a>
					</div>					
				</fieldset>
			</form>
		  </div>
        </div>
        <!-- end content -->
      </div>

      <hr>


    </div>

    <script src="js1/jquery.js"></script>
	<script src="js1/bootstrap.min.js"></script>
  </body>
</html>
