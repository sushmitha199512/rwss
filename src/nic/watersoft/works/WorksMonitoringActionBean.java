package nic.watersoft.works;

 
import java.io.Serializable;
import java.util.ArrayList;
public class WorksMonitoringActionBean implements Serializable

{
	private String flag;
	private String cmbCircle;
	private int	cmbDivision;
	private String cmbSubDivision;
	private String cmbAssetType;
	private String cmbMonth;
	private String cmbYear;
	private String enteredBy;
	private String enteredDate;
	private String dateOfComm;
	private String divisionName;
	private String circleName;
	private String cmdDel;
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
	private String engineerAssign1;
	private String engineerAssign2;
	private String engineerAssign3;
	private String workGndDate;
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
	private String expYear;
	private String expMonth;
	private String expMonthDuring;
	private String expMonthUp;
	private String expenditure;
	private String plainPop;
	private String scPop;
    private String stPop;
    private String valueOFWorkDone;
    
    private String workCompStartDate;
	private String workCompAgreementDate;
	private String workCompDateCompleted;
	private String workCompStipulatedDateOfCompletion;
	private String tenderPer="";
	private String progCode;
	private String progName;
	private String remarks;
	private String subSourceType;
	
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
//----------------------------------------------------------------------------------

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
//----------------------------------------------------------------------------------
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
	/*public tenderMemo getappListt(int index)
	{
		while(index >= memo.size())
		{
			//System.out.println("index in getSOURCEASSET_LIST= "+index);
			memo.add(new tenderMemo());
		}
		return (tenderMemo)memo.get(index);
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
	public void setCmbSubDivision(String cmbSubDivision)
	{
		this.cmbSubDivision = cmbSubDivision;
	}
	public String getCmbSubDivision()
	{
		return cmbSubDivision;
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
	/**
	 * @return Returns the mandalCode.
	 */
	public String getMandalCode() {
			return mandalCode;
	}
	/**
	 * @param mandalCode The mandalCode to set.
	 */
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
	}
	/**
	 * @return Returns the mandalName.
	 */
	public String getMandalName() {
		return mandalName;
	}
	/**
	 * @param mandalName The mandalName to set.
	 */
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	/**
	 * @return Returns the codeStatus.
	 */
	public String getCodeStatus() {
		return codeStatus;
	}
	/**
	 * @param codeStatus The codeStatus to set.
	 */
	public void setCodeStatus(String codeStatus) {
		this.codeStatus = codeStatus;
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
	/**
	 * @return Returns the expMonth.
	 */
	public String getExpMonth() {
		return expMonth;
	}
	/**
	 * @param expMonth The expMonth to set.
	 */
	public void setExpMonth(String expMonth) {
		this.expMonth = expMonth;
	}
	/**
	 * @return Returns the expYear.
	 */
	public String getExpYear() {
		return expYear;
	}
	/**
	 * @param expYear The expYear to set.
	 */
	public void setExpYear(String expYear) {
		this.expYear = expYear;
	}
	/**
	 * @return Returns the expMonthDuring.
	 */
	public String getExpMonthDuring() {
		return expMonthDuring;
	}
	/**
	 * @param expMonthDuring The expMonthDuring to set.
	 */
	public void setExpMonthDuring(String expMonthDuring) {
		this.expMonthDuring = expMonthDuring;
	}
	/**
	 * @return Returns the expMonthUp.
	 */
	public String getExpMonthUp() {
		return expMonthUp;
	}
	/**
	 * @param expMonthUp The expMonthUp to set.
	 */
	public void setExpMonthUp(String expMonthUp) {
		this.expMonthUp = expMonthUp;
	}
	/**
	 * @return Returns the plainPop.
	 */
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
	 * @return Returns the expenditureList.
	 */
	
	public String getWorkCompAgreementDate() {
		return workCompAgreementDate;
	}
	public void setWorkCompAgreementDate(String workCompAgreementDate) {
		this.workCompAgreementDate = workCompAgreementDate;
	}
	public String getWorkCompDateCompleted() {
		return workCompDateCompleted;
	}
	public void setWorkCompDateCompleted(String workCompDateCompleted) {
		this.workCompDateCompleted = workCompDateCompleted;
	}
	public String getWorkCompStartDate() {
		return workCompStartDate;
	}
	public void setWorkCompStartDate(String workCompStartDate) {
		this.workCompStartDate = workCompStartDate;
	}
	public String getWorkCompStipulatedDateOfCompletion() {
		return workCompStipulatedDateOfCompletion;
	}
	public void setWorkCompStipulatedDateOfCompletion(
			String workCompStipulatedDateOfCompletion) {
		this.workCompStipulatedDateOfCompletion = workCompStipulatedDateOfCompletion;
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
	
	public String getSubSourceType() {
		return subSourceType;
	}
	public void setSubSourceType(String subSourceType) {
		this.subSourceType = subSourceType;
	}
}
