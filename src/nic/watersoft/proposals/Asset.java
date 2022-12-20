package nic.watersoft.proposals;

import java.io.Serializable;

public class Asset implements Serializable
{
	private String assetCode;
	private String assetName;
	private String habCode;
	private String location;
	private String creationDate;
	private String assetStatus;
	private String assetCost;
	private String startYear;
	private String endYear;
	private String noOfHabs;
	private String noOfFunctionalHabs;

	public String getAssetCode() {
		return assetCode;
	}
	
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	
	public String getAssetCost() {
		return assetCost;
	}
		
	public void setAssetCost(String assetCost) {
		this.assetCost = assetCost;
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
	
	public String getCreationDate() {
		return creationDate;
	}
	
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}
	
	public String getEndYear() {
		return endYear;
	}
	
	public void setEndYear(String endYear) {
		this.endYear = endYear;
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
	
	public String getNoOfHabs() {
		return noOfHabs;
	}
	
	public void setNoOfHabs(String noOfHabs) {
		this.noOfHabs = noOfHabs;
	}
	
	public String getNoOfFunctionalHabs()
	{
		return noOfFunctionalHabs;
	}
	
	public void setNoOfFunctionalHabs(String noOfFunctionalHabs)
	{
		this.noOfFunctionalHabs = noOfFunctionalHabs;
	}
	
	public String getStartYear() {
		return startYear;
	}
	
	public void setStartYear(String startYear) {
		this.startYear = startYear;
	}
	}
