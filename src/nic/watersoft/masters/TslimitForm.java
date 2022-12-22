package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class TslimitForm extends ActionForm
{
	
		private String mode;
		private String office1; 
		private String office2;
		private String office3;
		private String office4;
		private String office5;
		
		private String designation1;
		private String designation2;
		private String designation3;
		private String designation4;
		private String designation5;
		
		private String lowerLimit1;
		private String lowerLimit2;
		private String lowerLimit3;
		private String lowerLimit4;
		private String lowerLimit5;
		
		private String upperLimit1;
		private String upperLimit2;
		private String upperLimit3;
		private String upperLimit4;
		private String upperLimit5;
		

	//setter
	public void setOffice1(String office1)
	{
		this.office1=office1;
	}
	public String getOffice1()
	{
		return office1;
	}

	public void setOffice2(String office2)
	{
		this.office2=office2;
	}
	public String getOffice2()
	{
		return office2;
	}
	public void setOffice3(String office3)
	{
		this.office3=office3;
	}
	public String getOffice3()
	{
		return office3;
	}
	public void setOffice4(String office4)
	{
		this.office4=office4;
	}
	public String getOffice4()
	{
		return office4;
	}
	public void setOffice5(String office5)
	{
		this.office5=office5;
	}
	public String getOffice5()
	{
		return office5;
	}



	public void setDesignation1(String designation1)
	{
		this.designation1=designation1;
	}
	public String getDesignation1()
	{
		return designation1;
	}
	public void setDesignation2(String designation2)
	{
		this.designation2=designation2;
	}
	public String getDesignation2()
	{
		return designation2;
	}
	public void setDesignation3(String designation3)
	{
		this.designation3=designation3;
	}
	public String getDesignation3()
	{
		return designation3;
	}
	public void setDesignation4(String designation4)
	{
		this.designation4=designation4;
	}
	public String getDesignation4()
	{
		return designation4;
	}
	public void setDesignation5(String designation5)
	{
		this.designation5=designation5;
	}
	public String getDesignation5()
	{
		return designation5;
	}



	
	public void setLowerLimit1(String lowerLimit1)
	{
		this.lowerLimit1=lowerLimit1;
	}
	public String getLowerLimit1()
	{
		return lowerLimit1;
	}
	public void setLowerLimit2(String lowerLimit2)
	{
		this.lowerLimit2=lowerLimit2;
	}
	public String getLowerLimit2()
	{
		return lowerLimit2;
	}
	public void setLowerLimit3(String lowerLimit3)
	{
		this.lowerLimit3=lowerLimit3;
	}
	public String getLowerLimit3()
	{
		return lowerLimit3;
	}
	public void setLowerLimit4(String lowerLimit4)
	{
		this.lowerLimit4=lowerLimit4;
	}
	public String getLowerLimit4()
	{
		return lowerLimit4;
	}
	public void setLowerLimit5(String lowerLimit5)
	{
		this.lowerLimit5=lowerLimit5;
	}
	public String getLowerLimit5()
	{
		return lowerLimit5;
	}



	public void setUpperLimit1(String upperLimit1)
	{
		this.upperLimit1=upperLimit1;
	}
	public String getUpperLimit1()
	{
		return upperLimit1;
	}
	public void setUpperLimit2(String upperLimit2)
	{
		this.upperLimit2=upperLimit2;
	}
	public String getUpperLimit2()
	{
		return upperLimit2;
	}
	public void setUpperLimit3(String upperLimit3)
	{
		this.upperLimit3=upperLimit3;
	}
	public String getUpperLimit3()
	{
		return upperLimit3;
	}
	public void setUpperLimit4(String upperLimit4)
	{
		this.upperLimit4=upperLimit4;
	}
	public String getUpperLimit4()
	{
		return upperLimit4;
	}
	public void setUpperLimit5(String upperLimit5)
	{
		this.upperLimit5=upperLimit5;
	}
	public String getUpperLimit5()
	{
		return upperLimit5;
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
		
		 this.office1="";
		 this.office2="";
		 this.office3="";
		 this.office4="";
		 this.office5="";
		
		 this.designation1="";
		 this.designation2="";
		 this.designation3="";
		 this.designation4="";
		 this.designation5="";

		 this.lowerLimit1="";
		 this.lowerLimit2="";
		 this.lowerLimit3="";
		 this.lowerLimit4="";
		 this.lowerLimit5="";

		 this.upperLimit1="";
		 this.upperLimit2="";
		 this.upperLimit3="";
		 this.upperLimit4="";
		 this.upperLimit5="";
		 
				
	}
	
}