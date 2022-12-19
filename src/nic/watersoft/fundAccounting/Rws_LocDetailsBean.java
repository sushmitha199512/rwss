/*
 * Created on Aug 10, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import java.io.Serializable;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_LocDetailsBean implements Serializable
{
	String locId;
	String broId;
	String circleLocId;
	String broAmount;
	String broAmountAlreadyAllocatedForLOCs;
	String remainingAmountToBeAllocated;
	String locReference;
	String locRelDate;
	String locAmount;
	String dwaAuthorisationReference;
	String dwaAuthorisationDate;
	private String broReference;
	String broRemainingAmountToBeAllocated;
	String programmeCode;
	String programmeName;
	String amountAllocatedToOtherCLOCIds;
	String workId;
	String workName;
	String brodate;

	
	/**
	 * @return Returns the brodate.
	 */
	public String getBrodate() {
		return brodate;
	}
	/**
	 * @param brodate The brodate to set.
	 */
	public void setBrodate(String brodate) {
		this.brodate = brodate;
	}
	public String getBroReference() {
		return broReference;
	}
	public void setBroReference(String broReference) {
		this.broReference = broReference;
	}
	public String getDwaAuthorisationDate() {
		return dwaAuthorisationDate;
	}
	public void setDwaAuthorisationDate(String dwaAuthorisationDate) {
		this.dwaAuthorisationDate = dwaAuthorisationDate;
	}
	public String getDwaAuthorisationReference() {
		return dwaAuthorisationReference;
	}
	public void setDwaAuthorisationReference(String dwaAuthorisationReference) {
		this.dwaAuthorisationReference = dwaAuthorisationReference;
	}
	public String getLocAmount() {
		return locAmount;
	}
	public void setLocAmount(String locAmount) {
		this.locAmount = locAmount;
	}
	public String getLocId() {
		return locId;
	}
	public void setLocId(String locId) {
		this.locId = locId;
	}
	public String getLocReference() {
		return locReference;
	}
	public void setLocReference(String locReference) {
		this.locReference = locReference;
	}
	public String getLocRelDate() {
		return locRelDate;
	}
	public void setLocRelDate(String locRelDate) {
		this.locRelDate = locRelDate;
	}
	public String getBroAmount() {
		return broAmount;
	}
	public void setBroAmount(String broAmount) {
		this.broAmount = broAmount;
	}
	public String getBroId() {
		return broId;
	}
	public void setBroId(String broId) {
		this.broId = broId;
	}
	public String getBroAmountAlreadyAllocatedForLOCs() {
		return broAmountAlreadyAllocatedForLOCs;
	}
	public void setBroAmountAlreadyAllocatedForLOCs(
			String broAmountAlreadyAllocatedForLOCs) {
		this.broAmountAlreadyAllocatedForLOCs = broAmountAlreadyAllocatedForLOCs;
	}
	public String getRemainingAmountToBeAllocated() {
		return remainingAmountToBeAllocated;
	}
	public void setRemainingAmountToBeAllocated(
			String remainingAmountToBeAllocated) {
		this.remainingAmountToBeAllocated = remainingAmountToBeAllocated;
	}
	public String getBroRemainingAmountToBeAllocated() {
		return broRemainingAmountToBeAllocated;
	}
	public void setBroRemainingAmountToBeAllocated(
			String broRemainingAmountToBeAllocated) {
		this.broRemainingAmountToBeAllocated = broRemainingAmountToBeAllocated;
	}
	public String getProgrammeCode() {
		return programmeCode;
	}
	public void setProgrammeCode(String programmeCode) {
		this.programmeCode = programmeCode;
	}
	public String getProgrammeName() {
		return programmeName;
	}
	public void setProgrammeName(String programmeName) {
		this.programmeName = programmeName;
	}
	public String getCircleLocId() {
		return circleLocId;
	}
	public void setCircleLocId(String circleLocId) {
		this.circleLocId = circleLocId;
	}
	public String getAmountAllocatedToOtherCLOCIds() {
		return amountAllocatedToOtherCLOCIds;
	}
	public void setAmountAllocatedToOtherCLOCIds(
			String amountAllocatedToOtherCLOCIds) {
		this.amountAllocatedToOtherCLOCIds = amountAllocatedToOtherCLOCIds;
	}
	public String getWorkId() {
		return workId;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public String getWorkName() {
		return workName;
	}
	public void setWorkName(String workName) {
		this.workName = workName;
	}
}
