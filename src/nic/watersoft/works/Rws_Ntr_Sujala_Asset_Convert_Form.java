package nic.watersoft.works;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

import com.ibm.icu.text.SimpleDateFormat;

public class Rws_Ntr_Sujala_Asset_Convert_Form extends ActionForm
{
private String circleCode;
private ArrayList circles;
private String mandalCode;
private ArrayList mandals;
private String mandal;
private String mandalName;
private ArrayList prhabs;
private String panchCode;
private String  habitation;
private ArrayList panchayats;
/**
 Hab Details
 */
private ArrayList habList;
private String habCode;
private String habName;
private String habPop;
private String checks;
private String habstatus;
private String currentDate;
private ArrayList plantTypes;
private ArrayList AgencyTypes;
private ArrayList maintenanceTypes;
private String plantType;
private String agencyType;
private String maintenanceType;
private String instAgencyName;
private String mainAgencyName;
private String plantCapacity;
private ArrayList habSaveList;


private String shabCode;
private String scurrentDate;
private String splantType;
private String sagencyType;
private String smaintenanceType;
private String sinstAgencyName;
private String smainAgencyName;
private String splantCapacity;
private String year;

private ArrayList years;

private String convStatus;
private String implDate;
private String assetCode;
private String assetName;
private String assetStatus;
private String assetCost;
private String location;
private String startYear;
private String dateCreation;
private String assetType;

private String sourceCode;
private String sourceLocation;
private String capacity;
private String noofUnits;
private String noOfHoursUsage;
private String noofStandByUnits;
private String rawWaterStorageTankExisting;
private String productWaterStorageTankExisting;
private String shelterExisting;
private String latitude;
private String longitude;
private String elivation;
private String wayPoint;
private String schemeCode;
private int sourceCount;
private FormFile compImage;
private String compCost;
private String compStatus;
private String compImageStatus;
private String aveCanSupplied;

private ArrayList convertedHabList;


public String getAveCanSupplied() {
	return aveCanSupplied;
}
public void setAveCanSupplied(String aveCanSupplied) {
	this.aveCanSupplied = aveCanSupplied;
}
public String getCompImageStatus() {
	return compImageStatus;
}
public void setCompImageStatus(String compImageStatus) {
	this.compImageStatus = compImageStatus;
}
public String getCompCost() {
	return compCost;
}
public void setCompCost(String compCost) {
	this.compCost = compCost;
}
public String getCompStatus() {
	return compStatus;
}
public void setCompStatus(String compStatus) {
	this.compStatus = compStatus;
}
public FormFile getCompImage() {
	return compImage;
}
public void setCompImage(FormFile compImage) {
	this.compImage = compImage;
}
public int getSourceCount() {
	return sourceCount;
}
public void setSourceCount(int sourceCount) {
	this.sourceCount = sourceCount;
}
public String getSchemeCode() {
	return schemeCode;
}
public void setSchemeCode(String schemeCode) {
	this.schemeCode = schemeCode;
}
public String getConvStatus() {
	return convStatus;
}
public void setConvStatus(String convStatus) {
	this.convStatus = convStatus;
}
public String getImplDate() {
	return implDate;
}
public void setImplDate(String implDate) {
	this.implDate = implDate;
}
public String getProductWaterStorageTankExisting() {
	return productWaterStorageTankExisting;
}
public void setProductWaterStorageTankExisting(
		String productWaterStorageTankExisting) {
	this.productWaterStorageTankExisting = productWaterStorageTankExisting;
}
public String getSourceLocation() {
	return sourceLocation;
}
public void setSourceLocation(String sourceLocation) {
	this.sourceLocation = sourceLocation;
}
public String getCapacity() {
	return capacity;
}
public void setCapacity(String capacity) {
	this.capacity = capacity;
}
public String getNoofUnits() {
	return noofUnits;
}
public void setNoofUnits(String noofUnits) {
	this.noofUnits = noofUnits;
}
public String getNoOfHoursUsage() {
	return noOfHoursUsage;
}
public void setNoOfHoursUsage(String noOfHoursUsage) {
	this.noOfHoursUsage = noOfHoursUsage;
}
public String getNoofStandByUnits() {
	return noofStandByUnits;
}
public void setNoofStandByUnits(String noofStandByUnits) {
	this.noofStandByUnits = noofStandByUnits;
}
public String getRawWaterStorageTankExisting() {
	return rawWaterStorageTankExisting;
}
public void setRawWaterStorageTankExisting(String rawWaterStorageTankExisting) {
	this.rawWaterStorageTankExisting = rawWaterStorageTankExisting;
}
public String getShelterExisting() {
	return shelterExisting;
}
public void setShelterExisting(String shelterExisting) {
	this.shelterExisting = shelterExisting;
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
public String getElivation() {
	return elivation;
}
public void setElivation(String elivation) {
	this.elivation = elivation;
}
public String getWayPoint() {
	return wayPoint;
}
public void setWayPoint(String wayPoint) {
	this.wayPoint = wayPoint;
}
public String getAssetType() {
	return assetType;
}
public void setAssetType(String assetType) {
	this.assetType = assetType;
}
public String getAssetName() {
	return assetName;
}
public void setAssetName(String assetName) {
	this.assetName = assetName;
}
public String getAssetStatus() {
	return assetStatus;
}
public void setAssetStatus(String assetStatus) {
	this.assetStatus = assetStatus;
}
public String getAssetCost() {
	return assetCost;
}
public void setAssetCost(String assetCost) {
	this.assetCost = assetCost;
}
public String getLocation() {
	return location;
}
public void setLocation(String location) {
	this.location = location;
}
public String getStartYear() {
	return startYear;
}
public void setStartYear(String startYear) {
	this.startYear = startYear;
}
public String getDateCreation() {
	return dateCreation;
}
public void setDateCreation(String dateCreation) {
	this.dateCreation = dateCreation;
}
public String getSourceCode() {
	return sourceCode;
}
public void setSourceCode(String sourceCode) {
	this.sourceCode = sourceCode;
}
public String getAssetCode() {
	return assetCode;
}
public void setAssetCode(String assetCode) {
	this.assetCode = assetCode;
}
public String getYear() {
	return year;
}
public void setYear(String year) {
	this.year = year;
}
public ArrayList getYears() {
	return years;
}
public void setYears(ArrayList years) {
	this.years = years;
}
public String getShabCode() {
	return shabCode;
}
public void setShabCode(String shabCode) {
	this.shabCode = shabCode;
}
public String getScurrentDate() {
	return scurrentDate;
}
public void setScurrentDate(String scurrentDate) {
	this.scurrentDate = scurrentDate;
}
public String getSplantType() {
	return splantType;
}
public void setSplantType(String splantType) {
	this.splantType = splantType;
}
public String getSagencyType() {
	return sagencyType;
}
public void setSagencyType(String sagencyType) {
	this.sagencyType = sagencyType;
}
public String getSmaintenanceType() {
	return smaintenanceType;
}
public void setSmaintenanceType(String smaintenanceType) {
	this.smaintenanceType = smaintenanceType;
}
public String getSinstAgencyName() {
	return sinstAgencyName;
}
public void setSinstAgencyName(String sinstAgencyName) {
	this.sinstAgencyName = sinstAgencyName;
}
public String getSmainAgencyName() {
	return smainAgencyName;
}
public void setSmainAgencyName(String smainAgencyName) {
	this.smainAgencyName = smainAgencyName;
}
public String getSplantCapacity() {
	return splantCapacity;
}
public void setSplantCapacity(String splantCapacity) {
	this.splantCapacity = splantCapacity;
}
public ArrayList getHabSaveList() {
	return habSaveList;
}
public void setHabSaveList(ArrayList habSaveList) {
	this.habSaveList = habSaveList;
}
public String getHabName() {
	return habName;
}
public void setHabName(String habName) {
	this.habName = habName;
}
public String getCircleCode() {
	return circleCode;
}
public void setCircleCode(String circleCode) {
	this.circleCode = circleCode;
}
public ArrayList getCircles() {
	return circles;
}
public void setCircles(ArrayList circles) {
	this.circles = circles;
}
public String getMandalCode() {
	return mandalCode;
}
public void setMandalCode(String mandalCode) {
	this.mandalCode = mandalCode;
}
public ArrayList getMandals() {
	return mandals;
}
public void setMandals(ArrayList mandals) {
	this.mandals = mandals;
}
public String getMandal() {
	return mandal;
}
public void setMandal(String mandal) {
	this.mandal = mandal;
}
public String getMandalName() {
	return mandalName;
}
public void setMandalName(String mandalName) {
	this.mandalName = mandalName;
}
public ArrayList getPrhabs() {
	return prhabs;
}
public void setPrhabs(ArrayList prhabs) {
	this.prhabs = prhabs;
}
public String getPanchCode() {
	return panchCode;
}
public void setPanchCode(String panchCode) {
	this.panchCode = panchCode;
}
public String getHabitation() {
	return habitation;
}
public void setHabitation(String habitation) {
	this.habitation = habitation;
}
public ArrayList getPanchayats() {
	return panchayats;
}
public void setPanchayats(ArrayList panchayats) {
	this.panchayats = panchayats;
}
public ArrayList getHabList() {
	return habList;
}
public void setHabList(ArrayList habList) {
	this.habList = habList;
}
public String getHabCode() {
	return habCode;
}
public void setHabCode(String habCode) {
	this.habCode = habCode;
}
public String getHabPop() {
	return habPop;
}
public void setHabPop(String habPop) {
	this.habPop = habPop;
}
public String getChecks() {
	return checks;
}
public void setChecks(String checks) {
	this.checks = checks;
}
public String getHabstatus() {
	return habstatus;
}
public void setHabstatus(String habstatus) {
	this.habstatus = habstatus;
}
public String getCurrentDate() {
	return currentDate;
}
public void setCurrentDate(String currentDate) {
	this.currentDate = currentDate;
}
public ArrayList getPlantTypes() {
	return plantTypes;
}
public void setPlantTypes(ArrayList plantTypes) {
	this.plantTypes = plantTypes;
}
public ArrayList getAgencyTypes() {
	return AgencyTypes;
}
public void setAgencyTypes(ArrayList agencyTypes) {
	AgencyTypes = agencyTypes;
}
public ArrayList getMaintenanceTypes() {
	return maintenanceTypes;
}
public void setMaintenanceTypes(ArrayList maintenanceTypes) {
	this.maintenanceTypes = maintenanceTypes;
}

public String getPlantType() {
	return plantType;
}
public void setPlantType(String plantType) {
	this.plantType = plantType;
}

public String getAgencyType() {
	return agencyType;
}
public void setAgencyType(String agencyType) {
	this.agencyType = agencyType;
}
public String getMaintenanceType() {
	return maintenanceType;
}
public void setMaintenanceType(String maintenanceType) {
	this.maintenanceType = maintenanceType;
}

public String getInstAgencyName() {
	return instAgencyName;
}
public void setInstAgencyName(String instAgencyName) {
	this.instAgencyName = instAgencyName;
}
public String getMainAgencyName() {
	return mainAgencyName;
}
public void setMainAgencyName(String mainAgencyName) {
	this.mainAgencyName = mainAgencyName;
}
public String getPlantCapacity() {
	return plantCapacity;
}
public void setPlantCapacity(String plantCapacity) {
	this.plantCapacity = plantCapacity;
}
public ArrayList getConvertedHabList() {
	return convertedHabList;
}
public void setConvertedHabList(ArrayList convertedHabList) {
	this.convertedHabList = convertedHabList;
}


}
