package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class PriorityForm extends ActionForm
{
	
		private String priorityCode; 
		private String priorityDesc; 
		private String priorityFrom; 
		private String mode;
				
	public void setPriorityCode(String priorityCode)
	{
		this.priorityCode=priorityCode;
	}
	public String getPriorityCode()
	{
		return priorityCode;
	}
	public void setPriorityDesc(String priorityDesc)
	{
		this.priorityDesc=priorityDesc;
	}
	public String getPriorityDesc()
	{
		return priorityDesc;
	}
	public void setPriorityFrom(String priorityFrom)
	{
		this.priorityFrom=priorityFrom;
	}
	public String getPriorityFrom()
	{
		return priorityFrom;
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
		 this.priorityCode=" ";
		  this.priorityDesc=" ";
		 this.priorityFrom=" ";
				
	}
	
}