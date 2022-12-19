package nic.watersoft.worksMonitoring;

import org.apache.struts.action.ActionForm;
import javax.servlet.http.*;

public class PhysicalProgressQueryActionForm extends ActionForm
{
	private String cmbCircle;
	private int	cmbDivision;
	private String cmbSubDivision;
	private String cmbAssetType;
	private String cmbMonth;
	private String cmbYear;
    private String circleCode;
    private String circleName;
	private String divisionName;
    
	public void setDivisionName(String divisionName)
	{
		this.divisionName = divisionName;
	}
	public String getDivisionName()
	{
		return divisionName;
	}


	public void setCircleName(String circleName)
	{
		this.circleName = circleName;
	}
	public String getCircleName()
	{
		return circleName;
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
	
	

}

