package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class HabitationNewEntry_Form extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6339340586765257114L;

	private String safeLpd;
	private String sourceType;

	private String panchayat;

	private String divisionCode;
	private String circleCode;
	private String subDivisionCode;
	private String mandalCode;
	private String mode;
	private String circleName;
	private String divisionName;
	private String subDivisionsNames;
	private String subDivisionName;
	private String subDivisionOffice;
	private String mandalOfficeNames;
	private String mandalName;
	private String habCode;
	private String habName;
	private String habitationCode;
	private ArrayList<RwsHPRecord> habs;
	private ArrayList<RwsHPRecord> assethabs;
	private String isSaved;
	private String habitationsBy;
	private String flouride;
	private String brakish;
	private String iron;
	private String nitrate;
	private String updated;

	private String nitrateMax;
	private String flourideMax;
	private String brakishMax;
	private String ironMax;

	private String nitrateMin;
	private String flourideMin;
	private String brakishMin;
	private String ironMin;
	private String date;
	private String testdate;
	private String repairdate;
	private String repairdesc;
	private String recordStatus;

	private String sourcedetails;
	private String summerDpth;
	private String staticDpth;
	private String assetType;
	private String assetTypeCode;
	private String pcode;
	private String pname;
	private String villageCode;
	private String villageName;
	private String astCompCode;
	private String astCompName;
	
	
	
    public String getSummerDpth() {
		return summerDpth;
	}

	public void setSummerDpth(String summerDpth) {
		this.summerDpth = summerDpth;
	}

	public String getStaticDpth() {
		return staticDpth;
	}

	public void setStaticDpth(String staticDpth) {
		this.staticDpth = staticDpth;
	}

	private String typeofassetname;
    private String startyear;
    private String endyear;
    private String schemecode;
    private String assetStatusName;
    private String panchName;
    private String villName;
    private String habitation;
    private String coveragestatus;
    private String safelpcd;
    private String unsafelpcd;
    private String panchname;
    private String sourceCode;
    private String sourceName;
    private String platformexistng;
    private String SOAKPIT;
    
	
	
	public String getPlatformexistng() {
		return platformexistng;
	}

	public void setPlatformexistng(String platformexistng) {
		this.platformexistng = platformexistng;
	}

	public String getSOAKPIT() {
		return SOAKPIT;
	}

	public void setSOAKPIT(String sOAKPIT) {
		SOAKPIT = sOAKPIT;
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

	public String getTypeofassetname() {
		return typeofassetname;
	}

	public void setTypeofassetname(String typeofassetname) {
		this.typeofassetname = typeofassetname;
	}

	public String getStartyear() {
		return startyear;
	}

	public void setStartyear(String startyear) {
		this.startyear = startyear;
	}

	public String getEndyear() {
		return endyear;
	}

	public void setEndyear(String endyear) {
		this.endyear = endyear;
	}

	public String getSchemecode() {
		return schemecode;
	}

	public void setSchemecode(String schemecode) {
		this.schemecode = schemecode;
	}

	public String getAssetStatusName() {
		return assetStatusName;
	}

	public void setAssetStatusName(String assetStatusName) {
		this.assetStatusName = assetStatusName;
	}

	public String getPanchName() {
		return panchName;
	}

	public void setPanchName(String panchName) {
		this.panchName = panchName;
	}

	public String getVillName() {
		return villName;
	}

	public void setVillName(String villName) {
		this.villName = villName;
	}

	public String getHabitation() {
		return habitation;
	}

	public void setHabitation(String habitation) {
		this.habitation = habitation;
	}

	public String getCoveragestatus() {
		return coveragestatus;
	}

	public void setCoveragestatus(String coveragestatus) {
		this.coveragestatus = coveragestatus;
	}

	public String getSafelpcd() {
		return safelpcd;
	}

	public void setSafelpcd(String safelpcd) {
		this.safelpcd = safelpcd;
	}

	public String getUnsafelpcd() {
		return unsafelpcd;
	}

	public void setUnsafelpcd(String unsafelpcd) {
		this.unsafelpcd = unsafelpcd;
	}

	public String getPanchname() {
		return panchname;
	}

	public void setPanchname(String panchname) {
		this.panchname = panchname;
	}

	public String getPanchayat() {
		return panchayat;
	}

	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}

	@Override
	public void reset(ActionMapping mapping, HttpServletRequest request) {

		super.reset(mapping, request);

	}

	public String getNitrateMin() {
		return nitrateMin;
	}

	public void setNitrateMin(String nitrateMin) {
		this.nitrateMin = nitrateMin;
	}

	public String getFlourideMin() {
		return flourideMin;
	}

	public void setFlourideMin(String flourideMin) {
		this.flourideMin = flourideMin;
	}

	public String getBrakishMin() {
		return brakishMin;
	}

	public void setBrakishMin(String brakishMin) {
		this.brakishMin = brakishMin;
	}

	public String getIronMin() {
		return ironMin;
	}

	public void setIronMin(String ironMin) {
		this.ironMin = ironMin;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getCircleCode() {
		return circleCode;
	}

	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}

	public String getSubDivisionCode() {
		return subDivisionCode;
	}

	public void setSubDivisionCode(String subDivisionCode) {
		this.subDivisionCode = subDivisionCode;
	}

	public String getMandalCode() {
		return mandalCode;
	}

	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
	}

	public String getMode() {
		return mode;
	}

	public void setMode(String mode) {
		this.mode = mode;
	}

	public String getCircleName() {
		return circleName;
	}

	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}

	public String getDivisionName() {
		return divisionName;
	}

	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}

	public String getSubDivisionsNames() {
		return subDivisionsNames;
	}

	public void setSubDivisionsNames(String subDivisionsNames) {
		this.subDivisionsNames = subDivisionsNames;
	}

	public String getSubDivisionName() {
		return subDivisionName;
	}

	public void setSubDivisionName(String subDivisionName) {
		this.subDivisionName = subDivisionName;
	}

	public String getSubDivisionOffice() {
		return subDivisionOffice;
	}

	public void setSubDivisionOffice(String subDivisionOffice) {
		this.subDivisionOffice = subDivisionOffice;
	}

	public String getMandalOfficeNames() {
		return mandalOfficeNames;
	}

	public void setMandalOfficeNames(String mandalOfficeNames) {
		this.mandalOfficeNames = mandalOfficeNames;
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

	public String getHabitationCode() {
		return habitationCode;
	}

	public void setHabitationCode(String habitationCode) {
		this.habitationCode = habitationCode;
	}

	public ArrayList<RwsHPRecord> getHabs() {
		return habs;
	}

	public void setHabs(ArrayList<RwsHPRecord> habs) {
		this.habs = habs;
	}

	public String getIsSaved() {
		return isSaved;
	}

	public void setIsSaved(String isSaved) {
		this.isSaved = isSaved;
	}

	public String getHabitationsBy() {
		return habitationsBy;
	}

	public void setHabitationsBy(String habitationsBy) {
		this.habitationsBy = habitationsBy;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getFlouride() {
		return flouride;
	}

	public void setFlouride(String flouride) {
		this.flouride = flouride;
	}

	public String getBrakish() {
		return brakish;
	}

	public void setBrakish(String brakish) {
		this.brakish = brakish;
	}

	public String getIron() {
		return iron;
	}

	public void setIron(String iron) {
		this.iron = iron;
	}

	public String getNitrate() {
		return nitrate;
	}

	public void setNitrate(String nitrate) {
		this.nitrate = nitrate;
	}

	public String getNitrateMax() {
		return nitrateMax;
	}

	public void setNitrateMax(String nitrateMax) {
		this.nitrateMax = nitrateMax;
	}

	public String getFlourideMax() {
		return flourideMax;
	}

	public void setFlourideMax(String flourideMax) {
		this.flourideMax = flourideMax;
	}

	public String getBrakishMax() {
		return brakishMax;
	}

	public void setBrakishMax(String brakishMax) {
		this.brakishMax = brakishMax;
	}

	public String getIronMax() {
		return ironMax;
	}

	public void setIronMax(String ironMax) {
		this.ironMax = ironMax;
	}

	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}

	public String getSourceType() {
		return sourceType;
	}

	public void setUpdated(String updated) {
		this.updated = updated;
	}

	public String getUpdated() {
		return updated;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getDate() {
		return date;
	}

	public void setTestdate(String testdate) {
		this.testdate = testdate;
	}

	public String getTestdate() {
		return testdate;
	}

	public void setSafeLpd(String safeLpd) {
		this.safeLpd = safeLpd;
	}

	public String getSafeLpd() {
		return safeLpd;
	}

	public void setRepairdate(String repairdate) {
		this.repairdate = repairdate;
	}

	public String getRepairdate() {
		return repairdate;
	}

	public void setRepairdesc(String repairdesc) {
		this.repairdesc = repairdesc;
	}

	public String getRepairdesc() {
		return repairdesc;
	}

	public void setRecordStatus(String recordStatus) {
		this.recordStatus = recordStatus;
	}

	public String getRecordStatus() {
		return recordStatus;
	}

	public void setSourcedetails(String sourcedetails) {
		this.sourcedetails = sourcedetails;
	}

	public String getSourcedetails() {
		return sourcedetails;
	}

	public void setAssethabs(ArrayList<RwsHPRecord> assethabs) {
		this.assethabs = assethabs;
	}

	public ArrayList<RwsHPRecord> getAssethabs() {
		return assethabs;
	}

	public String getAssetType() {
		return assetType;
	}

	public void setAssetType(String assetType) {
		this.assetType = assetType;
	}

	public String getAssetTypeCode() {
		return assetTypeCode;
	}

	public void setAssetTypeCode(String assetTypeCode) {
		this.assetTypeCode = assetTypeCode;
	}

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
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

	public String getAstCompCode() {
		return astCompCode;
	}

	public void setAstCompCode(String astCompCode) {
		this.astCompCode = astCompCode;
	}

	public String getAstCompName() {
		return astCompName;
	}

	public void setAstCompName(String astCompName) {
		this.astCompName = astCompName;
	}



}
