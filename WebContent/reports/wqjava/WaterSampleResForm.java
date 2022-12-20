package nic.watersoft.wquality;

import java.util.ArrayList;
import nic.watersoft.commons.Debug;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;

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
public class WaterSampleResForm extends ActionForm
{
	
	 private String recommendations;
	 private String condemnSource;
	 private String updateSource;
	 private String forwadedOn;
	 private String preparedBy;
	 private String preparedOn;
	 private Collection wqtestParams;
	 private Collection wqLabTests;
	 private Collection wqLabTestResults;
	 private String mode;
	 private String circleOfficeCode;
	 private String divisionOfficeCode;
	
	 
	 
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
	 public WaterSampleResForm()
	 {
		wqtestParams = new ArrayList();
		wqLabTests = new ArrayList();
		wqLabTestResults = new ArrayList();
	 }
	 /**
	 * @return Returns the wqLabTests.
	 */
	 public Collection getWqLabTests()
	 {
	 	//System.out.println("##### Entered to getWqLabTests() #####");
	 	return wqLabTests;
	 }
	 /**
	 * @param wqLabTests The wqLabTests to set.
	 */
	 public void setWqLabTests(Collection wqLabTests)
	 {
	 	//System.out.println("##### Entered to setWqLabTests() #####");
		this.wqLabTests = wqLabTests;
	 }
	 /**
	 * @return Returns the WaterSampleTestResLnk Class.
	 */
	 public WaterSampleTestResBean getLABTEST_LIST(int index)
	 {
		 //System.out.println("index in getLABTEST_LIST()= "+index);
		while(index >= wqLabTests.size())
		{
			wqLabTests.add(new WaterSampleTestResBean());
		}
		return (WaterSampleTestResBean)((ArrayList) wqLabTests).get(index);
	 }
	 
	 public WaterSampleTestResBean getLABTESTRESULTS_LIST(int index)
	 {
		// System.out.println("index in getLABTESTDETAILS_LIST()= "+index);
		while(index >= wqLabTestResults.size())
		{
			wqLabTestResults.add(new WaterSampleTestResBean());
		}
		return (WaterSampleTestResBean)((ArrayList) wqLabTestResults).get(index);
	 }
	 /**
	 * @return Returns the wqtestParams.
	 */
	 public Collection getWqtestParams() 
	 {
		//System.out.println("##### Entered to getWqtestParams() #####");
		return wqtestParams;		
	 }
	 /**
	 * @param wqtestParams The wqtestParams to set.
	 */
	 public void setWqtestParams(Collection wqtestParams) 
	 {
		this.wqtestParams = wqtestParams;
		//System.out.println("##### Entered to setWqtestParams() #####");
	 }
	 /**
	 * @return Returns the WaterSampleTestResLnk Class.
	 */
	 public WaterSampleTestResLnk getTESTPARAM_LIST(int index)
	 {
		// System.out.println("index in getTESTPARAM_LIST()= "+index);
		while(index >= wqtestParams.size())
		{
			wqtestParams.add(new WaterSampleTestResLnk());
		}
		return (WaterSampleTestResLnk)((ArrayList) wqtestParams).get(index);
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
	 * @return Returns the updateSource.
	 */
	public String getUpdateSource() {
		return updateSource;
	}
	/**
	 * @param updateSource The updateSource to set.
	 */
	public void setUpdateSource(String updateSource) {
		this.updateSource = updateSource;
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
	public void reset(ActionMapping mapping,HttpServletRequest request) 
	{
		this.recommendations="";   
		this.condemnSource="";
		this.updateSource="";
		this.forwadedOn="";
		wqtestParams.clear();
		wqLabTests.clear();
		wqLabTestResults.clear();
	}
	
	public Collection getWqLabTestResults() {
		return wqLabTestResults;
	}
	public void setWqLabTestResults(Collection wqLabTestResults) {
		this.wqLabTestResults = wqLabTestResults;
	}
	
	
}

