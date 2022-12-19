package nic.watersoft.works;

import java.util.ArrayList;


import org.apache.struts.action.ActionForm;


public class LeadHabForm extends ActionForm
{
	
	private String checks="";
	//////////Added on 6/6/2014
	private String leadHab="";
	private String leadName="";
	private String dist="";
	private String mcode="";
	private String pcode="";
	private String habCode="";
	private String habName="";
	private String assetCd1="";
	private ArrayList habs;
	
	//////////
	
	public String getAssetCd1() {
		return assetCd1;
	}
	public void setAssetCd1(String assetCd1) {
		this.assetCd1 = assetCd1;
	}
	public ArrayList getHabs() {
		return habs;
	}
	public void setHabs(ArrayList habs) {
		this.habs = habs;
	}
	public String getDist() {
		return dist;
	}
	public void setDist(String dist) {
		this.dist = dist;
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
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	public String getHabName() {
		return habName;
	}
	public void setHabName(String habName) {
		this.habName = habName;
	}
	public String getLeadHab() {
		return leadHab;
	}
	public void setLeadHab(String leadHab) {
		this.leadHab = leadHab;
	}
	public String getLeadName() {
		return leadName;
	}
	public void setLeadName(String leadName) {
		this.leadName = leadName;
	}
	public String getChecks() {
		return checks;
	}
	public void setChecks(String checks) {
		this.checks = checks;
	}
	public String getBlockPayment() {
		return blockPayment;
	}
	public void setBlockPayment(String blockPayment) {
		this.blockPayment = blockPayment;
	}
	public String getBlockDate() {
		return blockDate;
	}
	public void setBlockDate(String blockDate) {
		this.blockDate = blockDate;
	}
	private String blockPayment="";
	private String blockDate="";
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
}
