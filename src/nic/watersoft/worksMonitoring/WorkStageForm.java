package nic.watersoft.worksMonitoring;

import javax.servlet.http.*;
import org.apache.struts.action.*;
import org.apache.struts.action.ActionForm;
import org.apache.struts.validator.ValidatorForm;

public class WorkStageForm extends ValidatorForm
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