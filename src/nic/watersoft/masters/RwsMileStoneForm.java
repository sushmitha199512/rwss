
package nic.watersoft.masters;

import org.apache.struts.action.ActionForm;

public class RwsMileStoneForm  extends ActionForm {
	
	
	String mileStoneCode;
	String mileStoneName;
	String mode;
	String ddwsStatus;
	double phyPercentage;
	
	

	public double getPhyPercentage() {
		return phyPercentage;
	}
	public void setPhyPercentage(double phyPercentage) {
		this.phyPercentage = phyPercentage;
	}
	public String getDdwsStatus() {
		return ddwsStatus;
	}
	public void setDdwsStatus(String ddwsStatus) {
		this.ddwsStatus = ddwsStatus;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}
	/**
	 * @return Returns the mileStoneCode.
	 */
	public String getMileStoneCode() {
		return mileStoneCode;
	}
	/**
	 * @param mileStoneCode The mileStoneCode to set.
	 */
	public void setMileStoneCode(String mileStoneCode) {
		this.mileStoneCode = mileStoneCode;
	}
	/**
	 * @return Returns the mileStoneName.
	 */
	public String getMileStoneName() {
		return mileStoneName;
	}
	/**
	 * @param mileStoneName The mileStoneName to set.
	 */
	public void setMileStoneName(String mileStoneName) {
		this.mileStoneName = mileStoneName;
	}
}
