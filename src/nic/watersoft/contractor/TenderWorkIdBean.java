package nic.watersoft.contractor;

import java.io.Serializable;

public class TenderWorkIdBean implements Serializable
{
	
	private String workId=null;
	private String workName=null;
	private String work=null;
 
	public TenderWorkIdBean()
	{
		
	}
	public TenderWorkIdBean(String workId,String workName)
	{
		 this.workId=workId;
		 this.workName=workName;
	}
	
	
	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}
	/**
	 * @param workId The workId to set.
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	/**
	 * @return Returns the workName.
	 */
	public String getWorkName() {
		return workName;
	}
	/**
	 * @param workName The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	
	/**
	 * @return Returns the work.
	 */
	public String getWork() {
		return work;
	}
	/**
	 * @param work The work to set.
	 */
	public void setWork(String work) {
		this.work = work;
	}
}