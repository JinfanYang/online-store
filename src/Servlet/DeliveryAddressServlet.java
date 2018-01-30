package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import BusinessLogic.DeliveryAddressLogic;
import Entity.DeliveryAddress;

/**
 * Servlet implementation class DeliveryAddressServlet
 */
@WebServlet("/DeliveryAddress")
public class DeliveryAddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeliveryAddressServlet() {
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
		if(action != null && action.equals("add")){
			String name = request.getParameter("nametextbox");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");
			String uid = request.getParameter("uid");
			String product= request.getParameter("product");
			DeliveryAddressLogic svc = new DeliveryAddressLogic();
			Entity.DeliveryAddress aaddress = new DeliveryAddress();
			aaddress.setUId(Integer.parseInt(uid));
			aaddress.setDName(name);
			aaddress.setDPhone(phone);
			aaddress.setDAddress(address);
			try{
				int i = svc.addAddress(aaddress);
				if(i>0){
					request.getRequestDispatcher("order.jsp?userId="+uid+"&product="+product).forward(request, response);
				}
				else{
					request.getRequestDispatcher("addNewAddress.jsp").forward(request, response);
				}
				
			}catch (Exception e){
				e.printStackTrace();
			}
		}
		
	}

}
