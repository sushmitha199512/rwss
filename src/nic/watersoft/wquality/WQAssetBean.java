package nic.watersoft.wquality;
import java.io.Serializable;
import java.util.ArrayList;
import org.apache.struts.action.ActionForm;

/**
 * 
 * @author 
 *
 */
public class WQAssetBean implements Serializable
{
	//Started on 27-06-2014
	private String circleCode="";
	private String divisionCode="";
	private String subdivisionCode="";
	private String assetType="";
	private String finYear="";
	private String assetCode="";
	private String dateofCreation="";
	private String assetName="";
	private String location="";
	private String ongoingWorks="";
	private String assetCost="";
	private String workName="";
	private String workId="";
	private String office="";
	private ArrayList ongoing;
	private ArrayList sources;
	private String testId="";
	private String potable="";
	
	public String getPotable() {
		return potable;
	}
	public void setPotable(String potable) {
		this.potable = potable;
	}
	public String getTestId() {
		return testId;
	}
	public void setTestId(String testId) {
		this.testId = testId;
	}
	public ArrayList getSources() {
		return sources;
	}
	public void setSources(ArrayList sources) {
		this.sources = sources;
	}
	private String sourceName="";
	private String sourceLocation="";
	private String sourceType="";
	private String portable="";
	private String remarks="";
	private String preparedDate="";
	
	
	
	public String getSourceName() {
		return sourceName;
	}
	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}
	public String getSourceLocation() {
		return sourceLocation;
	}
	public void setSourceLocation(String sourceLocation) {
		this.sourceLocation = sourceLocation;
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getPortable() {
		return portable;
	}
	public void setPortable(String portable) {
		this.portable = portable;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public String getPreparedDate() {
		return preparedDate;
	}
	public void setPreparedDate(String preparedDate) {
		this.preparedDate = preparedDate;
	}
	private String assetNo="";
	public String getAssetNo() {
		return assetNo;
	}
	public void setAssetNo(String assetNo) {
		this.assetNo = assetNo;
	}
	public String getSourceCode() {
		return sourceCode;
	}
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}
	private String sourceCode="";
	public String getParameter1() {
		return parameter1;
	}
	public void setParameter1(String parameter1) {
		this.parameter1 = parameter1;
	}
	public String getParameter2() {
		return parameter2;
	}
	public void setParameter2(String parameter2) {
		this.parameter2 = parameter2;
	}
	public String getParameter3() {
		return parameter3;
	}
	public void setParameter3(String parameter3) {
		this.parameter3 = parameter3;
	}
	public String getParameter4() {
		return parameter4;
	}
	public void setParameter4(String parameter4) {
		this.parameter4 = parameter4;
	}
	public String getParameter5() {
		return parameter5;
	}
	public void setParameter5(String parameter5) {
		this.parameter5 = parameter5;
	}
	private String parameter1="";
	private String parameter2="";
	private String parameter3="";
	private String parameter4="";
	private String parameter5="";
	
	
	private String parameter6="";
	private String parameter7="";
	private String parameter8="";
	private String parameter9="";
	
	
	
	
	
	
	public String getParameter6() {
		return parameter6;
	}
	public void setParameter6(String parameter6) {
		this.parameter6 = parameter6;
	}
	public String getParameter7() {
		return parameter7;
	}
	public void setParameter7(String parameter7) {
		this.parameter7 = parameter7;
	}
	public String getParameter8() {
		return parameter8;
	}
	public void setParameter8(String parameter8) {
		this.parameter8 = parameter8;
	}
	public String getParameter9() {
		return parameter9;
	}
	public void setParameter9(String parameter9) {
		this.parameter9 = parameter9;
	}
	public String getWorkName() {
		return workName;
	}
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	public String getWorkId() {
		return workId;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public String getOffice() {
		return office;
	}
	public void setOffice(String office) {
		this.office = office;
	}
	public ArrayList getOngoing() {
		return ongoing;
	}
	public void setOngoing(ArrayList ongoing) {
		this.ongoing = ongoing;
	}
	public String getCircleCode() {
		return circleCode;
	}
	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}
	public String getDivisionCode() {
		return divisionCode;
	}
	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}
	public String getSubdivisionCode() {
		return subdivisionCode;
	}
	public void setSubdivisionCode(String subdivisionCode) {
		this.subdivisionCode = subdivisionCode;
	}
	public String getAssetType() {
		return assetType;
	}
	public void setAssetType(String assetType) {
		this.assetType = assetType;
	}
	public String getFinYear() {
		return finYear;
	}
	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	public String getDateofCreation() {
		return dateofCreation;
	}
	public void setDateofCreation(String dateofCreation) {
		this.dateofCreation = dateofCreation;
	}
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getOngoingWorks() {
		return ongoingWorks;
	}
	public void setOngoingWorks(String ongoingWorks) {
		this.ongoingWorks = ongoingWorks;
	}
	public String getAssetCost() {
		return assetCost;
	}
	public void setAssetCost(String assetCost) {
		this.assetCost = assetCost;
	}
	//Started on 27-06-2014
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
	private String anganNum="";
	public String getAnganNum() {
		return anganNum;
	}
	public void setAnganNum(String anganNum) {
		this.anganNum = anganNum;
	}
	private String anganCode="";

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
	//
	private String tableName="";
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
	private String columnName="";
private String dcode="";
private String mcode="";
private String pcode="";
private String vcode="";
private String habCode="";
private String bldgName="";
private String latFacility="";
private String watFacility="";
private String surveyDate="";
private String dist="";
private String checks="";
private String panchName="";
private String bldgCode="";
public String getBldgCode() {
	return bldgCode;
}
public void setBldgCode(String bldgCode) {
	this.bldgCode = bldgCode;
}
private String vwscFormed="";
//
private String totDustbins="";
private String totSoakpits="";
private String totCompits="";
private String totTricycles="";
private String extraFacilities="";
private String otherInNo="";
private String drainageExist="";
private String solidCode="";

public String getSolidCode() {
	return solidCode;
}
public void setSolidCode(String solidCode) {
	this.solidCode = solidCode;
}
private String dName="";
private String mName="";
private String pName="";
private String vName="";
private String commCode="";
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
private String vwsmFunctional="";
private String sDate="";
public String getPanchName() {
	return panchName;
}
public void setPanchName(String panchName) {
	this.panchName = panchName;
}
//
private boolean isUpdate;

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
private ArrayList bldgs=new ArrayList();
//
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
private String mode="";

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