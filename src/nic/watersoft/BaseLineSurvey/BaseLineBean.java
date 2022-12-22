package nic.watersoft.BaseLineSurvey;
import java.util.ArrayList;
import java.io.Serializable;
import java.util.ArrayList;

/**
 * 
 * @author N SREE LAXMI DEVI
 *
 */
public class BaseLineBean implements Serializable

{
	//Anganwadi school
	private String pitAvalilable="";
	private String binAvailable="";
	private String drinkingWaterexist="";
	private String toiletwaterFacilityavailable="";
	private String reasonforDefunct="";
	private String functionalReason="";
	private String buildingDept="";
	private String availabilityofToiletfacility="";
	private String totalEnrolment="";
	private String buildingTypename="";
	private String anganwadiCode="";
	private String anganwadiName="";
	private String anganCode="";
	private String anganNum="";

	public String getAnganNum() {
		return anganNum;
	}
	public void setAnganNum(String anganNum) {
		this.anganNum = anganNum;
	}
	public String getPitAvalilable() {
		return pitAvalilable;
	}
	public void setPitAvalilable(String pitAvalilable) {
		this.pitAvalilable = pitAvalilable;
	}
	public String getBinAvailable() {
		return binAvailable;
	}
	public void setBinAvailable(String binAvailable) {
		this.binAvailable = binAvailable;
	}
	public String getDrinkingWaterexist() {
		return drinkingWaterexist;
	}
	public void setDrinkingWaterexist(String drinkingWaterexist) {
		this.drinkingWaterexist = drinkingWaterexist;
	}
	public String getToiletwaterFacilityavailable() {
		return toiletwaterFacilityavailable;
	}
	public void setToiletwaterFacilityavailable(String toiletwaterFacilityavailable) {
		this.toiletwaterFacilityavailable = toiletwaterFacilityavailable;
	}
	public String getReasonforDefunct() {
		return reasonforDefunct;
	}
	public void setReasonforDefunct(String reasonforDefunct) {
		this.reasonforDefunct = reasonforDefunct;
	}
	public String getFunctionalReason() {
		return functionalReason;
	}
	public void setFunctionalReason(String functionalReason) {
		this.functionalReason = functionalReason;
	}
	public String getBuildingDept() {
		return buildingDept;
	}
	public void setBuildingDept(String buildingDept) {
		this.buildingDept = buildingDept;
	}
	public String getAvailabilityofToiletfacility() {
		return availabilityofToiletfacility;
	}
	public void setAvailabilityofToiletfacility(String availabilityofToiletfacility) {
		this.availabilityofToiletfacility = availabilityofToiletfacility;
	}
	public String getTotalEnrolment() {
		return totalEnrolment;
	}
	public void setTotalEnrolment(String totalEnrolment) {
		this.totalEnrolment = totalEnrolment;
	}
	public String getBuildingTypename() {
		return buildingTypename;
	}
	public void setBuildingTypename(String buildingTypename) {
		this.buildingTypename = buildingTypename;
	}
	public String getAnganwadiCode() {
		return anganwadiCode;
	}
	public void setAnganwadiCode(String anganwadiCode) {
		this.anganwadiCode = anganwadiCode;
	}
	public String getAnganwadiName() {
		return anganwadiName;
	}
	public void setAnganwadiName(String anganwadiName) {
		this.anganwadiName = anganwadiName;
	}
	public String getAnganCode() {
		return anganCode;
	}
	public void setAnganCode(String anganCode) {
		this.anganCode = anganCode;
	}
	private String tableName="";
	private String columnName="";
public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
private String dcode="";
private String mcode="";
private String pcode="";
private String vcode="";
private String habCode="";
private String bldgName="";
private String latFacility="";
private String watFacility="";
private String surveyDate="";
private String mode="";
private String panchName="";
private String dist="";
private String checks="";
private boolean isUpdate;
private String dName="";
private String commCode="";
private String solidCode="";

public String getSolidCode() {
	return solidCode;
}
public void setSolidCode(String solidCode) {
	this.solidCode = solidCode;
}
//
private String schoolName="";
private String diseCode="";
private String locality="";
private String schoolType="";
private String schoolCategory="";
private String schoolEstablieshed2007="";
private String boysCount="";
private String girlsCount="";
private String sanitaryExist="";
private String sanitaryBuildingdept="";
private String yearofBuilt="";
private String boystoiletCount="";
private String girlstoiletCount="";
private String isWaterExist="";
private String sanitaryUse="";
private String drinkingwaterFacilityAvailable="";
private String binExist="";
private String pitExist="";
private String schoolCode="";
 
public String getSchoolCode() {
	return schoolCode;
}
public void setSchoolCode(String schoolCode) {
	this.schoolCode = schoolCode;
}
public String getSchoolName() {
	return schoolName;
}
public void setSchoolName(String schoolName) {
	this.schoolName = schoolName;
}
public String getDiseCode() {
	return diseCode;
}
public void setDiseCode(String diseCode) {
	this.diseCode = diseCode;
}
public String getLocality() {
	return locality;
}
public void setLocality(String locality) {
	this.locality = locality;
}
public String getSchoolType() {
	return schoolType;
}
public void setSchoolType(String schoolType) {
	this.schoolType = schoolType;
}
public String getSchoolCategory() {
	return schoolCategory;
}
public void setSchoolCategory(String schoolCategory) {
	this.schoolCategory = schoolCategory;
}
public String getSchoolEstablieshed2007() {
	return schoolEstablieshed2007;
}
public void setSchoolEstablieshed2007(String schoolEstablieshed2007) {
	this.schoolEstablieshed2007 = schoolEstablieshed2007;
}
public String getBoysCount() {
	return boysCount;
}
public void setBoysCount(String boysCount) {
	this.boysCount = boysCount;
}
public String getGirlsCount() {
	return girlsCount;
}
public void setGirlsCount(String girlsCount) {
	this.girlsCount = girlsCount;
}
public String getSanitaryExist() {
	return sanitaryExist;
}
public void setSanitaryExist(String sanitaryExist) {
	this.sanitaryExist = sanitaryExist;
}
public String getSanitaryBuildingdept() {
	return sanitaryBuildingdept;
}
public void setSanitaryBuildingdept(String sanitaryBuildingdept) {
	this.sanitaryBuildingdept = sanitaryBuildingdept;
}
public String getYearofBuilt() {
	return yearofBuilt;
}
public void setYearofBuilt(String yearofBuilt) {
	this.yearofBuilt = yearofBuilt;
}
public String getBoystoiletCount() {
	return boystoiletCount;
}
public void setBoystoiletCount(String boystoiletCount) {
	this.boystoiletCount = boystoiletCount;
}
public String getGirlstoiletCount() {
	return girlstoiletCount;
}
public void setGirlstoiletCount(String girlstoiletCount) {
	this.girlstoiletCount = girlstoiletCount;
}
public String getIsWaterExist() {
	return isWaterExist;
}
public void setIsWaterExist(String isWaterExist) {
	this.isWaterExist = isWaterExist;
}
public String getSanitaryUse() {
	return sanitaryUse;
}
public void setSanitaryUse(String sanitaryUse) {
	this.sanitaryUse = sanitaryUse;
}
public String getDrinkingwaterFacilityAvailable() {
	return drinkingwaterFacilityAvailable;
}
public void setDrinkingwaterFacilityAvailable(
		String drinkingwaterFacilityAvailable) {
	this.drinkingwaterFacilityAvailable = drinkingwaterFacilityAvailable;
}
public String getBinExist() {
	return binExist;
}
public void setBinExist(String binExist) {
	this.binExist = binExist;
}
public String getPitExist() {
	return pitExist;
}
public void setPitExist(String pitExist) {
	this.pitExist = pitExist;
}
//
public String getCommCode() {
	return commCode;
	
}
public void setCommCode(String commCode) {
	this.commCode = commCode;
}
public String getdName() {
	return dName;
}
public void setdName(String dName) {
	this.dName = dName;
}
public String getmName() {
	return mName;
}
public void setmName(String mName) {
	this.mName = mName;
}
public String getpName() {
	return pName;
}
public void setpName(String pName) {
	this.pName = pName;
}
public String getvName() {
	return vName;
}
public void setvName(String vName) {
	this.vName = vName;
}
private String mName="";
private String pName="";
private String vName="";
//
 private String sDate="";
private String bldgCode="";
private String vwscFormed="";
private String vwsmFunctional="";

public String getBldgCode() {
	return bldgCode;
}
public void setBldgCode(String bldgCode) {
	this.bldgCode = bldgCode;
}
//
private String totDustbins="";
private String totSoakpits="";
private String totCompits="";
private String totTricycles="";
private String extraFacilities="";
private String otherInNo="";
private String drainageExist="";

//

public String getTotDustbins() {
	return totDustbins;
}
public void setTotDustbins(String totDustbins) {
	this.totDustbins = totDustbins;
}
public String getTotSoakpits() {
	return totSoakpits;
}
public void setTotSoakpits(String totSoakpits) {
	this.totSoakpits = totSoakpits;
}
public String getTotCompits() {
	return totCompits;
}
public void setTotCompits(String totCompits) {
	this.totCompits = totCompits;
}
public String getTotTricycles() {
	return totTricycles;
}
public void setTotTricycles(String totTricycles) {
	this.totTricycles = totTricycles;
}
public String getExtraFacilities() {
	return extraFacilities;
}
public void setExtraFacilities(String extraFacilities) {
	this.extraFacilities = extraFacilities;
}
public String getOtherInNo() {
	return otherInNo;
}
public void setOtherInNo(String otherInNo) {
	this.otherInNo = otherInNo;
}
public String getDrainageExist() {
	return drainageExist;
}
public void setDrainageExist(String drainageExist) {
	this.drainageExist = drainageExist;
}
public String getVwscFormed() {
	return vwscFormed;
}
public void setVwscFormed(String vwscFormed) {
	this.vwscFormed = vwscFormed;
}
public String getVwsmFunctional() {
	return vwsmFunctional;
}
public void setVwsmFunctional(String vwsmFunctional) {
	this.vwsmFunctional = vwsmFunctional;
}
public String getsDate() {
	return sDate;
}
public void setsDate(String sDate) {
	this.sDate = sDate;
}
//
private ArrayList bldgs=new ArrayList();



public boolean isUpdate() {
	return isUpdate;
}
public void setUpdate(boolean isUpdate) {
	this.isUpdate = isUpdate;
}
public ArrayList getBldgs() {
	return bldgs;
}
public void setBldgs(ArrayList bldgs) {
	this.bldgs = bldgs;
}
public String getChecks() {
	return checks;
}
public void setChecks(String checks) {
	this.checks = checks;
}
public String getDist() {
	return dist;
}
public void setDist(String dist) {
	this.dist = dist;
}
public String getPanchName() {
	return panchName;
}
public void setPanchName(String panchName) {
	this.panchName = panchName;
}
public String getHabCode() {
	return habCode;
}
public void setHabCode(String habCode) {
	this.habCode = habCode;
}
public String getBldgName() {
	return bldgName;
}
public void setBldgName(String bldgName) {
	this.bldgName = bldgName;
}
public String getLatFacility() {
	return latFacility;
}
public void setLatFacility(String latFacility) {
	this.latFacility = latFacility;
}
public String getWatFacility() {
	return watFacility;
}
public void setWatFacility(String watFacility) {
	this.watFacility = watFacility;
}
public String getSurveyDate() {
	return surveyDate;
}
public void setSurveyDate(String surveyDate) {
	this.surveyDate = surveyDate;
}
public String getMode() {
	return mode;
}
public void setMode(String mode) {
	this.mode = mode;
}
public String getDcode() {
	return dcode;
}
public void setDcode(String dcode) {
	this.dcode = dcode;
}
public String getMcode() {
	return mcode;
}
public void setMcode(String mcode) {
	this.mcode = mcode;
}
public String getPcode() {
	return pcode;
}
public void setPcode(String pcode) {
	this.pcode = pcode;
}
public String getVcode() {
	return vcode;
}
public void setVcode(String vcode) {
	this.vcode = vcode;
}
}