/*
 * Created on 20-03-2013
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
public class RwsWorkLinkActionForm extends ActionForm implements Serializable {


	String oldWorkId;

	String newWorkId;

	String oldWorkName;

	String oldProgram;

	String oldSanctionedDate;

	String oldSanctionedAmount;

	String oldSubProgName;

	String newWorkName;

	String newProgram;

	String newSanctionedDate;

	String newSanctionedAmount;

	String newSubProgName;

	String oldReleasesSoFar;
	String adminHabs;
	

	/**
	 * @return Returns the adminHabs.
	 */
	public String getAdminHabs() {
		return adminHabs;
	}
	/**
	 * @param adminHabs The adminHabs to set.
	 */
	public void setAdminHabs(String adminHabs) {
		this.adminHabs = adminHabs;
	}
	/**
	 * @return Returns the oldProgram.
	 */
	public String getOldProgram() {
		return oldProgram;
	}

	/**
	 * @return Returns the newProgram.
	 */
	public String getNewProgram() {
		return newProgram;
	}

	/**
	 * @param newProgram
	 *            The newProgram to set.
	 */
	public void setNewProgram(String newProgram) {
		this.newProgram = newProgram;
	}

	/**
	 * @return Returns the newSanctionedAmount.
	 */
	public String getNewSanctionedAmount() {
		return newSanctionedAmount;
	}

	/**
	 * @param newSanctionedAmount
	 *            The newSanctionedAmount to set.
	 */
	public void setNewSanctionedAmount(String newSanctionedAmount) {
		this.newSanctionedAmount = newSanctionedAmount;
	}

	/**
	 * @return Returns the newSanctionedDate.
	 */
	public String getNewSanctionedDate() {
		return newSanctionedDate;
	}

	/**
	 * @param newSanctionedDate
	 *            The newSanctionedDate to set.
	 */
	public void setNewSanctionedDate(String newSanctionedDate) {
		this.newSanctionedDate = newSanctionedDate;
	}

	/**
	 * @return Returns the newSubProgName.
	 */
	public String getNewSubProgName() {
		return newSubProgName;
	}

	/**
	 * @param newSubProgName
	 *            The newSubProgName to set.
	 */
	public void setNewSubProgName(String newSubProgName) {
		this.newSubProgName = newSubProgName;
	}

	/**
	 * @return Returns the newWorkName.
	 */
	public String getNewWorkName() {
		return newWorkName;
	}

	/**
	 * @param newWorkName
	 *            The newWorkName to set.
	 */
	public void setNewWorkName(String newWorkName) {
		this.newWorkName = newWorkName;
	}

	/**
	 * @param oldProgram
	 *            The oldProgram to set.
	 */
	public void setOldProgram(String oldProgram) {
		this.oldProgram = oldProgram;
	}

	/**
	 * @return Returns the oldSanctionedAmount.
	 */
	public String getOldSanctionedAmount() {
		return oldSanctionedAmount;
	}

	/**
	 * @param oldSanctionedAmount
	 *            The oldSanctionedAmount to set.
	 */
	public void setOldSanctionedAmount(String oldSanctionedAmount) {
		this.oldSanctionedAmount = oldSanctionedAmount;
	}

	/**
	 * @return Returns the oldSanctionedDate.
	 */
	public String getOldSanctionedDate() {
		return oldSanctionedDate;
	}

	/**
	 * @param oldSanctionedDate
	 *            The oldSanctionedDate to set.
	 */
	public void setOldSanctionedDate(String oldSanctionedDate) {
		this.oldSanctionedDate = oldSanctionedDate;
	}

	/**
	 * @return Returns the oldWorkName.
	 */
	public String getOldWorkName() {
		return oldWorkName;
	}

	/**
	 * @param oldWorkName
	 *            The oldWorkName to set.
	 */
	public void setOldWorkName(String oldWorkName) {
		this.oldWorkName = oldWorkName;
	}

	/**
	 * @return Returns the newWorkId.
	 */
	public String getNewWorkId() {
		return newWorkId;
	}

	/**
	 * @param newWorkId
	 *            The newWorkId to set.
	 */
	public void setNewWorkId(String newWorkId) {
		this.newWorkId = newWorkId;
	}

	/**
	 * @return Returns the oldWorkId.
	 */
	public String getOldWorkId() {
		return oldWorkId;
	}

	/**
	 * @param oldWorkId
	 *            The oldWorkId to set.
	 */
	public void setOldWorkId(String oldWorkId) {
		this.oldWorkId = oldWorkId;
	}

	/**
	 * @return Returns the oldSubProgName.
	 */
	public String getOldSubProgName() {
		return oldSubProgName;
	}

	/**
	 * @param oldSubProgName
	 *            The oldSubProgName to set.
	 */
	public void setOldSubProgName(String oldSubProgName) {
		this.oldSubProgName = oldSubProgName;
	}

	/**
	 * @return Returns the oldReleasesSoFar.
	 */
	public String getOldReleasesSoFar() {
		return oldReleasesSoFar;
	}

	/**
	 * @param oldReleasesSoFar
	 *            The oldReleasesSoFar to set.
	 */
	public void setOldReleasesSoFar(String oldReleasesSoFar) {
		this.oldReleasesSoFar = oldReleasesSoFar;
	}
}