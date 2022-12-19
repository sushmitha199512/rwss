package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class SourceTypeForm extends ActionForm
{
	
		
		private String sourceTypeCode;      
		private String sourceTypeName;   
		private String mode;
		

	public void setSourceTypeCode(String sourceTypeCode)
	{
		this.sourceTypeCode=sourceTypeCode;
	}
	public String getSourceTypeCode()
	{
		return sourceTypeCode;
	}
	public void setSourceTypeName(String sourceTypeName)
	{
		this.sourceTypeName=sourceTypeName;
	}
	public String getSourceTypeName()
	{
		return sourceTypeName;
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
		

		 this.sourceTypeCode=" ";      
		 this.sourceTypeName=" ";   
		 		
	}
	
}