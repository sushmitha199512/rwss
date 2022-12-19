package nic.watersoft.masters;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/** form bean classes* */
public class Rws_Employee_Mobile_Updation_Form extends ActionForm {
	
	private static final long serialVersionUID = 1L;
	
	private String circleOfficeCode;
	private String circleOfficeName;
	private String divisionOfficeCode;
	private String subDivisionOfficeCode;
	private String employeeId;
	private String employeeMobile;
	private String employeeName;
	private String label;
	private String value;
	private String labelValue;
	
	
	public String getCircleOfficeName() {
		return circleOfficeName;
	}
	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getLabelValue() {
		return labelValue;
	}
	public void setLabelValue(String labelValue) {
		this.labelValue = labelValue;
	}
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeeMobile() {
		return employeeMobile;
	}
	public void setEmployeeMobile(String employeeMobile) {
		this.employeeMobile = employeeMobile;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	public String getSubDivisionOfficeCode() {
		return subDivisionOfficeCode;
	}
	public void setSubDivisionOfficeCode(String subDivisionOfficeCode) {
		this.subDivisionOfficeCode = subDivisionOfficeCode;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
	
}
