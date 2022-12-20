package nic.watersoft.drought;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class DroughtForm extends ActionForm
{
	private String dist;
	private String mand;
	private String panchayath;
	private String year;
	private String  thabitationCode;
	private String thabName;
	//Added by srilaxmi on 25/02/2012
	private String scarcityCode;
    private String scarcityName;
    //Added by srilaxmi 14/03/2012
    private String vill;
    private String panch;
    private String habCode;
    private String habName;
    private String districtName;
    private String mandalName;
    private String panchayatName;
    private String villageName;
    private String flushDate;
    private String flushRemarks;
    private String flushDeepening;
    private String hpCode;
    private ArrayList hps;
    private String flushDepth;
    private boolean isUpdate;
    
    private String droughtYear;
    
    private String status;
    private String location;
    private String conFlush;
    private String conDeep;
    private String droughtMandal;
    private ArrayList schemes=new ArrayList();
    
    
	/**
	 * @return Returns the schemes.
	 */
	public ArrayList getSchemes() {
		return schemes;
	}
	/**
	 * @param schemes The schemes to set.
	 */
	public void setSchemes(ArrayList schemes) {
		this.schemes = schemes;
	}
	/**
	 * @return Returns the droughtMandal.
	 */
	public String getDroughtMandal() {
		return droughtMandal;
	}
	/**
	 * @param droughtMandal The droughtMandal to set.
	 */
	public void setDroughtMandal(String droughtMandal) {
		this.droughtMandal = droughtMandal;
	}
//  ADDEd by jyothi for drought sstank  form 
	private String dryear;
	/**
	 * @return Returns the droughtYear.
	 */
	public String getDroughtYear() {
		
		return droughtYear;
		
	}
	/**
	 * @param droughtYear The droughtYear to set.
	 */
	public void setDroughtYear(String droughtYear) {
		this.droughtYear = droughtYear;
	}
	private String dhabCode;
	
	
	private String shabCode;
	private String shabName;
	private String assetCode;
	private String ssscCode;
	private String spopServed;
	private String sschemeName;
	
	private String shabsCovered;

	private String sriverVaguName;
	private String scanalName;
	private String stankCapacity;
	private String swaterSupplyDays;
	private String stankNo;
	private String sfillingStatus;
	private String sfillDate;
	private String scanalPrbDate;
	private String sreopenPrbData;
	private String sstepsTaken;
	private String sidentifiedAlternative;
	private String stankRemarks;
	private String finYear;
	private ArrayList dryears;
	private String habCount;
	private ArrayList assetsources;
	private String sdrDate;
	private String sdroughtDate;
	private String stakenReasons;
	private String sidentifiedReasons;
	
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	public ArrayList getAssetsources() {
		return assetsources;
	}
	public void setAssetsources(ArrayList assetsources) {
		this.assetsources = assetsources;
	}
	public String getDhabCode() {
		return dhabCode;
	}
	public void setDhabCode(String dhabCode) {
		this.dhabCode = dhabCode;
	}
public String getDryear() {
	return dryear;
}
public void setDryear(String dryear) {
	this.dryear = dryear;
}
	public ArrayList getDryears() {
		return dryears;
	}
	public void setDryears(ArrayList dryears) {
		this.dryears = dryears;
	}
	public String getFinYear() {
		return finYear;
	}
	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}
	public String getHabCount() {
		return habCount;
	}
	public void setHabCount(String habCount) {
		this.habCount = habCount;
	}
	public String getScanalName() {
		return scanalName;
	}
	public void setScanalName(String scanalName) {
		this.scanalName = scanalName;
	}
	public String getScanalPrbDate() {
		return scanalPrbDate;
	}
	public void setScanalPrbDate(String scanalPrbDate) {
		this.scanalPrbDate = scanalPrbDate;
	}
	public String getSdrDate() {
		return sdrDate;
	}
	public void setSdrDate(String sdrDate) {
		this.sdrDate = sdrDate;
	}
	public String getSdroughtDate() {
		return sdroughtDate;
	}
	public void setSdroughtDate(String sdroughtDate) {
		this.sdroughtDate = sdroughtDate;
	}
	public String getSfillDate() {
		return sfillDate;
	}
	public void setSfillDate(String sfillDate) {
		this.sfillDate = sfillDate;
	}
	public String getSfillingStatus() {
		return sfillingStatus;
	}
	public void setSfillingStatus(String sfillingStatus) {
		this.sfillingStatus = sfillingStatus;
	}
	public String getShabCode() {
		return shabCode;
	}
	public void setShabCode(String shabCode) {
		this.shabCode = shabCode;
	}
	public String getShabName() {
		return shabName;
	}
	public void setShabName(String shabName) {
		this.shabName = shabName;
	}
	public String getShabsCovered() {
		return shabsCovered;
	}
	public void setShabsCovered(String shabsCovered) {
		this.shabsCovered = shabsCovered;
	}
	public String getSidentifiedAlternative() {
		return sidentifiedAlternative;
	}
	public void setSidentifiedAlternative(String sidentifiedAlternative) {
		this.sidentifiedAlternative = sidentifiedAlternative;
	}
	public String getSidentifiedReasons() {
		return sidentifiedReasons;
	}
	public void setSidentifiedReasons(String sidentifiedReasons) {
		this.sidentifiedReasons = sidentifiedReasons;
	}
	public String getSpopServed() {
		return spopServed;
	}
	public void setSpopServed(String spopServed) {
		this.spopServed = spopServed;
	}
	public String getSreopenPrbData() {
		return sreopenPrbData;
	}
	public void setSreopenPrbData(String sreopenPrbData) {
		this.sreopenPrbData = sreopenPrbData;
	}
	public String getSriverVaguName() {
		return sriverVaguName;
	}
	public void setSriverVaguName(String sriverVaguName) {
		this.sriverVaguName = sriverVaguName;
	}
	public String getSschemeName() {
		return sschemeName;
	}
	public void setSschemeName(String sschemeName) {
		this.sschemeName = sschemeName;
	}
	public String getSsscCode() {
		return ssscCode;
	}
	public void setSsscCode(String ssscCode) {
		this.ssscCode = ssscCode;
	}
	public String getSstepsTaken() {
		return sstepsTaken;
	}
	public void setSstepsTaken(String sstepsTaken) {
		this.sstepsTaken = sstepsTaken;
	}
	public String getStakenReasons() {
		return stakenReasons;
	}
	public void setStakenReasons(String stakenReasons) {
		this.stakenReasons = stakenReasons;
	}
	public String getStankCapacity() {
		return stankCapacity;
	}
	public void setStankCapacity(String stankCapacity) {
		this.stankCapacity = stankCapacity;
	}
	public String getStankNo() {
		return stankNo;
	}
	public void setStankNo(String stankNo) {
		this.stankNo = stankNo;
	}
	public String getStankRemarks() {
		return stankRemarks;
	}
	public void setStankRemarks(String stankRemarks) {
		this.stankRemarks = stankRemarks;
	}
	public String getSwaterSupplyDays() {
		return swaterSupplyDays;
	}
	public void setSwaterSupplyDays(String swaterSupplyDays) {
		this.swaterSupplyDays = swaterSupplyDays;
	}
	public String getConDeep() {
		return conDeep;
	}
	public void setConDeep(String conDeep) {
		this.conDeep = conDeep;
	}
	public String getConFlush() {
		return conFlush;
	}
	public void setConFlush(String conFlush) {
		this.conFlush = conFlush;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getScarcityCode() {
		return scarcityCode;
	}
	public void setScarcityCode(String scarcityCode) {
		this.scarcityCode = scarcityCode;
	}
	public String getScarcityName() {
		return scarcityName;
	}
	public void setScarcityName(String scarcityName) {
		this.scarcityName = scarcityName;
	}
//	Added by srilaxmi on 25/02/2012
	
	//Added by Sai Prasad N
	private String causeOfScarcity;
	private String transportation;
	private String hiringOfSources;
	private String powerProblem;
	private String flushing;
	private String deepening;
	private String toDate;
	private String frmDate;
	private String transportationEST;
	private String hiringOfSourcesEST;
	private String powerProblemEST;
	private String flushingEST;
	private String deepeningEST;
	private String typeOfWork;
	private String workESTCOST;
	private String remarks;
	
	private String deepenOwNum;
	private String deepenOwEst;
	private String sstNum;
	private String sstEst;
	private String sstScheme;
	
	/**
	 * @return Returns the deepenOwEst.
	 */
	public String getDeepenOwEst() {
		return deepenOwEst;
	}
	/**
	 * @param deepenOwEst The deepenOwEst to set.
	 */
	public void setDeepenOwEst(String deepenOwEst) {
		this.deepenOwEst = deepenOwEst;
	}
	/**
	 * @return Returns the deepenOwNum.
	 */
	public String getDeepenOwNum() {
		return deepenOwNum;
	}
	/**
	 * @param deepenOwNum The deepenOwNum to set.
	 */
	public void setDeepenOwNum(String deepenOwNum) {
		this.deepenOwNum = deepenOwNum;
	}
	/**
	 * @return Returns the sstEst.
	 */
	public String getSstEst() {
		return sstEst;
	}
	/**
	 * @param sstEst The sstEst to set.
	 */
	public void setSstEst(String sstEst) {
		this.sstEst = sstEst;
	}
	/**
	 * @return Returns the sstNum.
	 */
	public String getSstNum() {
		return sstNum;
	}
	/**
	 * @param sstNum The sstNum to set.
	 */
	public void setSstNum(String sstNum) {
		this.sstNum = sstNum;
	}
	/**
	 * @return Returns the sstScheme.
	 */
	public String getSstScheme() {
		return sstScheme;
	}
	/**
	 * @param sstScheme The sstScheme to set.
	 */
	public void setSstScheme(String sstScheme) {
		this.sstScheme = sstScheme;
	}

	
	
	
	//******************************
	
	private ArrayList habs;
	private String mode;
	private String checks;
	private String alreadyExists;
	private ArrayList thabs;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * @return Returns the causeOfScarcity.
	 */
	public String getCauseOfScarcity() {
		return causeOfScarcity;
	}
	/**
	 * @param causeOfScarcity The causeOfScarcity to set.
	 */
	public void setCauseOfScarcity(String causeOfScarcity) {
		this.causeOfScarcity = causeOfScarcity;
	}
	/**
	 * @return Returns the deepening.
	 */
	public String getDeepening() {
		return deepening;
	}
	/**
	 * @param deepening The deepening to set.
	 */
	public void setDeepening(String deepening) {
		this.deepening = deepening;
	}
	/**
	 * @return Returns the deepeningEST.
	 */
	public String getDeepeningEST() {
		return deepeningEST;
	}
	/**
	 * @param deepeningEST The deepeningEST to set.
	 */
	public void setDeepeningEST(String deepeningEST) {
		this.deepeningEST = deepeningEST;
	}
	/**
	 * @return Returns the flushing.
	 */
	public String getFlushing() {
		return flushing;
	}
	/**
	 * @param flushing The flushing to set.
	 */
	public void setFlushing(String flushing) {
		this.flushing = flushing;
	}
	/**
	 * @return Returns the flushingEST.
	 */
	public String getFlushingEST() {
		return flushingEST;
	}
	/**
	 * @param flushingEST The flushingEST to set.
	 */
	public void setFlushingEST(String flushingEST) {
		this.flushingEST = flushingEST;
	}
	/**
	 * @return Returns the hiringOfSources.
	 */
	public String getHiringOfSources() {
		return hiringOfSources;
	}
	/**
	 * @param hiringOfSources The hiringOfSources to set.
	 */
	public void setHiringOfSources(String hiringOfSources) {
		this.hiringOfSources = hiringOfSources;
	}
	/**
	 * @return Returns the hiringOfSourcesEST.
	 */
	public String getHiringOfSourcesEST() {
		return hiringOfSourcesEST;
	}
	/**
	 * @param hiringOfSourcesEST The hiringOfSourcesEST to set.
	 */
	public void setHiringOfSourcesEST(String hiringOfSourcesEST) {
		this.hiringOfSourcesEST = hiringOfSourcesEST;
	}
	/**
	 * @return Returns the powerProblem.
	 */
	public String getPowerProblem() {
		return powerProblem;
	}
	/**
	 * @param powerProblem The powerProblem to set.
	 */
	public void setPowerProblem(String powerProblem) {
		this.powerProblem = powerProblem;
	}
	/**
	 * @return Returns the powerProblemEST.
	 */
	public String getPowerProblemEST() {
		return powerProblemEST;
	}
	/**
	 * @param powerProblemEST The powerProblemEST to set.
	 */
	public void setPowerProblemEST(String powerProblemEST) {
		this.powerProblemEST = powerProblemEST;
	}
	/**
	 * @return Returns the remarks.
	 */
	public String getRemarks() {
		return remarks;
	}
	/**
	 * @param remarks The remarks to set.
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	/**
	 * @return Returns the transportation.
	 */
	public String getTransportation() {
		return transportation;
	}
	/**
	 * @param transportation The transportation to set.
	 */
	public void setTransportation(String transportation) {
		this.transportation = transportation;
	}
	/**
	 * @return Returns the transportationEST.
	 */
	public String getTransportationEST() {
		return transportationEST;
	}
	/**
	 * @param transportationEST The transportationEST to set.
	 */
	public void setTransportationEST(String transportationEST) {
		this.transportationEST = transportationEST;
	}
	/**
	 * @return Returns the typeOfWork.
	 */
	public String getTypeOfWork() {
		return typeOfWork;
	}
	/**
	 * @param typeOfWork The typeOfWork to set.
	 */
	public void setTypeOfWork(String typeOfWork) {
		this.typeOfWork = typeOfWork;
	}
	/**
	 * @return Returns the workESTCOST.
	 */
	public String getWorkESTCOST() {
		return workESTCOST;
	}
	/**
	 * @param workESTCOST The workESTCOST to set.
	 */
	public void setWorkESTCOST(String workESTCOST) {
		this.workESTCOST = workESTCOST;
	}
	// Added on 10022012
	
	
	/**
	 * @return Returns the frmDate.
	 */
	public String getFrmDate() {
		return frmDate;
	}
	/**
	 * @param frmDate The frmDate to set.
	 */
	public void setFrmDate(String frmDate) {
		this.frmDate = frmDate;
	}
	/**
	 * @return Returns the toDate.
	 */
	public String getToDate() {
		return toDate;
	}
	/**
	 * @param toDate The toDate to set.
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
		
	
    private String droughtStatus;
    private ArrayList categories;
	
	
	/**
	 * @return Returns the droughtStatus.
	 */
	public String getDroughtStatus() {
		return droughtStatus;
	}
	/**
	 * @param droughtStatus The droughtStatus to set.
	 */
	public void setDroughtStatus(String droughtStatus) {
		this.droughtStatus = droughtStatus;
	}

	
	/**
	 * @return Returns the year.
	 */
	public String getYear() {
		return year;
	}
	/**
	 * @param year The year to set.
	 */
	public void setYear(String year) {
		this.year = year;
	}
	/**
	 * @return Returns the thabs.
	 */
	public ArrayList getThabs() {
		return thabs;
	}
	/**
	 * @param thabs The thabs to set.
	 */
	public void setThabs(ArrayList thabs) {
		this.thabs = thabs;
	}
	/**
	 * @return Returns the alreadyExists.
	 */
	public String getAlreadyExists() {
		return alreadyExists;
	}
	/**
	 * @param alreadyExists The alreadyExists to set.
	 */
	public void setAlreadyExists(String alreadyExists) {
		this.alreadyExists = alreadyExists;
	}
	public String getChecks() {
		return checks;
	}
	/**
	 * @param checks The checks to set.
	 */
	public void setChecks(String checks) {
		this.checks = checks;
	}
	/**
	 * @return Returns the dist.
	 */
	public String getDist() {
		return dist;
	}
	/**
	 * @param dist The dist to set.
	 */
	public void setDist(String dist) {
		this.dist = dist;
	}
	/**
	 * @return Returns the habs.
	 */
	public ArrayList getHabs() {
		return habs;
	}
	/**
	 * @param habs The habs to set.
	 */
	public void setHabs(ArrayList habs) {
		this.habs = habs;
	}
	/**
	 * @return Returns the mand.
	 */
	public String getMand() {
		return mand;
	}
	/**
	 * @param mand The mand to set.
	 */
	public void setMand(String mand) {
		this.mand = mand;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}
	/**
	 * @return Returns the thabitationCode.
	 */
	public String getThabitationCode() {
		return thabitationCode;
	}
	/**
	 * @param thabitationCode The thabitationCode to set.
	 */
	public void setThabitationCode(String thabitationCode) {
		this.thabitationCode = thabitationCode;
	}
	/**
	 * @return Returns the thabName.
	 */
	public String getThabName() {
		return thabName;
	}
	/**
	 * @param thabName The thabName to set.
	 */
	public void setThabName(String thabName) {
		this.thabName = thabName;
	}
	/**
	 * @return Returns the categories.
	 */
	public ArrayList getCategories() {
		return categories;
	}
	/**
	 * @param categories The categories to set.
	 */
	public void setCategories(ArrayList categories) {
		this.categories = categories;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getFlushDate() {
		return flushDate;
	}
	public void setFlushDate(String flushDate) {
		this.flushDate = flushDate;
	}
	public String getFlushDeepening() {
		return flushDeepening;
	}
	public void setFlushDeepening(String flushDeepening) {
		this.flushDeepening = flushDeepening;
	}
	public String getFlushDepth() {
		return flushDepth;
	}
	public void setFlushDepth(String flushDepth) {
		this.flushDepth = flushDepth;
	}
	public String getFlushRemarks() {
		return flushRemarks;
	}
	public void setFlushRemarks(String flushRemarks) {
		this.flushRemarks = flushRemarks;
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
	public String getHpCode() {
		return hpCode;
	}
	public void setHpCode(String hpCode) {
		this.hpCode = hpCode;
	}
	public ArrayList getHps() {
		return hps;
	}
	public void setHps(ArrayList hps) {
		this.hps = hps;
	}
	public boolean isUpdate() {
		return isUpdate;
	}
	public void setUpdate(boolean isUpdate) {
		this.isUpdate = isUpdate;
	}
	public String getMandalName() {
		return mandalName;
	}
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	public String getPanch() {
		return panch;
	}
	public void setPanch(String panch) {
		this.panch = panch;
	}
	public String getPanchayatName() {
		return panchayatName;
	}
	public void setPanchayatName(String panchayatName) {
		this.panchayatName = panchayatName;
	}
	public String getVill() {
		return vill;
	}
	public void setVill(String vill) {
		this.vill = vill;
	}
	public String getVillageName() {
		return villageName;
	}
	public void setVillageName(String villageName) {
		this.villageName = villageName;
	}
	public void setPanchayath(String panchayath) {
		this.panchayath = panchayath;
	}
	public String getPanchayath() {
		return panchayath;
	}
}
