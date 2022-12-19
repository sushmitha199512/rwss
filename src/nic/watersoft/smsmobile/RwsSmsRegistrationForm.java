package nic.watersoft.smsmobile;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

public class RwsSmsRegistrationForm  extends ActionForm {
	
	private String username;
	private String confirmpassword;
	private String gender;
	private String desgnation;
	private String datecollname;
	private String servicereq;
	private String datadownload;
	private String location;
	private String modAuth;
	private String taskCode;
	private String taskName;
	private String taskcodename;
	private String taskAuthorizationCode;
	private String taskAuthorizationName;
	private String password;
	public RwsSmsRegistrationForm(){}

	
	public String getTaskAuthorizationCode() {
		return taskAuthorizationCode;
	}
	public void setTaskAuthorizationCode(String taskAuthorizationCode) {
		this.taskAuthorizationCode = taskAuthorizationCode;
	}
	public String getTaskAuthorizationName() {
		return taskAuthorizationName;
	}
	public void setTaskAuthorizationName(String taskAuthorizationName) {
		this.taskAuthorizationName = taskAuthorizationName;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}	
	
	private String imeino;
	
	    public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getDist() {
		return dist;
	}
	public void setDist(String dist) {
		this.dist = dist;
	}
	public String getDist1() {
		return dist1;
	}
	public void setDist1(String dist1) {
		this.dist1 = dist1;
	}
	public String getMand1() {
		return mand1;
	}
	public void setMand1(String mand1) {
		this.mand1 = mand1;
	}
	public String getPanch1() {
		return panch1;
	}
	public void setPanch1(String panch1) {
		this.panch1 = panch1;
	}
	public String getHabCode1() {
		return habCode1;
	}
	public void setHabCode1(String habCode1) {
		this.habCode1 = habCode1;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	public String getTypeofAsset() {
		return typeofAsset;
	}
	public void setTypeofAsset(String typeofAsset) {
		this.typeofAsset = typeofAsset;
	}
	public String getTypeofAssetName() {
		return typeofAssetName;
	}
	public void setTypeofAssetName(String typeofAssetName) {
		this.typeofAssetName = typeofAssetName;
	}
	public String getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(String categoryCode) {
		this.categoryCode = categoryCode;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	public String getVillageCode() {
		return villageCode;
	}
	public void setVillageCode(String villageCode) {
		this.villageCode = villageCode;
	}
	
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	
	public String getDateCreation() {
		return dateCreation;
	}
	public void setDateCreation(String dateCreation) {
		this.dateCreation = dateCreation;
	}
	
	public String getMandal() {
		return mandal;
	}
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	public String getDcode() {
		return dcode;
	}
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getMandalCode() {
		return mandalCode;
	}
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
	}
	public String getMandalName() {
		return mandalName;
	}
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	public String getPanchayatCode() {
		return panchayatCode;
	}
	public void setPanchayatCode(String panchayatCode) {
		this.panchayatCode = panchayatCode;
	}
	public String getPanchayatName() {
		return panchayatName;
	}
	public void setPanchayatName(String panchayatName) {
		this.panchayatName = panchayatName;
	}
	public String getHabName() {
		return habName;
	}
	public void setHabName(String habName) {
		this.habName = habName;
	}
	
	public String getVill() {
		return vill;
	}
	public void setVill(String vill) {
		this.vill = vill;
	}
	
	public String getHeadOfficeCode() {
		return headOfficeCode;
	}
	public void setHeadOfficeCode(String headOfficeCode) {
		this.headOfficeCode = headOfficeCode;
	}
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	public String getDistrictCode() {
		return districtCode;
	}
	public void setDistrictCode(String districtCode) {
		this.districtCode = districtCode;
	}
	
	public String getHeadOfficeName() {
		return headOfficeName;
	}
	public void setHeadOfficeName(String headOfficeName) {
		this.headOfficeName = headOfficeName;
	}
	public String getCircleOfficeName() {
		return circleOfficeName;
	}
	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getCircleCode() {
		return circleCode;
	}
	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}
	public String getMand() {
		return mand;
	}
	public void setMand(String mand) {
		this.mand = mand;
	}
	public String getPanch() {
		return panch;
	}
	public void setPanch(String panch) {
		this.panch = panch;
	}
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	


		public void setImeino(String imeino) {
		this.imeino = imeino;
	}
	public String getImeino() {
		return imeino;
	}


		public void setConfirmpassword(String confirmpassword) {
		this.confirmpassword = confirmpassword;
	}
	public String getConfirmpassword() {
		return confirmpassword;
	}


		public void setGender(String gender) {
		this.gender = gender;
	}
	public String getGender() {
		return gender;
	}


		public void setDesgnation(String desgnation) {
		this.desgnation = desgnation;
	}
	public String getDesgnation() {
		return desgnation;
	}


		public void setDatecollname(String datecollname) {
		this.datecollname = datecollname;
	}
	public String getDatecollname() {
		return datecollname;
	}


		public void setServicereq(String servicereq) {
		this.servicereq = servicereq;
	}
	public String getServicereq() {
		return servicereq;
	}


		public void setDatadownload(String datadownload) {
		this.datadownload = datadownload;
	}
	public String getDatadownload() {
		return datadownload;
	}


		public void setLocation(String location) {
		this.location = location;
	}
	public String getLocation() {
		return location;
	}


		public String getOldMobile() {
		return oldMobile;
	}
	public void setOldMobile(String oldMobile) {
		this.oldMobile = oldMobile;
	}


		public String getModAuth() {
		return modAuth;
	}
	public void setModAuth(String modAuth) {
		this.modAuth = modAuth;
	}


		public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}


		public String getTaskCode() {
		return taskCode;
	}
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}


		public String getTaskcodename() {
		return taskcodename;
	}
	public void setTaskcodename(String taskcodename) {
		this.taskcodename = taskcodename;
	}


		private String mode;
	    private String dist;
	    private String dist1;
	    private String mand1;
	    private String panch1;
	    private String habCode1;
	    private String codeName;
	    private String typeofAsset;
	    private String typeofAssetName;
	    private String categoryCode;
	    private String categoryName;
	    private String name;
	    private String address;
	   
	    private String villageCode;
	   
	    private String phoneNo;
	    private String oldMobile;
	    
	    private String dateCreation;
	    
	   
	    private String mandal;
	    private String dcode;
	    private String district;
	  
	    private String pcode;
	    private String mandalCode;
	    private String mandalName;
	    private String panchayatCode;
	    private String panchayatName;
	    private String habName;
	    
	    private String vill;
	   
	    private String headOfficeCode;
	    private String circleOfficeCode;
	    private String districtCode;
	  
	    private String headOfficeName;
	    private String circleOfficeName;
	    private String districtName;
	    private String circleCode;
	    private String mand;
	    private String panch;
	    private String habCode;
	   
	    
	    private String message;
	    
	   
	    private String emailId;
	  
	    
	

}
