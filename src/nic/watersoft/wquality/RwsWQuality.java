package nic.watersoft.wquality;

import java.io.Serializable;

import org.apache.struts.upload.FormFile;

public class RwsWQuality implements Serializable
{
	private String contaminType;
	private String testType;
	
	
	/**
	 * @return Returns the contaminType.
	 */
	public String getContaminType() {
		return contaminType;
	}
	/**
	 * @param contaminType The contaminType to set.
	 */
	public void setContaminType(String contaminType) {
		this.contaminType = contaminType;
	}
	/**
	 * @return Returns the testType.
	 */
	public String getTestType() {
		return testType;
	}
	/**
	 * @param testType The testType to set.
	 */
	public void setTestType(String testType) {
		this.testType = testType;
	}
	private String mandalCode;
	private String mandalName;
	private String panchCode;
	private String panchName;
	private String villageCode;
	private String habCode;
	private String roc;
	private String coc;
	private String doc;
	private String sdoc;
	private String circleOfficeName;
	private String divisionOfficeName;
	private String subDivisionOfficeName;
	private String codeName;
	private String empcode;
	private String empname;
	private String minPerVal;
	private String maxPerVal;
	private String undesirableEffect;
	private String result;
	private String remarks;
	private String depth;
	private String yield;
	private String prgmCode;
	private String prgmName;
	private String habName;
		
	private String ftklab;
	private String ftktestid;
	private String forwardtolab;
	private String sourceCode;
	private String sourceName;
	private String sourceType;
	
	private String assetTypeCode;
	private String compTypeCode;
	private String subCompTypeCode;
	
	private String subprgmCode;
	private String subprgmName;
	
	private String testCode;
	private String testName; 
	private String testPCode; 
	private String testPName;
		 
	 private String recommendations;
	 private String condemnSource;
	 private String updateSource;
	 private String forwadedTo;
	 private String forwadedOn;
	 private String preparedBy;
	 private String preparedOn;
	 private String natureOfTest;
	 private String labCode;
	 private String labName;
	 private String sampCollectCode;
	 private String sampCollectDate;
	 private String sampCollectTime;
	 private String assignedTo;
	 private String assignedOn;
	 private String workCode;
	 private FormFile sitePlan;
	 private String casing;
	 private String source1;
	 private String source2;
	 private String source3;
	 private String depth1;
	 private String depth2;
	 private String depth3;
	 private String yield1;
	 private String yield2;
	 private String yield3;
	 private String siteIdenData;
	 private String finalised;
	 private String finalDate;
	 private String testId;
	 private String drillDate;
     private String drillStatus;

	 private String resultObtainOn;
	 private String resultForwardOn;
	 private String dateAssignedFromDiv;
	 private String code;
	 private String name;
	 private String checkedTest;
	 	 
	 //code added
	private String sourceCode1;
	private String sourceCode2;
	private String sourceCode3;
	private String officeCode;
	 //fields to hold testingResult data
	private String testingParameterCode;
	private String testingParameterName;
	private String minPermissibleValue;
	private String maxPermissibleValue;
	private String testingParameterValue;
    private String ftkTestDate;
	private String forwardDate;
	
	private String circleOfficeCode;
	private String divisionOfficeCode;
	private String subdivisionOfficeCode;
	private String ftkCtype;
	private String ftkHtype;
	
	
	public String getFtkCtype() {
		return ftkCtype;
	}
	public void setFtkCtype(String ftkCtype) {
		this.ftkCtype = ftkCtype;
	}
	public String getFtkHtype() {
		return ftkHtype;
	}
	public void setFtkHtype(String ftkHtype) {
		this.ftkHtype = ftkHtype;
	}
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	public String getSubdivisionOfficeCode() {
		return subdivisionOfficeCode;
	}
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
		this.subdivisionOfficeCode = subdivisionOfficeCode;
	}
	/**
	 * @return Returns the ftktestid
	 */
	public String getFtktestid() {
		return ftktestid;
	}
	/**
	 * @param ftktestid The ftktestid to set.
	 */
	public void setFtktestid(String ftktestid) {
		this.ftktestid = ftktestid;
	}
	/**
	 * @return Returns the forwardtolab
	 */
	public String getForwardtolab() {
		return forwardtolab;
	}
	/**
	 * @param forwardDate The forwardDate to set.
	 */
	public void setForwardtolab(String forwardtolab) {
		this.forwardtolab = forwardtolab;
	}
	/**
	 * @return Returns the forwardDate.
	 */
	public String getForwardDate() {
		return forwardDate;
	}
	/**
	 * @param forwardDate The forwardDate to set.
	 */
	public void setForwardDate(String forwardDate) {
		this.forwardDate = forwardDate;
	}
    /**
	 * @return Returns the ftkTestDate.
	 */
	public String getFtkTestDate() {
		return ftkTestDate;
	}
	/**
	 * @param ftkTestDate The ftkTestDate to set.
	 */
	public void setFtkTestDate(String ftkTestDate) {
		this.ftkTestDate = ftkTestDate;
	}
	
	/**
	 * @return Returns the assignedOn.
	 */
	public String getAssignedOn() {
		return assignedOn;
	}
	/**
	 * @param assignedOn The assignedOn to set.
	 */
	public void setAssignedOn(String assignedOn) {
		this.assignedOn = assignedOn;
	}
	/**
	 * @return Returns the assignedTo.
	 */
	public String getAssignedTo() {
		return assignedTo;
	}
	/**
	 * @param assignedTo The assignedTo to set.
	 */
	public void setAssignedTo(String assignedTo) {
		this.assignedTo = assignedTo;
	}
	/**
	 * @return Returns the casing.
	 */
	public String getCasing() {
		return casing;
	}
	/**
	 * @param casing The casing to set.
	 */
	public void setCasing(String casing) {
		this.casing = casing;
	}
	/**
	 * @return Returns the condemnSource.
	 */
	public String getCondemnSource() {
		return condemnSource;
	}
	/**
	 * @param condemnSource The condemnSource to set.
	 */
	public void setCondemnSource(String condemnSource) {
		this.condemnSource = condemnSource;
	}
	/**
	 * @return Returns the dateAssignedFromDiv.
	 */
	public String getDateAssignedFromDiv() {
		return dateAssignedFromDiv;
	}
	/**
	 * @param dateAssignedFromDiv The dateAssignedFromDiv to set.
	 */
	public void setDateAssignedFromDiv(String dateAssignedFromDiv) {
		this.dateAssignedFromDiv = dateAssignedFromDiv;
	}
	/**
	 * @return Returns the depth1.
	 */
	public String getDepth1() {
		return depth1;
	}
	/**
	 * @param depth1 The depth1 to set.
	 */
	public void setDepth1(String depth1) {
		this.depth1 = depth1;
	}
	/**
	 * @return Returns the depth2.
	 */
	public String getDepth2() {
		return depth2;
	}
	/**
	 * @param depth2 The depth2 to set.
	 */
	public void setDepth2(String depth2) {
		this.depth2 = depth2;
	}
	/**
	 * @return Returns the depth3.
	 */
	public String getDepth3() {
		return depth3;
	}
	/**
	 * @param depth3 The depth3 to set.
	 */
	public void setDepth3(String depth3) {
		this.depth3 = depth3;
	}
	/**
	 * @return Returns the drillDate.
	 */
	public String getDrillDate() {
		return drillDate;
	}
	/**
	 * @param drillDate The drillDate to set.
	 */
	public void setDrillDate(String drillDate) {
		this.drillDate = drillDate;
	}
	/**
	 * @return Returns the drillStatus.
	 */
	public String getDrillStatus() {
		return drillStatus;
	}
	/**
	 * @param drillStatus The drillStatus to set.
	 */
	public void setDrillStatus(String drillStatus) {
		this.drillStatus = drillStatus;
	}
	/**
	 * @return Returns the finalDate.
	 */
	public String getFinalDate() {
		return finalDate;
	}
	/**
	 * @param finalDate The finalDate to set.
	 */
	public void setFinalDate(String finalDate) {
		this.finalDate = finalDate;
	}
	/**
	 * @return Returns the finalised.
	 */
	public String getFinalised() {
		return finalised;
	}
	/**
	 * @param finalised The finalised to set.
	 */
	public void setFinalised(String finalised) {
		this.finalised = finalised;
	}
	/**
	 * @return Returns the forwadedOn.
	 */
	public String getForwadedOn() {
		return forwadedOn;
	}
	/**
	 * @param forwadedOn The forwadedOn to set.
	 */
	public void setForwadedOn(String forwadedOn) {
		this.forwadedOn = forwadedOn;
	}
	/**
	 * @return Returns the forwadedTo.
	 */
	public String getForwadedTo() {
		return forwadedTo;
	}
	/**
	 * @param forwadedTo The forwadedTo to set.
	 */
	public void setForwadedTo(String forwadedTo) {
		this.forwadedTo = forwadedTo;
	}
	/**
	 * @return Returns the labCode.
	 */
	public String getLabCode() {
		return labCode;
	}
	/**
	 * @param labCode The labCode to set.
	 */
	public void setLabCode(String labCode) {
		this.labCode = labCode;
	}
	/**
	 * @return Returns the labName.
	 */
	public String getLabName() {
		return labName;
	}
	/**
	 * @param labName The labName to set.
	 */
	public void setLabName(String labName) {
		this.labName = labName;
	}
	/**
	 * @return Returns the natureOfTest.
	 */
	public String getNatureOfTest() {
		return natureOfTest;
	}
	/**
	 * @param natureOfTest The natureOfTest to set.
	 */
	public void setNatureOfTest(String natureOfTest) {
		this.natureOfTest = natureOfTest;
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
	 * @return Returns the preparedOn.
	 */
	public String getPreparedOn() {
		return preparedOn;
	}
	/**
	 * @param preparedOn The preparedOn to set.
	 */
	public void setPreparedOn(String preparedOn) {
		this.preparedOn = preparedOn;
	}
	/**
	 * @return Returns the recommendations.
	 */
	public String getRecommendations() {
		return recommendations;
	}
	/**
	 * @param recommendations The recommendations to set.
	 */
	public void setRecommendations(String recommendations) {
		this.recommendations = recommendations;
	}
	/**
	 * @return Returns the resultForwardOn.
	 */
	public String getResultForwardOn() {
		return resultForwardOn;
	}
	/**
	 * @param resultForwardOn The resultForwardOn to set.
	 */
	public void setResultForwardOn(String resultForwardOn) {
		this.resultForwardOn = resultForwardOn;
	}
	/**
	 * @return Returns the resultObtainOn.
	 */
	public String getResultObtainOn() {
		return resultObtainOn;
	}
	/**
	 * @param resultObtainOn The resultObtainOn to set.
	 */
	public void setResultObtainOn(String resultObtainOn) {
		this.resultObtainOn = resultObtainOn;
	}
	/**
	 * @return Returns the sampCollectCode.
	 */
	public String getSampCollectCode() {
		return sampCollectCode;
	}
	/**
	 * @param sampCollectCode The sampCollectCode to set.
	 */
	public void setSampCollectCode(String sampCollectCode) {
		this.sampCollectCode = sampCollectCode;
	}
	/**
	 * @return Returns the sampCollectDate.
	 */
	public String getSampCollectDate() {
		return sampCollectDate;
	}
	/**
	 * @param sampCollectDate The sampCollectDate to set.
	 */
	public void setSampCollectDate(String sampCollectDate) {
		this.sampCollectDate = sampCollectDate;
	}
	/**
	 * @return Returns the sampCollectTime.
	 */
	public String getSampCollectTime() {
		return sampCollectTime;
	}
	/**
	 * @param sampCollectTime The sampCollectTime to set.
	 */
	public void setSampCollectTime(String sampCollectTime) {
		this.sampCollectTime = sampCollectTime;
	}
	/**
	 * @return Returns the siteIdenData.
	 */
	public String getSiteIdenData() {
		return siteIdenData;
	}
	/**
	 * @param siteIdenData The siteIdenData to set.
	 */
	public void setSiteIdenData(String siteIdenData) {
		this.siteIdenData = siteIdenData;
	}
	/**
	 * @return Returns the sitePlan.
	 */
	public FormFile getSitePlan() {
		return sitePlan;
	}
	/**
	 * @param sitePlan The sitePlan to set.
	 */
	public void setSitePlan(FormFile sitePlan) {
		this.sitePlan = sitePlan;
	}
	/**
	 * @return Returns the source1.
	 */
	public String getSource1() {
		return source1;
	}
	/**
	 * @param source1 The source1 to set.
	 */
	public void setSource1(String source1) {
		this.source1 = source1;
	}
	/**
	 * @return Returns the source2.
	 */
	public String getSource2() {
		return source2;
	}
	/**
	 * @param source2 The source2 to set.
	 */
	public void setSource2(String source2) {
		this.source2 = source2;
	}
	/**
	 * @return Returns the source3.
	 */
	public String getSource3() {
		return source3;
	}
	/**
	 * @param source3 The source3 to set.
	 */
	public void setSource3(String source3) {
		this.source3 = source3;
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
	 * @return Returns the ftklab.
	 */
	public String getFtklab() {
		return ftklab;
	}
	/**
	 * @param ftklab The ftklab to set.
	 */
	public void setFtklab(String ftklab) {
		this.ftklab = ftklab;
	}
	
	
	/**
	 * @return Returns the sourceName.
	 */
	public String getSourceName() {
		return sourceName;
	}
	/**
	 * @param sourceName The sourceName to set.
	 */
	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}
	/**
	 * @return Returns the subprgmCode.
	 */
	public String getSubprgmCode() {
		return subprgmCode;
	}
	/**
	 * @param subprgmCode The subprgmCode to set.
	 */
	public void setSubprgmCode(String subprgmCode) {
		this.subprgmCode = subprgmCode;
	}
	/**
	 * @return Returns the subprgmName.
	 */
	public String getSubprgmName() {
		return subprgmName;
	}
	/**
	 * @param subprgmName The subprgmName to set.
	 */
	public void setSubprgmName(String subprgmName) {
		this.subprgmName = subprgmName;
	}
	/**
	 * @return Returns the testCode.
	 */
	public String getTestCode() {
		return testCode;
	}
	/**
	 * @param testCode The testCode to set.
	 */
	public void setTestCode(String testCode) {
		this.testCode = testCode;
	}
	/**
	 * @return Returns the testId.
	 */
	public String getTestId() {
		return testId;
	}
	/**
	 * @param testId The testId to set.
	 */
	public void setTestId(String testId) {
		this.testId = testId;
	}
	/**
	 * @return Returns the testName.
	 */
	public String getTestName() {
		return testName;
	}
	/**
	 * @param testName The testName to set.
	 */
	public void setTestName(String testName) {
		this.testName = testName;
	}
	/**
	 * @return Returns the testPCode.
	 */
	public String getTestPCode() {
		return testPCode;
	}
	/**
	 * @param testPCode The testPCode to set.
	 */
	public void setTestPCode(String testPCode) {
		this.testPCode = testPCode;
	}
	/**
	 * @return Returns the testPName.
	 */
	public String getTestPName() {
		return testPName;
	}
	/**
	 * @param testPName The testPName to set.
	 */
	public void setTestPName(String testPName) {
		this.testPName = testPName;
	}
	/**
	 * @return Returns the updateSource.
	 */
	public String getUpdateSource() {
		if(updateSource==null){
			return  "";
		}
		return updateSource;
	}
	/**
	 * @param updateSource The updateSource to set.
	 */
	public void setUpdateSource(String updateSource) {
		this.updateSource = updateSource;
	}
	/**
	 * @return Returns the workCode.
	 */
	public String getWorkCode() {
		return workCode;
	}
	/**
	 * @param workCode The workCode to set.
	 */
	public void setWorkCode(String workCode) {
		this.workCode = workCode;
	}
	/**
	 * @return Returns the yield1.
	 */
	public String getYield1() {
		return yield1;
	}
	/**
	 * @param yield1 The yield1 to set.
	 */
	public void setYield1(String yield1) {
		this.yield1 = yield1;
	}
	/**
	 * @return Returns the yield2.
	 */
	public String getYield2() {
		return yield2;
	}
	/**
	 * @param yield2 The yield2 to set.
	 */
	public void setYield2(String yield2) {
		this.yield2 = yield2;
	}
	/**
	 * @return Returns the yield3.
	 */
	public String getYield3() {
		return yield3;
	}
	/**
	 * @param yield3 The yield3 to set.
	 */
	public void setYield3(String yield3) {
		this.yield3 = yield3;
	}
	/**
	 * @return Returns the code.
	 */
	public String getCode() {
		return code;
	}
	/**
	 * @param code The code to set.
	 */
	public void setCode(String code) {
		this.code = code;
	}
	/**
	 * @return Returns the name.
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name The name to set.
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return Returns the coc.
	 */
	public String getCoc() {
		return coc;
	}
	/**
	 * @param coc The coc to set.
	 */
	public void setCoc(String coc) {
		this.coc = coc;
	}
	/**
	 * @return Returns the doc.
	 */
	public String getDoc() {
		return doc;
	}
	/**
	 * @param doc The doc to set.
	 */
	public void setDoc(String doc) {
		this.doc = doc;
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
	 * @return Returns the mandalCode.
	 */
	public String getMandalCode() {
		return mandalCode;
	}
	/**
	 * @param mandalCode The mandal to set.
	 */
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
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
	 * @return Returns the villageCode.
	 */
	public String getVillageCode() {
		return panchCode;
	}
	/**
	 * @param villageCode The villageCode to set.
	 */
	public void setVillageCode(String villageCode) {
		this.villageCode = villageCode;
	}
	/**
	 * @return Returns the sdoc.
	 */
	public String getSdoc() {
		return sdoc;
	}
	/**
	 * @param sdoc The sdoc to set.
	 */
	public void setSdoc(String sdoc) {
		this.sdoc = sdoc;
	}
	/**
	 * @return Returns the codeName.
	 */
	public String getCodeName() {
		return codeName;
	}
	/**
	 * @param codeName The codeName to set.
	 */
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	/**
	 * @return Returns the empcode.
	 */
	public String getEmpcode() {
		return empcode;
	}
	/**
	 * @param empcode The empcode to set.
	 */
	public void setEmpcode(String empcode) {
		this.empcode = empcode;
	}
	/**
	 * @return Returns the empname.
	 */
	public String getEmpname() {
		return empname;
	}
	/**
	 * @param empname The empname to set.
	 */
	public void setEmpname(String empname) {
		this.empname = empname;
	}
	/**
	 * @return Returns the maxPerVal.
	 */
	public String getMaxPerVal() {
		return maxPerVal;
	}
	/**
	 * @param maxPerVal The maxPerVal to set.
	 */
	public void setMaxPerVal(String maxPerVal) {
		this.maxPerVal = maxPerVal;
	}
	/**
	 * @return Returns the minPerVal.
	 */
	public String getMinPerVal() {
		return minPerVal;
	}
	/**
	 * @param minPerVal The minPerVal to set.
	 */
	public void setMinPerVal(String minPerVal) {
		this.minPerVal = minPerVal;
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
	 * @return Returns the depth.
	 */
	public String getDepth() {
		return depth;
	}
	/**
	 * @param depth The depth to set.
	 */
	public void setDepth(String depth) {
		this.depth = depth;
	}
	/**
	 * @return Returns the prgmCode.
	 */
	public String getPrgmCode() {
		return prgmCode;
	}
	/**
	 * @param prgmCode The prgmCode to set.
	 */
	public void setPrgmCode(String prgmCode) {
		this.prgmCode = prgmCode;
	}
	/**
	 * @return Returns the yield.
	 */
	public String getYield() {
		return yield;
	}
	/**
	 * @param yield The yield to set.
	 */
	public void setYield(String yield) {
		this.yield = yield;
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
	 * @return Returns the prgmName.
	 */
	public String getPrgmName() {
		return prgmName;
	}
	/**
	 * @param prgmName The prgmName to set.
	 */
	public void setPrgmName(String prgmName) {
		this.prgmName = prgmName;
	}
	/**
	 * @return Returns the roc.
	 */
	public String getRoc() {
		return roc;
	}
	/**
	 * @param roc The roc to set.
	 */
	public void setRoc(String roc) {
		this.roc = roc;
	}
	/**
	 * @return Returns the checkedTest.
	 */
	public String getCheckedTest() {
		return checkedTest;
	}
	/**
	 * @param checkedTest The checkedTest to set.
	 */
	public void setCheckedTest(String checkedTest) {
		this.checkedTest = checkedTest;
	}
	/**
	 * @return Returns the result.
	 */
	public String getResult() {
		return result;
	}
	/**
	 * @param result The result to set.
	 */
	public void setResult(String result) {
		this.result = result;
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	
	public String getMaxPermissibleValue() {
		return maxPermissibleValue;
	}
	public void setMaxPermissibleValue(String maxPermissibleValue) {
		this.maxPermissibleValue = maxPermissibleValue;
	}
	public String getMinPermissibleValue() {
		return minPermissibleValue;
	}
	public void setMinPermissibleValue(String minPermissibleValue) {
		this.minPermissibleValue = minPermissibleValue;
	}
	public String getTestingParameterCode() {
		return testingParameterCode;
	}
	public void setTestingParameterCode(String testingParameterCode) {
		this.testingParameterCode = testingParameterCode;
	}
	public String getTestingParameterName() {
		return testingParameterName;
	}
	public void setTestingParameterName(String testingParameterName) {
		this.testingParameterName = testingParameterName;
	}
	public String getTestingParameterValue() {
		return testingParameterValue;
	}
	public void setTestingParameterValue(String testingParameterValue) {
		this.testingParameterValue = testingParameterValue;
	}
	public String getUndesirableEffect() {
		return undesirableEffect;
	}
	public void setUndesirableEffect(String undesirableEffect) {
		this.undesirableEffect = undesirableEffect;
	}
	public String getSourceCode1() {
		return sourceCode1;
	}
	public void setSourceCode1(String sourceCode1) {
		this.sourceCode1 = sourceCode1;
	}
	public String getSourceCode2() {
		return sourceCode2;
	}
	public void setSourceCode2(String sourceCode2) {
		this.sourceCode2 = sourceCode2;
	}
	public String getSourceCode3() {
		return sourceCode3;
	}
	public void setSourceCode3(String sourceCode3) {
		this.sourceCode3 = sourceCode3;
	}
	public String getOfficeCode() {
		return officeCode;
	}
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	public String getAssetTypeCode() {
		return assetTypeCode;
	}
	public void setAssetTypeCode(String assetTypeCode) {
		this.assetTypeCode = assetTypeCode;
	}
	public String getCompTypeCode() {
		return compTypeCode;
	}
	public void setCompTypeCode(String compTypeCode) {
		this.compTypeCode = compTypeCode;
	}
	public String getSubCompTypeCode() {
		return subCompTypeCode;
	}
	public void setSubCompTypeCode(String subCompTypeCode) {
		this.subCompTypeCode = subCompTypeCode;
	}
	/**
	 * @return Returns the circleOfficeName.
	 */
	public String getCircleOfficeName() {
		return circleOfficeName;
	}
	/**
	 * @param circleOfficeName The circleOfficeName to set.
	 */
	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}
	/**
	 * @return Returns the divisionOfficeName.
	 */
	public String getDivisionOfficeName() {
		return divisionOfficeName;
	}
	/**
	 * @param divisionOfficeName The divisionOfficeName to set.
	 */
	public void setDivisionOfficeName(String divisionOfficeName) {
		this.divisionOfficeName = divisionOfficeName;
	}
	/**
	 * @return Returns the subDivisionName.
	 */

	/**
	 * @return Returns the subDivisionOfficeName.
	 */
	public String getSubDivisionOfficeName() {
		return subDivisionOfficeName;
	}
	/**
	 * @param subDivisionOfficeName The subDivisionOfficeName to set.
	 */
	public void setSubDivisionOfficeName(String subDivisionOfficeName) {
		this.subDivisionOfficeName = subDivisionOfficeName;
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
}

     

