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

import BusinessLogic.UserLogic;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/User")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
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
		String action = request.getParameter("action");
		if (action != null && action.equals("login")){
			String loginTextbox = request.getParameter("logintextbox");
			String password  = request.getParameter("password");

			if(request.getSession().getAttribute("FROMSKU") == null)
			{
				
				String type = request.getParameter("type");
				PrintWriter out = response.getWriter();
				Entity.User item = new Entity.User();
				if (loginTextbox != null && password != null){
					if (!loginTextbox.equals("") && !password.equals("")){
						if(loginTextbox.contains("@")){
							try{
								item = loginbyEmail(loginTextbox, password);
								if (item != null){
									request.getSession().setAttribute("ISLOGIN", "1");
									request.getSession().setAttribute("USERNAME", item.getUserName());
									request.getSession().setAttribute("USERID", item.getUserId());
									if(type != null){
										out.write(item.getUserName());
									}
									else{
										request.getRequestDispatcher("index.jsp").forward(request, response);
									}
								}
								else{
									response.sendRedirect("login.jsp");
								}
							}
							catch(Exception e){
								e.printStackTrace();
							}
						}
						else{
							try {
								item = loginbyName(loginTextbox, password);
								if (item != null){
									request.getSession().setAttribute("ISLOGIN", "1");
									request.getSession().setAttribute("USERNAME",item.getUserName());
									request.getSession().setAttribute("USERID",item.getUserId());
									if(type != null){
										out.write(item.getUserName());
									}
									else{
										request.getRequestDispatcher("index.jsp").forward(request, response);
									}
									
								}
								else{
									response.sendRedirect("login.jsp");
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					}
				}
			}
			else{
				String sku = (String)request.getSession().getAttribute("FROMSKU");
				Entity.User item = new Entity.User();
				Entity.Product product = new Entity.Product();
				BusinessLogic.ProductLogic svc = new BusinessLogic.ProductLogic();
				if (loginTextbox != null && password != null){
					if (!loginTextbox.equals("") && !password.equals("")){
						if(loginTextbox.contains("@")){
							try{
								item = loginbyEmail(loginTextbox, password);
								product = svc.findBySKU(sku);
								if (item != null){
									request.getSession().setAttribute("ISLOGIN", "1");
									request.getSession().setAttribute("USERNAME", item.getUserName());
									request.getSession().setAttribute("USERID", item.getUserId());
									request.getSession().setAttribute("PRODUCT", product);
									request.getRequestDispatcher("details.jsp").forward(request, response);
								}
								else{
									response.sendRedirect("login.jsp");
								}
							}
							catch(Exception e){
								e.printStackTrace();
							}
						}
						else{
							try {
								item = loginbyName(loginTextbox, password);
								product = svc.findBySKU(sku);
								if (item != null){
									request.getSession().setAttribute("ISLOGIN", "1");
									request.getSession().setAttribute("USERNAME",item.getUserName());
									request.getSession().setAttribute("USERID",item.getUserId());
									request.getSession().setAttribute("PRODUCT", product);
									request.getRequestDispatcher("details.jsp").forward(request, response);
								}
								else{
									response.sendRedirect("login.jsp");
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
					}
				}
			}

		}
		
		if(action != null && action.equals("logout")){
			request.getSession().setAttribute("ISLOGIN", "0");
			request.getSession().setAttribute("USERNAME",null);
			request.getSession().setAttribute("USERID",null);
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
		
		if(action != null && action.equals("checkUsername")){
			response.setContentType("text/html;charset=UTF-8");  
	        PrintWriter out = response.getWriter();
			String username = request.getParameter("rusername");
			UserLogic svc = new UserLogic();
			int i = 0;
			try {
				i = svc.query("SELECT * FROM users WHERE U_Name='"+username+"'");
				out.write(String.valueOf(i));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally{
				out.close();
			}
		}
		
		if(action != null && action.equals("checkEmail")){
			response.setContentType("text/html;charset=UTF-8");  
	        PrintWriter out = response.getWriter();
			String email = request.getParameter("remail");
			UserLogic svc = new UserLogic();
			int i = 0;
			try {
				i = svc.query("SELECT * FROM users WHERE Email='"+email+"'");
				out.write(String.valueOf(i));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally{
				out.close();
			}
		}
		
		if(action != null && action.equals("register")){
			Entity.User item = this.getUser(request);
			if (item != null){
				int i = this.Register(item);
				if(i>0){
					response.sendRedirect("login.jsp");
				}
			}
			
		}
		
		if(action != null && action.equals("save")){
			Entity.User item = this.getUser1(request);
			if (item != null){
				int i = this.Save(item);
				if(i>0){
					request.getSession().setAttribute("ISLOGIN", "0");
					request.getSession().setAttribute("USERNAME", null);
					request.getSession().setAttribute("USERID", null);
					request.getRequestDispatcher("login.jsp").forward(request, response);
				}
			}
			
		}
		
		if(action != null && action.equals("getPassword")){
			String uid = request.getParameter("uid");
			UserLogic svc = new UserLogic();
			PrintWriter out = response.getWriter();
			try {
				Entity.User auser = svc.findById(Integer.parseInt(uid));
				out.write(auser.getPassword());
			}catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	private Entity.User loginbyName(String userName, String password) throws Exception {
		UserLogic svc = new UserLogic();
		return svc.loginbyName(userName, password);
	}
	
	private Entity.User loginbyEmail(String email, String password) throws Exception {
		UserLogic svc = new UserLogic();
		return svc.loginbyEmail(email, password);
	}
	
	private int Register(Entity.User item){
		UserLogic svc = new UserLogic();
		int i = 0;
		try{
			i = svc.add(item);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return i;
	}
	
	private int Save(Entity.User item){
		UserLogic svc = new UserLogic();
		int i = 0;
		try{
			i = svc.save(item);
		}catch(Exception e){
			e.printStackTrace();
		}
		return i;
	}

	private Entity.User getUser(HttpServletRequest req){
		String username = req.getParameter("rusername");
		String password  = req.getParameter("rpassword1");
		String email = req.getParameter("remail");
		String phone = req.getParameter("rphone");
		
		String gender  = req.getParameter("rgender");
		
		Entity.User item = new Entity.User();
		
		item.setUserName(username);
		item.setPassword(password);
		item.setEmail(email);
		item.setPhone(phone);
		if(gender=="Male"){
			item.setGender(0);
		}
		else{
			item.setGender(1);
		}

		return item;
    }
	
	private Entity.User getUser1(HttpServletRequest req){
		String uid = req.getParameter("ruserid");
		String username = req.getParameter("rusername");
		String password  = req.getParameter("rpassword1");
		String email = req.getParameter("remail");
		String phone = req.getParameter("rphone");
		
		String gender  = req.getParameter("rgender");
		
		Entity.User item = new Entity.User();
		
		item.setUserId(Integer.parseInt(uid));
		item.setUserName(username);
		item.setPassword(password);
		item.setEmail(email);
		item.setPhone(phone);
		if(gender=="Male"){
			item.setGender(0);
		}
		else{
			item.setGender(1);
		}

		return item;
    }
}
