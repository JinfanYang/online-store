package Servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.xml.internal.stream.Entity;

import BusinessLogic.CommentLogic;
import Entity.Comment;

/**
 * Servlet implementation class CommentServlet
 */
@WebServlet("/Comment")
public class CommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentServlet() {
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
		CommentLogic cml = new CommentLogic();
		int updatecount = 0;
		if(action != null && action.equals("add")){
			int itemnumber = Integer.parseInt(request.getParameter("itemnumber"));
			String oldoid = request.getParameter("hiddenoid");
			for(int i = 0; i<itemnumber; i++){
				String radioname = "commentradio"+String.valueOf(i);
				String commentname = "comment" + String.valueOf(i);
				String idname = "orderid" + String.valueOf(i);
				String oid = request.getParameter(idname);
				String star = request.getParameter(radioname);
				String comment = request.getParameter(commentname);
				Comment acomment = new Comment();
				acomment.setOId(oid);
				acomment.setCStar(Integer.parseInt(star));
				acomment.setCComment(comment);
				acomment.setUName((String)request.getSession().getAttribute("USERNAME"));
				try {
					updatecount += cml.addComment(acomment);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(updatecount > 0){
				request.getRequestDispatcher("myspace_index.jsp").forward(request, response);
			}
			else{
				request.getRequestDispatcher("myspace_comment.jsp?oid="+oldoid).forward(request, response);
			}
		}
	}

}
