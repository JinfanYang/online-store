<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>My Profile | Admin</title>
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
		function checkinput(){
			var rpassword1=document.getElementById("newpassword").value;
			var rpassword2=document.getElementById("rnewpassword").value;
			if(rpassword1!= rpassword2){
				document.getElementById("message2").innerHTML="two passwords different!";
				document.getElementById("rnewpassword").focus;
			}
			else{
				document.getElementById("message2").innerHTML=" ";
			}
		}
		
		function checkoldpassword(){
			var oldpassword = document.getElementById("oldpassword").value;
			var url="Admin?action=checkpassword&oldpassword="+oldpassword;
			$.post(url,null,function(data){
				if(data =="0"){
					document.getElementById("message1").innerHTML="wrong old password";
					document.getElementById("rusername").focus;
				}
				else{
					document.getElementById("message1").innerHTML=" ";
				}
			});
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
              <li><a href="A_list_products.jsp">Products</a></li>
              <li><a href="A_list_orders.jsp">Orders</a></li>
              <li class="nav-header"><i class="icon-signal"></i> Statistics</li>
              <li><a href="A_static_general.jsp">General</a></li>
              <li><a href="A_static_kind.jsp">Kind</a></li>
              <li><a href="A_static_brand.jsp">Brand</a></li>
              <li class="nav-header"><i class="icon-user"></i> Profile</li>
              <li class="active"><a href="A_my_profile.jsp">My profile</a></li>
			  <li><a href="Admin?action=logout">Logout</a></li> 
            </ul>
          </div>
        </div>
        <!-- end side menu -->
        
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>My profile <small>Change Password</small></h1>
			</div>
			<form class="form-horizontal" action="Admin?action=changepassword" method="post">
				<fieldset>
					<div class="control-group">
						<label class="control-label" for="name">Admin</label>
						<div class="controls">
							<%out.print("<input type='text' class='input-xlarge' id='name' name='name' value='"+request.getSession().getAttribute("ADMINNAME")+"' readonly>"); %>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="oldpassword">Old password</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="oldpassword" name="oldpassword" onblur="checkoldpassword()"/>
							<div id="message1" style="color:#F00"></div>
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="newpassword">New password</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="newpassword" name="newpassword" />
						</div>
					</div>
					<div class="control-group">
						<label class="control-label" for="rnewpassword">Retype New password</label>
						<div class="controls">
							<input type="password" class="input-xlarge" id="rnewpassword" name="rnewpassword" onblur="checkinput()"/>
							<div id="message2" style="color:#F00"></div>
						</div>
					</div>
					<div class="form-actions">
						<input type="submit" class="btn btn-success btn-large" value="Save Changes" />
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
