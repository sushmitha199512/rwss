package nic.watersoft.wquality;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/*
 * Created on Nov 26, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class WQDrillStatusForm extends ActionForm
{
	private String workCode;
	private String drillDate;
	private String drillStatus;
	private String yield;
	private String preparedBy;
	private String preparedOn;
	private String mode;
	
	/**
	 * @return Returns the drillDate.
	 */
	public String getDrillDate() {
		return drillDate;
	}
	/**
	 * @param drillDate The drillDate to set.
	 */
	public void setDrillDate(String drillDate) {
		this.drillDate = drillDate;
	}
	/**
	 * @return Returns the drillStatus.
	 */
	public String getDrillStatus() {
		return drillStatus;
	}
	/**
	 * @param drillStatus The drillStatus to set.
	 */
	public void setDrillStatus(String drillStatus) {
		this.drillStatus = drillStatus;
	}
	/**
	 * @return Returns the preparedBy.
	 */
	public String getPreparedBy() {
		return preparedBy;
	}
	/**
	 * @param preparedBy The preparedBy to set.
	 */
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	/**
	 * @return Returns the preparedOn.
	 */
	public String getPreparedOn() {
		return preparedOn;
	}
	/**
	 * @param preparedOn The preparedOn to set.
	 */
	public void setPreparedOn(String preparedOn) {
		this.preparedOn = preparedOn;
	}
	/**
	 * @return Returns the workCode.
	 */
	public String getWorkCode() {
		return workCode;
	}
	/**
	 * @param workCode The workCode to set.
	 */
	public void setWorkCode(String workCode) {
		this.workCode = workCode;
	}
	/**
	 * @return Returns the yield.
	 */
	public String getYield() {
		return yield;
	}
	/**
	 * @param yield The yield to set.
	 */
	public void setYield(String yield) {
		this.yield = yield;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode)
	{
		this.mode=mode;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode()
	{
		return mode;
	}
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		this.workCode="";
		this.drillStatus="";
		this.drillDate="";
		this.yield="";
	}
}
