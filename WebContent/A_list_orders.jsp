<%@page import="BusinessLogic.OrderLogic"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Orders | Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Admin panel developed with the Bootstrap from Twitter.">
    <meta name="author" content="travis">

    <link href="css1/bootstrap.css" rel="stylesheet">
	<link href="css1/site.css" rel="stylesheet">
    <link href="css1/bootstrap-responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
      <script src="js/html5.js"></script>
    <![endif]-->
    
    <style>
  		.addlocationbox{
  			display:none;
  			position: absolute;
  			top:35%;
  			left:35%;
  			height:25%;
  			width:25%;
  			padding:20px;
  			border: 2px solid grey;
  			background-color: #ffffff;
  			z-index:1002;
  			overflow:auto;
  		}
  	</style>
    
  </head>
  <body>
  	<%@include file="A_HeadMenu.jsp" %>
  	
  	<script>
  		function send(str){
  			var oid = document.getElementById("order"+str).innerHTML;
  			var url = "Order?action=send&oid="+oid;
  			$.post(url, null, function(data){
  				if(data != ""){
  					alert("发货成功!");
  	  				window.location.href="A_list_orders.jsp";
  				}
  			});
  		}
  		
  		function modifylocation(str){
  			var oid = document.getElementById("order"+str).innerHTML;
  			document.getElementById("addlocation").style.display="block";
  			document.getElementById("addlocationoid").setAttribute("value", oid);
  		}
  		
  		function addlocation(){
  			var oid = document.getElementById("addlocationoid").value;
  			var location = document.getElementById("locationtext").value;
  			var url = "Order?action=addlocation&oid="+oid+"&newlocation="+location;
  			$.post(url, null, function(data){
  				if(data != ""){
  					alert("更新物流成功!");
  	  				window.location.href="A_list_orders.jsp";
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
              <li class="active"><a href="A_list_orders.jsp">Orders</a></li>
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
				<h1>Orders</h1>
			</div>
			
			<div id='addlocation' class='addlocationbox'>
				<div style="margin:0 auto">
				<strong><span>添加物流信息</span></strong>
				<br>
				<textarea id="locationtext" style="width:325px; height:90px"></textarea>
				<input type="button" value="Submit" onclick="addlocation()">
				<input type="hidden" id="addlocationoid">
				</div>
			</div>
			
			<table class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th style="text-align:center;vertical-align:middle;">OrderId</th>
						<th style="text-align:center;vertical-align:middle;">Picture</th>
						<th style="text-align:center;vertical-align:middle;">SKU</th>
						<th style="text-align:center;vertical-align:middle;">Name</th>
						<th style="text-align:center;vertical-align:middle;">Price</th>
						<th style="text-align:center;vertical-align:middle;">Quantity</th>

						<th style="text-align:center;vertical-align:middle;">创建日期</th>
						<th style="text-align:center;vertical-align:middle;">发货日期</th>
						<th style="text-align:center;vertical-align:middle;">收货日期</th>
						<th style="text-align:center;vertical-align:middle;">状态</th>
						<th style="text-align:center;vertical-align:middle;">物流</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
				
				<%
					OrderLogic ol = new OrderLogic();
					List<String> alloids = ol.findAllOid();
					for(int i = 0; i<alloids.size(); i++){
						String oid = alloids.get(i);
						String[] oid1 = oid.split("-");
						List<Entity.Order> items = ol.findAllItems(oid);
						
						for(int j = 0; j<items.size(); j++){
							
							if( j == 0){
								out.print("<tr class='list-roles'>");
								out.print("<td id='order"+String.valueOf(i)+"' style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>"+oid1[0]+"</td>");
							}
							out.print("<td><img width=80px src='images/"+items.get(j).getOPic()+"'></td>");
							out.print("<td style='text-align:center;vertical-align:middle;'>"+items.get(j).getSKU()+"</td>");
							out.print("<td style='text-align:center;vertical-align:middle;'>"+items.get(j).getOName()+"</td>");
							out.print("<td style='text-align:center;vertical-align:middle;'>"+items.get(j).getOPrice()+"</td>");
							out.print("<td style='text-align:center;vertical-align:middle;'>"+items.get(j).getONumber()+"</td>");
							if( j == 0){
								out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>"+items.get(j).getODate().toString()+"</td>");
								if(items.get(j).getOSentDate() != null){
									out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>"+items.get(j).getOSentDate().toString()+"</td>");
								}
								else{
									out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'></td>");
								}
								if(items.get(j).getOConfirmDate() != null){
									out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>"+items.get(j).getOConfirmDate().toString()+"</td>");
								}
								else{
									out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'></td>");
								}
								
								switch(items.get(j).getOStatus()){
								case 0 : out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>网上支付未付款</td>");break;
								case 1 : out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>网上支付未发货</td>");break;
								case 2 : out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>货到付款未发货</td>");break;
								case 3 : out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>已发货</td>");break;
								case 4 : out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>已确认收货</td>");break;
								case 5 : out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>已取消</td>");break;
								case 6 : out.print("<td style='text-align:center;vertical-align:middle;' rowspan='"+items.size()+"'>已完成</td>");break;
								}
								
								if(items.get(j).getOLocation() != null){
									out.print("<td style='vertical-align:middle;' rowspan='"+items.size()+"'>"+items.get(j).getOLocation()+"</td>");
								}
								else{
									out.print("<td rowspan='"+items.size()+"'></td>");
								}
								
								if(items.get(j).getOStatus() == 0 || items.get(j).getOStatus()==5){
									out.print("<td rowspan='"+items.size()+"'></td></tr>");
								}
								else if(items.get(j).getOStatus() == 1 || items.get(j).getOStatus() == 2)
								{
									out.print("<td rowspan='"+items.size()+"' style='vertical-align:middle;'>");
									out.print("<div class='btn-group'>");
									out.print("<a class='btn btn-mini dropdown-toggle' data-toggle='dropdown' href='#'>Actions<span class='caret'></span></a>");
									out.print("<ul class='dropdown-menu pull-right'>");
									out.print("<li><a href='#' onclick=\"send(\'"+String.valueOf(i)+"\')\"><i class='icon-pencil'></i>发货</a></li>");
									out.print("</ul></div></td></tr>");
								}
								else if(items.get(j).getOStatus() == 3){
									out.print("<td rowspan='"+items.size()+"' style='vertical-align:middle;'>");
									out.print("<div class='btn-group'>");
									out.print("<a class='btn btn-mini dropdown-toggle' data-toggle='dropdown' href='#'>Actions<span class='caret'></span></a>");
									out.print("<ul class='dropdown-menu pull-right'>");
									out.print("<li><a href='#' onclick=\"modifylocation(\'"+String.valueOf(i)+"\')\"><i class='icon-pencil'></i>更新物流</a></li>");
									out.print("</ul></div></td></tr>");
								}
								else{
									out.print("<td rowspan='"+items.size()+"'></td></tr>");
								}
							}
						}
					}
				%>
				</tbody>
			</table>
		  </div>
        </div>
        <!-- content -->
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
