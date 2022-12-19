package nic.watersoft.BaseLineSurvey;

import java.util.ArrayList;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class blsOrgForm extends ActionForm {
private String mode;
private String district;
private String mandal;
private String village;
private String habCode;




private String panchayat,ngos,shgs,wmngrps,othergrps,surveydt;

public String getNgos() {
	return ngos;
}

public void setNgos(String ngos) {
	this.ngos = ngos;
}

public String getShgs() {
	return shgs;
}

public void setShgs(String shgs) {
	this.shgs = shgs;
}

public String getWmngrps() {
	return wmngrps;
}

public void setWmngrps(String wmngrps) {
	this.wmngrps = wmngrps;
}

public String getOthergrps() {
	return othergrps;
}

public void setOthergrps(String othergrps) {
	this.othergrps = othergrps;
}

public String getSurveydt() {
	return surveydt;
}

public void setSurveydt(String surveydt) {
	this.surveydt = surveydt;
}

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


@Override
	public void reset(ActionMapping mapping,HttpServletRequest request) {

	this.district="";
	this.mandal="";
	this.village="";
	this.habCode="";
	this.panchayat="";
	this.ngos="";this.shgs="";this.wmngrps="";this.othergrps="";this.surveydt="";
	}


}
