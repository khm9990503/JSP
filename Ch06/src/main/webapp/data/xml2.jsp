<%@page import="bean.UserBean"%>
<%@page import="config.DB"%>
<%@page import="org.jdom2.output.Format"%>
<%@page import="org.jdom2.output.XMLOutputter"%>
<%@page import="org.jdom2.Element"%>
<%@page import="org.jdom2.Document"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/xml;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	List<UserBean> userlist = new ArrayList<>();
	try{
		Connection conn = DB.getInstance().getConnection();
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM `user1`");
		while(rs.next()){
			UserBean ub = new UserBean();
			ub.setUid(rs.getString(1));
			ub.setName(rs.getString(2));
			ub.setHp(rs.getString(3));
			ub.setAge(rs.getInt(4));
			
			userlist.add(ub);
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// list -> xml
	Document doc = new Document();
	Element users = new Element("users");
	
	for(UserBean ub : userlist){
		Element user = new Element("user");
		Element uid = new Element("uid");
		Element name = new Element("name");
		Element hp = new Element("hp");
		Element age = new Element("age");
		
		uid.setText(ub.getUid());
		name.setText(ub.getName());
		hp.setText(ub.getHp());
		age.setText(""+ub.getAge()); // String.valueof
		
		user.addContent(uid);
		user.addContent(name);
		user.addContent(hp);
		user.addContent(age);
		
		users.addContent(user);
	}
	
	doc.setRootElement(users);
	
	// 출력
	
	XMLOutputter outPutter = new XMLOutputter(Format.getPrettyFormat());
	String xml = outPutter.outputString(doc);
	
	out.print(xml);
	
%>