package nic.watersoft.admin;

import org.apache.struts.validator.ValidatorForm;

public class LoginForm extends ValidatorForm
{
	private String userId;
	private String password; 
	private String number;
	private String otp;
			
	public void setUserId(String userId)
	{	
		this.userId=userId;
	}
	public String getUserId()
	{	
		return userId;
	}

	public void setPassword(String password)
	{	
		this.password=password;
	}
	public String getPassword()
	{	
		//System.out.println("LoginForm-password bean :"+password.toString());
		return password;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getOtp() {
		return otp;
	}
	public void setOtp(String otp) {
		this.otp = otp;
	}
}