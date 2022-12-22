package nic.com.webservices.dao;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Asset {

	private String assetCode;
	private String assetName;
	private String assetLocation;
	private String sourceCode;
	private String habitationName;
	private String habitationCode;
	private String GPSLat;
	private String GPSLong;
	private String capacity;
	private String diameter;
	private String depth;
	private String galleryLengthAndDiameter;
	private String galleryDepthAtLocation;
	private String dateOfCommissioning;
	private String hours;
	private String noFillingsDay;
	private String yield;
	private String head;
	private String discharge;
	private String GIPipes;
	private String platFormExisting;
	private String platFormCondition;
	private String drainExisting;
	private String drainCondition;
	private String coveredHabitations;
	private String noOfHouseHoldsPlain;
	private String noOfHouseHoldsSC;
	private String noOfHouseHoldsST;
	private String noOfHouseHoldConnectionsPlain;
	private String noOfHouseHoldConnectionssSC;
	private String noOfHouseHoldsConnectionsST;
	private String populationAsPer2011Plain;
	private String populationAsPer2011SC;
	private String populationAsPer2011ST;
	private String coordniatesOfImpLocations;
	private String assetStatus;
	private String assetCategory;
	private String asseType;
	private String dateOfSurvey;
	private String capacityLPM;
	private String respondCode;
	
	private Source source;

	public Source getSource() {
		return source;
	}

	@XmlElement
	public void setSource(Source source) {
		this.source = source;
	}

	@XmlElement
	public void setAssetStatus(String assetStatus) {
		this.assetStatus = assetStatus;
	}

	@XmlElement
	public void setAssetCategory(String assetCategory) {
		this.assetCategory = assetCategory;
	}

	@XmlElement
	public void setDateOfSurvey(String dateOfSurvey) {
		this.dateOfSurvey = dateOfSurvey;
	}

	@XmlElement
	public void setCapacityLPM(String capacityLPM) {
		this.capacityLPM = capacityLPM;
	}

	@XmlElement
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}

	@XmlElement
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}

	@XmlElement
	public void setAssetLocation(String assetLocation) {
		this.assetLocation = assetLocation;
	}

	@XmlElement
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}

	@XmlElement
	public void setHabitationName(String habitationName) {
		this.habitationName = habitationName;
	}

	@XmlElement
	public void setHabitationCode(String habitationCode) {
		this.habitationCode = habitationCode;
	}

	@XmlElement
	public void setGPSLat(String gPSLat) {
		GPSLat = gPSLat;
	}

	@XmlElement
	public void setGPSLong(String gPSLong) {
		GPSLong = gPSLong;
	}

	@XmlElement
	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}

	@XmlElement
	public void setDiameter(String diameter) {
		this.diameter = diameter;
	}

	@XmlElement
	public void setDepth(String depth) {
		this.depth = depth;
	}

	@XmlElement
	public void setGalleryLengthAndDiameter(String galleryLengthAndDiameter) {
		this.galleryLengthAndDiameter = galleryLengthAndDiameter;
	}

	@XmlElement
	public void setGalleryDepthAtLocation(String galleryDepthAtLocation) {
		this.galleryDepthAtLocation = galleryDepthAtLocation;
	}

	@XmlElement
	public void setDateOfCommissioning(String dateOfCommissioning) {
		this.dateOfCommissioning = dateOfCommissioning;
	}

	@XmlElement
	public void setHours(String hours) {
		this.hours = hours;
	}

	@XmlElement
	public void setNoFillingsDay(String noFillingsDay) {
		this.noFillingsDay = noFillingsDay;
	}

	@XmlElement
	public void setYield(String yield) {
		this.yield = yield;
	}

	@XmlElement
	public void setHead(String head) {
		this.head = head;
	}

	@XmlElement
	public void setDischarge(String discharge) {
		this.discharge = discharge;
	}

	@XmlElement
	public void setGIPipes(String gIPipes) {
		GIPipes = gIPipes;
	}

	@XmlElement
	public void setPlatFormExisting(String platFormExisting) {
		this.platFormExisting = platFormExisting;
	}

	@XmlElement
	public void setPlatFormCondition(String platFormCondition) {
		this.platFormCondition = platFormCondition;
	}

	@XmlElement
	public void setDrainExisting(String drainExisting) {
		this.drainExisting = drainExisting;
	}

	@XmlElement
	public void setDrainCondition(String drainCondition) {
		this.drainCondition = drainCondition;
	}

	@XmlElement
	public void setCoveredHabitations(String coveredHabitations) {
		this.coveredHabitations = coveredHabitations;
	}

	@XmlElement
	public void setNoOfHouseHoldsPlain(String noOfHouseHoldsPlain) {
		this.noOfHouseHoldsPlain = noOfHouseHoldsPlain;
	}

	@XmlElement
	public void setNoOfHouseHoldsSC(String noOfHouseHoldsSC) {
		this.noOfHouseHoldsSC = noOfHouseHoldsSC;
	}

	@XmlElement
	public void setNoOfHouseHoldsST(String noOfHouseHoldsST) {
		this.noOfHouseHoldsST = noOfHouseHoldsST;
	}

	@XmlElement
	public void setNoOfHouseHoldConnectionsPlain(
			String noOfHouseHoldConnectionsPlain) {
		this.noOfHouseHoldConnectionsPlain = noOfHouseHoldConnectionsPlain;
	}

	@XmlElement
	public void setNoOfHouseHoldConnectionssSC(
			String noOfHouseHoldConnectionssSC) {
		this.noOfHouseHoldConnectionssSC = noOfHouseHoldConnectionssSC;
	}

	@XmlElement
	public void setNoOfHouseHoldsConnectionsST(
			String noOfHouseHoldsConnectionsST) {
		this.noOfHouseHoldsConnectionsST = noOfHouseHoldsConnectionsST;
	}

	@XmlElement
	public void setPopulationAsPer2011Plain(String populationAsPer2011Plain) {
		this.populationAsPer2011Plain = populationAsPer2011Plain;
	}

	@XmlElement
	public void setPopulationAsPer2011SC(String populationAsPer2011SC) {
		this.populationAsPer2011SC = populationAsPer2011SC;
	}

	@XmlElement
	public void setPopulationAsPer2011ST(String populationAsPer2011ST) {
		this.populationAsPer2011ST = populationAsPer2011ST;
	}

	@XmlElement
	public void setCoordniatesOfImpLocations(String coordniatesOfImpLocations) {
		this.coordniatesOfImpLocations = coordniatesOfImpLocations;
	}

	@XmlElement
	public void setAsseType(String asseType) {
		this.asseType = asseType;
	}

	@XmlElement
	public void setRespondCode(String respondCode) {
		this.respondCode = respondCode;
	}

	public String getAssetCode() {
		return assetCode;
	}

	public String getAssetName() {
		return assetName;
	}

	public String getAssetLocation() {
		return assetLocation;
	}

	public String getSourceCode() {
		return sourceCode;
	}

	public String getHabitationName() {
		return habitationName;
	}

	public String getHabitationCode() {
		return habitationCode;
	}

	public String getGPSLat() {
		return GPSLat;
	}

	public String getGPSLong() {
		return GPSLong;
	}

	public String getCapacity() {
		return capacity;
	}

	public String getDiameter() {
		return diameter;
	}

	public String getDepth() {
		return depth;
	}

	public String getGalleryLengthAndDiameter() {
		return galleryLengthAndDiameter;
	}

	public String getGalleryDepthAtLocation() {
		return galleryDepthAtLocation;
	}

	public String getDateOfCommissioning() {
		return dateOfCommissioning;
	}

	public String getHours() {
		return hours;
	}

	public String getNoFillingsDay() {
		return noFillingsDay;
	}

	public String getYield() {
		return yield;
	}

	public String getHead() {
		return head;
	}

	public String getDischarge() {
		return discharge;
	}

	public String getGIPipes() {
		return GIPipes;
	}

	public String getPlatFormExisting() {
		return platFormExisting;
	}

	public String getPlatFormCondition() {
		return platFormCondition;
	}

	public String getDrainExisting() {
		return drainExisting;
	}

	public String getDrainCondition() {
		return drainCondition;
	}

	public String getCoveredHabitations() {
		return coveredHabitations;
	}

	public String getNoOfHouseHoldsPlain() {
		return noOfHouseHoldsPlain;
	}

	public String getNoOfHouseHoldsSC() {
		return noOfHouseHoldsSC;
	}

	public String getNoOfHouseHoldsST() {
		return noOfHouseHoldsST;
	}

	public String getNoOfHouseHoldConnectionsPlain() {
		return noOfHouseHoldConnectionsPlain;
	}

	public String getNoOfHouseHoldConnectionssSC() {
		return noOfHouseHoldConnectionssSC;
	}

	public String getNoOfHouseHoldsConnectionsST() {
		return noOfHouseHoldsConnectionsST;
	}

	public String getPopulationAsPer2011Plain() {
		return populationAsPer2011Plain;
	}

	public String getPopulationAsPer2011SC() {
		return populationAsPer2011SC;
	}

	public String getPopulationAsPer2011ST() {
		return populationAsPer2011ST;
	}

	public String getCoordniatesOfImpLocations() {
		return coordniatesOfImpLocations;
	}

	public String getAsseType() {
		return asseType;
	}

	public String getRespondCode() {
		return respondCode;
	}

	public String getAssetStatus() {
		return assetStatus;
	}

	public String getAssetCategory() {
		return assetCategory;
	}

	public String getDateOfSurvey() {
		return dateOfSurvey;
	}

	public String getCapacityLPM() {
		return capacityLPM;
	}

}
