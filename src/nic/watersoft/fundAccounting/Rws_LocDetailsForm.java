/*
 * Created on Aug 10, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_LocDetailsForm extends ActionForm{
	
	String locId;
	String circleLocId;
	String broId;
	String broAmount;
	String broAmountAlreadyAllocatedForLOCs;
	String remainingAmountToBeAllocated;
	String locReference;
	String locRelDate;
	String locAmount;
	String dwaAuthorisationReference;
	String dwaAuthorisationDate;
	private String broReference;
	String broRemainingAmountToBeAllocated;
	String project;
	ArrayList locDetailsList;
	String addWorkId;
	private String district;
	private String division;
	private String workCategory;
	private String program;
	String year;
	ArrayList works;
	String brodate;
	
	
	
	/**
	 * @return Returns the brodate.
	 */
	public String getBrodate() {
		return brodate;
	}
	/**
	 * @param brodate The brodate to set.
	 */
	public void setBrodate(String brodate) {
		this.brodate = brodate;
	}
	public ArrayList getWorks() {
		return works;
	}
	public void setWorks(ArrayList works) {
		this.works = works;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getAddWorkId() {
		return addWorkId;
	}
	public void setAddWorkId(String addWorkId) {
		this.addWorkId = addWorkId;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public Rws_LocDetailsForm()
	{
		locDetailsList=new ArrayList();
		
	}
	
	public Rws_LocProgDetailsBean getLOC_DETAILS_LIST(int index)
	{
		while(index >= locDetailsList.size())
		{
			locDetailsList.add(new Rws_LocProgDetailsBean());
		}
		return (Rws_LocProgDetailsBean)((ArrayList) locDetailsList).get(index);
	}

	
	public ArrayList getLocDetailsList() {
		return locDetailsList;
	}
	public void setLocDetailsList(ArrayList locDetailsList) {
		this.locDetailsList = locDetailsList;
	}
	public String getBroReference() {
		return broReference;
	}
	public void setBroReference(String broReference) {
		this.broReference = broReference;
	}
	public String getLocAmount() {
		return locAmount;
	}
	public void setLocAmount(String locAmount) {
		this.locAmount = locAmount;
	}
	public String getLocId() {
		return locId;
	}
	public void setLocId(String locId) {
		this.locId = locId;
	}
	public String getLocReference() {
		return locReference;
	}
	public void setLocReference(String locReference) {
		this.locReference = locReference;
	}
	public String getLocRelDate() {
		return locRelDate;
	}
	public void setLocRelDate(String locRelDate) {
		this.locRelDate = locRelDate;
	}
	
	public String getDwaAuthorisationDate() {
		return dwaAuthorisationDate;
	}
	public void setDwaAuthorisationDate(String dwaAuthorisationDate) {
		this.dwaAuthorisationDate = dwaAuthorisationDate;
	}
	public String getDwaAuthorisationReference() {
		return dwaAuthorisationReference;
	}
	public void setDwaAuthorisationReference(String dwaAuthorisationReference) {
		this.dwaAuthorisationReference = dwaAuthorisationReference;
	}
	public String getBroAmount() {
		return broAmount;
	}
	public void setBroAmount(String broAmount) {
		this.broAmount = broAmount;
	}
	public String getBroId() {
		return broId;
	}
	public void setBroId(String broId) {
		this.broId = broId;
	}
	public String getBroAmountAlreadyAllocatedForLOCs() {
		return broAmountAlreadyAllocatedForLOCs;
	}
	public void setBroAmountAlreadyAllocatedForLOCs(
			String broAmountAlreadyAllocatedForLOCs) {
		this.broAmountAlreadyAllocatedForLOCs = broAmountAlreadyAllocatedForLOCs;
	}
	public String getRemainingAmountToBeAllocated() {
		return remainingAmountToBeAllocated;
	}
	public void setRemainingAmountToBeAllocated(
			String remainingAmountToBeAllocated) {
		this.remainingAmountToBeAllocated = remainingAmountToBeAllocated;
	}
	public String getBroRemainingAmountToBeAllocated() {
		return broRemainingAmountToBeAllocated;
	}
	public void setBroRemainingAmountToBeAllocated(
			String broRemainingAmountToBeAllocated) {
		this.broRemainingAmountToBeAllocated = broRemainingAmountToBeAllocated;
	}
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	public String getCircleLocId() {
		return circleLocId;
	}
	public void setCircleLocId(String circleLocId) {
		this.circleLocId = circleLocId;
	}
	/**
	 * @return Returns the division.
	 */
	public String getDivision() {
		return division;
	}
	/**
	 * @param division The division to set.
	 */
	public void setDivision(String division) {
		this.division = division;
	}
	
	public String getProgram() {
		return program;
	}
	public void setProgram(String program) {
		this.program = program;
	}
	public String getWorkCategory() {
		return workCategory;
	}
	public void setWorkCategory(String workCategory) {
		this.workCategory = workCategory;
	}
}
