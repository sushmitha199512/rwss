package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class InstituteForm extends ActionForm
{
	
		
		private String instituteCode; 
		private String instituteName; 
		private String mode;
		

	public void setInstituteCode(String instituteCode)
	{
		this.instituteCode=instituteCode;
	}
	public String getInstituteCode()
	{
		return instituteCode;
	}
	public void setInstituteName(String instituteName)
	{
		this.instituteName=instituteName;
	}
	public String getInstituteName()
	{
		return instituteName;
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
		

		 this.instituteCode=" ";
		 this.instituteName=" ";
		 
				
	}
	
}