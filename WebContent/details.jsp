<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="BusinessLogic.ProductLogic" %>
<%@ page import="Entity.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="BusinessLogic.CommentLogic" %>
<%@ page import="Entity.Comment" %>
<!DOCTYPE html>
<html>
<head>
<%@include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/etalage.css">
<script src="js/jquery.etalage.min.js"></script>
<script src="js/simpleCart.min.js"> </script>

<script>
	jQuery(document).ready(function($){
		$('#etalage').etalage({
			thumb_image_width: 300,
			thumb_image_height: 400,
			source_image_width: 900,
			source_image_height: 1200,
			show_hint: true,
			click_callback: function(image_anchor, instance_id){
			alert('Callback example:\nYou clicked on an image with the anchor: "'+image_anchor+'"\n(in Etalage instance: "'+instance_id+'")');
			}
		});

	});
</script>
<script type="text/javascript">
	function checkStorage(){
		var sizes = document.getElementsByName("sradio");
		var size;
		for(var i =0; i<sizes.length; i++){
			if(sizes[i].checked){
				size = sizes[i].getAttribute("value");
				break;
			}
			else{
				continue;
			}
		}
		var pid = document.getElementById("pid").innerHTML;
		
		var colors = document.getElementsByName("cradio");
		var color;
		for(var i =0; i<colors.length; i++){
			if(colors[i].checked){
				color = colors[i].getAttribute("value");
				break;
			}
			else{
				continue;
			}
		}
		
		var url="Product?action=checkStorage&pid="+pid+"&size="+size+"&color="+color;
		$.post(url,null,function(data){
			if(data!=0){
				var strs = new Array();
				strs = data.split(",");
				document.getElementById("sku").innerHTML = strs[0];
				document.getElementById("storage").innerHTML = strs[1];
				if(strs[1]==""){
					document.getElementById("addCartButton").setAttribute("onclick","noStorage()");
					document.getElementById("buyButton").setAttribute("onclick","noStorage()");
				}
				else{
					document.getElementById("addCartButton").setAttribute("onclick","addToCart()");
					document.getElementById("buyButton").setAttribute("onclick","toBuy()");
				}
			}
		});
	}
	
	function addToCart(){
		var sku = document.getElementById("sku").innerHTML;
		var userId = document.getElementById("userId").value;
		
		var url = "Cart?action=add&sku="+sku+"&uid="+userId;
		
		$.post(url, null, function(data){
			if(data != "0"){
				alert("Add Successfully!");
				var totalstr = document.getElementById("simpleCart_total").innerHTML;
				var numberstr = document.getElementById("simpleCart_quantity").innerHTML;
				var pricestr = document.getElementById("price-new").innerHTML;
				var total = parseFloat(totalstr);
				var price = parseFloat(pricestr);
				var number = parseInt(numberstr);
				total = total + price;
				number = number + 1;
				document.getElementById("simpleCart_total").innerHTML = total;
				document.getElementById("simpleCart_quantity").innerHTML = number;
				var cartdiv = document.getElementById("cart");
				if (cartdiv != null)
					cartdiv.parentNode.removeChild(cartdiv);
			}
			else{
				var r = confirm("You didn't login, Do you want to login?");
				if(r){
					window.location.href="Cart?action=toLogin&sku="+sku;
				}
				
			}		
		});
	}
	
	function toBuy(){
		var sku = document.getElementById("sku").innerHTML;
		var userId = document.getElementById("userId").value;
		
		var url = "Cart?action=buy&sku="+sku+"&uid="+userId;
		
		$.post(url, null, function(data){
			if(data == "0"){
				var r = confirm("You didn't login, Do you want to login?");
				if(r){
					window.location.href="Cart?action=toLogin&sku="+sku;
				}
			}
			else{
				window.location.href="cart.jsp?userId="+userId;
			}
		});
	}
	
	function noStorage(){
		alert("The product you chosen is not available!");
	}
	
</script>
<title>Detail</title>
</head>
<body>
<%@include file="Head.jsp" %>
<!--content -->
<div class="container">
	<div class="women_main">
	<!-- start content -->
	<%@include file="Menu.jsp" %>
	
	<div id="content">
		<div class="col-md-9 det">
			<div class="single_left">
				<div class="grid images_3_of_2">
					<ul id="etalage">
						<%
							Product product = (Product)request.getSession().getAttribute("PRODUCT");
							if(product!=null){
								if(product.getPPics().size()>0){
									for(int i=0; i<product.getPPics().size(); i++){
										if(product.getPPics().get(i) != null){
											if(i==0){
												out.print("<a href='#'>");
												out.print("<li>");
												out.print("<img class='etalage_thumb_image' src='images/"+ product.getPPics().get(i)+"' class='img-responsive' />");
												out.print("<img class='etalage_source_image' src='images/"+product.getPPics().get(i)+"' class='img-responsive' title='' />");
												out.print("</a>");
											}
											out.print("<li>");
											out.print("<img class='etalage_thumb_image' src='images/"+ product.getPPics().get(i)+"' class='img-responsive' />");
											out.print("<img class='etalage_source_image' src='images/"+product.getPPics().get(i)+"' class='img-responsive' title='' />");
										}
									}
								}
							}
						%>
						</ul>
						<div class="clearfix"></div>		
				  </div>
				  <div class="desc1 span_3_of_2">
				  		<h3><% out.print(product.getPName()); %></h3>
						<br>
						<div class="price">
							<span class="text">Price:</span>
							<span class="price-new">$<span id="price-new"><% out.print(product.getPDiscountPrice());%></span></span><span class="price-old">$<%out.print(product.getPPrice()); %></span>
							<br>
							<span class="points">
								<small>Product: </small><small  id="pid"><%out.print(product.getPId()); %></small>
							</span>
							<br>
							<span class="points">
								<small>SKU: </small><small  id="sku"><%out.print(product.getSKU()); %></small>
							</span>
							<br>
							<span class="points">
								<small>Storage: </small><small id="storage"><% out.print(product.getPStorage()); %></small>
							</span>
							<br>
						</div>
						<div class="det_nav1">
							<h4>Select a size :</h4>
							<div class=" sky-form col col-4">
								<ul>
								<%
									List<Integer> sizes = (List<Integer>)request.getSession().getAttribute("SIZE");
									for(int i =0; i< sizes.size();i++){
										if(sizes.get(i)==0)
										{
											if(product.getPSize() == sizes.get(i))
											{
												%>
													<li><label class="checkbox"><input type="radio" name="sradio" id="sradio" value="s" checked="checked" onclick="checkStorage()"><i></i>S</label></li>
												<% 
											}
											else{
												out.print("<li><label class='checkbox'><input type='radio' name='sradio' id='sradio' value='s' onclick='checkStorage()'><i></i>S</label></li>");
											}
											
										}
										else if(sizes.get(i)==1){
											if(product.getPSize() == sizes.get(i))
											{
												out.print("<li><label class='checkbox'><input type='radio' name='sradio' id='sradio' value='m' checked='checked' onclick='checkStorage()'><i></i>M</label></li>");
											}
											else{
												out.print("<li><label class='checkbox'><input type='radio' name='sradio' id='sradio' value='m' onclick='checkStorage()'><i></i>M</label></li>");
											}
										}
										else if(sizes.get(i)==2){
											if(product.getPSize() == sizes.get(i))
											{
												out.print("<li><label class='checkbox'><input type='radio' name='sradio' id='sradio' value='l' checked='checked' onclick='checkStorage()'><i></i>L</label></li>");
											}
											else{
												out.print("<li><label class='checkbox'><input type='radio' name='sradio' id='sradio' value='l' onclick='checkStorage()'><i></i>L</label></li>");
											}
										}
										else{
											if(product.getPSize() == sizes.get(i))
											{
												out.print("<li><label class='checkbox'><input type='radio' name='sradio' id='sradio' value='xl' checked='checked' onclick='checkStorage()'><i></i>XL</label></li>");
											}
											else{
											out.print("<li><label class='checkbox'><input type='radio' name='sradio' id='sradio' value='xl' onclick='checkStorage()'><i></i>XL</label></li>");
										
											}
										}
									}
								
								%>
								</ul>
							</div>
						</div>
						<div class="det_nav1">
							<h4>Select a color :</h4>
							<div class="sky-form col col-4">
								<ul>
								<%
									List<String> colors = (List<String>)request.getSession().getAttribute("COLOR");
									for(int i =0; i< colors.size();i++){
										if(product.getPColor().equals(colors.get(i)))
										{
											out.print("<li><label class='checkbox'><input type='radio' name='cradio' id='cradio' checked='checked' onclick='checkStorage()' value='"+colors.get(i)+"'><i></i>"+colors.get(i)+"</label></li>");
										}
										else{
											out.print("<li><label class='checkbox'><input type='radio' name='cradio' id='cradio' onclick='checkStorage()' value='"+colors.get(i)+"'><i></i>"+colors.get(i)+"</label></li>");
									
										}
									}
								%>
								</ul>
							</div>
						</div>
						<div class="btn_form" id="addCartdiv">
							<a href="javascript:;" id="addCartButton" onclick="addToCart()">Add to Cart</a>
						</div>
						<div class="btn_form" id="buyButtondiv">
							<a href="javascript:;" id="buyButton" onclick="toBuy()">Buy</a>
						</div>	
			   	 </div>
          	     <div class="clearfix"></div>
          	</div>
          	<div class="single-bottom1">
				<h6>Details</h6>
				<p class="prod-desc">Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option</p>
			</div>
			<div class="single-bottom2">
				<h6>Comments</h6>	
					<%
						String pid = product.getPId();
						CommentLogic col = new CommentLogic();
						List<Comment> comments = col.findComment(pid);
						for(int j = 0; j<comments.size(); j++){
							out.print("<div class=\"product\"");
								out.print("<div class=\"product-desc\"");
									out.print("<div class=\"product-img\">");
				   						out.print("<img src=\"images/user.png\" class=\"img-responsive\" alt='' width=100px><br>");
				   		    		out.print("</div>");
                       				out.print("<div class=\"prod1-desc\">");
                       					out.print("<a class=\"product_link\" href=\"#2\">"+comments.get(j).getUName()+"</a>");
                            			out.print("<p class=\"product_descr\">"+comments.get(j).getCComment()+"</p>");									
					   				out.print("</div>");
					  				out.print("<div class=\"clearfix\"></div>");
								//out.print("</div>");
								out.print("<div class=\"product-price\"");
									if(comments.get(j).getCStar() == 1){
										out.print("<span class=\"price-access\"><img src=\"images/good.png\"></span>");
									}
									else if(comments.get(j).getCStar() == 2){
										out.print("<span class=\"price-access\"><img src=\"images/normal.png\"></span>");
									}
									else{
										out.print("<span class=\"price-access\"><img src=\"images/bad.png\"></span>");
									}
								out.print("</div>");	
								//out.print("<div class=\"clearfix\"></div>");
							//out.print("</div>");
						}
					%>
		   	  </div>
	       </div>
	   </div>	
	<div class="clearfix"></div>	
	<!-- end content -->
</div>
</div>

<%@include file="Foot.jsp" %>
</body>
</html>