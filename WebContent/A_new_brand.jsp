<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>New Brand | Admin</title>
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
        
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>New Brand</h1>
			</div>
			<form class="form-horizontal">
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="brand">Brand</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="brand"  name="brand"/>
						</div>
					</div>
					<div class="form-actions">
						<input type="button" class="btn btn-success btn-large" value="Save Brand" onclick="addbrand()" /> <a class="btn" href="A_list_brands.jsp">Cancel</a>
					</div>					
				</fieldset>
			</form>
		  </div>
        </div>
        <!-- content -->
      </div>

      <hr>


    </div>

    <script src="js1/jquery.js"></script>
	<script src="js1/bootstrap.min.js"></script>
	<script>
		function addbrand(){
			var brand = document.getElementById("brand").value;
			if(brand == ""){
				alert("please input brand!");
			}
			else{
				var url = "Others?action=addbrand&brand="+brand;
				$.post(url, null, function(data){
					if(data != "0"){
						alert("添加成功！");
						window.location.href="A_list_brands.jsp";
					}
					else{
						alert("brand already exist!")
						document.getElementById("brand").value="";
						document.getElementById("brand").focus();
					}
				});
			}
		}
	</script>
  </body>
</html>
