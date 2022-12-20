package nic.watersoft.commons;

import java.io.Serializable;

public class BaseDTO implements Serializable
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
	private String employeeCode;
	private String employeeName;
	private String userId;
	private String remarks;
	private String mandal;
		
	public String getMandal() {
		return mandal;
	}

	public void setMandal(String mandal) {
		this.mandal = mandal;
	}

	/**
	*	Set officeCode
	*/
	public void setOfficeCode(String officeCode)
	{	this.officeCode = officeCode;
	}

	/**
	*	Get officeCode
	*/
	public String getOfficeCode()
	{	return officeCode;
	}
	
	/**
	*	Set officeName
	*/
	public void setOfficeName(String officeName)
	{	this.officeName = officeName;
	}

	/**
	*	Get officeName
	*/
	public String getOfficeName()
	{	return officeName;
	}
	
	/**
	*	Set headOfficeCode
	*/
	public void setHeadOfficeCode(String headOfficeCode)
	{	this.headOfficeCode = headOfficeCode;
	}
	
	/**
	*	Get headOfficeCode
	*/
	public String getHeadOfficeCode()
	{	return headOfficeCode;
	}
	
	/**
	*	Set headOfficeName
	*/
	public void setHeadOfficeName(String headOfficeName)
	{	this.headOfficeName = headOfficeName;
	}

	/**
	*	Get headOfficeName
	*/
	public String getHeadOfficeName()
	{	return headOfficeName;
	}

	/**
	*	Set circleOfficeCode
	*/
	public void setCircleOfficeCode(String circleOfficeCode)
	{	this.circleOfficeCode = circleOfficeCode;
	}
	
	/**
	*	Get circleOfficeCode
	*/
	public String getCircleOfficeCode()
	{	return circleOfficeCode;
	}

	/**
	*	Set circleOfficeName
	*/
	public void setCircleOfficeName(String circleOfficeName)
	{	this.circleOfficeName = circleOfficeName;
	}

	/**
	*	Get circleOfficeName
	*/
	public String getCircleOfficeName()
	{	return circleOfficeName;
	}

	/**
	*	Set divisionOfficeCode
	*/
	public void setDivisionOfficeCode(String divisionOfficeCode)
	{	this.divisionOfficeCode = divisionOfficeCode;
	}

	/**
	*	Get divisionOfficeCode
	*/
	public String getDivisionOfficeCode()
	{	return divisionOfficeCode;
	}
	
	/**
	*	Set divisionOfficeName
	*/
	public void setDivisionOfficeName(String divisionOfficeName)
	{	this.divisionOfficeName = divisionOfficeName;
	}

	/**
	*	Get divisionOfficeName
	*/
	public String getDivisionOfficeName()
	{	return divisionOfficeName;
	}
	
	/**
	*	Set subdivisionOfficeCode
	*/
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode)
	{	this.subdivisionOfficeCode = subdivisionOfficeCode;
	}

	/**
	*	Get subdivisionOfficeCode
	*/
	public String getSubdivisionOfficeCode()
	{	return subdivisionOfficeCode;
	}
	
	/**
	*	Set subdivisionOfficeName
	*/
	public void setSubdivisionOfficeName(String subdivisionOfficeName)
	{	this.subdivisionOfficeName = subdivisionOfficeName;
	}

	/**
	*	Get subdivisionOfficeName
	*/
	public String getSubdivisionOfficeName()
	{	return subdivisionOfficeName;
	}

	/**
	*	Set employeeCode
	*/
	public void setEmployeeCode(String employeeCode)
	{	this.employeeCode = employeeCode;
	}

	/**
	*	Get employeeCode
	*/
	public String getEmployeeCode()
	{	return employeeCode;
	}
	
	/**
	*	Set employeeName
	*/
	public void setEmployeeName(String employeeName)
	{	this.employeeName = employeeName;
	}
	
	/**
	*	Get employeeName
	*/
	public String getEmployeeName()
	{	return employeeName;
	}
	
	/**
	*	Set remarks
	*/
	public void setRemarks(String remarks)
	{	this.remarks = remarks;
	}

	/**
	*	Get remarks
	*/
	public String getRemarks()
	{	return remarks;
	}
	
	public void setUserId(String userId)
	{	this.userId = userId;		
	}
	public String getUserId()
	{	return userId;		
	}
}
