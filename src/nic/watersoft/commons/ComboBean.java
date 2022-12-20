/*
 * Created on Aug 10, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.io.Serializable;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class ComboBean implements Serializable
{

	String value;
	String displayValue;
	
	ComboBean(String value,String displayValue)
	{
		this.value=value;
		this.displayValue=displayValue;
	}
	
	public void setValue(String value)
	{
		this.value=value;
	}
	
	public void setDisplayValue(String displayValue)
	{
		this.displayValue=displayValue;
	}
	
	public String getValue()
	{
		return value;
	}
	
	public String getDisplayValue()
	{
		return displayValue;
	}

}
