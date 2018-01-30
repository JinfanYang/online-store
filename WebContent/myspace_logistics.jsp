<%@page import="Entity.Order"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Entity.Order"%>
<%@ page import="BusinessLogic.OrderLogic" %>
<!DOCTYPE html>
<html>
<head>
<script src="http://api.map.baidu.com/api?v=1.5&ak=jFFGKTR0YGbeFvAXfn36ydqK" type="text/javascript"></script>
<title>Order Location</title>
<%@ include file="Reference.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=1.5&amp;ak=jFFGKTR0YGbeFvAXfn36ydqK&amp;services=&amp;t=20150522094656"></script>

</head>
<body>
<%@ include file="Head.jsp" %>



<%
	String oid = request.getParameter("oid");
	OrderLogic ol = new OrderLogic();
	List<Order> orders = ol.findById(oid);
%>

<div class="container">
<div class="grids_of_4">
	<div style='text-align:left; border:1px solid #ebebeb; padding:10px;'>
		<%
			out.print("<span>Ship Address : Jenny&nbsp;&nbsp;Haidian Distric,Beijing&nbsp;&nbsp;18500800193</span><br>");
			out.print("<span>Delivery Address : "+ orders.get(0).getODeliveryName() +"&nbsp;&nbsp;"+orders.get(0).getODeliveryAddress()+"&nbsp;&nbsp;"+orders.get(0).getODeliveryPhone()+"</span><br>");
		%>
	</div>
	<div class="clearfix"></div>
</div>

<div style="border-bottom:1px solid #ebebeb; padding:5px;"></div>

<div>
	<div style='padding:10px;'>
		<%
			for(int i = 0; i<orders.size(); i++)
			{
					out.print("<span style='float:left; width: 120px;'>");
					out.print("<img src='images/"+orders.get(i).getOPic()+"' width=80px><br>");
					out.print("<span>"+orders.get(i).getOPrice()+" * "+orders.get(i).getONumber()+"</span>");
					out.print("</span>");	
			}
		%>
	</div>
	<div class="clearfix"></div>
</div>

<div style="padding-top : 30px; margin-left: 30px;">
	<%
		String locationstr = orders.get(0).getOLocation();
		if(locationstr != null){
			String[] locations = locationstr.split("/");
			for(int i = 0; i<locations.length; i++){
				out.print("<span>"+ locations[i] +"</span><br>");
				out.print("<img src=images/points.png width=50px><br>");
				if(i == locations.length-1){
					out.print("<strong><span id='latesLocation'>"+ locations[i] +"</span></strong>");
					out.print("<a href='javascript:;' onclick='showMap()'><small>&nbsp;(look up map)</small></a>");
				}
			}
		}
		else{
			out.print("<div>Not send products yet !</div>");
		}
		
	%>
</div>
 <div id="container" name="container"  style="width:100%;height:320px; margin:30px;">
	<script type="text/javascript">
	var map = new BMap.Map("container");	
	var point = new BMap.Point(116.404, 39.915);
	map.centerAndZoom(point, 15);
	map.enableScrollWheelZoom();
	map.addControl(new BMap.NavigationControl()); 

	var localSearch = new BMap.LocalSearch(map);
	localSearch.enableAutoViewport();
	
	function showMap(){
		map.clearOverlays();
		var keyword = document.getElementById("latesLocation").innerHTML;
		
		localSearch.setSearchCompleteCallback(function (searchResult) {
			var poi = searchResult.getPoi(0);
		    map.centerAndZoom(poi.point, 13);
		    var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地址对应的经纬度
		    map.addOverlay(marker);
		    var content = document.getElementById("latesLocation").value; 
		    var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
		    marker.addEventListener("click", function () { 
		        this.openInfoWindow(infoWindow); }); 
		    marker.setAnimation(BMAP_ANIMATION_BOUNCE);
		});
		localSearch.search(keyword); 
	};
</script>
 </div>

<div class="clearfix"></div>

</div>

<div class="clearfix"></div>

<%@ include file="Foot.jsp" %>
</body>
</html>