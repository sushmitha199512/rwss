package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class StoreForm extends ActionForm
{
	private String district;
	private String mandal;
	private String subdivision;
	private String storeCode;
	private String empcode;
	private String location;
	private String storeInCharge;
	private String postheld;
	private String mode;
		
	public void setDistrict(String district)
	{
		this.district=district;
	}
	public String getDistrict()
	{
		return district;
	}
	public void setSubdivision(String subdivision)
	{
		this.subdivision=subdivision;
	}
	public String getSubdivision()
	{
		return subdivision;
	}
	public void setMandal(String mandal)
	{
		this.mandal=mandal;
	}
	public String getMandal()
	{
		return mandal;
	}
	public void setStoreCode(String storeCode)
	{
		this.storeCode=storeCode;
	}
	public String getStoreCode()
	{
		return storeCode;
	}
	public void setEmpcode(String empcode)
	{
		this.empcode=empcode;
	}
	public String getEmpcode()
	{
		return empcode;
	}
	public void setLocation(String location)
	{
		this.location=location;
	}
	public String getLocation()
	{
		return location;
	}
	public void setStoreInCharge(String storeInCharge)
	{
		this.storeInCharge=storeInCharge;
	}
	public String getStoreInCharge()
	{
		return storeInCharge;
	}
	public void setPostheld(String postheld)
	{
		this.postheld=postheld;
	}
	public String getPostheld()
	{
		return postheld;
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
		this.district="";     
		this.mandal="";       
		this.subdivision="";  
		this.storeCode="";    
		this.empcode="";      
		this.location="";     
		this.storeInCharge="";
		this.postheld="";     
	}
	
}