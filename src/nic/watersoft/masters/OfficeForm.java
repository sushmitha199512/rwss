package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class OfficeForm extends ActionForm
{
	
	private String hoc;
	private String coc;
	private String doc;
	private String sdoc;
		
	private String roc;
	private String address;
	private String location;
	private String area;
	private String city;
	private String pin;
	private String phone;
	private String fax;
	private String email;
	private String building;
	private String hof;
	private String project;
	private String mode;

	public void setHoc(String hoc)
	{
		this.hoc=hoc;
	}
	public String getHoc()
	{
		return hoc;
	}
	public void setCoc(String coc)
	{
		this.coc=coc;
	}
	public String getCoc()
	{
		return coc;
	}
	public void setDoc(String doc)
	{
		this.doc=doc;
	}
	public String getDoc()
	{
		return doc;
	}
	public void setSdoc(String sdoc)
	{
		this.sdoc=sdoc;
	}
	public String getSdoc()
	{
		return sdoc;
	}
	
	public void setRoc(String roc)
	{
		this.roc=roc;
	}
	public String getRoc()
	{
		return roc;
	}
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
	public void setBuilding(String building)
	{
		this.building=building;
	}
	public String getBuilding()
	{
		return building;
	}
	public void setHof(String hof)
	{
		this.hof=hof;
	}
	public String getHof()
	{
		return hof;
	}
	public void setProject(String project)
	{
		this.project=project;
	}
	public String getProject()
	{
		return project;
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
		this.hoc="0";
		this.coc="00";
		this.doc="0";
		this.sdoc="00";
		this.roc="";     
		this.address=""; 
		this.location="";
		this.area="";    
		this.city="";    
		this.pin="";     
		this.phone="";   
		this.fax="";     
		this.email="";   
		this.building="";
		this.hof="";     
		this.project=""; 
	}
}
