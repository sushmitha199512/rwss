package nic.watersoft.BaseLineSurvey;

import java.io.Serializable;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public abstract class BaseLineAbstractActionForm extends ActionForm implements
		Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	String district;
	String mandal;
	String panchayat;
	String village;
	String habCode;
	String surveyDate;
	String mode;

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getMandal() {
		return mandal;
	}

	public void setMandal(String mandal) {
		this.mandal = mandal;
	}

	public String getPanchayat() {
		return panchayat;
	}

	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}

	public String getVillage() {
		return village;
	}

	public void setVillage(String village) {
		this.village = village;
	}

	public String getHabCode() {
		return habCode;
	}

	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}

	public String getSurveyDate() {
		return surveyDate;
	}

	public void setSurveyDate(String surveyDate) {
		this.surveyDate = surveyDate;
	}

}
