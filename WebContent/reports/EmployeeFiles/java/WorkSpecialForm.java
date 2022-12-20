package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class WorkSpecialForm extends ActionForm
{
	
		
		private String workSpecCode;
		private String workSpecName;
		private String mode;
		

	public void setWorkSpecCode(String workSpecCode)
	{
		this.workSpecCode=workSpecCode;
	}
	public String getWorkSpecCode()
	{
		return workSpecCode;
	}
	public void setWorkSpecName(String workSpecName)
	{
		this.workSpecName=workSpecName;
	}
	public String getWorkSpecName()
	{
		return workSpecName;
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
		

		 this.workSpecCode=" ";
		 this.workSpecName=" ";
		 
				
	}
	
}