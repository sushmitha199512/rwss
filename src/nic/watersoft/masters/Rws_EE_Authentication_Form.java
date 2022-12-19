/*
 * Created on 27-05-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * @author user
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_EE_Authentication_Form  extends ActionForm
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String circle;
	private String division;
	private String eeid;
	private String eename;
	private String officecode;
	private String checks;
	private String mode;
	private ArrayList eeList;
	private String  selectedList;
	
	
	
	
	
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
	 * @return Returns the circle.
	 */
	public String getCircle() {
		return circle;
	}
	/**
	 * @param circle The circle to set.
	 */
	public void setCircle(String circle) {
		this.circle = circle;
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
	/**
	 * @return Returns the eeid.
	 */
	public String getEeid() {
		return eeid;
	}
	/**
	 * @param eeid The eeid to set.
	 */
	public void setEeid(String eeid) {
		this.eeid = eeid;
	}
	/**
	 * @return Returns the eename.
	 */
	public String getEename() {
		return eename;
	}
	/**
	 * @param eename The eename to set.
	 */
	public void setEename(String eename) {
		this.eename = eename;
	}
	/**
	 * @return Returns the officecode.
	 */
	public String getOfficecode() {
		return officecode;
	}
	/**
	 * @param officecode The officecode to set.
	 */
	public void setOfficecode(String officecode) {
		this.officecode = officecode;
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
	 * @return Returns the eeList.
	 */
	public ArrayList getEeList() {
		return eeList;
	}
	/**
	 * @param eeList The eeList to set.
	 */
	public void setEeList(ArrayList eeList) {
		this.eeList = eeList;
	}
	/**
	 * @return Returns the selectedList.
	 */
	public String getSelectedList() {
		return selectedList;
	}
	/**
	 * @param selectedList The selectedList to set.
	 */
	public void setSelectedList(String selectedList) {
		this.selectedList = selectedList;
	}
}
