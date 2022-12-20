/*
 * Created on 23-11-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.wquality;

import java.util.ArrayList;

/**
 * @author RWSS_DPT1
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class RwsWQLabTestingForm extends RwsWQAbstractActionForm {
	
	   ArrayList wqtestParams=new ArrayList();;
	   
	   private String testDate;
	   
	   private String potable;
	   
	   private String condemTheSource;

	   private String updateSourceData;
	   
	   private String recomended;
	   
	   private String forwardedOn;
	   
	   private String paramValue;

    public String getParamValue() {
        return paramValue;
    }

    public void setParamValue(String paramValue) {
        this.paramValue = paramValue;
    }
	   
	   
	   
	
	/**
	 * @return Returns the forwardedOn.
	 */
	public String getForwardedOn() {
		return forwardedOn;
	}
	/**
	 * @param forwardedOn The forwardedOn to set.
	 */
	public void setForwardedOn(String forwardedOn) {
		this.forwardedOn = forwardedOn;
	}
	/**
	 * @return Returns the condemTheSource.
	 */
	public String getCondemTheSource() {
		return condemTheSource;
	}
	/**
	 * @param condemTheSource The condemTheSource to set.
	 */
	public void setCondemTheSource(String condemTheSource) {
		this.condemTheSource = condemTheSource;
	}
	/**
	 * @return Returns the potable.
	 */
	public String getPotable() {
		return potable;
	}
	/**
	 * @param potable The potable to set.
	 */
	public void setPotable(String potable) {
		this.potable = potable;
	}
	/**
	 * @return Returns the recomended.
	 */
	public String getRecomended() {
		return recomended;
	}
	/**
	 * @param recomended The recomended to set.
	 */
	public void setRecomended(String recomended) {
		this.recomended = recomended;
	}
	/**
	 * @return Returns the updateSourceData.
	 */
	public String getUpdateSourceData() {
		return updateSourceData;
	}
	/**
	 * @param updateSourceData The updateSourceData to set.
	 */
	public void setUpdateSourceData(String updateSourceData) {
		this.updateSourceData = updateSourceData;
	}
	/**
	 * @return Returns the testDate.
	 */
	public String getTestDate() {
		return testDate;
	}
	/**
	 * @param testDate The testDate to set.
	 */
	public void setTestDate(String testDate) {
		this.testDate = testDate;
	}
	/**
	 * @return Returns the wqtestParams.
	 */
	public ArrayList getWqtestParams() {
		return wqtestParams;
	}
	/**
	 * @param wqtestParams The wqtestParams to set.
	 */
	public void setWqtestParams(ArrayList wqtestParams) {
		this.wqtestParams = wqtestParams;
	}
}