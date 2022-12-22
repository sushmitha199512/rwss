package nic.watersoft.works;

import nic.watersoft.commons.Debug;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

import javax.servlet.http.*;

import java.util.ArrayList;
import java.util.Collection;
public class WorksMonitoringActionForm extends ActionForm
{
	
//	 added by sita
	private String circleCode;
	private String divName;
	private int divCode;
	private String subDivCode;
	private String subDivName;
	private String workId;
	private String workName;
	private String subProgName;
    private String scheme;
    private String subProgCode;
    private String workStage;
	
	private String flag;
	private String cmbCircle;
	private int	cmbDivision;
	private String subdivisioncode;
	private String cmbAssetType;
	private String cmbMonth;
	private String cmbYear;
	private String enteredBy;
	private String enteredDate;

	private String valueOFWorkDone;
	private String dateOfComm;
	private String divisionName;
	private String subdivisionName;
	private String circleName;
	private String cmdDel;
	private String program;
	private String subprogram;
	private String cmbProgramme;
	private String cmbSubprogramme;
	private String programmeName;
	private String subprogrammeName;
	private String offissuedfrom;
	private String offissuedto;
	private String workid;
	private String contCode;
	private String dateofcomp;
	private ArrayList memo;
	private String cmbWorks;
	private String works;
	private String code;
	private String work;
	private float ecost;
	private String repDate;
	private String endorseNo;
	private String endorseDate;
	private String admSanNo;
	private String admSanDate;
	private float sanAmt;
	private int habsBen;
	 private String habNames;
	 private String revAdmSanc;
	 private String revAdmSancDate;
	 private float revSanAmt;
	 private int revHabsBen;
	 private String revHabNames;
	 private String techSangiven;
	  private float admCost;
	  private String techSanNo;
	  private String techSanDate;
	  private float techSanAmt;
	  private int techHabsBen;
	  private String techHabNames;
	  private String revtechSangiven;
	  private float revadmCost;
	  private String revtechSanNo;
	  private String revtechSanDate;
	  private float revtechSanAmt;
	private int revtechHabsBen;
	private String revtechHabNames;
	private String del;
	private String ssrYear;
	private String habCode;
	private String financialYear;
	private String sourceCode;
	private String revssrYear;
	private String revflag;
	private String revdel;
	private String revmode;
	private float revAdmCost;
	private String revsangivenby;
	private String sitehab;
	private String panchCode;
	private String panchName;
	private String mandalCode;
	private String mandalName;
	private String codeStatus;
	private String srcType;
	private String srcCode;
	private String srcName;
	private String srcIdby;
	private String siteHODate;
	private String recommend;
	private String subcompType;
	private String subSourceType;
	private String schemeCode;
	private String slNo;
	private String newsrcName;
	private String newsrcCode;
	private String tenderNoteId;
	private float tenderCost;
	private String cfName;
	private String loa;
	private String tenderAppBy;
	private String tenderAppDate;
	private String siteHandDate;
	private String agreeDate;
	private String agreeRefNo;
	private int agreeDur;
	private float agreeVal;
	private String workCompDate;
	private String tenderAccDate;
	private String tenderCommittee;
	private String compAuthority;
	private String subDivAssign;
	private String engineerAssign;
	private String engineerAssignDee;
	private String engineerAssignEe;
	private String engineerAssignSe;
	private String workGndDate;
	private String subDiv;
	private ArrayList mileStones;
	private String mstone;
	private String stages;
	private String targetDate;
	private String percentComp;
	private String mstoneCode;
	private String mstoneName;
	private String mstoneStageCode;
	private String mstoneStageName;
	private String sno;
	private String stage;
	private ArrayList mileStone;
	private String schemeName;
	
	private String expenditure;
	private String programmeCode;
	
	private String plainPop;
	private String scPop;
    private String stPop;
    private String raPlainPop;
    private String raScPop;
    private String raStPop;
    private String eplainPop="";
    private String estPop="";
    private String escPop="";
    private String rePlainPop;
    private String reStPop;
    private String reScPop;
    private String estTotPop;
    private String reTotPop;
    private String totPop;
    private String raTotPop;
    private String expUptoPrevYear;
    private String expYears;
    
    private String workCompStartDate;
    private String workCompStipulatedDtOfComp;
	private String workCompActualDtOfComp;
    
    private ArrayList expenditureList;
    private ArrayList programmeList;
    private String tenderPer;
    
    // added by ramesh
    private String aggrigateExpenditureForProg;
    private double totalExp;
    private String spradgroup;
    
    //added by nagendra kankatala 26-6-21
    private FormFile qcImg;
	private String qcImgAvailble;
	private String issueDate;
    private String certDate;
    
    //for tpqc 29-09-2021
    
    private String agency;
    
    
    
    public String getAgency() {
		return agency;
	}
	public void setAgency(String agency) {
		this.agency = agency;
	}
	//added by nagendra kankatala 04-08-2021
    private String agencyName;
    
	public String getAgencyName() {
		return agencyName;
	}
	public void setAgencyName(String agencyName) {
		this.agencyName = agencyName;
	}
	public FormFile getQcImg() {
		return qcImg;
	}
	public void setQcImg(FormFile qcImg) {
		this.qcImg = qcImg;
	}
	public String getQcImgAvailble() {
		return qcImgAvailble;
	}
	public void setQcImgAvailble(String qcImgAvailble) {
		this.qcImgAvailble = qcImgAvailble;
	}
	public String getIssueDate() {
		return issueDate;
	}
	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}
	public String getCertDate() {
		return certDate;
	}
	public void setCertDate(String certDate) {
		this.certDate = certDate;
	}
	public String getSpradgroup() {
		return spradgroup;
	}
	public void setSpradgroup(String spradgroup) {
		this.spradgroup = spradgroup;
	}
	/**
	 * @return Returns the aggrigateExpenditureForProg.
	 */
	public String getAggrigateExpenditureForProg() {
		return aggrigateExpenditureForProg;
	}
	/**
	 * @param aggrigateExpenditureForProg The aggrigateExpenditureForProg to set.
	 */
	public void setAggrigateExpenditureForProg(
			String aggrigateExpenditureForProg) {
		this.aggrigateExpenditureForProg = aggrigateExpenditureForProg;
	}
    private String progCode;
    private String progName;
    private String remarks;
    
    private String plan;
    private String wrktype;
    private String workCat;
    
    private String mode="";// added by sita
    //code added by pranavi
    /**
 	 * @return Returns the worksforDel.
 	 */
    
    private Collection worksforDelete;
    
    //added by sridhar
    private String wrkCanDate; 
    
	public String getWrkCanDate() {
		return wrkCanDate;
	}
	public void setWrkCanDate(String wrkCanDate) {
		this.wrkCanDate = wrkCanDate;
	}
    
 	 public Collection getWorksforDelete() 
 	 {
 	
 				return worksforDelete;		
 	 }
 	
 	 public void setWorksforDelete(Collection worksforDelete) 
 	 {
 	 	
 		this.worksforDelete = worksforDelete;
 		
 	 }
    //end of code added by pranavi
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
	 * @return Returns the remarks.
	 */
	public String getRemarks() {
		return remarks;
	}
	/**
	 * @param remarks The remarks to set.
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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
    
//----------------------------------------------------------------------------------
public WorksMonitoringActionForm()
{
	
	mileStones=new ArrayList();
	expenditureList=new ArrayList();
	programmeList=new ArrayList();
}
public void setCompAuthority(String compAuthority)
	{
		this.compAuthority = compAuthority;
	}
	public String getCompAuthority()
	{
		return compAuthority;
	}
public void setTenderCommittee(String tenderCommittee)
	{
		this.tenderCommittee = tenderCommittee;
	}
	public String getTenderCommittee()
	{
		return tenderCommittee;
	}
public void setTenderAccDate(String tenderAccDate)
	{
		this.tenderAccDate = tenderAccDate;
	}
	public String getTenderAccDate()
	{
		return tenderAccDate;
	}
public void setWorkCompDate(String workCompDate)
	{
		this.workCompDate = workCompDate;
	}
	public String getWorkCompDate()
	{
		return workCompDate;
	}
public void setAgreeVal(float agreeVal)
	{
		this.agreeVal = agreeVal;
	}
	public float getAgreeVal()
	{
		return agreeVal;
	}
public void setAgreeDur(int agreeDur)
	{
		this.agreeDur = agreeDur;
	}
	public int getAgreeDur()
	{
		return agreeDur;
	}
public void setAgreeRefNo(String agreeRefNo)
	{
		this.agreeRefNo = agreeRefNo;
	}
	public String getAgreeRefNo()
	{
		return agreeRefNo;
	}
public void setAgreeDate(String agreeDate)
	{
		this.agreeDate = agreeDate;
	}
	public String getAgreeDate()
	{
		return agreeDate;
	}
public void setSiteHandDate(String siteHandDate)
	{
		this.siteHandDate = siteHandDate;
	}
	public String getSiteHandDate()
	{
		return siteHandDate;
	}
public void setTenderAppDate(String tenderAppDate)
	{
		this.tenderAppDate = tenderAppDate;
	}
	public String getTenderAppDate()
	{
		return tenderAppDate;
	}
public void setTenderAppBy(String tenderAppBy)
	{
		this.tenderAppBy = tenderAppBy;
	}
	public String getTenderAppBy()
	{
		return tenderAppBy;
	}
public void setLoa(String loa)
	{
		this.loa = loa;
	}
	public String getLoa()
	{
		return loa;
	}
public void setCfName(String cfName)
	{
		this.cfName = cfName;
	}
	public String getCfName()
	{
		return cfName;
	}
public void setTenderCost(float tenderCost)
	{
		this.tenderCost = tenderCost;
	}
	public float getTenderCost()
	{
		return tenderCost;
	}
public void setTenderNoteId(String tenderNoteId)
	{
		this.tenderNoteId = tenderNoteId;
	}
	public String getTenderNoteId()
	{
		return tenderNoteId;
	}
public void setRecommend(String recommend)
	{
		this.recommend = recommend;
	}
	public String getRecommend()
	{
		return recommend;
	}
public void setSiteHODate(String siteHODate)
	{
		this.siteHODate = siteHODate;
	}
	public String getSiteHODate()
	{
		return siteHODate;
	}
public void setSrcIdby(String srcIdby)
	{
		this.srcIdby = srcIdby;
	}
	public String getSrcIdby()
	{
		return srcIdby;
	}
public void setSrcName(String srcName)
	{
		this.srcName = srcName;
	}
	public String getSrcName()
	{
		return srcName;
	}
public void setRevtechHabNames(String revtechHabNames)
	{
		this.revtechHabNames = revtechHabNames;
	}
	public String getRevtechHabNames()
	{
		return revtechHabNames;
	}
	public void setRevtechHabsBen(int revtechHabsBen)
	{
		this.revtechHabsBen = revtechHabsBen;
	}
	public int getRevtechHabsBen()
	{
		return revtechHabsBen;
	}
	public void setRevtechSanAmt(float revtechSanAmt)
	{
		this.revtechSanAmt = revtechSanAmt;
	}
	public float getRevtechSanAmt()
	{
		return revtechSanAmt;
	}
	public void setRevtechSanDate(String revtechSanDate)
	{
		this.revtechSanDate = revtechSanDate;
	}
	public String getRevtechSanDate()
	{
		return revtechSanDate;
	}
	public void setRevtechSanNo(String revtechSanNo)
	{
		this.revtechSanNo = revtechSanNo;
	}
	public String getRevtechSanNo()
	{
		return revtechSanNo;
	}
	public void setRevadmCost(float revadmCost)
	{
		this.revadmCost = revadmCost;
	}
	public float getRevadmCost()
	{
		return revadmCost;
	}
	public void setRevtechSangiven(String revtechSangiven)
	{
		this.revtechSangiven = revtechSangiven;
	}
	public String getRevtechSangiven()
	{
		return revtechSangiven;
	}
//------------------------------------------------------------------------------------	
	public void setTechHabNames(String techHabNames)
	{
		this.techHabNames = techHabNames;
	}
	public String getTechHabNames()
	{
		return techHabNames;
	}
	public void setTechHabsBen(int techHabsBen)
	{
		this.techHabsBen = techHabsBen;
	}
	public int getTechHabsBen()
	{
		return techHabsBen;
	}
	public void setTechSanAmt(float techSanAmt)
	{
		this.techSanAmt = techSanAmt;
	}
	public float getTechSanAmt()
	{
		return techSanAmt;
	}
	public void setTechSanDate(String techSanDate)
	{
		this.techSanDate = techSanDate;
	}
	public String getTechSanDate()
	{
		return techSanDate;
	}
	public void setTechSanNo(String techSanNo)
	{
		this.techSanNo = techSanNo;
	}
	public String getTechSanNo()
	{
		return techSanNo;
	}
	public void setAdmCost(float admCost)
	{
		this.admCost = admCost;
	}
	public float getAdmCost()
	{
		return admCost;
	}
	public void setTechSangiven(String techSangiven)
	{
		this.techSangiven = techSangiven;
	}
	public String getTechSangiven()
	{
		return techSangiven;
	}
	public void setRevHabNames(String revHabNames)
	{
		this.revHabNames = revHabNames;
	}
	public String getRevHabNames()
	{
		return revHabNames;
	}
		public void setRevHabsBen(int revHabsBen)
	{
		this.revHabsBen = revHabsBen;
	}
	public int getRevHabsBen()
	{
		return revHabsBen;
	}

	public void setRevSanAmt(float revSanAmt)
	{
		this.revSanAmt = revSanAmt;
	}
	public float getRevSanAmt()
	{
		return revSanAmt;
	}
	public void setRevAdmSancDate(String revAdmSancDate)
	{
		this.revAdmSancDate = revAdmSancDate;
	}
	public String getRevAdmSancDate()
	{
		return revAdmSancDate;
	}
	public void setRevAdmSanc(String revAdmSanc)
	{
		this.revAdmSanc = revAdmSanc;
	}
	public String getRevAdmSanc()
	{
		return revAdmSanc;
	}
	public void setHabNames(String habNames)
	{
		this.habNames = habNames;
	}
	public String getHabNames()
	{
		return habNames;
	}
	public void setHabsBen(int habsBen)
	{
		this.habsBen = habsBen;
	}
	public int getHabsBen()
	{
		return habsBen;
	}
	public void setSanAmt(float sanAmt)
	{
		this.sanAmt = sanAmt;
	}
	public float getSanAmt()
	{
		return sanAmt;
	}
	public void setAdmSanDate(String admSanDate)
	{
		this.admSanDate = admSanDate;
	}
	public String getAdmSanDate()
	{
		return admSanDate;
	}
	public void setAdmSanNo(String admSanNo)
	{
		this.admSanNo = admSanNo;
	}
	public String getAdmSanNo()
	{
		return admSanNo;
	}
	public void setEndorseDate(String endorseDate)
	{
		this.endorseDate = endorseDate;
	}
	public String getEndorseDate()
	{
		return endorseDate;
	}
	public void setEndorseNo(String endorseNo)
	{
		this.endorseNo = endorseNo;
	}
	public String getEndorseNo()
	{
		return endorseNo;
	}
	public void setRepDate(String repDate)
	{
		this.repDate = repDate;
	}
	public String getRepDate()
	{
		return repDate;
	}
	public void setEcost(float ecost)
	{
		this.ecost = ecost;
	}
	public float getEcost()
	{
		return ecost;
	}
	public tenderMemo getappListt(int index)
	{
		while(index >= memo.size())
		{
			//System.out.println("index in getSOURCEASSET_LIST= "+index);
			memo.add(new tenderMemo());
		}
		return (tenderMemo)memo.get(index);
	}
	/*
	 public tenderMemo getWORK(int index)
	{
		//System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaa");
		while(index >= mileStones.size())
		{
			//System.out.println("index in getSOURCEASSET_LIST= "+index);
			mileStones.add(new tenderMemo());
		}
		return (tenderMemo)mileStones.get(index);
	}*/
	public void setMemo(ArrayList memo)
	{
		this.memo = memo;
	}
	public ArrayList getMemo()
	{
		return memo;
	}
	public void setOffissuedfrom(String offissuedfrom)
	{
		this.offissuedfrom = offissuedfrom;
	}
	public String getOffissuedfrom()
	{
		return offissuedfrom;
	}
	public void setOffissuedto(String offissuedto)
	{
		this.offissuedto = offissuedto;
	}
	public String getOffissuedto()
	{
		return offissuedto;
	}
	public void setWorkid(String workid)
	{
		this.workid = workid;
	}
	public String getWorkid()
	{
		return workid;
	}
	public void setContCode(String contCode)
	{
		this.contCode = contCode;
	}
	public String getContCode()
	{
		return contCode;
	}
	public void setDateofcomp(String dateofcomp)
	{
		this.dateofcomp = dateofcomp;
	}
	public String getDateofcomp()
	{
		return dateofcomp;
	}
	public void setCmbProgramme(String cmbProgramme)
	{
		this.cmbProgramme = cmbProgramme;
	}
	public String getCmbProgramme()
	{
		return cmbProgramme;
	}
	public void setCmbSubprogramme(String cmbSubprogramme)
	{
		this.cmbSubprogramme = cmbSubprogramme;
	}
	public String getCmbSubprogramme()
	{
		return cmbSubprogramme;
	}
	public void setProgrammeName(String programmeName)
	{
		this.programmeName = programmeName;
	}
	public String getProgrammeName()
	{
		return programmeName;
	}
	public void setSubprogrammeName(String subprogrammeName)
	{
		this.subprogrammeName = subprogrammeName;
	}
	public String getSubprogrammeName()
	{
		return subprogrammeName;
	}
	public void setCmdDel(String cmdDel)
	{
		this.cmdDel = cmdDel;
	}
	public String getCmdDel()
	{
		return cmdDel;
	}

	public void setCircleName(String circleName)
	{
		this.circleName = circleName;
	}
	public String getCircleName()
	{
		return circleName;
	}

	public void setDivisionName(String divisionName)
	{
		this.divisionName = divisionName;
	}
	public String getDivisionName()
	{
		return divisionName;
	}


	public void setCmbCircle(String cmbCircle)
	{
		this.cmbCircle = cmbCircle;
	}
	public String getCmbCircle()
	{
		return cmbCircle;
	}
	public void setCmbDivision(int cmbDivision)
	{
		this.cmbDivision = cmbDivision;
	}
	public int getCmbDivision()
	{
		return cmbDivision;
	}
	public void setSubdivisioncode(String subdivisioncode)
	{
		this.subdivisioncode = subdivisioncode;
	}
	public String getSubdivisioncode()
	{
		return subdivisioncode;
	}
	public void setCmbAssetType(String cmbAssetType)
	{
		this.cmbAssetType = cmbAssetType;
	}
	public String getCmbAssetType()
	{
		return cmbAssetType;
	}
	public void setCmbMonth(String cmbMonth)
	{
		this.cmbMonth = cmbMonth;
	}
	public String getCmbMonth()
	{
		return cmbMonth;
	}
	public void setCmbYear(String cmbYear)
	{
		this.cmbYear = cmbYear;
	}
	public String getCmbYear()
	{
		return cmbYear;
	}
	public void setEnteredBy(String enteredBy)
	{
		this.enteredBy = enteredBy;
	}
	public String getEnteredBy()
	{
		return enteredBy;
	}
	public void setEnteredDate(String enteredDate)
	{
		this.enteredDate = enteredDate;
	}
	public String getEnteredDate()
	{
		return enteredDate;
	}
	
	
	

	/**
	 * @return Returns the cmbWorks.
	 */
	public String getCmbWorks() {
		return cmbWorks;
	}
	/**
	 * @param cmbWorks The cmbWorks to set.
	 */
	public void setCmbWorks(String cmbWorks) {
		this.cmbWorks = cmbWorks;
	}
	public void setWorks(String works)
	{
		this.works = works;
	}
	public String getWorks()
	{
		return works;
	}
	public void setCode(String code)
	{
		this.code = code;
	}
	public String getCode()
	{
		return code;
	}
	public void setWork(String work)
	{
		this.work = work;
	}
	public String getWork()
	{
		return work;
	}
	public void setFlag(String flag)
	{
		this.flag = flag;
	}
	public String getFlag()
	{
		return flag;
	}
	/**
	 * @return Returns the del.
	 */
	public String getDel() {
		return del;
	}
	/**
	 * @param del The del to set.
	 */
	public void setDel(String del) {
		this.del = del;
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
	 * @return Returns the habCode.
	 */
	public String getHabCode() {
		return habCode;
	}
	/**
	 * @param habCode The habCode to set.
	 */
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	
	/**
	 * @return Returns the financialYear.
	 */
	public String getFinancialYear() {
		return financialYear;
	}
	/**
	 * @param financialYear The financialYear to set.
	 */
	public void setFinancialYear(String financialYear) {
		this.financialYear = financialYear;
	}
	/**
	 * @return Returns the sourceCode.
	 */
	public String getSourceCode() {
		return sourceCode;
	}
	/**
	 * @param sourceCode The sourceCode to set.
	 */
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}
	/**
	 * @return Returns the revssrYear.
	 */
	public String getRevssrYear() {
		return revssrYear;
	}
	/**
	 * @param revssrYear The revssrYear to set.
	 */
	public void setRevssrYear(String revssrYear) {
		this.revssrYear = revssrYear;
	}
	/**
	 * @return Returns the revdel.
	 */
	public String getRevdel() {
		return revdel;
	}
	/**
	 * @param revdel The revdel to set.
	 */
	public void setRevdel(String revdel) {
		this.revdel = revdel;
	}
	/**
	 * @return Returns the revflag.
	 */
	public String getRevflag() {
		return revflag;
	}
	/**
	 * @param revflag The revflag to set.
	 */
	public void setRevflag(String revflag) {
		this.revflag = revflag;
	}
	/**
	 * @return Returns the revmode.
	 */
	public String getRevmode() {
		return revmode;
	}
	/**
	 * @param revmode The revmode to set.
	 */
	public void setRevmode(String revmode) {
		this.revmode = revmode;
	}
	/**
	 * @return Returns the revAdmCost.
	 */
	public float getRevAdmCost() {
		return revAdmCost;
	}
	/**
	 * @param revAdmCost The revAdmCost to set.
	 */
	public void setRevAdmCost(float revAdmCost) {
		this.revAdmCost = revAdmCost;
	}
	/**
	 * @return Returns the revsangivenby.
	 */
	public String getRevsangivenby() {
		return revsangivenby;
	}
	/**
	 * @param revsangivenby The revsangivenby to set.
	 */
	public void setRevsangivenby(String revsangivenby) {
		this.revsangivenby = revsangivenby;
	}
	/**
	 * @return Returns the sitehab.
	 */
	public String getSitehab() {
		return sitehab;
	}
	/**
	 * @param sitehab The sitehab to set.
	 */
	public void setSitehab(String sitehab) {
		this.sitehab = sitehab;
	}
	public void setMandalCode(String mandalCode) {
	
		this.mandalCode = mandalCode;
	}
	public void setCodeStatus(String codeStatus) {
		
			this.codeStatus = codeStatus;
		}
	public String getCodeStatus() {
		return codeStatus;
	}
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	public String getMandalCode() {
		return mandalCode;
	}
	public String getMandalName() {
		return mandalName;
	}
	/**
	 * @return Returns the panchCode.
	 */
	public String getPanchCode() {
		return panchCode;
	}
	/**
	 * @param panchCode The panchCode to set.
	 */
	public void setPanchCode(String panchCode) {
		this.panchCode = panchCode;
	}
	/**
	 * @return Returns the panchName.
	 */
	public String getPanchName() {
		return panchName;
	}
	/**
	 * @param panchName The panchName to set.
	 */
	public void setPanchName(String panchName) {
		this.panchName = panchName;
	}
	/**
	 * @return Returns the srcType.
	 */
	public String getSrcType() {
		return srcType;
	}
	/**
	 * @param srcType The srcType to set.
	 */
	public void setSrcType(String srcType) {
		this.srcType = srcType;
	}
	/**
	 * @return Returns the srcCode.
	 */
	public String getSrcCode() {
		return srcCode;
	}
	/**
	 * @param srcCode The srcCode to set.
	 */
	public void setSrcCode(String srcCode) {
		this.srcCode = srcCode;
	}
	/**
	 * @return Returns the subcompType.
	 */
	public String getSubcompType() {
		return subcompType;
	}
	/**
	 * @param subcompType The subcompType to set.
	 */
	public void setSubcompType(String subcompType) {
		this.subcompType = subcompType;
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
	 * @return Returns the slNo.
	 */
	public String getSlNo() {
		return slNo;
	}
	/**
	 * @param slNo The slNo to set.
	 */
	public void setSlNo(String slNo) {
		this.slNo = slNo;
	}
	/**
	 * @return Returns the newsrcName.
	 */
	public String getNewsrcName() {
		return newsrcName;
	}
	/**
	 * @param newsrcName The newsrcName to set.
	 */
	public void setNewsrcName(String newsrcName) {
		this.newsrcName = newsrcName;
	}
	/**
	 * @return Returns the newsrcCode.
	 */
	public String getNewsrcCode() {
		return newsrcCode;
	}
	/**
	 * @param newsrcCode The newsrcCode to set.
	 */
	public void setNewsrcCode(String newsrcCode) {
		this.newsrcCode = newsrcCode;
	}
	/*public void reset(ActionMapping mapping,HttpServletRequest request) 
	{
		this.sitehab="";   
		this.subcompType="";
		this.updateSource="";
		this.forwadedOn="";
		wqtestParams.clear();
		wqLabTests.clear();
		wqLabTestResults.clear();
	}*/
	/**
	 * @return Returns the subDivAssign.
	 */
	public String getSubDivAssign() {
		return subDivAssign;
	}
	/**
	 * @param subDivAssign The subDivAssign to set.
	 */
	public void setSubDivAssign(String subDivAssign) {
		this.subDivAssign = subDivAssign;
	}
	/**
	 * @return Returns the engineerAssign.
	 */
	public String getEngineerAssign() {
		return engineerAssign;
	}
	/**
	 * @param engineerAssign The engineerAssign to set.
	 */
	public void setEngineerAssign(String engineerAssign) {
		this.engineerAssign = engineerAssign;
	}
	/**
	 * @return Returns the workGndDate.
	 */
	public String getWorkGndDate() {
		return workGndDate;
	}
	/**
	 * @param workGndDate The workGndDate to set.
	 */
	public void setWorkGndDate(String workGndDate) {
		this.workGndDate = workGndDate;
	}
	/**
	 * @return Returns the subDiv.
	 */
	public String getSubDiv() {
		return subDiv;
	}
	/**
	 * @param subDiv The subDiv to set.
	 */
	public void setSubDiv(String subDiv) {
		this.subDiv = subDiv;
	}
	/**
	 * @return Returns the mileStones.
	 */
	public ArrayList getMileStones() {
		return mileStones;
	}
	/**
	 * @param mileStones The mileStones to set.
	 */
	public void setMileStones(ArrayList mileStones) {
		this.mileStones = mileStones;
	}
	/**
	 * @return Returns the mstone.
	 */
	public String getMstone() {
		return mstone;
	}
	/**
	 * @param mstone The mstone to set.
	 */
	public void setMstone(String mstone) {
		this.mstone = mstone;
	}
	/**
	 * @return Returns the mstoneCode.
	 */
	public String getMstoneCode() {
		return mstoneCode;
	}
	/**
	 * @param mstoneCode The mstoneCode to set.
	 */
	public void setMstoneCode(String mstoneCode) {
		this.mstoneCode = mstoneCode;
	}
	/**
	 * @return Returns the mstoneName.
	 */
	public String getMstoneName() {
		return mstoneName;
	}
	/**
	 * @param mstoneName The mstoneName to set.
	 */
	public void setMstoneName(String mstoneName) {
		this.mstoneName = mstoneName;
	}
	/**
	 * @return Returns the mstoneStageCode.
	 */
	public String getMstoneStageCode() {
		return mstoneStageCode;
	}
	/**
	 * @param mstoneStageCode The mstoneStageCode to set.
	 */
	public void setMstoneStageCode(String mstoneStageCode) {
		this.mstoneStageCode = mstoneStageCode;
	}
	/**
	 * @return Returns the mstoneStageName.
	 */
	public String getMstoneStageName() {
		return mstoneStageName;
	}
	/**
	 * @param mstoneStageName The mstoneStageName to set.
	 */
	public void setMstoneStageName(String mstoneStageName) {
		this.mstoneStageName = mstoneStageName;
	}
	
	/**
	 * @return Returns the stages.
	 */
	public String getStages() {
		return stages;
	}
	/**
	 * @param stages The stages to set.
	 */
	public void setStages(String stages) {
		this.stages = stages;
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
	 * @return Returns the sno.
	 */
	public String getSno() {
		return sno;
	}
	/**
	 * @param sno The sno to set.
	 */
	public void setSno(String sno) {
		this.sno = sno;
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
	 * @return Returns the mileStone.
	 */
	public ArrayList getMileStone() {
		return mileStone;
	}
	/**
	 * @param mileStone The mileStone to set.
	 */
	public void setMileStone(ArrayList mileStone) {
		this.mileStone = mileStone;
	}
	/**
	 * @param percentComp The percentComp to set.
	 */
	
	/**
	 * @return Returns the percentComp.
	 */
	public String getPercentComp() {
		return percentComp;
	}
	/**
	 * @param percentComp The percentComp to set.
	 */
	public void setPercentComp(String percentComp) {
		this.percentComp = percentComp;
	}
	/**
	 * @return Returns the expenditure.
	 */
	public String getExpenditure() {
		return expenditure;
	}
	/**
	 * @param expenditure The expenditure to set.
	 */
	public void setExpenditure(String expenditure) {
		this.expenditure = expenditure;
	}
	
	
	public String getPlainPop() {
		return plainPop;
	}
	/**
	 * @param plainPop The plainPop to set.
	 */
	public void setPlainPop(String plainPop) {
		this.plainPop = plainPop;
	}
	/**
	 * @return Returns the scPop.
	 */
	public String getScPop() {
		return scPop;
	}
	/**
	 * @param scPop The scPop to set.
	 */
	public void setScPop(String scPop) {
		this.scPop = scPop;
	}
	/**
	 * @return Returns the stPop.
	 */
	public String getStPop() {
		return stPop;
	}
	/**
	 * @param stPop The stPop to set.
	 */
	public void setStPop(String stPop) {
		this.stPop = stPop;
	}
	/**
	 * @return Returns the raPlainPop.
	 */
	public String getRaPlainPop() {
		return raPlainPop;
	}
	/**
	 * @param raPlainPop The raPlainPop to set.
	 */
	public void setRaPlainPop(String raPlainPop) {
		this.raPlainPop = raPlainPop;
	}
	/**
	 * @return Returns the raScPop.
	 */
	public String getRaScPop() {
		return raScPop;
	}
	/**
	 * @param raScPop The raScPop to set.
	 */
	public void setRaScPop(String raScPop) {
		this.raScPop = raScPop;
	}
	/**
	 * @return Returns the raStPop.
	 */
	public String getRaStPop() {
		return raStPop;
	}
	/**
	 * @param raStPop The raStPop to set.
	 */
	public void setRaStPop(String raStPop) {
		this.raStPop = raStPop;
	}
	public String getRePlainPop() {
		return rePlainPop;
	}
	/**
	 * @param rePlainPop The rePlainPop to set.
	 */
	public void setRePlainPop(String rePlainPop) {
		this.rePlainPop = rePlainPop;
	}
	/**
	 * @return Returns the reScPop.
	 */
	public String getReScPop() {
		return reScPop;
	}
	/**
	 * @param reScPop The reScPop to set.
	 */
	public void setReScPop(String reScPop) {
		this.reScPop = reScPop;
	}
	/**
	 * @return Returns the reStPop.
	 */
	public String getReStPop() {
		return reStPop;
	}
	/**
	 * @param reStPop The reStPop to set.
	 */
	public void setReStPop(String reStPop) {
		this.reStPop = reStPop;
	}
	/**
	 * @return Returns the eplainPop.
	 */
	public String getEplainPop() {
		return eplainPop;
	}
	/**
	 * @param eplainPop The eplainPop to set.
	 */
	public void setEplainPop(String eplainPop) {
		this.eplainPop = eplainPop;
	}
	/**
	 * @return Returns the escPop.
	 */
	public String getEscPop() {
		return escPop;
	}
	/**
	 * @param escPop The escPop to set.
	 */
	public void setEscPop(String escPop) {
		this.escPop = escPop;
	}
	/**
	 * @return Returns the estPop.
	 */
	public String getEstPop() {
		return estPop;
	}
	/**
	 * @param estPop The estPop to set.
	 */
	public void setEstPop(String estPop) {
		this.estPop = estPop;
	}
	/**
	 * @return Returns the estTotPop.
	 */
	public String getEstTotPop() {
		return estTotPop;
	}
	/**
	 * @param estTotPop The estTotPop to set.
	 */
	public void setEstTotPop(String estTotPop) {
		this.estTotPop = estTotPop;
	}
	/**
	 * @return Returns the reTotPop.
	 */
	public String getReTotPop() {
		return reTotPop;
	}
	/**
	 * @param reTotPop The reTotPop to set.
	 */
	public void setReTotPop(String reTotPop) {
		this.reTotPop = reTotPop;
	}
	/**
	 * @return Returns the raTotPop.
	 */
	public String getRaTotPop() {
		return raTotPop;
	}
	/**
	 * @param raTotPop The raTotPop to set.
	 */
	public void setRaTotPop(String raTotPop) {
		this.raTotPop = raTotPop;
	}
	
	/**
	 * @return Returns the totPop.
	 */
	public String getTotPop() {
		return totPop;
	}
	/**
	 * @param totPop The totPop to set.
	 */
	public void setTotPop(String totPop) {
		this.totPop = totPop;
	}
	/**
	 * @return Returns the expUptoPrevYear.
	 */
	public String getExpUptoPrevYear() {
		return expUptoPrevYear;
	}
	/**
	 * @param expUptoPrevYear The expUptoPrevYear to set.
	 */
	public void setExpUptoPrevYear(String expUptoPrevYear) {
		this.expUptoPrevYear = expUptoPrevYear;
	}
	/**
	 * @return Returns the expenditureList.
	 */
	public ArrayList getExpenditureList() {
		return expenditureList;
	}
	/**
	 * @param expenditureList The expenditureList to set.
	 */
	public void setExpenditureList(ArrayList expenditureList) {
		this.expenditureList = expenditureList;
	}
	
	public  tenderMemo  getWORKEXP_LIST(int index)
	{
	 
		//System.out.println("in getWORKEXP_LIST index is "+index);
		//System.out.println("in expenditureList size is  "+expenditureList.size());
		while(index >= expenditureList.size())
		{
			expenditureList.add(new tenderMemo());
		}
	 
		return (tenderMemo)expenditureList.get(index);
	}
	
	public  tenderMemo  getCONTMGT_MILESTONES_LIST(int index)
	{
	 
		//System.out.println("in CONTMGT_MILESTONES_LIST index is "+index);
		while(index >= mileStones.size())
		{
			mileStones.add(new tenderMemo());
		}
	 
		return (tenderMemo)mileStones.get(index);
	}
	
	public  tenderMemo  getProgExp(int index)
	{
	 
		//System.out.println("in progExp in formBean index is "+index);
		//System.out.println("programmelist size is "+programmeList.size());
		while(index >= programmeList.size())
		{
			programmeList.add(new tenderMemo());
		}
	 
		return (tenderMemo)programmeList.get(index);
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
	/**
	 * @return Returns the programmeCode.
	 */
	public String getProgrammeCode() {
		return programmeCode;
	}
	/**
	 * @param programmeCode The programmeCode to set.
	 */
	public void setProgrammeCode(String programmeCode) {
		this.programmeCode = programmeCode;
	}
	/**
	 * @return Returns the schemeName.
	 */
	public String getSchemeName() {
		return schemeName;
	}
	/**
	 * @param schemeName The schemeName to set.
	 */
	public void setSchemeName(String schemeName) {
		this.schemeName = schemeName;
	}
	/**
	 * @return Returns the dateOfComm.
	 */
	public String getDateOfComm() {
		return dateOfComm;
	}
	/**
	 * @param dateOfComm The dateOfComm to set.
	 */
	public void setDateOfComm(String dateOfComm) {
		this.dateOfComm = dateOfComm;
	}
	/**
	 * @return Returns the valueOFWorkDone.
	 */
	public String getValueOFWorkDone() {
		return valueOFWorkDone;
	}
	/**
	 * @param valueOFWorkDone The valueOFWorkDone to set.
	 */
	public void setValueOFWorkDone(String valueOFWorkDone) {
		this.valueOFWorkDone = valueOFWorkDone;
	}
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		  //System.out.println("Reset Method called........");
		  this.cmbCircle="";
		  this.cmbDivision=0;
		  this.works="";
		  this.programmeName="";
		  this.subprogrammeName="";
		  this.schemeName="";
		  this.subdivisioncode="";
		  this.subdivisionName="";
		  this.program="";
	}
	/**
	 * @return Returns the tenderPer.
	 */
	public String getTenderPer() {
		return tenderPer;
	}
	/**
	 * @param tenderPer The tenderPer to set.
	 */
	public void setTenderPer(String tenderPer) {
		this.tenderPer = tenderPer;
	}
	public ArrayList getProgrammeList() {
		return programmeList;
	}
	public void setProgrammeList(ArrayList programmeList) {
		this.programmeList = programmeList;
	}
	
	public String getEngineerAssignDee() {
		return engineerAssignDee;
	}
	public void setEngineerAssignDee(String engineerAssignDee) {
		this.engineerAssignDee = engineerAssignDee;
	}
	public String getEngineerAssignEe() {
		return engineerAssignEe;
	}
	public void setEngineerAssignEe(String engineerAssignEe) {
		this.engineerAssignEe = engineerAssignEe;
	}
	public String getEngineerAssignSe() {
		return engineerAssignSe;
	}
	public void setEngineerAssignSe(String engineerAssignSe) {
		this.engineerAssignSe = engineerAssignSe;
	}
	/**
	 * @return Returns the subdivisionName.
	 */
	public String getSubdivisionName() {
		return subdivisionName;
	}
	/**
	 * @param subdivisionName The subdivisionName to set.
	 */
	public void setSubdivisionName(String subdivisionName) {
		this.subdivisionName = subdivisionName;
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
	 * @return Returns the divCode.
	 */
	public int getDivCode() {
		return divCode;
	}
	/**
	 * @param divCode The divCode to set.
	 */
	public void setDivCode(int divCode) {
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
	 * @return Returns the totalExp.
	 */
	public double getTotalExp() {
		return totalExp;
	}
	/**
	 * @param totalExp The totalExp to set.
	 */
	public void setTotalExp(double totalExp) {
		this.totalExp = totalExp;
	}
	
	/**
	 * @return Returns the expYears.
	 */
	public String getExpYears() {
		return expYears;
	}
	/**
	 * @param expYears The expYears to set.
	 */
	public void setExpYears(String expYears) {
		this.expYears = expYears;
	}
	
	public String getSubSourceType() {
		return subSourceType;
	}
	public void setSubSourceType(String subSourceType) {
		this.subSourceType = subSourceType;
	}
}


