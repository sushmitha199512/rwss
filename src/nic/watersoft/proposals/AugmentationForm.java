/*
 * Created on Jan 16, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.proposals;

import org.apache.struts.action.ActionForm;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class AugmentationForm extends ActionForm {
	
	private String assetType;
	private String year;
	private String workId;
	private String mode;
	

	/**
	 * @return Returns the assetType.
	 */
	public String getAssetType() {
		return assetType;
	}
	/**
	 * @param assetType The assetType to set.
	 */
	public void setAssetType(String assetType) {
		this.assetType = assetType;
	}
	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}
	/**
	 * @param workId The workId to set.
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	/**
	 * @return Returns the year.
	 */
	public String getYear() {
		return year;
	}
	/**
	 * @param year The year to set.
	 */
	public void setYear(String year) {
		this.year = year;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}
}
