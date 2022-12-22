package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;


public class DetailHeadForm extends ActionForm
{
	
		
		private String majorHeadCode;      
		private String submajorHeadCode;  
		private String minorHeadCode;     
		private String grpSubHeadCode;    
		private String subHeadCode;       
		private String detailHeadCode;    
		private String detailHeadName;  
		private String mode;
				

	public void setMajorHeadCode(String majorHeadCode)
	{
		this.majorHeadCode=majorHeadCode;
	}
	public String getMajorHeadCode()
	{
		return majorHeadCode;
	}
	public void setSubmajorHeadCode(String submajorHeadCode)
	{
		this.submajorHeadCode=submajorHeadCode;
	}
	public String getSubmajorHeadCode()
	{
		return submajorHeadCode;
	}
	public void setMinorHeadCode(String minorHeadCode)
	{
		this.minorHeadCode=minorHeadCode;
	}
	public String getMinorHeadCode()
	{
		return minorHeadCode;
	}
		public void setGrpSubHeadCode(String grpSubHeadCode)
	{
		this.grpSubHeadCode=grpSubHeadCode;
	}
	public String getGrpSubHeadCode()
	{
		return grpSubHeadCode;
	}
	public void setSubHeadCode(String subHeadCode)
	{
		this.subHeadCode=subHeadCode;
	}
	public String getSubHeadCode()
	{
		return subHeadCode;
	}
	public void setDetailHeadCode(String detailHeadCode)
	{
		this.detailHeadCode=detailHeadCode;
	}
	public String getDetailHeadCode()
	{
		return detailHeadCode;
	}
	public void setDetailHeadName(String detailHeadName)
	{
		this.detailHeadName=detailHeadName;
	}
	public String getDetailHeadName()
	{
		return detailHeadName;
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
		

		 this.majorHeadCode=" ";    
		 this.submajorHeadCode=" "; 
		 this.minorHeadCode=" ";    
		 this.grpSubHeadCode=" ";   
		 this.subHeadCode=" ";      
		 this.detailHeadCode=" ";   
		 this.detailHeadName=" ";
				
	}
	
}