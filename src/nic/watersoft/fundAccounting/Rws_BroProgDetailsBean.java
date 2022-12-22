/*
 * Created on Aug 6, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import java.util.ArrayList;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_BroProgDetailsBean {
	private String broId;
	private String programmeName;
	private String programmeCode;
	private String subprogrammeName;
	private String subprogrammeCode;
	private String headOfAccount;
	private String headOfAccountName;
	private String budgetEstimate;
	private String budgetEstimateYear;
	private String amountAlreadyAuthorised;
	private String amountNowAuthorised;
	private String procedureForDrawl;
	private String drawingOfficer;
	private String remarks;
	private String broReference;
	private String quarter;
	private String selects;
	private String installment;
	//code added by sridhar 
	private String majorHead;
	private String subMajorHead;
	private String minorHead;
	private String groupHead;
	private String subHead;
	private String detailHead;
	private String subDetailHead;
		
	
	ArrayList subProgrammesList;
	ArrayList majorHeadList;
	/**
	 * @return Returns the majorHeadList.
	 */
	public ArrayList getMajorHeadList() {
		return majorHeadList;
	}
	/**
	 * @param majorHeadList The majorHeadList to set.
	 */
	public void setMajorHeadList(ArrayList majorHeadList) {
		this.majorHeadList = majorHeadList;
	}
	ArrayList submajorlist;
	ArrayList minorHeadList;
	ArrayList groupHeadList;
	ArrayList subHeadList;
	ArrayList detailHeadList;
	ArrayList subDetailHeadList;
	
	
	/**
	 * @return Returns the detailHead.
	 */
	public String getDetailHead() {
		return detailHead;
	}
	/**
	 * @param detailHead The detailHead to set.
	 */
	public void setDetailHead(String detailHead) {
		this.detailHead = detailHead;
	}
	/**
	 * @return Returns the detailHeadList.
	 */
	public ArrayList getDetailHeadList() {
		return detailHeadList;
	}
	/**
	 * @param detailHeadList The detailHeadList to set.
	 */
	public void setDetailHeadList(ArrayList detailHeadList) {
		this.detailHeadList = detailHeadList;
	}
	/**
	 * @return Returns the subDetailHead.
	 */
	public String getSubDetailHead() {
		return subDetailHead;
	}
	/**
	 * @param subDetailHead The subDetailHead to set.
	 */
	public void setSubDetailHead(String subDetailHead) {
		this.subDetailHead = subDetailHead;
	}
	/**
	 * @return Returns the subDetailHeadList.
	 */
	public ArrayList getSubDetailHeadList() {
		return subDetailHeadList;
	}
	/**
	 * @param subDetailHeadList The subDetailHeadList to set.
	 */
	public void setSubDetailHeadList(ArrayList subDetailHeadList) {
		this.subDetailHeadList = subDetailHeadList;
	}
	public String getSubHead() {
		return subHead;
	}
	public void setSubHead(String subHead) {
		this.subHead = subHead;
	}
	public ArrayList getSubHeadList() {
		return subHeadList;
	}
	
	public void setSubHeadList(ArrayList subHeadList) {
		this.subHeadList = subHeadList;
	}
	public ArrayList getMinorHeadList() {
		return minorHeadList;
	}
	
	public void setMinorHeadList(ArrayList minorHeadList) {
		this.minorHeadList = minorHeadList;
	}
	
	public ArrayList getSubmajorlist() {
		return submajorlist;
	}
	
	public void setSubmajorlist(ArrayList submajorlist) {
		this.submajorlist = submajorlist;
	}
	public ArrayList getSubProgrammesList() {
		return subProgrammesList;
	}
	public void setSubProgrammesList(ArrayList subProgrammesList) {
		this.subProgrammesList = subProgrammesList;
	}
	public String getAmountAlreadyAuthorised() {
		return amountAlreadyAuthorised;
	}
	public void setAmountAlreadyAuthorised(String amountAlreadyAuthorised) {
		this.amountAlreadyAuthorised = amountAlreadyAuthorised;
	}
	public String getAmountNowAuthorised() {
		return amountNowAuthorised;
	}
	public void setAmountNowAuthorised(String amountNowAuthorised) {
		this.amountNowAuthorised = amountNowAuthorised;
	}
	public String getBudgetEstimate() {
		return budgetEstimate;
	}
	public void setBudgetEstimate(String budgetEstimate) {
		this.budgetEstimate = budgetEstimate;
	}
	public String getBudgetEstimateYear() {
		return budgetEstimateYear;
	}
	public void setBudgetEstimateYear(String budgetEstimateYear) {
		this.budgetEstimateYear = budgetEstimateYear;
	}
	public String getDrawingOfficer() {
		return drawingOfficer;
	}
	public void setDrawingOfficer(String drawingOfficer) {
		this.drawingOfficer = drawingOfficer;
	}
	public String getHeadOfAccount() {
		return headOfAccount;
	}
	public void setHeadOfAccount(String headOfAccount) {
		this.headOfAccount = headOfAccount;
	}
	public String getProcedureForDrawl() {
		return procedureForDrawl;
	}
	public void setProcedureForDrawl(String procedureForDrawl) {
		this.procedureForDrawl = procedureForDrawl;
	}
	public String getProgrammeCode() {
		return programmeCode;
	}
	public void setProgrammeCode(String programmeCode) {
		this.programmeCode = programmeCode;
	}
	public String getProgrammeName() {
		return programmeName;
	}
	public void setProgrammeName(String programmeName) {
		this.programmeName = programmeName;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getBroId() {
		return broId;
	}
	public void setBroId(String broId) {
		this.broId = broId;
	}
	public String getHeadOfAccountName() {
		return headOfAccountName;
	}
	public void setHeadOfAccountName(String headOfAccountName) {
		this.headOfAccountName = headOfAccountName;
	}
	public String getBroReference() {
		return broReference;
	}
	public void setBroReference(String broReference) {
		this.broReference = broReference;
	}
	
	public String getQuarter() {
		return quarter;
	}
	
	public void setQuarter(String quarter) {
		this.quarter = quarter;
	}
	public String getSubprogrammeCode() {
		return subprogrammeCode;
	}
	public void setSubprogrammeCode(String subprogrammeCode) {
		this.subprogrammeCode = subprogrammeCode;
	}
	public String getSubprogrammeName() {
		return subprogrammeName;
	}
	public void setSubprogrammeName(String subprogrammeName) {
		this.subprogrammeName = subprogrammeName;
	}
	public String getInstallment() {
		return installment;
	}
	public void setInstallment(String installment) {
		this.installment = installment;
	}
	public String getSelects() { 
		return selects;
	}
	public void setSelects(String selects) {
		this.selects = selects; 
	}
	
	//code added by sridhar 
	public String getMajorHead() {
		return majorHead;
	}
	public void setMajorHead(String majorHead) {
		this.majorHead = majorHead;
	} 
	
	public String getSubMajorHead() {
		return subMajorHead;
	}
	public void setSubMajorHead(String subMajorHead) {
		this.subMajorHead = subMajorHead;
	}
	
	public String getMinorHead() {
		return minorHead;
	}
	
	public void setMinorHead(String minorHead) {
		this.minorHead = minorHead;
	}
	
	public String getGroupHead() {
		return groupHead;
	}
	
	public void setGroupHead(String groupHead) {
		this.groupHead = groupHead;
	}
	
	public ArrayList getGroupHeadList() {
		return groupHeadList;
	}
	
	public void setGroupHeadList(ArrayList groupHeadList) {
		this.groupHeadList = groupHeadList;
	}
}
