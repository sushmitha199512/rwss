package nic.watersoft.worksMonitoring;

import org.apache.struts.action.ActionForm;
import javax.servlet.http.*;
import org.apache.struts.action.*;
import org.apache.struts.validator.ValidatorActionForm;

public class PhysicalProgressActionForm extends ValidatorActionForm
{
	private String cmbCircle;
	private int	cmbDivision;
	private String cmbSubDivision;
	private String cmbAssetType;
	private String cmbMonth;
	private String cmbYear;
	private String enteredBy;
	private String enteredDate;
	private int noPrpUptoMon;
	private int noPrpDurMon;
	private float prpCostUptoMon;
	private float prpCostDurMon;
	private int noAugWorkSandurMon;
	private int noAugWorkSanUptoMon;
	private int noPrpClrUptoMon;
	private int noPrpClrDurMon;
	private float prpCostClrUptoMon;
	private float prpCostClrDurMon;
	private int noNewWorkSanUptoMon;
	private int noNewWorkSandurMon;
	private String divisionName;
	private String circleName;
	private String cmdDel;
	private float workTenderCostDurMon;
	private float workTenderCostUptoMon;
	private float totExpinLakhsDurMon;
	private float totExpinLakhsUptoMon;
	private int noNewWorksProgDurMon;
	private int	noNewWorksProgUptoMon;
	private int noAugWorksProgDurMon;
	private int noAugWorksProgUptoMon;
	private float perPhyProgress;
	private float perOfOverallExp;
	private float totWorkValClrDurMon;
	private float totWorkValClrUptoMon;
	private int noPCHabsCovDurMon;
	private int noPCHabsCovUptoMon;
	private int noNSSHabsCovDurMon;
	private int noNSSHabsCovUptoMon;
	private int noPCHabsTarUptoMon;
	private int noPCHabsTarDurMon;
	private int noNSSHabsTarUptoMon;
	private int noNSSHabsTarDurMon;
	private float costSpoverWorksDurMon;
	private float costSpoverWorksUptoMon;
	private float costOngoWorksUptoMon;
	private float costOngoWorksDurMon;
	private int totWorksCompDurMon;
	private int totWorksCompUptoMon;
	private int totWorksGrdDurMon;
	private int totWorksGrdUptoMon;
	private int totWorksAdmsanDurMon;
	private int totWorksAdmsanUptoMon;
	private int totWorksTechsanDurMon;
	private int totWorksTechsanUptoMon;
	private int totofWorksCompDurMon;
	private int totofWorksCompUptoMon;


	public void setTotofWorksCompDurMon(int totofWorksCompDurMon)
	{
		this.totofWorksCompDurMon = totofWorksCompDurMon;
	}
	public int getTotofWorksCompDurMon()
	{
	return totofWorksCompDurMon;
	}
	public void setTotofWorksCompUptoMon(int totofWorksCompUptoMon)
	{
		this.totofWorksCompUptoMon = totofWorksCompUptoMon;
	}
	public int getTotofWorksCompUptoMon()
	{
		return totofWorksCompUptoMon;
	}
	public void setTotWorksTechsanDurMon(int totWorksTechsanDurMon)
	{
		this.totWorksTechsanDurMon = totWorksTechsanDurMon;
	}
	public int getTotWorksTechsanDurMon()
	{
		return totWorksTechsanDurMon;
	}
	public void setTotWorksTechsanUptoMon(int totWorksTechsanUptoMon)
	{
		this.totWorksTechsanUptoMon = totWorksTechsanUptoMon;
	}
	public int getTotWorksTechsanUptoMon()
	{
		return totWorksTechsanUptoMon;
	}
	public void setTotWorksAdmsanUptoMon(int totWorksAdmsanUptoMon)
	{
		this.totWorksAdmsanUptoMon = totWorksAdmsanUptoMon;
	}
	public int getTotWorksAdmsanUptoMon()
	{
		return totWorksAdmsanUptoMon;
	}
	public void setTotWorksAdmsanDurMon(int totWorksAdmsanDurMon)
	{
		this.totWorksAdmsanDurMon = totWorksAdmsanDurMon;
	}
	public int getTotWorksAdmsanDurMon()
	{
		return totWorksAdmsanDurMon;
	}
	public void setTotWorksGrdDurMon(int totWorksGrdDurMon)
	{
		this.totWorksGrdDurMon = totWorksGrdDurMon;
	}
	public int getTotWorksGrdDurMon()
	{
		return totWorksGrdDurMon;
	}
	public void setTotWorksGrdUptoMon(int totWorksGrdUptoMon)
	{
		this.totWorksGrdUptoMon = totWorksGrdUptoMon;
	}
	public int getTotWorksGrdUptoMon()
	{
		return totWorksGrdUptoMon;
	}
	public void setTotWorksCompDurMon(int totWorksCompDurMon)
	{
		this.totWorksCompDurMon = totWorksCompDurMon;
	}
	public int getTotWorksCompDurMon()
	{
		return totWorksCompDurMon;
	}
	public void setTotWorksCompUptoMon(int totWorksCompUptoMon)
	{
		this.totWorksCompUptoMon = totWorksCompUptoMon;
	}
	public int getTotWorksCompUptoMon()
	{
		return totWorksCompUptoMon;
	}
	public void setCostOngoWorksUptoMon(float costOngoWorksUptoMon)
	{
		this.costOngoWorksUptoMon = costOngoWorksUptoMon;
	}
	public float getCostOngoWorksUptoMon()
	{
		return costOngoWorksUptoMon;
	}
	public void setCostOngoWorksDurMon(float costOngoWorksDurMon)
	{
		this.costOngoWorksDurMon = costOngoWorksDurMon;
	}
	public float getCostOngoWorksDurMon()
	{
		return costOngoWorksDurMon;
	}

	public void setCostSpoverWorksDurMon(float costSpoverWorksDurMon)
	{
		this.costSpoverWorksDurMon = costSpoverWorksDurMon;
	}
	public float getCostSpoverWorksDurMon()
	{
		return costSpoverWorksDurMon;
	}
	public void setCostSpoverWorksUptoMon(float costSpoverWorksUptoMon)
	{
		this.costSpoverWorksUptoMon = costSpoverWorksUptoMon;
	}
	public float getCostSpoverWorksUptoMon()
	{
		return costSpoverWorksUptoMon;
	}
	public void setNoNSSHabsTarUptoMon(int noNSSHabsTarUptoMon)
	{
		this.noNSSHabsTarUptoMon = noNSSHabsTarUptoMon;
	}
	public int getNoNSSHabsTarUptoMon()
	{
		return noNSSHabsTarUptoMon;
	}
	public void setNoNSSHabsTarDurMon(int noNSSHabsTarDurMon)
	{
		this.noNSSHabsTarDurMon = noNSSHabsTarDurMon;
	}
	public int getNoNSSHabsTarDurMon()
	{
		return noNSSHabsTarDurMon;
	}
	public void setNoPCHabsTarUptoMon(int noPCHabsTarUptoMon)
	{
		this.noPCHabsTarUptoMon = noPCHabsTarUptoMon;
	}
	public int getNoPCHabsTarUptoMon()
	{
		return noPCHabsTarUptoMon;
	}
	public void setNoPCHabsTarDurMon(int noPCHabsTarDurMon)
	{
		this.noPCHabsTarDurMon = noPCHabsTarDurMon;
	}
	public int getNoPCHabsTarDurMon()
	{
		return noPCHabsTarDurMon;
	}
	public void setNoNSSHabsCovDurMon(int noNSSHabsCovDurMon)
	{
		this.noNSSHabsCovDurMon = noNSSHabsCovDurMon;
	}
	public int getNoNSSHabsCovDurMon()
	{
		return noNSSHabsCovDurMon;
	}
	public void setNoNSSHabsCovUptoMon(int noNSSHabsCovUptoMon)
	{
		this.noNSSHabsCovUptoMon = noNSSHabsCovUptoMon;
	}
	public int getNoNSSHabsCovUptoMon()
	{
		return noNSSHabsCovUptoMon;
	}
	public void setNoPCHabsCovDurMon(int noPCHabsCovDurMon)
	{
		this.noPCHabsCovDurMon = noPCHabsCovDurMon;
	}
	public int getNoPCHabsCovDurMon()
	{
		return noPCHabsCovDurMon;
	}
	public void setNoPCHabsCovUptoMon(int noPCHabsCovUptoMon)
	{
		this.noPCHabsCovUptoMon = noPCHabsCovUptoMon;
	}
	public int getNoPCHabsCovUptoMon()
	{
		return noPCHabsCovUptoMon;
	}
	public void setTotWorkValClrDurMon(float totWorkValClrDurMon)
	{
		this.totWorkValClrDurMon = totWorkValClrDurMon;
	}
	public float getTotWorkValClrDurMon()
	{
		return totWorkValClrDurMon;
	}
	public void setTotWorkValClrUptoMon(float totWorkValClrUptoMon)
	{
		this.totWorkValClrUptoMon = totWorkValClrUptoMon;
	}
	public float getTotWorkValClrUptoMon()
	{
		return totWorkValClrUptoMon;
	}
	public void setPerOfOverallExp(float perOfOverallExp)
	{
		this.perOfOverallExp = perOfOverallExp;
	}
	public float getPerOfOverallExp()
	{
		return perOfOverallExp;
	}
	public void setPerPhyProgress(float perPhyProgress)
	{
		this.perPhyProgress = perPhyProgress;
	}
	public float getPerPhyProgress()
	{
		return perPhyProgress;
	}
	public void setNoAugWorksProgDurMon(int noAugWorksProgDurMon)
	{
		this.noAugWorksProgDurMon = noAugWorksProgDurMon;
	}
	public int getNoAugWorksProgDurMon()
	{
		return noAugWorksProgDurMon;
	}
	public void setNoAugWorksProgUptoMon(int noAugWorksProgUptoMon)
	{
		this.noAugWorksProgUptoMon = noAugWorksProgUptoMon;
	}
	public int getNoAugWorksProgUptoMon()
	{
		return noAugWorksProgUptoMon;
	}
	public void setNoNewWorksProgDurMon(int noNewWorksProgDurMon)
	{
		this.noNewWorksProgDurMon = noNewWorksProgDurMon;
	}
	public int getNoNewWorksProgDurMon()
	{
		return noNewWorksProgDurMon;
	}
	public void setNoNewWorksProgUptoMon(int noNewWorksProgUptoMon)
	{
		this.noNewWorksProgUptoMon = noNewWorksProgUptoMon;
	}
	public int getNoNewWorksProgUptoMon()
	{
		return noNewWorksProgUptoMon;
	}
	public void setWorkTenderCostDurMon(float workTenderCostDurMon)
	{
		this.workTenderCostDurMon = workTenderCostDurMon;
	}
	public float getWorkTenderCostDurMon()
	{
		return workTenderCostDurMon;
	}
	public void setWorkTenderCostUptoMon(float workTenderCostUptoMon)
	{
		this.workTenderCostUptoMon = workTenderCostUptoMon;
	}
	public float getWorkTenderCostUptoMon()
	{
		return workTenderCostUptoMon;
	}
	public void setTotExpinLakhsUptoMon(float totExpinLakhsUptoMon)
	{
		this.totExpinLakhsUptoMon = totExpinLakhsUptoMon;
	}
	public float getTotExpinLakhsUptoMon()
	{
		return totExpinLakhsUptoMon;
	}
	public void setTotExpinLakhsDurMon(float totExpinLakhsDurMon)
	{
		this.totExpinLakhsDurMon = totExpinLakhsDurMon;
	}
	public float getTotExpinLakhsDurMon()
	{
		return totExpinLakhsDurMon;
	}
//----------------------------------------------------------------------------------	

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
	public void setNoPrpUptoMon(int noPrpUptoMon)
	{
		this.noPrpUptoMon = noPrpUptoMon;
	}
	public int getNoPrpUptoMon()
	{
		return noPrpUptoMon;
	}
	public void setNoPrpDurMon(int noPrpDurMon)
	{
		this.noPrpDurMon = noPrpDurMon;
	}
	public int getNoPrpDurMon()
	{
		return noPrpDurMon;
	}
	public void setPrpCostUptoMon(float prpCostUptoMon)
	{
		this.prpCostUptoMon = prpCostUptoMon;
	}
	public float getPrpCostUptoMon()
	{
		return prpCostUptoMon;
	}
	public void setPrpCostDurMon(float prpCostDurMon)
	{
		this.prpCostDurMon = prpCostDurMon;
	}
	public float getPrpCostDurMon()
	{
		return prpCostDurMon;
	}

	public void setNoAugWorkSanUptoMon(int noAugWorkSanUptoMon)
	{
		this.noAugWorkSanUptoMon = noAugWorkSanUptoMon;
	}
	public int getNoAugWorkSanUptoMon()
	{
		return noAugWorkSanUptoMon;
	}
	public void setNoAugWorkSandurMon(int noAugWorkSandurMon)
	{
		this.noAugWorkSandurMon = noAugWorkSandurMon;
	}
	public int getNoAugWorkSandurMon()
	{
		return noAugWorkSandurMon;
	}
	public void setNoPrpClrUptoMon(int noPrpClrUptoMon)
	{
		this.noPrpClrUptoMon = noPrpClrUptoMon;
	}
	public int getNoPrpClrUptoMon()
	{
		return noPrpClrUptoMon;
	}
	public void setNoPrpClrDurMon(int noPrpClrDurMon)
	{
		this.noPrpClrDurMon = noPrpClrDurMon;
	}
	public int getNoPrpClrDurMon()
	{
		return noPrpClrDurMon;
	}
	public void setPrpCostClrUptoMon(float prpCostClrUptoMon)
	{
		this.prpCostClrUptoMon = prpCostClrUptoMon;
	}
	public float getPrpCostClrUptoMon()
	{
		return prpCostClrUptoMon;
	}
	public void setPrpCostClrDurMon(float prpCostClrDurMon)
	{
		this.prpCostClrDurMon = prpCostClrDurMon;
	}
	public float getPrpCostClrDurMon()
	{
		return prpCostClrDurMon;
	}
	public void setNoNewWorkSanUptoMon(int noNewWorkSanUptoMon)
	{
		this.noNewWorkSanUptoMon = noNewWorkSanUptoMon;
	}
	public int getNoNewWorkSanUptoMon()
	{
		return noNewWorkSanUptoMon;
	}
	public void setNoNewWorkSandurMon(int noNewWorkSandurMon)
	{
		this.noNewWorkSandurMon = noNewWorkSandurMon;
	}
	public int getNoNewWorkSandurMon()
	{
		return noNewWorkSandurMon;
	}
	
	
	

}

