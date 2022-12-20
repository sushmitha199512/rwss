package nic.watersoft.masters;
import java.io.Serializable;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class EEBean  implements Serializable
{
	private String circleOffice="";
	private String divisionOffice="";
	private String paoCode="";
	private String eeName="";
	private String dateofPresent="";
	private String dateofReleaving="";
	private String mode="";
	private String circleName="";
	private String divisionName="";

	/**
	 * @return Returns the circleOffice.
	 */
	public String getCircleOffice() {
		return circleOffice;
	}
	/**
	 * @param circleOffice The circleOffice to set.
	 */
	public void setCircleOffice(String circleOffice) {
		this.circleOffice = circleOffice;
	}
	/**
	 * @return Returns the dateofPresent.
	 */
	public String getDateofPresent() {
		return dateofPresent;
	}
	/**
	 * @param dateofPresent The dateofPresent to set.
	 */
	public void setDateofPresent(String dateofPresent) {
		this.dateofPresent = dateofPresent;
	}
	/**
	 * @return Returns the dateofReleaving.
	 */
	public String getDateofReleaving() {
		return dateofReleaving;
	}
	/**
	 * @param dateofReleaving The dateofReleaving to set.
	 */
	public void setDateofReleaving(String dateofReleaving) {
		this.dateofReleaving = dateofReleaving;
	}
	/**
	 * @return Returns the divisionOffice.
	 */
	public String getDivisionOffice() {
		return divisionOffice;
	}
	/**
	 * @param divisionOffice The divisionOffice to set.
	 */
	public void setDivisionOffice(String divisionOffice) {
		this.divisionOffice = divisionOffice;
	}
	/**
	 * @return Returns the eeName.
	 */
	public String getEeName() {
		return eeName;
	}
	/**
	 * @param eeName The eeName to set.
	 */
	public void setEeName(String eeName) {
		this.eeName = eeName;
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
	/**
	 * @return Returns the paoCode.
	 */
	public String getPaoCode() {
		return paoCode;
	}
	/**
	 * @param paoCode The paoCode to set.
	 */
	public void setPaoCode(String paoCode) {
		this.paoCode = paoCode;
	}
	/**
	 * @return Returns the circleName.
	 */
	public String getCircleName() {
		return circleName;
	}
	/**
	 * @param circleName The circleName to set.
	 */
	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}
	/**
	 * @return Returns the divisionName.
	 */
	public String getDivisionName() {
		return divisionName;
	}
	/**
	 * @param divisionName The divisionName to set.
	 */
	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}
}