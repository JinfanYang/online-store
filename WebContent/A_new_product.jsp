<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="BusinessLogic.KindLogic" %>
<%@ page import="BusinessLogic.BrandLogic" %>
<%@ page import="Entity.Kind" %>
<%@ page import="Entity.Brand" %>
<%@ page import="java.util.List" %>
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
        	KindLogic kl = new KindLogic();
        	BrandLogic bl = new BrandLogic();
        	List<Brand> brands = bl.findAllBrand();
        	List<Kind> mk = kl.findMKind();
        %>
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>New Product</h1>
			</div>
			<form class="form-horizontal" action="Product?action=add" method="post">
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="pid">ProductId</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="pid" name="pid" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="name">Name</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="name" name="name"/>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="gender">Gender</label>
						<div class="controls">
							<select id="gender" name="gender" onchange="getKind()">
								<option value="0"  selected>Male</option>
								<option value="1">Female</option>
								<option value="2">Kid</option>
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="kind">Kind</label>
						<div class="controls">
							<select id="kind" name="kind">
								<%
									for(int i = 0; i<mk.size(); i++){
										out.print("<option value='"+mk.get(i).getKId()+"'>"+mk.get(i).getKCatalog3()+"</option>");
									}
								%>
							</select>
						</div>
					</div>	
					<div class="control-group">
						<label class="control-label" for="brand">Brand</label>
						<div class="controls">
							<select id="brand" name="brand">
							<%
								for(int i = 0; i<brands.size(); i++){
									out.print("<option value='"+brands.get(i).getBId()+"'>"+brands.get(i).getBName()+"</option>");
								}
							%>
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="size">Size</label>
						<div class="controls">
							<select id="size" name="size">
								<option value="0" selected>S</option>
								<option value="1">M</option>
								<option value="2">L</option>
								<option value="3">XL</option>
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="color">Color</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="color" name="color" />
						</div>
					</div>		
					<div class="control-group">
						<label class="control-label" for="price">Price</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="price" name="price"/>
						</div>
					</div>	
					<div class="control-group">
						<label class="control-label" for="discountprice">DiscountPrice</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="discountprice" name="discountprice"/>
						</div>
					</div>	
					<div class="control-group">
						<label class="control-label" for="storage">Storage</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="storage" name="storage" />
						</div>
					</div>
					<div>
						<label class="control-label" for="pic">Picture</label>
						<input type="file" name="pic" id="pic">
					</div>
					<div class="form-actions">
						<input type="submit" class="btn btn-success btn-large" value="Add Product" /> <a class="btn" href="A_list_products.jsp">Cancel</a>
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
	<script type="text/javascript">
		function getKind(){
			var gender = document.getElementById("gender").value;
			if(gender == "0"){
				var url="Others?action=getkind&gender=0";
				$.post(url, null, function(data){
					$("#kind").html(data);
				});
			}
			else if(gender == "1"){
				var url="Others?action=getkind&gender=1";
				$.post(url, null, function(data){
					$("#kind").html(data);
				});
			}
			else{
				var url="Others?action=getkind&gender=2";
				$.post(url, null, function(data){
					$("#kind").html(data);
				});
			}
		}
	</script>
  </body>
</html>
