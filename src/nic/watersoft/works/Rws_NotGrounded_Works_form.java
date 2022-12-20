/*
 * Created on 2-11-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.io.Serializable;

import org.apache.struts.action.ActionForm;

/**
 * @author RWSS_DPT1
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class Rws_NotGrounded_Works_form extends ActionForm implements
		Serializable {

	private String workidS;
	
	private String groundWaterInvestigationChg;

	private String yieldTestingChg;

	private String sourceCreationChg;

	private String landAquisitionChrg;

	private String waterDrawlPermissionChrg;

	private String railwayCrossingPermissionChrg;

	private String roadCrossingPermissionChrg;

	private String roadCrossingPermissionNHAIChrg;

	private String forestClearanceChrg;

	private String othersChrg;

	private String partAAmount;

	private String circleCode;

	private String divName;

	private int divCode;

	private String subDivCode;

	private String subDivName;

	private String workName;

	private String subProgName;

	private String subProgCode;

	private int cmbDivision;

	String programCode;

	String program;

	String finYear;

	private String workid;

	private String sanctionedAmount;

	private String sanctionedDate;

	private String workIdList;

	private String sanctionYear;

	private String landAquisition;

	private String waterDrawlPermission;

	private String railwayCrossingPermission;

	private String roadCrossingPermission;

	private String roadCrossingPermissionNHAI;

	private String forestClearance;

	private String others;

	private String othersReason;

	private String dprStatus;

	private String dprCompDate;

	private boolean isUpdate;

	private String remarks;

	private String landAquisitionReqDate;

	private String waterDrawlPermissionReqDate;

	private String railwayCrossingPermissionReqDate;

	private String roadCrossingPermissionReqDate;

	private String forestClearanceReqDate;

	private String othersReqDate;

	private String landAquisitionReqNumber;

	private String waterDrawlPermissionReqNumber;

	private String railwayCrossingPermissionReqNumber;

	private String roadCrossingPermissionReqNumber;

	private String forestClearanceReqNumber;

	private String othersReqNumber;

	private String landAquisitionObtainDate;

	private String waterDrawlPermissionObtainDate;

	private String railwayCrossingPermissionObtainDate;

	private String roadCrossingPermissionObtainDate;

	private String roadCrossingNHAIObtainDate;

	private String forestClearanceObtainDate;

	private String othersObtainDate;

	private String landAquisitionNumber;

	private String waterDrawlPermissionNumber;

	private String railwayCrossingPermissionNumber;

	private String roadCrossingPermissionNumber;

	private String roadCrossingObtainNHAINumber;

	private String forestClearanceNumber;

	private String othersNumber;

	private String partAClearnce;

	private String partAClearnceDate;

	private String roadCrossingPermissionReqNumberNHAI;

	private String roadCrossingPermissionReqDateNHAI;

	private String sourceCreated;

	private String sourceCreatedDate;

	private String powerAPTranscoReq;

	private String powerAPTranscoChrgs;

	private String powerAPTranscoReqNumber;

	private String powerAPTranscoReqDate;

	private String powerAPTranscoObtainNumber;

	private String powerAPTranscoObtainDate;

	private String hmwsReq;

	private String hmwsChrgs;

	private String hmwsReqNum;

	private String hmwsReqDate;

	private String hmwsReqobtainNum;

	private String hmwsReqobtainDate;

	private String agencyName;

	private String dprCharges;
	
	private String mileStoneAmount;
	
	

	
	/**
	 * @return Returns the mileStoneAmount.
	 */
	public String getMileStoneAmount() {
		return mileStoneAmount;
	}
	/**
	 * @param mileStoneAmount The mileStoneAmount to set.
	 */
	public void setMileStoneAmount(String mileStoneAmount) {
		this.mileStoneAmount = mileStoneAmount;
	}
	/**
	 * @return Returns the hmwsChrgs.
	 */
	public String getHmwsChrgs() {
		return hmwsChrgs;
	}

	/**
	 * @param hmwsChrgs
	 *            The hmwsChrgs to set.
	 */
	public void setHmwsChrgs(String hmwsChrgs) {
		this.hmwsChrgs = hmwsChrgs;
	}

	/**
	 * @return Returns the powerAPTranscoChrgs.
	 */
	public String getPowerAPTranscoChrgs() {
		return powerAPTranscoChrgs;
	}

	/**
	 * @param powerAPTranscoChrgs
	 *            The powerAPTranscoChrgs to set.
	 */
	public void setPowerAPTranscoChrgs(String powerAPTranscoChrgs) {
		this.powerAPTranscoChrgs = powerAPTranscoChrgs;
	}

	/**
	 * @return Returns the forestClearanceChrg.
	 */
	public String getForestClearanceChrg() {
		return forestClearanceChrg;
	}

	/**
	 * @param forestClearanceChrg
	 *            The forestClearanceChrg to set.
	 */
	public void setForestClearanceChrg(String forestClearanceChrg) {
		this.forestClearanceChrg = forestClearanceChrg;
	}

	/**
	 * @return Returns the landAquisitionChrg.
	 */
	public String getLandAquisitionChrg() {
		return landAquisitionChrg;
	}

	/**
	 * @param landAquisitionChrg
	 *            The landAquisitionChrg to set.
	 */
	public void setLandAquisitionChrg(String landAquisitionChrg) {
		this.landAquisitionChrg = landAquisitionChrg;
	}

	/**
	 * @return Returns the othersChrg.
	 */
	public String getOthersChrg() {
		return othersChrg;
	}

	/**
	 * @param othersChrg
	 *            The othersChrg to set.
	 */
	public void setOthersChrg(String othersChrg) {
		this.othersChrg = othersChrg;
	}

	/**
	 * @return Returns the railwayCrossingPermissionChrg.
	 */
	public String getRailwayCrossingPermissionChrg() {
		return railwayCrossingPermissionChrg;
	}

	/**
	 * @param railwayCrossingPermissionChrg
	 *            The railwayCrossingPermissionChrg to set.
	 */
	public void setRailwayCrossingPermissionChrg(
			String railwayCrossingPermissionChrg) {
		this.railwayCrossingPermissionChrg = railwayCrossingPermissionChrg;
	}

	/**
	 * @return Returns the roadCrossingPermissionChrg.
	 */
	public String getRoadCrossingPermissionChrg() {
		return roadCrossingPermissionChrg;
	}

	/**
	 * @param roadCrossingPermissionChrg
	 *            The roadCrossingPermissionChrg to set.
	 */
	public void setRoadCrossingPermissionChrg(String roadCrossingPermissionChrg) {
		this.roadCrossingPermissionChrg = roadCrossingPermissionChrg;
	}

	/**
	 * @return Returns the roadCrossingPermissionNHAIChrg.
	 */
	public String getRoadCrossingPermissionNHAIChrg() {
		return roadCrossingPermissionNHAIChrg;
	}

	/**
	 * @param roadCrossingPermissionNHAIChrg
	 *            The roadCrossingPermissionNHAIChrg to set.
	 */
	public void setRoadCrossingPermissionNHAIChrg(
			String roadCrossingPermissionNHAIChrg) {
		this.roadCrossingPermissionNHAIChrg = roadCrossingPermissionNHAIChrg;
	}

	/**
	 * @return Returns the waterDrawlPermissionChrg.
	 */
	public String getWaterDrawlPermissionChrg() {
		return waterDrawlPermissionChrg;
	}

	/**
	 * @param waterDrawlPermissionChrg
	 *            The waterDrawlPermissionChrg to set.
	 */
	public void setWaterDrawlPermissionChrg(String waterDrawlPermissionChrg) {
		this.waterDrawlPermissionChrg = waterDrawlPermissionChrg;
	}

	/**
	 * @return Returns the agencyName.
	 */
	public String getAgencyName() {
		return agencyName;
	}

	/**
	 * @param agencyName
	 *            The agencyName to set.
	 */
	public void setAgencyName(String agencyName) {
		this.agencyName = agencyName;
	}

	private String dprPrepartion;

	/**
	 * @return Returns the dprPrepartion.
	 */
	public String getDprPrepartion() {
		return dprPrepartion;
	}

	/**
	 * @param dprPrepartion
	 *            The dprPrepartion to set.
	 */
	public void setDprPrepartion(String dprPrepartion) {
		this.dprPrepartion = dprPrepartion;
	}

	/**
	 * @return Returns the hmwsReqDate.
	 */
	public String getHmwsReqDate() {
		if(this.hmwsReqDate==null){
			return "";
		}
		return hmwsReqDate;
	}

	/**
	 * @param hmwsReqDate
	 *            The hmwsReqDate to set.
	 */
	public void setHmwsReqDate(String hmwsReqDate) {
		
		this.hmwsReqDate = hmwsReqDate;
	}

	/**
	 * @return Returns the hmwsReqNum.
	 */
	public String getHmwsReqNum() {
		return hmwsReqNum;
	}

	/**
	 * @param hmwsReqNum
	 *            The hmwsReqNum to set.
	 */
	public void setHmwsReqNum(String hmwsReqNum) {
		this.hmwsReqNum = hmwsReqNum;
	}

	/**
	 * @return Returns the hmwsReq.
	 */
	public String getHmwsReq() {
		if (hmwsReq == null) {
			return "N";
		}
		return hmwsReq;
	}

	/**
	 * @param hmwsReq
	 *            The hmwsReq to set.
	 */
	public void setHmwsReq(String hmwsReq) {
		this.hmwsReq = hmwsReq;
	}

	/**
	 * @return Returns the sourceCreatedDate.
	 */
	public String getSourceCreatedDate() {
		if(this.sourceCreatedDate==null){
			return "";
		}
		return sourceCreatedDate;
	}

	/**
	 * @param sourceCreatedDate
	 *            The sourceCreatedDate to set.
	 */
	public void setSourceCreatedDate(String sourceCreatedDate) {
		this.sourceCreatedDate = sourceCreatedDate;
	}

	/**
	 * @return Returns the sourceCreated.
	 */
	public String getSourceCreated() {
		return sourceCreated;
	}

	/**
	 * @param sourceCreated
	 *            The sourceCreated to set.
	 */
	public void setSourceCreated(String sourceCreated) {
		this.sourceCreated = sourceCreated;
	}

	/**
	 * @return Returns the roadCrossingPermissionReqDateNHAI.
	 */
	public String getRoadCrossingPermissionReqDateNHAI() {
		if(this.roadCrossingPermissionReqDateNHAI==null){
			return "";
		}
		return roadCrossingPermissionReqDateNHAI;
	}

	/**
	 * @param roadCrossingPermissionReqDateNHAI
	 *            The roadCrossingPermissionReqDateNHAI to set.
	 */
	public void setRoadCrossingPermissionReqDateNHAI(
			String roadCrossingPermissionReqDateNHAI) {
		if(this.roadCrossingPermissionReqDateNHAI==null){
			this.roadCrossingPermissionReqDateNHAI="";
		}
		this.roadCrossingPermissionReqDateNHAI = roadCrossingPermissionReqDateNHAI;
	}

	/**
	 * @return Returns the roadCrossingPermissionReqNumberNHAI.
	 */
	public String getRoadCrossingPermissionReqNumberNHAI() {
		return roadCrossingPermissionReqNumberNHAI;
	}

	/**
	 * @param roadCrossingPermissionReqNumberNHAI
	 *            The roadCrossingPermissionReqNumberNHAI to set.
	 */
	public void setRoadCrossingPermissionReqNumberNHAI(
			String roadCrossingPermissionReqNumberNHAI) {
		this.roadCrossingPermissionReqNumberNHAI = roadCrossingPermissionReqNumberNHAI;
	}

	/**
	 * @return Returns the forestClearanceReqDate.
	 */
	public String getForestClearanceReqDate() {
		if(this.forestClearanceReqDate==null){
			return "";
		}
		return forestClearanceReqDate;
	}

	/**
	 * @param forestClearanceReqDate
	 *            The forestClearanceReqDate to set.
	 */
	public void setForestClearanceReqDate(String forestClearanceReqDate) {
		this.forestClearanceReqDate = forestClearanceReqDate;
	}

	/**
	 * @return Returns the forestClearanceReqNumber.
	 */
	public String getForestClearanceReqNumber() {
		return forestClearanceReqNumber;
	}

	/**
	 * @param forestClearanceReqNumber
	 *            The forestClearanceReqNumber to set.
	 */
	public void setForestClearanceReqNumber(String forestClearanceReqNumber) {
		this.forestClearanceReqNumber = forestClearanceReqNumber;
	}

	/**
	 * @return Returns the landAquisitionReqDate.
	 */
	public String getLandAquisitionReqDate() {
		if(this.landAquisitionReqDate==null){
			return "";
		}
		return landAquisitionReqDate;
	}

	/**
	 * @param landAquisitionReqDate
	 *            The landAquisitionReqDate to set.
	 */
	public void setLandAquisitionReqDate(String landAquisitionReqDate) {
		this.landAquisitionReqDate = landAquisitionReqDate;
	}

	/**
	 * @return Returns the landAquisitionReqNumber.
	 */
	public String getLandAquisitionReqNumber() {
		return landAquisitionReqNumber;
	}

	/**
	 * @param landAquisitionReqNumber
	 *            The landAquisitionReqNumber to set.
	 */
	public void setLandAquisitionReqNumber(String landAquisitionReqNumber) {
		this.landAquisitionReqNumber = landAquisitionReqNumber;
	}

	/**
	 * @return Returns the othersReqDate.
	 */
	public String getOthersReqDate() {
		if(this.othersReqDate==null){
			return "";
		}
		return othersReqDate;
	}

	/**
	 * @param othersReqDate
	 *            The othersReqDate to set.
	 */
	public void setOthersReqDate(String othersReqDate) {
		this.othersReqDate = othersReqDate;
	}

	/**
	 * @return Returns the othersReqNumber.
	 */
	public String getOthersReqNumber() {
		return othersReqNumber;
	}

	/**
	 * @param othersReqNumber
	 *            The othersReqNumber to set.
	 */
	public void setOthersReqNumber(String othersReqNumber) {
		this.othersReqNumber = othersReqNumber;
	}

	/**
	 * @return Returns the railwayCrossingPermissionReqDate.
	 */
	public String getRailwayCrossingPermissionReqDate() {
		if(this.railwayCrossingPermissionReqDate==null){
			return "";
		}
		return railwayCrossingPermissionReqDate;
	}

	/**
	 * @param railwayCrossingPermissionReqDate
	 *            The railwayCrossingPermissionReqDate to set.
	 */
	public void setRailwayCrossingPermissionReqDate(
			String railwayCrossingPermissionReqDate) {
		this.railwayCrossingPermissionReqDate = railwayCrossingPermissionReqDate;
	}

	/**
	 * @return Returns the railwayCrossingPermissionReqNumber.
	 */
	public String getRailwayCrossingPermissionReqNumber() {
		return railwayCrossingPermissionReqNumber;
	}

	/**
	 * @param railwayCrossingPermissionReqNumber
	 *            The railwayCrossingPermissionReqNumber to set.
	 */
	public void setRailwayCrossingPermissionReqNumber(
			String railwayCrossingPermissionReqNumber) {
		this.railwayCrossingPermissionReqNumber = railwayCrossingPermissionReqNumber;
	}

	/**
	 * @return Returns the roadCrossingPermissionReqDate.
	 */
	public String getRoadCrossingPermissionReqDate() {
		if(this.roadCrossingPermissionReqDate==null){
			return "";
		}
		return roadCrossingPermissionReqDate;
	}

	/**
	 * @param roadCrossingPermissionReqDate
	 *            The roadCrossingPermissionReqDate to set.
	 */
	public void setRoadCrossingPermissionReqDate(
			String roadCrossingPermissionReqDate) {
		this.roadCrossingPermissionReqDate = roadCrossingPermissionReqDate;
	}

	/**
	 * @return Returns the roadCrossingPermissionReqNumber.
	 */
	public String getRoadCrossingPermissionReqNumber() {
		return roadCrossingPermissionReqNumber;
	}

	/**
	 * @param roadCrossingPermissionReqNumber
	 *            The roadCrossingPermissionReqNumber to set.
	 */
	public void setRoadCrossingPermissionReqNumber(
			String roadCrossingPermissionReqNumber) {
		this.roadCrossingPermissionReqNumber = roadCrossingPermissionReqNumber;
	}

	/**
	 * @return Returns the waterDrawlPermissionReqDate.
	 */
	public String getWaterDrawlPermissionReqDate() {
		if(this.waterDrawlPermissionReqDate==null){
			return "";
		}
		return waterDrawlPermissionReqDate;
	}

	/**
	 * @param waterDrawlPermissionReqDate
	 *            The waterDrawlPermissionReqDate to set.
	 */
	public void setWaterDrawlPermissionReqDate(
			String waterDrawlPermissionReqDate) {
		this.waterDrawlPermissionReqDate = waterDrawlPermissionReqDate;
	}

	/**
	 * @return Returns the waterDrawlPermissionReqNumber.
	 */
	public String getWaterDrawlPermissionReqNumber() {
		return waterDrawlPermissionReqNumber;
	}

	/**
	 * @param waterDrawlPermissionReqNumber
	 *            The waterDrawlPermissionReqNumber to set.
	 */
	public void setWaterDrawlPermissionReqNumber(
			String waterDrawlPermissionReqNumber) {
		this.waterDrawlPermissionReqNumber = waterDrawlPermissionReqNumber;
	}

	/**
	 * @return Returns the sanctionYear.
	 */
	public String getSanctionYear() {
		return sanctionYear;
	}

	/**
	 * @param sanctionYear
	 *            The sanctionYear to set.
	 */
	public void setSanctionYear(String sanctionYear) {
		this.sanctionYear = sanctionYear;
	}

	/**
	 * @return Returns the partAClearnce.
	 */
	public String getPartAClearnce() {
		if (this.partAClearnce == null) {
			return "N";
		}
		return partAClearnce;
	}

	/**
	 * @param partAClearnce
	 *            The partAClearnce to set.
	 */
	public void setPartAClearnce(String partAClearnce) {
		this.partAClearnce = partAClearnce;
	}

	/**
	 * @return Returns the partAClearnceDate.
	 */
	public String getPartAClearnceDate() {
		if(this.partAClearnceDate==null){
			return "";
		}
		return partAClearnceDate;
	}

	/**
	 * @param partAClearnceDate
	 *            The partAClearnceDate to set.
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
	 * @param forestClearanceNumber
	 *            The forestClearanceNumber to set.
	 */
	public void setForestClearanceNumber(String forestClearanceNumber) {
		this.forestClearanceNumber = forestClearanceNumber;
	}

	/**
	 * @return Returns the othersNumber.
	 */
	public String getOthersNumber() {
		return othersNumber;
	}

	/**
	 * @param othersNumber
	 *            The othersNumber to set.
	 */
	public void setOthersNumber(String othersNumber) {
		this.othersNumber = othersNumber;
	}

	/**
	 * @return Returns the railwayCrossingPermissionNumber.
	 */
	public String getRailwayCrossingPermissionNumber() {
		return railwayCrossingPermissionNumber;
	}

	/**
	 * @param railwayCrossingPermissionNumber
	 *            The railwayCrossingPermissionNumber to set.
	 */
	public void setRailwayCrossingPermissionNumber(
			String railwayCrossingPermissionNumber) {
		this.railwayCrossingPermissionNumber = railwayCrossingPermissionNumber;
	}

	/**
	 * @return Returns the roadCrossingPermissionNumber.
	 */
	public String getRoadCrossingPermissionNumber() {
		return roadCrossingPermissionNumber;
	}

	/**
	 * @param roadCrossingPermissionNumber
	 *            The roadCrossingPermissionNumber to set.
	 */
	public void setRoadCrossingPermissionNumber(
			String roadCrossingPermissionNumber) {
		this.roadCrossingPermissionNumber = roadCrossingPermissionNumber;
	}

	/**
	 * @return Returns the waterDrawlPermissionNumber.
	 */
	public String getWaterDrawlPermissionNumber() {
		return waterDrawlPermissionNumber;
	}

	/**
	 * @param waterDrawlPermissionNumber
	 *            The waterDrawlPermissionNumber to set.
	 */
	public void setWaterDrawlPermissionNumber(String waterDrawlPermissionNumber) {
		this.waterDrawlPermissionNumber = waterDrawlPermissionNumber;
	}

	/**
	 * @return Returns the landAquisitionNumber.
	 */
	public String getLandAquisitionNumber() {
		return landAquisitionNumber;
	}

	/**
	 * @param landAquisitionNumber
	 *            The landAquisitionNumber to set.
	 */
	public void setLandAquisitionNumber(String landAquisitionNumber) {
		this.landAquisitionNumber = landAquisitionNumber;
	}

	/**
	 * @return Returns the remarks.
	 */
	public String getRemarks() {
		return remarks;
	}

	/**
	 * @param remarks
	 *            The remarks to set.
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	/**
	 * @return Returns the isUpdate.
	 */
	public boolean isUpdate() {
		return isUpdate;
	}

	/**
	 * @param isUpdate
	 *            The isUpdate to set.
	 */
	public void setUpdate(boolean isUpdate) {
		this.isUpdate = isUpdate;
	}

	/**
	 * @return Returns the dprCompDate.
	 */
	public String getDprCompDate() {
		if(this.dprCompDate==null){
			return "";
		}
		return dprCompDate;
	}

	/**
	 * @param dprCompDate
	 *            The dprCompDate to set.
	 */
	public void setDprCompDate(String dprCompDate) {
		
		this.dprCompDate = dprCompDate;
	}

	/**
	 * @return Returns the forestClearance.
	 */
	public String getForestClearance() {
		if (this.forestClearance == null) {
			return "N";
		}
		return this.forestClearance;

	}

	/**
	 * @param forestClearance
	 *            The forestClearance to set.
	 */
	public void setForestClearance(String forestClearance) {
		this.forestClearance = forestClearance;
	}

	/**
	 * @return Returns the landAquisition.
	 */
	public String getLandAquisition() {
		if (this.landAquisition == null) {
			return "N";
		}

		return this.landAquisition;

	}

	/**
	 * @param landAquisition
	 *            The landAquisition to set.
	 */
	public void setLandAquisition(String landAquisition) {
		this.landAquisition = landAquisition;
	}

	/**
	 * @return Returns the others.
	 */
	public String getOthers() {
		if (this.others == null) {
			return "N";
		}
		return this.others;

	}

	/**
	 * @param others
	 *            The others to set.
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
	 * @param othersReason
	 *            The othersReason to set.
	 */
	public void setOthersReason(String othersReason) {
		this.othersReason = othersReason;
	}

	/**
	 * @return Returns the railwayCrossingPermission.
	 */
	public String getRailwayCrossingPermission() {
		if (this.railwayCrossingPermission == null) {
			return "N";
		}

		return this.railwayCrossingPermission;

	}

	/**
	 * @param railwayCrossingPermission
	 *            The railwayCrossingPermission to set.
	 */
	public void setRailwayCrossingPermission(String railwayCrossingPermission) {
		this.railwayCrossingPermission = railwayCrossingPermission;
	}

	/**
	 * @return Returns the roadCrossingPermission.
	 */
	public String getRoadCrossingPermission() {
		if (this.roadCrossingPermission == null) {
			return "N";
		}

		return this.roadCrossingPermission;

	}

	/**
	 * @param roadCrossingPermission
	 *            The roadCrossingPermission to set.
	 */
	public void setRoadCrossingPermission(String roadCrossingPermission) {
		this.roadCrossingPermission = roadCrossingPermission;
	}

	/**
	 * @return Returns the waterDrawlPermission.
	 */
	public String getWaterDrawlPermission() {
		if (this.waterDrawlPermission == null) {
			return "N";
		}
		return this.waterDrawlPermission;

	}

	/**
	 * @param waterDrawlPermission
	 *            The waterDrawlPermission to set.
	 */
	public void setWaterDrawlPermission(String waterDrawlPermission) {
		this.waterDrawlPermission = waterDrawlPermission;
	}

	/**
	 * @return Returns the workIdList.
	 */
	public String getWorkIdList() {
		return workIdList;
	}

	/**
	 * @param workIdList
	 *            The workIdList to set.
	 */
	public void setWorkIdList(String workIdList) {
		this.workIdList = workIdList;
	}

	private String category;

	/**
	 * @return Returns the category.
	 */
	public String getCategory() {
		return category;
	}

	/**
	 * @param category
	 *            The category to set.
	 */
	public void setCategory(String category) {
		this.category = category;
	}

	/**
	 * @return Returns the program.
	 */
	public String getProgram() {
		return program;
	}

	/**
	 * @param program
	 *            The program to set.
	 */
	public void setProgram(String program) {
		this.program = program;
	}

	/**
	 * @return Returns the sanctionedDate.
	 */
	public String getSanctionedDate() {
		return sanctionedDate;
	}

	/**
	 * @param sanctionedDate
	 *            The sanctionedDate to set.
	 */
	public void setSanctionedDate(String sanctionedDate) {
		this.sanctionedDate = sanctionedDate;
	}

	private String reason;

	/**
	 * @return Returns the reason.
	 */
	public String getReason() {
		return reason;
	}

	/**
	 * @param reason
	 *            The reason to set.
	 */
	public void setReason(String reason) {
		this.reason = reason;
	}

	/**
	 * @return Returns the sanctionedAmount.
	 */
	public String getSanctionedAmount() {
		return sanctionedAmount;
	}

	/**
	 * @param sanctionedAmount
	 *            The sanctionedAmount to set.
	 */
	public void setSanctionedAmount(String sanctionedAmount) {
		this.sanctionedAmount = sanctionedAmount;
	}

	/**
	 * @return Returns the workid.
	 */
	public String getWorkid() {
		return workid;
	}

	/**
	 * @param workid
	 *            The workid to set.
	 */
	public void setWorkid(String workid) {
		this.workid = workid;
	}

	/**
	 * @return Returns the finYear.
	 */
	public String getFinYear() {
		return finYear;
	}

	/**
	 * @param finYear
	 *            The finYear to set.
	 */
	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}

	/**
	 * @return Returns the circleCode.
	 */
	public String getCircleCode() {
		return circleCode;
	}

	/**
	 * @param circleCode
	 *            The circleCode to set.
	 */
	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}

	/**
	 * @return Returns the cmbDivision.
	 */
	public int getCmbDivision() {
		return cmbDivision;
	}

	/**
	 * @param cmbDivision
	 *            The cmbDivision to set.
	 */
	public void setCmbDivision(int cmbDivision) {
		this.cmbDivision = cmbDivision;
	}

	/**
	 * @return Returns the divCode.
	 */
	public int getDivCode() {
		return divCode;
	}

	/**
	 * @param divCode
	 *            The divCode to set.
	 */
	public void setDivCode(int divCode) {
		this.divCode = divCode;
	}

	/**
	 * @return Returns the divName.
	 */
	public String getDivName() {
		return divName;
	}

	/**
	 * @param divName
	 *            The divName to set.
	 */
	public void setDivName(String divName) {
		this.divName = divName;
	}

	/**
	 * @return Returns the programCode.
	 */
	public String getProgramCode() {
		return programCode;
	}

	/**
	 * @param programCode
	 *            The programCode to set.
	 */
	public void setProgramCode(String programCode) {
		this.programCode = programCode;
	}

	/**
	 * @return Returns the subDivCode.
	 */
	public String getSubDivCode() {
		return subDivCode;
	}

	/**
	 * @param subDivCode
	 *            The subDivCode to set.
	 */
	public void setSubDivCode(String subDivCode) {
		this.subDivCode = subDivCode;
	}

	/**
	 * @return Returns the subDivName.
	 */
	public String getSubDivName() {
		return subDivName;
	}

	/**
	 * @param subDivName
	 *            The subDivName to set.
	 */
	public void setSubDivName(String subDivName) {
		this.subDivName = subDivName;
	}

	/**
	 * @return Returns the subProgCode.
	 */
	public String getSubProgCode() {
		return subProgCode;
	}

	/**
	 * @param subProgCode
	 *            The subProgCode to set.
	 */
	public void setSubProgCode(String subProgCode) {
		this.subProgCode = subProgCode;
	}

	/**
	 * @return Returns the subProgName.
	 */
	public String getSubProgName() {
		return subProgName;
	}

	/**
	 * @param subProgName
	 *            The subProgName to set.
	 */
	public void setSubProgName(String subProgName) {
		this.subProgName = subProgName;
	}

	/**
	 * @return Returns the workName.
	 */
	public String getWorkName() {
		return workName;
	}

	/**
	 * @param workName
	 *            The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}

	/**
	 * @return Returns the dprStatus.
	 */
	public String getDprStatus() {
		return dprStatus;
	}

	/**
	 * @param dprStatus
	 *            The dprStatus to set.
	 */
	public void setDprStatus(String dprStatus) {
		this.dprStatus = dprStatus;
	}

	/**
	 * @return Returns the forestClearanceObtainDate.
	 */
	public String getForestClearanceObtainDate() {
		if(this.forestClearanceObtainDate==null){
			return "";
		}
		return forestClearanceObtainDate;
	}

	/**
	 * @param forestClearanceObtainDate
	 *            The forestClearanceObtainDate to set.
	 */
	public void setForestClearanceObtainDate(String forestClearanceObtainDate) {
		this.forestClearanceObtainDate = forestClearanceObtainDate;
	}

	/**
	 * @return Returns the landAquisitionObtainDate.
	 */
	public String getLandAquisitionObtainDate() {
		if(this.landAquisitionObtainDate==null){
		 return "";
		}
		
		return landAquisitionObtainDate;
	}

	/**
	 * @param landAquisitionObtainDate
	 *            The landAquisitionObtainDate to set.
	 */
	public void setLandAquisitionObtainDate(String landAquisitionObtainDate) {
		this.landAquisitionObtainDate = landAquisitionObtainDate;
	}

	/**
	 * @return Returns the othersObtainDate.
	 */
	public String getOthersObtainDate() {
		if(this.othersObtainDate==null){
			return "";
		}
		return othersObtainDate;
	}

	/**
	 * @param othersObtainDate
	 *            The othersObtainDate to set.
	 */
	public void setOthersObtainDate(String othersObtainDate) {
		this.othersObtainDate = othersObtainDate;
	}

	/**
	 * @return Returns the railwayCrossingPermissionObtainDate.
	 */
	public String getRailwayCrossingPermissionObtainDate() {
		if(this.railwayCrossingPermissionObtainDate==null){
			return "";
		}
		return railwayCrossingPermissionObtainDate;
	}

	/**
	 * @param railwayCrossingPermissionObtainDate
	 *            The railwayCrossingPermissionObtainDate to set.
	 */
	public void setRailwayCrossingPermissionObtainDate(
			String railwayCrossingPermissionObtainDate) {
		this.railwayCrossingPermissionObtainDate = railwayCrossingPermissionObtainDate;
	}

	/**
	 * @return Returns the roadCrossingPermissionObtainDate.
	 */
	public String getRoadCrossingPermissionObtainDate() {
		if(this.roadCrossingPermissionObtainDate==null){
			return "";
			
		}
		return roadCrossingPermissionObtainDate;
	}

	/**
	 * @param roadCrossingPermissionObtainDate
	 *            The roadCrossingPermissionObtainDate to set.
	 */
	public void setRoadCrossingPermissionObtainDate(
			String roadCrossingPermissionObtainDate) {
		this.roadCrossingPermissionObtainDate = roadCrossingPermissionObtainDate;
	}

	/**
	 * @return Returns the waterDrawlPermissionObtainDate.
	 */
	public String getWaterDrawlPermissionObtainDate() {
		if(this.waterDrawlPermissionObtainDate==null){
			return "";
		}
		return waterDrawlPermissionObtainDate;
	}

	/**
	 * @param waterDrawlPermissionObtainDate
	 *            The waterDrawlPermissionObtainDate to set.
	 */
	public void setWaterDrawlPermissionObtainDate(
			String waterDrawlPermissionObtainDate) {
		this.waterDrawlPermissionObtainDate = waterDrawlPermissionObtainDate;
	}

	/**
	 * @return Returns the roadCrossingPermissionNHAI.
	 */
	public String getRoadCrossingPermissionNHAI() {

		if (this.roadCrossingPermissionNHAI == null) {
			return "N";
		}

		return this.roadCrossingPermissionNHAI;
	}

	/**
	 * @param roadCrossingPermissionNHAI
	 *            The roadCrossingPermissionNHAI to set.
	 */
	public void setRoadCrossingPermissionNHAI(String roadCrossingPermissionNHAI) {
		this.roadCrossingPermissionNHAI = roadCrossingPermissionNHAI;
	}

	/**
	 * @return Returns the roadCrossingNHAIObtainDate.
	 */
	public String getRoadCrossingNHAIObtainDate() {
		if(this.roadCrossingNHAIObtainDate==null){
			return "";
		}
		return roadCrossingNHAIObtainDate;
	}

	/**
	 * @param roadCrossingNHAIObtainDate
	 *            The roadCrossingNHAIObtainDate to set.
	 */
	public void setRoadCrossingNHAIObtainDate(String roadCrossingNHAIObtainDate) {
		this.roadCrossingNHAIObtainDate = roadCrossingNHAIObtainDate;
	}

	/**
	 * @return Returns the roadCrossingObtainNHAINumber.
	 */
	public String getRoadCrossingObtainNHAINumber() {
		return roadCrossingObtainNHAINumber;
	}

	/**
	 * @param roadCrossingObtainNHAINumber
	 *            The roadCrossingObtainNHAINumber to set.
	 */
	public void setRoadCrossingObtainNHAINumber(
			String roadCrossingObtainNHAINumber) {
		this.roadCrossingObtainNHAINumber = roadCrossingObtainNHAINumber;
	}

	/**
	 * @return Returns the powerAPTranscoObtainDate.
	 */
	public String getPowerAPTranscoObtainDate() {
		if(this.powerAPTranscoObtainDate==null){
			return "";
		}
		return powerAPTranscoObtainDate;
	}

	/**
	 * @param powerAPTranscoObtainDate
	 *            The powerAPTranscoObtainDate to set.
	 */
	public void setPowerAPTranscoObtainDate(String powerAPTranscoObtainDate) {
		this.powerAPTranscoObtainDate = powerAPTranscoObtainDate;
	}

	/**
	 * @return Returns the powerAPTranscoObtainNumber.
	 */
	public String getPowerAPTranscoObtainNumber() {
		return powerAPTranscoObtainNumber;
	}

	/**
	 * @param powerAPTranscoObtainNumber
	 *            The powerAPTranscoObtainNumber to set.
	 */
	public void setPowerAPTranscoObtainNumber(String powerAPTranscoObtainNumber) {
		this.powerAPTranscoObtainNumber = powerAPTranscoObtainNumber;
	}

	/**
	 * @return Returns the powerAPTranscoReq.
	 */
	public String getPowerAPTranscoReq() {
		if (this.powerAPTranscoReq == null) {
			return "N";
		}
		return powerAPTranscoReq;
	}

	/**
	 * @param powerAPTranscoReq
	 *            The powerAPTranscoReq to set.
	 */
	public void setPowerAPTranscoReq(String powerAPTranscoReq) {
		this.powerAPTranscoReq = powerAPTranscoReq;
	}

	/**
	 * @return Returns the powerAPTranscoReqDate.
	 */
	public String getPowerAPTranscoReqDate() {
		if(this.powerAPTranscoReqDate==null){
			return "";
		}
		return powerAPTranscoReqDate;
	}

	/**
	 * @param powerAPTranscoReqDate
	 *            The powerAPTranscoReqDate to set.
	 */
	public void setPowerAPTranscoReqDate(String powerAPTranscoReqDate) {
		this.powerAPTranscoReqDate = powerAPTranscoReqDate;
	}

	/**
	 * @return Returns the powerAPTranscoReqNumber.
	 */
	public String getPowerAPTranscoReqNumber() {
		return powerAPTranscoReqNumber;
	}

	/**
	 * @param powerAPTranscoReqNumber
	 *            The powerAPTranscoReqNumber to set.
	 */
	public void setPowerAPTranscoReqNumber(String powerAPTranscoReqNumber) {
		this.powerAPTranscoReqNumber = powerAPTranscoReqNumber;
	}

	/**
	 * @return Returns the partAAmount.
	 */
	public String getPartAAmount() {
		return partAAmount;
	}

	/**
	 * @param partAAmount
	 *            The partAAmount to set.
	 */
	public void setPartAAmount(String partAAmount) {
		this.partAAmount = partAAmount;
	}

	/**
	 * @return Returns the hmwsReqobtainDate.
	 */
	public String getHmwsReqobtainDate() {
		if(this.hmwsReqobtainDate==null){
			return "";
		}
		return hmwsReqobtainDate;
	}

	/**
	 * @param hmwsReqobtainDate
	 *            The hmwsReqobtainDate to set.
	 */
	public void setHmwsReqobtainDate(String hmwsReqobtainDate) {
		this.hmwsReqobtainDate = hmwsReqobtainDate;
	}

	/**
	 * @return Returns the hmwsReqobtainNum.
	 */
	public String getHmwsReqobtainNum() {
		return hmwsReqobtainNum;
	}

	/**
	 * @param hmwsReqobtainNum
	 *            The hmwsReqobtainNum to set.
	 */
	public void setHmwsReqobtainNum(String hmwsReqobtainNum) {
		this.hmwsReqobtainNum = hmwsReqobtainNum;
	}

	/**
	 * @return Returns the dprCharges.
	 */
	public String getDprCharges() {
		return dprCharges;
	}

	/**
	 * @param dprCharges
	 *            The dprCharges to set.
	 */
	public void setDprCharges(String dprCharges) {
		this.dprCharges = dprCharges;
	}

	/**
	 * @return Returns the groundWaterInvestigationChg.
	 */
	public String getGroundWaterInvestigationChg() {
		return groundWaterInvestigationChg;
	}

	/**
	 * @param groundWaterInvestigationChg
	 *            The groundWaterInvestigationChg to set.
	 */
	public void setGroundWaterInvestigationChg(
			String groundWaterInvestigationChg) {
		this.groundWaterInvestigationChg = groundWaterInvestigationChg;
	}

	/**
	 * @return Returns the sourceCreationChg.
	 */
	public String getSourceCreationChg() {
		return sourceCreationChg;
	}

	/**
	 * @param sourceCreationChg
	 *            The sourceCreationChg to set.
	 */
	public void setSourceCreationChg(String sourceCreationChg) {
		this.sourceCreationChg = sourceCreationChg;
	}

	/**
	 * @return Returns the yieldTestingChg.
	 */
	public String getYieldTestingChg() {
		return yieldTestingChg;
	}

	/**
	 * @param yieldTestingChg
	 *            The yieldTestingChg to set.
	 */
	public void setYieldTestingChg(String yieldTestingChg) {
		this.yieldTestingChg = yieldTestingChg;
	}

	/**
	 *  
	 */
	public void allReset() {
		this.groundWaterInvestigationChg = "";
		this.yieldTestingChg = "";
		this.sourceCreationChg = "";
		this.landAquisitionChrg = "";
		this.waterDrawlPermissionChrg = "";

		this.railwayCrossingPermissionChrg = "";

		this.roadCrossingPermissionChrg = "";

		this.roadCrossingPermissionNHAIChrg = "";
		this.forestClearanceChrg = "";

		this.othersChrg = "";

		this.partAAmount = "";
		this.hmwsReq="";
		this.powerAPTranscoReq="";
		this.powerAPTranscoObtainDate="";
		this.powerAPTranscoChrgs="";
		this.powerAPTranscoObtainNumber="";
		this.powerAPTranscoReqDate="";
		this.powerAPTranscoReqNumber="";
		this.hmwsChrgs="";
		this.hmwsReq="";
		this.hmwsReqDate="";
		this.hmwsReqNum="";
		this.hmwsReqobtainDate="";
		this.hmwsReqobtainNum="";
		this.dprPrepartion="";
		this.dprCharges="";
		this.agencyName="";
		
		
	}
	public String getWorkidS() {
		return workidS;
	}
	public void setWorkidS(String workidS) {
		this.workidS = workidS;
	}
}