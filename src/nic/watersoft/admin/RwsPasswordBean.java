package nic.watersoft.admin;

import org.apache.struts.action.ActionForm;

public class RwsPasswordBean extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userId;
	private String registeredMailId;
	private String registeredMobileNo;

	private String circleOfficeName;
	private String divOfficeName;
	private String selectOption;
	private String randomPassword;

	public String getSelectOption() {
		return selectOption;
	}

	public String getRandomPassword() {
		return randomPassword;
	}

	public void setRandomPassword(String randomPassword) {
		this.randomPassword = randomPassword;
	}

	public void setSelectOption(String selectOption) {
		this.selectOption = selectOption;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRegisteredMailId() {
		return registeredMailId;
	}

	public void setRegisteredMailId(String registeredMailId) {
		this.registeredMailId = registeredMailId;
	}

	public String getRegisteredMobileNo() {
		return registeredMobileNo;
	}

	public void setRegisteredMobileNo(String registeredMobileNo) {
		this.registeredMobileNo = registeredMobileNo;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getCircleOfficeName() {
		return circleOfficeName;
	}

	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}

	public String getDivOfficeName() {
		return divOfficeName;
	}

	public void setDivOfficeName(String divOfficeName) {
		this.divOfficeName = divOfficeName;
	}
}
