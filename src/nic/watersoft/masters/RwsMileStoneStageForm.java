package nic.watersoft.masters;

import org.apache.struts.action.ActionForm;

public class RwsMileStoneStageForm extends ActionForm {

	
	  String mileStoneCode;
	  String mileStoneStageCode;
	  String mileStoneStageName;
	  String mode;
	  String ddwsLinked;
	  String ddwsCompCode;
	  String ddwsComp;
	  String sourceType;
	  String subSourceType;
	  String sourceName;
	  String subSourceName;
	  double mileStoneStagePercentage;
	  String displayStatus;
		  
	  
	public String getDisplayStatus() {
		return displayStatus;
	}
	public void setDisplayStatus(String displayStatus) {
		this.displayStatus = displayStatus;
	}
	public double getMileStoneStagePercentage() {
		return mileStoneStagePercentage;
	}
	public void setMileStoneStagePercentage(double mileStoneStagePercentage) {
		this.mileStoneStagePercentage = mileStoneStagePercentage;
	}
	public String getSubSourceName() {
		return subSourceName;
	}
	public void setSubSourceName(String subSourceName) {
		this.subSourceName = subSourceName;
	}
	public String getSourceName() {
		return sourceName;
	}
	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getSubSourceType() {
		return subSourceType;
	}
	public void setSubSourceType(String subSourceType) {
		this.subSourceType = subSourceType;
	}
	public String getDdwsComp() {
		return ddwsComp;
	}
	public void setDdwsComp(String ddwsComp) {
		this.ddwsComp = ddwsComp;
	}
	public String getDdwsCompCode() {
		return ddwsCompCode;
	}
	public void setDdwsCompCode(String ddwsCompCode) {
		this.ddwsCompCode = ddwsCompCode;
	}
	public String getDdwsLinked() {
		return ddwsLinked;
	}
	public void setDdwsLinked(String ddwsLinked) {
		this.ddwsLinked = ddwsLinked;
	}
	
	public String getMode() {
		return mode;
	}
	
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	public String getMileStoneCode() {
		return mileStoneCode;
	}
	
	public void setMileStoneCode(String mileStoneCode) {
		this.mileStoneCode = mileStoneCode;
	}
	
	public String getMileStoneStageCode() {
		return mileStoneStageCode;
	}
	
	public void setMileStoneStageCode(String mileStoneStageCode) {
		this.mileStoneStageCode = mileStoneStageCode;
	}

	
	public String getMileStoneStageName() {
		return mileStoneStageName;
	}
	
	public void setMileStoneStageName(String mileStoneStageName) {
		this.mileStoneStageName = mileStoneStageName;
	}
}