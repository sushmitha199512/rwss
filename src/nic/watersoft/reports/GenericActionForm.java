package nic.watersoft.reports;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class GenericActionForm extends ActionForm {

	private ArrayList<GenericActionBean> generic;
	private String generic1;
	private String dcode;
	private String mcode;
	private String category;
	
	public String getDcode() {
		return dcode;
	}
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	public String getMcode() {
		return mcode;
	}
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getVcode() {
		return vcode;
	}
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	public String getPanchCode() {
		return panchCode;
	}
	public void setPanchCode(String panchCode) {
		this.panchCode = panchCode;
	}
	public String getPanchName() {
		return panchName;
	}
	public void setPanchName(String panchName) {
		this.panchName = panchName;
	}
	public String getComplaintNumber() {
		return complaintNumber;
	}
	public void setComplaintNumber(String complaintNumber) {
		this.complaintNumber = complaintNumber;
	}
	public String getComplaintDate() {
		return complaintDate;
	}
	public void setComplaintDate(String complaintDate) {
		this.complaintDate = complaintDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getActionTaken() {
		return actionTaken;
	}
	public void setActionTaken(String actionTaken) {
		this.actionTaken = actionTaken;
	}
	public String getPrblmDesc() {
		return prblmDesc;
	}
	public void setPrblmDesc(String prblmDesc) {
		this.prblmDesc = prblmDesc;
	}
	public String getComplaintGivenBy() {
		return complaintGivenBy;
	}
	public void setComplaintGivenBy(String complaintGivenBy) {
		this.complaintGivenBy = complaintGivenBy;
	}
	public String getActionDesc() {
		return actionDesc;
	}
	public void setActionDesc(String actionDesc) {
		this.actionDesc = actionDesc;
	}
	public String getAttendBy() {
		return attendBy;
	}
	public void setAttendBy(String attendBy) {
		this.attendBy = attendBy;
	}
	public String getAttendedDate() {
		return attendedDate;
	}
	public void setAttendedDate(String attendedDate) {
		this.attendedDate = attendedDate;
	}
	public String getMesSentToGrevance() {
		return mesSentToGrevance;
	}
	public void setMesSentToGrevance(String mesSentToGrevance) {
		this.mesSentToGrevance = mesSentToGrevance;
	}
	public String getDateOfSent() {
		return dateOfSent;
	}
	public void setDateOfSent(String dateOfSent) {
		this.dateOfSent = dateOfSent;
	}
	public void setGeneric(ArrayList generic) {
		this.generic = generic;
	}
	public ArrayList getGeneric() {
		return generic;
	}
	public void setGeneric1(String generic1) {
		this.generic1 = generic1;
	}
	public String getGeneric1() {
		return generic1;
	}
	private String pcode;
	private String vcode;
	private String panchCode;
	private String panchName;
	private String complaintNumber;
	private String complaintDate;
	private String name;
	private String phoneNumber;
	private String address;
	private String actionTaken;
	private String prblmDesc;
	
	private String complaintGivenBy;
	private String actionDesc;
	private String attendBy;
	private String attendedDate;
	private String mesSentToGrevance;
	private String dateOfSent;
	private String checks;
	public Object getHabs() {
		// TODO Auto-generated method stub
		return null;
	}
	public void setChecks(String checks) {
		this.checks = checks;
	}
	public String getChecks() {
		return checks;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCategory() {
		return category;
	}
	
	
}
