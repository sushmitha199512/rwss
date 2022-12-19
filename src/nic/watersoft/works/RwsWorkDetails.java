/*
 * Created on 8-11-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.io.Serializable;

/**
 * @author RWSS_DPT1
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class RwsWorkDetails implements Serializable {

	private String workId;

	private String workName;

	private String landAquisition;

	private String waterDrawlPermission;

	private String railwayCrossingPermission;

	private String roadCrossingPermission;

	private String forestClearance;

	private String others;

	private String othersReason;

	private String dprStatus;

	private String dprCompDate;
	
	private String remarks;

	private String landAquisitionObtainDate;

	private String waterDrawlPermissionObtainDate;

	private String railwayCrossingPermissionObtainDate;

	private String roadCrossingPermissionObtainDate;

	private String forestClearanceObtainDate;

	private String othersObtainDate;

	private String landAquisitionNumber;

	private String waterDrawlPermissionNumber;
	
	private String railwayCrossingPermissionNumber;

	private String roadCrossingPermissionNumber;

	private String forestClearanceNumber;

	private String othersNumber;
	
	private String partAClearnce;
	private String  partAClearnceDate;
	
	private String programmeName;
	private String subProgrammeName;
	
  private String partAAmount;
  
  private String sanctionAmount;
  
	

/**
 * @return Returns the partAAmount.
 */
public String getPartAAmount() {
	return partAAmount;
}
/**
 * @param partAAmount The partAAmount to set.
 */
public void setPartAAmount(String partAAmount) {
	this.partAAmount = partAAmount;
}
	/**
	 * @return Returns the programmeName.
	 */
	public String getProgrammeName() {
		return programmeName;
	}
	/**
	 * @param programmeName The programmeName to set.
	 */
	public void setProgrammeName(String programmeName) {
		this.programmeName = programmeName;
	}
	/**
	 * @return Returns the subProgrammeName.
	 */
	public String getSubProgrammeName() {
		return subProgrammeName;
	}
	/**
	 * @param subProgrammeName The subProgrammeName to set.
	 */
	public void setSubProgrammeName(String subProgrammeName) {
		this.subProgrammeName = subProgrammeName;
	}
	/**
	 * @return Returns the partAClearnce.
	 */
	public String getPartAClearnce() {
		return partAClearnce;
	}
	/**
	 * @param partAClearnce The partAClearnce to set.
	 */
	public void setPartAClearnce(String partAClearnce) {
		this.partAClearnce = partAClearnce;
	}
	/**
	 * @return Returns the partAClearnceDate.
	 */
	public String getPartAClearnceDate() {
		return partAClearnceDate;
	}
	/**
	 * @param partAClearnceDate The partAClearnceDate to set.
	 */
	public void setPartAClearnceDate(String partAClearnceDate) {
		this.partAClearnceDate = partAClearnceDate;
	}
	/**
	 * @return Returns the forestClearanceNumber.
	 */
	public String getForestClearanceNumber() {
		return forestClearanceNumber;
	}
	/**
	 * @param forestClearanceNumber The forestClearanceNumber to set.
	 */
	public void setForestClearanceNumber(String forestClearanceNumber) {
		this.forestClearanceNumber = forestClearanceNumber;
	}
	/**
	 * @return Returns the forestClearanceObtainDate.
	 */
	public String getForestClearanceObtainDate() {
		return forestClearanceObtainDate;
	}
	/**
	 * @param forestClearanceObtainDate The forestClearanceObtainDate to set.
	 */
	public void setForestClearanceObtainDate(String forestClearanceObtainDate) {
		this.forestClearanceObtainDate = forestClearanceObtainDate;
	}
	/**
	 * @return Returns the landAquisitionNumber.
	 */
	public String getLandAquisitionNumber() {
		return landAquisitionNumber;
	}
	/**
	 * @param landAquisitionNumber The landAquisitionNumber to set.
	 */
	public void setLandAquisitionNumber(String landAquisitionNumber) {
		this.landAquisitionNumber = landAquisitionNumber;
	}
	/**
	 * @return Returns the landAquisitionObtainDate.
	 */
	public String getLandAquisitionObtainDate() {
		return landAquisitionObtainDate;
	}
	/**
	 * @param landAquisitionObtainDate The landAquisitionObtainDate to set.
	 */
	public void setLandAquisitionObtainDate(String landAquisitionObtainDate) {
		this.landAquisitionObtainDate = landAquisitionObtainDate;
	}
	/**
	 * @return Returns the othersNumber.
	 */
	public String getOthersNumber() {
		return othersNumber;
	}
	/**
	 * @param othersNumber The othersNumber to set.
	 */
	public void setOthersNumber(String othersNumber) {
		this.othersNumber = othersNumber;
	}
	/**
	 * @return Returns the othersObtainDate.
	 */
	public String getOthersObtainDate() {
		return othersObtainDate;
	}
	/**
	 * @param othersObtainDate The othersObtainDate to set.
	 */
	public void setOthersObtainDate(String othersObtainDate) {
		this.othersObtainDate = othersObtainDate;
	}
	/**
	 * @return Returns the railwayCrossingPermissionNumber.
	 */
	public String getRailwayCrossingPermissionNumber() {
		return railwayCrossingPermissionNumber;
	}
	/**
	 * @param railwayCrossingPermissionNumber The railwayCrossingPermissionNumber to set.
	 */
	public void setRailwayCrossingPermissionNumber(
			String railwayCrossingPermissionNumber) {
		this.railwayCrossingPermissionNumber = railwayCrossingPermissionNumber;
	}
	/**
	 * @return Returns the railwayCrossingPermissionObtainDate.
	 */
	public String getRailwayCrossingPermissionObtainDate() {
		return railwayCrossingPermissionObtainDate;
	}
	/**
	 * @param railwayCrossingPermissionObtainDate The railwayCrossingPermissionObtainDate to set.
	 */
	public void setRailwayCrossingPermissionObtainDate(
			String railwayCrossingPermissionObtainDate) {
		this.railwayCrossingPermissionObtainDate = railwayCrossingPermissionObtainDate;
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
	 * @return Returns the roadCrossingPermissionNumber.
	 */
	public String getRoadCrossingPermissionNumber() {
		return roadCrossingPermissionNumber;
	}
	/**
	 * @param roadCrossingPermissionNumber The roadCrossingPermissionNumber to set.
	 */
	public void setRoadCrossingPermissionNumber(
			String roadCrossingPermissionNumber) {
		this.roadCrossingPermissionNumber = roadCrossingPermissionNumber;
	}
	/**
	 * @return Returns the roadCrossingPermissionObtainDate.
	 */
	public String getRoadCrossingPermissionObtainDate() {
		return roadCrossingPermissionObtainDate;
	}
	/**
	 * @param roadCrossingPermissionObtainDate The roadCrossingPermissionObtainDate to set.
	 */
	public void setRoadCrossingPermissionObtainDate(
			String roadCrossingPermissionObtainDate) {
		this.roadCrossingPermissionObtainDate = roadCrossingPermissionObtainDate;
	}
	/**
	 * @return Returns the waterDrawlPermissionNumber.
	 */
	public String getWaterDrawlPermissionNumber() {
		return waterDrawlPermissionNumber;
	}
	/**
	 * @param waterDrawlPermissionNumber The waterDrawlPermissionNumber to set.
	 */
	public void setWaterDrawlPermissionNumber(String waterDrawlPermissionNumber) {
		this.waterDrawlPermissionNumber = waterDrawlPermissionNumber;
	}
	/**
	 * @return Returns the waterDrawlPermissionObtainDate.
	 */
	public String getWaterDrawlPermissionObtainDate() {
		return waterDrawlPermissionObtainDate;
	}
	/**
	 * @param waterDrawlPermissionObtainDate The waterDrawlPermissionObtainDate to set.
	 */
	public void setWaterDrawlPermissionObtainDate(
			String waterDrawlPermissionObtainDate) {
		this.waterDrawlPermissionObtainDate = waterDrawlPermissionObtainDate;
	}
	/**
	 * @return Returns the dprCompDate.
	 */
	public String getDprCompDate() {
		return dprCompDate;
	}
	/**
	 * @param dprCompDate The dprCompDate to set.
	 */
	public void setDprCompDate(String dprCompDate) {
		this.dprCompDate = dprCompDate;
	}
	/**
	 * @return Returns the dprStatus.
	 */
	public String getDprStatus() {
		return dprStatus;
	}
	/**
	 * @param dprStatus The dprStatus to set.
	 */
	public void setDprStatus(String dprStatus) {
		this.dprStatus = dprStatus;
	}
	/**
	 * @return Returns the forestClearance.
	 */
	public String getForestClearance() {
		return forestClearance;
	}
	/**
	 * @param forestClearance The forestClearance to set.
	 */
	public void setForestClearance(String forestClearance) {
		this.forestClearance = forestClearance;
	}
	/**
	 * @return Returns the landAquisition.
	 */
	public String getLandAquisition() {
		return landAquisition;
	}
	/**
	 * @param landAquisition The landAquisition to set.
	 */
	public void setLandAquisition(String landAquisition) {
		this.landAquisition = landAquisition;
	}
	/**
	 * @return Returns the others.
	 */
	public String getOthers() {
		return others;
	}
	/**
	 * @param others The others to set.
	 */
	public void setOthers(String others) {
		this.others = others;
	}
	/**
	 * @return Returns the othersReason.
	 */
	public String getOthersReason() {
		return othersReason;
	}
	/**
	 * @param othersReason The othersReason to set.
	 */
	public void setOthersReason(String othersReason) {
		this.othersReason = othersReason;
	}
	/**
	 * @return Returns the railwayCrossingPermission.
	 */
	public String getRailwayCrossingPermission() {
		return railwayCrossingPermission;
	}
	/**
	 * @param railwayCrossingPermission The railwayCrossingPermission to set.
	 */
	public void setRailwayCrossingPermission(String railwayCrossingPermission) {
		this.railwayCrossingPermission = railwayCrossingPermission;
	}
	/**
	 * @return Returns the roadCrossingPermission.
	 */
	public String getRoadCrossingPermission() {
		return roadCrossingPermission;
	}
	/**
	 * @param roadCrossingPermission The roadCrossingPermission to set.
	 */
	public void setRoadCrossingPermission(String roadCrossingPermission) {
		this.roadCrossingPermission = roadCrossingPermission;
	}
	/**
	 * @return Returns the waterDrawlPermission.
	 */
	public String getWaterDrawlPermission() {
		return waterDrawlPermission;
	}
	/**
	 * @param waterDrawlPermission The waterDrawlPermission to set.
	 */
	public void setWaterDrawlPermission(String waterDrawlPermission) {
		this.waterDrawlPermission = waterDrawlPermission;
	}
	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}
	/**
	 * @param workId The workId to set.
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	/**
	 * @return Returns the workName.
	 */
	public String getWorkName() {
		return workName;
	}
	/**
	 * @param workName The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}
/**
 * @return Returns the sanctionAmount.
 */
public String getSanctionAmount() {
	return sanctionAmount;
}
/**
 * @param sanctionAmount The sanctionAmount to set.
 */
public void setSanctionAmount(String sanctionAmount) {
	this.sanctionAmount = sanctionAmount;
}
}