package nic.watersoft.worksMonitoring;

import org.apache.struts.action.ActionForm;
import javax.servlet.http.*;

public class EOATActionBean
{
	private String cmbCircle;
	private int	cmbDivision;
	private String cmbSubDivision;
	
	private String divisionName;
	private String circleName;
	
	private String cmbProgramme;
	
	private String programmeName;
	private String cmdDel;
	private float valWorkDone;
	private float costOfWork;
	private float valWorkByndAgree;
	private float valWorktoDone;
	
//----------------------------------------------------------------------------------
	
	public void setCmbProgramme(String cmbProgramme)
	{
		this.cmbProgramme = cmbProgramme;
	}
	public String getCmbProgramme()
	{
		return cmbProgramme;
	}
	
	public void setProgrammeName(String programmeName)
	{
		this.programmeName = programmeName;
	}
	public String getProgrammeName()
	{
		return programmeName;
	}
	
	public void setCmdDel(String cmdDel)
	{
		this.cmdDel = cmdDel;
	}
	public String getCmdDel()
	{
		return cmdDel;
	}

	public void setCircleName(String circleName)
	{
		this.circleName = circleName;
	}
	public String getCircleName()
	{
		return circleName;
	}

	public void setDivisionName(String divisionName)
	{
		this.divisionName = divisionName;
	}
	public String getDivisionName()
	{
		return divisionName;
	}


	public void setCmbCircle(String cmbCircle)
	{
		this.cmbCircle = cmbCircle;
	}
	public String getCmbCircle()
	{
		return cmbCircle;
	}
	public void setCmbDivision(int cmbDivision)
	{
		this.cmbDivision = cmbDivision;
	}
	public int getCmbDivision()
	{
		return cmbDivision;
	}
	public void setCmbSubDivision(String cmbSubDivision)
	{
		this.cmbSubDivision = cmbSubDivision;
	}
	public String getCmbSubDivision()
	{
		return cmbSubDivision;
	}
	public void setValWorkDone(float valWorkDone)
	{
		this.valWorkDone = valWorkDone;
	}
	public float getValWorkDone()
	{
		return valWorkDone;
	}
	public void setCostOfWork(float costOfWork)
	{
		this.costOfWork = costOfWork;
	}
	public float getCostOfWork()
	{
		return costOfWork;
	}
	public void setValWorkByndAgree(float valWorkByndAgree)
	{
		this.valWorkByndAgree = valWorkByndAgree;
	}
	public float getValWorkByndAgree()
	{
		return valWorkByndAgree;
	}
	
public void setValWorktoDone(float valWorktoDone)
	{
		this.valWorktoDone = valWorktoDone;
	}
	public float getValWorktoDone()
	{
		return valWorktoDone;
	}
}

