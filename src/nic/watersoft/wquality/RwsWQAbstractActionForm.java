/*
 * Created on 23-11-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.wquality;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * @author RWSS_DPT1
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsWQAbstractActionForm extends ActionForm{

	
	private String ttype;
	
	/**
	 * @return Returns the ttype.
	 */
	public String getTtype() {
		return ttype;
	}
	/**
	 * @param ttype The ttype to set.
	 */
	public void setTtype(String ttype) {
		this.ttype = ttype;
	}
	private String circleOfficeName;

	private String divisionOfficeName;

	private String subDivisionOfficeName;

	private String mandalName;

	private String panchayatName;

	private String habName;

	private String testId;

	 String circleOfficeCode;

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

	private String ftklab;

	private String ftkTestDate;

	private String forwardDate;

	private String ftktestid;

	private String sampCollectCode;

	private String sampCollectDate;

	private String sampCollectTime;

	private String assignedTo;

	private String assignedOn;

	private String preparedBy;

	private String preparedOn;

	private String mode;

	private String location;

	private String forwardtolab;

	private String contamin;

	private String habname;
	private String recommendations;

	/**
	 * @return Returns the habname.
	 */
	public String getHabname() {
		return habname;
	}

	/**
	 * @param habname
	 *            The habname to set.
	 */
	public void setHabname(String habname) {
		this.habname = habname;
	}

	/**
	 * @return Returns the contamin
	 */
	public String getContamin() {
		return contamin;
	}

	/**
	 * @param contamin
	 *            The contamin to set.
	 */
	public void setContamin(String contamin) {
		this.contamin = contamin;
	}

	/**
	 * @return Returns the ftktestid
	 */
	public String getFtktestid() {
		return ftktestid;
	}

	/**
	 * @param ftktestid
	 *            The ftktestid to set.
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
	 * @param forwardDate
	 *            The forwardDate to set.
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
	 * @param forwardDate
	 *            The forwardDate to set.
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
	 * @param ftkTestDate
	 *            The ftkTestDate to set.
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
	 * @param assignedOn
	 *            The assignedOn to set.
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
	 * @param assignedTo
	 *            The assignedTo to set.
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
	 * @param circleOfficeCode
	 *            The circleOfficeCode to set.
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
	 * @param divisionOfficeCode
	 *            The divisionOfficeCode to set.
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
	 * @param habCode
	 *            The habCode to set.
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
	 * @param labCode
	 *            The labCode to set.
	 */
	public void setLabCode(String labCode) {
		this.labCode = labCode;
	}

	/**
	 * @return Returns the ftklab.
	 */
	public String getFtklab() {
		return ftklab;
	}

	/**
	 * @param ftklab
	 *            The ftklab to set.
	 */
	public void setFtklab(String ftklab) {
		this.ftklab = ftklab;
	}

	/**
	 * @return Returns the natureOfTest.
	 */
	public String getNatureOfTest() {
		return natureOfTest;
	}

	/**
	 * @param natureOfTest
	 *            The natureOfTest to set.
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
	 * @param preparedBy
	 *            The preparedBy to set.
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
	 * @param preparedOn
	 *            The preparedOn to set.
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
	 * @param sampCollectCode
	 *            The sampCollectCode to set.
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
	 * @param sampCollectDate
	 *            The sampCollectDate to set.
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
	 * @param sampCollectTime
	 *            The sampCollectTime to set.
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
	 * @param subdivisionOfficeCode
	 *            The subdivisionOfficeCode to set.
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
	 * @param sourceCode
	 *            The sourceCode to set.
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
	 * @param testCode
	 *            The testCode to set.
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
	 * @param testId
	 *            The testId to set.
	 */
	public void setTestId(String testId) {
		this.testId = testId;
	}

	/**
	 * @param mode
	 *            The mode to set.
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}

	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}

	/**
	 * @param mode
	 *            The panchayatCode to set.
	 */
	public void setPanchayatCode(String panchayatCode) {
		this.panchayatCode = panchayatCode;
	}

	/**
	 * @return Returns the panchayatCode.
	 */
	public String getPanchayatCode() {
		return panchayatCode;
	}

	/**
	 * @param mode
	 *            The villageCode to set.
	 */
	public void setVillageCode(String villageCode) {
		this.villageCode = villageCode;
	}

	/**
	 * @return Returns the villageCode.
	 */
	public String getVillageCode() {
		return villageCode;
	}

	/**
	 * @param mode
	 *            The mandalCode to set.
	 */
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
		//System.out.println("mandal code in bean"+mandalCode);
	}

	/**
	 * @return Returns the mandalCode.
	 */
	public String getMandalCode() {
		//System.out.println("mandal code in bean"+mandalCode);
		return mandalCode;

	}

	/**
	 * @param reset
	 *            Clear all the Params.
	 */
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		//System.out.println("in reset method");
		try {
			HttpSession session = request.getSession();
			this.habCode = "";
			this.subdivisionOfficeCode = "";
			this.mandalCode = "";
			this.villageCode = "";
			this.panchayatCode = "";
			this.sourceCode = "";
			this.testCode = "";
			this.natureOfTest = "";
			this.labCode = "";
			this.sampCollectCode = "";
			this.sampCollectDate = "";
			this.sampCollectTime = "";
			this.assignedTo = "";
			this.assignedOn = "";
			this.sourceType = "";
			this.location = "";
			this.ftklab = "";
			/*
			 * ArrayList m=(ArrayList)session.getAttribute("mandals"); ArrayList
			 * p=(ArrayList)session.getAttribute("panchyats"); ArrayList
			 * v=(ArrayList)session.getAttribute("villages"); ArrayList
			 * ph=(ArrayList)session.getAttribute("prhabs");
			 * if(session.getAttribute("prhabs") != null) {
			 * 
			 * //m.clear(); if(p!=null)p.clear(); if(v!=null)v.clear();
			 * if(ph!=null)ph.clear(); }
			 */
		} catch (Exception e) {
			nic.watersoft.commons.Debug.println(e.getMessage());
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

	public String getCircleOfficeName() {
		return circleOfficeName;
	}

	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}

	public String getDivisionOfficeName() {
		return divisionOfficeName;
	}

	public void setDivisionOfficeName(String divisionOfficeName) {
		this.divisionOfficeName = divisionOfficeName;
	}

	public String getHabName() {
		return habName;
	}

	public void setHabName(String habName) {
		this.habName = habName;
	}

	public String getMandalName() {
		return mandalName;
	}

	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}

	public String getPanchayatName() {
		return panchayatName;
	}

	public void setPanchayatName(String panchayatName) {
		this.panchayatName = panchayatName;
	}

	public String getSubDivisionOfficeName() {
		return subDivisionOfficeName;
	}

	public void setSubDivisionOfficeName(String subDivisionOfficeName) {
		this.subDivisionOfficeName = subDivisionOfficeName;
	}
	public String getRecommendations() {
		return recommendations;
	}
	public void setRecommendations(String recommendations) {
		this.recommendations = recommendations;
	}
}
