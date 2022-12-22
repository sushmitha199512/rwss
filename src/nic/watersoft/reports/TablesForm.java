/*
 * Created on Aug 29, 2011
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;

import org.apache.struts.action.ActionForm;

/**
 * @jyothi
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TablesForm extends ActionForm 

{
	private String circleOfficeCode;
	private String mandal;
	private String table;
	private String district;
	private String districtName;
	
	
	/**
	 * @return Returns the circleOfficeCode.
	 */
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	/**
	 * @param circleOfficeCode The circleOfficeCode to set.
	 */
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	/**
	 * @return Returns the district.
	 */
	public String getDistrict() {
		return district;
	}
	/**
	 * @param district The district to set.
	 */
	public void setDistrict(String district) {
		this.district = district;
	}
	/**
	 * @return Returns the districtName.
	 */
	public String getDistrictName() {
		return districtName;
	}
	/**
	 * @param districtName The districtName to set.
	 */
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	/**
	 * @return Returns the mandal.
	 */
	public String getMandal() {
		return mandal;
	}
	/**
	 * @param mandal The mandal to set.
	 */
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	/**
	 * @return Returns the table.
	 */
	public String getTable() {
		return table;
	}
	/**
	 * @param table The table to set.
	 */
	public void setTable(String table) {
		this.table = table;
	}
}
