/*
 * Created on Feb 16, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.wquality;

/**
 * @author sabitha
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class WaterSampleTestResBean {
	
	private String testId;
	private String habCode;
	private String habName;
	private String sourceName;
	private String labName;
	private String testName;
	private String sourceCode;
	private String labCode;
	private String testCode;
	private String assignedOn;
	private String sampCollectCode;
	private String sampCollectDate;
	private String condemnSource;
	
	//code added
	private java.util.ArrayList testParameters;
	//end of code
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
	public java.util.ArrayList getTestParameters() {
		return testParameters;
	}
	public void setTestParameters(java.util.ArrayList testParameters) {
		this.testParameters = testParameters;
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
}
