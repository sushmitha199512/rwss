package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class MajorHeadForm extends ActionForm
{
		private String majorHeadCode;      
		private String majorHeadName;  
		private String mode;
				

	public void setMajorHeadCode(String majorHeadCode)
	{
		this.majorHeadCode=majorHeadCode;
	}
	public String getMajorHeadCode()
	{
		return majorHeadCode;
	}
	public void setMajorHeadName(String majorHeadName)
	{
		this.majorHeadName=majorHeadName;
	}
	public String getMajorHeadName()
	{
		return majorHeadName;
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
		 this.majorHeadCode=" ";    
		 this.majorHeadName=" "; 		 
				
	}
	
}