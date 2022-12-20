/*
 * Created on Dec 7, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Asset_OpenWells {
//	added by swapna on 20-01-2012 for gis data entry
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
	//
	private String assetCode;
	private String habCode;
	private String openWellCode;
	private String location;
	private String diameter;
	private String depth;
	private String normalWaterLevel;
	private String minimumWaterLevel;
	private String maximumWaterLevel;
	private String platformExists;
	private String platformCondition;
	private String purpose;
	private String waterQuality;
	private String floride;
	private String brakish;
	private String iron;
	private String others="";
	private String othersType;
//	code added by pranavi
	 private String habitation;
	 private String imageStatus;
	 
	 
	 public String getImageStatus() {
		return imageStatus;
	}
	public void setImageStatus(String imageStatus) {
		this.imageStatus = imageStatus;
	}
	public String getHabitation() {
		return habitation;
		}
		public void setHabitation(String habitation) {
			this.habitation = habitation;
		}
	//end of code added by pranavi 



	public String getDepth() {
		return depth;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	public String getDiameter() {
		return diameter;
	}
	public void setDiameter(String diameter) {
		this.diameter = diameter;
	}
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getMaximumWaterLevel() {
		return maximumWaterLevel;
	}
	public void setMaximumWaterLevel(String maximumWaterLevel) {
		this.maximumWaterLevel = maximumWaterLevel;
	}
	public String getMinimumWaterLevel() {
		return minimumWaterLevel;
	}
	public void setMinimumWaterLevel(String minimumWaterLevel) {
		this.minimumWaterLevel = minimumWaterLevel;
	}
	public String getNormalWaterLevel() {
		return normalWaterLevel;
	}
	public void setNormalWaterLevel(String normalWaterLevel) {
		this.normalWaterLevel = normalWaterLevel;
	}
	public String getOpenWellCode() {
		return openWellCode;
	}
	public void setOpenWellCode(String openWellCode) {
		this.openWellCode = openWellCode;
	}
	public String getPlatformCondition() {
		return platformCondition;
	}
	public void setPlatformCondition(String platformCondition) {
		this.platformCondition = platformCondition;
	}
	public String getPlatformExists() {
		return platformExists;
	}
	public void setPlatformExists(String platformExists) {
		this.platformExists = platformExists;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
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
	public String getOthers() {
		return others;
	}
	public void setOthers(String others) {
		this.others = others;
	}
	public String getWaterQuality() {
		return waterQuality;
	}
	public void setWaterQuality(String waterQuality) {
		this.waterQuality = waterQuality;
	}
	public String getFloride() {
		return floride;
	}
	public void setFloride(String floride) {
		this.floride = floride;
	}
	public String getOthersType() {
		return othersType;
	}
	public void setOthersType(String othersType) {
		this.othersType = othersType;
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
