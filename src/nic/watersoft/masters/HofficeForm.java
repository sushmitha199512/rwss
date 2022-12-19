package nic.watersoft.masters;

import org.apache.struts.action.ActionForm;

public class HofficeForm extends ActionForm
{
		
		private String mode;
		private String office;
		private String designation;

	public void setOffice(String office)
	{
		this.office=office;
	}
	public String getOffice()
	{
		return office;
	}
	public void setDesignation(String designation)
	{
		this.designation=designation;
		//System.out.println("setDesignation in HofficeForm"+designation);
	}
	public String getDesignation()
	{
		//System.out.println("setDesignation in HofficeForm"+designation);
		return designation;
		
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
}