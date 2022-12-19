	package nic.watersoft.masters;
	import javax.servlet.http.HttpServletRequest;
	import org.apache.struts.action.ActionForm;
	import org.apache.struts.action.ActionMapping;
	public class ContamForm extends ActionForm
	{
	
		private String mode;
		private String contamCode; 
		private String contamName; 
		

	public void setContamCode(String contamCode)
	{
		this.contamCode=contamCode;
	}
	public String getContamCode()
	{
		return contamCode;
	}
	public void setContamName(String contamName)
	{
		this.contamName=contamName;
	}
	public String getContamName()
	{
		return contamName;
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
		
		 this.contamCode=" ";
		 this.contamName=" ";
	}
}