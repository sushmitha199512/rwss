package nic.watersoft.works;

import java.io.Serializable;

public class SubDivision implements Serializable
{
	private String code;
	private String name;
	private String assetcode;
	private String assetname;

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
	public void setAssetcode(String assetcode)
	{	this.assetcode = assetcode;
	}
	public String getAssetcode()
	{	return assetcode;
	}
	public void setAssetname(String assetname)
	{	this.assetname = assetname;
	}
	public String getAssetname()
	{	return assetname;
	}
}
