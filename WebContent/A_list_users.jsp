<%@page import="BusinessLogic.UserLogic"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Users | Admin</title>
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
              <li class="active"><a href="A_list_users.jsp">Users</a></li>
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
       
       <!-- content -->
       <%
       		UserLogic aul = new UserLogic();
       		List<Entity.User> users = aul.findAll();
       		int activecount = 0;
       		int inactivecount = 0;
       %>
       
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>Users </h1>
			</div>
			
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Gender</th>
						<th>Phone</th>
						<th>Email</th>
						<th>Orders</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
				<%
					for(int i = 0; i<users.size(); i++)
					{
				%>
					<tr class="list-users">
						<td><%out.print(users.get(i).getUserId()); %></td>
						<td><%out.print(users.get(i).getUserName()); %></td>
						<%
							if(users.get(i).getGender() == 0){
								out.print("<td>Male</td>");
							}
							else{
								out.print("<td>Female</td>");
							}
						%>
						<td><%out.print(users.get(i).getPhone()); %></td>
						<td><%out.print(users.get(i).getEmail()); %></td>
						<%
							int count = aul.getProducts(users.get(i).getUserId());
							out.print("<td>"+count+"</td>");
							if(count > 0)
							{
								activecount += 1;
								out.print("<td><span class='label label-success'>Active</span></td>");
							}
							else{
								inactivecount += 1;
								out.print("<td><span class='label label-important'>Inactive</span></td>");
							}
						%>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			<div class="pagination">
				<ul>
					<li><a href="#">Prev</a></li>
					<li class="active">
						<a href="#">1</a>
					</li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
					<li><a href="#">Next</a></li>
				</ul>
			</div>
			
			<div style="width: 50%; margin-left:auto; margin-right:auto">
				<canvas id="canvas" height="225" width="300"></canvas>
			</div>
			
			<div>
				Active User:<span id="activecount"> <%=activecount %>&nbsp; &nbsp; &nbsp;</span>
				InActive User:<span id="inactivecount"> <%=inactivecount %>&nbsp; &nbsp; &nbsp;</span>
			</div>
		
		  </div>
        </div>
        
        <!-- end content -->
      </div>

      <hr>

    </div>

    <script src="js1/jquery.js"></script>
	<script src="js1/bootstrap.min.js"></script>
	
	<script>
		var pieData = [
					{
						value: parseInt(document.getElementById("activecount").innerHTML),
						color:"#51A351",
						highlight: "#6BB56B",
						label: "Active"
					},
					{
						value: parseInt(document.getElementById("inactivecount").innerHTML),
						color: "#AFABAB",
						highlight: "#C1BFBF",
						label: "INactive"
					},

				];

		window.onload = function(){
				var ctx = document.getElementById("canvas").getContext("2d");
				window.myPie = new Chart(ctx).Pie(pieData);
		};
	</script>
	
  </body>
</html>
