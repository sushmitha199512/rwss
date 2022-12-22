package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class PublicRepForm extends ActionForm
{	
	private String publicRepCode; 
	private String publicRepName; 
	private String mode;

	/**
	 * @param publicRepCode The publicRepCode to set.
	 */
	public void setPublicRepCode(String publicRepCode)
	{
		this.publicRepCode=publicRepCode;
	}
	/**
	 * @return Returns the publicRepCode.
	 */
	public String getPublicRepCode()
	{
		return publicRepCode;
	}
	/**
	 * @param publicRepName The publicRepName to set.
	 */
	public void setPublicRepName(String publicRepName)
	{
		this.publicRepName=publicRepName;
	}
	/**
	 * @return Returns the publicRepName.
	 */
	public String getPublicRepName()
	{
		return publicRepName;
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
		 this.publicRepCode="";
		 this.publicRepName="";
	}
	
}