package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

//import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
//import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class EmpSearchForm extends ActionForm {

	private String desgnCode;
	private String hoc;
	private String zone;
	private String desig;
	private String desgnName;
	private String mode;
	private String circleOfficeCode;
	
	
	
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	/**
	 * @return Returns the desgnCode.
	 */
	public String getDesgnCode() {
		return desgnCode;
	}
	/**
	 * @param desgnCode The desgnCode to set.
	 */
	public void setDesgnCode(String desgnCode) {
		this.desgnCode = desgnCode;
	}
	/**
	 * @return Returns the desig.
	 */
	public String getDesig() {
		return desig;
	}
	/**
	 * @param desig The desig to set.
	 */
	public void setDesig(String desig) {
		this.desig = desig;
	}
	/**
	 * @return Returns the hoc.
	 */
	public String getHoc() {
		return hoc;
	}
	/**
	 * @param hoc The hoc to set.
	 */
	public void setHoc(String hoc) {
		this.hoc = hoc;
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
	 * @return Returns the zone.
	 */
	public String getZone() {
		return zone;
	}
	/**
	 * @param zone The zone to set.
	 */
	public void setZone(String zone) {
		this.zone = zone;
	}
	
	 public void reset(ActionMapping mapping,HttpServletRequest request)
	 {
	 	this.desgnCode="";
		this.hoc="";
		this.zone="";
		this.desig="";
		
		
	 }
	
	/**
	 * @return Returns the desgnName.
	 */
	public String getDesgnName() {
		return desgnName;
	}
	/**
	 * @param desgnName The desgnName to set.
	 */
	public void setDesgnName(String desgnName) {
		this.desgnName = desgnName;
	}
}
