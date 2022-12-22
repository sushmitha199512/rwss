package nic.watersoft.works;

import javax.servlet.http.*;

public class WorkStageBean 
{
	private int workStageCode;
	private String workStageName;
	
	public void setWorkStageCode(int workStageCode)
	{
		this.workStageCode = workStageCode;
	}
	public int getWorkStageCode()
	{
		return workStageCode;
	}
	public void setWorkStageName(String workStageName)
	{
		this.workStageName = workStageName;
	}
	public String getWorkStageName()
	{
		return workStageName;
	}
	
}