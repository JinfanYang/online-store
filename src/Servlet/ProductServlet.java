package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import BusinessLogic.ProductLogic;
import java.util.Calendar;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/Product")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductServlet() {
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
		response.setContentType("UTF-8");
		ProductLogic svc = new ProductLogic();
		String action = request.getParameter("action");
		if(action != null && action.equals("detail")){
			String sku = request.getParameter("SKU");
			try {
				Entity.Product product = svc.findBySKU(sku);
				List<Integer> sizes = svc.findSize(product.getPId());
				List<String> colors = svc.findColor(product.getPId());
				if (product != null){
					request.getSession().setAttribute("PRODUCT", product);
					request.getSession().setAttribute("SIZE", sizes);
					request.getSession().setAttribute("COLOR", colors);
					request.getRequestDispatcher("details.jsp").forward(request, response);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(action != null && action.equals("mcatalog")){
			PrintWriter out = response.getWriter();
			String genderstr = request.getParameter("gender");
			int gender;
			if(genderstr.equals("women")){
				gender = 1;
			}
			else if(genderstr.equals("men")){
				gender = 0;
			}
			else{
				gender = 2;
			}
			String[] ks;
			String[] bs;
			String kinds = request.getParameter("kinds");
			if(kinds != "")
			{
				ks = kinds.split("/");
			}
			else{
				ks = new String[]{"",""};
			}
			
			String brands = request.getParameter("brands");
			if(brands != "")
			{
				bs = brands.split("/");
			}
			else{
				bs = new String[]{"",""};
			}
			try{
				List<Entity.Product> products = svc.find(gender, ks, bs);
				out.write("<div class='col-md-9 w_content'>");
				out.write("<div class='women'>");
				out.write("<a href='#'><h4>");
				for(int i = 1; i< ks.length; i++){
					out.write(" "+ks[i]);
				}
				for(int i = 1; i<bs.length; i++){
					out.write(" "+bs[i]);
				}
				out.write(" - <span>"+products.size()+" items</span> </h4></a>");
				out.write("<div class='clearfix'></div></div>");
				if(products != null && products.size()>0){
					for(int i =0; i<products.size(); i++){
						if(i%4 == 0 ){
							out.write("<div class='grids_of_4'>");
						}
						out.write("<div class='grid1_of_4'>");
						out.write("<div class='content_box'><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahrefimg'>");
						out.write("<img src='images/"+products.get(i).getPPics().get(0)+"' class='img-responsive' alt='' id='imgsrc'/></a>");
						out.write("<h4><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahref'>"+products.get(i).getPName()+"</a></h4>");
						out.write("<div class='grid_1 simpleCart_shelfItem'>");
						out.write("<div class='item_add'><span class='item_price'><h6 id='price'>ONLY "+products.get(i).getPPrice()+"</h6></span></div>");
						out.write("</div></div></div>");
						if(i%4 == 0 && i/4 > 1){
							out.print("<div class='clearfix'></div></div>");
						}
					}
				}
				out.write("</div>");
			}catch(Exception e){
				e.printStackTrace();
			}
			finally{
				out.close();
			}
		}
		
		if(action != null && action.equals("mnew")){
			PrintWriter out = response.getWriter();
			String[] ks;
			String[] bs;
			String kinds = request.getParameter("kinds");
			if(kinds != "")
			{
				ks = kinds.split("/");
			}
			else{
				ks = new String[]{"",""};
			}
			
			String brands = request.getParameter("brands");
			if(brands != "")
			{
				bs = brands.split("/");
			}
			else{
				bs = new String[]{"",""};
			}

			try{
				List<Entity.Product> products = svc.findNew(ks, bs);
				out.write("<div class='col-md-9 w_content'>");
				out.write("<div class='women'>");
				out.write("<a href='#'><h4>");
				for(int i = 1; i< ks.length; i++){
					out.write(" "+ks[i]);
				}
				for(int i = 1; i<bs.length; i++){
					out.write(" "+bs[i]);
				}
				out.write(" - <span>"+products.size()+" items</span> </h4></a>");
				out.write("<div class='clearfix'></div></div>");
				if(products != null && products.size()>0){
					for(int i =0; i<products.size(); i++){
						if(i%4 == 0 ){
							out.write("<div class='grids_of_4'>");
						}
						out.write("<div class='grid1_of_4'>");
						out.write("<div class='content_box'><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahrefimg'>");
						out.write("<img src='images/"+products.get(i).getPPics().get(0)+"' class='img-responsive' alt='' id='imgsrc'/></a>");
						out.write("<h4><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahref'>"+products.get(i).getPName()+"</a></h4>");
						out.write("<div class='grid_1 simpleCart_shelfItem'>");
						out.write("<div class='item_add'><span class='item_price'><h6 id='price'>ONLY "+products.get(i).getPPrice()+"</h6></span></div>");
						out.write("</div></div></div>");
						if(i%4 == 0 && i/4 > 1){
							out.print("<div class='clearfix'></div></div>");
						}
					}
				}
				out.write("</div>");
			}catch(Exception e){
				e.printStackTrace();
			}
			finally{
				out.close();
			}
		}
		
		if(action != null && action.equals("msale")){
			PrintWriter out = response.getWriter();
			String[] ks;
			String[] bs;
			String kinds = request.getParameter("kinds");
			if(kinds != "")
			{
				ks = kinds.split("/");
			}
			else{
				ks = new String[]{"",""};
			}
			
			String brands = request.getParameter("brands");
			if(brands != "")
			{
				bs = brands.split("/");
			}
			else{
				bs = new String[]{"",""};
			}

			try{
				List<Entity.Product> products = svc.findSale(ks, bs);
				out.write("<div class='col-md-9 w_content'>");
				out.write("<div class='women'>");
				out.write("<a href='#'><h4>");
				for(int i = 1; i< ks.length; i++){
					out.write(" "+ks[i]);
				}
				for(int i = 1; i<bs.length; i++){
					out.write(" "+bs[i]);
				}
				out.write(" - <span>"+products.size()+" items</span> </h4></a>");
				out.write("<div class='clearfix'></div></div>");
				if(products != null && products.size()>0){
					for(int i =0; i<products.size(); i++){
						if(i%4 == 0 ){
							out.write("<div class='grids_of_4'>");
						}
						out.write("<div class='grid1_of_4'>");
						out.write("<div class='content_box'><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahrefimg'>");
						out.write("<img src='images/"+products.get(i).getPPics().get(0)+"' class='img-responsive' alt='' id='imgsrc'/></a>");
						out.write("<h4><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahref'>"+products.get(i).getPName()+"</a></h4>");
						out.write("<div class='grid_1 simpleCart_shelfItem'>");
						out.write("<div class='item_add'><span class='item_price'><h6 id='price'>ONLY "+products.get(i).getPPrice()+"</h6></span></div>");
						out.write("</div></div></div>");
						if(i%4 == 0 && i/4 > 1){
							out.print("<div class='clearfix'></div></div>");
						}
					}
				}
				out.write("</div>");
			}catch(Exception e){
				e.printStackTrace();
			}
			finally{
				out.close();
			}
		}
		
		if(action != null && action.equals("all")){
			PrintWriter out = response.getWriter();
			String kinds = request.getParameter("kinds");
			String[] ks;
			String[] bs;
			
			if(kinds != "")
			{
				ks = kinds.split("/");
			}
			else{
				ks = new String[]{"",""};
			}
			
			String brands = request.getParameter("brands");
			if(brands != "")
			{
				bs = brands.split("/");
			}
			else{
				bs = new String[]{"",""};
			}
			
			try{
				List<Entity.Product> products = svc.findAll(ks, bs);
				out.write("<div class='col-md-9 w_content'>");
				out.write("<div class='women'>");
				out.write("<a href='#'><h4>");
				for(int i = 1; i< ks.length; i++){
					out.write(" "+ks[i]);
				}
				for(int i = 1; i<bs.length; i++){
					out.write(" "+bs[i]);
				}
				out.write(" - <span>"+products.size()+" items</span> </h4></a>");
				out.write("<div class='clearfix'></div></div>");
				if(products != null && products.size()>0){
					for(int i =0; i<products.size(); i++){
						if(i%4 == 0 ){
							out.write("<div class='grids_of_4'>");
						}
						out.write("<div class='grid1_of_4'>");
						out.write("<div class='content_box'><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahrefimg'>");
						out.write("<img src='images/"+products.get(i).getPPics().get(0)+"' class='img-responsive' alt='' id='imgsrc'/></a>");
						out.write("<h4><a href='Product?action=detail&SKU="+products.get(i).getSKU()+"' id='ahref'>"+products.get(i).getPName()+"</a></h4>");
						out.write("<div class='grid_1 simpleCart_shelfItem'>");
						out.write("<div class='item_add'><span class='item_price'><h6 id='price'>ONLY "+products.get(i).getPPrice()+"</h6></span></div>");
						out.write("</div></div></div>");
						if(i%4 == 0 && i/4 > 1){
							out.print("<div class='clearfix'></div></div></div>");
						}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
			finally{
				out.close();
			}
		}
		
		if(action != null && action.equals("catalog")){
			String genderstr;
			String gender = request.getParameter("gender");
			String kindid = request.getParameter("kindid");
			String kind = request.getParameter("kind");
			String ckind = request.getParameter("kcheckbox");
			String cbrand = request.getParameter("bcheckbox");
			if(gender != null)
			{
				if(gender.equals("0")){
					genderstr="male";
				}
				else if(gender.equals("1")){
					genderstr="female";
				}
				else{
					genderstr="kid";
				}
				if(kindid != null){
					try{
						List<Entity.Product> products = svc.find(gender, kindid);
						if(!products.isEmpty()){
							request.getSession().setAttribute("PRODUCTS", products);
							request.getSession().setAttribute("KIND", genderstr+" "+kind);
							request.getRequestDispatcher("catalog.jsp").forward(request, response);
						}
						else{
							request.getSession().setAttribute("PRODUCTS", null);
							request.getSession().setAttribute("KIND", genderstr+" "+kind);
							request.getRequestDispatcher("catalog.jsp").forward(request, response);
						}
						
					}catch(Exception e){
						e.printStackTrace();
					}
				}
				else if(ckind != null || cbrand != null){
					if(ckind == null){
						try{
							List<Entity.Product> products = svc.findByBrand(gender, cbrand);
							if(!products.isEmpty()){
								request.getSession().setAttribute("PRODUCTS", products);
								request.getSession().setAttribute("KIND", genderstr +" "+cbrand);
								request.getRequestDispatcher("catalog.jsp").forward(request, response);
							}
							else{
								request.getSession().setAttribute("PRODUCTS", null);
								request.getSession().setAttribute("KIND", genderstr +" "+cbrand);
								request.getRequestDispatcher("catalog.jsp").forward(request, response);
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					}
					else if(cbrand == null){
						try{
							List<Entity.Product> products = svc.findByKind(gender, ckind);
							if(!products.isEmpty()){
								request.getSession().setAttribute("PRODUCTS", products);
								request.getSession().setAttribute("KIND", genderstr+" "+ckind);
								request.getRequestDispatcher("catalog.jsp").forward(request, response);
							}
							else{
								request.getSession().setAttribute("PRODUCTS", null);
								request.getSession().setAttribute("KIND", genderstr+" "+ckind);
								request.getRequestDispatcher("catalog.jsp").forward(request, response);
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					}
					else{
						try{
							List<Entity.Product> products = svc.findByKB(gender, ckind, cbrand);
							if(!products.isEmpty()){
								request.getSession().setAttribute("PRODUCTS", products);
								request.getSession().setAttribute("KIND", genderstr+" "+ckind+" "+cbrand);
								request.getRequestDispatcher("catalog.jsp").forward(request, response);
							}
							else{
								request.getSession().setAttribute("PRODUCTS", null);
								request.getSession().setAttribute("KIND", genderstr+" "+ckind+" "+cbrand);
								request.getRequestDispatcher("catalog.jsp").forward(request, response);
							}
						}catch(Exception e){
							e.printStackTrace();
						}
					}
				}
				
			}
			else{
				try{
					List<Entity.Product> products = svc.findByKind(kind);
					if(!products.isEmpty()){
						request.getSession().setAttribute("PRODUCTS", products);
						request.getSession().setAttribute("KIND", kind);
						request.getRequestDispatcher("catalog.jsp").forward(request, response);
					}
					else{
						request.getSession().setAttribute("PRODUCTS", null);
						request.getSession().setAttribute("KIND", kind);
						request.getRequestDispatcher("catalog.jsp").forward(request, response);
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		if(action != null && action.equals("new")){
			String gender = request.getParameter("gender");
			String kindid = request.getParameter("kindid");
			String ckind = request.getParameter("kcheckbox");
			String cbrand = request.getParameter("bcheckbox");
			if(gender != null && kindid != null)
			{
				try{
					List<Entity.Product> products = svc.findNew(gender, kindid);
					if(!products.isEmpty()){
						request.getSession().setAttribute("PRODUCTS", products);
						request.getSession().setAttribute("KIND", "New");
						request.getRequestDispatcher("catalog.jsp").forward(request, response);
					}
					else{
						request.getSession().setAttribute("PRODUCTS", null);
						request.getSession().setAttribute("KIND", "New");
						request.getRequestDispatcher("catalog.jsp").forward(request, response);
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			else if(ckind != null || cbrand != null)
			{
				if(ckind == null){
					try{
						List<Entity.Product> products = svc.findNewByKind(ckind);
						if(!products.isEmpty()){
							request.getSession().setAttribute("PRODUCTS", products);
							request.getSession().setAttribute("KIND", "New");
							request.getRequestDispatcher("catalog.jsp").forward(request, response);
						}
						else{
							request.getSession().setAttribute("PRODUCTS", null);
							request.getSession().setAttribute("KIND", "New");
							request.getRequestDispatcher("catalog.jsp").forward(request, response);
						}
					}catch(Exception e){
						e.printStackTrace();
					}
				}
				else if(cbrand == null){
					try{
						List<Entity.Product> products = svc.findNew(gender, kindid);
						if(!products.isEmpty()){
							request.getSession().setAttribute("PRODUCTS", products);
							request.getSession().setAttribute("KIND", "New");
							request.getRequestDispatcher("catalog.jsp").forward(request, response);
						}
						else{
							request.getSession().setAttribute("PRODUCTS", null);
							request.getSession().setAttribute("KIND", "New");
							request.getRequestDispatcher("catalog.jsp").forward(request, response);
						}
					}catch(Exception e){
						e.printStackTrace();
					}
				}
				else{
					try{
						List<Entity.Product> products = svc.findNew(gender, kindid);
						if(!products.isEmpty()){
							request.getSession().setAttribute("PRODUCTS", products);
							request.getSession().setAttribute("KIND", "New");
							request.getRequestDispatcher("catalog.jsp").forward(request, response);
						}
						else{
							request.getSession().setAttribute("PRODUCTS", null);
							request.getSession().setAttribute("KIND", "New");
							request.getRequestDispatcher("catalog.jsp").forward(request, response);
						}
					}catch(Exception e){
						e.printStackTrace();
					}
				}
				
			}
			else
			{
				try{
					List<Entity.Product> products = svc.findNew();
					if(!products.isEmpty()){
						request.getSession().setAttribute("PRODUCTS", products);
						request.getSession().setAttribute("KIND", "New");
						request.getRequestDispatcher("catalog.jsp").forward(request, response);
					}
					else{
						request.getSession().setAttribute("PRODUCTS", null);
						request.getSession().setAttribute("KIND", "New");
						request.getRequestDispatcher("catalog.jsp").forward(request, response);
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		if(action != null && action.equals("checkStorage")){
			PrintWriter out = response.getWriter();
			String pid = request.getParameter("pid");
			String sizestr = request.getParameter("size");
			String color = request.getParameter("color");
			int size;
			if(sizestr.equals("s")){
				size = 0;
			}
			else if(sizestr.equals("m")){
				size = 1;
			}
			else if(sizestr.equals("l")){
				size = 2;
			}
			else{
				size = 3;
			}
			try{
				out.write(svc.findStorage(pid, size, color));
			}catch(Exception e){
				e.printStackTrace();
			}
			finally{
				out.close();
			}
		}
		
		if(action != null && action.equals("findoneByPid")){
			PrintWriter out = response.getWriter();
			String pid = request.getParameter("pid");
			try {
				List<ArrayList<String>> products = svc.findoneByPid(pid);
				for(int i=0; i<products.size(); i++){
					out.write("<tr class='list-roles' >");
					out.write("<td><img src='images/"+products.get(i).get(12)+"' width=50px></td>");//image
					for(int j = 0; j<products.get(i).size()-1; j++){
						out.write("<td style='text-align:center;vertical-align:middle;'>"+products.get(i).get(j)+"</td>");
					}
					out.write("<td style='vertical-align:middle;'>");
					out.write("<div class='btn-group'>");
					out.write("<a class='btn btn-mini dropdown-toggle' data-toggle='dropdown' href='#'>Actions<span class='caret'></span></a>");
					out.write("<ul class='dropdown-menu pull-right'>");
					out.write("<li><a href='Product?action=findoneBySku&sku="+products.get(i).get(0)+"'><i class='icon-pencil'></i> Edit</a></li>");
					out.write("</ul></div></td></tr>");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally{
				out.close();
			}
		}
		
		if(action != null && action.equals("allinfo")){
			PrintWriter out = response.getWriter();
			List<ArrayList<String>> products;
			try {
				products = svc.findAllProducts();
				for(int i=0; i<products.size(); i++){
					out.write("<tr class='list-roles' >");
					out.write("<td><img src='images/"+products.get(i).get(12)+"' width=50px></td>");//image
					for(int j = 0; j<products.get(i).size()-1; j++){
						out.write("<td style='text-align:center;vertical-align:middle;'>"+products.get(i).get(j)+"</td>");
					}
					out.write("<td style='vertical-align:middle;'>");
					out.write("<div class='btn-group'>");
					out.write("<a class='btn btn-mini dropdown-toggle' data-toggle='dropdown' href='#'>Actions<span class='caret'></span></a>");
					out.write("<ul class='dropdown-menu pull-right'>");
					out.write("<li><a href='Product?action=findoneBySku&sku="+products.get(i).get(0)+"'><i class='icon-pencil'></i> Edit</a></li>");
					out.write("</ul></div></td></tr>");
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally{
				out.close();
			}
		}
		
		if(action != null && action.equals("add")){
			String pid = request.getParameter("pid");
			String name = request.getParameter("name");
			String gender = request.getParameter("gender");
			String kind = request.getParameter("kind");
			String brand = request.getParameter("brand");
			String size = request.getParameter("size");
			String color = request.getParameter("color");
			String price = request.getParameter("price");
			String discountprice = request.getParameter("discountprice");
			String storage = request.getParameter("storage");
			
			String bid = "";
			if(brand.length()==1){
				bid="00"+brand;
			}
			else if(brand.length() ==2){
				bid = "0" + brand;
			}
			else{
				bid = brand;
			}
			
			String kid = "";
			if(kind.length()==1){
				kid="00"+kind;
			}
			else if(kind.length() ==2){
				kid = "0" + kind;
			}
			else{
				kid = kind;
			}
			
			String sku ="";
			if(gender.equals("0")){
				sku = pid + bid + kid + "M" + size + color.charAt(0);
			}
			else if(gender.equals("1")){
				sku = pid + bid + kid + "F" + size + color.charAt(0);
			}
			else{
				sku = pid + bid + kid + "K" + size + color.charAt(0);
			}
			
			Entity.Product newproduct = new Entity.Product();
			newproduct.setPId(pid);
			newproduct.setSKU(sku);
			newproduct.setBId(Integer.parseInt(brand));
			newproduct.setKId(Integer.parseInt(kind));
			newproduct.setPName(name);
			newproduct.setPGender(Integer.parseInt(gender));
			newproduct.setPPrice(Double.parseDouble(price));
			newproduct.setPDiscountPrice(Double.parseDouble(discountprice));
			newproduct.setPSize(Integer.parseInt(size));
			newproduct.setPStorage(Integer.parseInt(storage));
			newproduct.setPInDate(new Date());
			newproduct.setPColor(color);
			
			String pic = request.getParameter("pic");
			ArrayList<String> pics = new ArrayList<String>();
			pics.add(pic);
			pics.add("");
			pics.add("");
			pics.add("");
			
			newproduct.setPPics(pics);
			
			int i = 0;
			try {
				i = svc.add(newproduct);
				if(i == 2){
					request.getRequestDispatcher("A_list_products.jsp").forward(request, response);
				}
				else{
					request.getRequestDispatcher("A_new_products.jsp").forward(request, response);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			 
			/*if(i == 2){
				SmartUpload mySmartUpload =new SmartUpload();
			    long file_size_max=4000000;
			    String fileName2="",ext="",testvar="";
			    String url="images/";      //Ӧ��֤�ڸ�Ŀ¼���д�Ŀ¼�Ĵ���
			    //��ʼ��
			    mySmartUpload.initialize(this.getServletConfig(),request,response);
			    try {
					mySmartUpload.upload();
				} 
			    catch (SmartUploadException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			    com.jspsmart.upload.File myFile = mySmartUpload. getFiles().getFile(0);
			    String myFileName=myFile. getFileName(); //ȡ�����ص��ļ����ļ���
		        int start=myFileName.indexOf('.');
		        myFileName=myFileName.substring(0,start);
		        ext= myFile. getFileExt();      //ȡ�ú�׺��
		        int file_size=myFile. getSize();     //ȡ���ļ��Ĵ�С 
		        String saveurl="";
		        if(file_size<file_size_max){
		        	String filename =myFileName;
		        	saveurl=request. getRealPath("/")+url;
		        	saveurl+=filename+"."+ext;          //����·��
		        try {
					myFile.saveAs(saveurl,mySmartUpload.SAVE_PHYSICAL);
				} 
		        catch (SmartUploadException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		        
		        request.getRequestDispatcher("A_list_product.jsp").forward(request, response);
			}
			else{
				request.getRequestDispatcher("A_list_product.jsp").forward(request, response);
			}*/
		}
		
		if(action != null && action.equals("save")){
			String sku = request.getParameter("sku");
			String name = request.getParameter("name");
			String pricestr = request.getParameter("price");
			String discountpricestr = request.getParameter("discountprice");
			String storagestr = request.getParameter("storage");
			
			double price = Double.parseDouble(pricestr);
			double discountprice = Double.parseDouble(discountpricestr);
			int storage = Integer.parseInt(storagestr);
			
			try {
				int count = svc.save(sku, name, price, discountprice, storage);
				if(count > 0){
					request.getRequestDispatcher("A_list_products.jsp").forward(request, response);
				}
				else{
					request.getRequestDispatcher("A_modify_product.jsp?sku="+sku).forward(request, response);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}

}
