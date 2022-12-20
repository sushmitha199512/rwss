
package nic.watersoft.works;

import java.io.Serializable;

import org.apache.struts.upload.FormFile;

public class rws_projectshelf_works_probabledt_bean implements Serializable {
	
	
	private String stipulatedDate;
	

	public String getStipulatedDate() {
		return stipulatedDate;
	}
	
	public void setStipulatedDate(String stipulatedDate) {
		this.stipulatedDate = stipulatedDate;
	}
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
	private FormFile scannedCopy;
	private String imageStatus1;
	private String imageStatus2;
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
	private String updatedateStatus;
	private String kpiStatus;
	private String habCode;
	private String habName;
	private String kpiHabList;
	private double milestonePercentage;
	private double milestoneStagePercentage;
	private String majorChecks;
	private String allChecks;
	
	
	
	public String getMajorChecks() {
		return majorChecks;
	}
	public void setMajorChecks(String majorChecks) {
		this.majorChecks = majorChecks;
	}
	public String getAllChecks() {
		return allChecks;
	}
	public void setAllChecks(String allChecks) {
		this.allChecks = allChecks;
	}
	public double getMilestoneStagePercentage() {
		return milestoneStagePercentage;
	}
	public void setMilestoneStagePercentage(double milestoneStagePercentage) {
		this.milestoneStagePercentage = milestoneStagePercentage;
	}
	public double getMilestonePercentage() {
		return milestonePercentage;
	}
	public void setMilestonePercentage(double milestonePercentage) {
		this.milestonePercentage = milestonePercentage;
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
	public String getCompCode() {
		return compCode;
	}
	public void setCompCode(String compCode) {
		this.compCode = compCode;
	}
	public String getCompName() {
		return compName;
	}
	public void setCompName(String compName) {
		this.compName = compName;
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
	public String getReasonName() {
		return reasonName;
	}
	public void setReasonName(String reasonName) {
		this.reasonName = reasonName;
	}
	public String getReasonCode() {
		return reasonCode;
	}
	public void setReasonCode(String reasonCode) {
		this.reasonCode = reasonCode;
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
	}
	/*public String getGroundDate() {
		return groundDate;
	}
	public void setGroundDate(String groundDate) {
		this.groundDate = groundDate;
	}*/
	
	public String getProbableDate() {
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
	private String circleOfficeCode;
	private String circleOfficeName;
	private String divisionOfficeCode;
	
	private String mode;
	private String type;
	private String programCode;
	private String schemeCode;

	
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
	public String getUpdatedateStatus() {
		return updatedateStatus;
	}
	public void setUpdatedateStatus(String updatedateStatus) {
		this.updatedateStatus = updatedateStatus;
	}
	public String getKpiStatus() {
		return kpiStatus;
	}
	public void setKpiStatus(String kpiStatus) {
		this.kpiStatus = kpiStatus;
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
	public String getKpiHabList() {
		return kpiHabList;
	}
	public void setKpiHabList(String kpiHabList) {
		this.kpiHabList = kpiHabList;
	}
	
}