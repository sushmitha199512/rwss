package nic.watersoft.worksMonitoring;

import org.apache.struts.action.ActionForm;
import javax.servlet.http.*;
import org.apache.struts.action.*;
import org.apache.struts.validator.ValidatorForm;

public class LoginActionForm extends ActionForm
{
	private String userName;
	
	private String passWord;
	private String cmdLogin;
	
//----------------------------------------------------------------------------------
	
	public void setCmdLogin(String cmdLogin)
	{
		this.cmdLogin = cmdLogin;
	}
	public String getCmdLogin()
	{
		return cmdLogin;
	}
	
	public void setUserName(String userName)
	{
		this.userName = userName;
	}
	public String getUserName()
	{
		return userName;
	}
	public void setPassWord(String passWord)
	{
		this.passWord = passWord;
	}
	public String getPassWord()
	{
		return passWord;
	}
}