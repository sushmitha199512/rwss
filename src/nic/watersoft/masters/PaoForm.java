package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class PaoForm extends ActionForm
{
		  
		private String distcode;  
		private String paocode;   
		private String address1;
		private String address2;
		private String address3;
		private String location;   
		private String area;
		private String city;   
		private String pin;
		
		private String phone;  
		private String email;  
		private String fax;   
		private String mode;
		private String paoName;
		public String getPaoapao() {
			return paoapao;
		}
		public void setPaoapao(String paoapao) {
			this.paoapao = paoapao;
		}
		private String paoapao;
				

		public String getPaoName() {
			return paoName;
		}
		
		public void setPaoName(String paoName) {
			this.paoName = paoName;
		}
	public void setDistcode(String distcode)
	{
		this.distcode=distcode;
	}
	public String getDistcode()
	{
		return distcode;
	}
	public void setPaocode(String paocode)
	{
		this.paocode=paocode;
	}
	public String getPaocode()
	{
		return paocode;
	}
	public void setLocation(String location)
	{
		this.location=location;
	}
	public String getLocation()
	{
		return location;
	}
	public void setAddress1(String address)
	{
		this.address1=address;
	}
	public String getAddress1()
	{
		return address1;
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
		this.distcode=""; 
		this.paocode="";  
		this.address1="";
		this.address2="";
		this.address3="";
		this.location="";   
		this.area="";       
		this.city="";       
		this.pin="";        
		this.phone="";     
		this.fax="";       
		this.email="";     



				
	}
	
		public String getAddress2() {
			return address2;
		}
		public void setAddress2(String address2) {
			this.address2 = address2;
		}
		public String getAddress3() {
			return address3;
		}
		public void setAddress3(String address3) {
			this.address3 = address3;
		}
}