<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="BusinessLogic.ProductLogic" %>
<%@ page import="Entity.Product" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>General Statistics | Admin</title>
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
        	ProductLogic pl = new ProductLogic();
        	String pid = request.getParameter("pid");
        	List<Integer> sizes = pl.findSize(pid);
        %>
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>General Statics</h1>
			</div>
			<div style="width: 50%; margin-left:auto; margin-right:auto">
				<canvas id="canvas" height="225" width="300"></canvas>
			</div>
			<div>
				<%
					for(int i = 0; i<sizes.size(); i++)
					{
						if(sizes.get(i) == 0){
							out.print("<span id='size"+String.valueOf(i)+"'> S : </span><span id='sizecount"+String.valueOf(i)+"'>"+ pl.countsize(pid, 0)+" </span><br>");
						}
						else if(sizes.get(i) == 1){
							out.print("<span id='size"+String.valueOf(i)+"'> M : </span><span id='sizecount"+String.valueOf(i)+"'>"+ pl.countsize(pid, 1)+" </span><br>");
						}
						else if(sizes.get(i) == 2){
							out.print("<span id='size"+String.valueOf(i)+"'> L : </span><span id='sizecount"+String.valueOf(i)+"'>"+ pl.countsize(pid, 2)+" </span><br>");
						}
						else{
							out.print("<span id='size"+String.valueOf(i)+"'> XL : </span><span id='sizecount"+String.valueOf(i)+"'>"+ pl.countsize(pid, 3)+" </span><br>");
						}
						
					}
					out.print("<input type='hidden' value='"+ sizes.size()+"' id='count'>");
					out.print("<a href='A_static_general.jsp'>Back</a>");
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
		var count = document.getElementById("count").value;
		var pieData= new Array();
		
		for(var i = 0; i< parseInt(count); i++){
			pieData.push({
		 		value: parseInt(document.getElementById("sizecount"+i).innerHTML),
		 		color: "#51A351",
		 		highlight: "#6BB56B",
		 		label: document.getElementById("size"+i).innerHTML
		 	});
		}
		
		window.onload = function(){
				var ctx = document.getElementById("canvas").getContext("2d");
				window.myPie = new Chart(ctx).Pie(pieData);
		};
	</script>
	
  </body>
</html>
