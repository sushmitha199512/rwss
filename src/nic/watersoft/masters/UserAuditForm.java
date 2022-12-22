package nic.watersoft.masters;

 

import org.apache.struts.action.ActionForm;


public class UserAuditForm extends ActionForm
{
	private String mode=null;
	private String toDate=null;
	private String fromDate=null;
	private String user=null;

	public void setMode(String mode)
	{
		this.mode=mode;
	}
	public String getMode()
	{
		return mode;
	}
	public void setToDate(String toDate)
	{
		this.toDate=toDate;
	}
	public String getToDate()
	{
		return toDate;
	}
	public void setFromDate(String fromDate)
	{
		this.fromDate=fromDate;
	}
	public String getFromDate()
	{
		return fromDate;
	}
	public void setUser(String user)
	{
		this.user=user;
	}
	public String getUser()
	{
		return user;
	}
}