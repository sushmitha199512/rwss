/*
 * Created on Feb 10, 2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;


import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class DroughtFlushRecords implements Serializable{

	private String thabitationCode;
	
	private String thabName;
	

	private String hpCode;

	private String flushDate;

	private String flushRemarks;

	private String flushDeepening;
	private String flushDepth;
	
	private boolean isUpdate;
	private String checks;
	private ArrayList hps;
	private String conFlush;
	private String conDeep;
	private String year;
	/**
	 * @return Returns the conDeep.
	 */
	public String getConDeep() {
		return conDeep;
	}
	/**
	 * @param conDeep The conDeep to set.
	 */
	public void setConDeep(String conDeep) {
		this.conDeep = conDeep;
	}
	/**
	 * @return Returns the conFlush.
	 */
	public String getConFlush() {
		return conFlush;
	}
	/**
	 * @param conFlush The conFlush to set.
	 */
	public void setConFlush(String conFlush) {
		this.conFlush = conFlush;
	}
	private String status;
	/**
	 * @return Returns the location.
	 */
	public String getLocation() {
		return location;
	}
	/**
	 * @param location The location to set.
	 */
	public void setLocation(String location) {
		this.location = location;
	}
	/**
	 * @return Returns the status.
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status The status to set.
	 */
	public void setStatus(String status) {
		this.status = status;
	}
    private String location;
	
	
	/**
	 * @return Returns the hps.
	 */
	public ArrayList getHps() {
		return hps;
	}
	/**
	 * @param hps The hps to set.
	 */
	public void setHps(ArrayList hps) {
		this.hps = hps;
	}
	/**
	 * @return Returns the checks.
	 */
	public String getChecks() {
		return checks;
	}
	/**
	 * @param checks The checks to set.
	 */
	public void setChecks(String checks) {
		this.checks = checks;
	}
	/**
	 * @return Returns the isUpdate.
	 */
	public boolean isUpdate() {
		return isUpdate;
	}
	/**
	 * @param isUpdate The isUpdate to set.
	 */
	public void setUpdate(boolean isUpdate) {
		this.isUpdate = isUpdate;
	}
	/**
	 * @return Returns the flushDate.
	 */
	public String getFlushDate() {
		return flushDate;
	}
	/**
	 * @param flushDate The flushDate to set.
	 */
	public void setFlushDate(String flushDate) {
		this.flushDate = flushDate;
	}
	/**
	 * @return Returns the flushDeepening.
	 */
	public String getFlushDeepening() {
		return flushDeepening;
	}
	/**
	 * @param flushDeepening The flushDeepening to set.
	 */
	public void setFlushDeepening(String flushDeepening) {
		this.flushDeepening = flushDeepening;
	}
	/**
	 * @return Returns the flushRemarks.
	 */
	public String getFlushRemarks() {
		return flushRemarks;
	}
	/**
	 * @param flushRemarks The flushRemarks to set.
	 */
	public void setFlushRemarks(String flushRemarks) {
		this.flushRemarks = flushRemarks;
	}
	/**
	 * @return Returns the hpCode.
	 */
	public String getHpCode() {
		return hpCode;
	}
	/**
	 * @param hpCode The hpCode to set.
	 */
	public void setHpCode(String hpCode) {
		this.hpCode = hpCode;
	}
	/**
	 * @return Returns the thabitationCode.
	 */
	public String getThabitationCode() {
		return thabitationCode;
	}
	/**
	 * @param thabitationCode The thabitationCode to set.
	 */
	public void setThabitationCode(String thabitationCode) {
		this.thabitationCode = thabitationCode;
	}
	/**
	 * @return Returns the thabName.
	 */
	public String getThabName() {
		return thabName;
	}
	/**
	 * @param thabName The thabName to set.
	 */
	public void setThabName(String thabName) {
		this.thabName = thabName;
	}
	/**
	 * @return Returns the flushDepth.
	 */
	public String getFlushDepth() {
		return flushDepth;
	}
	/**
	 * @param flushDepth The flushDepth to set.
	 */
	public void setFlushDepth(String flushDepth) {
		this.flushDepth = flushDepth;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
}