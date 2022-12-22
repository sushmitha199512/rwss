/*
 * Created on 10-Jan-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * @author sadiq
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class DroughtBean implements Serializable
{

	private String dassetCode;
    private String dassetName;
    private String dtypeofAssetcode;
    private String dlocationd;
    private String ddateCreationd;
    private String dassetStatus;
    private String dassetCost;
    private String dstartYear;
    private String transportSource;
    private String startDate;
    private String noofTankers;
    private String capacity;
    private String noofTrips;
    private ArrayList details;
    private String dist;
    private String mand;
    private String trnooftrips;
    public String getTrnooftrips() {
		return trnooftrips;
	}
	public void setTrnooftrips(String trnooftrips) {
		this.trnooftrips = trnooftrips;
	}
	public String getCathabs() {
		return cathabs;
	}
	public void setCathabs(String cathabs) {
		this.cathabs = cathabs;
	}
	public String getCatpopserv() {
		return catpopserv;
	}
	public void setCatpopserv(String catpopserv) {
		this.catpopserv = catpopserv;
	}
	public String getCatnooftrips() {
		return catnooftrips;
	}
	public void setCatnooftrips(String catnooftrips) {
		this.catnooftrips = catnooftrips;
	}
	public String getCatqty() {
		return catqty;
	}
	public void setCatqty(String catqty) {
		this.catqty = catqty;
	}
	private String cathabs;
    
    private String catpopserv;
    private String catnooftrips;
    private String catqty;
    
    
    
    private String habCode;

	private String habName;
	
	private String powerCumalativeExpenditure;
	private String tankerQuantity;
	
	private String checks;
	/////Added by srilaxmi on 25/02/2012
	private String scarcityCode;
    private String scarcityName;
	

//  Added for sstank
    private String shabCode;
	private String shabName;
	private String assetCode;
	private String ssscCode;
	private String spopServed;
	private String sschemeName;
	
	private String shabsCovered;
	private boolean isUpdate;
	private String finYear;
	private ArrayList dryears;
	private String habCount;
	private ArrayList assetsources;
	private String sdrDate;
	private String sdroughtDate;
	private String stakenReasons;
	private String sidentifiedReasons;
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
	private ArrayList years;
    
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
	public boolean isUpdate() {
		return isUpdate;
	}
	public void setUpdate(boolean isUpdate) {
		this.isUpdate = isUpdate;
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
	/**
	 * @return Returns the tankerQuantity.
	 */
	public String getTankerQuantity() {
		return tankerQuantity;
	}
	/**
	 * @param tankerQuantity The tankerQuantity to set.
	 */
	public void setTankerQuantity(String tankerQuantity) {
		this.tankerQuantity = tankerQuantity;
	}
	/**
	 * @return Returns the powerCumalativeExpenditure.
	 */
	public String getPowerCumalativeExpenditure() {
		return powerCumalativeExpenditure;
	}
	/**
	 * @param powerCumalativeExpenditure The powerCumalativeExpenditure to set.
	 */
	public void setPowerCumalativeExpenditure(String powerCumalativeExpenditure) {
		this.powerCumalativeExpenditure = powerCumalativeExpenditure;
	}
	/**
	 * @return Returns the habCode.
	 */
	public String getHabCode() {
		return habCode;
	}
	/**
	 * @param habCode The habCode to set.
	 */
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	/**
	 * @return Returns the habName.
	 */
	public String getHabName() {
		return habName;
	}
	/**
	 * @param habName The habName to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
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
    //
    private String thabitationCode;
    private String dateofEntry;
    private String populationServed;
    private String transporttankerNo;
    private String transportQty;
    private String transportRemarks;
    private String pvtsourceshiredNo;
    private String pvtsourcesQty;
    private String pvtsourcesRemarks;
    private String powersupplyregIrreg;
    private String powersupplylowVoltage;
    private String powersupplyRemarks;
    private String tdistrict;
    private String tmandal;
    private String tdivision;
    private String tsubDivision;
    private String thabName;
    private ArrayList transportdetails;
    private ArrayList habs; 
	
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
	 * @return Returns the capacity.
	 */
	public String getCapacity() {
		return capacity;
	}
	/**
	 * @param capacity The capacity to set.
	 */
	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}
	/**
	 * @return Returns the dassetCode.
	 */
	public String getDassetCode() {
		return dassetCode;
	}
	/**
	 * @param dassetCode The dassetCode to set.
	 */
	public void setDassetCode(String dassetCode) {
		this.dassetCode = dassetCode;
	}
	/**
	 * @return Returns the dassetCost.
	 */
	public String getDassetCost() {
		return dassetCost;
	}
	/**
	 * @param dassetCost The dassetCost to set.
	 */
	public void setDassetCost(String dassetCost) {
		this.dassetCost = dassetCost;
	}
	/**
	 * @return Returns the dassetName.
	 */
	public String getDassetName() {
		return dassetName;
	}
	/**
	 * @param dassetName The dassetName to set.
	 */
	public void setDassetName(String dassetName) {
		this.dassetName = dassetName;
	}
	/**
	 * @return Returns the dassetStatus.
	 */
	public String getDassetStatus() {
		return dassetStatus;
	}
	/**
	 * @param dassetStatus The dassetStatus to set.
	 */
	public void setDassetStatus(String dassetStatus) {
		this.dassetStatus = dassetStatus;
	}
	/**
	 * @return Returns the dateofEntry.
	 */
	public String getDateofEntry() {
		return dateofEntry;
	}
	/**
	 * @param dateofEntry The dateofEntry to set.
	 */
	public void setDateofEntry(String dateofEntry) {
		this.dateofEntry = dateofEntry;
	}
	/**
	 * @return Returns the ddateCreationd.
	 */
	public String getDdateCreationd() {
		return ddateCreationd;
	}
	/**
	 * @param ddateCreationd The ddateCreationd to set.
	 */
	public void setDdateCreationd(String ddateCreationd) {
		this.ddateCreationd = ddateCreationd;
	}
	/**
	 * @return Returns the details.
	 */
	public ArrayList getDetails() {
		return details;
	}
	/**
	 * @param details The details to set.
	 */
	public void setDetails(ArrayList details) {
		this.details = details;
	}
	/**
	 * @return Returns the dlocationd.
	 */
	public String getDlocationd() {
		return dlocationd;
	}
	/**
	 * @param dlocationd The dlocationd to set.
	 */
	public void setDlocationd(String dlocationd) {
		this.dlocationd = dlocationd;
	}
	/**
	 * @return Returns the dstartYear.
	 */
	public String getDstartYear() {
		return dstartYear;
	}
	/**
	 * @param dstartYear The dstartYear to set.
	 */
	public void setDstartYear(String dstartYear) {
		this.dstartYear = dstartYear;
	}
	/**
	 * @return Returns the dtypeofAssetcode.
	 */
	public String getDtypeofAssetcode() {
		return dtypeofAssetcode;
	}
	/**
	 * @param dtypeofAssetcode The dtypeofAssetcode to set.
	 */
	public void setDtypeofAssetcode(String dtypeofAssetcode) {
		this.dtypeofAssetcode = dtypeofAssetcode;
	}
	/**
	 * @return Returns the noofTankers.
	 */
	public String getNoofTankers() {
		return noofTankers;
	}
	/**
	 * @param noofTankers The noofTankers to set.
	 */
	public void setNoofTankers(String noofTankers) {
		this.noofTankers = noofTankers;
	}
	/**
	 * @return Returns the noofTrips.
	 */
	public String getNoofTrips() {
		return noofTrips;
	}
	/**
	 * @param noofTrips The noofTrips to set.
	 */
	public void setNoofTrips(String noofTrips) {
		this.noofTrips = noofTrips;
	}
	/**
	 * @return Returns the populationServed.
	 */
	public String getPopulationServed() {
		return populationServed;
	}
	/**
	 * @param populationServed The populationServed to set.
	 */
	public void setPopulationServed(String populationServed) {
		this.populationServed = populationServed;
	}
	/**
	 * @return Returns the powersupplylowVoltage.
	 */
	public String getPowersupplylowVoltage() {
		return powersupplylowVoltage;
	}
	/**
	 * @param powersupplylowVoltage The powersupplylowVoltage to set.
	 */
	public void setPowersupplylowVoltage(String powersupplylowVoltage) {
		this.powersupplylowVoltage = powersupplylowVoltage;
	}
	/**
	 * @return Returns the powersupplyregIrreg.
	 */
	public String getPowersupplyregIrreg() {
		return powersupplyregIrreg;
	}
	/**
	 * @param powersupplyregIrreg The powersupplyregIrreg to set.
	 */
	public void setPowersupplyregIrreg(String powersupplyregIrreg) {
		this.powersupplyregIrreg = powersupplyregIrreg;
	}
	/**
	 * @return Returns the powersupplyRemarks.
	 */
	public String getPowersupplyRemarks() {
		return powersupplyRemarks;
	}
	/**
	 * @param powersupplyRemarks The powersupplyRemarks to set.
	 */
	public void setPowersupplyRemarks(String powersupplyRemarks) {
		this.powersupplyRemarks = powersupplyRemarks;
	}
	/**
	 * @return Returns the pvtsourceshiredNo.
	 */
	public String getPvtsourceshiredNo() {
		return pvtsourceshiredNo;
	}
	/**
	 * @param pvtsourceshiredNo The pvtsourceshiredNo to set.
	 */
	public void setPvtsourceshiredNo(String pvtsourceshiredNo) {
		this.pvtsourceshiredNo = pvtsourceshiredNo;
	}
	/**
	 * @return Returns the pvtsourcesQty.
	 */
	public String getPvtsourcesQty() {
		return pvtsourcesQty;
	}
	/**
	 * @param pvtsourcesQty The pvtsourcesQty to set.
	 */
	public void setPvtsourcesQty(String pvtsourcesQty) {
		this.pvtsourcesQty = pvtsourcesQty;
	}
	/**
	 * @return Returns the pvtsourcesRemarks.
	 */
	public String getPvtsourcesRemarks() {
		return pvtsourcesRemarks;
	}
	/**
	 * @param pvtsourcesRemarks The pvtsourcesRemarks to set.
	 */
	public void setPvtsourcesRemarks(String pvtsourcesRemarks) {
		this.pvtsourcesRemarks = pvtsourcesRemarks;
	}
	/**
	 * @return Returns the startDate.
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate The startDate to set.
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return Returns the tdistrict.
	 */
	public String getTdistrict() {
		return tdistrict;
	}
	/**
	 * @param tdistrict The tdistrict to set.
	 */
	public void setTdistrict(String tdistrict) {
		this.tdistrict = tdistrict;
	}
	/**
	 * @return Returns the tdivision.
	 */
	public String getTdivision() {
		return tdivision;
	}
	/**
	 * @param tdivision The tdivision to set.
	 */
	public void setTdivision(String tdivision) {
		this.tdivision = tdivision;
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
	 * @return Returns the tmandal.
	 */
	public String getTmandal() {
		return tmandal;
	}
	/**
	 * @param tmandal The tmandal to set.
	 */
	public void setTmandal(String tmandal) {
		this.tmandal = tmandal;
	}
	/**
	 * @return Returns the transportdetails.
	 */
	public ArrayList getTransportdetails() {
		return transportdetails;
	}
	/**
	 * @param transportdetails The transportdetails to set.
	 */
	public void setTransportdetails(ArrayList transportdetails) {
		this.transportdetails = transportdetails;
	}
	/**
	 * @return Returns the transportQty.
	 */
	public String getTransportQty() {
		return transportQty;
	}
	/**
	 * @param transportQty The transportQty to set.
	 */
	public void setTransportQty(String transportQty) {
		this.transportQty = transportQty;
	}
	/**
	 * @return Returns the transportRemarks.
	 */
	public String getTransportRemarks() {
		return transportRemarks;
	}
	/**
	 * @param transportRemarks The transportRemarks to set.
	 */
	public void setTransportRemarks(String transportRemarks) {
		this.transportRemarks = transportRemarks;
	}
	/**
	 * @return Returns the transportSource.
	 */
	public String getTransportSource() {
		return transportSource;
	}
	/**
	 * @param transportSource The transportSource to set.
	 */
	public void setTransportSource(String transportSource) {
		this.transportSource = transportSource;
	}
	/**
	 * @return Returns the transporttankerNo.
	 */
	public String getTransporttankerNo() {
		return transporttankerNo;
	}
	/**
	 * @param transporttankerNo The transporttankerNo to set.
	 */
	public void setTransporttankerNo(String transporttankerNo) {
		this.transporttankerNo = transporttankerNo;
	}
	/**
	 * @return Returns the tsubDivision.
	 */
	public String getTsubDivision() {
		return tsubDivision;
	}
	/**
	 * @param tsubDivision The tsubDivision to set.
	 */
	public void setTsubDivision(String tsubDivision) {
		this.tsubDivision = tsubDivision;
	}
	/**
	 * @return Returns the checks.
	 */
	public String getChecks() {
		return checks;
	}
	/**
	 * @param checks The checks to set.
	 */
	public void setChecks(String checks) {
		this.checks = checks;
	}
////////////added by jyothi for drought daily abstract entry-4-1-2013///////////////////////////////
	
	
	
	
	private String trhabs;
	private String trpopserv;
	private String trqty;
	private String hshabs;
	private String hssour;
	private String hspopserv;
	private String powhabs;
	private int tothabs;
	private ArrayList abs;
	private String absDate;
	public ArrayList getAbs() {
		return abs;
	}
	public void setAbs(ArrayList abs) {
		this.abs = abs;
	}
	public String getAbsDate() {
		return absDate;
	}
	public void setAbsDate(String absDate) {
		this.absDate = absDate;
	}
	public String getHshabs() {
		return hshabs;
	}
	public void setHshabs(String hshabs) {
		this.hshabs = hshabs;
	}
	public String getHspopserv() {
		return hspopserv;
	}
	public void setHspopserv(String hspopserv) {
		this.hspopserv = hspopserv;
	}
	public String getHssour() {
		return hssour;
	}
	public void setHssour(String hssour) {
		this.hssour = hssour;
	}
	public String getPowhabs() {
		return powhabs;
	}
	public void setPowhabs(String powhabs) {
		this.powhabs = powhabs;
	}
	public int getTothabs() {
		return tothabs;
	}
	public void setTothabs(int tothabs) {
		this.tothabs = tothabs;
	}
public String getTrhabs() {
	return trhabs;
}
public void setTrhabs(String trhabs) {
	this.trhabs = trhabs;
}
	public String getTrpopserv() {
		return trpopserv;
	}
	public void setTrpopserv(String trpopserv) {
		this.trpopserv = trpopserv;
	}
	public String getTrqty() {
		return trqty;
	}
	public void setTrqty(String trqty) {
		this.trqty = trqty;
	}
	public ArrayList getYears() {
		return years;
	}
	public void setYears(ArrayList years) {
		this.years = years;
	}
}
