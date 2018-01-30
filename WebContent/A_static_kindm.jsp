<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="BusinessLogic.KindLogic" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Kind Statistics | Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">

    <link href="css1/bootstrap.css" rel="stylesheet">
	<link href="css1/site.css" rel="stylesheet">
    <link href="css1/bootstrap-responsive.css" rel="stylesheet">
    <script src="js1/Chart.js"></script>
    <!--[if lt IE 9]>
      <script src="js/html5.js"></script>
    <![endif]-->
	<!--[if lte IE 8]><script src="js/excanvas.min.js"></script><![endif]-->
    <style type="text/css">
    html, body {
        height: 100%;
    }
    </style>
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
        	KindLogic kl = new KindLogic();    	
        	List<Entity.Kind> mkinds = kl.findMKind();     
        %>
        
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>Kind Statics</h1>
			</div>
			
			<div id="mchart">
				<div style="width: 50%; margin-left:auto; margin-right:auto">
					<canvas id="mcanvas" height="225" width="300"></canvas>
				</div>
				<div>
				<%
					for(int i = 0; i<mkinds.size(); i++)
					{
						out.print("<span id='mkind"+ String.valueOf(i)+"'>"+mkinds.get(i).getKCatalog3()+" : </span><span id='mkindcount"+String.valueOf(i)+"'>"+kl.countOrder(mkinds.get(i).getKId())+" </span><br>");
					}
					out.print("<input type='hidden' value='"+ mkinds.size()+"' id='mkcount'>");
					out.print("<a href='A_static_kind.jsp'>Back</a>");
				%>
				</div>
			</div>
			
		  </div>
        </div>
        <!-- end content -->
      </div>
      <hr>

    </div>

    <script src="js1/jquery.js"></script>
	<script src="js1/jquery.flot.js"></script>
	<script src="js1/jquery.flot.resize.js"></script>	
	<script src="js1/bootstrap.min.js"></script>
	<script>
	var mkcount = document.getElementById("mkcount").value;
	var pieDatam= new Array();
	
	for(var i = 0; i< parseInt(mkcount); i++){
		if(parseInt(document.getElementById("mkindcount"+i).innerHTML) > 0){
			pieDatam.push({
		 		value: parseInt(document.getElementById("mkindcount"+i).innerHTML),
		 		color: "#51A351",
		 		highlight: "#6BB56B",
		 		label: document.getElementById("mkind"+i).innerHTML
		 	});
		}
	}
	

	window.onload = function(){
		var ctxm = document.getElementById("mcanvas").getContext("2d");
		window.myPie = new Chart(ctxm).Pie(pieDatam);
	};
		
	</script>
  </body>
</html>
