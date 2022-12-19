/*
 * Created on Aug 8, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.proposals;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class DAOMessage {
	
	int code;
	String message;
	boolean operationSussess;

	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isOperationSussess() {
		return operationSussess;
	}
	public void setOperationSussess(boolean operationSussess) {
		this.operationSussess = operationSussess;
	}
	public void setDefaultMessage(int errorCode){
		if(errorCode==17081)
			setMessage("Record cannot be deleted as child records exists");
		else
			setMessage("Record cannot be deleted");
	}
	
}
