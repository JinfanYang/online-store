package BusinessLogic;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dbUtil.DbHelper;
import dbUtil.IConnectionProvider;
import dbUtil.JdbcProvider;

import BusinessLogic.CartLogic;

public class ProductLogic {
	private IConnectionProvider connectionProvider = null;
	private String sourceName = "estore";
    private DbHelper dbHelper;
    public ProductLogic(){
		try {
	        connectionProvider = new JdbcProvider(
	                "com.mysql.jdbc.Driver",
	                "jdbc:mysql://127.0.0.1:3306/",
	                "root","123456");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }
		dbHelper = new DbHelper(connectionProvider, sourceName);
    }
    
    //增
    public int add(Entity.Product item) throws Exception {
    	ArrayList<String> temp = item.getPPics();
    	int i= 0, j=0;
		i = dbHelper.insertPrepareSQL(
				"INSERT INTO products(P_Id, SKU, B_Id, K_Id, P_Name, P_Gender, P_Price, P_DiscountPrice, P_Size, P_Storage, P_InDate, P_Color, P_Memo) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)",
				item.getPId(),
				item.getSKU(),
				item.getBId(),
				item.getKId(),
				item.getPName(),
				item.getPGender(),
				item.getPPrice(),
				item.getPDiscountPrice(),
				item.getPSize(),
				item.getPStorage(),
				item.getPInDate(),
				item.getPColor(),
				item.getPMemo());
		
		String sql = "SELECT * FROM productspic WHERE P_Id = ?";
		ResultSet rs = dbHelper.query(sql, item.getPId());
		if(! rs.next())
		{
			j = dbHelper.insertPrepareSQL("INSERT INTO productspic(P_Id, Pic1, Pic2, Pic3, Pic4) values(?,?,?,?,?)",
					item.getPId(),
					temp.get(0),
					temp.get(1),
					temp.get(2),
					temp.get(3));
		}
		
		return i+j;
	}
    
    //删
    public void remove(int sku) throws Exception{
		String sql = "DELETE FROM products WHERE SKU=?";
		dbHelper.updatePrepareSQL(sql, sku);
	}
    
    //改
    public int save(String sku, String name, double price, double discountprice, int storage) throws SQLException {
		return dbHelper.updatePrepareSQL(
				"UPDATE products SET P_Name=?, P_Price=?, P_DiscountPrice=?, P_Storage=? WHERE SKU=?",
				name,
				price,
				discountprice,
				storage,
				sku);
	}
    
    //查size
    public List<Integer> findSize(String PId) throws Exception{
    	String sql = "SELECT DISTINCT P_Size FROM products WHERE P_Id = ?";
    	ResultSet rs = dbHelper.query(sql, PId);
    	List<Integer> sizes = new ArrayList<Integer>();
    	while(rs.next()){
    		sizes.add(rs.getInt(1));
    	}
    	return sizes;
    }
    
    //每个size下的订单数
    public int countsize(String PId, int size) throws Exception{
    	int count = 0;
    	String sql = "SELECT COUNT(*) FROM products, orders WHERE products.SKU = orders.SKU AND products.P_Id=? AND products.P_Size = ? ";
    	ResultSet rs = dbHelper.query(sql, PId, size);
    	if(rs.next()){
    		count =rs.getInt(1);
    	}
    	return count;
    }
    
    //查color
    public List<String> findColor(String PId) throws Exception{
    	String sql = "SELECT DISTINCT P_Color FROM products WHERE P_Id = ?";
    	ResultSet rs = dbHelper.query(sql, PId);
    	List<String> colors = new ArrayList<String>();
    	while(rs.next()){
    		colors.add(rs.getString(1));
    	}
    	return colors;
    }
    
    //查每个color下的订单数
    public int countcolor(String PId, String color) throws Exception{
    	int count = 0;
    	String sql = "SELECT COUNT(*) FROM products, orders WHERE products.SKU = orders.SKU AND products.P_Id=? AND products.P_Color = ? ";
    	ResultSet rs = dbHelper.query(sql, PId, color);
    	if(rs.next()){
    		count =rs.getInt(1);
    	}
    	return count;
    }
    
    //查storage
    public String findStorage(String pid, int size, String color) throws Exception{
    	String value=",";
    	String sql = "SELECT SKU, P_Storage FROM products WHERE P_Id=? AND P_Size=? AND P_Color=?";
    	ResultSet rs = dbHelper.query(sql, pid, size, color);
    	if(rs.next()){
    		value = rs.getString(1)+","+rs.getInt(2);
    	}
    	return value;
    }
	
    //查一个
	public Entity.Product findBySKU(String sku) throws Exception{
		String sql = "SELECT * FROM products WHERE SKU=?";
		ResultSet rs = dbHelper.findById(sql, sku);
		if (rs.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs.getString(1));
			item.setSKU(rs.getString(2));
			item.setBId(rs.getInt(3));
			item.setKId(rs.getInt(4));
			item.setPName(rs.getString(5));
			item.setPGender(rs.getInt(6));
			item.setPPrice(rs.getDouble(7));
			item.setPDiscountPrice(rs.getDouble(8));
			item.setPSize(rs.getInt(9));
			item.setPStorage(rs.getInt(10));
			item.setPInDate(rs.getDate(11));
			item.setPColor(rs.getString(12));
			item.setPMemo(rs.getString(13));
			
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			rs = dbHelper.findById(sql, item.getPId());
			if(rs.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs.getString(2));
				temp.add(rs.getString(3));
				temp.add(rs.getString(4));
				temp.add(rs.getString(5));
				item.setPPics(temp);
			}
			
			return item;
		}
		else
			return null;
	}
	
	//查特价
	public List<Entity.Product> findSpecial() throws Exception{
		String sql = "SELECT * FROM products WHERE P_DiscountPrice != '' GROUP BY P_Id";
		ResultSet rs1 = dbHelper.query(sql);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
			
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}
			
			items.add(item);
		}
		
		return items;
	}
	
	//按类别查
	public List<Entity.Product> findByKind(String kind) throws Exception{
		String sql = "SELECT * FROM products,kinds WHERE products.K_Id=kinds.K_Id AND kinds.K_Catalog3=? GROUP BY products.P_Id";
		ResultSet rs1 = dbHelper.query(sql, kind);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
			
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}
			
			items.add(item);
		}
		
		return items;
	}
	
	//按gender&kindid查
	public List<Entity.Product> find(String genderstr, String kindidstr) throws Exception{
		int gender = Integer.parseInt(genderstr);
		int kindid = Integer.parseInt(kindidstr);
		String sql = "SELECT * FROM products WHERE K_Id=? AND P_Gender=? GROUP BY products.P_Id";
		ResultSet rs1 = dbHelper.query(sql, kindid, gender);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
				
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}	
			items.add(item);
		}
		return items;
	}
		
	//按gender&kind查
	public List<Entity.Product> findByKind(String genderstr, String kind) throws Exception{
		int gender = Integer.parseInt(genderstr);
		String sql = "SELECT * FROM products,kinds WHERE products.K_Id=kinds.K_Id AND products.P_Gender=? AND kinds.K_Catalog3=? GROUP BY products.P_Id";
		ResultSet rs1 = dbHelper.query(sql, gender, kind);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
						
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}				
			items.add(item);
		}				
		return items;
	}
	
	//按gender&brand查
	public List<Entity.Product> findByBrand(String genderstr, String brand) throws Exception{
		int gender = Integer.parseInt(genderstr);
		String sql = "SELECT * FROM products,brands WHERE products.K_Id=kinds.K_Id AND products.P_Gender=? AND brands.B_Name=? GROUP BY products.P_Id";
		ResultSet rs1 = dbHelper.query(sql, gender, brand);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
						
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}				
			items.add(item);
		}				
		return items;
	}
				
	//按gender&kind&brand查
	public List<Entity.Product> findByKB(String genderstr, String kind, String brand) throws Exception{
		int gender = Integer.parseInt(genderstr);
		String sql = "SELECT * FROM products,kinds,brands WHERE products.K_Id=kinds.K_Id AND products.B_Id=brands.B_Id AND products.P_Gender=? AND kinds.K_Catalog3=? AND brands.B_Name=? GROUP BY products.P_Id";
		ResultSet rs1 = dbHelper.query(sql, gender, kind, brand);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
						
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}				
			items.add(item);
		}				
		return items;
	}
				
	//按gender&kind&brand查
	public List<Entity.Product> find(int gender, String[] kinds, String[] brands) throws Exception{
		String sql = "SELECT * FROM products,kinds,brands WHERE products.K_Id=kinds.K_Id AND products.B_Id=brands.B_Id AND products.P_Gender="+gender;
		for(int i=1; i<kinds.length; i++){
			if(i==1){
				if(!kinds[i].equals("")){
					sql = sql + " AND (kinds.K_Catalog3='"+kinds[i]+"'";
				}
			}
			else{
				sql = sql + " OR kinds.K_Catalog3='"+kinds[i]+"'";
			}
			if(i==kinds.length-1){
				if(!kinds[i].equals("")){
					sql = sql + ")";
				}
			}
		}
		
		for(int j=1; j<brands.length;j++){
			if(j==1){
				if(!brands[j].equals("")){
					sql = sql + " AND (brands.B_Name='"+brands[j]+"'";
				}
			}
			else{
				sql = sql + " OR brands.B_Name='"+brands[j]+"'";
			}
			if(j==brands.length-1){
				if(!brands[j].equals("")){
					sql = sql + ") GROUP BY products.P_Id";
				}
				else{
					sql = sql + " GROUP BY products.P_Id";
				}
			}
		}
		
		ResultSet rs1 = dbHelper.query(sql);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
						
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}				
			items.add(item);
		}				
		return items;
	}
				
	//根据filter查找所有符合项		
	public List<Entity.Product> findAll(String[] kinds, String[] brands) throws Exception{
		String sql = "SELECT * FROM products,kinds,brands WHERE products.K_Id=kinds.K_Id AND products.B_Id=brands.B_Id ";
		for(int i=1; i<kinds.length; i++){
			if(i==1){
				if(!kinds[i].equals("")){
					sql = sql + "AND (kinds.K_Catalog3='"+kinds[i]+"'";
				}
			}
			else{
				sql = sql + " OR kinds.K_Catalog3='"+kinds[i]+"'";
			}
			if(i==kinds.length-1){
				if(!kinds[i].equals("")){
					sql = sql + ")";
				}
			}
		}
		
		for(int j=1; j<brands.length;j++){
			if(j==1){
				if(!brands[j].equals("")){
					sql = sql + " AND (brands.B_Name='"+brands[j]+"'";
				}
			}
			else{
				sql = sql + " OR brands.B_Name='"+brands[j]+"'";
			}
			if(j==brands.length-1){
				if(!brands[j].equals("")){
					sql = sql + ") GROUP BY products.P_Id";
				}
				else{
					sql = sql + " GROUP BY products.P_Id";
				}
			}
		}
					
		ResultSet rs1 = dbHelper.query(sql);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
						
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}				
			items.add(item);
		}				
		return items;
	}
			
	//根据filter查找所有新的商品
	public List<Entity.Product> findNew(String[] kinds, String[] brands) throws Exception{
		String sql = "SELECT * FROM products,kinds,brands WHERE products.K_Id=kinds.K_Id AND products.B_Id=brands.B_Id";
		for(int i=1; i<kinds.length; i++){
			if(i==1){
				if(!kinds[i].equals("")){
					sql = sql + " AND (kinds.K_Catalog3='"+kinds[i]+"'";
				}
			}
			else{
				sql = sql + " OR kinds.K_Catalog3='"+kinds[i]+"'";
			}
			if(i==kinds.length-1){
				if(!kinds[i].equals("")){
					sql = sql + ")";
				}
			}
		}
					
		for(int j=1; j<brands.length;j++){
			if(j==1){
				if(!brands[j].equals("")){
					sql = sql + " AND (brands.B_Name='"+brands[j]+"'";
				}
			}
			else{
				sql = sql + " OR brands.B_Name='"+brands[j]+"'";
			}
			if(j==brands.length-1){
				if(!brands[j].equals("")){
					sql = sql + ") GROUP BY products.P_Id ORDER BY P_InDate DESC";
				}
				else{
					sql = sql + " GROUP BY products.P_Id ORDER BY P_InDate DESC";
				}
			}
		}
					
		ResultSet rs1 = dbHelper.query(sql);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
						
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}				
			items.add(item);
		}				
		return items;
	}
				
	//根据filter查找所有特价商品
	public List<Entity.Product> findSale(String[] kinds, String[] brands) throws Exception{
		String sql = "SELECT * FROM products,kinds,brands WHERE products.K_Id=kinds.K_Id AND products.B_Id=brands.B_Id AND P_DiscountPrice != ''";
		for(int i=1; i<kinds.length; i++){
			if(i==1){
				if(!kinds[i].equals("")){
					sql = sql + " AND (kinds.K_Catalog3='"+kinds[i]+"'";
				}
			}
			else{
				sql = sql + " OR kinds.K_Catalog3='"+kinds[i]+"'";
			}
			if(i==kinds.length-1){
				if(!kinds[i].equals("")){
					sql = sql + ")";
				}
			}
		}
					
		for(int j=1; j<brands.length;j++){
			if(j==1){
				if(!brands[j].equals("")){
					sql = sql + " AND (brands.B_Name='"+brands[j]+"'";
				}
			}
			else{
				sql = sql + " OR brands.B_Name='"+brands[j]+"'";
			}
			if(j==brands.length-1){
				if(!brands[j].equals("")){
					sql = sql + ") GROUP BY products.P_Id";
				}
				else{
					sql = sql + " GROUP BY products.P_Id";
				}
			}
		}
					
		ResultSet rs1 = dbHelper.query(sql);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
						
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}				
			items.add(item);
		}				
		return items;
	}
				
	//查最新
	public List<Entity.Product> findNew() throws Exception{
		String sql = "SELECT * FROM products GROUP BY P_Id ORDER BY P_InDate DESC";
		ResultSet rs1 = dbHelper.query(sql);
		int count=0;
		List<Entity.Product> items = new ArrayList<Entity.Product>();
			while (rs1.next()){
				if(count < 5){
					Entity.Product item = new Entity.Product();
					item.setPId(rs1.getString(1));
					item.setSKU(rs1.getString(2));
					item.setBId(rs1.getInt(3));
					item.setKId(rs1.getInt(4));
					item.setPName(rs1.getString(5));
					item.setPGender(rs1.getInt(6));
					item.setPPrice(rs1.getDouble(7));
					item.setPDiscountPrice(rs1.getDouble(8));
					item.setPSize(rs1.getInt(9));
					item.setPStorage(rs1.getInt(10));
					item.setPInDate(rs1.getDate(11));
					item.setPColor(rs1.getString(12));
					item.setPMemo(rs1.getString(13));
					
					sql = "SELECT * FROM productspic WHERE P_Id=?";
					ResultSet rs2 = dbHelper.findById(sql, item.getPId());
					if(rs2.next()){
						ArrayList<String> temp = new ArrayList<String>();
						temp.add(rs2.getString(2));
						temp.add(rs2.getString(3));
						temp.add(rs2.getString(4));
						temp.add(rs2.getString(5));
						item.setPPics(temp);
					}
					
					items.add(item);
					count++;
				}
				else{
					break;
				}
			}
			return items;
	}
	
	//根据gender&kindid查最新
	public List<Entity.Product> findNew(String genderstr, String kindidstr) throws Exception{
		int gender = Integer.parseInt(genderstr);
		int kindid = Integer.parseInt(kindidstr);
		String sql = "SELECT * FROM products WHERE P_Gender=? AND K_Id = ? GROUP BY P_Id ORDER BY P_InDate DESC";
		ResultSet rs1 = dbHelper.query(sql, gender, kindid);
		int count=0;
		List<Entity.Product> items = new ArrayList<Entity.Product>();
			while (rs1.next()){
				if(count < 5){
					Entity.Product item = new Entity.Product();
					item.setPId(rs1.getString(1));
					item.setSKU(rs1.getString(2));
					item.setBId(rs1.getInt(3));
					item.setKId(rs1.getInt(4));
					item.setPName(rs1.getString(5));
					item.setPGender(rs1.getInt(6));
					item.setPPrice(rs1.getDouble(7));
					item.setPDiscountPrice(rs1.getDouble(8));
					item.setPSize(rs1.getInt(9));
					item.setPStorage(rs1.getInt(10));
					item.setPInDate(rs1.getDate(11));
					item.setPColor(rs1.getString(12));
					item.setPMemo(rs1.getString(13));
					
					sql = "SELECT * FROM productspic WHERE P_Id=?";
					ResultSet rs2 = dbHelper.findById(sql, item.getPId());
					if(rs2.next()){
						ArrayList<String> temp = new ArrayList<String>();
						temp.add(rs2.getString(2));
						temp.add(rs2.getString(3));
						temp.add(rs2.getString(4));
						temp.add(rs2.getString(5));
						item.setPPics(temp);
					}
					
					items.add(item);
					count++;
				}
				else{
					break;
				}
			}
			
			return items;
	}
	
	//根据kind查最新
	public List<Entity.Product> findNewByKind(String kind) throws Exception{
		String sql = "SELECT * FROM products,kinds WHERE products.K_Id=kinds.K_Id AND kinds.K_Catalog3=? GROUP BY P_Id ORDER BY P_InDate DESC";
		ResultSet rs1 = dbHelper.query(sql, kind);
		int count=0;
		List<Entity.Product> items = new ArrayList<Entity.Product>();
			while (rs1.next()){
				if(count < 5){
					Entity.Product item = new Entity.Product();
					item.setPId(rs1.getString(1));
					item.setSKU(rs1.getString(2));
					item.setBId(rs1.getInt(3));
					item.setKId(rs1.getInt(4));
					item.setPName(rs1.getString(5));
					item.setPGender(rs1.getInt(6));
					item.setPPrice(rs1.getDouble(7));
					item.setPDiscountPrice(rs1.getDouble(8));
					item.setPSize(rs1.getInt(9));
					item.setPStorage(rs1.getInt(10));
					item.setPInDate(rs1.getDate(11));
					item.setPColor(rs1.getString(12));
					item.setPMemo(rs1.getString(13));
					
					sql = "SELECT * FROM productspic WHERE P_Id=?";
					ResultSet rs2 = dbHelper.findById(sql, item.getPId());
					if(rs2.next()){
						ArrayList<String> temp = new ArrayList<String>();
						temp.add(rs2.getString(2));
						temp.add(rs2.getString(3));
						temp.add(rs2.getString(4));
						temp.add(rs2.getString(5));
						item.setPPics(temp);
					}
					
					items.add(item);
					count++;
				}
				else{
					break;
				}
			}
			
			return items;
	}
	
	//根据brand查最新
	public List<Entity.Product> findNewByBrand(String brand) throws Exception{
		String sql = "SELECT * FROM products,brands WHERE products.B_Id=brands.B_Id AND brands.B_Name=? GROUP BY P_Id ORDER BY P_InDate DESC";
		ResultSet rs1 = dbHelper.query(sql, brand);
		int count=0;
		List<Entity.Product> items = new ArrayList<Entity.Product>();
			while (rs1.next()){
				if(count < 5){
					Entity.Product item = new Entity.Product();
					item.setPId(rs1.getString(1));
					item.setSKU(rs1.getString(2));
					item.setBId(rs1.getInt(3));
					item.setKId(rs1.getInt(4));
					item.setPName(rs1.getString(5));
					item.setPGender(rs1.getInt(6));
					item.setPPrice(rs1.getDouble(7));
					item.setPDiscountPrice(rs1.getDouble(8));
					item.setPSize(rs1.getInt(9));
					item.setPStorage(rs1.getInt(10));
					item.setPInDate(rs1.getDate(11));
					item.setPColor(rs1.getString(12));
					item.setPMemo(rs1.getString(13));
					
					sql = "SELECT * FROM productspic WHERE P_Id=?";
					ResultSet rs2 = dbHelper.findById(sql, item.getPId());
					if(rs2.next()){
						ArrayList<String> temp = new ArrayList<String>();
						temp.add(rs2.getString(2));
						temp.add(rs2.getString(3));
						temp.add(rs2.getString(4));
						temp.add(rs2.getString(5));
						item.setPPics(temp);
					}
					
					items.add(item);
					count++;
				}
				else{
					break;
				}
			}
			
			return items;
	}
	
	//根据kind&brand查最新
	public List<Entity.Product> findNewByKB(String kind, String brand) throws Exception{
		String sql = "SELECT * FROM products,kinds,brands WHERE products.K_Id=kinds.K_Id AND products.B_Id=brands.B_Id AND kinds.K_Catalog3=? AND brands.B_Name=? GROUP BY P_Id ORDER BY P_InDate DESC";
		ResultSet rs1 = dbHelper.query(sql, kind, brand);
		int count=0;
		List<Entity.Product> items = new ArrayList<Entity.Product>();
			while (rs1.next()){
				if(count < 5){
					Entity.Product item = new Entity.Product();
					item.setPId(rs1.getString(1));
					item.setSKU(rs1.getString(2));
					item.setBId(rs1.getInt(3));
					item.setKId(rs1.getInt(4));
					item.setPName(rs1.getString(5));
					item.setPGender(rs1.getInt(6));
					item.setPPrice(rs1.getDouble(7));
					item.setPDiscountPrice(rs1.getDouble(8));
					item.setPSize(rs1.getInt(9));
					item.setPStorage(rs1.getInt(10));
					item.setPInDate(rs1.getDate(11));
					item.setPColor(rs1.getString(12));
					item.setPMemo(rs1.getString(13));
					
					sql = "SELECT * FROM productspic WHERE P_Id=?";
					ResultSet rs2 = dbHelper.findById(sql, item.getPId());
					if(rs2.next()){
						ArrayList<String> temp = new ArrayList<String>();
						temp.add(rs2.getString(2));
						temp.add(rs2.getString(3));
						temp.add(rs2.getString(4));
						temp.add(rs2.getString(5));
						item.setPPics(temp);
					}
					
					items.add(item);
					count++;
				}
				else{
					break;
				}
			}
			
			return items;
	}
	
	//查全部根据PId
	public List<Entity.Product> findAll() throws Exception{
		String sql = "SELECT * FROM products GROUP BY P_Id";
		ResultSet rs1 = dbHelper.query(sql);
		List<Entity.Product> items = new ArrayList<Entity.Product>();
		while (rs1.next()){
			Entity.Product item = new Entity.Product();
			item.setPId(rs1.getString(1));
			item.setSKU(rs1.getString(2));
			item.setBId(rs1.getInt(3));
			item.setKId(rs1.getInt(4));
			item.setPName(rs1.getString(5));
			item.setPGender(rs1.getInt(6));
			item.setPPrice(rs1.getDouble(7));
			item.setPDiscountPrice(rs1.getDouble(8));
			item.setPSize(rs1.getInt(9));
			item.setPStorage(rs1.getInt(10));
			item.setPInDate(rs1.getDate(11));
			item.setPColor(rs1.getString(12));
			item.setPMemo(rs1.getString(13));
			
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, item.getPId());
			if(rs2.next()){
				ArrayList<String> temp = new ArrayList<String>();
				temp.add(rs2.getString(2));
				temp.add(rs2.getString(3));
				temp.add(rs2.getString(4));
				temp.add(rs2.getString(5));
				item.setPPics(temp);
			}
			
			items.add(item);
		}
		
		return items;
	}
	
	//查全部根据sku
	public List<ArrayList<String>> findAllProducts() throws Exception{
		String sql = "SELECT * FROM products,kinds,brands WHERE products.K_Id=kinds.K_Id AND products.B_Id=brands.B_Id";
		ResultSet rs1 = dbHelper.query(sql);
		List<ArrayList<String>> items = new ArrayList<ArrayList<String>>();
		while (rs1.next()){
			ArrayList<String> temp = new ArrayList<String>();
			temp.add(rs1.getString(2));//sku
			temp.add(rs1.getString(1));//pid
			temp.add(rs1.getString(5));//pname
			switch(rs1.getInt(6)){
			case 0: temp.add("Male");break;
			case 1 : temp.add("Female");break;
			case 2 : temp.add("Kid");break;
			}//gender
			temp.add(rs1.getString(17));//kind
			temp.add(rs1.getString(19));//brand
			temp.add(String.valueOf(rs1.getDouble(7)));//price
			temp.add(String.valueOf(rs1.getDouble(8)));//discountprice
			switch(rs1.getInt(9)){
				case 0: temp.add("S");break;
				case 1 : temp.add("M");break;
				case 2 : temp.add("L");break;
				case 3 : temp.add("XL");break;
			}//size
			temp.add(rs1.getString(12));//color
			temp.add(String.valueOf(rs1.getInt(10)));//storage
			temp.add(rs1.getDate(11).toString());//in date
			
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, rs1.getString(1));
			if(rs2.next()){
				temp.add(rs2.getString(2));
			}
			
			items.add(temp);
		}
		return items;
	}
	
	//查商品信息根据pid
	public List<ArrayList<String>> findoneByPid(String pid) throws Exception{
		String sql = "SELECT * FROM products,kinds,brands WHERE products.K_Id=kinds.K_Id AND products.B_Id=brands.B_Id AND products.P_Id=?";
		ResultSet rs1 = dbHelper.query(sql, pid);
		List<ArrayList<String>> items = new ArrayList<ArrayList<String>>();
		while (rs1.next()){
			ArrayList<String> temp = new ArrayList<String>();
			temp.add(rs1.getString(2));//sku
			temp.add(rs1.getString(1));//pid
			temp.add(rs1.getString(5));//pname
			switch(rs1.getInt(6)){
			case 0: temp.add("Male");break;
			case 1 : temp.add("Female");break;
			case 2 : temp.add("Kid");break;
			}//gender
			temp.add(rs1.getString(17));//kind
			temp.add(rs1.getString(19));//brand
			temp.add(String.valueOf(rs1.getDouble(7)));//price
			temp.add(String.valueOf(rs1.getDouble(8)));//discountprice
			switch(rs1.getInt(9)){
				case 0: temp.add("S");break;
				case 1 : temp.add("M");break;
				case 2 : temp.add("L");break;
				case 3 : temp.add("XL");break;
			}//size
			temp.add(rs1.getString(12));//color
			temp.add(String.valueOf(rs1.getInt(10)));//storage
			temp.add(rs1.getDate(11).toString());//in date
			
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, rs1.getString(1));
			if(rs2.next()){
				temp.add(rs2.getString(2));
			}
			
			items.add(temp);
		}
		return items;
	}
	
	//查所有商品信息根据sku
	public List<String> findoneBySku(String sku) throws Exception{
		String sql = "SELECT * FROM products,kinds,brands WHERE products.K_Id=kinds.K_Id AND products.B_Id=brands.B_Id AND products.SKU=?";
		ResultSet rs1 = dbHelper.query(sql, sku);
		List<String> item = new ArrayList<String>();
		if(rs1.next()){
			item.add(rs1.getString(2));//sku 0
			item.add(rs1.getString(1));//pid 1
			item.add(rs1.getString(5));//pname 2
			switch(rs1.getInt(6)){
			case 0: item.add("Male");break;
			case 1 : item.add("Female");break;
			case 2 : item.add("Kid");break;
			}//gender 3
			item.add(rs1.getString(17));//kind 4
			item.add(rs1.getString(19));//brand 5
			item.add(String.valueOf(rs1.getDouble(7)));//price 6
			item.add(String.valueOf(rs1.getDouble(8)));//discountprice 7
			switch(rs1.getInt(9)){
				case 0: item.add("S");break;
				case 1 : item.add("M");break;
				case 2 : item.add("L");break;
				case 3 : item.add("XL");break;
			}//size 8
			item.add(rs1.getString(12));//color 9
			item.add(String.valueOf(rs1.getInt(10)));//storage 10
			item.add(rs1.getDate(11).toString());//in date 11
			
			sql = "SELECT * FROM productspic WHERE P_Id=?";
			ResultSet rs2 = dbHelper.findById(sql, rs1.getString(1));
			if(rs2.next()){
				item.add(rs2.getString(2));
			}
		}
		return item;
	}
	
	
	
	//算一个list的product的总价
	public double getTotalPrice(List<Entity.Product> productList, int userId) throws Exception{
		double totalPrice = 0;
		for(int i = 0; i< productList.size(); i++){
			double price;
			int number;
			if(productList.get(i).getPDiscountPrice() > 0){
				price = productList.get(i).getPDiscountPrice();
			}
			else{
				price = productList.get(i).getPPrice();
			}
			
			CartLogic cl = new CartLogic();
			number = cl.getNumber(userId, productList.get(i).getSKU());
			
			totalPrice += price * number;
		}
		return totalPrice;
	}
	
	//查商品总数
	public int count() throws Exception{
		int count = 0;
		String sql = "SELECT COUNT(*) FROM products";
		ResultSet rs = dbHelper.query(sql);
		if(rs.next()){
			count = rs.getInt(1);
		}
		return count;
	}
	
	//查一个pid下的所有order
	public int countbypid(String pid) throws Exception{
		int count = 0;
		String sql = "SELECT COUNT(*) FROM products, orders WHERE products.SKU = orders.SKU AND products.P_Id=?";
		ResultSet rs = dbHelper.query(sql, pid);
		if(rs.next()){
			count = rs.getInt(1);
		}
		return count;
	}

}

