package nic.watersoft.admin;

import java.io.Serializable;

public class LogBean implements Serializable 
{
	private String userId;
	private String authType;
	private String accessTime;
	private String module;
	private String page;
	private String address;
	private String host;
	private String browser;
	private String sessionid;


	public void setUserId(String userId) 
	{	this.userId = userId;
	}
	public String getUserId() 
	{	return userId;
	}

	public void setAuthType(String authType) 
	{	this.authType = authType;
	}
	public String getAuthType() 
	{	return authType;
	}

	public void setAccessTime(String accessTime) 
	{	this.accessTime = accessTime;
	}
	public String getAccessTime() 
	{	return accessTime;
		
	}
	
	public void setModule(String module) 
	{	this.module = module;
	}
	public String getModule() 
	{	return module;
	}

	public void setPage(String page) 
	{	this.page = page;
	}
	public String getPage() 
	{	return page;
	}

	public void setAddress(String address) 
	{	this.address = address;
	}
	public String getAddress() 
	{	return address;
	}

	public void setHost(String host) 
	{	this.host = host;
	}
	public String getHost() 
	{	return host;
	}

	public void setBrowser(String browser) 
	{	this.browser = browser;
	}
	public String getBrowser() 
	{	return browser;
	}
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	
	
}