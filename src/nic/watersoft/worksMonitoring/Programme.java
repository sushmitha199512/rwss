package nic.watersoft.worksMonitoring;

import java.io.Serializable;

public class Programme implements Serializable 
{
	private String code;
	private String name;

	// Acessors for code
	public void setCode(String code)
	{	this.code = code;
	}
	public String getCode()
	{	return code;
	}

	// Acessors for name
	public void setName(String name)
	{	this.name = name;
	}
	public String getName()
	{	return name;
	}
}
