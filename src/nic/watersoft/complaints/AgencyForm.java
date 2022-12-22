package nic.watersoft.complaints;

import java.io.Serializable;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class AgencyForm extends ActionForm implements Serializable
{
		private String agencyCode;      
		private String agencyName;  
		private String mode;
				
		
	public String getAgencyCode() {
			return agencyCode;
		}
		public void setAgencyCode(String agencyCode) {
			this.agencyCode = agencyCode;
		}
		public String getAgencyName() {
			return agencyName;
		}
		public void setAgencyName(String agencyName) {
			this.agencyName = agencyName;
		}
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
		 this.agencyCode=" ";    
		 this.agencyName=" "; 		 
				
	}
	
}