package nic.watersoft.admin;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class UserListForm extends ActionForm{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4283135459960889088L;
	
	private String userId;
	private String mode;
	private String mobileNo;
	private String mailId;
	private String superUser;
	private String circle;
	private String division;
	private String subdivision;
	
	private ArrayList usersList;
	
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
	public String getSuperUser() {
		return superUser;
	}
	public void setSuperUser(String superUser) {
		this.superUser = superUser;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public ArrayList getUsersList() {
		return usersList;
	}
	public void setUsersList(ArrayList usersList) {
		this.usersList = usersList;
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
	
}
