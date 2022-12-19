/*
 * Created on Mar 30, 2009
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */package nic.watersoft.wquality;

 import java.util.ArrayList;
 import java.util.Collection;

 import javax.servlet.http.HttpServletRequest;

 import org.apache.struts.action.ActionForm;
 import org.apache.struts.action.ActionMapping;

 import nic.watersoft.commons.Debug;


 
 public class WaterSampleFtkTestForm extends ActionForm
 {
 	 private String headOfficeCode;
 	/**
 	 * @return Returns the headOfficeCode.
 	 */
 	public String getHeadOfficeCode() {
 		return headOfficeCode;
 	}
 	/**
 	 * @param headOfficeCode The headOfficeCode to set.
 	 */
 	public void setHeadOfficeCode(String headOfficeCode) {
 		this.headOfficeCode = headOfficeCode;
 	}
 	 private String circleOfficeCode;
 	 private String divisionOfficeCode;
 	 private String subdivisionOfficeCode;
 	 private String testId;
 	 private String prepared_by;
 	 private String prepared_on;
 	 private Collection samplesForwardToLabs;
 	 private Collection resultsSubmittedToSubdivision;
 	 private ArrayList testResults;
 	 private String mode;
 	 private String sourceType;
 	 private String selectedMonth;
 	 private String selectedYear;
 	 private String circleOfficeCode1;
 	 private String divisionOfficeCode1;
 	 private String mandalCode;
 	private String ftktestid; 
	 private String mandalName;
	 private String ftkTestDate;
	 private String forwardDate;
	 private String mandalCode1;
	 private String mandalName1;
	 
 	 
 	
 	 public WaterSampleFtkTestForm()
 	 {
 	 	//Debug.println("in WaterSampleFtkTestForm()");
 		samplesForwardToLabs = new ArrayList();
 		testResults=new ArrayList();
 		resultsSubmittedToSubdivision = new ArrayList();
 	 }
 	/**
   	 * @return Returns the mandalCode1.
   	 */
   	public String getMandalCode1() {
   		return mandalCode1;
   	}
   	/**
   	 * @param mandalCode1 The mandalCode1 to set.
   	 */
   	public void setMandalCode1(String mandalCode1) {
   		this.mandalCode1 = mandalCode1;
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
	 * @return Returns the mandalName1.
	 */
	public String getMandalName1() {
		return mandalName1;
	}
	/**
	 * @param mandalName The mandalName to set.
	 */
	public void setMandalName1(String mandalName1) {
		this.mandalName1 = mandalName1;
	}
 	/**
 	 * @return Returns the resultsSubmittedToSubdivision.
 	 */
 	public Collection getResultsSubmittedToSubdivision() 
 	{
 		return resultsSubmittedToSubdivision;
 	}
 	/**
 	 * @param resultsSubmittedToSubdivision The resultsSubmittedToSubdivision to set.
 	 */
 	public void setResultsSubmittedToSubdivision(
 			Collection resultsSubmittedToSubdivision)
 	{
 		//System.out.println("##### Entered to setResultsSubmittedToSubdivision() #####");
 		this.resultsSubmittedToSubdivision = resultsSubmittedToSubdivision;
 	}
 	public SampleForwardGeoTests getTESTRESULT_LIST(int index)
 	 {
 		//System.out.println("##### Entered to getTESTRESULT_LIST() index= "+index);
 		while(index >= resultsSubmittedToSubdivision.size())
 		{
 			resultsSubmittedToSubdivision.add(new SampleForwardGeoTests());
 		}
 		return (SampleForwardGeoTests)((ArrayList) resultsSubmittedToSubdivision).get(index);
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
 	 * @return Returns the samplesForwardToLabs.
 	 */
 	 public Collection getSamplesForwardToLabs() 
 	 {
 		//System.out.println("##### Entered to getSamplesForwardToLabs() #####");
 		return samplesForwardToLabs;		
 	 }
 	 /**
 	 * @param samplesForwardToLabs The samplesForwardToLabs to set.
 	 */
 	 public void setSamplesForwardToLabs(Collection samplesForwardToLabs) 
 	 {
 		this.samplesForwardToLabs = samplesForwardToLabs;
 		//System.out.println("##### Entered to setSamplesForwardToLabs() #####");
 	 }
 	  /**
 	 * @return Returns the WaterSampleForwardedTests Class.
 	 */
 	 public SampleForwardGeoTests getWATERSAMPLE_LIST(int index)
 	 {
 	 	//System.out.println("##### Entered to getWATERSAMPLE_LIST() index= "+index);
 		while(index >= samplesForwardToLabs.size())
 		{
 			samplesForwardToLabs.add(new SampleForwardGeoTests());
 		}
 		return (SampleForwardGeoTests)((ArrayList) samplesForwardToLabs).get(index);
 	 }
 	 
 	 public RwsWQuality getTESTRESULTS_LIST(int index)
 	 {
 	 	//System.out.println("##### Entered to getTESTRESULTS_LIST() index= "+index);
 		while(index >= testResults.size())
 		{
 			testResults.add(new RwsWQuality());
 		}
 		return (RwsWQuality)((ArrayList) testResults).get(index);
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
 	 * @return Returns the prepared_by.
 	 */
 	public String getPrepared_by() {
 		return prepared_by;
 	}
 	/**
 	 * @param prepared_by The prepared_by to set.
 	 */
 	public void setPrepared_by(String prepared_by) {
 		this.prepared_by = prepared_by;
 	}
 	/**
 	 * @return Returns the prepared_on.
 	 */
 	public String getPrepared_on() {
 		return prepared_on;
 	}
 	/**
 	 * @param prepared_on The prepared_on to set.
 	 */
 	public void setPrepared_on(String prepared_on) {
 		this.prepared_on = prepared_on;
 	}
 	public void reset(ActionMapping mapping,HttpServletRequest request) 
 	{		
 		testResults.clear();
 		samplesForwardToLabs.clear();
 		resultsSubmittedToSubdivision.clear();
 	}
 	public Collection getTestResults() {
 		//System.out.println("in getTestResults()");
 		return testResults;
 	}
 	public void setTestResults(ArrayList testResults) {
 		//System.out.println("in setTestResults()");
 		this.testResults = testResults;
 	}
 	public String getSourceType() {
 		return sourceType;
 	}
 	public void setSourceType(String sourceType) {
 		this.sourceType = sourceType;
 	}
 	
 	/**
 	 * @return Returns the selectedMonth.
 	 */
 	public String getSelectedMonth() {
 		return selectedMonth;
 	}
 	/**
 	 * @param selectedMonth The selectedMonth to set.
 	 */
 	public void setSelectedMonth(String selectedMonth) {
 		this.selectedMonth = selectedMonth;
 	}
 	/**
 	 * @return Returns the selectedYear.
 	 */
 	public String getSelectedYear() {
 		return selectedYear;
 	}
 	/**
 	 * @param selectedYear The selectedYear to set.
 	 */
 	public void setSelectedYear(String selectedYear) {
 		this.selectedYear = selectedYear;
 	}
 	/**
 	 * @return Returns the circleOfficeCode1.
 	 */
 	public String getCircleOfficeCode1() {
 		return circleOfficeCode1;
 	}
 	/**
 	 * @param circleOfficeCode1 The circleOfficeCode1 to set.
 	 */
 	public void setCircleOfficeCode1(String circleOfficeCode1) {
 		this.circleOfficeCode1 = circleOfficeCode1;
 	}
 	/**
 	 * @return Returns the divisionOfficeCode1.
 	 */
 	public String getDivisionOfficeCode1() {
 		return divisionOfficeCode1;
 	}
 	/**
 	 * @param divisionOfficeCode1 The divisionOfficeCode1 to set.
 	 */
 	public void setDivisionOfficeCode1(String divisionOfficeCode1) {
 		this.divisionOfficeCode1 = divisionOfficeCode1;
 	}
 }
