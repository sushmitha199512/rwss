package nic.watersoft.wquality;
/*
 * Created on Nov 17, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */



public class WaterSampleTestResLnk 
{
	private String testName;
	private String testPCode;
	private String testPName;
	//private String minValue;
	//private String maxValue;
	private String result;
	private String testId;
	private String minPerVal;
	private String maxPerVal;
	private String undesirableEffect;
	
	/*public WaterSampleTestResLnk()
	{		
	}
	public WaterSampleTestResLnk(String testCode,String testName,String testPName,String minValue,String maxValue)
	{
		this.testCode=testCode;
		this.testName=testName;
		this.testPName=testPName;
		this.minValue = minValue;
		this.maxValue = maxValue;
	}*/
	
	
	public String getResult() {
		return result;
	}
	/**
	 * @param result The result to set.
	 */
	public void setResult(String result) {
		this.result = result;
	}
	/**
	 * @return Returns the testCode.
	 */
	public String getTestPCode() {
		return testPCode;
	}
	/**
	 * @param testCode The testCode to set.
	 */
	public void setTestPCode(String testPCode) {
		this.testPCode = testPCode;
	}
	/**
	 * @return Returns the testPName.
	 */
	public String getTestPName() {
		return testPName;
	}
	/**
	 * @param testPName The testPName to set.
	 */
	public void setTestPName(String testPName) {
		this.testPName = testPName;
	}
	/**
	 * @return Returns the testName.
	 */
	public String getTestName() {
		return testName;
	}
	/**
	 * @param testName The testName to set.
	 */
	public void setTestName(String testName) {
		this.testName = testName;
	}
	public String getTestId() {
		return testId;
	}
	public void setTestId(String testId) {
		this.testId = testId;
	}
	public String getMinPerVal() {
		return minPerVal;
	}
	public void setMinPerVal(String minPerVal) {
		this.minPerVal = minPerVal;
	}
	public String getMaxPerVal() {
		return maxPerVal;
	}
	public void setMaxPerVal(String maxPerVal) {
		this.maxPerVal = maxPerVal;
	}
	public String getUndesirableEffect() {
		return undesirableEffect;
	}
	public void setUndesirableEffect(String undesirableEffect) {
		this.undesirableEffect = undesirableEffect;
	}
}
