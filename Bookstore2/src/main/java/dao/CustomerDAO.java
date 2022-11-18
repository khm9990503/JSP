package dao;

import java.util.ArrayList;
import java.util.List;

import db.DBHelper;
import vo.CustomerVO;

public class CustomerDAO extends DBHelper{
	private static CustomerDAO instance = new CustomerDAO();
	public static CustomerDAO getInstance () {
		return instance;
	}
	private CustomerDAO () {}
	
	// 기본 CRUD
	
	public void insertCustomer(CustomerVO customer) {
		try{
			
			conn = getConnection();
			// 3단계
			String sql = "INSERT INTO `customer` VALUES (?,?,?,?)";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1,customer.getCusid());
			psmt.setString(2,customer.getName());
			psmt.setString(3,customer.getAddress());
			psmt.setString(4,customer.getPhone());
			
			// 4단계
			psmt.executeUpdate();
			// 5단계
			// 6단계
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	public CustomerVO selectCustomer(String cusid) {
		CustomerVO customer = null;
		try{
			conn = getConnection();
			stmt = conn.createStatement();
			String sql = "select * from `customer` where `cusid`='"+cusid+"'";
			rs = stmt.executeQuery(sql);
			customer = new CustomerVO();
			if(rs.next()){
				customer.setCusid(rs.getInt(1));
				customer.setName(rs.getString(2));
				customer.setAddress(rs.getString(3));
				customer.setPhone(rs.getString(4));
			}
			rs.close();
			stmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return customer;
	}
	public List<CustomerVO> selectCustomers() {
		List<CustomerVO> customers = null;
		try{
			conn = getConnection();
			stmt = conn.createStatement();
			String sql = "select * from `customer`";
			rs = stmt.executeQuery(sql);
			customers = new ArrayList<>();
			while(rs.next()){
				CustomerVO customer = new CustomerVO();
				customer.setCusid(rs.getInt(1));
				customer.setName(rs.getString(2));
				customer.setAddress(rs.getString(3));
				customer.setPhone(rs.getString(4));
				
				customers.add(customer);
			}
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return customers;
	}
	public void modifyCustomer(CustomerVO customer) {
		try{
			conn = getConnection();
			String sql = "UPDATE `customer` SET `name`=?, `address`=?, `phone`=? ";
		   		   sql+= "WHERE `cusid`=?";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1,customer.getName());
			psmt.setString(2,customer.getAddress());
			psmt.setString(3,customer.getPhone());
			psmt.setInt(4,customer.getCusid());
			
			psmt.executeUpdate();
			
			close();
		}catch(Exception e){
			e.printStackTrace();
		}	   
	}
	public void deleteCustomer(String cusid) {
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			stmt.executeUpdate("delete from `customer` where `cusid`='"+cusid+"'");
			
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
