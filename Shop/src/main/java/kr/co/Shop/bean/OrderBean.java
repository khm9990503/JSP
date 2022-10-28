package kr.co.Shop.bean;

public class OrderBean {
	private int orderNo;
	private String orderId;
	private String orderProduct;
	private int orderCount;
	private String orderdate;
	
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getOrderProduct() {
		return orderProduct;
	}
	public void setOrderProduct(String orderProduct) {
		this.orderProduct = orderProduct;
	}
	public int getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	
}
