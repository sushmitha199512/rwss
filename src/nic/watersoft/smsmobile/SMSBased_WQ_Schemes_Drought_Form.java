package nic.watersoft.smsmobile;


import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class SMSBased_WQ_Schemes_Drought_Form extends ActionForm {

	private ArrayList<SMSBased_WQ_Schemes_Drought_Bean> chlorides;
	private ArrayList<SMSBased_WQ_Schemes_Drought_Bean> chlorides1;
	private ArrayList<SMSBased_WQ_Schemes_Drought_Bean> schemes;
	private ArrayList<SMSBased_WQ_Schemes_Drought_Bean> schemes1;
	private ArrayList<SMSBased_WQ_Schemes_Drought_Bean> drought;
	private ArrayList<SMSBased_WQ_Schemes_Drought_Bean> drought1;
	private ArrayList<SMSBased_WQ_Schemes_Drought_Bean> ohsr;
	private ArrayList<SMSBased_WQ_Schemes_Drought_Bean> ohsr1;
	public ArrayList<SMSBased_WQ_Schemes_Drought_Bean> getOhsr() {
		return ohsr;
	}
	public void setOhsr(ArrayList<SMSBased_WQ_Schemes_Drought_Bean> ohsr) {
		this.ohsr = ohsr;
	}
	public ArrayList getAssets() {
		return assets;
	}
	public void setAssets(ArrayList assets) {
		this.assets = assets;
	}
	public String getOHSR() {
		return OHSR;
	}
	public void setOHSR(String oHSR) {
		OHSR = oHSR;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	private String district;
	private String districtName;
	private String mandal;
	private String panchayat;
	private String village;
	private String habitation;
	private String sourceCode;
	private String sourceName;
	private String assetCode;
	private String assetName;
	private String contaminationValue;
	private String actionTaken;
	private String dateOfAction;
	private String serviceRequest;
	private String remarks;
	private String ppmValue;
	private String smsMobile;
	private String checks;
	private String dateEntered;
	private String testDate;
	private String schemeStatus;
	private String smsDate;
	private String location;
	private String tankerStatus;
	private String tankerUpdateStatus;
	private String tankerSupplyDate;
	private String droughtHabCode;
	private String enteredBy;
	private ArrayList assets;
	private String mesid;
	private String OHSR;
	private String status;
	private String latitude;
	private String longitude;
	private String astType;
	
	private String localpersonname;
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getEnteredBy() {
		return enteredBy;
	}
	public void setEnteredBy(String enteredBy) {
		this.enteredBy = enteredBy;
	}
	public String getTankerSupplyDate() {
		return tankerSupplyDate;
	}
	public void setTankerSupplyDate(String tankerSupplyDate) {
		this.tankerSupplyDate = tankerSupplyDate;
	}
	public ArrayList<SMSBased_WQ_Schemes_Drought_Bean> getDrought() {
		return drought;
	}
	public void setDrought(ArrayList<SMSBased_WQ_Schemes_Drought_Bean> drought) {
		this.drought = drought;
	}
	public String getDroughtHabCode() {
		return droughtHabCode;
	}
	public void setDroughtHabCode(String droughtHabCode) {
		this.droughtHabCode = droughtHabCode;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getTankerStatus() {
		return tankerStatus;
	}
	public void setTankerStatus(String tankerStatus) {
		this.tankerStatus = tankerStatus;
	}
	public String getTankerUpdateStatus() {
		return tankerUpdateStatus;
	}
	public void setTankerUpdateStatus(String tankerUpdateStatus) {
		this.tankerUpdateStatus = tankerUpdateStatus;
	}
	public String getSmsDate() {
		return smsDate;
	}
	public void setSmsDate(String smsDate) {
		this.smsDate = smsDate;
	}
	public ArrayList<SMSBased_WQ_Schemes_Drought_Bean> getSchemes() {
		return schemes;
	}
	public void setSchemes(ArrayList<SMSBased_WQ_Schemes_Drought_Bean> schemes) {
		this.schemes = schemes;
	}
	public String getSchemeStatus() {
		return schemeStatus;
	}
	public void setSchemeStatus(String schemeStatus) {
		this.schemeStatus = schemeStatus;
	}
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	public String getTestDate() {
		return testDate;
	}
	public void setTestDate(String testDate) {
		this.testDate = testDate;
	}
	public String getDateEntered() {
		return dateEntered;
	}
	public void setDateEntered(String dateEntered) {
		this.dateEntered = dateEntered;
	}
	public String getChecks() {
		return checks;
	}
	public void setChecks(String checks) {
		this.checks = checks;
	}
	public String getPpmValue() {
		return ppmValue;
	}
	public void setPpmValue(String ppmValue) {
		this.ppmValue = ppmValue;
	}
	public String getSmsMobile() {
		return smsMobile;
	}
	public void setSmsMobile(String smsMobile) {
		this.smsMobile = smsMobile;
	}
	public ArrayList<SMSBased_WQ_Schemes_Drought_Bean> getChlorides() {
		return chlorides;
	}
	public void setChlorides(ArrayList<SMSBased_WQ_Schemes_Drought_Bean> chlorides) {
		this.chlorides = chlorides;
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
	public String getHabitation() {
		return habitation;
	}
	public void setHabitation(String habitation) {
		this.habitation = habitation;
	}
	public String getSourceCode() {
		return sourceCode;
	}
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}
	public String getSourceName() {
		return sourceName;
	}
	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}
	public String getContaminationValue() {
		return contaminationValue;
	}
	public void setContaminationValue(String contaminationValue) {
		this.contaminationValue = contaminationValue;
	}
	public String getActionTaken() {
		return actionTaken;
	}
	public void setActionTaken(String actionTaken) {
		this.actionTaken = actionTaken;
	}
	public String getDateOfAction() {
		return dateOfAction;
	}
	public void setDateOfAction(String dateOfAction) {
		this.dateOfAction = dateOfAction;
	}
	public String getServiceRequest() {
		return serviceRequest;
	}
	public void setServiceRequest(String serviceRequest) {
		this.serviceRequest = serviceRequest;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getMesid() {
		return mesid;
	}
	public void setMesid(String mesid) {
		this.mesid = mesid;
	}
	public String getLocalpersonname() {
		return localpersonname;
	}
	public void setLocalpersonname(String localpersonname) {
		this.localpersonname = localpersonname;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getAstType() {
		return astType;
	}
	public void setAstType(String astType) {
		this.astType = astType;
	}
	public ArrayList<SMSBased_WQ_Schemes_Drought_Bean> getChlorides1() {
		return chlorides1;
	}
	public void setChlorides1(ArrayList<SMSBased_WQ_Schemes_Drought_Bean> chlorides1) {
		this.chlorides1 = chlorides1;
	}
	public ArrayList<SMSBased_WQ_Schemes_Drought_Bean> getSchemes1() {
		return schemes1;
	}
	public void setSchemes1(ArrayList<SMSBased_WQ_Schemes_Drought_Bean> schemes1) {
		this.schemes1 = schemes1;
	}
	public ArrayList<SMSBased_WQ_Schemes_Drought_Bean> getDrought1() {
		return drought1;
	}
	public void setDrought1(ArrayList<SMSBased_WQ_Schemes_Drought_Bean> drought1) {
		this.drought1 = drought1;
	}
	public ArrayList<SMSBased_WQ_Schemes_Drought_Bean> getOhsr1() {
		return ohsr1;
	}
	public void setOhsr1(ArrayList<SMSBased_WQ_Schemes_Drought_Bean> ohsr1) {
		this.ohsr1 = ohsr1;
	}
	
		
}
