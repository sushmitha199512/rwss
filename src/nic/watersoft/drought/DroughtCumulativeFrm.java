/*
 * Created on 28-Feb-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * @author NIC
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class DroughtCumulativeFrm extends ActionForm {

	private String dist;

	private String mand;

	ArrayList habs = new ArrayList();

	String habCode;

	String habName;

	String checks;

	String frmDate;

	String toDate;

	int transportationEST;

	int hiringOfSourcesEST;

	int flushingEST;

	int deepeningEST;

	int powerProblemEST;
	
	 String financialYear;

	/**
	 * @return Returns the financialYear.
	 */
	public String getFinancialYear() {
		return financialYear;
	}
	/**
	 * @param financialYear The financialYear to set.
	 */
	public void setFinancialYear(String financialYear) {
		this.financialYear = financialYear;
	}
	/**
	 * @return Returns the deepeningEST.
	 */
	public int getDeepeningEST() {
		return deepeningEST;
	}
	/**
	 * @param deepeningEST The deepeningEST to set.
	 */
	public void setDeepeningEST(int deepeningEST) {
		this.deepeningEST = deepeningEST;
	}
	/**
	 * @return Returns the flushingEST.
	 */
	public int getFlushingEST() {
		return flushingEST;
	}
	/**
	 * @param flushingEST The flushingEST to set.
	 */
	public void setFlushingEST(int flushingEST) {
		this.flushingEST = flushingEST;
	}
	/**
	 * @return Returns the frmDate.
	 */
	public String getFrmDate() {
		return frmDate;
	}
	/**
	 * @param frmDate The frmDate to set.
	 */
	public void setFrmDate(String frmDate) {
		this.frmDate = frmDate;
	}
	/**
	 * @return Returns the hiringOfSourcesEST.
	 */
	public int getHiringOfSourcesEST() {
		return hiringOfSourcesEST;
	}
	/**
	 * @param hiringOfSourcesEST The hiringOfSourcesEST to set.
	 */
	public void setHiringOfSourcesEST(int hiringOfSourcesEST) {
		this.hiringOfSourcesEST = hiringOfSourcesEST;
	}
	/**
	 * @return Returns the powerProblemEST.
	 */
	public int getPowerProblemEST() {
		return powerProblemEST;
	}
	/**
	 * @param powerProblemEST The powerProblemEST to set.
	 */
	public void setPowerProblemEST(int powerProblemEST) {
		this.powerProblemEST = powerProblemEST;
	}
	/**
	 * @return Returns the toDate.
	 */
	public String getToDate() {
		return toDate;
	}
	/**
	 * @param toDate The toDate to set.
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	/**
	 * @return Returns the transportationEST.
	 */
	public int getTransportationEST() {
		return transportationEST;
	}
	/**
	 * @param transportationEST The transportationEST to set.
	 */
	public void setTransportationEST(int transportationEST) {
		this.transportationEST = transportationEST;
	}
	/**
	 * @return Returns the checks.
	 */
	public String getChecks() {
		return checks;
	}

	/**
	 * @param checks
	 *            The checks to set.
	 */
	public void setChecks(String checks) {
		this.checks = checks;
	}

	/**
	 * @return Returns the habCode.
	 */
	public String getHabCode() {
		return habCode;
	}

	/**
	 * @param habCode
	 *            The habCode to set.
	 */
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}

	/**
	 * @return Returns the habName.
	 */
	public String getHabName() {
		return habName;
	}

	/**
	 * @param habName
	 *            The habName to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
	}

	/**
	 * @return Returns the habs.
	 */
	public ArrayList getHabs() {
		return habs;
	}

	/**
	 * @param habs
	 *            The habs to set.
	 */
	public void setHabs(ArrayList habs) {
		this.habs = habs;
	}

	/**
	 * @return Returns the dist.
	 */
	public String getDist() {
		return dist;
	}

	/**
	 * @param dist
	 *            The dist to set.
	 */
	public void setDist(String dist) {
		this.dist = dist;
	}

	/**
	 * @return Returns the mand.
	 */
	public String getMand() {
		return mand;
	}

	/**
	 * @param mand
	 *            The mand to set.
	 */
	public void setMand(String mand) {
		this.mand = mand;
	}
}