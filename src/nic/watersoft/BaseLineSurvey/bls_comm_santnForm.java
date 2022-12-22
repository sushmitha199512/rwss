package nic.watersoft.BaseLineSurvey;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class bls_comm_santnForm extends ActionForm implements Serializable {
	private String district;
	private String mandal;
	private String panchayat;
	private String village;
	private String habCode;
	private String totalCscConstructed;
	private String totalFunctionalCsc;
	private String totalDefunctCsc;
	private String noofAdditionalCscRequired;
	private String surveyDate;
	private String mode;

	public String getHabCode() {
		return habCode;
	}

	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}

	public String getVillage() {
		return village;
	}

	public void setVillage(String village) {
		this.village = village;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
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

	public String getTotalCscConstructed() {
		return totalCscConstructed;
	}

	public void setTotalCscConstructed(String totalCscConstructed) {
		this.totalCscConstructed = totalCscConstructed;
	}

	public String getTotalFunctionalCsc() {
		return totalFunctionalCsc;
	}

	public void setTotalFunctionalCsc(String totalFunctionalCsc) {
		this.totalFunctionalCsc = totalFunctionalCsc;
	}

	public String getTotalDefunctCsc() {
		return totalDefunctCsc;
	}

	public void setTotalDefunctCsc(String totalDefunctCsc) {
		this.totalDefunctCsc = totalDefunctCsc;
	}

	public String getNoofAdditionalCscRequired() {
		return noofAdditionalCscRequired;
	}

	public void setNoofAdditionalCscRequired(String noofAdditionalCscRequired) {
		this.noofAdditionalCscRequired = noofAdditionalCscRequired;
	}

	public String getSurveyDate() {
		return surveyDate;
	}

	public void setSurveyDate(String surveyDate) {
		this.surveyDate = surveyDate;
	}

	@Override
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		this.district = "";
		this.mandal = "";
		this.panchayat = "";
		this.village = "";
		this.habCode = "";
		this.totalCscConstructed = "";
		this.totalFunctionalCsc = "";
		this.totalDefunctCsc = "";
		this.noofAdditionalCscRequired = "";
		this.surveyDate = "";
	}

}
