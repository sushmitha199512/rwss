package nic.watersoft.works;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

import com.ibm.icu.text.SimpleDateFormat;

public class Rws_Ntr_Sujala_Patakam_Frm extends ActionForm
{
private String circleCode;
private ArrayList circles;
private String mandalCode;
private ArrayList mandals;
private String mandal;
private String mandalName;
private String habCode;
private String habName;
private ArrayList prhabs;
private String panchCode;
private String village;
private String villageCode;
private String villageName;
private ArrayList villages;
private ArrayList panchayats;
private String panchayat;
private String  habitation;
private String  panchayatName;
/**
 Source Details
 */
private ArrayList sourceList;
private String constCode;
private String smandalCode;
private String gpCode;
private String shabCode;
private String habPop;
private String sourceType;
private String sourceCode;
private String sourceName;
private String sourcelocation;
private double coptValue;
private double turbValue;
private double phValue;
private double tdsValue;
private double flourideValue;
private double chlorideValue;
private double nitrateValue;
private double ironValue;
private double sulphateValue;
private double alkalinitValue ;
private double hardnessValue;
private double ecoliValue;
private String issueIdent;
private String plantType;
private String genHealIssuesIdent;
private String buildingAvailability  ;  
private String buildingName;
private String buildingLoc;
private String buildingSize;
private String waterAvailabilty;
private String waterAvalDist;
private String powerAvailability;
private String anyFirm;
private String anyFirmName	;    
private String anyFirmloc;
private String anyFirmExtPlantType;	    
private String anyFirmExtPlantCap;
private String anyCoporate;
private String anyCoporateName;
private String anyCoporateloc;
private String checks;
private String testid;
private String sourcecondition;

private String habstatus;

public String getHabstatus() {
	return habstatus;
}
public void setHabstatus(String habstatus) {
	this.habstatus = habstatus;
}
public String getSourcecondition() {
	return sourcecondition;
}
public void setSourcecondition(String sourcecondition) {
	this.sourcecondition = sourcecondition;
}
public String getTestid() {
	return testid;
}
public void setTestid(String testid) {
	this.testid = testid;
}
public String getChecks() {
	return checks;
}
public void setChecks(String checks) {
	this.checks = checks;
}
public String getAnyCoporateloc() {
	return anyCoporateloc;
}
public void setAnyCoporateloc(String anyCoporateloc) {
	this.anyCoporateloc = anyCoporateloc;
}
private String phaseImpl;
private String testDate;


public String getTestDate() {

	
		return testDate;
	
}
public void setTestDate(String testDate) {
	this.testDate = testDate;
}
public String getCircleCode() {
	return circleCode;
}
public void setCircleCode(String circleCode) 
{
	this.circleCode = circleCode;
}
public ArrayList getCircles() 
{
	if(circles==null)
	{
		return new ArrayList();
	}
	return circles;
}
public void setCircles(ArrayList circles)
{
	this.circles = circles;
}
public String getMandalCode() {
	return mandalCode;
}
public void setMandalCode(String mandalCode) {
	this.mandalCode = mandalCode;
}
public ArrayList getMandals()
{
	if(mandals==null)
	{
		return new ArrayList();
	}
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
public String getHabCode() {
	return habCode;
}
public void setHabCode(String habCode) {
	this.habCode = habCode;
}
public String getHabName() {
	return habName;
}
public void setHabName(String habName) {
	this.habName = habName;
}
public ArrayList getPrhabs()
{
	if(prhabs==null)
	{
		return new ArrayList();
	}
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
public String getVillage() {
	return village;
}
public void setVillage(String village) {
	this.village = village;
}
public String getVillageCode() {
	return villageCode;
}
public void setVillageCode(String villageCode) {
	this.villageCode = villageCode;
}
public String getVillageName() {
	return villageName;
}
public void setVillageName(String villageName) {
	this.villageName = villageName;
}
public ArrayList getVillages()
{
	if(villages==null)
	{
		return new ArrayList();
	}
	return villages;
}
public void setVillages(ArrayList villages)
{
	
	this.villages = villages;
}
public ArrayList getPanchayats()
{
	if(panchayats==null)
	{
		return new ArrayList();
	}
	return panchayats;
}
public void setPanchayats(ArrayList panchayats) {
	this.panchayats = panchayats;
}
public ArrayList getSourceList() 
{
	if(sourceList==null)
	{
		return new ArrayList();
	}
	return sourceList;
}
public void setSourceList(ArrayList sourceList) {
	this.sourceList = sourceList;
}

public String getPanchayat() {
	return panchayat;
}
public void setPanchayat(String panchayat) {
	this.panchayat = panchayat;
}
public String getHabitation() {
	return habitation;
}
public void setHabitation(String habitation) {
	this.habitation = habitation;
}
public String getPanchayatName() {
	return panchayatName;
}
public void setPanchayatName(String panchayatName) {
	this.panchayatName = panchayatName;
}
public String getConstCode() {
	return constCode;
}
public void setConstCode(String constCode) {
	this.constCode = constCode;
}
public String getSmandalCode() {
	return smandalCode;
}
public void setSmandalCode(String smandalCode) {
	this.smandalCode = smandalCode;
}
public String getGpCode() {
	return gpCode;
}
public void setGpCode(String gpCode) {
	this.gpCode = gpCode;
}
public String getShabCode() {
	return shabCode;
}
public void setShabCode(String shabCode) {
	this.shabCode = shabCode;
}
public String getHabPop() {
	return habPop;
}
public void setHabPop(String habPop) {
	this.habPop = habPop;
}
public String getSourceType() {
	return sourceType;
}
public void setSourceType(String sourceType) {
	this.sourceType = sourceType;
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
public String getSourcelocation() {
	return sourcelocation;
}
public void setSourcelocation(String sourcelocation) {
	this.sourcelocation = sourcelocation;
}

public double getCoptValue() {
	return coptValue;
}
public void setCoptValue(double coptValue) {
	this.coptValue = coptValue;
}

public double getTurbValue() {
	return turbValue;
}
public void setTurbValue(double turbValue) {
	this.turbValue = turbValue;
}

public double getPhValue() {
	return phValue;
}
public void setPhValue(double phValue) {
	this.phValue = phValue;
}
public double getTdsValue() {
	return tdsValue;
}
public void setTdsValue(double tdsValue) {
	this.tdsValue = tdsValue;
}
public double getFlourideValue() {
	return flourideValue;
}
public void setFlourideValue(double flourideValue) {
	this.flourideValue = flourideValue;
}
public double getChlorideValue() {
	return chlorideValue;
}
public void setChlorideValue(double chlorideValue) {
	this.chlorideValue = chlorideValue;
}
public double getNitrateValue() {
	return nitrateValue;
}
public void setNitrateValue(double nitrateValue) {
	this.nitrateValue = nitrateValue;
}
public double getIronValue() {
	return ironValue;
}
public void setIronValue(double ironValue) {
	this.ironValue = ironValue;
}
public double getSulphateValue() {
	return sulphateValue;
}
public void setSulphateValue(double sulphateValue) {
	this.sulphateValue = sulphateValue;
}
public double getAlkalinitValue() {
	return alkalinitValue;
}
public void setAlkalinitValue(double alkalinitValue) {
	this.alkalinitValue = alkalinitValue;
}
public double getHardnessValue() {
	return hardnessValue;
}
public void setHardnessValue(double hardnessValue) {
	this.hardnessValue = hardnessValue;
}
public double getEcoliValue() {
	return ecoliValue;
}
public void setEcoliValue(double ecoliValue) {
	this.ecoliValue = ecoliValue;
}
public String getIssueIdent() {
	return issueIdent;
}
public void setIssueIdent(String issueIdent) {
	this.issueIdent = issueIdent;
}
public String getPlantType() {
	return plantType;
}
public void setPlantType(String plantType) {
	this.plantType = plantType;
}
public String getGenHealIssuesIdent() {
	return genHealIssuesIdent;
}
public void setGenHealIssuesIdent(String genHealIssuesIdent) {
	this.genHealIssuesIdent = genHealIssuesIdent;
}
public String getBuildingAvailability() {
	return buildingAvailability;
}
public void setBuildingAvailability(String buildingAvailability) {
	this.buildingAvailability = buildingAvailability;
}
public String getBuildingName() {
	return buildingName;
}
public void setBuildingName(String buildingName) {
	this.buildingName = buildingName;
}
public String getBuildingLoc() {
	return buildingLoc;
}
public void setBuildingLoc(String buildingLoc) {
	this.buildingLoc = buildingLoc;
}
public String getBuildingSize() {
	return buildingSize;
}
public void setBuildingSize(String buildingSize) {
	this.buildingSize = buildingSize;
}
public String getWaterAvailabilty() {
	return waterAvailabilty;
}
public void setWaterAvailabilty(String waterAvailabilty) {
	this.waterAvailabilty = waterAvailabilty;
}
public String getWaterAvalDist() {
	return waterAvalDist;
}
public void setWaterAvalDist(String waterAvalDist) {
	this.waterAvalDist = waterAvalDist;
}
public String getPowerAvailability() {
	return powerAvailability;
}
public void setPowerAvailability(String powerAvailability) {
	this.powerAvailability = powerAvailability;
}
public String getAnyFirm() {
	return anyFirm;
}
public void setAnyFirm(String anyFirm) {
	this.anyFirm = anyFirm;
}
public String getAnyFirmName() {
	return anyFirmName;
}
public void setAnyFirmName(String anyFirmName) {
	this.anyFirmName = anyFirmName;
}
public String getAnyFirmloc() {
	return anyFirmloc;
}
public void setAnyFirmloc(String anyFirmloc) {
	this.anyFirmloc = anyFirmloc;
}
public String getAnyFirmExtPlantType() {
	return anyFirmExtPlantType;
}
public void setAnyFirmExtPlantType(String anyFirmExtPlantType) {
	this.anyFirmExtPlantType = anyFirmExtPlantType;
}
public String getAnyFirmExtPlantCap() {
	return anyFirmExtPlantCap;
}
public void setAnyFirmExtPlantCap(String anyFirmExtPlantCap) {
	this.anyFirmExtPlantCap = anyFirmExtPlantCap;
}
public String getAnyCoporate() {
	return anyCoporate;
}
public void setAnyCoporate(String anyCoporate) {
	this.anyCoporate = anyCoporate;
}
public String getAnyCoporateName() {
	return anyCoporateName;
}
public void setAnyCoporateName(String anyCoporateName) {
	this.anyCoporateName = anyCoporateName;
}
public String getPhaseImpl() {
	return phaseImpl;
}
public void setPhaseImpl(String phaseImpl) {
	this.phaseImpl = phaseImpl;
}










}
