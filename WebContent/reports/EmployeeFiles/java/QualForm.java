package nic.watersoft.masters;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class QualForm extends ActionForm
{
	
	private String qualCode;
	private String qualName;
	private String mode;
		
	public void setQualCode(String qualCode)
	{
		this.qualCode=qualCode;
	}
	public String getQualCode()
	{
		return qualCode;
	}
	public void setQualName(String qualName)
	{
		this.qualName=qualName;
	}
	public String getQualName()
	{
		return qualName;
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
		 this.qualCode=" ";
		 this.qualName=" ";
	}
	
}
