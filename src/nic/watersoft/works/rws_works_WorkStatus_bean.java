/*
 * Created on Jun 15, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.io.Serializable;
  
public class rws_works_WorkStatus_bean implements Serializable
{ 
	 //added by swapna on 18-10-2011
    private String milestone1;
    //
	private String officeCode;
	private String preparedBy;
	private String mode;
	private String circleName;
	private String circleCode;
	private String divName;
	private String divCode;
	private String subdivisioncode;
	private String subDivCode;
	private String subDivName;
	private String workId;
	private String workName;
	private String progName;
 	private String subProgName;
    private String scheme;
    private String schemeCode;
    private String progCode;
    private String subProgCode;
    private String workStage;
    /**Admin Sanction*/
    private String adminAmnt;
    private String adminDate;
    private String adminNo;
    private String adminHabsBen;
    private String adminHabNames;
    private String adminPlainPopu;
    private String adminScPopu;
    private String adminSTPopu;
    private String adminTotpopu;
    /**Revised admin  */
    private String revAdminAmnt;
    private String revAdminDate;
    private String revAdminNo;
    private String revAdminHabsBen;
    private String revAdminHabNames;
    private String revPlainPopu;
    private String revScPopu;
    private String revSTPopu;
    private String revTotpopu;
    
    /**Technical sanction  */
    private String tsMode;
    private String tsAccBy;
    private String tsAmnt;
    private String tsNo;
    private String tsDate;
    private String tsHabsBen;
    private String tsHabNames;
    private String tsOffice;
    private String ssrYear;
    private String tsPlainPop;
    private String tsScPop;
    private String tsStPop;
    private String tsTotPop;
    /**Revised Tecnicla saction  */
    private String revTsMode="data";
    private String revTsAccBy;
    private String revTsAmnt;
    private String revTsNo;
    private String revTsDate;
    private String revTsHabsBen;
    private String revTsHabNames;
    private String revTsOffice;
    private String revSsrYear;
    private String revTsPlainPopu;
    private String revTsScPopu;
    private String revTsSTPopu;
    private String revTsTotpopu;
    private String revTsNoOfHabs;
    /**Contractor manageement */
    private String tenId;
    private String tenCost;
    private String conName;
    private String loaIssued;
    private String tenPer;
    private String agrRefNo;
    private String agrDuration;
    private String agrDate;
    private String agrValue;
    private String siteHandOverDate;
    private String stipulatedDate;
    private String mileStoneSno;
    private String mileStone;
    private String majorMileStone;
    private String mileStoneName;
    private String stage;
    private String compInNo;
    private String targetDate;
    private String perComp;
    private String perCompValue;
    private String perCompInWork;
    private String perCompInWorkValue;
    private String typeOfContractor;
    private String eoatTargetDate;
    private String tenApprovedBy;
    private String tenAcceptedDate;
    private java.util.ArrayList stages;
    private String stageName;
    private String tenCommitee;
	private String tenCompetentAuthority;
	private String[] tenCommiteeArr;
	private String syr;
	private String syr1;
	private String program;
	private String subprogram;
	private String probCompDate;
	private String plan;
	private String wrktype;
	private String workCat;
    private String item;
	private String workEnt;
	private String workPer1;
	private String tenId1;
	
	// added by ramesh on 090610
	private String alreadyExists;
	private String schoolHabCode;
	private String panchayat;
	private String village;
	private String habitation;
	private String habName;
	private String schoolCode;
	private String schoolName;
	private String category;
	private String classification;
	private String totStudents;
	
	// added by sridhar for tsmilestones 
	private String qtyts;
	private String unitsts;
	private String amountts;
	
	public String getAmountts() {
		return amountts;
	}
	public void setAmountts(String amountts) {
		this.amountts = amountts;
	}
	public String getQtyts() {
		return qtyts;
	}
	public void setQtyts(String qtyts) {
		this.qtyts = qtyts;
	}
	public String getUnitsts() {
		return unitsts;
	}
	public void setUnitsts(String unitsts) {
		this.unitsts = unitsts;
	}
	/**
	 * @return Returns the tenApprovedBy.
	 */
	public String getTenApprovedBy() {
		return tenApprovedBy;
	}
	/**
	 * @param tenApprovedBy The tenApprovedBy to set.
	 */
	public void setTenApprovedBy(String tenApprovedBy) {
		this.tenApprovedBy = tenApprovedBy;
	}
    
	/**
	 * @return Returns the adminAmnt.
	 */
	public String getAdminAmnt() {
		return adminAmnt;
	}
	/**
	 * @param adminAmnt The adminAmnt to set.
	 */
	public void setAdminAmnt(String adminAmnt) {
		this.adminAmnt = adminAmnt;
	}
	/**
	 * @return Returns the adminDate.
	 */
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
	 * @return Returns the adminHabNames.
	 */
	public String getAdminHabNames() {
		return adminHabNames;
	}
	/**
	 * @param adminHabNames The adminHabNames to set.
	 */
	public void setAdminHabNames(String adminHabNames) {
		this.adminHabNames = adminHabNames;
	}
	/**
	 * @return Returns the adminHabsBen.
	 */
	public String getAdminHabsBen() {
		return adminHabsBen;
	}
	/**
	 * @param adminHabsBen The adminHabsBen to set.
	 */
	public void setAdminHabsBen(String adminHabsBen) {
		this.adminHabsBen = adminHabsBen;
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
	 * @return Returns the adminPlainPopu.
	 */
	public String getAdminPlainPopu() {
		return adminPlainPopu;
	}
	/**
	 * @param adminPlainPopu The adminPlainPopu to set.
	 */
	public void setAdminPlainPopu(String adminPlainPopu) {
		this.adminPlainPopu = adminPlainPopu;
	}
	/**
	 * @return Returns the adminScPopu.
	 */
	public String getAdminScPopu() {
		return adminScPopu;
	}
	/**
	 * @param adminScPopu The adminScPopu to set.
	 */
	public void setAdminScPopu(String adminScPopu) {
		this.adminScPopu = adminScPopu;
	}
	/**
	 * @return Returns the adminSTPopu.
	 */
	public String getAdminSTPopu() {
		return adminSTPopu;
	}
	/**
	 * @param adminSTPopu The adminSTPopu to set.
	 */
	public void setAdminSTPopu(String adminSTPopu) {
		this.adminSTPopu = adminSTPopu;
	}
	/**
	 * @return Returns the adminTotpopu.
	 */
	public String getAdminTotpopu() {
		return adminTotpopu;
	}
	/**
	 * @param adminTotpopu The adminTotpopu to set.
	 */
	public void setAdminTotpopu(String adminTotpopu) {
		this.adminTotpopu = adminTotpopu;
	}
	/**
	 * @return Returns the agrDate.
	 */
	public String getAgrDate() {
		return agrDate;
	}
	/**
	 * @param agrDate The agrDate to set.
	 */
	public void setAgrDate(String agrDate) {
		this.agrDate = agrDate;
	}
	/**
	 * @return Returns the agrDuration.
	 */
	public String getAgrDuration() {
		return agrDuration;
	}
	/**
	 * @param agrDuration The agrDuration to set.
	 */
	public void setAgrDuration(String agrDuration) {
		this.agrDuration = agrDuration;
	}
	/**
	 * @return Returns the agrRefNo.
	 */
	public String getAgrRefNo() {
		return agrRefNo;
	}
	/**
	 * @param agrRefNo The agrRefNo to set.
	 */
	public void setAgrRefNo(String agrRefNo) {
		this.agrRefNo = agrRefNo;
	}
	/**
	 * @return Returns the agrValue.
	 */
	public String getAgrValue() {
		return agrValue;
	}
	/**
	 * @param agrValue The agrValue to set.
	 */
	public void setAgrValue(String agrValue) {
		this.agrValue = agrValue;
	}
	/**
	 * @return Returns the circleCode.
	 */
	public String getCircleCode() {
		return circleCode;
	}
	/**
	 * @param circleCode The circleCode to set.
	 */
	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}
	/**
	 * @return Returns the circleName.
	 */
	public String getCircleName() {
		return circleName;
	}
	/**
	 * @param circleName The circleName to set.
	 */
	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}
	/**
	 * @return Returns the conName.
	 */
	public String getConName() {
		return conName;
	}
	/**
	 * @param conName The conName to set.
	 */
	public void setConName(String conName) {
		this.conName = conName;
	}
	/**
	 * @return Returns the divCode.
	 */
	public String getDivCode() {
		return divCode;
	}
	/**
	 * @param divCode The divCode to set.
	 */
	public void setDivCode(String divCode) {
		this.divCode = divCode;
	}
	/**
	 * @return Returns the divName.
	 */
	public String getDivName() {
		return divName;
	}
	/**
	 * @param divName The divName to set.
	 */
	public void setDivName(String divName) {
		this.divName = divName;
	}
	/**
	 * @return Returns the loaIssued.
	 */
	public String getLoaIssued() {
		return loaIssued;
	}
	/**
	 * @param loaIssued The loaIssued to set.
	 */
	public void setLoaIssued(String loaIssued) {
		this.loaIssued = loaIssued;
	}
	/**
	 * @return Returns the mileStone.
	 */
	public String getMileStone() {
		return mileStone;
	}
	/**
	 * @param mileStone The mileStone to set.
	 */
	public void setMileStone(String mileStone) {
		this.mileStone = mileStone;
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
	 * @return Returns the officeCode.
	 */
	public String getOfficeCode() {
		return officeCode;
	}
	/**
	 * @param officeCode The officeCode to set.
	 */
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	/**
	 * @return Returns the perComp.
	 */
	public String getPerComp() {
		return perComp;
	}
	/**
	 * @param perComp The perComp to set.
	 */
	public void setPerComp(String perComp) {
		this.perComp = perComp;
	}
	/**
	 * @return Returns the preparedBy.
	 */
	public String getPreparedBy() {
		return preparedBy;
	}
	/**
	 * @param preparedBy The preparedBy to set.
	 */
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	/**
	 * @return Returns the progCode.
	 */
	public String getProgCode() {
		return progCode;
	}
	/**
	 * @param progCode The progCode to set.
	 */
	public void setProgCode(String progCode) {
		this.progCode = progCode;
	}
	/**
	 * @return Returns the progName.
	 */
	public String getProgName() {
		return progName;
	}
	/**
	 * @param progName The progName to set.
	 */
	public void setProgName(String progName) {
		this.progName = progName;
	}
	/**
	 * @return Returns the revAdminAmnt.
	 */
	public String getRevAdminAmnt() {
		return revAdminAmnt;
	}
	/**
	 * @param revAdminAmnt The revAdminAmnt to set.
	 */
	public void setRevAdminAmnt(String revAdminAmnt) {
		this.revAdminAmnt = revAdminAmnt;
	}
	/**
	 * @return Returns the revAdminDate.
	 */
	public String getRevAdminDate() {
		return revAdminDate;
	}
	/**
	 * @param revAdminDate The revAdminDate to set.
	 */
	public void setRevAdminDate(String revAdminDate) {
		this.revAdminDate = revAdminDate;
	}
	/**
	 * @return Returns the revAdminHabNames.
	 */
	public String getRevAdminHabNames() {
		return revAdminHabNames;
	}
	/**
	 * @param revAdminHabNames The revAdminHabNames to set.
	 */
	public void setRevAdminHabNames(String revAdminHabNames) {
		this.revAdminHabNames = revAdminHabNames;
	}
	/**
	 * @return Returns the revAdminHabsBen.
	 */
	public String getRevAdminHabsBen() {
		return revAdminHabsBen;
	}
	/**
	 * @param revAdminHabsBen The revAdminHabsBen to set.
	 */
	public void setRevAdminHabsBen(String revAdminHabsBen) {
		this.revAdminHabsBen = revAdminHabsBen;
	}
	/**
	 * @return Returns the revAdminNo.
	 */
	public String getRevAdminNo() {
		return revAdminNo;
	}
	/**
	 * @param revAdminNo The revAdminNo to set.
	 */
	public void setRevAdminNo(String revAdminNo) {
		this.revAdminNo = revAdminNo;
	}
	/**
	 * @return Returns the revPlainPopu.
	 */
	public String getRevPlainPopu() {
		return revPlainPopu;
	}
	/**
	 * @param revPlainPopu The revPlainPopu to set.
	 */
	public void setRevPlainPopu(String revPlainPopu) {
		this.revPlainPopu = revPlainPopu;
	}
	/**
	 * @return Returns the revScPopu.
	 */
	public String getRevScPopu() {
		return revScPopu;
	}
	/**
	 * @param revScPopu The revScPopu to set.
	 */
	public void setRevScPopu(String revScPopu) {
		this.revScPopu = revScPopu;
	}
	/**
	 * @return Returns the revSsrYear.
	 */
	public String getRevSsrYear() {
		return revSsrYear;
	}
	/**
	 * @param revSsrYear The revSsrYear to set.
	 */
	public void setRevSsrYear(String revSsrYear) {
		this.revSsrYear = revSsrYear;
	}
	/**
	 * @return Returns the revSTPopu.
	 */
	public String getRevSTPopu() {
		return revSTPopu;
	}
	/**
	 * @param revSTPopu The revSTPopu to set.
	 */
	public void setRevSTPopu(String revSTPopu) {
		this.revSTPopu = revSTPopu;
	}
	/**
	 * @return Returns the revTotpopu.
	 */
	public String getRevTotpopu() {
		return revTotpopu;
	}
	/**
	 * @param revTotpopu The revTotpopu to set.
	 */
	public void setRevTotpopu(String revTotpopu) {
		this.revTotpopu = revTotpopu;
	}
	/**
	 * @return Returns the revTsAccBy.
	 */
	public String getRevTsAccBy() {
		return revTsAccBy;
	}
	/**
	 * @param revTsAccBy The revTsAccBy to set.
	 */
	public void setRevTsAccBy(String revTsAccBy) {
		this.revTsAccBy = revTsAccBy;
	}
	/**
	 * @return Returns the revTsAmnt.
	 */
	public String getRevTsAmnt() {
		return revTsAmnt;
	}
	/**
	 * @param revTsAmnt The revTsAmnt to set.
	 */
	public void setRevTsAmnt(String revTsAmnt) {
		this.revTsAmnt = revTsAmnt;
	}
	/**
	 * @return Returns the revTsDate.
	 */
	public String getRevTsDate() {
		return revTsDate;
	}
	/**
	 * @param revTsDate The revTsDate to set.
	 */
	public void setRevTsDate(String revTsDate) {
		this.revTsDate = revTsDate;
	}
	/**
	 * @return Returns the revTsHabNames.
	 */
	public String getRevTsHabNames() {
		return revTsHabNames;
	}
	/**
	 * @param revTsHabNames The revTsHabNames to set.
	 */
	public void setRevTsHabNames(String revTsHabNames) {
		this.revTsHabNames = revTsHabNames;
	}
	/**
	 * @return Returns the revTsHabsBen.
	 */
	public String getRevTsHabsBen() {
		return revTsHabsBen;
	}
	/**
	 * @param revTsHabsBen The revTsHabsBen to set.
	 */
	public void setRevTsHabsBen(String revTsHabsBen) {
		this.revTsHabsBen = revTsHabsBen;
	}
	/**
	 * @return Returns the revTsMode.
	 */
	public String getRevTsMode() {
		return revTsMode;
	}
	/**
	 * @param revTsMode The revTsMode to set.
	 */
	public void setRevTsMode(String revTsMode) {
		this.revTsMode = revTsMode;
	}
	/**
	 * @return Returns the revTsNo.
	 */
	public String getRevTsNo() {
		return revTsNo;
	}
	/**
	 * @param revTsNo The revTsNo to set.
	 */
	public void setRevTsNo(String revTsNo) {
		this.revTsNo = revTsNo;
	}
	/**
	 * @return Returns the revTsOffice.
	 */
	public String getRevTsOffice() {
		return revTsOffice;
	}
	/**
	 * @param revTsOffice The revTsOffice to set.
	 */
	public void setRevTsOffice(String revTsOffice) {
		this.revTsOffice = revTsOffice;
	}
	/**
	 * @return Returns the revTsPlainPopu.
	 */
	public String getRevTsPlainPopu() {
		return revTsPlainPopu;
	}
	/**
	 * @param revTsPlainPopu The revTsPlainPopu to set.
	 */
	public void setRevTsPlainPopu(String revTsPlainPopu) {
		this.revTsPlainPopu = revTsPlainPopu;
	}
	/**
	 * @return Returns the revTsScPopu.
	 */
	public String getRevTsScPopu() {
		return revTsScPopu;
	}
	/**
	 * @param revTsScPopu The revTsScPopu to set.
	 */
	public void setRevTsScPopu(String revTsScPopu) {
		this.revTsScPopu = revTsScPopu;
	}
	/**
	 * @return Returns the revTsSTPopu.
	 */
	public String getRevTsSTPopu() {
		return revTsSTPopu;
	}
	/**
	 * @param revTsSTPopu The revTsSTPopu to set.
	 */
	public void setRevTsSTPopu(String revTsSTPopu) {
		this.revTsSTPopu = revTsSTPopu;
	}
	/**
	 * @return Returns the revTsTotpopu.
	 */
	public String getRevTsTotpopu() {
		return revTsTotpopu;
	}
	/**
	 * @param revTsTotpopu The revTsTotpopu to set.
	 */
	public void setRevTsTotpopu(String revTsTotpopu) {
		this.revTsTotpopu = revTsTotpopu;
	}
	/**
	 * @return Returns the scheme.
	 */
	public String getScheme() {
		return scheme;
	}
	/**
	 * @param scheme The scheme to set.
	 */
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	/**
	 * @return Returns the schemeCode.
	 */
	public String getSchemeCode() {
		return schemeCode;
	}
	/**
	 * @param schemeCode The schemeCode to set.
	 */
	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}
	/**
	 * @return Returns the siteHandOverDate.
	 */
	public String getSiteHandOverDate() {
		return siteHandOverDate;
	}
	/**
	 * @param siteHandOverDate The siteHandOverDate to set.
	 */
	public void setSiteHandOverDate(String siteHandOverDate) {
		this.siteHandOverDate = siteHandOverDate;
	}
	/**
	 * @return Returns the ssrYear.
	 */
	public String getSsrYear() {
		return ssrYear;
	}
	/**
	 * @param ssrYear The ssrYear to set.
	 */
	public void setSsrYear(String ssrYear) {
		this.ssrYear = ssrYear;
	}
	/**
	 * @return Returns the stage.
	 */
	public String getStage() {
		return stage;
	}
	/**
	 * @param stage The stage to set.
	 */
	public void setStage(String stage) {
		this.stage = stage;
	}
	/**
	 * @return Returns the stipulatedDate.
	 */
	public String getStipulatedDate() {
		return stipulatedDate;
	}
	/**
	 * @param stipulatedDate The stipulatedDate to set.
	 */
	public void setStipulatedDate(String stipulatedDate) {
		this.stipulatedDate = stipulatedDate;
	}
	/**
	 * @return Returns the subDivCode.
	 */
	public String getSubDivCode() {
		return subDivCode;
	}
	/**
	 * @param subDivCode The subDivCode to set.
	 */
	public void setSubDivCode(String subDivCode) {
		this.subDivCode = subDivCode;
	}
	/**
	 * @return Returns the subDivName.
	 */
	public String getSubDivName() {
		return subDivName;
	}
	/**
	 * @param subDivName The subDivName to set.
	 */
	public void setSubDivName(String subDivName) {
		this.subDivName = subDivName;
	}
	/**
	 * @return Returns the subProgCode.
	 */
	public String getSubProgCode() {
		return subProgCode;
	}
	/**
	 * @param subProgCode The subProgCode to set.
	 */
	public void setSubProgCode(String subProgCode) {
		this.subProgCode = subProgCode;
	}
	/**
	 * @return Returns the subProgName.
	 */
	public String getSubProgName() {
		return subProgName;
	}
	/**
	 * @param subProgName The subProgName to set.
	 */
	public void setSubProgName(String subProgName) {
		this.subProgName = subProgName;
	}
	/**
	 * @return Returns the targetDate.
	 */
	public String getTargetDate() {
		return targetDate;
	}
	/**
	 * @param targetDate The targetDate to set.
	 */
	public void setTargetDate(String targetDate) {
		this.targetDate = targetDate;
	}
	/**
	 * @return Returns the tenCost.
	 */
	public String getTenCost() {
		return tenCost;
	}
	/**
	 * @param tenCost The tenCost to set.
	 */
	public void setTenCost(String tenCost) {
		this.tenCost = tenCost;
	}
	/**
	 * @return Returns the tenId.
	 */
	public String getTenId() {
		return tenId;
	}
	/**
	 * @param tenId The tenId to set.
	 */
	public void setTenId(String tenId) {
		this.tenId = tenId;
	}
	/**
	 * @return Returns the tenPer.
	 */
	public String getTenPer() {
		return tenPer;
	}
	/**
	 * @param tenPer The tenPer to set.
	 */
	public void setTenPer(String tenPer) {
		this.tenPer = tenPer;
	}
	/**
	 * @return Returns the tsAccBy.
	 */
	public String getTsAccBy() {
		return tsAccBy;
	}
	/**
	 * @param tsAccBy The tsAccBy to set.
	 */
	public void setTsAccBy(String tsAccBy) {
		this.tsAccBy = tsAccBy;
	}
	/**
	 * @return Returns the tsAmnt.
	 */
	public String getTsAmnt() {
		return tsAmnt;
	}
	/**
	 * @param tsAmnt The tsAmnt to set.
	 */
	public void setTsAmnt(String tsAmnt) {
		this.tsAmnt = tsAmnt;
	}
	/**
	 * @return Returns the tsDate.
	 */
	public String getTsDate() {
		return tsDate;
	}
	/**
	 * @param tsDate The tsDate to set.
	 */
	public void setTsDate(String tsDate) {
		this.tsDate = tsDate;
	}
	/**
	 * @return Returns the tsHabNames.
	 */
	public String getTsHabNames() {
		return tsHabNames;
	}
	/**
	 * @param tsHabNames The tsHabNames to set.
	 */
	public void setTsHabNames(String tsHabNames) {
		this.tsHabNames = tsHabNames;
	}
	/**
	 * @return Returns the tsHabsBen.
	 */
	public String getTsHabsBen() {
		return tsHabsBen;
	}
	/**
	 * @param tsHabsBen The tsHabsBen to set.
	 */
	public void setTsHabsBen(String tsHabsBen) {
		this.tsHabsBen = tsHabsBen;
	}
	/**
	 * @return Returns the tsMode.
	 */
	public String getTsMode() {
		return tsMode;
	}
	/**
	 * @param tsMode The tsMode to set.
	 */
	public void setTsMode(String tsMode) {
		this.tsMode = tsMode;
	}
	/**
	 * @return Returns the tsNo.
	 */
	public String getTsNo() {
		return tsNo;
	}
	/**
	 * @param tsNo The tsNo to set.
	 */
	public void setTsNo(String tsNo) {
		this.tsNo = tsNo;
	}
	/**
	 * @return Returns the tsOffice.
	 */
	public String getTsOffice() {
		return tsOffice;
	}
	/**
	 * @param tsOffice The tsOffice to set.
	 */
	public void setTsOffice(String tsOffice) {
		this.tsOffice = tsOffice;
	}
	/**
	 * @return Returns the tsPlainPop.
	 */
	public String getTsPlainPop() {
		return tsPlainPop;
	}
	/**
	 * @param tsPlainPop The tsPlainPop to set.
	 */
	public void setTsPlainPop(String tsPlainPop) {
		this.tsPlainPop = tsPlainPop;
	}
	/**
	 * @return Returns the tsScPop.
	 */
	public String getTsScPop() {
		return tsScPop;
	}
	/**
	 * @param tsScPop The tsScPop to set.
	 */
	public void setTsScPop(String tsScPop) {
		this.tsScPop = tsScPop;
	}
	/**
	 * @return Returns the tsStPop.
	 */
	public String getTsStPop() {
		return tsStPop;
	}
	/**
	 * @param tsStPop The tsStPop to set.
	 */
	public void setTsStPop(String tsStPop) {
		this.tsStPop = tsStPop;
	}
	/**
	 * @return Returns the tsTotPop.
	 */
	public String getTsTotPop() {
		return tsTotPop;
	}
	/**
	 * @param tsTotPop The tsTotPop to set.
	 */
	public void setTsTotPop(String tsTotPop) {
		this.tsTotPop = tsTotPop;
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
	 * @return Returns the workStage.
	 */
	public String getWorkStage() {
		return workStage;
	}
	/**
	 * @param workStage The workStage to set.
	 */
	public void setWorkStage(String workStage) {
		this.workStage = workStage;
	}
	/**
	 * @return Returns the mileStoneName.
	 */
	public String getMileStoneName() {
		return mileStoneName;
	}
	/**
	 * @param mileStoneName The mileStoneName to set.
	 */
	public void setMileStoneName(String mileStoneName) {
		this.mileStoneName = mileStoneName;
	}
	/**
	 * @return Returns the stages.
	 */
	public java.util.ArrayList getStages() {
		return stages;
	}
	/**
	 * @param stages The stages to set.
	 */
	public void setStages(java.util.ArrayList stages) {
		this.stages = stages;
	}
	/**
	 * @return Returns the stageName.
	 */
	public String getStageName() {
		return stageName;
	}
	/**
	 * @param stageName The stageName to set.
	 */
	public void setStageName(String stageName) {
		this.stageName = stageName;
	}
	public String getRevTsNoOfHabs() {
		return revTsNoOfHabs;
	}
	public void setRevTsNoOfHabs(String revTsNoOfHabs) {
		this.revTsNoOfHabs = revTsNoOfHabs;
	}
	public String getTenAcceptedDate() {
		return tenAcceptedDate;
	}
	public void setTenAcceptedDate(String tenAcceptedDate) {
		this.tenAcceptedDate = tenAcceptedDate;
	}
	public String getTenCommitee() {
		return tenCommitee;
	}
	public void setTenCommitee(String tenCommitee) {
		this.tenCommitee = tenCommitee;
	}
	public String getTenCompetentAuthority() {
		return tenCompetentAuthority;
	}
	public void setTenCompetentAuthority(String tenCompetentAuthority) {
		this.tenCompetentAuthority = tenCompetentAuthority;
	}
	public String[] getTenCommiteeArr() {
		return tenCommiteeArr;
	}
	public void setTenCommiteeArr(String[] tenCommiteeArr) {
		this.tenCommiteeArr = tenCommiteeArr;
	}
	/**
	 * @return Returns the syr.
	 */
	public String getSyr() {
		return syr;
	}
	/**
	 * @param syr The syr to set.
	 */
	public void setSyr(String syr) {
		this.syr = syr;
	}
	/**
	 * @return Returns the syr1.
	 */
	public String getSyr1() {
		return syr1;
	}
	/**
	 * @param syr1 The syr1 to set.
	 */
	public void setSyr1(String syr1) {
		this.syr1 = syr1;
	}
	/**
	 * @return Returns the subdivisioncode.
	 */
	public String getSubdivisioncode() {
		return subdivisioncode;
	}
	/**
	 * @param subdivisioncode The subdivisioncode to set.
	 */
	public void setSubdivisioncode(String subdivisioncode) {
		this.subdivisioncode = subdivisioncode;
	}
	/**
	 * @return Returns the program.
	 */
	public String getProgram() {
		return program;
	}
	/**
	 * @param program The program to set.
	 */
	public void setProgram(String program) {
		this.program = program;
	}
	/**
	 * @return Returns the subprogram.
	 */
	public String getSubprogram() {
		return subprogram;
	}
	/**
	 * @param subprogram The subprogram to set.
	 */
	public void setSubprogram(String subprogram) {
		this.subprogram = subprogram;
	}
	
	
	
	/**
	 * @return Returns the plan.
	 */
	public String getPlan() {
		return plan;
	}
	/**
	 * @param plan The plan to set.
	 */
	public void setPlan(String plan) {
		this.plan = plan;
	}
	/**
	 * @return Returns the workCat.
	 */
	public String getWorkCat() {
		return workCat;
	}
	/**
	 * @param workCat The workCat to set.
	 */
	public void setWorkCat(String workCat) {
		this.workCat = workCat;
	}
	/**
	 * @return Returns the wrktype.
	 */
	public String getWrktype() {
		return wrktype;
	}
	/**
	 * @param wrktype The wrktype to set.
	 */
	public void setWrktype(String wrktype) {
		this.wrktype = wrktype;
	}
	/**
	 * @return Returns the tenId1.
	 */
	public String getTenId1() {
		return tenId1;
	}
	/**
	 * @param tenId1 The tenId1 to set.
	 */
	public void setTenId1(String tenId1) {
		this.tenId1 = tenId1;
	}
	/**
	 * @return Returns the workEnt.
	 */
	public String getWorkEnt() {
		return workEnt;
	}
	/**
	 * @param workEnt The workEnt to set.
	 */
	public void setWorkEnt(String workEnt) {
		this.workEnt = workEnt;
	}
	/**
	 * @return Returns the workPer1.
	 */
	public String getWorkPer1() {
		return workPer1;
	}
	/**
	 * @param workPer1 The workPer1 to set.
	 */
	public void setWorkPer1(String workPer1) {
		this.workPer1 = workPer1;
	}
	
	public String getProbCompDate() {
		return probCompDate;
	}
	public void setProbCompDate(String probCompDate) {
		this.probCompDate = probCompDate;
	}
	
	/**
	 * @return Returns the category.
	 */
	public String getCategory() {
		return category;
	}
	/**
	 * @param category The category to set.
	 */
	public void setCategory(String category) {
		this.category = category;
	}
	/**
	 * @return Returns the classification.
	 */
	public String getClassification() {
		return classification;
	}
	/**
	 * @param classification The classification to set.
	 */
	public void setClassification(String classification) {
		this.classification = classification;
	}
	/**
	 * @return Returns the habitation.
	 */
	public String getHabitation() {
		return habitation;
	}
	/**
	 * @param habitation The habitation to set.
	 */
	public void setHabitation(String habitation) {
		this.habitation = habitation;
	}
	/**
	 * @return Returns the habName.
	 */
	public String getHabName() {
		return habName;
	}
	/**
	 * @param habName The habName to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
	}
	/**
	 * @return Returns the panchayat.
	 */
	public String getPanchayat() {
		return panchayat;
	}
	/**
	 * @param panchayat The panchayat to set.
	 */
	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}
	/**
	 * @return Returns the schoolCode.
	 */
	public String getSchoolCode() {
		return schoolCode;
	}
	/**
	 * @param schoolCode The schoolCode to set.
	 */
	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}
	/**
	 * @return Returns the schoolHabCode.
	 */
	public String getSchoolHabCode() {
		return schoolHabCode;
	}
	/**
	 * @param schoolHabCode The schoolHabCode to set.
	 */
	public void setSchoolHabCode(String schoolHabCode) {
		this.schoolHabCode = schoolHabCode;
	}
	/**
	 * @return Returns the schoolName.
	 */
	public String getSchoolName() {
		return schoolName;
	}
	/**
	 * @param schoolName The schoolName to set.
	 */
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	/**
	 * @return Returns the totStudents.
	 */
	public String getTotStudents() {
		return totStudents;
	}
	/**
	 * @param totStudents The totStudents to set.
	 */
	public void setTotStudents(String totStudents) {
		this.totStudents = totStudents;
	}
	/**
	 * @return Returns the village.
	 */
	public String getVillage() {
		return village;
	}
	/**
	 * @param village The village to set.
	 */
	public void setVillage(String village) {
		this.village = village;
	}
	
	/**
	 * @return Returns the alreadyExists.
	 */
	public String getAlreadyExists() {
		return alreadyExists;
	}
	/**
	 * @param alreadyExists The alreadyExists to set.
	 */
	public void setAlreadyExists(String alreadyExists) {
		this.alreadyExists = alreadyExists;
	}
	
	public String getCompInNo() {
		return compInNo;
	}
	public void setCompInNo(String compInNo) {
		this.compInNo = compInNo;
	}
	public String getMajorMileStone() {
		return majorMileStone;
	}
	public void setMajorMileStone(String majorMileStone) {
		this.majorMileStone = majorMileStone;
	}
	
	public String getPerCompInWork() {
		return perCompInWork;
	}
	public void setPerCompInWork(String perCompInWork) {
		this.perCompInWork = perCompInWork;
	}
	
	public String getMileStoneSno() {
		return mileStoneSno;
	}
	public void setMileStoneSno(String mileStoneSno) {
		this.mileStoneSno = mileStoneSno;
	}
	
	public String getPerCompInWorkValue() {
		return perCompInWorkValue;
	}
	public void setPerCompInWorkValue(String perCompInWorkValue) {
		this.perCompInWorkValue = perCompInWorkValue;
	}
	public String getPerCompValue() {
		return perCompValue;
	}
	public void setPerCompValue(String perCompValue) {
		this.perCompValue = perCompValue;
	}
	
	public String getTypeOfContractor() {
		return typeOfContractor;
	}
	public void setTypeOfContractor(String typeOfContractor) {
		this.typeOfContractor = typeOfContractor;
	}
	
	public String getEoatTargetDate() {
		return eoatTargetDate;
	}
	public void setEoatTargetDate(String eoatTargetDate) {
		this.eoatTargetDate = eoatTargetDate;
	}
	
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getMilestone1() {
		return milestone1;
	}
	public void setMilestone1(String milestone1) {
		this.milestone1 = milestone1;
	}
}
