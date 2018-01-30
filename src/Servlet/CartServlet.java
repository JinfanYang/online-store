package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;

import BusinessLogic.CartLogic;
/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/Cart")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartServlet() {
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
		CartLogic svc = new CartLogic();
		String action = request.getParameter("action");
		if(action != null && action.equals("add")){
			PrintWriter out = response.getWriter();
			String userId = request.getParameter("uid");
			String sku = request.getParameter("sku");
			if(userId == null || userId == ""){
				out.write("0");
			}
			else{
				Entity.Cart cart = new Entity.Cart();
				cart.setUId(Integer.parseInt(userId));
				cart.setSKU(sku);
				cart.setCNumber(1);
				try{
					int i = svc.add(cart);
					out.write(i);
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		if(action != null && action.equals("buy")){
			PrintWriter out = response.getWriter();
			String userId = request.getParameter("uid");
			String sku = request.getParameter("sku");
			if(userId == null || userId == ""){
				out.write("0");
			}
			else{
				Entity.Cart cart = new Entity.Cart();
				cart.setUId(Integer.parseInt(userId));
				cart.setSKU(sku);
				cart.setCNumber(1);
				try {
					int i = svc.add(cart);
					out.write(i);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		}
		
		if(action != null && action.equals("delete")){
			String sku = request.getParameter("sku");
			int userid = Integer.parseInt(request.getParameter("uid"));
			PrintWriter out = response.getWriter();
			try{
				int i = svc.remove(userid, sku);
				int items = svc.countByUserId(userid);
				double total = svc.totalByUserId(userid);
				double all = total + 150;
				out.write(i+"/"+items+"/"+total+"/"+all);
			}catch (Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("modifyQuantity")){
			int userid = Integer.parseInt(request.getParameter("userId"));
			String sku = request.getParameter("sku");
			int no = Integer.parseInt(request.getParameter("no"));
			PrintWriter out = response.getWriter();
			try{
				int i = svc.save(userid, sku, no);
				double total = svc.totalByUserId(userid);
				double all = total + 150;
				out.write(i+"/"+total+"/"+all);
			}catch(Exception e){
				e.printStackTrace();
			}
			
		}
		
		if(action != null && action.equals("toLogin")){
			String sku = request.getParameter("sku");
			request.getSession().setAttribute("FROMSKU", sku);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}

}
