package nic.watersoft.works;

import java.util.ArrayList;
import java.io.Serializable;

import org.apache.struts.action.ActionForm;

public class OfficeMasterBean implements Serializable
{
	private String workId="";
	private String workName="";
	private String adminNo="";
	private String sanctionAmount="";
	private String sanctionDate="";
	private String officeEntered=""; 
	private String mode;
	private String adminDate="";
	private ArrayList works;
	
	private String divisionofficeCode="";
	private String divisionofficeName="";
	//Added fields on 11/07/2013
	private String blockPayment="";
	private String blockDate="";
	private String circleOfficeCode="";
	private String checks="";
	
	/**
	 * @return Returns the checks.
	 */
	public String getChecks() {
		return checks;
	}
	/**
	 * @param checks The checks to set.
	 */
	public void setChecks(String checks) {
		this.checks = checks;
	}
	/**
	 * @return Returns the circleOfficeCode.
	 */
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	/**
	 * @param circleOfficeCode The circleOfficeCode to set.
	 */
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	/**
	 * @return Returns the contractorCode.
	 */
	public String getContractorCode() {
		return contractorCode;
	}
	/**
	 * @param contractorCode The contractorCode to set.
	 */
	public void setContractorCode(String contractorCode) {
		this.contractorCode = contractorCode;
	}
	/**
	 * @return Returns the contractorName.
	 */
	public String getContractorName() {
		return contractorName;
	}
	/**
	 * @param contractorName The contractorName to set.
	 */
	public void setContractorName(String contractorName) {
		this.contractorName = contractorName;
	}
	private String divisionOfficeCode="";
	private String subdivisionofficeCode="";
	private String contractorCode="";
	private String contractorName="";
	
	/**
	 * @return Returns the subdivisionofficeCode.
	 */
	public String getSubdivisionofficeCode() {
		return subdivisionofficeCode;
	}
	/**
	 * @param subdivisionofficeCode The subdivisionofficeCode to set.
	 */
	public void setSubdivisionofficeCode(String subdivisionofficeCode) {
		this.subdivisionofficeCode = subdivisionofficeCode;
	}
	/**
	 * @return Returns the divisionofficeCode.
	 */
	public String getDivisionofficeCode() {
		return divisionofficeCode;
	}
	/**
	 * @param divisionofficeCode The divisionofficeCode to set.
	 */
	public void setDivisionofficeCode(String divisionofficeCode) {
		this.divisionofficeCode = divisionofficeCode;
	}
	/**
	 * @return Returns the divisionofficeName.
	 */
	public String getDivisionofficeName() {
		return divisionofficeName;
	}
	/**
	 * @param divisionofficeName The divisionofficeName to set.
	 */
	public void setDivisionofficeName(String divisionofficeName) {
		this.divisionofficeName = divisionofficeName;
	}
	
	public String getAdminDate() {
		return adminDate;
	}
	/**
	 * @param adminDate The adminDate to set.
	 */
	public void setAdminDate(String adminDate) {
		this.adminDate = adminDate;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}
	/**
	 * @return Returns the adminNo.
	 */
	public String getAdminNo() {
		return adminNo;
	}
	/**
	 * @param adminNo The adminNo to set.
	 */
	public void setAdminNo(String adminNo) {
		this.adminNo = adminNo;
	}
	/**
	 * @return Returns the officeEntered.
	 */
	public String getOfficeEntered() {
		return officeEntered;
	}
	/**
	 * @param officeEntered The officeEntered to set.
	 */
	public void setOfficeEntered(String officeEntered) {
		this.officeEntered = officeEntered;
	}
	/**
	 * @return Returns the sanctionAmount.
	 */
	public String getSanctionAmount() {
		return sanctionAmount;
	}
	/**
	 * @param sanctionAmount The sanctionAmount to set.
	 */
	public void setSanctionAmount(String sanctionAmount) {
		this.sanctionAmount = sanctionAmount;
	}
	/**
	 * @return Returns the sanctionDate.
	 */
	public String getSanctionDate() {
		return sanctionDate;
	}
	/**
	 * @param sanctionDate The sanctionDate to set.
	 */
	public void setSanctionDate(String sanctionDate) {
		this.sanctionDate = sanctionDate;
	}
	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}
	/**
	 * @param workId The workId to set.
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	/**
	 * @return Returns the workName.
	 */
	public String getWorkName() {
		return workName;
	}
	/**
	 * @param workName The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	/**
	 * @return Returns the works.
	 */
	public ArrayList getWorks() {
		return works;
	}
	/**
	 * @param works The works to set.
	 */
	public void setWorks(ArrayList works) {
		this.works = works;
	}
	/**
	 * @return Returns the divisionOfficeCode.
	 */
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	/**
	 * @param divisionOfficeCode The divisionOfficeCode to set.
	 */
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	/**
	 * @return Returns the blockDate.
	 */
	public String getBlockDate() {
		return blockDate;
	}
	/**
	 * @param blockDate The blockDate to set.
	 */
	public void setBlockDate(String blockDate) {
		this.blockDate = blockDate;
	}
	/**
	 * @return Returns the blockPayment.
	 */
	public String getBlockPayment() {
		return blockPayment;
	}
	/**
	 * @param blockPayment The blockPayment to set.
	 */
	public void setBlockPayment(String blockPayment) {
		this.blockPayment = blockPayment;
	}
}
