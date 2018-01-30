package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import BusinessLogic.OrderLogic;
import Entity.Order;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/Order")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf8");
		response.setCharacterEncoding("utf8");
		String action = request.getParameter("action");
		PrintWriter out = response.getWriter();
		OrderLogic svc = new OrderLogic();
		BusinessLogic.CartLogic svc1 = new BusinessLogic.CartLogic();
		if(action != null && action.equals("add")){
			int count = 0;
			String uid = request.getParameter("userId");
			String product = request.getParameter("product");
			String[] skus = product.split("/");
			String address = request.getParameter("address");
			String[] addresses = address.split("/");
			String oid = String.valueOf(System.currentTimeMillis());
			for(int i = 1; i< skus.length; i++){
				try {
					int j = svc.add(Integer.parseInt(uid), skus[i], Integer.parseInt(addresses[1]), oid+"-"+i);
					if(j > 0){
						svc1.remove(Integer.parseInt(uid), skus[i]);
						count += j;
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(count > 0){
				out.write(oid);
			}
			else{
				out.write("0");
			}
		}
		
		if(action != null && action.equals("all")){
			String userId = request.getParameter("userId");
			OrderLogic ol = new OrderLogic();
			try{
				List<String> oids = ol.findOid(Integer.parseInt(userId));
				out.write(getHTML(Integer.parseInt(userId), oids, "all"));
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("allpay")){
			String userId = request.getParameter("userId");
			OrderLogic ol = new OrderLogic();
			try{
				List<String> oids = ol.findPayOid(Integer.parseInt(userId));
				out.write(getHTML(Integer.parseInt(userId), oids, "pay"));
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("allremind")){
			String userId = request.getParameter("userId");
			OrderLogic ol = new OrderLogic();
			try{
				List<String> oids = ol.findRemindOid(Integer.parseInt(userId));
				out.write(getHTML(Integer.parseInt(userId), oids, "remind"));
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("allconfirm")){
			String userId = request.getParameter("userId");
			OrderLogic ol = new OrderLogic();
			try{
				List<String> oids = ol.findConfirmOid(Integer.parseInt(userId));
				out.write(getHTML(Integer.parseInt(userId), oids, "confirm"));
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("allcomment")){
			String userId = request.getParameter("userId");
			OrderLogic ol = new OrderLogic();
			try{
				List<String> oids = ol.findCommentOid(Integer.parseInt(userId));
				out.write(getHTML(Integer.parseInt(userId), oids, "comment"));
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("confirm")){
			String oid = request.getParameter("oid");
			OrderLogic ol = new OrderLogic();
			try{
				int i = ol.confirm(oid);
				out.write(i);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("cancel")){
			String oid = request.getParameter("oid");
			OrderLogic ol = new OrderLogic();
			try{
				int i = ol.cancel(oid);
				out.write(i);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("send")){
			String oid = request.getParameter("oid");
			OrderLogic ol = new OrderLogic();
			try{
				if(ol.send(oid) > 0){
					out.write(ol.send(oid));
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("addlocation")){
			String oid = request.getParameter("oid");
			String newlocation = request.getParameter("newlocation");
			OrderLogic ol = new OrderLogic();
			try{
				if(ol.updatelocation(oid, newlocation) > 0){
					out.write(ol.updatelocation(oid, newlocation));
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	private String getHTML(int userId, List<String> oids, String action) throws Exception{
		BusinessLogic.OrderLogic ol = new BusinessLogic.OrderLogic();
		List<Order> items;
		String HTMLbody = "";
		for(int i=0;i<oids.size();i++){
			if(i == 0){
				String oid = oids.get(i);
				String[] oid1 = oid.split("-");
				if(action.equals("all")){
					items = ol.findItems(userId, oid);
				}
				else if(action.equals("pay")){
					items = ol.findPayItems(userId, oid);
				}
				else if(action.equals("remind")){
					items = ol.findRemindItems(userId, oid);
				}
				else if(action.equals("confirm")){
					items = ol.findConfirmItems(userId, oid);
				}
				else{
					items = ol.findCommentItems(userId, oid);
				}
				
				HTMLbody += "<tr style='border-bottom : 1px, solid, #ebebeb;' align='left' >";
				HTMLbody += "<td  colspan='7' >";
				HTMLbody += "<span padding= 10px>&nbsp; &nbsp; Date : "+items.get(0).getODate()+"</span>";
				HTMLbody += "<span padding=10px > &nbsp; &nbsp; OrderId : "+ oid1[0] + "</span>";
				HTMLbody += "</td>";
				HTMLbody += "</tr>";
				
				for(int j = 0; j<items.size(); j++){
					HTMLbody += "<tr>";
					HTMLbody += "<td>";
					HTMLbody += "<img src='images/"+items.get(j).getOPic()+"' width=80px>";
					HTMLbody += "</td>";
					HTMLbody += "<td>";
					HTMLbody += "<a href='Product?action=detail&SKU="+items.get(j).getSKU()+"'>"+items.get(j).getOName()+"</a>";
					HTMLbody += "</td><td>";
					HTMLbody += String.valueOf(items.get(j).getOPrice());
					HTMLbody += "</td><td>";
					HTMLbody += items.get(j).getONumber();
					HTMLbody += "</td><td>";
					HTMLbody += String.valueOf(items.get(j).getONumber() * items.get(j).getOPrice());
					HTMLbody += "</td>";
					if(j == 0){
						HTMLbody += "<td rowspan='"+items.size()+"'>";
						HTMLbody += "<a href='myspace_detail.jsp?oid="+oid+"'>Detail</a>";
						HTMLbody += "<br>";
						HTMLbody += "<a href='myspace_logistics.jsp?oid="+oid+"'>Location</a>";
						switch(items.get(0).getOStatus()){
							case 0 : HTMLbody += "<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>";break;
							case 1 : HTMLbody += "<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>";break;
							case 2 : HTMLbody += "<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>";break;
						}
						HTMLbody += "</td>";
						HTMLbody += "<td rowspan='"+items.size()+"'>";
						switch(items.get(0).getOStatus()){
							case 0 : HTMLbody += "<a href='#2'>To Pay</a>";break;
							case 1 : HTMLbody += "<a href='#2'>Remind Delivery</a>";break;
							case 2 : HTMLbody += "<a href='#2'>Remind Delivery</a>";break;
							case 3 : HTMLbody += "<a href='myspace_confirm.jsp?oid="+oid+"'>Confirm</a>";break;
							case 4 : HTMLbody += "<a href='myspace_comment.jsp?oid="+oid+"'>Comment</a>";break;
							case 5 : HTMLbody += "<a href='#2'>Canceled</a>";break;
							default : HTMLbody += "<a href='#2'>Finished</a>";
						}
						HTMLbody += "</td></tr>";
					}
					else{
						HTMLbody += "</tr>";
					}
				}
			}
			else{
				String[] oid1 = oids.get(i).split("-");
				String[] oid2 = oids.get(i-1).split("-");
				if(oid1[0].equals(oid2[0])){
					continue;
				}
				else{
					String oid = oids.get(i);
					if(action.equals("all")){
						items = ol.findItems(userId, oid);
					}
					else if(action.equals("pay")){
						items = ol.findPayItems(userId, oid);
					}
					else if(action.equals("remind")){
						items = ol.findRemindItems(userId, oid);
					}
					else if(action.equals("confirm")){
						items = ol.findConfirmItems(userId, oid);
					}
					else{
						items = ol.findCommentItems(userId, oid);
					}
					
					HTMLbody += "<tr style='border-bottom : 1px, solid, #ebebeb;' align='left' >";
					HTMLbody += "<td  colspan='7' >";
					HTMLbody += "<span padding= 10px>&nbsp; &nbsp; Date : "+items.get(0).getODate()+"</span>";
					HTMLbody += "<span padding=10px > &nbsp; &nbsp; OrderId : "+ oid + "</span>";
					HTMLbody += "</td>";
					HTMLbody += "</tr>";
					
					for(int j = 0; j<items.size(); j++){
						HTMLbody += "<tr>";
						HTMLbody += "<td>";
						HTMLbody += "<img src='images/"+items.get(j).getOPic()+"' width=80px>";
						HTMLbody += "</td>";
						HTMLbody += "<td>";
						HTMLbody += "<a href='Product?action=detail&SKU="+items.get(j).getSKU()+"'>"+items.get(j).getOName()+"</a>";
						HTMLbody += "</td><td>";
						HTMLbody += String.valueOf(items.get(j).getOPrice());
						HTMLbody += "</td><td>";
						HTMLbody += items.get(j).getONumber();
						HTMLbody += "</td><td>";
						HTMLbody += String.valueOf(items.get(j).getONumber() * items.get(j).getOPrice());
						HTMLbody += "</td>";
						if(j == 0){
							HTMLbody += "<td rowspan='"+items.size()+"'>";
							HTMLbody += "<a href='myspace_detail.jsp?oid="+oid+"'>Detail</a>";
							HTMLbody += "<br>";
							HTMLbody += "<a href='myspace_logistics.jsp?oid="+oid+"'>Location</a>";
							switch(items.get(0).getOStatus()){
								case 0 : HTMLbody += "<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>";break;
								case 1 : HTMLbody += "<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>";break;
								case 2 : HTMLbody += "<br><a href='javascript:;' onclick=\"cancel(\'"+oid+"\')\">Cancel</a>";break;
							}
							HTMLbody += "</td>";
							HTMLbody += "<td rowspan='"+items.size()+"'>";
							switch(items.get(0).getOStatus()){
								case 0 : HTMLbody += "<a href='#2'>To Pay</a>";break;
								case 1 : HTMLbody += "<a href='#2'>Remind Delivery</a>";break;
								case 2 : HTMLbody += "<a href='#2'>Remind Delivery</a>";break;
								case 3 : HTMLbody += "<a href='myspace_confirm.jsp?oid="+oid+"'>Confirm</a>";break;
								case 4 : HTMLbody += "<a href='myspace_comment.jsp?oid="+oid+"'>Comment</a>";break;
								case 5 : HTMLbody += "<a href='#2'>Canceled</a>";break;
								default : HTMLbody += "<a href='#2'>Finished</a>";
							}
							HTMLbody += "</td></tr>";
						}
						else{
							HTMLbody += "</tr>";
						}
					}
				}	
			}
		}
		return HTMLbody;
	}

	
}
