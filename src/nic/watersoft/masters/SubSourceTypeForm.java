package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class SubSourceTypeForm extends ActionForm
{
	
		
		private String sourceTypeCode;      
		private String subSourceTypeCode;      
		private String subSourceTypeName;   
		private String mode;
		

	public void setSourceTypeCode(String sourceTypeCode)
	{
		this.sourceTypeCode=sourceTypeCode;
	}
	public String getSourceTypeCode()
	{
		return sourceTypeCode;
	}
	public void setSubSourceTypeCode(String subSourceTypeCode)
	{
		this.subSourceTypeCode=subSourceTypeCode;
	}
	public String getSubSourceTypeCode()
	{
		return subSourceTypeCode;
	}
	public void setSubSourceTypeName(String subSourceTypeName)
	{
		this.subSourceTypeName=subSourceTypeName;
	}
	public String getSubSourceTypeName()
	{
		return subSourceTypeName;
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
		 this.sourceTypeCode="";      
		 this.subSourceTypeCode="";      
		 this.subSourceTypeName="";   		 		
	}
	
}