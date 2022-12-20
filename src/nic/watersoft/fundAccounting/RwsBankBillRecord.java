package nic.watersoft.fundAccounting;

import java.io.Serializable;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsBankBillRecord implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cirlceName;
	private String divName;
	private String workId;
	private String workName;
	private String sanctionAmount;
	private String programe;
	private String subPrograme;
	private String billSlNo;
	private String billDate;
	private String billEnterDate;
	private String eeFWdDate;
	private String billAmtContractor;
	private String billAmtAdmissible;
	private String dueActual;
	private String dueState;
	private String dueGOI;
	private String paidActual;
	private String paidState;
	private String paidGOI;
	private String recomandedActual;
	//private String recomandedState;
	private String recomandedGOI;
	private String checks;
	private String billNo;
	private String recomandedStatePer;
	private String recomandedGOILast;
	private String recomandedGOIA;
	private String offieCode;
	private String recordStatus;
	private String checkMeasuredByDEE;
	private String checkMeasuredDateDEE;
	private String mbookNoDEE;

	private String checkMeasuredByEE;
	private String checkMeasuredDateEE;
	private String mbookNoEE;
	private String checkMeasuredBySE;
	private String checkMeasuredDateSE;
	private String mbookNoSE;
    private String bmsno;
    private String work_img;
    private String passOrderScanCopyAvailable;
    private String estCost;
    private String noOfHabs;
    private String subProgramCode;
	
    
    public String getSubProgramCode() {
		return subProgramCode;
	}

	public void setSubProgramCode(String subProgramCode) {
		this.subProgramCode = subProgramCode;
	}    
  
    public String getEstCost() {
		return estCost;
	}

	public void setEstCost(String estCost) {
		this.estCost = estCost;
	}

	public String getNoOfHabs() {
		return noOfHabs;
	}

	public void setNoOfHabs(String noOfHabs) {
		this.noOfHabs = noOfHabs;
	}

	public String getPassOrderScanCopyAvailable() {
		return passOrderScanCopyAvailable;
	}

	public void setPassOrderScanCopyAvailable(String passOrderScanCopyAvailable) {
		this.passOrderScanCopyAvailable = passOrderScanCopyAvailable;
	}

	public String  getbmsno() {
		return bmsno;
	}

	public void setbmsno(String bmsno) {
		this.bmsno = bmsno;
	}
    
	public String getCheckMeasuredByEE() {
		return checkMeasuredByEE;
	}

	public void setCheckMeasuredByEE(String checkMeasuredByEE) {
		this.checkMeasuredByEE = checkMeasuredByEE;
	}

	public String getCheckMeasuredDateEE() {
		return checkMeasuredDateEE;
	}

	public void setCheckMeasuredDateEE(String checkMeasuredDateEE) {
		this.checkMeasuredDateEE = checkMeasuredDateEE;
	}

	public String getMbookNoEE() {
		return mbookNoEE;
	}

	public void setMbookNoEE(String mbookNoEE) {
		this.mbookNoEE = mbookNoEE;
	}

	public String getCheckMeasuredByDEE() {
		return checkMeasuredByDEE;
	}

	public void setCheckMeasuredByDEE(String checkMeasuredByDEE) {
		this.checkMeasuredByDEE = checkMeasuredByDEE;
	}

	public String getCheckMeasuredDateDEE() {
		return checkMeasuredDateDEE;
	}

	public void setCheckMeasuredDateDEE(String checkMeasuredDateDEE) {
		this.checkMeasuredDateDEE = checkMeasuredDateDEE;
	}

	public String getMbookNoDEE() {
		return mbookNoDEE;
	}

	public void setMbookNoDEE(String mbookNoDEE) {
		this.mbookNoDEE = mbookNoDEE;
	}

	public String getCheckMeasuredBySE() {
		return checkMeasuredBySE;
	}

	public void setCheckMeasuredBySE(String checkMeasuredBySE) {
		this.checkMeasuredBySE = checkMeasuredBySE;
	}

	public String getCheckMeasuredDateSE() {
		return checkMeasuredDateSE;
	}

	public void setCheckMeasuredDateSE(String checkMeasuredDateSE) {
		this.checkMeasuredDateSE = checkMeasuredDateSE;
	}

	public String getMbookNoSE() {
		return mbookNoSE;
	}

	public void setMbookNoSE(String mbookNoSE) {
		this.mbookNoSE = mbookNoSE;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	private String paoFlag;

	public String getRecomandedStatePer() {
		return recomandedStatePer;
	}

	public void setRecomandedStatePer(String recomandedStatePer) {
		this.recomandedStatePer = recomandedStatePer;
	}

	public String getRecomandedGOILast() {
		return recomandedGOILast;
	}

	public void setRecomandedGOILast(String recomandedGOILast) {
		this.recomandedGOILast = recomandedGOILast;
	}

	private String eeFwdDate;

	public String getCirlceName() {
		return cirlceName;
	}

	public void setCirlceName(String cirlceName) {
		this.cirlceName = cirlceName;
	}

	public String getDivName() {
		return divName;
	}

	public void setDivName(String divName) {
		this.divName = divName;
	}

	public String getWorkId() {
		return workId;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public String getWorkName() {
		return workName;
	}

	public void setWorkName(String workName) {
		this.workName = workName;
	}

	public String getSanctionAmount() {
		return sanctionAmount;
	}

	public void setSanctionAmount(String sanctionAmount) {
		this.sanctionAmount = sanctionAmount;
	}

	public String getPrograme() {
		return programe;
	}

	public void setPrograme(String programe) {
		this.programe = programe;
	}

	public String getSubPrograme() {
		return subPrograme;
	}

	public void setSubPrograme(String subPrograme) {
		this.subPrograme = subPrograme;
	}

	public String getBillSlNo() {
		return billSlNo;
	}

	public void setBillSlNo(String billSlNo) {
		this.billSlNo = billSlNo;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public String getBillEnterDate() {
		return billEnterDate;
	}

	public void setBillEnterDate(String billEnterDate) {
		this.billEnterDate = billEnterDate;
	}

	public String getEeFWdDate() {
		return eeFWdDate;
	}

	public void setEeFWdDate(String eeFWdDate) {
		this.eeFWdDate = eeFWdDate;
	}

	public String getBillAmtContractor() {
		return billAmtContractor;
	}

	public void setBillAmtContractor(String billAmtContractor) {
		this.billAmtContractor = billAmtContractor;
	}

	public String getBillAmtAdmissible() {
		return billAmtAdmissible;
	}

	public void setBillAmtAdmissible(String billAmtAdmissible) {
		this.billAmtAdmissible = billAmtAdmissible;
	}

	public String getDueActual() {
		return dueActual;
	}

	public void setDueActual(String dueActual) {
		this.dueActual = dueActual;
	}

	public String getDueState() {
		return dueState;
	}

	public void setDueState(String dueState) {
		this.dueState = dueState;
	}

	public String getDueGOI() {
		return dueGOI;
	}

	public void setDueGOI(String dueGOI) {
		this.dueGOI = dueGOI;
	}

	public String getPaidActual() {
		return paidActual;
	}

	public void setPaidActual(String paidActual) {
		this.paidActual = paidActual;
	}

	public String getPaidState() {
		return paidState;
	}

	public void setPaidState(String paidState) {
		this.paidState = paidState;
	}

	public String getPaidGOI() {
		return paidGOI;
	}

	public void setPaidGOI(String paidGOI) {
		this.paidGOI = paidGOI;
	}

	public String getRecomandedActual() {
		return recomandedActual;
	}

	public void setRecomandedActual(String recomandedActual) {
		this.recomandedActual = recomandedActual;
	}

//	public String getRecomandedState() {
//		return recomandedState;
//	}
//
//	public void setRecomandedState(String recomandedState) {
//		this.recomandedState = recomandedState;
//	}

	public String getRecomandedGOI() {
		if (this.recomandedGOI == null) {
			return "0.0";
		}
		return recomandedGOI;
	}

	public void setRecomandedGOI(String recomandedGOI) {
		this.recomandedGOI = recomandedGOI;
	}

	public String getChecks() {
		return checks;
	}

	public void setChecks(String checks) {
		this.checks = checks;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getBillNo() {
		return billNo;
	}

	public void setEeFwdDate(String eeFwdDate) {
		this.eeFwdDate = eeFwdDate;
	}

	public String getEeFwdDate() {
		return eeFwdDate;
	}

	public void setRecomandedGOIA(String recomandedGOIA) {
		this.recomandedGOIA = recomandedGOIA;
	}

	public String getRecomandedGOIA() {
		if (this.recomandedGOIA == null) {
			return "0.0";
		}
		return recomandedGOIA;
	}

	public void setOffieCode(String offieCode) {
		this.offieCode = offieCode;
	}

	public String getOffieCode() {
		return offieCode;
	}

	public void setRecordStatus(String recordStatus) {
		this.recordStatus = recordStatus;
	}

	public String getRecordStatus() {
		return recordStatus;
	}

	public void setPaoFlag(String paoFlag) {
		this.paoFlag = paoFlag;
	}

	public String getPaoFlag() {
		return paoFlag;
	}

	public String getWork_img() {
		return work_img;
	}

	public void setWork_img(String work_img) {
		this.work_img = work_img;
	}
	

}
