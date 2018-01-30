<%@page import="BusinessLogic.KindLogic"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Kinds | Admin</title>
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
        
        <%
        	KindLogic kl = new KindLogic();
        	List<Entity.Kind> ftkinds = kl.findFKind1();
        	List<Entity.Kind> fbkinds = kl.findFKind2();
        	List<Entity.Kind> mtkinds = kl.findMKind1();
        	List<Entity.Kind> mbkinds = kl.findMKind2();
        	List<Entity.Kind> ktkinds = kl.findKKind1();
        	List<Entity.Kind> kbkinds = kl.findKKind2();
        %>
        <!-- content -->
        <div class="span9">
		  <div class="row-fluid">
			<div class="page-header">
				<h1>Kinds</h1>
			</div>
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>ID</th>
						<th>Gender</th>
						<th>Top/Bottom</th>
						<th>Kind</th>
						<th>Products</th>
						<th>Orders</th>
					</tr>
				</thead>
				<tbody>
				
				<%
					for(int i = 0; i<ftkinds.size(); i++){
						out.print("<tr class='list-roles'>");
						out.print("<td>"+ftkinds.get(i).getKId()+"</td>");
						out.print("<td>Female</td>");
						out.print("<td>Top</td>");
						out.print("<td>"+ftkinds.get(i).getKCatalog3()+"</td>");
						int count1 = kl.countProduct(ftkinds.get(i).getKId());
						int count2 = kl.countOrder(ftkinds.get(i).getKId());
						out.print("<td>"+count1+"</td>");
						out.print("<td>"+count2+"</td>");
						out.print("</tr>");		
					}
					
					for(int i = 0; i<fbkinds.size(); i++){
						out.print("<tr class='list-roles'>");
						out.print("<td>"+fbkinds.get(i).getKId()+"</td>");
						out.print("<td>Female</td>");
						out.print("<td>Bottom</td>");
						out.print("<td>"+fbkinds.get(i).getKCatalog3()+"</td>");
						int count1 = kl.countProduct(fbkinds.get(i).getKId());
						int count2 = kl.countOrder(fbkinds.get(i).getKId());
						out.print("<td>"+count1+"</td>");
						out.print("<td>"+count2+"</td>");
						out.print("</tr>");		
					}
				
					for(int i = 0; i<mtkinds.size(); i++){
						out.print("<tr class='list-roles'>");
						out.print("<td>"+mtkinds.get(i).getKId()+"</td>");
						out.print("<td>Male</td>");
						out.print("<td>Top</td>");
					   	out.print("<td>"+mtkinds.get(i).getKCatalog3()+"</td>");
						int count1 = kl.countProduct(mtkinds.get(i).getKId());
						int count2 = kl.countOrder(mtkinds.get(i).getKId());
						out.print("<td>"+count1+"</td>");
						out.print("<td>"+count2+"</td>");
						out.print("</tr>");		
					}
				
					for(int i = 0; i<mbkinds.size(); i++){
						out.print("<tr class='list-roles'>");
						out.print("<td>"+mbkinds.get(i).getKId()+"</td>");
						out.print("<td>Male</td>");
						out.print("<td>Bottom</td>");
						out.print("<td>"+mbkinds.get(i).getKCatalog3()+"</td>");
						int count1 = kl.countProduct(mbkinds.get(i).getKId());
						int count2 = kl.countOrder(mbkinds.get(i).getKId());
						out.print("<td>"+count1+"</td>");
						out.print("<td>"+count2+"</td>");
						out.print("</tr>");		
					}
				
					for(int i = 0; i<ktkinds.size(); i++){
						out.print("<tr class='list-roles'>");
						out.print("<td>"+ktkinds.get(i).getKId()+"</td>");
						out.print("<td>Kid</td>");
						out.print("<td>Top</td>");
						out.print("<td>"+ktkinds.get(i).getKCatalog3()+"</td>");
						int count1 = kl.countProduct(ktkinds.get(i).getKId());
						int count2 = kl.countOrder(ktkinds.get(i).getKId());
						out.print("<td>"+count1+"</td>");
						out.print("<td>"+count2+"</td>");
						out.print("</tr>");		
					}
				
					for(int i = 0; i<kbkinds.size(); i++){
						out.print("<tr class='list-roles'>");
						out.print("<td>"+kbkinds.get(i).getKId()+"</td>");
						out.print("<td>Kid</td>");
						out.print("<td>Bottom</td>");
						out.print("<td>"+kbkinds.get(i).getKCatalog3()+"</td>");
						int count1 = kl.countProduct(kbkinds.get(i).getKId());
						int count2 = kl.countOrder(kbkinds.get(i).getKId());
						out.print("<td>"+count1+"</td>");
						out.print("<td>"+count2+"</td>");
						out.print("</tr>");		
					}
				%>
				</tbody>
			</table>
			<a href="A_new_kind.jsp" class="btn btn-success">New Kind</a>
		  </div>
        </div>
        <!-- end content -->
      </div>

      <hr>

    </div>

    <script src="js1/jquery.js"></script>
	<script src="js1/bootstrap.min.js"></script>
	<script>
	$(document).ready(function() {
		$('.dropdown-menu li a').hover(
		function() {
			$(this).children('i').addClass('icon-white');
		},
		function() {
			$(this).children('i').removeClass('icon-white');
		});
	});
	</script>
  </body>
</html>
