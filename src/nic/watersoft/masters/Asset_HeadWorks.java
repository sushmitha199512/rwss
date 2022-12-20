package nic.watersoft.masters;

/**
 * @author Administrator
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class Asset_HeadWorks {
//	added by swapna on 18-01-2012 for gis data entry
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
	//
	 
	 private String assetSubCompType;
	 private String assetCode="";
	 private String habCode="";
	 //CPWS-Headworks-SS Tank
	 
	 private String ssTankCode;
	/**
	 * @return Returns the depth.
	 */
	
	 private float ssDepth;
	 private String ssSize;
	 private String ssCapacityDays;
	 private String ssCapacityMcum;
	 private String ssTankAdeq;
	 private String ssTankLocation;
	 private String ssTankYield;
	 private String ssTankYieldDate;
	 private String powerConn;
	 private String powerConnOthers;
	 private String powerHours;
	 
	 
	 // CPWS-Headworks-SS Filters
	 
	 private String wtpCode;
	 private String wtpType;
	 private String wtpMld;
	 private String wtpUnits;
	 private String wtpSize;
	 private String wtpUnitsStandby;
	 private String wtpBackwashFreq;
	 private String wtpPerformance;
	 private String wtpCapacityUse;
	 private String wtpExtentionScope;
	 private String wtpLocation;
	 private float wtpNoOfHoursOfUsage;
	 private double wtpRateOfFiltration;
	 
	 private String wtpChkFilter;
	 private int wtpFreqSandScrap;
	 private int wtpShelter;
	 private String wtpRawWater;
	 private String wtpProductWater;
	 private boolean wtpSedimentationTank;
	 private boolean wtpHorizontalRoughingFilter;
	 private boolean wtpVerticalRoughingFilter;
	 private boolean wtpClarifloculator;
	 private String wtpSedimentationTankValue;
	 private String wtpHorizontalRoughingFilterValue;
	 private String wtpVerticalRoughingFilterValue;
	 private String wtpClarifloculatorValue;
	 
	 //CPWS-Headworks-Sump
	 
	 private String sumpCode;
	 private String sumpType;
	 private String sumpCapacity;
	 private String sumpFillHr;
	 private String sumpEmptyHr;
	 private String sumpCondition;
	 private String sumpLocation;
	 private String sumpMadeOf;
	 private float sumpDiameter;
	 private float sumpDepth;
	 
	 //CPWS-HeadWorks-Raw Water and Clear Water Collection well
	 
	 private String collectionWellCode;
	 private String collectionWellLocation;
	 private String rwDiameter;
	 private String rwDepth;
	 private String rwTypeOfFlooring;
	 private double rwCapacity;
	 private String rwLocation;
	   
	 
	 // CPWS-HeadWorks-Foot Path Bridge
	 
	 private String bridgeCode;
	 private String bridgeType;
	 private String bridgeLength;
	 private String bridgeWidth;
	 private String bridgeWalkwaywidth;
	 private String bridgeSpanLength;
	 private String bridgeLocation;
	 //CPWS-HeadWorks-Pump House
	 
	 //CPWS-HeadWorks-Pump House &&	 PWS-PUMPSETS-Pump House
	 
	 private String pumpHouseType;
	 private String pumpHouseArea;
	 private String pumpHouseHeight;
	 private String pumpHouseCode;
	 private String pumpCond;
	 private String pumpHouseLocation;
	 	 	 
	// CPWS-HeadWorks-WATCHMAN QUARTER
	 
	 private String watchManCode;
	 private String watchManType;
	 private String watchManArea;
	 private String watchManNoOfQuarters;
	 private String watchManLocation;
	 
	 private String pMaterial;
	 private String pClass;
	 private String pDiameter;
	 private String pLength;
		
	 
	 private String aveCansSupplied;
	 
	 
	/**
	 * @param Asset_HeadWorks
	 */
	
	public Asset_HeadWorks() {
		powerConnOthers="";
		wtpSedimentationTankValue="00";
		wtpHorizontalRoughingFilterValue="00";
		wtpVerticalRoughingFilterValue="00";
		wtpClarifloculatorValue="00";
	}
	public Asset_HeadWorks(String assetSubCompType) {
		super();
		wtpSedimentationTankValue="00";
		wtpHorizontalRoughingFilterValue="00";
		wtpVerticalRoughingFilterValue="00";
		wtpClarifloculatorValue="00";
		this.assetSubCompType = assetSubCompType;
	}	  
		
	
	public String getAveCansSupplied() {
		return aveCansSupplied;
	}
	public void setAveCansSupplied(String aveCansSupplied) {
		this.aveCansSupplied = aveCansSupplied;
	}
	/**
	 * @return Returns the assetCode.
	 */
	public String getAssetCode() {
		return assetCode;
	}
	/**
	 * @param assetCode The assetCode to set.
	 */
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	/**
	 * @return Returns the assetSubCompType.
	 */
	public String getAssetSubCompType() {
		return assetSubCompType;
	}
	/**
	 * @param assetSubCompType The assetSubCompType to set.
	 */
	public void setAssetSubCompType(String assetSubCompType) {
		this.assetSubCompType = assetSubCompType;
	}
 
	public String getPowerConn() {
		return powerConn;
	}
	public void setPowerConn(String powerConn) {
		this.powerConn = powerConn;
	}
	public String getPowerHours() {
		return powerHours;
	}
	public void setPowerHours(String powerHours) {
		this.powerHours = powerHours;
	}
	public String getSsCapacityDays() {
		return ssCapacityDays;
	}
	public void setSsCapacityDays(String ssCapacityDays) {
		this.ssCapacityDays = ssCapacityDays;
	}
	public String getSsCapacityMcum() {
		return ssCapacityMcum;
	}
	public void setSsCapacityMcum(String ssCapacityMcum) {
		this.ssCapacityMcum = ssCapacityMcum;
	}
	public String getSsSize() {
		return ssSize;
	}
	public void setSsSize(String ssSize) {
		this.ssSize = ssSize;
	}
	public String getSsTankAdeq() {
		return ssTankAdeq;
	}
	public void setSsTankAdeq(String ssTankAdeq) {
		this.ssTankAdeq = ssTankAdeq;
	}
	public String getSsTankCode() {
		return ssTankCode;
	}
	public void setSsTankCode(String ssTankCode) {
		this.ssTankCode = ssTankCode;
	}
	public String getSsTankLocation() {
		return ssTankLocation;
	}
	public void setSsTankLocation(String ssTankLocation) {
		this.ssTankLocation = ssTankLocation;
	}
	public String getSsTankYield() {
		return ssTankYield;
	}
	public void setSsTankYield(String ssTankYield) {
		this.ssTankYield = ssTankYield;
	}
	public String getSsTankYieldDate() {
		return ssTankYieldDate;
	}
	public void setSsTankYieldDate(String ssTankYieldDate) {
		this.ssTankYieldDate = ssTankYieldDate;
	}
	
	
	
	public String getWtpBackwashFreq() {
		return wtpBackwashFreq;
	}
	public void setWtpBackwashFreq(String wtpBackwashFreq) {
		this.wtpBackwashFreq = wtpBackwashFreq;
	}
	public String getWtpCapacityUse() {
		return wtpCapacityUse;
	}
	public void setWtpCapacityUse(String wtpCapacityUse) {
		this.wtpCapacityUse = wtpCapacityUse;
	}
	public String getWtpCode() {
		return wtpCode;
	}
	public void setWtpCode(String wtpCode) {
		this.wtpCode = wtpCode;
	}
	public String getWtpExtentionScope() {
		return wtpExtentionScope;
	}
	
	public String getWtpChkFilter() {
		return wtpChkFilter;
	}
	
	public void setWtpChkFilter(String wtpChkFilter) {
		this.wtpChkFilter = wtpChkFilter;
	}
	
	
	public int getWtpFreqSandScrap() {
		return wtpFreqSandScrap;
	}
	
	public void setWtpFreqSandScrap(int wtpFreqSandScrap) {
		this.wtpFreqSandScrap = wtpFreqSandScrap;
	}
	
	public String getWtpLocation() {
		return wtpLocation;
	}
	
	public void setWtpLocation(String wtpLocation) {
		this.wtpLocation = wtpLocation;
	}
	
	public float getWtpNoOfHoursOfUsage() {
		return wtpNoOfHoursOfUsage;
	}
	
	public void setWtpNoOfHoursOfUsage(float wtpNoOfHoursOfUsage) {
		this.wtpNoOfHoursOfUsage = wtpNoOfHoursOfUsage;
	}
	
	
	public void setWtpExtentionScope(String wtpExtentionScope) {
		this.wtpExtentionScope = wtpExtentionScope;
	}
	public String getWtpMld() {
		return wtpMld;
	}
	public void setWtpMld(String wtpMld) {
		this.wtpMld = wtpMld;
	}
	public String getWtpPerformance() {
		return wtpPerformance;
	}
	public void setWtpPerformance(String wtpPerformance) {
		this.wtpPerformance = wtpPerformance;
	}
	public String getWtpSize() {
		return wtpSize;
	}
	public void setWtpSize(String wtpSize) {
		this.wtpSize = wtpSize;
	}
	public String getWtpType() {
		return wtpType;
	}
	public void setWtpType(String wtpType) {
		this.wtpType = wtpType;
	}
	public String getWtpUnits() {
		return wtpUnits;
	}
	public void setWtpUnits(String wtpUnits) {
		this.wtpUnits = wtpUnits;
	}
	public String getWtpUnitsStandby() {
		return wtpUnitsStandby;
	}
	public void setWtpUnitsStandby(String wtpUnitsStandby) {
		this.wtpUnitsStandby = wtpUnitsStandby;
	}
	
	
	public String getSumpCapacity() {
		return sumpCapacity;
	}
	public void setSumpCapacity(String sumpCapacity) {
		this.sumpCapacity = sumpCapacity;
	}
	public String getSumpCode() {
		return sumpCode;
	}
	public void setSumpCode(String sumpCode) {
		this.sumpCode = sumpCode;
	}
	public String getSumpCondition() {
		return sumpCondition;
	}
	/**
	 * @return Returns the sumpDepth.
	 */
	public float getSumpDepth() {
		return sumpDepth;
	}
	/**
	 * @param sumpDepth The sumpDepth to set.
	 */
	public void setSumpDepth(float sumpDepth) {
		this.sumpDepth = sumpDepth;
	}
	/**
	 * @return Returns the sumpDiameter.
	 */
	public float getSumpDiameter() {
		return sumpDiameter;
	}
	/**
	 * @param sumpDiameter The sumpDiameter to set.
	 */
	public void setSumpDiameter(float sumpDiameter) {
		this.sumpDiameter = sumpDiameter;
	}
	/**
	 * @return Returns the sumpLocation.
	 */
	public String getSumpLocation() {
		return sumpLocation;
	}
	/**
	 * @param sumpLocation The sumpLocation to set.
	 */
	public void setSumpLocation(String sumpLocation) {
		this.sumpLocation = sumpLocation;
	}
	/**
	 * @return Returns the sumpMadeOf.
	 */
	public String getSumpMadeOf() {
		return sumpMadeOf;
	}
	/**
	 * @param sumpMadeOf The sumpMadeOf to set.
	 */
	public void setSumpMadeOf(String sumpMadeOf) {
		this.sumpMadeOf = sumpMadeOf;
	}
	public void setSumpCondition(String sumpCondition) {
		this.sumpCondition = sumpCondition;
	}
	public String getSumpEmptyHr() {
		return sumpEmptyHr;
	}
	public void setSumpEmptyHr(String sumpEmptyHr) {
		this.sumpEmptyHr = sumpEmptyHr;
	}
	public String getSumpFillHr() {
		return sumpFillHr;
	}
	public void setSumpFillHr(String sumpFillHr) {
		this.sumpFillHr = sumpFillHr;
	}
	public String getSumpType() {
		return sumpType;
	}
	public void setSumpType(String sumpType) {
		this.sumpType = sumpType;
	}
	
	public String getCollectionWellCode() {
		return collectionWellCode;
	}
	public void setCollectionWellCode(String collectionWellCode) {
		this.collectionWellCode = collectionWellCode;
	}
	public String getRwDepth() {
		return rwDepth;
	}
	public void setRwDepth(String rwDepth) {
		this.rwDepth = rwDepth;
	}
	public String getRwDiameter() {
		return rwDiameter;
	}
	public void setRwDiameter(String rwDiameter) {
		this.rwDiameter = rwDiameter;
	}
	public String getRwTypeOfFlooring() {
		return rwTypeOfFlooring;
	}
	public void setRwTypeOfFlooring(String rwTypeOfFlooring) {
		this.rwTypeOfFlooring = rwTypeOfFlooring;
	}
	
	/**
	 * @return Returns the rwCapacity.
	 */
	public double getRwCapacity() {
		return rwCapacity;
	}
	/**
	 * @param rwCapacity The rwCapacity to set.
	 */
	public void setRwCapacity(double rwCapacity) {
		this.rwCapacity = rwCapacity;
	}
	/**
	 * @return Returns the rwLocation.
	 */
	public String getRwLocation() {
		return rwLocation;
	}
	/**
	 * @param rwLocation The rwLocation to set.
	 */
	public void setRwLocation(String rwLocation) {
		this.rwLocation = rwLocation;
	}
	public String getBridgeCode() {
		return bridgeCode;
	}
	public void setBridgeCode(String bridgeCode) {
		this.bridgeCode = bridgeCode;
	}
	public String getBridgeLength() {
		return bridgeLength;
	}
	public void setBridgeLength(String bridgeLength) {
		this.bridgeLength = bridgeLength;
	}
	public String getBridgeSpanLength() {
		return bridgeSpanLength;
	}
	public void setBridgeSpanLength(String bridgeSpanLength) {
		this.bridgeSpanLength = bridgeSpanLength;
	}
	public String getBridgeType() {
		return bridgeType;
	}
	public void setBridgeType(String bridgeType) {
		this.bridgeType = bridgeType;
	}
	public String getBridgeWalkwaywidth() {
		return bridgeWalkwaywidth;
	}
	public void setBridgeWalkwaywidth(String bridgeWalkwaywidth) {
		this.bridgeWalkwaywidth = bridgeWalkwaywidth;
	}
	public String getBridgeWidth() {
		return bridgeWidth;
	}
	public void setBridgeWidth(String bridgeWidth) {
		this.bridgeWidth = bridgeWidth;
	}
	
	
	public String getPumpHouseArea() {
		return pumpHouseArea;
	}
	public void setPumpHouseArea(String pumpHouseArea) {
		this.pumpHouseArea = pumpHouseArea;
	}
	public String getPumpHouseCode() {
		return pumpHouseCode;
	}
	public void setPumpHouseCode(String pumpHouseCode) {
		this.pumpHouseCode = pumpHouseCode;
	}
	public String getPumpHouseHeight() {
		return pumpHouseHeight;
	}
	public void setPumpHouseHeight(String pumpHouseHeight) {
		this.pumpHouseHeight = pumpHouseHeight;
	}
	public String getPumpHouseType() {
		return pumpHouseType;
	}
	
	/**
	 * @return Returns the pumpCond.
	 */
	public String getPumpCond() {
		return pumpCond;
	}
	/**
	 * @param pumpCond The pumpCond to set.
	 */
	public void setPumpCond(String pumpCond) {
		this.pumpCond = pumpCond;
	}
	public void setPumpHouseType(String pumpHouseType) {
		this.pumpHouseType = pumpHouseType;
	}
	
	
	public String getWatchManArea() {
		return watchManArea;
	}
	public void setWatchManArea(String watchManArea) {
		this.watchManArea = watchManArea;
	}
	public String getWatchManCode() {
		return watchManCode;
	}
	public void setWatchManCode(String watchManCode) {
		this.watchManCode = watchManCode;
	}
	public String getWatchManNoOfQuarters() {
		return watchManNoOfQuarters;
	}
	public void setWatchManNoOfQuarters(String watchManNoOfQuarters) {
		this.watchManNoOfQuarters = watchManNoOfQuarters;
	}
	public String getWatchManType() {
		return watchManType;
	}
	public void setWatchManType(String watchManType) {
		this.watchManType = watchManType;
	}
	/**
	 * @return Returns the ssDepth.
	 */
	public float getSsDepth() {
		return ssDepth;
	}
	/**
	 * @param ssDepth The ssDepth to set.
	 */
	public void setSsDepth(float ssDepth) {
		this.ssDepth = ssDepth;
	}
	public String getPClass() {
		return pClass;
	}
	public void setPClass(String class1) {
		pClass = class1;
	}
	public String getPDiameter() {
		return pDiameter;
	}
	public void setPDiameter(String diameter) {
		pDiameter = diameter;
	}
	public String getPLength() {
		return pLength;
	}
	public void setPLength(String length) {
		pLength = length;
	}
	public String getPMaterial() {
		return pMaterial;
	}
	public void setPMaterial(String material) {
		pMaterial = material;
	}
	
	public String getPowerConnOthers() {
		return powerConnOthers;
	}
	public void setPowerConnOthers(String powerConnOthers) {
		this.powerConnOthers = powerConnOthers;
	}
	public String getCollectionWellLocation() {
		return collectionWellLocation;
	}
	public void setCollectionWellLocation(String collectionWellLocation) {
		this.collectionWellLocation = collectionWellLocation;
	}
	public boolean isWtpClarifloculator() {
		return wtpClarifloculator;
	}
	public void setWtpClarifloculator(boolean wtpClarifloculator) {
		wtpClarifloculatorValue="01";
		this.wtpClarifloculator = wtpClarifloculator;
	}
	public boolean isWtpHorizontalRoughingFilter() {
		return wtpHorizontalRoughingFilter;
	}
	public void setWtpHorizontalRoughingFilter(
			boolean wtpHorizontalRoughingFilter) {
		wtpHorizontalRoughingFilterValue="02";
		this.wtpHorizontalRoughingFilter = wtpHorizontalRoughingFilter;
	}
	public boolean isWtpSedimentationTank() {
		return wtpSedimentationTank;
	}
	public void setWtpSedimentationTank(boolean wtpSedimentationTank) {
		wtpSedimentationTankValue="01";
		this.wtpSedimentationTank = wtpSedimentationTank;
	}
	public boolean isWtpVerticalRoughingFilter() {
		return wtpVerticalRoughingFilter;
	}
	public void setWtpVerticalRoughingFilter(boolean wtpVerticalRoughingFilter) {
		wtpVerticalRoughingFilterValue="03";
		this.wtpVerticalRoughingFilter = wtpVerticalRoughingFilter;
	}
	public String getWtpClarifloculatorValue() {
		return wtpClarifloculatorValue;
	}
	public void setWtpClarifloculatorValue(String wtpClarifloculatorValue) {
		this.wtpClarifloculatorValue = wtpClarifloculatorValue;
	}
	public String getWtpHorizontalRoughingFilterValue() {
		return wtpHorizontalRoughingFilterValue;
	}
	public void setWtpHorizontalRoughingFilterValue(
			String wtpHorizontalRoughingFilterValue) {
		this.wtpHorizontalRoughingFilterValue = wtpHorizontalRoughingFilterValue;
	}
	public String getWtpSedimentationTankValue() {
		return wtpSedimentationTankValue;
	}
	public void setWtpSedimentationTankValue(String wtpSedimentationTankValue) {
		this.wtpSedimentationTankValue = wtpSedimentationTankValue;
	}
	public String getWtpVerticalRoughingFilterValue() {
		return wtpVerticalRoughingFilterValue;
	}
	public void setWtpVerticalRoughingFilterValue(
			String wtpVerticalRoughingFilterValue) {
		this.wtpVerticalRoughingFilterValue = wtpVerticalRoughingFilterValue;
	}
	public String getPumpHouseLocation() {
		return pumpHouseLocation;
	}
	public void setPumpHouseLocation(String pumpHouseLocation) {
		this.pumpHouseLocation = pumpHouseLocation;
	}
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	
	

	public double getWtpRateOfFiltration() {
		return wtpRateOfFiltration;
	}
	public void setWtpRateOfFiltration(double wtpRateOfFiltration) {
		this.wtpRateOfFiltration = wtpRateOfFiltration;
	}
	public String getWatchManLocation() {
		return watchManLocation;
	}
	public void setWatchManLocation(String watchManLocation) {
		this.watchManLocation = watchManLocation;
	}
	public String getBridgeLocation() {
		return bridgeLocation;
	}
	public void setBridgeLocation(String bridgeLocation) {
		this.bridgeLocation = bridgeLocation;
	}
	
	/**
	 * @return Returns the wtpShelter.
	 */
	public int getWtpShelter() {
		return wtpShelter;
	}
	/**
	 * @param wtpShelter The wtpShelter to set.
	 */
	public void setWtpShelter(int wtpShelter) {
		this.wtpShelter = wtpShelter;
	}
	
	public String getWtpProductWater() {
		return wtpProductWater;
	}
	public void setWtpProductWater(String wtpProductWater) {
		this.wtpProductWater = wtpProductWater;
	}
	public String getWtpRawWater() {
		return wtpRawWater;
	}
	public void setWtpRawWater(String wtpRawWater) {
		this.wtpRawWater = wtpRawWater;
	}
	/**
	 * @return Returns the elevation.
	 */
	public String getElevation() {
		return elevation;
	}
	/**
	 * @param elevation The elevation to set.
	 */
	public void setElevation(String elevation) {
		this.elevation = elevation;
	}
/**
 * @return Returns the latitude.
 */
public String getLatitude() {
	return latitude;
}
/**
 * @param latitude The latitude to set.
 */
public void setLatitude(String latitude) {
	this.latitude = latitude;
}
	/**
	 * @return Returns the longitude.
	 */
	public String getLongitude() {
		return longitude;
	}
	/**
	 * @param longitude The longitude to set.
	 */
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	/**
	 * @return Returns the waypoint.
	 */
	public String getWaypoint() {
		return waypoint;
	}
	/**
	 * @param waypoint The waypoint to set.
	 */
	public void setWaypoint(String waypoint) {
		this.waypoint = waypoint;
	}
}
