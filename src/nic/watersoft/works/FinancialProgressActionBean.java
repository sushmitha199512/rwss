package nic.watersoft.works;

import org.apache.struts.action.ActionForm;
import javax.servlet.http.*;

public class FinancialProgressActionBean 
{
	private String cmbCircle;
	private int	cmbDivision;
	private String cmbSubDivision;
	private String cmbAssetType;
	private String cmbMonth;
	private String cmbYear;
	private String enteredBy;
	private String enteredDate;
	
	private String divisionName;
	private String circleName;
	private String cmbProgramme;
	private String cmbSubprogramme;
	private String programmeName;
	private String subprogrammeName;
	private float relUptoMon;
	private float relDurMon;
	private float expUptoMon;
	private float expDurMon;
	private float bgtProvisionAmt;
	private int workLoadUnits;
	private float valWorkDone;
	private float costOfWork;
//---------------------------------------------------------------

//----------------------------------------------------------------------------------------------
	public void setCostOfWork(float costOfWork)
	{
		this.costOfWork = costOfWork;
	}
	public float getCostOfWork()
	{
		return costOfWork;
	}
	public void setValWorkDone(float valWorkDone)
	{
		this.valWorkDone = valWorkDone;
	}
	
	public float getValWorkDone()
	{
		return valWorkDone;
	}
	public void setBgtProvisionAmt(float bgtProvisionAmt)
	{
		this.bgtProvisionAmt = bgtProvisionAmt;
	}
	public float getBgtProvisionAmt()
	{
		return bgtProvisionAmt;
	}
	public void setWorkLoadUnits(int workLoadUnits)
	{
		this.workLoadUnits = workLoadUnits;
	}
	public int getWorkLoadUnits()
	{
		return workLoadUnits;
	}
	public void setExpDurMon(float expDurMon)
	{
		this.expDurMon = expDurMon;
	}
	public float getExpDurMon()
	{
		return expDurMon;
	}
	public void setExpUptoMon(float expUptoMon)
	{
		this.expUptoMon = expUptoMon;
	}
	public float getExpUptoMon()
	{
		return expUptoMon;
	}
	public void setRelDurMon(float relDurMon)
	{
		this.relDurMon = relDurMon;
	}
	public float getRelDurMon()
	{
		return relDurMon;
	}
	public void setRelUptoMon(float relUptoMon)
	{
		this.relUptoMon = relUptoMon;
	}
	public float getRelUptoMon()
	{
		return relUptoMon;
	}
	public void setCmbProgramme(String cmbProgramme)
	{
		this.cmbProgramme = cmbProgramme;
	}
	public String getCmbProgramme()
	{
		return cmbProgramme;
	}
	public void setCmbSubprogramme(String cmbSubprogramme)
	{
		this.cmbSubprogramme = cmbSubprogramme;
	}
	public String getCmbSubprogramme()
	{
		return cmbSubprogramme;
	}
	public void setProgrammeName(String programmeName)
	{
		this.programmeName = programmeName;
	}
	public String getProgrammeName()
	{
		return programmeName;
	}
	public void setSubprogrammeName(String subprogrammeName)
	{
		this.subprogrammeName = subprogrammeName;
	}
	public String getSubprogrammeName()
	{
		return subprogrammeName;
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
	public void setCmbAssetType(String cmbAssetType)
	{
		this.cmbAssetType = cmbAssetType;
	}
	public String getCmbAssetType()
	{
		return cmbAssetType;
	}
	public void setCmbMonth(String cmbMonth)
	{
		this.cmbMonth = cmbMonth;
	}
	public String getCmbMonth()
	{
		return cmbMonth;
	}
	public void setCmbYear(String cmbYear)
	{
		this.cmbYear = cmbYear;
	}
	public String getCmbYear()
	{
		return cmbYear;
	}
	public void setEnteredBy(String enteredBy)
	{
		this.enteredBy = enteredBy;
	}
	public String getEnteredBy()
	{
		return enteredBy;
	}
	public void setEnteredDate(String enteredDate)
	{
		this.enteredDate = enteredDate;
	}
	public String getEnteredDate()
	{
		return enteredDate;
	}
	
	
	
	

}

