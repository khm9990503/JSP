package kr.co.college.bean;

public class RegisterBean {
	private String regstdno;
	private int reglecno;
	private int regmidscore;
	private int regfinalscore;
	private int regtotalscore;
	private String reggrade;
	
	private String stdname;
	private String lecname;
	
	public String getRegstdno() {
		return regstdno;
	}
	public void setRegstdno(String regstdno) {
		this.regstdno = regstdno;
	}
	public int getReglecno() {
		return reglecno;
	}
	public void setReglecno(int reglecno) {
		this.reglecno = reglecno;
	}
	public int getRegmidscore() {
		return regmidscore;
	}
	public void setRegmidscore(int regmidscore) {
		this.regmidscore = regmidscore;
	}
	public int getRegfinalscore() {
		return regfinalscore;
	}
	public void setRegfinalscore(int regfinalscore) {
		this.regfinalscore = regfinalscore;
	}
	public int getRegtotalscore() {
		return regtotalscore;
	}
	public void setRegtotalscore(int regtotalscore) {
		this.regtotalscore = regtotalscore;
	}
	public String getReggrade() {
		return reggrade;
	}
	public void setReggrade(String reggrade) {
		this.reggrade = reggrade;
	}
	
	public String getStdname() {
		return stdname;
	}
	
	public void setStdname(String stdname) {
		this.stdname = stdname;
	}
	
	public String getLecname() {
		return lecname;
	}
	
	public void setLecname(String lecname) {
		this.lecname = lecname;
	}
	
}
