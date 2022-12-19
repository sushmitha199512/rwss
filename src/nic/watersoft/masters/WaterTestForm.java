package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class WaterTestForm extends ActionForm
{
	private String testCode;
	private String testName; 
	private String testPeriod;
	private String mode;
		
	public void setTestCode(String testCode)
	{
		this.testCode=testCode;
	}
	public String getTestCode()
	{
		return testCode;
	}
	public void setTestName(String testName)
	{
		this.testName=testName;
	}
	public String getTestName()
	{
		return testName;
	}
	public void setTestPeriod(String testPeriod)
	{
		this.testPeriod=testPeriod;
	}
	public String getTestPeriod()
	{
		return testPeriod;
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
		this.testCode="";  
		this.testName="";  
		this.testPeriod="";
	}
	
}