package nic.watersoft.commons;

import java.io.Serializable;

import org.apache.struts.validator.ValidatorActionForm;

public class BaseActionForm extends ValidatorActionForm implements Serializable
{
	private String officeCode;
	private String officeName;
	private String headOfficeCode;
	private String headOfficeName;
	private String circleOfficeCode;
	private String circleOfficeName;
	private String divisionOfficeCode;
	private String divisionOfficeName;
	private String subdivisionOfficeCode;
	private String subdivisionOfficeName;
	
	private String mandal;
	private String pcode;
	private String vcode;
	private String habCode;
	private String districtName;
	
	private String employeeCode;
	private String employeeName;
	private String userId;
	private String remarks;
	private String message;
	private String mode;
	private String focusField;
	private boolean init;
	
	
	public void setOfficeCode(String officeCode)
	{	this.officeCode = officeCode;
	}
	public String getOfficeCode()
	{	return officeCode;
	}

	public void setOfficeName(String officeName)
	{	this.officeName = officeName;
	}
	public String getOfficeName()
	{	return officeName;
	}
		
	public void setHeadOfficeCode(String headOfficeCode)
	{	this.headOfficeCode = headOfficeCode;
	}
	public String getHeadOfficeCode()
	{	return headOfficeCode;
	}
	
	
	public void setHeadOfficeName(String headOfficeName)
	{	this.headOfficeName = headOfficeName;
	}
	public String getHeadOfficeName()
	{	return headOfficeName;
	}

	
	public void setCircleOfficeCode(String circleOfficeCode)
	{	this.circleOfficeCode = circleOfficeCode;
	}
	public String getCircleOfficeCode()
	{	return circleOfficeCode;
	}

	public void setCircleOfficeName(String circleOfficeName)
	{	this.circleOfficeName = circleOfficeName;
	}
	public String getCircleOfficeName()
	{	return circleOfficeName;
	}
	
	public void setDivisionOfficeCode(String divisionOfficeCode)
	{	this.divisionOfficeCode = divisionOfficeCode;
	}
	public String getDivisionOfficeCode()
	{	return divisionOfficeCode;
	}
	
	
	public void setDivisionOfficeName(String divisionOfficeName)
	{	this.divisionOfficeName = divisionOfficeName;
	}
	public String getDivisionOfficeName()
	{	return divisionOfficeName;
	}
	
	
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode)
	{	this.subdivisionOfficeCode = subdivisionOfficeCode;
	}
	public String getSubdivisionOfficeCode()
	{	return subdivisionOfficeCode;
	}
	
	public void setSubdivisionOfficeName(String subdivisionOfficeName)
	{	this.subdivisionOfficeName = subdivisionOfficeName;
	}
	public String getSubdivisionOfficeName()
	{	return subdivisionOfficeName;
	}

	public void setEmployeeCode(String employeeCode)
	{	this.employeeCode = employeeCode;
	}
	public String getEmployeeCode()
	{	return employeeCode;
	}
	
	public void setEmployeeName(String employeeName)
	{	this.employeeName = employeeName;
	}
	public String getEmployeeName()
	{	return employeeName;
	}
	
	public void setUserId(String userId)
	{	this.userId = userId;
	}
	public String getUserId()
	{	return userId;
	}
	
	public void setRemarks(String remarks)
	{	this.remarks = remarks;
	}
	public String getRemarks()
	{	return remarks;
	}


	public void setMessage(String message)
	{	this.message = message;
	}
	public String getMessage()
	{	return message;
	}
	
	
	public void setMode(String mode)
	{	this.mode = mode;
	}
	public String getMode()
	{	return mode;
	}
	
	
	public void setFocusField(String focusField)
	{	this.focusField = focusField;
	}
	public String getFocusField()
	{	return focusField;
	}
	
	
	public void setInit(boolean init)
	{	this.init = init;
	}
	public boolean getInit()
	{	return init;
	}

	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	public String getMandal() {
		return mandal;
	}
	public void setMandal(String mandal) {
		this.mandal = mandal;
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
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
}