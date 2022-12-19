package nic.watersoft.admin;

import java.io.Serializable;

public class Role implements Serializable
{
	private String code;
	private String name;
	private String desc;
	
	public void setCode(String code)
	{	this.code = code;
	}
	public String getCode()
	{	return code;
	}
	public void setName(String name)
	{	this.name = name;
	}
	public String getName()
	{	return name;
	}

	public void setDesc(String desc)
	{	this.desc = desc;
	}
	public String getDesc()
	{	return desc;
	}

	
}
