package nic.watersoft.wquality;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/*
 * Created on Nov 10, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class WaterSampleForm extends ActionForm
{
	 private String testId;
	 private String circleOfficeCode;
	 private String divisionOfficeCode;
	 private String subdivisionOfficeCode;
	 private String panchayatCode;
	 private String villageCode;
	 private String mandalCode;
	 private String habCode;
	 private String sourceCode;
	 private String sourceType;
	 private String testCode;
	 private String natureOfTest;
	 private String labCode;
	 private String sampCollectCode;
	 private String sampCollectDate;
	 private String sampCollectTime;
	 private String assignedTo;
	 private String assignedOn;
	 private String preparedBy;
	 private String preparedOn;
	 private String mode;
	 private String location;
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
	 * @return Returns the circleOfficeCode.
	 */
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	/**
	 * @param circleOfficeCode The circleOfficeCode to set.
	 */
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	/**
	 * @return Returns the divisionOfficeCode.
	 */
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	/**
	 * @param divisionOfficeCode The divisionOfficeCode to set.
	 */
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
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
	 * @return Returns the subdivisionOfficeCode.
	 */
	public String getSubdivisionOfficeCode() {
		return subdivisionOfficeCode;
	}
	/**
	 * @param subdivisionOfficeCode The subdivisionOfficeCode to set.
	 */
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
		this.subdivisionOfficeCode = subdivisionOfficeCode;
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
	 * @param mode The mode to set.
	 */
	public void setMode(String mode)
	{
		this.mode=mode;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode()
	{
		return mode;
	}

	/**
	 * @param mode The panchayatCode to set.
	 */
	public void setPanchayatCode(String panchayatCode)
	{
		this.panchayatCode=panchayatCode;
	}
	/**
	 * @return Returns the panchayatCode.
	 */
	public String getPanchayatCode()
	{
		return panchayatCode;
	}
	/**
	 * @param mode The villageCode to set.
	 */
	public void setVillageCode(String villageCode)
	{
		this.villageCode=villageCode;
	}
	/**
	 * @return Returns the villageCode.
	 */
	public String getVillageCode()
	{
		return villageCode;
	}
	/**
	 * @param mode The mandalCode to set.
	 */
	public void setMandalCode(String mandalCode)
	{
		this.mandalCode=mandalCode;
	}
	/**
	 * @return Returns the mandalCode.
	 */
	public String getMandalCode()
	{
		return mandalCode;
	}
	/**
	 * @param reset Clear all the Params.
	 */
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		System.out.println("in reset method");
		HttpSession session=request.getSession();
		this.habCode="";
		this.subdivisionOfficeCode="";
		this.mandalCode="";
		this.villageCode="";
		this.panchayatCode="";
		this.sourceCode="";     
		this.testCode="";       
		this.natureOfTest="";   
		this.labCode="";        
		this.sampCollectCode="";
		this.sampCollectDate="";
		this.sampCollectTime="";
		this.assignedTo="";     
		this.assignedOn="";   
		this.sourceType="";
		this.location="";
		ArrayList m=(ArrayList)session.getAttribute("mandals");
		ArrayList p=(ArrayList)session.getAttribute("panchyats");
		ArrayList v=(ArrayList)session.getAttribute("villages");
		ArrayList ph=(ArrayList)session.getAttribute("prhabs");
		if(session.getAttribute("prhabs") != null)
		{
			m.clear();
			p.clear();
			v.clear();
			ph.clear();
		}

	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
}
