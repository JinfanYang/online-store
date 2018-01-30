<%@page import="Entity.Kind" %>
<%@page import="Entity.Brand" %>
<%@page import="BusinessLogic.KindLogic" %>
<%@page import="BusinessLogic.BrandLogic" %>
<%@page import="java.util.List" %>
<script src="js/simpleCart.min.js"> </script>
<script>
	function changeGender(str){
		var kinds = document.getElementsByName("kcheckbox");	
		var kind="";
		for(var i =0; i<kinds.length; i++){
			if(kinds[i].checked){
				kind = kind + "/" + kinds[i].getAttribute("value");
			}
		}
		
		var brands = document.getElementsByName("bcheckbox");
		var brand="";
		for(var i =0; i<brands.length; i++){
			if(brands[i].checked){
				brand = brand + "/" + brands[i].getAttribute("value");
			}
		}
		
		if(str == "newarrival"){
			var url="Product?action=mnew&kinds="+kind+"&brands="+brand;
		}
		else if(str == "sale"){
			var url="Product?action=msale&kinds="+kind+"&brands="+brand;
		}
		else{
			var url="Product?action=mcatalog&gender="+str+"&kinds="+kind+"&brands="+brand;
		}	
		
		$.post(url,null,function(data){
			if(data!=0){
				$("#content").html(data);	
			}
		});
				
	}
	
	function change(){
		var kinds = document.getElementsByName("kcheckbox");	
		var kind="";
		for(var i =0; i<kinds.length; i++){
			if(kinds[i].checked){
				kind = kind + "/" + kinds[i].getAttribute("value");
			}
		}
		
		var brands = document.getElementsByName("bcheckbox");
		var brand="";
		for(var i =0; i<brands.length; i++){
			if(brands[i].checked){
				brand = brand + "/" + brands[i].getAttribute("value");
			}
		}
		
		var url="Product?action=all&kinds="+kind+"&brands="+brand;
		
		$.post(url,null,function(data){
			if(data!=0){
				$("#content").html(data);	
			}
		});
	}
	
</script>

	<div class="col-md-3 s-d">
	  <div class="w_sidebar">
		<div class="w_nav1">
			<h4>All</h4>
			<ul>
				<li><a href="javascript:void(0);" onclick="changeGender('newarrival')">new arrivals</a></li>
				<li><a href="javascript:void(0);" onclick="changeGender('women')">women</a></li>
				<li><a href="javascript:void(0);" onclick="changeGender('men')">men</a></li>
				<li><a href="javascript:void(0);" onclick="changeGender('kid')">kids</a></li>
				<li><a href="javascript:void(0);" onclick="changeGender('sale')">sale</a></li>
			</ul>	
		</div>
		<h3>filter by</h3>
		<section  class="sky-form">
		<%
			KindLogic mkl = new KindLogic();
			List<String> kindlist =(List<String>)mkl.findAllKind();
			BrandLogic mbl = new BrandLogic();
			List<Brand> brandlist = (List<Brand>)mbl.findAllBrand();
		%>
					<h4>catogories</h4>
						<div class="row1 scroll-pane">
							<div class="col col-4">
								<%
									for(int i = 0; i<kindlist.size(); i++){
										out.print("<label class='checkbox'><input type='checkbox' name='kcheckbox' value='"+kindlist.get(i)+"' onclick='change()'><i></i>"+kindlist.get(i)+"</label>");
									}
								%>
							</div>
						</div>
		</section>
		<section  class="sky-form">
					<h4>brand</h4>
						<div class="row1 scroll-pane">
							<div class="col col-4">
							<%
									for(int i = 0; i<brandlist.size(); i++){
										out.print("<label class='checkbox'><input type='checkbox' name='bcheckbox' value='"+brandlist.get(i).getBName()+"' onclick='change()'><i></i>"+brandlist.get(i).getBName()+"</label>");
									}
							%>																						
							</div>
						</div>
		</section>
		<section class="sky-form">
			<h4>colour</h4>
			<ul class="w_nav2">
				<li><a class="color1" href="#"></a></li>
				<li><a class="color2" href="#"></a></li>
				<li><a class="color3" href="#"></a></li>
				<li><a class="color4" href="#"></a></li>
				<li><a class="color5" href="#"></a></li>
				<li><a class="color6" href="#"></a></li>
				<li><a class="color7" href="#"></a></li>
				<li><a class="color8" href="#"></a></li>
				<li><a class="color9" href="#"></a></li>
				<li><a class="color10" href="#"></a></li>
				<li><a class="color12" href="#"></a></li>
				<li><a class="color13" href="#"></a></li>
				<li><a class="color14" href="#"></a></li>
				<li><a class="color15" href="#"></a></li>
				<li><a class="color5" href="#"></a></li>
				<li><a class="color6" href="#"></a></li>
				<li><a class="color7" href="#"></a></li>
				<li><a class="color8" href="#"></a></li>
				<li><a class="color9" href="#"></a></li>
				<li><a class="color10" href="#"></a></li>
			</ul>
		</section>
	</div>
   </div>