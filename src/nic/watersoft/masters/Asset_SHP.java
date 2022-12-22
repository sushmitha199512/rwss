/*
 * Created on Dec 11, 2006
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
public class Asset_SHP {
//	added by swapna on 20-01-2012 for gis data entry
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
	//
	private String assetCode=null;
	private String habCode=null;
	private String shallowHandPumpCode=null;
	private String location=null;
	private String diameter=null;
	private String depth=null;
	private String hygiene=null;
	private String avgNoOfHoursWorkingPerDay=null;
	private String avgTimeToFill=null;
	private String yeild=null;
	private String waterQuality=null;
	private String floride=null;
	private String brakish=null;
	private String iron=null;
	private String others=null;
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


	public String getAvgNoOfHoursWorkingPerDay() {
		return avgNoOfHoursWorkingPerDay;
	}
	public void setAvgNoOfHoursWorkingPerDay(String avgNoOfHoursWorkingPerDay) {
		this.avgNoOfHoursWorkingPerDay = avgNoOfHoursWorkingPerDay;
	}
	public String getAvgTimeToFill() {
		return avgTimeToFill;
	}
	public void setAvgTimeToFill(String avgTimeToFill) {
		this.avgTimeToFill = avgTimeToFill;
	}
	public String getBrakish() {
		return brakish;
	}
	public void setBrakish(String brakish) {
		this.brakish = brakish;
	}
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
	public String getHygiene() {
		return hygiene;
	}
	public void setHygiene(String hygiene) {
		this.hygiene = hygiene;
	}
	public String getIron() {
		return iron;
	}
	public void setIron(String iron) {
		this.iron = iron;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getOthers() {
		return others;
	}
	public void setOthers(String others) {
		this.others = others;
	}
	public String getShallowHandPumpCode() {
		return shallowHandPumpCode;
	}
	public void setShallowHandPumpCode(String shallowHandPumpCode) {
		this.shallowHandPumpCode = shallowHandPumpCode;
	}
	public String getWaterQuality() {
		return waterQuality;
	}
	public void setWaterQuality(String waterQuality) {
		this.waterQuality = waterQuality;
	}
	public String getYeild() {
		return yeild;
	}
	public void setYeild(String yeild) {
		this.yeild = yeild;
	}
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
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
