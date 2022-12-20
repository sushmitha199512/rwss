
package nic.watersoft.works;
import java.io.Serializable;

public class worksforDeletion implements Serializable {

	private String workname;
	 private String workid;
	 private String sanctionno;
	 private String sanctiondt;
	 private String sanctionamount;
	 private String progName;
	 private String subprogName;
	 private String noofhabs;
	 private String wrkCanDate;


public worksforDeletion()
{
}

public worksforDeletion(String workname,String workid,String sanctionno,String sanctiondt,String sanctionamount,String progName,String subprogName,String noofhabs,String wrkCanDate)
{  
	this.workname = workname;
	this.workid = workid;
	this.sanctionno = sanctionno;
	this.sanctiondt = sanctiondt;
	this.sanctionamount = sanctionamount;
	this.progName = progName;
	this.subprogName = subprogName;
	this.noofhabs=noofhabs;
	this.wrkCanDate=wrkCanDate;
	
} 
 
	public String getWrkCanDate() {
		return wrkCanDate;
	}
	public void setWrkCanDate(String wrkCanDate) {
		this.wrkCanDate = wrkCanDate;
	}
public void setWorkname(String workname)
{
	this.workname = workname;
}
public String getWorkname()
{
	return workname;
}
public void setWorkid(String workid)
{
	this.workid = workid;
}
public String getWorkid()
{
	return workid;
}
public void setSanctionno(String sanctionno)
{
	this.sanctionno = sanctionno;
}
public String getSanctionno()
{
	return sanctionno;
}
public void setSanctiondt(String sanctiondt)
{
	this.sanctiondt = sanctiondt;
}
public String getSanctiondt()
{
	return sanctiondt;
}
public void setSanctionamount(String sanctionamount)
{
	this.sanctionamount = sanctionamount;
}
public String getSanctionamount()
{
	return sanctionamount;
}
public void setProgName(String progName)
{
	this.progName = progName;
}
public String getProgName()
{
	return progName;
}
public void setSubprogName(String subprogName)
{
	this.subprogName = subprogName;
}
public String getSubprogName()
{
	return subprogName;
}

	/**
	 * @return Returns the noofhabs.
	 */
	public String getNoofhabs() {
		return noofhabs;
	}
	/**
	 * @param noofhabs The noofhabs to set.
	 */
	public void setNoofhabs(String noofhabs) {
		this.noofhabs = noofhabs;
	}
}

