package nic.watersoft.estimates;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;


public class TaskSubTaskForm extends ActionForm
{
	private String compIndex;
	private String assetTypeCode;
	private String assetTypeName;
	private String componentCode;
	private String componentName;
	private String subComponentCode;
	private String subComponentName;
	private ArrayList tasks;
	
	public void setCompIndex(String compIndex)
	{	this.compIndex = compIndex;
	}
	public String getCompIndex()
	{	return compIndex;	
	}
	
	
	public String getAssetTypeCode() {
		return assetTypeCode;
	}
	
	public void setAssetTypeCode(String assetTypeCode) {
		this.assetTypeCode = assetTypeCode;
	}
	
	public String getAssetTypeName() {
		return assetTypeName;
	}
	
	public void setAssetTypeName(String assetTypeName) {
		this.assetTypeName = assetTypeName;
	}
	
	public String getComponentCode() {
		return componentCode;
	}
	
	public void setComponentCode(String componentCode) {
		this.componentCode = componentCode;
	}
	
	public String getComponentName() {
		return componentName;
	}
	
	public void setComponentName(String componentName) {
		this.componentName = componentName;
	}
	
	public String getSubComponentCode() {
		return subComponentCode;
	}
	
	public void setSubComponentCode(String subComponentCode) {
		this.subComponentCode = subComponentCode;
	}
	
	public String getSubComponentName() {
		return subComponentName;
	}
	
	public void setSubComponentName(String subComponentName) {
		this.subComponentName = subComponentName;
	}
	
	public ArrayList getTasks() {
		return tasks;
	}
	
	public void setTasks(ArrayList tasks) {
		this.tasks = tasks;
	}
	
	public TaskHolder getTASK(int index)
	{
		while(index >= tasks.size())
		{
			tasks.add(new TaskHolder());
		}
		return (TaskHolder)tasks.get(index);
	}
}