package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Entity.Admin;
import BusinessLogic.AdminLogic;
import java.util.List;
import java.util.ArrayList;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet("/Admin")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminServlet() {
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
			String loginName = request.getParameter("loginName");
			String password  = request.getParameter("password");
			Entity.Admin admin = new Entity.Admin();
			BusinessLogic.AdminLogic al = new BusinessLogic.AdminLogic();
			try{
				admin = al.login(loginName, password);
				if (admin != null){
					request.getSession().setAttribute("ADMINISLOGIN", "1");
					request.getSession().setAttribute("ADMINNAME", admin.getAName());
					request.getSession().setAttribute("ADMINID", admin.getAId());
					request.getRequestDispatcher("A_index.jsp").forward(request, response);
				}
				else{
					response.sendRedirect("A_login.jsp");
				}
			}
			catch(Exception e){
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("changepassword")){
			int adminid = (int)request.getSession().getAttribute("ADMINID");
			String newpassword = request.getParameter("newpassword");
			AdminLogic al = new AdminLogic();
			try {
				al.changeps(newpassword, adminid);
				request.getRequestDispatcher("A_login.jsp").forward(request, response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("checkpassword")){
			PrintWriter out = response.getWriter();
			String checkpassword = request.getParameter("oldpassword");
			int adminid = (int)request.getSession().getAttribute("ADMINID");
			AdminLogic al = new AdminLogic();
			try {
				if(checkpassword.equals(al.findById(adminid))){
					out.write("1");
				}
				else{
					out.write("0");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		if(action != null && action.equals("logout")){
			request.getSession().setAttribute("ADMINISLOGIN", "0");
			request.getSession().setAttribute("ADMINNAME", null);
			request.getSession().setAttribute("ADMINID", null);
			request.getRequestDispatcher("A_login.jsp").forward(request, response);
		}
	}

}
