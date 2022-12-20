package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class SupplierForm extends ActionForm
{
	private String supplierCode;
	private String supplierName;
	private String address;
	private String location;
	private String area;
	private String city;
	private String pin;
	private String phone;
	private String fax;
	private String email;
	private String supplierRegNo;
	private String mode;
	
	public void setLocation(String location)
	{
		this.location=location;
	}
	public String getLocation()
	{
		return location;
	}
	public void setAddress(String address)
	{
		this.address=address;
	}
	public String getAddress()
	{
		return address;
	}
	public void setArea(String area)
	{
		this.area=area;
	}
	public String getArea()
	{
		return area;
	}
	public void setCity(String city)
	{
		this.city=city;
	}
	public String getCity()
	{
		return city;
	}
	public void setPin(String pin)
	{
		this.pin=pin;
	}
	public String getPin()
	{
		return pin;
	}
	public void setPhone(String phone)
	{
		this.phone=phone;
	}
	public String getPhone()
	{
		return phone;
	}
	public void setFax(String fax)
	{
		this.fax=fax;
	}
	public String getFax()
	{
		return fax;
	}
	public void setEmail(String email)
	{
		this.email=email;
	}
	public String getEmail()
	{
		return email;
	}
	public void setSupplierCode(String supplierCode)
	{
		this.supplierCode=supplierCode;
	}
	public String getSupplierCode()
	{
		return supplierCode;
	}
	public void setSupplierName(String supplierName)
	{
		this.supplierName=supplierName;
	}
	public String getSupplierName()
	{
		return supplierName;
	}
	public void setSupplierRegNo(String supplierRegNo)
	{
		this.supplierRegNo=supplierRegNo;
	}
	public String getSupplierRegNo()
	{
		return supplierRegNo;
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
		this.supplierCode="";  		
		this.supplierName="";  
		this.address="";       
		this.location="";      
		this.area="";          
		this.city="";          
		this.pin="";           
		this.phone="";         
		this.fax="";           
		this.email="";         
		this.supplierRegNo=""; 
	}

	
}