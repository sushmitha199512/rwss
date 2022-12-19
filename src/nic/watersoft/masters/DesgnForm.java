package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class DesgnForm extends ActionForm
{
	private String desgnCode;
	private String desgnAcr;
	private String desgnName;
	private String mode;
	private String desgnType;
	
	/**
	 * @return Returns the desgnType.
	 */
	public String getDesgnType() {
		return desgnType;
	}
	/**
	 * @param desgnType The desgnType to set.
	 */
	public void setDesgnType(String desgnType) {
		this.desgnType = desgnType;
	}
	public void setDesgnCode(String desgnCode)
	{
		this.desgnCode=desgnCode;
	}
	public String getDesgnCode()
	{
		return desgnCode;
	}
	public void setDesgnAcr(String desgnAcr)
	{
		this.desgnAcr=desgnAcr;
	}
	public String getDesgnAcr()
	{
		return desgnAcr;
	}
	public void setDesgnName(String desgnName)
	{
		this.desgnName=desgnName;
	}
	public String getDesgnName()
	{
		return desgnName;
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
		this.desgnCode=" ";
		this.desgnAcr=" ";
		this.desgnName=" ";
		
	}
	
}