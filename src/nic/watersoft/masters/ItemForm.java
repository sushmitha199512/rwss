package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;


public class ItemForm extends ActionForm
{
	private String itemCode;      
	private String itemName;  
	private String distCode;    
	private String finyear;  
	private String units;
	private String rate;
	private String mode;

	public void setItemCode(String itemCode)
	{
		this.itemCode=itemCode;
	}
	public String getItemCode()
	{
		return itemCode;
	}
	public void setItemName(String itemName)
	{
		this.itemName=itemName;
	}
	public String getItemName()
	{
		return itemName;
	}
	public void setDistCode(String distCode)
	{
		this.distCode=distCode;
	}
	public String getDistCode()
	{
		return distCode;
	}
		public void setFinyear(String finyear)
	{
		this.finyear=finyear;
	}
	public String getFinyear()
	{
		return finyear;
	}
	public void setUnits(String units)
	{
		this.units=units;
	}
	public String getUnits()
	{
		return units;
	}
	public void setRate(String rate)
	{
		this.rate=rate;
	}
	public String getRate()
	{
		return rate;
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
		this.itemCode="";
		this.itemName="";
		this.distCode="";
		this.finyear=""; 
		this.units="";   
		this.rate="";    
	}

}