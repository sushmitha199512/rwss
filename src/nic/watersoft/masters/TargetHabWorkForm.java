package nic.watersoft.masters;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author SREELAXMI
 * 
 */
public class TargetHabWorkForm extends ActionForm {
	private String dist = "";
	private String finYear = "";
	private String svsHabs = "";
	private String svsExp = "";
	private String mvsHabs = "";
	private String mvsExp = "";
	private String schHabs = "";
	private String angHabs = "";
	private String mode = "";
	private String districtName = "";
	private ArrayList targets;
	// Added on 13-11-2013
	private String noofVwsctrained = "";
	private String trtoFtkkits = "";
	private String wqftkTests = "";

	private String pcHabs;
	private String qaHabs;
	private String pwsHabitations;
	private String houseConnections;

	//

	public String getNoofVwsctrained() {
		return noofVwsctrained;
	}

	public void setNoofVwsctrained(String noofVwsctrained) {
		this.noofVwsctrained = noofVwsctrained;
	}

	public String getTrtoFtkkits() {
		return trtoFtkkits;
	}

	public void setTrtoFtkkits(String trtoFtkkits) {
		this.trtoFtkkits = trtoFtkkits;
	}

	public String getWqftkTests() {
		return wqftkTests;
	}

	public void setWqftkTests(String wqftkTests) {
		this.wqftkTests = wqftkTests;
	}

	public ArrayList getTargets() {
		return targets;
	}

	public void setTargets(ArrayList targets) {
		this.targets = targets;
	}

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}

	/**
	 * @param mode
	 *            The mode to set.
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}

	/**
	 * @return Returns the angHabs.
	 */
	public String getAngHabs() {
		return angHabs;
	}

	/**
	 * @param angHabs
	 *            The angHabs to set.
	 */
	public void setAngHabs(String angHabs) {
		this.angHabs = angHabs;
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
	 * @return Returns the mvsExp.
	 */
	public String getMvsExp() {
		return mvsExp;
	}

	/**
	 * @param mvsExp
	 *            The mvsExp to set.
	 */
	public void setMvsExp(String mvsExp) {
		this.mvsExp = mvsExp;
	}

	/**
	 * @return Returns the mvsHabs.
	 */
	public String getMvsHabs() {
		return mvsHabs;
	}

	/**
	 * @param mvsHabs
	 *            The mvsHabs to set.
	 */
	public void setMvsHabs(String mvsHabs) {
		this.mvsHabs = mvsHabs;
	}

	/**
	 * @return Returns the schHabs.
	 */
	public String getSchHabs() {
		return schHabs;
	}

	/**
	 * @param schHabs
	 *            The schHabs to set.
	 */
	public void setSchHabs(String schHabs) {
		this.schHabs = schHabs;
	}

	/**
	 * @return Returns the svsExp.
	 */
	public String getSvsExp() {
		return svsExp;
	}

	/**
	 * @param svsExp
	 *            The svsExp to set.
	 */
	public void setSvsExp(String svsExp) {
		this.svsExp = svsExp;
	}

	/**
	 * @return Returns the svsHabs.
	 */
	public String getSvsHabs() {
		return svsHabs;
	}

	/**
	 * @param svsHabs
	 *            The svsHabs to set.
	 */
	public void setSvsHabs(String svsHabs) {
		this.svsHabs = svsHabs;
	}

	
	public String getPwsHabitations() {
		return pwsHabitations;
	}

	public void setPwsHabitations(String pwsHabitations) {
		this.pwsHabitations = pwsHabitations;
	}

	public String getHouseConnections() {
		return houseConnections;
	}

	public void setHouseConnections(String houseConnections) {
		this.houseConnections = houseConnections;
	}

	public String getPcHabs() {
		return pcHabs;
	}

	public void setPcHabs(String pcHabs) {
		this.pcHabs = pcHabs;
	}

	public String getQaHabs() {
		return qaHabs;
	}

	public void setQaHabs(String qaHabs) {
		this.qaHabs = qaHabs;
	}

	
	
	
	
}