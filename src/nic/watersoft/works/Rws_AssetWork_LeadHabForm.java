package nic.watersoft.works;

import java.util.ArrayList;


import org.apache.struts.action.ActionForm;


public class Rws_AssetWork_LeadHabForm extends ActionForm
{
	
	private String checks="";
	private String leadHab="";
	private String leadName="";
	private String dist="";
	private String mcode="";
	private String pcode="";
	private String habCode="";
	private String habName="";
	private String assetCd1="";
	private String assetCode="";
	private String assetName="";
	private String mode;
	private String workId;
	private String workName;
	private String workHabCode;
	private String workHabName;
	private String typeOfAsset;
	private String assetCode1="";
	
	private ArrayList assets;
	private ArrayList habs;
	
	
	public String getAssetCode1() {
		return assetCode1;
	}
	public void setAssetCode1(String assetCode1) {
		this.assetCode1 = assetCode1;
	}
	public String getTypeOfAsset() {
		return typeOfAsset;
	}
	public void setTypeOfAsset(String typeOfAsset) {
		this.typeOfAsset = typeOfAsset;
	}
	public String getAssetCd1() {
		return assetCd1;
	}
	public void setAssetCd1(String assetCd1) {
		this.assetCd1 = assetCd1;
	}
	public ArrayList getHabs() {
		return habs;
	}
	public void setHabs(ArrayList habs) {
		this.habs = habs;
	}
	public String getDist() {
		return dist;
	}
	public void setDist(String dist) {
		this.dist = dist;
	}
	public String getMcode() {
		return mcode;
	}
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	public String getHabName() {
		return habName;
	}
	public void setHabName(String habName) {
		this.habName = habName;
	}
	public String getLeadHab() {
		return leadHab;
	}
	public void setLeadHab(String leadHab) {
		this.leadHab = leadHab;
	}
	public String getLeadName() {
		return leadName;
	}
	public void setLeadName(String leadName) {
		this.leadName = leadName;
	}
	public String getChecks() {
		return checks;
	}
	public void setChecks(String checks) {
		this.checks = checks;
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
	 * @return Returns the assetCode.
	 */
	public String getAssetCode() {
		return assetCode;
	}
	/**
	 * @param workId The assetCode to set.
	 */
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	/**
	 * @return Returns the assetName.
	 */
	public String getAssetName() {
		return assetName;
	}
	/**
	 * @param workName The workName to set.
	 */
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	/**
	 * @return Returns the works.
	 */
	public ArrayList getAssets() {
		return assets;
	}
	/**
	 * @param works The works to set.
	 */
	public void setAssets(ArrayList assets) {
		this.assets = assets;
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
	public String getWorkHabCode() {
		return workHabCode;
	}
	public void setWorkHabCode(String workHabCode) {
		this.workHabCode = workHabCode;
	}
	public String getWorkHabName() {
		return workHabName;
	}
	public void setWorkHabName(String workHabName) {
		this.workHabName = workHabName;
	}
}
