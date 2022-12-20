
package nic.watersoft.works;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

 
public class rws_projectshelf_works_probabledt_frm extends ActionForm
{
	private ArrayList<rws_projectshelf_works_probabledt_bean> psWorks;
	private ArrayList<rws_projectshelf_works_probabledt_bean> milestones;
	
	private String circleOfficeCode;
	private String circleOfficeName;
	private String divisionOfficeCode;
	private String subdivisionOfficeCode;
	private String mandal;
	private String mode;
	private String type;
	private String programCode;
	private String schemeCode;
	
	private String dcode;
	private String divcode;
	private String dname;
	private String divname;
	private String mname;
	private String admnNo;
	private String admnAmnt;
	private String workId;
	private String workName;
	private String sanctionAmt;
	private String admnDate;
	private String groundingDate;
	private String sourceCode;
	private String sourceName;
	private String sourceLocation;
	private String check;
	
	private String progName;
	private String subprogName;
	private String noofhabs;
	private String main;
	private String label;
	private String contCode;
	//private String groundDate;
	private String probableDate;
	private String checks;
	private String workStatus;
	private String workStatusDate;
	private String groundedDate;
	private String financialDate;
	private String physicalDate;
	private String commisionedDate;
	private String expLastFinancialYear;
	private String expUptoLastMonth;
	private String expCurrentMonth;
	private String expTotal;
	private String imageStatus;
	private String description;
	private String imageStatus1;
	private String imageStatus2;
	private FormFile scannedCopy;
	private String schemeType;
	private String coreDashboardStatus;
	private String slsscDate;
	private String agreementDate;
	private String reasonCode;
	private String reasonName;
	private String perPhyCompl;
	private String mileStoneCode;
	private String mileStoneName;
	private String mileStoneStageCode;
	private String mileStoneStageName;
	private String status;
	private String stagePer;
	private String compCode;
	private String compName;
	private String sourceType;
	private String subSourceType;
	private String kpiHabList;
	private double currentMonthPer;
	private double previousMonthPer;
	
	
	public double getCurrentMonthPer() {
		return currentMonthPer;
	}
	public void setCurrentMonthPer(double currentMonthPer) {
		this.currentMonthPer = currentMonthPer;
	}
	public double getPreviousMonthPer() {
		return previousMonthPer;
	}
	public void setPreviousMonthPer(double previousMonthPer) {
		this.previousMonthPer = previousMonthPer;
	}	
	
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getSubSourceType() {
		return subSourceType;
	}
	public void setSubSourceType(String subSourceType) {
		this.subSourceType = subSourceType;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
	}
	public String getCompCode() {
		return compCode;
	}
	public void setCompCode(String compCode) {
		this.compCode = compCode;
	}
	public String getStagePer() {
		return stagePer;
	}
	public void setStagePer(String stagePer) {
		this.stagePer = stagePer;
	}
	public String getMileStoneCode() {
		return mileStoneCode;
	}
	public void setMileStoneCode(String mileStoneCode) {
		this.mileStoneCode = mileStoneCode;
	}
	public String getMileStoneName() {
		return mileStoneName;
	}
	public void setMileStoneName(String mileStoneName) {
		this.mileStoneName = mileStoneName;
	}
	public String getMileStoneStageCode() {
		return mileStoneStageCode;
	}
	public void setMileStoneStageCode(String mileStoneStageCode) {
		this.mileStoneStageCode = mileStoneStageCode;
	}
	public String getMileStoneStageName() {
		return mileStoneStageName;
	}
	public void setMileStoneStageName(String mileStoneStageName) {
		this.mileStoneStageName = mileStoneStageName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPerPhyCompl() {
		return perPhyCompl;
	}
	public void setPerPhyCompl(String perPhyCompl) {
		this.perPhyCompl = perPhyCompl;
	}
	public String getReasonCode() {
		return reasonCode;
	}
	public void setReasonCode(String reasonCode) {
		this.reasonCode = reasonCode;
	}
	public String getReasonName() {
		return reasonName;
	}
	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}
	public String getAgreementDate() {
		return agreementDate;
	}
	public void setAgreementDate(String agreementDate) {
		this.agreementDate = agreementDate;
	}
	public String getSlsscDate() {
		return slsscDate;
	}
	public void setSlsscDate(String slsscDate) {
		this.slsscDate = slsscDate;
	}
	public String getCoreDashboardStatus() {
		return coreDashboardStatus;
	}
	public void setCoreDashboardStatus(String coreDashboardStatus) {
		this.coreDashboardStatus = coreDashboardStatus;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getSchemeType() {
		return schemeType;
	}
	public void setSchemeType(String schemeType) {
		this.schemeType = schemeType;
	}
	public String getMandal() {
		return mandal;
	}
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	public String getSubdivisionOfficeCode() {
		return subdivisionOfficeCode;
	}
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
		this.subdivisionOfficeCode = subdivisionOfficeCode;
	}
	public String getImageStatus1() {
		return imageStatus1;
	}
	public void setImageStatus1(String imageStatus1) {
		this.imageStatus1 = imageStatus1;
	}
	public String getImageStatus2() {
		return imageStatus2;
	}
	public void setImageStatus2(String imageStatus2) {
		this.imageStatus2 = imageStatus2;
	}
	public String getImageStatus() {
		return imageStatus;
	}
	public void setImageStatus(String imageStatus) {
		this.imageStatus = imageStatus;
	}
	public FormFile getScannedCopy() {
		return scannedCopy;
	}
	public void setScannedCopy(FormFile scannedCopy) {
		this.scannedCopy = scannedCopy;
	}
	public ArrayList<rws_projectshelf_works_probabledt_bean> getPsWorks() {
		return psWorks;
	}
	public void setPsWorks(ArrayList<rws_projectshelf_works_probabledt_bean> psWorks) {
		this.psWorks = psWorks;
	}
	/**
	 * @return Returns the programCode.
	 */
	public String getProgramCode() {
		return programCode;
	}
	/**
	 * @param programCode The programCode to set.
	 */
	public void setProgramCode(String programCode) {
		this.programCode = programCode;
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
	private String category;
	

	
	
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
	
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	
private String stipulatedDate;
	
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getExpLastFinancialYear() {
		return expLastFinancialYear;
	}
	public void setExpLastFinancialYear(String expLastFinancialYear) {
		this.expLastFinancialYear = expLastFinancialYear;
	}
	public String getExpUptoLastMonth() {
		return expUptoLastMonth;
	}
	public void setExpUptoLastMonth(String expUptoLastMonth) {
		this.expUptoLastMonth = expUptoLastMonth;
	}
	public String getExpCurrentMonth() {
		return expCurrentMonth;
	}
	public void setExpCurrentMonth(String expCurrentMonth) {
		this.expCurrentMonth = expCurrentMonth;
	}
	public String getExpTotal() {
		return expTotal;
	}
	public void setExpTotal(String expTotal) {
		this.expTotal = expTotal;
	}
	public String getGroundedDate() {
		return groundedDate;
	}
	public void setGroundedDate(String groundedDate) {
		this.groundedDate = groundedDate;
	}
	public String getFinancialDate() {
		return financialDate;
	}
	public void setFinancialDate(String financialDate) {
		this.financialDate = financialDate;
	}
	public String getPhysicalDate() {
		return physicalDate;
	}
	public void setPhysicalDate(String physicalDate) {
		this.physicalDate = physicalDate;
	}
	public String getCommisionedDate() {
		return commisionedDate;
	}
	public void setCommisionedDate(String commisionedDate) {
		this.commisionedDate = commisionedDate;
	}
	public String getWorkStatus() {
		return workStatus;
	}
	public void setWorkStatus(String workStatus) {
		this.workStatus = workStatus;
	}
	public String getWorkStatusDate() {
		return workStatusDate;
	}
	public void setWorkStatusDate(String workStatusDate) {
		this.workStatusDate = workStatusDate;
	}
	public String getAdmnAmnt() {
		return admnAmnt;
	}
	public void setAdmnAmnt(String admnAmnt) {
		this.admnAmnt = admnAmnt;
	}
	public String getAdmnDate() {
		return admnDate;
	}
	public void setAdmnDate(String admnDate) {
		this.admnDate = admnDate;
	}
	public String getAdmnNo() {
		return admnNo;
	}
	public void setAdmnNo(String admnNo) {
		this.admnNo = admnNo;
	}
	public String getDcode() {
		return dcode;
	}
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	public String getDivcode() {
		return divcode;
	}
	public void setDivcode(String divcode) {
		this.divcode = divcode;
	}
	public String getDivname() {
		return divname;
	}
	public void setDivname(String divname) {
		this.divname = divname;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getGroundingDate() {
		return groundingDate;
	}
	public void setGroundingDate(String groundingDate) {
		this.groundingDate = groundingDate;
	}
	public String getSanctionAmt() {
		return sanctionAmt;
	}
	public void setSanctionAmt(String sanctionAmt) {
		this.sanctionAmt = sanctionAmt;
	}
	public String getSourceCode() {
		return sourceCode;
	}
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}
	public String getSourceLocation() {
		return sourceLocation;
	}
	public void setSourceLocation(String sourceLocation) {
		this.sourceLocation = sourceLocation;
	}
	public String getSourceName() {
		return sourceName;
	}
	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
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
	public String getCheck() {
		return check;
	}
	public void setCheck(String check) {
		this.check = check;
	}
	
	public String getChecks() {
		return checks;
	}
	public void setChecks(String checks) {
		this.checks = checks;
	}
	public String getContCode() {
		return contCode;
	}
	public void setContCode(String contCode) {
		this.contCode = contCode;
	}public String getProbableDate() {
		return probableDate;
	}
	public void setProbableDate(String probableDate) {
		this.probableDate = probableDate;
	}
	
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getMain() {
		return main;
	}
	public void setMain(String main) {
		this.main = main;
	}
	public String getNoofhabs() {
		return noofhabs;
	}
	public void setNoofhabs(String noofhabs) {
		this.noofhabs = noofhabs;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getSubprogName() {
		return subprogName;
	}
	public void setSubprogName(String subprogName) {
		this.subprogName = subprogName;
	}
	public ArrayList<rws_projectshelf_works_probabledt_bean> getMilestones() {
		return milestones;
	}
	public void setMilestones(
			ArrayList<rws_projectshelf_works_probabledt_bean> milestones) {
		this.milestones = milestones;
	}
	public String getKpiHabList() {
		return kpiHabList;
	}
	public void setKpiHabList(String kpiHabList) {
		this.kpiHabList = kpiHabList;
	}
	
	/*public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		this.admnDate="";
		this.admnAmnt="";
		this.admnNo="";
		this.dcode="";
		this.mode="";
		this.agreementDate="";
		this.probableDate="";
		this.category="";
		this.circleOfficeCode="";
		this.commisionedDate="";
		this.compCode="";
		this.contCode="";
		this.coreDashboardStatus="";
		this.divcode="";
		this.divisionOfficeCode="";
		this.expCurrentMonth="";
		this.expLastFinancialYear="";
		this.expUptoLastMonth="";
		this.financialDate="";
		this.groundedDate="";
		this.groundingDate="";
		this.imageStatus="";
		this.imageStatus1="";
		this.imageStatus2="";
		this.mileStoneCode="";
		this.mileStoneStageCode="";
		this.noofhabs="";
		this.physicalDate="";
		this.programCode="";
		this.reasonCode="";
		this.sanctionAmt="";
		this.schemeCode="";
		this.slsscDate="";
		this.sourceCode="";
		this.status="";
		this.subdivisionOfficeCode="";
		this.subSourceType="";
		this.type="";
		this.workId="";
		this.workName="";
		this.workStatus="";
		this.workStatusDate="";
		this.schemeType="";
		this.psWorks=null;
	}*/
	
	
	/*public ActionErrors validateFileUpload(ActionMapping mapping, HttpServletRequest request) {
        ActionErrors errors = new ActionErrors();
        FormFile dataFile = this.getScannedCopy();
        System.out.println(dataFile.getContentType());
        String dataFileName = dataFile.getFileName();
        if (dataFile == null) {
           errors.add( ActionErrors.GLOBAL_ERROR, new ActionError("invalid.file"));
        }else if (dataFileName == null || dataFileName.length() == 0) {
           errors.add( ActionErrors.GLOBAL_ERROR, new ActionError("file.required"));
        } else if (!dataFileName.matches("[a-zA-Z0-9\\s\\-]+\\.pdf")) {
           errors.add( ActionErrors.GLOBAL_ERROR, new ActionError("filename.invalid"));
          } else if (dataFile.getFileSize()>2048) { //2mb
        	  System.out.println("inside size");
       errors.add(ActionErrors.GLOBAL_ERROR, new ActionError("file.size.invalid"));
           }

    return errors;
   }*/
}
