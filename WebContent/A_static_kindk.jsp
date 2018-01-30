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
        	List<Entity.Kind> kkinds = kl.findKKind();
        %>
        
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>Kind Statics</h1>
			</div>
	
			<div id="kchart">
				<div style="width: 50%; margin-left:auto; margin-right:auto">
					<canvas id="kcanvas" height="225" width="300"></canvas>
				</div>
				<div>
				<%
					for(int i = 0; i<kkinds.size(); i++)
					{
						out.print("<span id='kkind"+ String.valueOf(i)+"'>"+kkinds.get(i).getKCatalog3()+" : </span><span id='kkindcount"+String.valueOf(i)+"'>"+kl.countOrder(kkinds.get(i).getKId())+" </span><br>");
					}
					out.print("<input type='hidden' value='"+ kkinds.size()+"' id='kkcount'>");
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
	var kkcount = document.getElementById("kkcount").value;
	var pieDatak= new Array();
	
	for(var i = 0; i< parseInt(kkcount); i++){
		if(parseInt(document.getElementById("kkindcount"+i).innerHTML) > 0){
			pieDatak.push({
		 		value: parseInt(document.getElementById("kkindcount"+i).innerHTML),
		 		color: "#51A351",
		 		highlight: "#6BB56B",
		 		label: document.getElementById("kkind"+i).innerHTML
		 	});
		}
	}

	window.onload = function(){
		var ctxk = document.getElementById("kcanvas").getContext("2d");
		window.myPie = new Chart(ctxk).Pie(pieDatak);
	};
	</script>
  </body>
</html>
