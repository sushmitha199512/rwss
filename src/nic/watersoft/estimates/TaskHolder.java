/*
 * Created on Jan 19, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.estimates;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TaskHolder implements Serializable
{
	private String taskCode;
	private String subTaskCode;
	private String subTaskDesc;
	private String actionName;
	private String title;
	private ArrayList assetSubTasks; 
			
	public TaskHolder()
	{
		this.actionName = "+";
		this.title = "Add one more Task / Sub Task";
	}
	/**
	 * @return Returns the actionName.
	 */
	public String getActionName() {
		return actionName;
	}
	/**
	 * @param actionName The actionName to set.
	 */
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	/**
	 * @return Returns the subTaskCode.
	 */
	public String getSubTaskCode() {
		return subTaskCode;
	}
	/**
	 * @param subTaskCode The subTaskCode to set.
	 */
	public void setSubTaskCode(String subTaskCode) {
		this.subTaskCode = subTaskCode;
	}
	/**
	 * @return Returns the subTaskDesc.
	 */
	public String getSubTaskDesc() {
		return subTaskDesc;
	}
	/**
	 * @param subTaskDesc The subTaskDesc to set.
	 */
	public void setSubTaskDesc(String subTaskDesc) {
		this.subTaskDesc = subTaskDesc;
	}
	/**
	 * @return Returns the taskCode.
	 */
	public String getTaskCode() {
		return taskCode;
	}
	/**
	 * @param taskCode The taskCode to set.
	 */
	public void setTaskCode(String taskCode) {
		this.taskCode = taskCode;
	}
	/**
	 * @return Returns the title.
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title The title to set.
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	
	public void setAssetSubTasks(ArrayList assetSubTasks)
	{	this.assetSubTasks = assetSubTasks;
	}
	public ArrayList getAssetSubTasks()
	{	return assetSubTasks;
	}
}
