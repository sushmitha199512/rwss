package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;


public class SubMajorHeadForm extends ActionForm
{

		private String majorHeadCode;     
		private String submajorHeadCode;     
		private String submajorHeadName;  
		private String mode;

	public void setMajorHeadCode(String majorHeadCode)
	{
		this.majorHeadCode=majorHeadCode;
	}
	public String getMajorHeadCode()
	{
		return majorHeadCode;
	}
	public void setSubmajorHeadCode(String submajorHeadCode)
	{
		this.submajorHeadCode=submajorHeadCode;
	}
	public String getSubmajorHeadCode()
	{
		return submajorHeadCode;
	}
	public void setSubmajorHeadName(String submajorHeadName)
	{
		this.submajorHeadName=submajorHeadName;
	}
	public String getSubmajorHeadName()
	{
		return submajorHeadName;
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
		 this.submajorHeadCode=" ";    
		 this.submajorHeadName=" "; 
	}
}