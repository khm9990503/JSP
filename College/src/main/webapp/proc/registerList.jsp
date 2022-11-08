<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.college.bean.RegisterBean"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.co.college.db.DBCP"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String regstdno = request.getParameter("regstdno");
	List<RegisterBean> rbs = null;
	try{
		Connection conn = DBCP.getConnection();
		String sql = "SELECT a.*, b.stdname, c.lecname FROM `register` AS a ";
				sql +="JOIN `student` AS b ";
				sql +="ON a.regstdno = b.stdno ";
				sql +="JOIN `lecture` AS c ";
				sql +="ON a.reglecno = c.lecno ";
				sql +="WHERE `regstdno`=?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, regstdno);
		ResultSet rs = psmt.executeQuery();
		rbs = new ArrayList<>();
		while(rs.next()){
			RegisterBean rb = new RegisterBean();
			rb.setRegstdno(rs.getString(1));
			rb.setReglecno(rs.getInt(2));
			rb.setRegmidscore(rs.getInt(3));
			rb.setRegfinalscore(rs.getInt(4));
			rb.setRegtotalscore(rs.getInt(5));
			rb.setReggrade(rs.getString(6));
			rb.setStdname(rs.getString(7));
			rb.setLecname(rs.getString(8));
			
			rbs.add(rb);
		}
				
		rs.close();
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}

	// Gson 라이브러리 함수를 이용해 List를 Json으로 변환
		Gson gson = new Gson();
		String jsonData = gson.toJson(rbs);
		
		
		// Json 데이터 출력
		out.print(jsonData);
%>