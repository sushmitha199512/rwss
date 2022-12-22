package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class WaterParameterTestForm extends ActionForm
{
	private String testCode;
	private String testPCode; 
	private String testPName;
	private String minPerVal; 
	private String maxPerVal;
	private String mode;
	private String undesirableEffect;
		
	public void setTestCode(String testCode)
	{
		this.testCode=testCode;
	}
	public String getTestCode()
	{
		return testCode;
	}
	public void setTestPCode(String testPCode)
	{
		this.testPCode=testPCode;
	}
	public String getTestPCode()
	{
		return testPCode;
	}
	public void setTestPName(String testPName)
	{
		this.testPName=testPName;
	}
	public String getTestPName()
	{
		return testPName;
	}
	public void setMinPerVal(String minPerVal)
	{
		this.minPerVal=minPerVal;
	}
	public String getMinPerVal()
	{
		return minPerVal;
	}
	public void setMaxPerVal(String maxPerVal)
	{
		this.maxPerVal=maxPerVal;
	}
	public String getMaxPerVal()
	{
		return maxPerVal;
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
		this.testPCode="";
		this.testPName="";
		this.minPerVal="";
		this.maxPerVal="";
		this.undesirableEffect="";
	}	
	public String getUndesirableEffect() {
		return undesirableEffect;
	}
	public void setUndesirableEffect(String undesirableEffect) {
		this.undesirableEffect = undesirableEffect;
	}
}