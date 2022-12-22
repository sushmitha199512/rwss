package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class Rws_Direct_Bills_Form extends ActionForm{
	
	/**
	 * @author Krishna K
	 */
	private static final long serialVersionUID = -7728305446360034054L;

	private String nwork;
	private String nmode;
	
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
    private String adminAmnt;
    private String adminDate;
    private String adminNo;
   
    private String mileStone;
    private String mileStoneSno;
    private String majorMileStone;
    private String stage;
    private String compInNo;
    private String targetDate;
    
	private ArrayList mileStones;
	private String conMode;
	
	private String subdivisioncode;
	private String program;
	private String subprogram;
	
	private String mandalCode;
	private String panchayatCode;
	private String villageCode;
	private String habsCode;
	private String mandalName;
	
	private String slNo;
	private String newsrcName;
	private String newsrcCode;
	private String sitehab;
	private String spradgroup;
	private String revflag;
	private String revdel;
	private String probCompDate;
	private String psMode;
	private String subDivAssign;
	private String engineerAssign;
	private String engineerAssign1;
	private String engineerAssign2;
	private String engineerAssign3;
	private String workGndDate;
	private String agreeDate;
	
	private double totalExp;
	private ArrayList expenditureList;
	private String admSanDate;
	private String workCount;
	private ArrayList programmeList;
	
	private String remarks;
	
    private String headOfficeName;
    private String headOfficeCode;
    private String circleOfficeName;
    private String circleOfficeCode;
    private String divisionOfficeName;
    private String divisionOfficeCode;
    private String subdivisionOfficeName;
    private String subdivisionOfficeCode;
    private String habName;
    private String habCode;
    private String assetTypeName;
    private String assetTypeCode;
    private String assetCode;
   
    private String assetName;
    private String location;
    private String assetStatusName;
   
    private String totHabs;
   
    private String samount;
    private ArrayList astwork;
    private ArrayList assettype;
  
    private ArrayList contractorList;
    
    
    public  Rws_Direct_Bills_Bean  getWORKS_DELETES(int index)
	{
		while(index >= contractorList.size())
		{
			contractorList.add(new Rws_Direct_Bills_Bean());
		}
		return (Rws_Direct_Bills_Bean)contractorList.get(index);
	}
    
    private ArrayList vouchersList;
	public String getProgram() {
		return program;
	}
	public void setProgram(String program) {
		this.program = program;
	}
	public String getMileStoneName() {
		return mileStoneName;
	}
	public void setMileStoneName(String mileStoneName) {
		this.mileStoneName = mileStoneName;
	}
	 private String mileStoneName;
    //constructor
	@SuppressWarnings("unchecked")
	public Rws_Direct_Bills_Form()
	{
	 	mileStones=new ArrayList();
 		expenditureList=new ArrayList();
 		programmeList=new ArrayList();
 	}
	
	@SuppressWarnings("unchecked")
	public  Rws_Direct_Bills_Bean  getVOUCHER_LIST(int index)
	{
		System.out.println("sdf--"+  index);
		while(index >= vouchersList.size())
		{
			vouchersList.add(new Rws_Direct_Bills_Bean());
		}
	 
		return (Rws_Direct_Bills_Bean)vouchersList.get(index);
	}
	
	
	@SuppressWarnings("unchecked")
	public  Rws_Direct_Bills_Bean  getWORKEXP_LIST(int index)
	{
		while(index >= expenditureList.size())
		{
			expenditureList.add(new Rws_Direct_Bills_Bean());
		}
	 
		return (Rws_Direct_Bills_Bean)expenditureList.get(index);
	}
	@SuppressWarnings("unchecked")
	public Rws_Direct_Bills_Bean_Form getMILES(int index)
	{
		while(index >= mileStones.size())
		{
			mileStones.add(new Rws_Direct_Bills_Bean_Form());
		}
		return (Rws_Direct_Bills_Bean_Form)mileStones.get(index);
	}
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
			this.officeCode="";
			this.preparedBy="";
			this.mode="";
			this.circleName="";
			this.circleCode="";
			this.divName="";
			this.divCode="";
			this.subDivCode="";
			this.subDivName="";
			this.workId="";
			this.workName="";
			this.progName="";
			this.subProgName="";
			this.scheme="";
			this.schemeCode="";
			this.progCode="";
			this.subProgCode="";
			this.workStage="";			
			this.adminAmnt="";
			this.adminDate="";
			this.adminNo="";
			this.mileStone="";
			this.stage="";
			this.targetDate="";			
			this.conMode="";
			this.subdivisioncode="";
			this.program="";
			this.subprogram="";
			
 	}
 
 
	public String getSchemeCode() {
		return schemeCode;
	}
	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}
 

	public String getNwork() {
		return nwork;
	}
	public void setNwork(String nwork) {
		this.nwork = nwork;
	}
	public String getNmode() {
		return nmode;
	}
	public void setNmode(String nmode) {
		this.nmode = nmode;
	}

	public String getOfficeCode() {
		return officeCode;
	}
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	public String getPreparedBy() {
		return preparedBy;
	}
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getCircleName() {
		return circleName;
	}
	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}
	public String getCircleCode() {
		return circleCode;
	}
	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}
	public String getDivName() {
		return divName;
	}
	public void setDivName(String divName) {
		this.divName = divName;
	}
	public String getDivCode() {
		return divCode;
	}
	public void setDivCode(String divCode) {
		this.divCode = divCode;
	}
	public String getSubDivCode() {
		return subDivCode;
	}
	public void setSubDivCode(String subDivCode) {
		this.subDivCode = subDivCode;
	}
	public String getSubDivName() {
		return subDivName;
	}
	public void setSubDivName(String subDivName) {
		this.subDivName = subDivName;
	}
	public String getWorkId() {
		return workId;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public String getWorkName() {
		return workName;
	}
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getSubProgName() {
		return subProgName;
	}
	public void setSubProgName(String subProgName) {
		this.subProgName = subProgName;
	}
	public String getScheme() {
		return scheme;
	}
	public void setScheme(String scheme) {
		this.scheme = scheme;
	}
	public String getProgCode() {
		return progCode;
	}
	public void setProgCode(String progCode) {
		this.progCode = progCode;
	}
	public String getSubProgCode() {
		return subProgCode;
	}
	public void setSubProgCode(String subProgCode) {
		this.subProgCode = subProgCode;
	}
	public String getWorkStage() {
		return workStage;
	}
	public void setWorkStage(String workStage) {
		this.workStage = workStage;
	}
	public String getAdminAmnt() {
		return adminAmnt;
	}
	public void setAdminAmnt(String adminAmnt) {
		this.adminAmnt = adminAmnt;
	}
	public String getAdminDate() {
		return adminDate;
	}
	public void setAdminDate(String adminDate) {
		this.adminDate = adminDate;
	}
	public String getAdminNo() {
		return adminNo;
	}
	public void setAdminNo(String adminNo) {
		this.adminNo = adminNo;
	}

	public String getMileStone() {
		return mileStone;
	}
	public void setMileStone(String mileStone) {
		this.mileStone = mileStone;
	}
	public String getMileStoneSno() {
		return mileStoneSno;
	}
	public void setMileStoneSno(String mileStoneSno) {
		this.mileStoneSno = mileStoneSno;
	}
	public String getMajorMileStone() {
		return majorMileStone;
	}
	public void setMajorMileStone(String majorMileStone) {
		this.majorMileStone = majorMileStone;
	}
	public String getStage() {
		return stage;
	}
	public void setStage(String stage) {
		this.stage = stage;
	}
	public String getCompInNo() {
		return compInNo;
	}
	public void setCompInNo(String compInNo) {
		this.compInNo = compInNo;
	}
	public String getTargetDate() {
		return targetDate;
	}
	public void setTargetDate(String targetDate) {
		this.targetDate = targetDate;
	}

	public ArrayList getMileStones() {
		return mileStones;
	}
	public void setMileStones(ArrayList mileStones) {
		this.mileStones = mileStones;
	}
	public String getConMode() {
		return conMode;
	}
	public void setConMode(String conMode) {
		this.conMode = conMode;
	}
	public String getPanchayatCode() {
		return panchayatCode;
	}
	public void setPanchayatCode(String panchayatCode) {
		this.panchayatCode = panchayatCode;
	}
	public String getVillageCode() {
		return villageCode;
	}
	public void setVillageCode(String villageCode) {
		this.villageCode = villageCode;
	}
	public String getHabsCode() {
		return habsCode;
	}
	public void setHabsCode(String habsCode) {
		this.habsCode = habsCode;
	}

	public ArrayList getContractorList() {
		return contractorList;
	}
	public void setContractorList(ArrayList contractorList) {
		this.contractorList = contractorList;
	}
	public ArrayList getVouchersList() {
		return vouchersList;
	}
	public void setVouchersList(ArrayList vouchersList) {
		this.vouchersList = vouchersList;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
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

	public String getSlNo() {
		return slNo;
	}
	public void setSlNo(String slNo) {
		this.slNo = slNo;
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

	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
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

	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
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

}
