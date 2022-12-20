package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class DistrictForm extends ActionForm
{
	
		
		protected String dcode;
		protected String dname;

				

	public void setDcode(String dcode)
	{
		this.dcode=dcode;
	}
	public String getDcode()
	{
		return dcode;
	}
	public void setDname(String dname)
	{
		this.dname=dname;
	}
	public String getDname()
	{
		return dname;
	}
	
		


		public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		

		 this.dcode=" ";
		 this.dname=" ";
	
		 	 
				
	}
	}