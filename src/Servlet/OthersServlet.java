package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import BusinessLogic.BrandLogic;
import BusinessLogic.KindLogic;
/**
 * Servlet implementation class OthersServlet
 */
@WebServlet("/Others")
public class OthersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OthersServlet() {
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
		PrintWriter out = response.getWriter();
		if(action != null && action.equals("addbrand")){
			String brand = request.getParameter("brand");
			BrandLogic bl = new BrandLogic();
			try {
				int i = bl.add(brand);
				out.write(String.valueOf(i));
			}catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		if(action != null && action.equals("addkind")){
			String gender = request.getParameter("gender");
			String torb = request.getParameter("torb");
			String kind = request.getParameter("kind");
			KindLogic kl = new KindLogic();
			try {
				int i = kl.add(Integer.parseInt(gender), Integer.parseInt(torb), kind);
				out.write(String.valueOf(i));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		if(action != null && action.equals("getkind")){
			KindLogic kl = new KindLogic();
			String gender = request.getParameter("gender");
			if(gender.equals("0")){
				try {
					List<Entity.Kind> kinds = kl.findMKind();
					for(int i = 0; i<kinds.size(); i++){
						out.write("<option value='"+kinds.get(i).getKId()+"'>"+kinds.get(i).getKCatalog3()+"</option>");
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else if(gender.equals("1")){
				try {
					List<Entity.Kind> kinds = kl.findFKind();
					for(int i = 0; i<kinds.size(); i++){
						out.write("<option value='"+kinds.get(i).getKId()+"'>"+kinds.get(i).getKCatalog3()+"</option>");
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			else{
				try {
					List<Entity.Kind> kinds = kl.findKKind();
					for(int i = 0; i<kinds.size(); i++){
						out.write("<option value='"+kinds.get(i).getKId()+"'>"+kinds.get(i).getKCatalog3()+"</option>");
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
