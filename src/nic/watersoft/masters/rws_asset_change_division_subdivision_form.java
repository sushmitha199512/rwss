package nic.watersoft.masters;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/** form bean classes* */
public class rws_asset_change_division_subdivision_form extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	 private String circle;
	 private String circleName;
	 
	 private String division;

	private String subDivision;
	
	private String circleOfficeCode;
	
	private String divisionOfficeCode;
	
	private String subDivisionOfficeCode;
	
	private String prasentDivision;
	
	private String prasentSubDivision;
	
	private String assetCode;
	
	private String assetName;
	
	private String habCode;
	
	private String habName;
	
	private String location;
	
	private String checks;
	
	private String assetCost;
	
	private String changeToDivision;
	
	private String changeToSubDivision;
	
	private String changeToDivisionCode;
	
	private String changeToSubDivisionCode;
	
	private String workasset;
	
	private String typeOfAsset;
	
	
	
	
	public String getTypeOfAsset() {
		return typeOfAsset;
	}

	public void setTypeOfAsset(String typeOfAsset) {
		this.typeOfAsset = typeOfAsset;
	}

	public String getChangeToDivisionCode() {
		return changeToDivisionCode;
	}

	public void setChangeToDivisionCode(String changeToDivisionCode) {
		this.changeToDivisionCode = changeToDivisionCode;
	}

	public String getChangeToSubDivisionCode() {
		return changeToSubDivisionCode;
	}

	public void setChangeToSubDivisionCode(String changeToSubDivisionCode) {
		this.changeToSubDivisionCode = changeToSubDivisionCode;
	}

	public String getWorkasset() {
		return workasset;
	}

	public void setWorkasset(String workasset) {
		this.workasset = workasset;
	}

	public String getChangeToDivision() {
		return changeToDivision;
	}

	public void setChangeToDivision(String changeToDivision) {
		this.changeToDivision = changeToDivision;
	}

	public String getChangeToSubDivision() {
		return changeToSubDivision;
	}

	public void setChangeToSubDivision(String changeToSubDivision) {
		this.changeToSubDivision = changeToSubDivision;
	}

	public String getAssetCost() {
		return assetCost;
	}

	public void setAssetCost(String assetCost) {
		this.assetCost = assetCost;
	}

	private ArrayList<rws_asset_change_division_subdivision_form> habs;
	private ArrayList<rws_asset_change_division_subdivision_form> assethabs;
	
	
	

	public String getCircleName() {
		return circleName;
	}

	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}

	public ArrayList<rws_asset_change_division_subdivision_form> getHabs() {
		return habs;
	}

	public void setHabs(ArrayList<rws_asset_change_division_subdivision_form> habs) {
		this.habs = habs;
	}

	public ArrayList<rws_asset_change_division_subdivision_form> getAssethabs() {
		return assethabs;
	}

	public void setAssethabs(
			ArrayList<rws_asset_change_division_subdivision_form> assethabs) {
		this.assethabs = assethabs;
	}

	public String getChecks() {
		return checks;
	}

	public void setChecks(String checks) {
		this.checks = checks;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getPrasentDivision() {
		return prasentDivision;
	}

	public void setPrasentDivision(String prasentDivision) {
		this.prasentDivision = prasentDivision;
	}

	public String getPrasentSubDivision() {
		return prasentSubDivision;
	}

	public void setPrasentSubDivision(String prasentSubDivision) {
		this.prasentSubDivision = prasentSubDivision;
	}

	public String getAssetCode() {
		return assetCode;
	}

	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}

	public String getAssetName() {
		return assetName;
	}

	public void setAssetName(String assetName) {
		this.assetName = assetName;
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

	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}

	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}

	public String getSubDivisionOfficeCode() {
		return subDivisionOfficeCode;
	}

	public void setSubDivisionOfficeCode(String subDivisionOfficeCode) {
		this.subDivisionOfficeCode = subDivisionOfficeCode;
	}

	public String getCircle() {
		return circle;
	}

	public void setCircle(String circle) {
		this.circle = circle;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getSubDivision() {
		return subDivision;
	}

	public void setSubDivision(String subDivision) {
		this.subDivision = subDivision;
	}

	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}

	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	

	
	
}
