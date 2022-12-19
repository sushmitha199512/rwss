/**
 * Created on Jun 15, 2007
 
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.RwsLocationBean;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import java.util.ArrayList;

/**
 * 
 * @author RWSS_DPT1
 * 
 */
public class rws_works_WorkStatus_form extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String nwork;

	/**
	 * @return Returns the nwork.
	 */
	public String getNwork() {
		return nwork;
	}

	/**
	 * @param nwork
	 *            The nwork to set.
	 */
	public void setNwork(String nwork) {
		this.nwork = nwork;
	}

	private String nmode;

	/**
	 * @return Returns the nmode.
	 */
	public String getNmode() {
		return nmode;
	}

	/**
	 * @param nmode
	 *            The nmode to set.
	 */
	public void setNmode(String nmode) {
		this.nmode = nmode;
	}

	private String partASanAMount;

	private String partialDateOfCompletion;
	private String percentCompleted;

	/**
	 * @return Returns the percentCompleted.
	 */
	public String getPercentCompleted() {
		return percentCompleted;
	}

	/**
	 * @param percentCompleted
	 *            The percentCompleted to set.
	 */
	public void setPercentCompleted(String percentCompleted) {
		this.percentCompleted = percentCompleted;
	}

	// added by swapna on 18-10-2011
	private String milestone1;
	//
	// added by swapna
	private String financialyear;
	private String schemelist;
	//
	private String officeCode;
	private String preparedBy;
	private String mode;
	private String mode1;
	private String circleName;
	private String circleCode;
	private String divName;
	private String divCode;
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
	/** Admin Sanction */
	private String adminAmnt;
	private String adminDate;
	private String adminNo;
	private String adminHabsBen;
	private String adminHabNames;
	private String adminPlainPopu;
	private String adminScPopu;
	private String adminSTPopu;
	private String adminTotpopu;
	/** Revised admin */
	private String revAdminAmnt;
	private String revAdminDate;
	private String revAdminNo;
	private String revAdminHabsBen;
	private String revAdminHabNames;
	private String revPlainPopu;
	private String revScPopu;
	private String revSTPopu;
	private String revTotpopu;
	/** Technical sanction */
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
	/** Revised Tecnicla saction */
	private String revTsMode = "data";
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
	/** Contractor manageement */
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
	private String mileStone;
	private String mileStoneSno;
	private String majorMileStone;
	private String stage;
	private String compInNo;
	private String targetDate;
	private String perComp;
	private String perCompInWork;
	private String tenDate;
	private String tenApprovedBy;
	private String tenAcceptedDate;
	private ArrayList mileStones;
	private String conMode;
	private String tenCommitee;
	private String tenCompetentAuthority;
	private String[] tenCommiteeArr;
	private String syr;
	private String syr1;
	private String subdivisioncode;
	private String program;
	private String subprogram;

	private String plan;
	private String wrktype;
	private String workCat;

	private String workEnt;
	private String workPer1;
	private String tenId1;

	// Source Identification

	private String siMode;
	private String subcompType;
	private String subSourceType;
	private String mandalCode;
	private String panchayatCode;
	private String villageCode;
	private String habsCode;
	private String mandalName;
	private String codeStatus;
	private String srcType;
	private String srcCode;
	private String srcName;
	private String srcIdby;
	private String siteHODate;
	private String recommend;
	private String slNo;
	private String newsrcName;
	private String newsrcCode;
	private String sitehab;
	private String spradgroup;
	private String revflag;
	private String revdel;
	private String probCompDate;
	// Program Schedule

	private String psMode;
	private String subDivAssign;
	private String engineerAssign;
	private String engineerAssign1;
	private String engineerAssign2;
	private String engineerAssign3;
	private String workGndDate;
	private String agreeDate;
	private String workUpdateProbDate;
	private String augType;

	// Work Expenditure

	private String weMode;
	private String expUptoPrevYear;
	private String expYears;
	private String aggrigateExpenditureForProg;
	private double totalExp;
	private ArrayList expenditureList;
	private String admSanDate;
	private String workCount;
	private ArrayList programmeList;
	private String valueOFWorkDone;
	private String valueOFWorkDoneButnotPaid;
	// Work Completion

	private String wcMode;
	private String workCompStartDate;
	private String workCompStipulatedDtOfComp;
	private String workCompActualDtOfComp;
	private String dateOfComm;
	private String workCompFinDtOfComp;
	private String techHabsBen;
	private String remarks;
	private String workCompStipulatedDateOfCompletion;
	private String workCompDateCompleted;
	private String plainPop;
	private String scPop;
	private String stPop;
	private String eplainPop;
	private String escPop;
	private String estPop;
	private String estTotPop;
	private String techHabNames;

	// added by ramesh on 19112010 for work completion form changes
	private String standPosts;
	private String houseConns;
	private String priYesOrNo;

	// newly added by ramesh on 201009

	private String headOfficeName;
	private String headOfficeCode;
	private String circleOfficeName;
	private String circleOfficeCode;
	private String divisionOfficeName;
	private String divisionOfficeCode;
	private String subdivisionOfficeName;
	private String subdivisionOfficeCode;
	private String district;
	private String dCode;
	private String mandal;
	private String habName;
	private String habCode;
	private String assetTypeName;
	private String assetTypeCode;
	private String assetCode;
	private String pumpCode;
	private String assetName;
	private String location;
	private String assetStatusName;
	private String assetStatus;
	private String startYear;
	private String dateofCreation;
	private String assetCost;
	private String totHabs;
	private String totPopBenfit;
	// added by ramesh on 061109
	private String physicalStatus;
	private String physicalStatusDetails;
	private String workCancelledDate;
	private String samount;
	private ArrayList astwork;
	private ArrayList assettype;
	private ArrayList rows;
	private ArrayList assets;
	private String schoolCode;
	private String schoolDetails;
	private String sanctionAmountChange;

	private ArrayList contractorList;
	private String reasonCodeNotGround;
	private String indTapLocation;
	private int indTapType;
	private String pendingFHTC;
	private ArrayList selectedHabs;

	private String token;
	
	
	
	public String getPendingFHTC() {
		return pendingFHTC;
	}

	public void setPendingFHTC(String pendingFHTC) {
		this.pendingFHTC = pendingFHTC;
	}

	public ArrayList getSelectedHabs() {
		return selectedHabs;
	}

	public void setSelectedHabs(ArrayList selectedHabs) {
		this.selectedHabs = selectedHabs;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public tenderMemo getWORKS_DELETES(int index) {
		while (index >= contractorList.size()) {
			contractorList.add(new tenderMemo());
		}
		return (tenderMemo) contractorList.get(index);
	}

	// added by ramesh on 14072010
	private ArrayList vouchersList;

	/**
	 * @return Returns the program.
	 */
	public String getProgram() {
		return program;
	}

	/**
	 * @param program
	 *            The program to set.
	 */
	public void setProgram(String program) {
		this.program = program;
	}

	public String getSanctionAmountChange() {
		return sanctionAmountChange;
	}

	public void setSanctionAmountChange(String sanctionAmountChange) {
		this.sanctionAmountChange = sanctionAmountChange;
	}

	/**
	 * @return Returns the mileStoneName.
	 */
	public String getMileStoneName() {
		return mileStoneName;
	}

	/**
	 * @param mileStoneName
	 *            The mileStoneName to set.
	 */
	public void setMileStoneName(String mileStoneName) {
		this.mileStoneName = mileStoneName;
	}

	private String mileStoneName;

	// constructor
	public rws_works_WorkStatus_form() {
		mileStones = new ArrayList();
		expenditureList = new ArrayList();
		programmeList = new ArrayList();
	}
	public RwsLocationBean getSELECTED_HABS_LIST(int index) {
		while (index >= selectedHabs.size()) {
			selectedHabs.add(new RwsLocationBean());
		}

		return (RwsLocationBean) selectedHabs.get(index);
	}
	public tenderMemo getVOUCHER_LIST(int index) {
		while (index >= vouchersList.size()) {
			vouchersList.add(new tenderMemo());
		}

		return (tenderMemo) vouchersList.get(index);
	}

	public tenderMemo getWORKEXP_LIST(int index) {
		while (index >= expenditureList.size()) {
			expenditureList.add(new tenderMemo());
		}

		return (tenderMemo) expenditureList.get(index);
	}

	public rws_works_WorkStatus_bean getMILES(int index) {
		while (index >= mileStones.size()) {
			mileStones.add(new rws_works_WorkStatus_bean());
		}
		return (rws_works_WorkStatus_bean) mileStones.get(index);
	}

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		/*
		 * this.circleCode=" "; this.divCode=" "; this.workId=" ";
		 * this.progName=" "; this.subProgName=" "; this.scheme=" ";
		 * this.workStage=" "; this.tsAccBy=" "; this.tsAmnt=" ";
		 * this.tsDate=" "; this.tsNo=" "; this.ssrYear=" "; this.revTsNo=" ";
		 * this.revTsDate=" "; this.revTsHabsBen=" "; this.revTsAmnt=" ";
		 * this.program=""; this.plan=""; this.wrktype=""; this.workCat="";
		 * this.workEnt=""; this.workPer1=""; this.tenId1="";
		 */
		/*
		 * @Added by MANOJ.
		 */
		
		this.officeCode = "";
		this.preparedBy = "";
		this.mode = "";
		this.circleName = "";
		this.circleCode = "";
		this.divName = "";
		this.divCode = "";
		this.subDivCode = "";
		this.subDivName = "";
		this.workId = "";
		this.workName = "";
		this.progName = "";
		this.subProgName = "";
		this.scheme = "";
		this.schemeCode = "";
		this.progCode = "";
		this.subProgCode = "";
		this.workStage = "";
		this.workCancelledDate = "";
		this.adminAmnt = "";
		this.adminDate = "";
		this.adminNo = "";
		this.adminHabsBen = "";
		this.adminHabNames = "";
		this.adminPlainPopu = "";
		// this.adminScPopu="";
		// this.adminSTPopu="";
		this.adminTotpopu = "";

		this.revAdminAmnt = "";
		this.revAdminDate = "";
		this.revAdminNo = "";
		this.revAdminHabsBen = "";
		this.revAdminHabNames = "";
		this.revPlainPopu = "";
		this.revScPopu = "";
		this.revSTPopu = "";
		this.revTotpopu = "";

		this.tsMode = "";
		this.tsAccBy = "";
		this.tsAmnt = "";
		this.tsNo = "";
		this.tsDate = "";
		this.tsHabsBen = "";
		this.tsHabNames = "";
		this.tsOffice = "";
		this.ssrYear = "";
		this.tsPlainPop = "";
		this.tsScPop = "";
		this.tsStPop = "";
		this.tsTotPop = "";

		this.revTsMode = "data";
		this.revTsAccBy = "";
		this.revTsAmnt = "";
		this.revTsNo = "";
		this.revTsDate = "";
		this.revTsHabsBen = "";
		this.revTsHabNames = "";
		this.revTsOffice = "";
		this.revSsrYear = "";
		this.revTsPlainPopu = "";
		this.revTsScPopu = "";
		this.revTsSTPopu = "";
		this.revTsTotpopu = "";
		this.tenId = "";
		this.tenCost = "";
		this.conName = "";
		this.loaIssued = "";
		this.tenPer = "";
		this.agrRefNo = "";
		this.agrDuration = "";
		this.agrDate = "";
		this.agrValue = "";
		this.siteHandOverDate = "";
		this.stipulatedDate = "";
		this.mileStone = "";
		this.stage = "";
		this.targetDate = "";
		this.perComp = "";
		this.tenDate = "";
		this.tenApprovedBy = "";
		this.tenAcceptedDate = "";
		this.conMode = "";
		this.tenCommitee = "";
		this.tenCompetentAuthority = "";
		this.syr = "";
		this.syr1 = "";
		this.subdivisioncode = "";
		this.program = "";
		this.subprogram = "";
		this.plan = "";
		this.wrktype = "";
		this.workCat = "";
		this.workEnt = "";
		this.workPer1 = "";
		this.tenId1 = "";
	}

	/**
	 * @return Returns the tenApprovedBy.
	 */
	public String getTenApprovedBy() {
		return tenApprovedBy;
	}

	/**
	 * @param tenApprovedBy
	 *            The tenApprovedBy to set.
	 */
	public void setTenApprovedBy(String tenApprovedBy) {
		this.tenApprovedBy = tenApprovedBy;
	}

	/**
	 * @return Returns the adminPlainPopu.
	 */
	public String getAdminPlainPopu() {
		return adminPlainPopu;
	}

	/**
	 * @param adminPlainPopu
	 *            The adminPlainPopu to set.
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
	 * @param adminScPopu
	 *            The adminScPopu to set.
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
	 * @param adminSTPopu
	 *            The adminSTPopu to set.
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
	 * @param adminTotpopu
	 *            The adminTotpopu to set.
	 */
	public void setAdminTotpopu(String adminTotpopu) {
		this.adminTotpopu = adminTotpopu;
	}

	/**
	 * @return Returns the schemeCode.
	 */
	public String getSchemeCode() {
		return schemeCode;
	}

	/**
	 * @param schemeCode
	 *            The schemeCode to set.
	 */
	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}

	/**
	 * @return Returns the revAdminAmnt.
	 */
	public String getRevAdminAmnt() {
		return revAdminAmnt;
	}

	/**
	 * @param revAdminAmnt
	 *            The revAdminAmnt to set.
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
	 * @param revAdminDate
	 *            The revAdminDate to set.
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
	 * @param revAdminHabNames
	 *            The revAdminHabNames to set.
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
	 * @param revAdminHabsBen
	 *            The revAdminHabsBen to set.
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
	 * @param revAdminNo
	 *            The revAdminNo to set.
	 */
	public void setRevAdminNo(String revAdminNo) {
		this.revAdminNo = revAdminNo;
	}

	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}

	/**
	 * @param workId
	 *            The workId to set.
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
	 * @param workName
	 *            The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}

	/**
	 * @return Returns the circleCode.
	 */
	public String getCircleCode() {
		return circleCode;
	}

	/**
	 * @param circleCode
	 *            The circleCode to set.
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
	 * @param circleName
	 *            The circleName to set.
	 */
	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}

	/**
	 * @return Returns the divCode.
	 */
	public String getDivCode() {
		return divCode;
	}

	/**
	 * @param divCode
	 *            The divCode to set.
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
	 * @param divName
	 *            The divName to set.
	 */
	public void setDivName(String divName) {
		this.divName = divName;
	}

	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}

	/**
	 * @param mode
	 *            The mode to set.
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}

	/**
	 * @return Returns the progName.
	 */
	public String getProgName() {
		return progName;
	}

	/**
	 * @param progName
	 *            The progName to set.
	 */
	public void setProgName(String progName) {
		this.progName = progName;
	}

	/**
	 * @return Returns the scheme.
	 */
	public String getScheme() {
		return scheme;
	}

	/**
	 * @param scheme
	 *            The scheme to set.
	 */
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}

	/**
	 * @return Returns the subProgName.
	 */
	public String getSubProgName() {
		return subProgName;
	}

	/**
	 * @param subProgName
	 *            The subProgName to set.
	 */
	public void setSubProgName(String subProgName) {
		this.subProgName = subProgName;
	}

	/**
	 * @return Returns the workStage.
	 */
	public String getWorkStage() {
		return workStage;
	}

	/**
	 * @param workStage
	 *            The workStage to set.
	 */
	public void setWorkStage(String workStage) {
		this.workStage = workStage;
	}

	/**
	 * @return Returns the adminAmnt.
	 */
	public String getAdminAmnt() {
		return adminAmnt;
	}

	/**
	 * @param adminAmnt
	 *            The adminAmnt to set.
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
	 * @param adminDate
	 *            The adminDate to set.
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
	 * @param adminHabNames
	 *            The adminHabNames to set.
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
	 * @param adminHabsBen
	 *            The adminHabsBen to set.
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
	 * @param adminNo
	 *            The adminNo to set.
	 */
	public void setAdminNo(String adminNo) {
		this.adminNo = adminNo;
	}

	/**
	 * @return Returns the tsAccBy.
	 */
	public String getTsAccBy() {
		return tsAccBy;
	}

	/**
	 * @param tsAccBy
	 *            The tsAccBy to set.
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
	 * @param tsAmnt
	 *            The tsAmnt to set.
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
	 * @param tsDate
	 *            The tsDate to set.
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
	 * @param tsHabNames
	 *            The tsHabNames to set.
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
	 * @param tsHabsBen
	 *            The tsHabsBen to set.
	 */
	public void setTsHabsBen(String tsHabsBen) {
		this.tsHabsBen = tsHabsBen;
	}

	/**
	 * @return Returns the tsNo.
	 */
	public String getTsNo() {
		return tsNo;
	}

	/**
	 * @param tsNo
	 *            The tsNo to set.
	 */
	public void setTsNo(String tsNo) {
		this.tsNo = tsNo;
	}

	/**
	 * @return Returns the ssrYear.
	 */
	public String getSsrYear() {
		return ssrYear;
	}

	/**
	 * @param ssrYear
	 *            The ssrYear to set.
	 */
	public void setSsrYear(String ssrYear) {
		this.ssrYear = ssrYear;
	}

	/**
	 * @return Returns the tsMode.
	 */
	public String getTsMode() {
		return tsMode;
	}

	/**
	 * @param tsMode
	 *            The tsMode to set.
	 */
	public void setTsMode(String tsMode) {
		this.tsMode = tsMode;
	}

	/**
	 * @return Returns the officeCode.
	 */
	public String getOfficeCode() {
		return officeCode;
	}

	/**
	 * @param officeCode
	 *            The officeCode to set.
	 */
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}

	/**
	 * @return Returns the preparedBy.
	 */
	public String getPreparedBy() {
		return preparedBy;
	}

	/**
	 * @param preparedBy
	 *            The preparedBy to set.
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
	 * @param progCode
	 *            The progCode to set.
	 */
	public void setProgCode(String progCode) {
		this.progCode = progCode;
	}

	/**
	 * @return Returns the subProgCode.
	 */
	public String getSubProgCode() {
		return subProgCode;
	}

	/**
	 * @param subProgCode
	 *            The subProgCode to set.
	 */
	public void setSubProgCode(String subProgCode) {
		this.subProgCode = subProgCode;
	}

	/**
	 * @return Returns the subDivCode.
	 */
	public String getSubDivCode() {
		return subDivCode;
	}

	/**
	 * @param subDivCode
	 *            The subDivCode to set.
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
	 * @param subDivName
	 *            The subDivName to set.
	 */
	public void setSubDivName(String subDivName) {
		this.subDivName = subDivName;
	}

	/**
	 * @return Returns the tsOffice.
	 */
	public String getTsOffice() {
		return tsOffice;
	}

	/**
	 * @param tsOffice
	 *            The tsOffice to set.
	 */
	public void setTsOffice(String tsOffice) {
		this.tsOffice = tsOffice;
	}

	/**
	 * @return Returns the revSsrYear.
	 */
	public String getRevSsrYear() {
		return revSsrYear;
	}

	/**
	 * @param revSsrYear
	 *            The revSsrYear to set.
	 */
	public void setRevSsrYear(String revSsrYear) {
		this.revSsrYear = revSsrYear;
	}

	/**
	 * @return Returns the revTsAccBy.
	 */
	public String getRevTsAccBy() {
		return revTsAccBy;
	}

	/**
	 * @param revTsAccBy
	 *            The revTsAccBy to set.
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
	 * @param revTsAmnt
	 *            The revTsAmnt to set.
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
	 * @param revTsDate
	 *            The revTsDate to set.
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
	 * @param revTsHabNames
	 *            The revTsHabNames to set.
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
	 * @param revTsHabsBen
	 *            The revTsHabsBen to set.
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
	 * @param revTsMode
	 *            The revTsMode to set.
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
	 * @param revTsNo
	 *            The revTsNo to set.
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
	 * @param revTsOffice
	 *            The revTsOffice to set.
	 */
	public void setRevTsOffice(String revTsOffice) {
		this.revTsOffice = revTsOffice;
	}

	/**
	 * @return Returns the revPlainPopu.
	 */
	public String getRevPlainPopu() {
		return revPlainPopu;
	}

	/**
	 * @param revPlainPopu
	 *            The revPlainPopu to set.
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
	 * @param revScPopu
	 *            The revScPopu to set.
	 */
	public void setRevScPopu(String revScPopu) {
		this.revScPopu = revScPopu;
	}

	/**
	 * @return Returns the revSTPopu.
	 */
	public String getRevSTPopu() {
		return revSTPopu;
	}

	/**
	 * @param revSTPopu
	 *            The revSTPopu to set.
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
	 * @param revTotpopu
	 *            The revTotpopu to set.
	 */
	public void setRevTotpopu(String revTotpopu) {
		this.revTotpopu = revTotpopu;
	}

	/**
	 * @return Returns the tsPlainPop.
	 */
	public String getTsPlainPop() {
		return tsPlainPop;
	}

	/**
	 * @param tsPlainPop
	 *            The tsPlainPop to set.
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
	 * @param tsScPop
	 *            The tsScPop to set.
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
	 * @param tsStPop
	 *            The tsStPop to set.
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
	 * @param tsTotPop
	 *            The tsTotPop to set.
	 */
	public void setTsTotPop(String tsTotPop) {
		this.tsTotPop = tsTotPop;
	}

	/**
	 * @return Returns the revTsPlainPopu.
	 */
	public String getRevTsPlainPopu() {
		return revTsPlainPopu;
	}

	/**
	 * @param revTsPlainPopu
	 *            The revTsPlainPopu to set.
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
	 * @param revTsScPopu
	 *            The revTsScPopu to set.
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
	 * @param revTsSTPopu
	 *            The revTsSTPopu to set.
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
	 * @param revTsTotpopu
	 *            The revTsTotpopu to set.
	 */
	public void setRevTsTotpopu(String revTsTotpopu) {
		this.revTsTotpopu = revTsTotpopu;
	}

	/**
	 * @return Returns the agrDate.
	 */
	public String getAgrDate() {
		return agrDate;
	}

	/**
	 * @param agrDate
	 *            The agrDate to set.
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
	 * @param agrDuration
	 *            The agrDuration to set.
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
	 * @param agrRefNo
	 *            The agrRefNo to set.
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
	 * @param agrValue
	 *            The agrValue to set.
	 */
	public void setAgrValue(String agrValue) {
		this.agrValue = agrValue;
	}

	/**
	 * @return Returns the conName.
	 */
	public String getConName() {
		return conName;
	}

	/**
	 * @param conName
	 *            The conName to set.
	 */
	public void setConName(String conName) {
		this.conName = conName;
	}

	/**
	 * @return Returns the loaIssued.
	 */
	public String getLoaIssued() {
		return loaIssued;
	}

	/**
	 * @param loaIssued
	 *            The loaIssued to set.
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
	 * @param mileStone
	 *            The mileStone to set.
	 */
	public void setMileStone(String mileStone) {
		this.mileStone = mileStone;
	}

	/**
	 * @return Returns the perComp.
	 */
	public String getPerComp() {
		return perComp;
	}

	/**
	 * @param perComp
	 *            The perComp to set.
	 */
	public void setPerComp(String perComp) {
		this.perComp = perComp;
	}

	/**
	 * @return Returns the siteHandOverDate.
	 */
	public String getSiteHandOverDate() {
		return siteHandOverDate;
	}

	/**
	 * @param siteHandOverDate
	 *            The siteHandOverDate to set.
	 */
	public void setSiteHandOverDate(String siteHandOverDate) {
		this.siteHandOverDate = siteHandOverDate;
	}

	/**
	 * @return Returns the stage.
	 */
	public String getStage() {
		return stage;
	}

	/**
	 * @param stage
	 *            The stage to set.
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
	 * @param stipulatedDate
	 *            The stipulatedDate to set.
	 */
	public void setStipulatedDate(String stipulatedDate) {
		this.stipulatedDate = stipulatedDate;
	}

	/**
	 * @return Returns the targetDate.
	 */
	public String getTargetDate() {
		return targetDate;
	}

	/**
	 * @param targetDate
	 *            The targetDate to set.
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
	 * @param tenCost
	 *            The tenCost to set.
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
	 * @param tenId
	 *            The tenId to set.
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
	 * @param tenPer
	 *            The tenPer to set.
	 */
	public void setTenPer(String tenPer) {
		this.tenPer = tenPer;
	}

	/**
	 * @return Returns the tenDate.
	 */
	public String getTenDate() {
		return tenDate;
	}

	/**
	 * @param tenDate
	 *            The tenDate to set.
	 */
	public void setTenDate(String tenDate) {
		this.tenDate = tenDate;
	}

	/**
	 * @return Returns the mileStones.
	 */
	public ArrayList getMileStones() {
		return mileStones;
	}

	/**
	 * @param mileStones
	 *            The mileStones to set.
	 */
	public void setMileStones(ArrayList mileStones) {
		this.mileStones = mileStones;
	}

	/**
	 * @return Returns the conMode.
	 */
	public String getConMode() {
		return conMode;
	}

	/**
	 * @param conMode
	 *            The conMode to set.
	 */
	public void setConMode(String conMode) {
		this.conMode = conMode;
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

	public String getSyr() {
		return syr;
	}

	public void setSyr(String syr) {
		this.syr = syr;
	}

	public String getSyr1() {
		return syr1;
	}

	public void setSyr1(String syr1) {
		this.syr1 = syr1;
	}

	public String getSubdivisioncode() {
		return subdivisioncode;
	}

	public void setSubdivisioncode(String subdivisioncode) {
		this.subdivisioncode = subdivisioncode;
	}

	public String getSubprogram() {
		return subprogram;
	}

	public void setSubprogram(String subprogram) {
		this.subprogram = subprogram;
	}

	public String getPlan() {
		return plan;
	}

	public void setPlan(String plan) {
		this.plan = plan;
	}

	public String getWorkCat() {
		return workCat;
	}

	public void setWorkCat(String workCat) {
		this.workCat = workCat;
	}

	public String getWrktype() {
		return wrktype;
	}

	public void setWrktype(String wrktype) {
		this.wrktype = wrktype;
	}

	public String getTenId1() {
		return tenId1;
	}

	public void setTenId1(String tenId1) {
		this.tenId1 = tenId1;
	}

	public String getWorkEnt() {
		return workEnt;
	}

	public void setWorkEnt(String workEnt) {
		this.workEnt = workEnt;
	}

	public String getWorkPer1() {
		return workPer1;
	}

	public void setWorkPer1(String workPer1) {
		this.workPer1 = workPer1;
	}

	public String getSiMode() {
		return siMode;
	}

	public void setSiMode(String siMode) {
		this.siMode = siMode;
	}

	public String getSubcompType() {
		return subcompType;
	}

	public void setSubcompType(String subcompType) {
		this.subcompType = subcompType;
	}

	public String getSubSourceType() {
		return subSourceType;
	}

	public void setSubSourceType(String subSourceType) {
		this.subSourceType = subSourceType;
	}

	public String getCodeStatus() {
		return codeStatus;
	}

	public void setCodeStatus(String codeStatus) {
		this.codeStatus = codeStatus;
	}

	public String getMandalCode() {
		return mandalCode;
	}

	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
	}

	public String getMandalName() {
		return mandalName;
	}

	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}

	public String getNewsrcCode() {
		return newsrcCode;
	}

	public void setNewsrcCode(String newsrcCode) {
		this.newsrcCode = newsrcCode;
	}

	public String getNewsrcName() {
		return newsrcName;
	}

	public void setNewsrcName(String newsrcName) {
		this.newsrcName = newsrcName;
	}

	public String getRecommend() {
		return recommend;
	}

	public void setRecommend(String recommend) {
		this.recommend = recommend;
	}

	public String getSiteHODate() {
		return siteHODate;
	}

	public void setSiteHODate(String siteHODate) {
		this.siteHODate = siteHODate;
	}

	public String getSlNo() {
		return slNo;
	}

	public void setSlNo(String slNo) {
		this.slNo = slNo;
	}

	public String getSrcCode() {
		return srcCode;
	}

	public void setSrcCode(String srcCode) {
		this.srcCode = srcCode;
	}

	public String getSrcIdby() {
		return srcIdby;
	}

	public void setSrcIdby(String srcIdby) {
		this.srcIdby = srcIdby;
	}

	public String getSrcName() {
		return srcName;
	}

	public void setSrcName(String srcName) {
		this.srcName = srcName;
	}

	public String getSrcType() {
		return srcType;
	}

	public void setSrcType(String srcType) {
		this.srcType = srcType;
	}

	public String getSitehab() {
		return sitehab;
	}

	public void setSitehab(String sitehab) {
		this.sitehab = sitehab;
	}

	public String getSpradgroup() {
		return spradgroup;
	}

	public void setSpradgroup(String spradgroup) {
		this.spradgroup = spradgroup;
	}

	public String getRevflag() {
		return revflag;
	}

	public void setRevflag(String revflag) {
		this.revflag = revflag;
	}

	public String getRevdel() {
		return revdel;
	}

	public void setRevdel(String revdel) {
		this.revdel = revdel;
	}

	public String getPsMode() {
		return psMode;
	}

	public void setPsMode(String psMode) {
		this.psMode = psMode;
	}

	public String getEngineerAssign() {
		return engineerAssign;
	}

	public void setEngineerAssign(String engineerAssign) {
		this.engineerAssign = engineerAssign;
	}

	public String getEngineerAssign1() {
		return engineerAssign1;
	}

	public void setEngineerAssign1(String engineerAssign1) {
		this.engineerAssign1 = engineerAssign1;
	}

	public String getEngineerAssign2() {
		return engineerAssign2;
	}

	public void setEngineerAssign2(String engineerAssign2) {
		this.engineerAssign2 = engineerAssign2;
	}

	public String getEngineerAssign3() {
		return engineerAssign3;
	}

	public void setEngineerAssign3(String engineerAssign3) {
		this.engineerAssign3 = engineerAssign3;
	}

	public String getSubDivAssign() {
		return subDivAssign;
	}

	public void setSubDivAssign(String subDivAssign) {
		this.subDivAssign = subDivAssign;
	}

	public String getWorkGndDate() {
		return workGndDate;
	}

	public void setWorkGndDate(String workGndDate) {
		this.workGndDate = workGndDate;
	}

	public String getAgreeDate() {
		return agreeDate;
	}

	public void setAgreeDate(String agreeDate) {
		this.agreeDate = agreeDate;
	}

	public String getWeMode() {
		return weMode;
	}

	public void setWeMode(String weMode) {
		this.weMode = weMode;
	}

	public String getAggrigateExpenditureForProg() {
		return aggrigateExpenditureForProg;
	}

	public void setAggrigateExpenditureForProg(
			String aggrigateExpenditureForProg) {
		this.aggrigateExpenditureForProg = aggrigateExpenditureForProg;
	}

	public String getExpUptoPrevYear() {
		return expUptoPrevYear;
	}

	public void setExpUptoPrevYear(String expUptoPrevYear) {
		this.expUptoPrevYear = expUptoPrevYear;
	}

	public String getExpYears() {
		return expYears;
	}

	public void setExpYears(String expYears) {
		this.expYears = expYears;
	}

	public double getTotalExp() {
		return totalExp;
	}

	public void setTotalExp(double totalExp) {
		this.totalExp = totalExp;
	}

	public ArrayList getExpenditureList() {
		return expenditureList;
	}

	public void setExpenditureList(ArrayList expenditureList) {
		this.expenditureList = expenditureList;
	}

	public String getAdmSanDate() {
		return admSanDate;
	}

	public void setAdmSanDate(String admSanDate) {
		this.admSanDate = admSanDate;
	}

	public String getWorkCount() {
		return workCount;
	}

	public void setWorkCount(String workCount) {
		this.workCount = workCount;
	}

	public ArrayList getProgrammeList() {
		return programmeList;
	}

	public void setProgrammeList(ArrayList programmeList) {
		this.programmeList = programmeList;
	}

	public String getValueOFWorkDone() {
		return valueOFWorkDone;
	}

	public void setValueOFWorkDone(String valueOFWorkDone) {
		this.valueOFWorkDone = valueOFWorkDone;
	}

	public String getDateOfComm() {
		return dateOfComm;
	}

	public void setDateOfComm(String dateOfComm) {
		this.dateOfComm = dateOfComm;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getTechHabsBen() {
		return techHabsBen;
	}

	public void setTechHabsBen(String techHabsBen) {
		this.techHabsBen = techHabsBen;
	}

	public String getWcMode() {
		return wcMode;
	}

	public void setWcMode(String wcMode) {
		this.wcMode = wcMode;
	}

	public String getWorkCompActualDtOfComp() {
		return workCompActualDtOfComp;
	}

	public void setWorkCompActualDtOfComp(String workCompActualDtOfComp) {
		this.workCompActualDtOfComp = workCompActualDtOfComp;
	}

	public String getWorkCompStartDate() {
		return workCompStartDate;
	}

	public void setWorkCompStartDate(String workCompStartDate) {
		this.workCompStartDate = workCompStartDate;
	}

	public String getWorkCompStipulatedDtOfComp() {
		return workCompStipulatedDtOfComp;
	}

	public void setWorkCompStipulatedDtOfComp(String workCompStipulatedDtOfComp) {
		this.workCompStipulatedDtOfComp = workCompStipulatedDtOfComp;
	}

	public String getWorkCompStipulatedDateOfCompletion() {
		return workCompStipulatedDateOfCompletion;
	}

	public void setWorkCompStipulatedDateOfCompletion(
			String workCompStipulatedDateOfCompletion) {
		this.workCompStipulatedDateOfCompletion = workCompStipulatedDateOfCompletion;
	}

	public String getPlainPop() {
		return plainPop;
	}

	public void setPlainPop(String plainPop) {
		this.plainPop = plainPop;
	}

	public String getScPop() {
		return scPop;
	}

	public void setScPop(String scPop) {
		this.scPop = scPop;
	}

	public String getStPop() {
		return stPop;
	}

	public void setStPop(String stPop) {
		this.stPop = stPop;
	}

	public String getWorkCompDateCompleted() {
		return workCompDateCompleted;
	}

	public void setWorkCompDateCompleted(String workCompDateCompleted) {
		this.workCompDateCompleted = workCompDateCompleted;
	}

	public String getEplainPop() {
		return eplainPop;
	}

	public void setEplainPop(String eplainPop) {
		this.eplainPop = eplainPop;
	}

	public String getEscPop() {
		return escPop;
	}

	public void setEscPop(String escPop) {
		this.escPop = escPop;
	}

	public String getEstPop() {
		return estPop;
	}

	public void setEstPop(String estPop) {
		this.estPop = estPop;
	}

	public String getEstTotPop() {
		return estTotPop;
	}

	public void setEstTotPop(String estTotPop) {
		this.estTotPop = estTotPop;
	}

	public String getTechHabNames() {
		return techHabNames;
	}

	public void setTechHabNames(String techHabNames) {
		this.techHabNames = techHabNames;
	}

	public String getProbCompDate() {
		return probCompDate;
	}

	public void setProbCompDate(String probCompDate) {
		this.probCompDate = probCompDate;
	}

	public String getAssetCode() {
		return assetCode;
	}

	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}

	public String getAssetCost() {
		return assetCost;
	}

	public void setAssetCost(String assetCost) {
		this.assetCost = assetCost;
	}

	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}

	public String getAssetStatus() {
		return assetStatus;
	}

	public void setAssetStatus(String assetStatus) {
		this.assetStatus = assetStatus;
	}

	public String getAssetStatusName() {
		return assetStatusName;
	}

	public void setAssetStatusName(String assetStatusName) {
		this.assetStatusName = assetStatusName;
	}

	public String getAssetTypeCode() {
		return assetTypeCode;
	}

	public void setAssetTypeCode(String assetTypeCode) {
		this.assetTypeCode = assetTypeCode;
	}

	public String getAssetTypeName() {
		return assetTypeName;
	}

	public void setAssetTypeName(String assetTypeName) {
		this.assetTypeName = assetTypeName;
	}

	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}

	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}

	public String getCircleOfficeName() {
		return circleOfficeName;
	}

	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}

	public String getDateofCreation() {
		return dateofCreation;
	}

	public void setDateofCreation(String dateofCreation) {
		this.dateofCreation = dateofCreation;
	}

	public String getDCode() {
		return dCode;
	}

	public void setDCode(String code) {
		dCode = code;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}

	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}

	public String getDivisionOfficeName() {
		return divisionOfficeName;
	}

	public void setDivisionOfficeName(String divisionOfficeName) {
		this.divisionOfficeName = divisionOfficeName;
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

	public String getHeadOfficeCode() {
		return headOfficeCode;
	}

	public void setHeadOfficeCode(String headOfficeCode) {
		this.headOfficeCode = headOfficeCode;
	}

	public String getHeadOfficeName() {
		return headOfficeName;
	}

	public void setHeadOfficeName(String headOfficeName) {
		this.headOfficeName = headOfficeName;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getMandal() {
		return mandal;
	}

	public void setMandal(String mandal) {
		this.mandal = mandal;
	}

	public String getPumpCode() {
		return pumpCode;
	}

	public void setPumpCode(String pumpCode) {
		this.pumpCode = pumpCode;
	}

	public String getStartYear() {
		return startYear;
	}

	public void setStartYear(String startYear) {
		this.startYear = startYear;
	}

	public String getSubdivisionOfficeCode() {
		return subdivisionOfficeCode;
	}

	public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
		this.subdivisionOfficeCode = subdivisionOfficeCode;
	}

	public String getSubdivisionOfficeName() {
		return subdivisionOfficeName;
	}

	public void setSubdivisionOfficeName(String subdivisionOfficeName) {
		this.subdivisionOfficeName = subdivisionOfficeName;
	}

	public String getTotHabs() {
		return totHabs;
	}

	public void setTotHabs(String totHabs) {
		this.totHabs = totHabs;
	}

	public String getTotPopBenfit() {
		return totPopBenfit;
	}

	public void setTotPopBenfit(String totPopBenfit) {
		this.totPopBenfit = totPopBenfit;
	}

	public String getPhysicalStatus() {
		return physicalStatus;
	}

	public void setPhysicalStatus(String physicalStatus) {
		this.physicalStatus = physicalStatus;
	}

	public String getPhysicalStatusDetails() {
		return physicalStatusDetails;
	}

	public void setPhysicalStatusDetails(String physicalStatusDetails) {
		this.physicalStatusDetails = physicalStatusDetails;
	}

	public String getValueOFWorkDoneButnotPaid() {
		return valueOFWorkDoneButnotPaid;
	}

	public void setValueOFWorkDoneButnotPaid(String valueOFWorkDoneButnotPaid) {
		this.valueOFWorkDoneButnotPaid = valueOFWorkDoneButnotPaid;
	}

	public ArrayList getAssets() {
		return assets;
	}

	public void setAssets(ArrayList assets) {
		this.assets = assets;
	}

	public ArrayList getAssettype() {
		return assettype;
	}

	public void setAssettype(ArrayList assettype) {
		this.assettype = assettype;
	}

	public ArrayList getAstwork() {
		return astwork;
	}

	public void setAstwork(ArrayList astwork) {
		this.astwork = astwork;
	}

	public ArrayList getRows() {
		return rows;
	}

	public void setRows(ArrayList rows) {
		this.rows = rows;
	}

	public String getSamount() {
		return samount;
	}

	public void setSamount(String samount) {
		this.samount = samount;
	}

	public String getMode1() {
		return mode1;
	}

	public void setMode1(String mode1) {
		this.mode1 = mode1;
	}

	public String getWorkUpdateProbDate() {
		return workUpdateProbDate;
	}

	public void setWorkUpdateProbDate(String workUpdateProbDate) {
		this.workUpdateProbDate = workUpdateProbDate;
	}

	public String getAugType() {
		return augType;
	}

	public void setAugType(String augType) {
		this.augType = augType;
	}

	/**
	 * @return Returns the workCancelledDate.
	 */
	public String getWorkCancelledDate() {
		return workCancelledDate;
	}

	/**
	 * @param workCancelledDate
	 *            The workCancelledDate to set.
	 */
	public void setWorkCancelledDate(String workCancelledDate) {
		this.workCancelledDate = workCancelledDate;
	}

	/**
	 * @return Returns the workCompFinDtOfComp.
	 */
	public String getWorkCompFinDtOfComp() {
		return workCompFinDtOfComp;
	}

	/**
	 * @param workCompFinDtOfComp
	 *            The workCompFinDtOfComp to set.
	 */
	public void setWorkCompFinDtOfComp(String workCompFinDtOfComp) {
		this.workCompFinDtOfComp = workCompFinDtOfComp;
	}

	/**
	 * @return Returns the schoolCode.
	 */
	public String getSchoolCode() {
		return schoolCode;
	}

	/**
	 * @param schoolCode
	 *            The schoolCode to set.
	 */
	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}

	/**
	 * @return Returns the schoolDetails.
	 */
	public String getSchoolDetails() {
		return schoolDetails;
	}

	/**
	 * @param schoolDetails
	 *            The schoolDetails to set.
	 */
	public void setSchoolDetails(String schoolDetails) {
		this.schoolDetails = schoolDetails;
	}

	/**
	 * @return Returns the habsCode.
	 */
	public String getHabsCode() {
		return habsCode;
	}

	/**
	 * @param habsCode
	 *            The habsCode to set.
	 */
	public void setHabsCode(String habsCode) {
		this.habsCode = habsCode;
	}

	/**
	 * @return Returns the panchayatCode.
	 */
	public String getPanchayatCode() {
		return panchayatCode;
	}

	/**
	 * @param panchayatCode
	 *            The panchayatCode to set.
	 */
	public void setPanchayatCode(String panchayatCode) {
		this.panchayatCode = panchayatCode;
	}

	/**
	 * @return Returns the villageCode.
	 */
	public String getVillageCode() {
		return villageCode;
	}

	/**
	 * @param villageCode
	 *            The villageCode to set.
	 */
	public void setVillageCode(String villageCode) {
		this.villageCode = villageCode;
	}

	public ArrayList getVouchersList() {
		return vouchersList;
	}

	public void setVouchersList(ArrayList vouchersList) {
		this.vouchersList = vouchersList;
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

	public ArrayList getContractorList() {
		return contractorList;
	}

	public void setContractorList(ArrayList contractorList) {
		this.contractorList = contractorList;
	}

	public String getHouseConns() {
		return houseConns;
	}

	public void setHouseConns(String houseConns) {
		this.houseConns = houseConns;
	}

	public String getPriYesOrNo() {
		return priYesOrNo;
	}

	public void setPriYesOrNo(String priYesOrNo) {
		this.priYesOrNo = priYesOrNo;
	}

	public String getStandPosts() {
		return standPosts;
	}

	public void setStandPosts(String standPosts) {
		this.standPosts = standPosts;
	}

	public String getFinancialyear() {
		return financialyear;
	}

	public void setFinancialyear(String financialyear) {
		this.financialyear = financialyear;
	}

	public String getSchemelist() {
		return schemelist;
	}

	public void setSchemelist(String schemelist) {
		this.schemelist = schemelist;
	}

	public String getMilestone1() {
		return milestone1;
	}

	public void setMilestone1(String milestone1) {
		this.milestone1 = milestone1;
	}

	/**
	 * @return Returns the partialDateOfCompletion.
	 */
	public String getPartialDateOfCompletion() {
		return partialDateOfCompletion;
	}

	/**
	 * @param partialDateOfCompletion
	 *            The partialDateOfCompletion to set.
	 */
	public void setPartialDateOfCompletion(String partialDateOfCompletion) {
		this.partialDateOfCompletion = partialDateOfCompletion;
	}

	/**
	 * @return Returns the partASanAMount.
	 */
	public String getPartASanAMount() {
		return partASanAMount;
	}

	/**
	 * @param partASanAMount
	 *            The partASanAMount to set.
	 */
	public void setPartASanAMount(String partASanAMount) {
		this.partASanAMount = partASanAMount;
	}

	public String getReasonCodeNotGround() {
		return reasonCodeNotGround;
	}

	public void setReasonCodeNotGround(String reasonCodeNotGround) {
		this.reasonCodeNotGround = reasonCodeNotGround;
	}
	public String getIndTapLocation() {
		return indTapLocation;
	}

	public void setIndTapLocation(String indTapLocation) {
		this.indTapLocation = indTapLocation;
	}

	public int getIndTapType() {
		return indTapType;
	}

	public void setIndTapType(int indTapType) {
		this.indTapType = indTapType;
	}
}
