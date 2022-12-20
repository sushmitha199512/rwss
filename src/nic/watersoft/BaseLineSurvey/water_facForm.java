package nic.watersoft.BaseLineSurvey;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class water_facForm extends ActionForm implements Serializable{
	
	private String district;
	private String mandal;
	private String panchayat;
	private String village;
	private String habCode;
	private String totalStandposts;
	private String totalHouseholds;
	private String totalMultiStandposts;
	private String totalMultiHouseholds;
	private String totalPumps;
	private String totalOpenwell;
	private String seasonal;
	private String throughOutYear;
	private String surveyDate;
	private String mode;
	
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
	public String getTotalStandposts() {
		return totalStandposts;
	}
	public void setTotalStandposts(String totalStandposts) {
		this.totalStandposts = totalStandposts;
	}
	public String getTotalHouseholds() {
		return totalHouseholds;
	}
	public void setTotalHouseholds(String totalHouseholds) {
		this.totalHouseholds = totalHouseholds;
	}
	public String getTotalMultiStandposts() {
		return totalMultiStandposts;
	}
	public void setTotalMultiStandposts(String totalMultiStandposts) {
		this.totalMultiStandposts = totalMultiStandposts;
	}
	public String getTotalMultiHouseholds() {
		return totalMultiHouseholds;
	}
	public void setTotalMultiHouseholds(String totalMultiHouseholds) {
		this.totalMultiHouseholds = totalMultiHouseholds;
	}
	public String getTotalPumps() {
		return totalPumps;
	}
	public void setTotalPumps(String totalPumps) {
		this.totalPumps = totalPumps;
	}
	public String getTotalOpenwell() {
		return totalOpenwell;
	}
	public void setTotalOpenwell(String totalOpenwell) {
		this.totalOpenwell = totalOpenwell;
	}
	public String getSeasonal() {
		return seasonal;
	}
	public void setSeasonal(String seasonal) {
		this.seasonal = seasonal;
	}
	public String getThroughOutYear() {
		return throughOutYear;
	}
	public void setThroughOutYear(String throughOutYear) {
		this.throughOutYear = throughOutYear;
	}
	public String getSurveyDate() {
		return surveyDate;
	}
	public void setSurveyDate(String surveyDate) {
		this.surveyDate = surveyDate;
	}
	public void reset(ActionMapping mapping, HttpServletRequest request) {
		this.district = "";
		this.mandal = "";
		this.panchayat = "";
		this.village = "";
		this.habCode = "";
		this.totalStandposts = "";
		this.totalHouseholds = "";
		this.totalMultiStandposts= "";
		this.totalMultiHouseholds = "";
		this.totalPumps="";
		this.totalOpenwell="";
		this.seasonal="";
		this.throughOutYear="";
		this.surveyDate = "";
	}
	

}
