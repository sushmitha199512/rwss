/*
 * Created on Feb 6, 2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;

import java.io.Serializable;
import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * @author nic
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class WaterTransportFrm extends ActionForm implements Serializable {

	private String district;

	private String mandal;

	private String currentDate;

	private String dataDate;

	private String division;
	private String mandals;
	


	
	private ArrayList transportDetails = new ArrayList();

	/**
	 * @return Returns the currentDate.
	 */
	public String getCurrentDate() {
		return currentDate;
	}

	/**
	 * @param currentDate
	 *            The currentDate to set.
	 */
	public void setCurrentDate(String currentDate) {
		this.currentDate = currentDate;
	}

	/**
	 * @return Returns the district.
	 */
	public String getDistrict() {
		return district;
	}

	/**
	 * @param district
	 *            The district to set.
	 */
	public void setDistrict(String district) {
		this.district = district;
	}

	/**
	 * @return Returns the mandal.
	 */
	public String getMandal() {
		return mandal;
	}

	/**
	 * @param mandal
	 *            The mandal to set.
	 */
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}

	/**
	 * @return Returns the transportDetails.
	 */
	public ArrayList getTransportDetails() {
		return transportDetails;
	}

	/**
	 * @param transportDetails
	 *            The transportDetails to set.
	 */
	public void setTransportDetails(ArrayList transportDetails) {
		this.transportDetails = transportDetails;
	}

	/**
	 * @return Returns the dataDate.
	 */
	public String getDataDate() {
		return dataDate;
	}

	/**
	 * @param dataDate
	 *            The dataDate to set.
	 */
	public void setDataDate(String dataDate) {
		this.dataDate = dataDate;
	}
	/**
	 * @return Returns the division.
	 */
	public String getDivision() {
		return division;
	}
	/**
	 * @param division The division to set.
	 */
	public void setDivision(String division) {
		this.division = division;
	}

	public String getMandals() {
		return mandals;
	}

	public void setMandals(String mandals) {
		this.mandals = mandals;
	}
}