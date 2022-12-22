package nic.watersoft.admin;

import java.io.Serializable;

public class UsersListManager implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2553594883475679866L;
	private String userId;
	private String mobileNo;
	private String mailId;
	private String circle;
	private String division;
	private String subdivision;
	
	public String getSubdivision() {
		return subdivision;
	}
	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
	}
	public String getCircle() {
		return circle;
	}
	public void setCircle(String circle) {
		this.circle = circle;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getMailId() {
		return mailId;
	}
	public void setMailId(String mailId) {
		this.mailId = mailId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	

}
