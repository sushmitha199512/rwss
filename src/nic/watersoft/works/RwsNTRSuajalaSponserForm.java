package nic.watersoft.works;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsNTRSuajalaSponserForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * Office Details
	 */
	private String[] circleCode;
	private String[] mandalCode;
	private String[] panchayathCode;
	private String[] villageCode;
	private String[] habCode;

	public String[] getMandalCode() {
		return mandalCode;
	}

	public void setMandalCode(String[] mandalCode) {
		this.mandalCode = mandalCode;
	}

	public String[] getPanchayathCode() {
		return panchayathCode;
	}

	public void setPanchayathCode(String[] panchayathCode) {
		this.panchayathCode = panchayathCode;
	}

	public String[] getVillageCode() {
		return villageCode;
	}

	public void setVillageCode(String[] villageCode) {
		this.villageCode = villageCode;
	}

	public String[] getHabCode() {
		return habCode;
	}

	public void setHabCode(String[] habCode) {
		this.habCode = habCode;
	}

	private String villageSelection;

	private String category;
	private String selection;

	/**
	 * Sponser Details
	 */
	private String sponserName;
	private String mobileNo;
	private String emailId;
	private String city;
	private String country;
	private String amount;

	private String state;

	private String address;

	public String getSponserName() {
		return sponserName;
	}

	public void setSponserName(String sponserName) {
		this.sponserName = sponserName;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getAmount() {
		return amount;
	}

	public void setAmount(String amount) {
		this.amount = amount;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCountry() {
		return country;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress() {
		return address;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getState() {
		return state;
	}

	public void setVillageSelection(String villageSelection) {
		this.villageSelection = villageSelection;
	}

	public String getVillageSelection() {
		return villageSelection;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCategory() {
		return category;
	}

	public void setSelection(String selection) {
		this.selection = selection;
	}

	public String getSelection() {
		return selection;
	}

	public void setCircleCode(String[] circleCode) {
		this.circleCode = circleCode;
	}

	public String[] getCircleCode() {
		return circleCode;
	}

}
