<div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">Administration</a>
          <div class="btn-group pull-right">
          <%
          		if(request.getSession().getAttribute("ADMINISLOGIN")=="1"){
					out.print("<a class='btn href='#2'><i class='icon-user'></i>"+ request.getSession().getAttribute("ADMINNAME")+"</a>");
					out.print("<input type='hidden' value='"+ request.getSession().getAttribute("ADMINID")+"'>");
				}
          %>
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
			  <li><a href="A_my_profile.jsp">Profile</a></li>
              <li class="divider"></li>
              <li><a href="Admin?action=logout">Logout</a></li>
            </ul>
          </div>
          <div class="nav-collapse">
            <ul class="nav">
			<li><a href="A_index.jsp">Home</a></li>
              <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Users <b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a href="A_list_users.jsp">Manage Users</a></li>
				</ul>
			  </li>
              <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Products <b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a href="A_new_product.jsp">New Product</a></li>
					<li class="divider"></li>
					<li><a href="A_list_products.jsp">Manage Products</a></li>
				</ul>
			  </li>
			  <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Orders <b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a href="A_list_orders.jsp">Manage Orders</a></li>
				</ul>
			  </li>
			  <li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">Statics <b class="caret"></b></a>
				<ul class="dropdown-menu">
					<li><a href="A_static_general.jsp">General</a></li>
					<li><a href="A_static_kind.jsp">Kind</a></li>
					<li><a href="A_static_brand.jsp">Brand</a></li>
				</ul>
			  </li>
            </ul>
          </div>
        </div>
      </div>
    </div>