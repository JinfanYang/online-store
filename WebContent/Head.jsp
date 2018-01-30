<!-- header_top -->
<%@page import="BusinessLogic.KindLogic"%>
<%@page import="Entity.Kind" %>
<%@page import="BusinessLogic.CartLogic"%>
<%@page import="java.util.List" %>
<div class="top_bg">
	<div class="container">
		<div class="header_top">
			<div class="top_right">
				<ul>
					<li><a href="A_login.jsp">Admin</a></li>|
					<li><a href="contact.html">Contact</a></li>
				</ul>
			</div>
			<div class="top_left">
				<h2><span></span> Call us : 012 3456 789</h2>
			</div>
				<div class="clearfix"> </div>
		</div>
	</div>
</div>
</script>
<!-- header -->
<div class="header_bg">
<div class="container">
	<div class="header">
	<div class="head-t">
		<div class="logo">
			<a href="index.jsp"><img src="images/logo.png" class="img-responsive" alt=""/> </a>
		</div>
		<!-- start header_right -->
		<div class="header_right">
			<div class="rgt-bottom">
			<% 
				if(request.getSession().getAttribute("ISLOGIN")=="1"){
					out.print("<div class='reg'><a href='myspace_index.jsp?userId="+request.getSession().getAttribute("USERID")+"'>Welcome!  "+request.getSession().getAttribute("USERNAME")+"</a></div>");
					out.print("<input type='hidden' id='userId' value='"+request.getSession().getAttribute("USERID")+"'>");
					out.print("<div class='reg'>");
					out.print("<a href='User?action=logout'>LogOut</a>");
					out.print("</div>");
				}
				else{
					out.print("<div class='log'>");
					out.print("<div class='login'>");
					out.print("<div id='loginContainer'>");
					out.print("<a href='login.jsp'><span>Login</span></a>");
					out.print("</div></div></div>");
					out.print("<input type='hidden' id='userId' value=''>");
					out.print("<div class='reg'>");
					out.print("<a href='register.jsp'>REGISTER</a>");
					out.print("</div>");
				}
			%>       
			<div class="cart box_1">
			<%
				if(request.getSession().getAttribute("ISLOGIN")=="1"){
					CartLogic cl = new CartLogic();
					int userId = (int)request.getSession().getAttribute("USERID");
					int count = cl.countByUserId(userId);
					double total = cl.totalByUserId(userId);
					if(count > 0){
						out.print("<a href='cart.jsp?userId="+userId+"'>");
						out.print("<h3> <span>$</span><span id='simpleCart_total'>"+ total +"</span> (<span id='simpleCart_quantity'>"+ count +"</span> items)<img src='images/bag.png' alt=''></h3>");
						out.print("</a>");
					}
					else{
						out.print("<a href='cart.jsp?userId="+userId+"'>");
						out.print("<h3> <span>$</span><span id='simpleCart_total'>"+ total +"</span> (<span id='simpleCart_quantity'>"+ count +"</span> items)<img src='images/bag.png' alt=''></h3>");
						out.print("</a>");
						out.print("<p id='cart'><a href='javascript:;' class='simpleCart_empty'>(empty cart)</a></p>");
					}
				}
				else{
					out.print("<a href='login.jsp'>");
					out.print("<h3> <span class='simpleCart_total'>$0.00</span> (<span id='simpleCart_quantity' class='simpleCart_quantity'>0</span> items)<img src='images/bag.png' alt=''></h3>");
					out.print("</a>");
					out.print("<p><a href='javascript:;' class='simpleCart_empty'>(empty cart)</a></p>");
				}
			%>
			
				<div class="clearfix"> </div>
			</div>
			<div class="create_btn">
				<%
					if(request.getSession().getAttribute("ISLOGIN")=="1"){
						out.print("<a href='cart.jsp?userId="+(int)request.getSession().getAttribute("USERID")+"'>CHECKOUT</a>");
					}
					else{
						out.print("<a href='login.jsp'>CHECKOUT</a>");
					}
					
				%>
			</div>
			<div class="clearfix"> </div>
		</div>
		<div class="search">
		    <form>
		    	<input type="text" value="" placeholder="search...">
				<input type="submit" value="">
			</form>
		</div>
		<div class="clearfix"> </div>
		</div>
		<div class="clearfix"> </div>
	</div>
		<!-- start header menu -->
		<ul class="megamenu skyblue">
			<li class="active grid"><a class="color1" href="index.jsp">Home</a></li>
			<li class="grid"><a class="color2" href="#">new arrivals</a>
				<div class="megapanel">
					<div class="row">
						<div class="col1">
							<div class="h_nav">
								<h4>Men</h4>
								<ul>
								<%
									KindLogic kl = new KindLogic();
									List<Kind> kinds = kl.findMKind();
									for(int i = 0; i<kinds.size(); i++){
										out.print("<li><a href='Product?action=new&gender=0&kindid="+String.valueOf(kinds.get(i).getKId())+"&kind="+kinds.get(i).getKCatalog3()+"'>"+kinds.get(i).getKCatalog3()+"</a></li>");
									}
								%>
								</ul>	
							</div>							
						</div>
						<div class="col1">
							<div class="h_nav">
								<h4>Women</h4>
								<ul>
									<%
										kinds = kl.findFKind();
										for(int i = 0; i<kinds.size(); i++){
											out.print("<li><a href='Product?action=new&gender=1&kindid="+String.valueOf(kinds.get(i).getKId())+"&kind="+kinds.get(i).getKCatalog3()+"'>"+kinds.get(i).getKCatalog3()+"</a></li>");
										}
									%>
								</ul>	
							</div>							
						</div>
						<div class="col1">
							<div class="h_nav">
								<h4>Kids</h4>
								<ul>
									<%
										kinds = kl.findKKind();
										for(int i = 0; i<kinds.size(); i++){
											out.print("<li><a href='Product?action=new&gender=2&kindid="+String.valueOf(kinds.get(i).getKId())+"&kind="+kinds.get(i).getKCatalog3()+"'>"+kinds.get(i).getKCatalog3()+"</a></li>");
										}
									%>
								</ul>	
							</div>												
						</div>
					</div>
					<div class="row">
						<div class="col2"></div>
						<div class="col1"></div>
						<div class="col1"></div>
						<div class="col1"></div>
						<div class="col1"></div>
					</div>
    				</div>
				</li>
			<li><a class="color4" href="#">Men</a>
				<div class="megapanel">
					<div class="row">
						<div class="col1">
							<div class="h_nav">
								<h4>Tops</h4>
								<ul>
									<%
										kinds = kl.findMKind1();
										for(int i = 0; i<kinds.size(); i++){
											out.print("<li><a href='Product?action=catalog&gender=0&kindid="+String.valueOf(kinds.get(i).getKId())+"&kind="+kinds.get(i).getKCatalog3()+"'>"+kinds.get(i).getKCatalog3()+"</a></li>");
										}
									%>
								</ul>	
							</div>							
						</div>
						<div class="col1">
							<div class="h_nav">
								<h4>Bottoms</h4>
								<ul>
									<%
										kinds = kl.findMKind2();
										for(int i = 0; i<kinds.size(); i++){
											out.print("<li><a href='Product?action=catalog&gender=0&kindid="+String.valueOf(kinds.get(i).getKId())+"&kind="+kinds.get(i).getKCatalog3()+"'>"+kinds.get(i).getKCatalog3()+"</a></li>");
										}
									%>
								</ul>	
							</div>							
						</div>
					</div>
					<div class="row">
						<div class="col2"></div>
						<div class="col1"></div>
						<div class="col1"></div>
						<div class="col1"></div>
						<div class="col1"></div>
					</div>
    				</div>
				</li>				
				<li><a class="color5" href="#">Women</a>
				<div class="megapanel">
					<div class="row">
						<div class="col1">
							<div class="h_nav">
								<h4>Tops</h4>
								<ul>
									<%
										kinds = kl.findFKind1();
										for(int i = 0; i<kinds.size(); i++){
											out.print("<li><a href='Product?action=catalog&gender=1&kindid="+String.valueOf(kinds.get(i).getKId())+"&kind="+kinds.get(i).getKCatalog3()+"'>"+kinds.get(i).getKCatalog3()+"</a></li>");
										}
									%>
								</ul>	
							</div>							
						</div>
						<div class="col1">
							<div class="h_nav">
								<h4>Bottoms</h4>
								<ul>
									<%
										kinds = kl.findFKind2();
										for(int i = 0; i<kinds.size(); i++){
											out.print("<li><a href='Product?action=catalog&gender=1&kindid="+String.valueOf(kinds.get(i).getKId())+"&kind="+kinds.get(i).getKCatalog3()+"'>"+kinds.get(i).getKCatalog3()+"</a></li>");
										}
									%>
								</ul>	
							</div>							
						</div>
					</div>
					<div class="row">
						<div class="col2"></div>
						<div class="col1"></div>
						<div class="col1"></div>
						<div class="col1"></div>
						<div class="col1"></div>
					</div>
    				</div>
				</li>
				<li><a class="color6" href="#">Kids</a>
				<div class="megapanel">
					<div class="row">
						<div class="col1">
							<div class="h_nav">
								<h4>Tops</h4>
								<ul>
									<%
										kinds = kl.findKKind1();
										for(int i = 0; i<kinds.size(); i++){
											out.print("<li><a href='Product?action=catalog&gender=2&kindid="+String.valueOf(kinds.get(i).getKId())+"&kind="+kinds.get(i).getKCatalog3()+"'>"+kinds.get(i).getKCatalog3()+"</a></li>");
										}
									%>
								</ul>	
							</div>							
						</div>
						<div class="col1">
							<div class="h_nav">
								<h4>Bottoms</h4>
								<ul>
									<%
										kinds = kl.findKKind2();
										for(int i = 0; i<kinds.size(); i++){
											out.print("<li><a href='Product?action=catalog&gender=2&kindid="+String.valueOf(kinds.get(i).getKId())+"&kind="+kinds.get(i).getKCatalog3()+"'>"+kinds.get(i).getKCatalog3()+"</a></li>");
										}
									%>
								</ul>	
							</div>							
						</div>
					</div>
					<div class="row">
						<div class="col2"></div>
						<div class="col1"></div>
						<div class="col1"></div>
						<div class="col1"></div>
						<div class="col1"></div>
					</div>
    				</div>
				</li>				
		 </ul> 
	</div>
</div>
</div>