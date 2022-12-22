package nic.watersoft.worksMonitoring;

import org.apache.struts.action.ActionForm;
import javax.servlet.http.*;
import org.apache.struts.action.*;


public class FinancialProgressActionFormt extends ActionForm
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
	private String cmdDel;
	private String cmbProgramme;
	private String cmbSubprogramme;
	private String programmeName;
	private String subprogrammeName;
	
	private float valWorkDone;
	private float costOfWork;
	private float valWrkBAgr;
	private float valWrkToDone;
	private String dateComp;
	private String eoatOrderNo;
	private String eoatDate;
	private float cstEscSought;
	private int eoatPeriod;
	private String eoatORNo1;
	private String eoatORDt1;
	private String eoatORNo2;
	private String eoatORDt2;
	private float fineImposed;
	private float fineRecovered;
	private String rsnsForNotRecFine;
	private String officerResp1;
	private String officerResp2;
	private String officerResp3;
	private String exemptRecSE;
	private String totDaysExemptSE;
	private float ratePenalty;
	private float totalPenalty;
	private String reasonsContractor;
	private String contRepUpd;
	private String agreeCopyPenalUpd;
	private String suppDocExmpUpd;
	private String aeeRecommend;
	private String deeRecommend;
	private String eeRecommend;
	private String seRecommend;
	private String ceRecommend;
	private String eoatGrantAuth;
	private String suppAgreeNo;
	private String suppAgreeDt;
	private String preparedBy;
	private String preparedDt;
	private String cmdNext;
	private String cmdinssub;
//----------------------------------------------------------------------------------
	public void setCmdinssub(String cmdinssub)
	{
		this.cmdinssub = cmdinssub;
	}
	public String getCmdinssub()
	{
		return cmdinssub;
	}
	public void setCmdNext(String cmdNext)
	{
		this.cmdNext = cmdNext;
	}
	public String getCmdNext()
	{
		return cmdNext;
	}
	public void setPreparedDt(String preparedDt)
	{
		this.preparedDt = preparedDt;
	}
	public String getPreparedDt()
	{
		return preparedDt;
	}
	public void setPreparedBy(String preparedBy)
	{
		this.preparedBy = preparedBy;
	}
	public String getPreparedBy()
	{
		return preparedBy;
	}
	public void setSuppAgreeDt(String suppAgreeDt)
	{
		this.suppAgreeDt = suppAgreeDt;
	}
	public String getSuppAgreeDt()
	{
		return suppAgreeDt;
	}
	public void setSuppAgreeNo(String suppAgreeNo)
	{
		this.suppAgreeNo = suppAgreeNo;
	}
	public String getSuppAgreeNo()
	{
		return suppAgreeNo;
	}
	public void setEoatGrantAuth(String eoatGrantAuth)
	{
		this.eoatGrantAuth = eoatGrantAuth;
	}
	public String getEoatGrantAuth()
	{
		return eoatGrantAuth;
	}
	public void setCeRecommend(String ceRecommend)
	{
		this.ceRecommend = ceRecommend;
	}
	public String getCeRecommend()
	{
		return ceRecommend;
	}
	public void setSeRecommend(String seRecommend)
	{
		this.seRecommend = seRecommend;
	}
	public String getSeRecommend()
	{
		return seRecommend;
	}
	public void setEeRecommend(String eeRecommend)
	{
		this.eeRecommend = eeRecommend;
	}
	public String getEeRecommend()
	{
		return eeRecommend;
	}
	public void setDeeRecommend(String deeRecommend)
	{
		this.deeRecommend = deeRecommend;
	}
	public String getDeeRecommend()
	{
		return deeRecommend;
	}
	public void setAeeRecommend(String aeeRecommend)
	{
		this.aeeRecommend = aeeRecommend;
	}
	public String getAeeRecommend()
	{
		return aeeRecommend;
	}
	public void setSuppDocExmpUpd(String suppDocExmpUpd)
	{
		this.suppDocExmpUpd = suppDocExmpUpd;
	}
	public String getSuppDocExmpUpd()
	{
		return suppDocExmpUpd;
	}
	public void setAgreeCopyPenalUpd(String agreeCopyPenalUpd)
	{
		this.agreeCopyPenalUpd = agreeCopyPenalUpd;
	}
	public String getAgreeCopyPenalUpd()
	{
		return agreeCopyPenalUpd;
	}
	public void setContRepUpd(String contRepUpd)
	{
		this.contRepUpd = contRepUpd;
	}
	public String getContRepUpd()
	{
		return contRepUpd;
	}
	public void setReasonsContractor(String reasonsContractor)
	{
		this.reasonsContractor = reasonsContractor;
	}
	public String getReasonsContractor()
	{
		return reasonsContractor;
	}
	public void setTotalPenalty(float totalPenalty)
	{
		this.totalPenalty = totalPenalty;
	}
	public float getTotalPenalty()
	{
		return totalPenalty;
	}
	public void setRatePenalty(float ratePenalty)
	{
		this.ratePenalty = ratePenalty;
	}
	public float getRatePenalty()
	{
		return ratePenalty;
	}
	public void setTotDaysExemptSE(String totDaysExemptSE)
	{
		this.totDaysExemptSE = totDaysExemptSE;
	}
	public String getTotDaysExemptSE()
	{
		return totDaysExemptSE;
	}
	public void setExemptRecSE(String exemptRecSE)
	{
		this.exemptRecSE = exemptRecSE;
	}
	public String getExemptRecSE()
	{
		return exemptRecSE;
	}
	public void setOfficerResp3(String officerResp3)
	{
		this.officerResp3 = officerResp3;
	}
	public String getOfficerResp3()
	{
		return officerResp3;
	}
	public void setOfficerResp2(String officerResp2)
	{
		this.officerResp2 = officerResp2;
	}
	public String getOfficerResp2()
	{
		return officerResp2;
	}
	public void setOfficerResp1(String officerResp1)
	{
		this.officerResp1 = officerResp1;
	}
	public String getOfficerResp1()
	{
		return officerResp1;
	}
	public void setRsnsForNotRecFine(String rsnsForNotRecFine)
	{
		this.rsnsForNotRecFine = rsnsForNotRecFine;
	}
	public String getRsnsForNotRecFine()
	{
		return rsnsForNotRecFine;
	}
	public void setFineRecovered(float fineRecovered)
	{
		this.fineRecovered = fineRecovered;
	}
	public float getFineRecovered()
	{
		return fineRecovered;
	}
	public void setFineImposed(float fineImposed)
	{
		this.fineImposed = fineImposed;
	}
	public float getFineImposed()
	{
		return fineImposed;
	}
	public void setEoatORDt2(String eoatORDt2)
	{
		this.eoatORDt2 = eoatORDt2;
	}
	public String getEoatORDt2()
	{
		return eoatORDt2;
	}
	public void setEoatORNo2(String eoatORNo2)
	{
		this.eoatORNo2 = eoatORNo2;
	}
	public String getEoatORNo2()
	{
		return eoatORNo2;
	}
	public void setEoatORDt1(String eoatORDt1)
	{
		this.eoatORDt1 = eoatORDt1;
	}
	public String getEoatORDt1()
	{
		return eoatORDt1;
	}
	public void setEoatORNo1(String eoatORNo1)
	{
		this.eoatORNo1 = eoatORNo1;
	}
	public String getEoatORNo1()
	{
		return eoatORNo1;
	}
	public void setEoatPeriod(int eoatPeriod)
	{
		this.eoatPeriod = eoatPeriod;
	}
	public int getEoatPeriod()
	{
		return eoatPeriod;
	}
	public void setCstEscSought(float cstEscSought)
	{
		this.cstEscSought = cstEscSought;
	}
	public float getCstEscSought()
	{
		return cstEscSought;
	}
	public void setEoatDate(String eoatDate)
	{
		this.eoatDate = eoatDate;
	}
	public String getEoatDate()
	{
		return eoatDate;
	}
	public void setEoatOrderNo(String eoatOrderNo)
	{
		this.eoatOrderNo = eoatOrderNo;
	}
	public String getEoatOrderNo()
	{
		return eoatOrderNo;
	}
	public void setDateComp(String dateComp)
	{
		this.dateComp = dateComp;
	}
	public String getDateComp()
	{
		return dateComp;
	}
	public void setValWrkToDone(float valWrkToDone)
	{
		this.valWrkToDone = valWrkToDone;
	}
	public float getValWrkToDone()
	{
		return valWrkToDone;
	}
	public void setValWrkBAgr(float valWrkBAgr)
	{
		this.valWrkBAgr = valWrkBAgr;
	}
	public float getValWrkBAgr()
	{
		return valWrkBAgr;
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
	
	
	

}

