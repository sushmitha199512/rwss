package nic.watersoft.admin;
import org.apache.struts.action.ActionForm;

public class HabFreezUnfreezForm  extends ActionForm  {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 
	 */
	private String fyear;
	private String message;

	/**
	 * @return Returns the message.
	 */
	public String getMessage() {
		return message;
	}
	/**
	 * @param message The message to set.
	 */
	public void setMessage(String message) {
		this.message = message;
	}
	/**
	 * @return Returns the fyear.
	 */
	public String getFyear() {
		return fyear;
	}
	/**
	 * @param fyear The fyear to set.
	 */
	public void setFyear(String fyear) {
		this.fyear = fyear;
	}
}
