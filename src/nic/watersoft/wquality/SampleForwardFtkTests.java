package nic.watersoft.wquality;

import java.io.Serializable;

public class SampleForwardFtkTests implements Serializable
{
	
	 private String testId;
	 private String habCode;
	 private String sourceCode;
	 private String testCode;
	 private String sampCollectCode;
	 private String sampCollectDate;
	 private String checkedTest;
	 private String forwadedOn;
	 private String forwadedTo;
	 private String dateAssignedFromDiv;
	 private String subdivision;
	 private String resultObtainOn;
	 private String resultForwardOn;
	 private String sourceType;
	 private String updateSource;
	 private String recommendations;
	 private String divisionOfficeName;
	 private String labName;
	 private String ftktestid; 
	 private String mandalName;
	 private String ftkTestDate;
	 private String forwardDate;
	 private String natureOfTest;
	 	 	
	public SampleForwardFtkTests()
	{
	}
	
	public SampleForwardFtkTests(String checkedTest,String testId,String dateAssignedFromDiv,String sampCollectDate,String habCode,String sourceCode,String testCode,String sampCollectCode,String forwadedOn,String division,String labname,String labnames)
	{
		this.testId = testId;
		this.checkedTest = checkedTest;
		this.habCode = habCode;
		this.sourceCode = sourceCode;
		this.testCode = testCode;
		this.sampCollectCode = sampCollectCode;
		this.sampCollectDate = sampCollectDate;
		this.dateAssignedFromDiv=dateAssignedFromDiv;
		this.forwadedOn = forwadedOn;
		this.divisionOfficeName = division;
		this.labName = labname;
	}
	/*public SampleForwardGeoTests(String checkedTest,String testId,String dateAssignedFromDiv,String sampCollectDate,String habCode,String sourceCode,String testCode,String sampCollectCode,String forwadedOn,String sourceType)
	{
		this.testId = testId;
		this.checkedTest = checkedTest;
		this.habCode = habCode;
		this.sourceCode = sourceCode;
		this.testCode = testCode;
		this.sampCollectCode = sampCollectCode;
		this.sampCollectDate = sampCollectDate;
		this.dateAssignedFromDiv=dateAssignedFromDiv;
		this.forwadedOn = forwadedOn;
		this.sourceType=sourceType;
	}*/
	
	public SampleForwardFtkTests(String checkedTest,String testId,String dateAssignedFromDiv,String habCode,String sourceCode,String testCode,String forwadedOn,String forwadedTo,String resultObtainOn,String resultForwardOn,String sourceType)
	{
		this.testId = testId;
		this.checkedTest = checkedTest;
		this.dateAssignedFromDiv=dateAssignedFromDiv;
		this.habCode = habCode;
		this.sourceCode = sourceCode;
		this.testCode = testCode;
		this.forwadedOn = forwadedOn;
		this.forwadedTo = forwadedTo;
		this.resultObtainOn = resultObtainOn;
		this.resultForwardOn = resultForwardOn;
		this.sourceType=sourceType;
	}
	public SampleForwardFtkTests(String checkedTest,String testId,String dateAssignedFromDiv,String habCode,String sourceCode,String testCode,String forwadedOn,String forwadedTo,String resultObtainOn,String resultForwardOn,String sourceType,String updateSource,String recommendations)
	{
		this.testId = testId;
		this.checkedTest = checkedTest;
		this.dateAssignedFromDiv=dateAssignedFromDiv;
		this.habCode = habCode;
		this.sourceCode = sourceCode;
		this.testCode = testCode;
		this.forwadedOn = forwadedOn;
		this.forwadedTo = forwadedTo;
		this.resultObtainOn = resultObtainOn;
		this.resultForwardOn = resultForwardOn;
		this.sourceType=sourceType;
		this.updateSource = updateSource;
		this.recommendations=recommendations;
	}	
	public SampleForwardFtkTests(String checkedTest,String testId,String divisionOfficeName,String labName,String sampCollectDate,String habCode,String sourceType,String sourceCode,String testCode,String samplCollectCode)
	{
		this.checkedTest = checkedTest;
		this.testId = testId;
		this.divisionOfficeName = divisionOfficeName;
		this.labName = labName;
		this.sampCollectDate = sampCollectDate;
		this.habCode = habCode;
		this.sourceType = sourceType;
		this.sourceCode = sourceCode;
		this.testCode = testCode;
		this.sampCollectCode = samplCollectCode;
	}
	public SampleForwardFtkTests(String ftktestid,String divisionOfficeName,String labName,String sampCollectDate,String habCode,String sourceType,String sourceCode,String testCode,String samplCollectCode)
	{
		this.ftktestid = ftktestid;
		this.divisionOfficeName = divisionOfficeName;
		this.labName = labName;
		this.sampCollectDate = sampCollectDate;
		this.habCode = habCode;
		this.sourceType = sourceType;
		this.sourceCode = sourceCode;
		this.testCode = testCode;
		this.sampCollectCode = samplCollectCode;
	}
	public SampleForwardFtkTests(String checkedTest,String ftktestid,String mandalName,String habCode,String sourceType,String sourceCode,String ftkTestDate,String forwardDate,String natureOfTest,String a,String b,String c,String d,String e)
	{
		this.checkedTest = checkedTest;
		this.ftktestid=ftktestid;
		this.mandalName = mandalName;
		this.habCode = habCode;
		this.sourceType = sourceType;
		this.sourceCode = sourceCode;
		this.ftkTestDate = ftkTestDate;
		this.forwardDate = forwardDate;
		this.natureOfTest = natureOfTest;
		
	}

	/**
	 * @return Returns the subdivision.
	 */
	public String getSubdivision() {
		return subdivision;
	}
	/**
	 * @param subdivision The subdivision to set.
	 */
	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
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
	 * @return Returns the ftktestId.
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
	 * @return Returns the forwarddate.
	 */
	public String getForwardDate() {
		return forwardDate;
	}
	/**
	 * @param forwarddate The forwarddate to set.
	 */
	public void setForwardDate(String forwardDate) {
		this.forwardDate = forwardDate;
	}
	/**
	 * @return Returns the ftktestdate.
	 */
	public String getFtkTestDate() {
		return ftkTestDate;
	}
	/**
	 * @param ftktestdate The ftktestdate to set.
	 */
	public void setFtkTestDate(String ftkTestDate) {
		this.ftkTestDate = ftkTestDate;
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
	 * @return Returns the forwadedOn.
	 */
	public String getForwadedOn() {
		return forwadedOn;
	}
	/**
	 * @param forwardedOn The forwadedOn to set.
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
	 * @param forwardedTo The forwadedTo to set.
	 */
	public void setForwadedTo(String forwadedTo) {
		this.forwadedTo = forwadedTo;
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
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getRecommendations() {
		return recommendations;
	}
	public void setRecommendations(String recommendations) {
		this.recommendations = recommendations;
	}
	public String getUpdateSource() {
		return updateSource;
	}
	public void setUpdateSource(String updateSource) {
		this.updateSource = updateSource;
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
}
