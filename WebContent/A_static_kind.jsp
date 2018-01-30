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
       		List<Entity.Kind> fkinds = kl.findFKind();     	
        	List<Entity.Kind> mkinds = kl.findMKind();     
        	List<Entity.Kind> kkinds = kl.findKKind();
        %>
        
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>Kind Statics</h1>
			</div>
			
			<div style="width: 50%; margin-left:auto; margin-right:auto">
				<canvas id="canvas" height="225" width="300"></canvas>
			</div>
			
			<div>
				<%
					int femalecount=0;
					int malecount = 0;
					int kidcount = 0;
					for(int i = 0; i<fkinds.size(); i++)
					{
						femalecount += kl.countOrder(fkinds.get(i).getKId());
					}
					out.print("<span id='fkind'>Female : &nbsp;&nbsp;</span><span id='fkindcount'>"+femalecount+" </span><a href='A_static_kindf.jsp'>look detail</a><br>");
					for(int i = 0; i<mkinds.size(); i++)
					{
						malecount += kl.countOrder(mkinds.get(i).getKId());
					}
					out.print("<span id='mkind'>Male : &nbsp;&nbsp;</span><span id='mkindcount'>"+malecount+" </span><a href='A_static_kindm.jsp'>look detail</a><br>");
					for(int i = 0; i<kkinds.size(); i++)
					{
						kidcount += kl.countOrder(kkinds.get(i).getKId());
					}
					out.print("<span id='kkind'>Kid : &nbsp;&nbsp;</span><span id='kkindcount'>"+kidcount+" </span><a href='A_static_kindk.jsp'>look detail</a><br>");
					
				%>
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
	var pieData = [
					{
						value: parseInt(document.getElementById("fkindcount").innerHTML),
						color:"#51A351",
						highlight: "#6BB56B",
						label: "Female"
					},
					{
						value: parseInt(document.getElementById("mkindcount").innerHTML),
						color: "#AFABAB",
						highlight: "#C1BFBF",
						label: "Male"
					},
					{
						value: parseInt(document.getElementById("kkindcount").innerHTML),
						color: "#AFABDD",
						highlight: "#C1BFbF",
						label: "Kid"
					},

				];

	window.onload = function(){
		var ctx = document.getElementById("canvas").getContext("2d");
		window.myPie = new Chart(ctx).Pie(pieData);
};
		
	</script>
  </body>
</html>
