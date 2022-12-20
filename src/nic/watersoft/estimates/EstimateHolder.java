package nic.watersoft.estimates;

import java.io.Serializable;
import java.util.ArrayList;

public class EstimateHolder implements Serializable
{
	private String assetComponentCode;
	private String assetComponent;
	private String assetSubComponentCode;
	private String assetSubComponent;
	private String assetTaskCode;
	private String assetTask;
	private String assetSubtaskCode;
	private String assetSubtask;
	private String quantity;
	private String unitRate;
	private String amount;
	private String taskSubTask;
	private ArrayList tasks;
	
	public void setAssetComponent(String assetComponent)
	{	this.assetComponent = assetComponent;
	}			   
	public String getAssetComponent()
	{	return assetComponent;
	}			   
				   
	public void setAssetSubComponent(String assetSubComponent)
	{	this.assetSubComponent = assetSubComponent;
	}			   
	public String getAssetSubComponent()
	{	return assetSubComponent;
	}			   
				   
	public void setQuantity(String quantity)
	{	this.quantity = quantity;
	}
	public String getQuantity()
	{	return quantity;
	}
		
	public void setUnitRate(String unitRate)
	{	this.unitRate = unitRate;
	}
	public String getUnitRate()
	{	return unitRate;
	}

	public void setAmount(String amount)
	{	this.amount = amount;
	}			   
	public String getAmount()
	{	return amount;
	}
	
	public String getTaskSubTask()
	{	return taskSubTask;
	}
	
	public void setTaskSubTask(String taskSubTask)
	{	this.taskSubTask = taskSubTask;
	}
	
	public void setTasks(ArrayList tasks)
	{	this.tasks = tasks;
	}
	public ArrayList getTasks()
	{	return tasks;
	}
	
	/**
	 * @return Returns the assetSubtask.
	 */
	public String getAssetSubtask() {
		return assetSubtask;
	}
	/**
	 * @param assetSubtask The assetSubtask to set.
	 */
	public void setAssetSubtask(String assetSubtask) {
		this.assetSubtask = assetSubtask;
	}
	/**
	 * @return Returns the assetTask.
	 */
	public String getAssetTask() {
		return assetTask;
	}
	/**
	 * @param assetTask The assetTask to set.
	 */
	public void setAssetTask(String assetTask) {
		this.assetTask = assetTask;
	}
	/**
	 * @return Returns the assetComponentCode.
	 */
	public String getAssetComponentCode() {
		return assetComponentCode;
	}
	/**
	 * @param assetComponentCode The assetComponentCode to set.
	 */
	public void setAssetComponentCode(String assetComponentCode) {
		this.assetComponentCode = assetComponentCode;
	}
	/**
	 * @return Returns the assetSubComponentCode.
	 */
	public String getAssetSubComponentCode() {
		return assetSubComponentCode;
	}
	/**
	 * @param assetSubComponentCode The assetSubComponentCode to set.
	 */
	public void setAssetSubComponentCode(String assetSubComponentCode) {
		this.assetSubComponentCode = assetSubComponentCode;
	}
	/**
	 * @return Returns the assetSubtaskCode.
	 */
	public String getAssetSubtaskCode() {
		return assetSubtaskCode;
	}
	/**
	 * @param assetSubtaskCode The assetSubtaskCode to set.
	 */
	public void setAssetSubtaskCode(String assetSubtaskCode) {
		this.assetSubtaskCode = assetSubtaskCode;
	}
	/**
	 * @return Returns the assetTaskCode.
	 */
	public String getAssetTaskCode() {
		return assetTaskCode;
	}
	/**
	 * @param assetTaskCode The assetTaskCode to set.
	 */
	public void setAssetTaskCode(String assetTaskCode) {
		this.assetTaskCode = assetTaskCode;
	}
}