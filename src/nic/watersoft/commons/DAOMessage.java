package nic.watersoft.commons;

import java.io.Serializable;


public class DAOMessage implements Serializable {
	
	int code;
	int rowCount;

	int rowsCount[]=null;
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
	public void setDefualtErrorMessage(int errorCode)
	{
		if(errorCode==17081)
			setMessage("Record cannot be deleted as child records exists");
		else
			setMessage("Record cannot be deleted");
			
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	public int[] getRowsCount() {
		return rowsCount;
	}
	public void setRowsCount(int[] rowsCount) {
		this.rowsCount = rowsCount;
	}
}
