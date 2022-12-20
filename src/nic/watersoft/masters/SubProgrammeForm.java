package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;


public class SubProgrammeForm extends ActionForm
{

		private String prgmCode;
		private String subprgmCode;
		private String subprgmName;	
		private String mode;  
				

	public void setPrgmCode(String prgmCode)
	{
		this.prgmCode=prgmCode;
	}
	public String getPrgmCode()
	{
		return prgmCode;
	}
	public void setSubprgmCode(String subprgmCode)
	{
		this.subprgmCode=subprgmCode;
	}
	public String getSubprgmCode()
	{
		return subprgmCode;
	}
	public void setSubprgmName(String subprgmName)
	{
		this.subprgmName=subprgmName;
	}
	public String getSubprgmName()
	{
		return subprgmName;
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
		

		 this.prgmCode=" ";    
		 this.subprgmCode=" ";    
		 this.subprgmName=" "; 
				 
				
	}
}