<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>New Kind | Admin</title>
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
              <li class="active"><a href="A_list_kinds.jsp">Kinds</a></li>
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
				<h1>New Kind</h1>
			</div>
			<form class="form-horizontal">
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="gender">Gender</label>
						<div class="controls">
							<select id="gender">
								<option value="0" selected>Male</option>
								<option value="1">Female</option>
								<option value="2">Kid</option>
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="torb">Top/Bottom</label>
						<div class="controls">
							<select id="torb">
								<option value="0" selected>Top</option>
								<option value="1">Bottom</option>
							</select>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="kind">Kind</label>
						<div class="controls">
							<input type="text" class="input-xlarge" id="kind" />
						</div>
					</div>
					<div class="form-actions">
						<input type="button" class="btn btn-success btn-large" value="Save Kind" onclick="addkind()"/> <a class="btn" href="A_list_kinds.jsp">Cancel</a>
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
		function addkind(){
			var gender = document.getElementById("gender").value;
			var torb = document.getElementById("torb").value;
			var kind = document.getElementById("kind").value;
			if(kind == ""){
				alert("Please input kind !");
			}
			else{
				var url = "Others?action=addkind&gender="+gender+"&torb="+torb+"&kind="+kind;
				$.post(url, null, function(data){
					if(data != "0"){
						alert("添加成功");
						window.location.href="A_list_kinds.jsp";
					}
					else{
						alert("Kind already exist !");
						document.getElementById("kind").value="";
						document.getElementById("kind").focus();
					}
				});
			}
		}
		
	</script>
  </body>
</html>
