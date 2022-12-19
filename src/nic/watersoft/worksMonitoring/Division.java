package nic.watersoft.worksMonitoring;

import java.io.Serializable;

public class Division implements Serializable 
{
	private int code;
	private String name;

	// Acessors for code
	public void setCode(int code)
	{	this.code = code;
	}
	public int getCode()
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
