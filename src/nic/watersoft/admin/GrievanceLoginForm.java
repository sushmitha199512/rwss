package nic.watersoft.admin;
import org.apache.struts.validator.ValidatorForm;


public class GrievanceLoginForm extends ValidatorForm{
	
		private String userId;
		private String password; 
		private String number;
		
		public void setUserId(String userId)
		{	this.userId=userId;
		}
		public String getUserId()
		{	return userId;
		}

		public void setPassword(String password)
		{	this.password=password;
		}
		public String getPassword()
		{	return password;
		}
		public String getNumber() {
			return number;
		}
		public void setNumber(String number) {
			this.number = number;
		}
		
}
