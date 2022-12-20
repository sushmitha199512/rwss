package nic.watersoft.works;

import java.io.Serializable;
import java.util.ArrayList;

import org.apache.struts.upload.FormFile;

public class tenderMemo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String isApproved;
	private String approvedOn;

	private String paoAdmissable;

	private String bmsTranSanctionNo;

	private String bmsTransactionDate;

	public String getBmsTranSanctionNo() {
		return bmsTranSanctionNo;
	}

	public void setBmsTranSanctionNo(String bmsTranSanctionNo) {
		this.bmsTranSanctionNo = bmsTranSanctionNo;
	}

	public String getBmsTransactionDate() {
		return bmsTransactionDate;
	}

	public void setBmsTransactionDate(String bmsTransactionDate) {
		this.bmsTransactionDate = bmsTransactionDate;
	}

	private String remove;
	private String offissuedfrom;
	private String offissuedto;
	private String workid;
	private String dateofcomp;
	private String sno;
	private String groundDate;
	private String workname;
	private String cmbWorks;
	private String works;
	private String habName;
	private String revHabName;
	private String selHabNames;
	private String panchCode;
	private String panchName;
	private String mandalName;
	private String mandalCode;
	private String subCompCode;
	private String subCompName;
	private String value;
	private String label;
	private String mstone;
	private String stages;
	private String targetDate;
	private String percentComp;
	private String mstoneCode;
	private String mstoneName;
	private String mstoneStageCode;
	private String mstoneStageName;
	private String valueOFWorkDone;
	private String valueOFWorkDoneButnotPaid;
	private String mileStones;

	private String expMonth;
	private String expYear;
	private String expMonthDuring;
	private String expMonthUp;
	private String expUptoPrevYear;
	// private String stage;
	private ArrayList mileStone;
	private ArrayList stage;
	private ArrayList mileStoneStagesList;
	private String achievementDate;
	private String mileStoneSno;
	private String progName;
	private String progCode;
	private String aggrigateExpenditureForProg;
	private String majorMileStone;
	private String compInNo;
	private String compInNoAch;
	private String typeOfContractor;
	private String eoatTargetDate;
	private String perCompInWork;
	private String perCompInWorkValue;
	private String perCompValue;
	private String mileStoneProgress;
	private String mileRemarks;
	private String contCode;
	private String budgetInfo;
	private String billVoucherAmount;
	private String billReleaseAmount;

	private String sanctionno;
	private String sanctiondt;
	private String sanctionamount;
	private String subprogName;
	private String noofhabs;

	/*
	 * added by ramesh on 150509
	 */

	private String scPop;
	private String stPop;
	private String plainPop;
	private String totalPop;
	private String scCov;
	private String stCov;
	private String plainCov;
	private String totalCov;

	/*
	 * added by ramesh on 180509
	 */
	private String inQua;
	private String qa;
	private String qp1;
	private String qp2;
	private String qp3;
	private String qp4;
	private String sfncpop;
	private String checks;
	private String main;
	private String vname;
	private String vcode;
	private String habCode;

	private String voucherNo;
	private String voucherDate;
	private String chequeNo;
	private String chequeDate;
	private String voucherAmount;
	private String empCode;
	private String checkMesuaredDate;
	private String empCodeSuper;
	private String superCheckMesuaredDate;
	private String empCodeRecorded;
	private String RecordedDate;
	private String mBookNo;
	private String mBookNum;

	private String billSlNo;
	private String billNo;
	private String billDate;
	private String billDateEE;
	private String grossValueContractor;
	private String grossValueAdmissable;
	private String grossValuePaidTotal;
	private String grossValueOfBill;
	private String grossValuePaid;
	private String paymentAdmissable;
	private String paymentInHand;
	private String paymentMode;
	private String checkMesuaredRemarks;

	// added by sai prasad N on 19022014

	private String cmMBookNo;
	private String cmPageNo;

	private String scmMBookNo;
	private String scmPageNo;

	private String superCheckBySE;

	private String superCheckPgNo;

	private String superCheckSEDate;

	private String billSaved;

	private String passOrderScanCopyAvailable;

	public String getPassOrderScanCopyAvailable() {
		return passOrderScanCopyAvailable;
	}

	public void setPassOrderScanCopyAvailable(String passOrderScanCopyAvailable) {
		this.passOrderScanCopyAvailable = passOrderScanCopyAvailable;
	}

	public String getBillSaved() {
		return billSaved;
	}

	public void setBillSaved(String billSaved) {
		this.billSaved = billSaved;
	}

	public String getSuperCheckBySE() {
		return superCheckBySE;
	}

	public void setSuperCheckBySE(String superCheckBySE) {
		this.superCheckBySE = superCheckBySE;
	}

	public String getSuperCheckPgNo() {
		return superCheckPgNo;
	}

	public void setSuperCheckPgNo(String superCheckPgNo) {
		this.superCheckPgNo = superCheckPgNo;
	}

	public String getSuperCheckSEDate() {
		return superCheckSEDate;
	}

	public void setSuperCheckSEDate(String superCheckSEDate) {
		this.superCheckSEDate = superCheckSEDate;
	}

	private FormFile passOrderScanCopy;

	public String getmBookNo() {
		return mBookNo;
	}

	public FormFile getPassOrderScanCopy() {
		return passOrderScanCopy;
	}

	public void setPassOrderScanCopy(FormFile passOrderScanCopy) {
		this.passOrderScanCopy = passOrderScanCopy;
	}

	public void setmBookNo(String mBookNo) {
		this.mBookNo = mBookNo;
	}

	public String getmBookNum() {
		return mBookNum;
	}

	public void setmBookNum(String mBookNum) {
		this.mBookNum = mBookNum;
	}

	public String getCmMBookNo() {
		return cmMBookNo;
	}

	public void setCmMBookNo(String cmMBookNo) {
		this.cmMBookNo = cmMBookNo;
	}

	public String getCmPageNo() {
		return cmPageNo;
	}

	public void setCmPageNo(String cmPageNo) {
		this.cmPageNo = cmPageNo;
	}

	public String getScmMBookNo() {
		return scmMBookNo;
	}

	public void setScmMBookNo(String scmMBookNo) {
		this.scmMBookNo = scmMBookNo;
	}

	public String getScmPageNo() {
		return scmPageNo;
	}

	public void setScmPageNo(String scmPageNo) {
		this.scmPageNo = scmPageNo;
	}

	// added by sridhar
	private String wrkCanDate;

	public String getWrkCanDate() {
		return wrkCanDate;
	}

	public void setWrkCanDate(String wrkCanDate) {
		this.wrkCanDate = wrkCanDate;
	}

	public void setNoofhabs(String noofhabs) {
		this.noofhabs = noofhabs;
	}

	public String getNoofhabs() {
		return noofhabs;
	}

	public void setSanctionno(String sanctionno) {
		this.sanctionno = sanctionno;
	}

	public String getSanctionno() {
		return sanctionno;
	}

	public void setSanctiondt(String sanctiondt) {
		this.sanctiondt = sanctiondt;
	}

	public String getSanctiondt() {
		return sanctiondt;
	}

	public void setSanctionamount(String sanctionamount) {
		this.sanctionamount = sanctionamount;
	}

	public String getSanctionamount() {
		return sanctionamount;
	}

	public void setSubprogName(String subprogName) {
		this.subprogName = subprogName;
	}

	public String getSubprogName() {
		return subprogName;
	}

	public tenderMemo() {
		mileStoneStagesList = new ArrayList();
	}

	// Acessors
	public void setRevHabName(String revHabName) {
		this.revHabName = revHabName;
	}

	public String getRevHabName() {
		return revHabName;
	}

	public void setWorks(String works) {
		this.works = works;
	}

	public String getWorks() {
		return works;
	}

	public void setCmbWorks(String cmbWorks) {
		this.cmbWorks = cmbWorks;
	}

	public String getCmbWorks() {
		return cmbWorks;
	}

	public void setGroundDate(String groundDate) {
		this.groundDate = groundDate;
	}

	public String getGroundDate() {
		return groundDate;
	}

	public void setOffissuedfrom(String offissuedfrom) {
		this.offissuedfrom = offissuedfrom;
	}

	public String getOffissuedfrom() {
		return offissuedfrom;
	}

	public void setOffissuedto(String offissuedto) {
		this.offissuedto = offissuedto;
	}

	public String getOffissuedto() {
		return offissuedto;
	}

	public void setWorkid(String workid) {
		this.workid = workid;
	}

	public String getWorkid() {
		return workid;
	}

	public void setDateofcomp(String dateofcomp) {
		this.dateofcomp = dateofcomp;
	}

	public String getDateofcomp() {
		return dateofcomp;
	}

	/**
	 * @return Returns the workname.
	 */
	public String getWorkname() {
		return workname;
	}

	/**
	 * @param workname
	 *            The workname to set.
	 */
	public void setWorkname(String workname) {
		this.workname = workname;
	}

	/**
	 * @return Returns the habNames.
	 */
	public String getHabName() {
		return habName;
	}

	/**
	 * @param habNames
	 *            The habNames to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
	}

	/**
	 * @return Returns the selHabNames.
	 */
	public String getSelHabNames() {
		return selHabNames;
	}

	/**
	 * @param selHabNames
	 *            The selHabNames to set.
	 */
	public void setSelHabNames(String selHabNames) {
		this.selHabNames = selHabNames;
	}

	/**
	 * @return Returns the panchCode.
	 */
	public String getPanchCode() {
		return panchCode;
	}

	/**
	 * @param panchCode
	 *            The panchCode to set.
	 */
	public void setPanchCode(String panchCode) {
		this.panchCode = panchCode;
	}

	/**
	 * @return Returns the panchName.
	 */
	public String getPanchName() {
		return panchName;
	}

	/**
	 * @param panchName
	 *            The panchName to set.
	 */
	public void setPanchName(String panchName) {
		this.panchName = panchName;
	}

	/**
	 * @return Returns the subCompCode.
	 */
	/**
	 * @return Returns the panchCode.
	 */
	public String getMandalCode() {
		return mandalCode;
	}

	/**
	 * @param panchCode
	 *            The panchCode to set.
	 */
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
	}

	/**
	 * @return Returns the panchName.
	 */
	public String getMandalName() {
		return mandalName;
	}

	/**
	 * @param panchName
	 *            The panchName to set.
	 */
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}

	/**
	 * @return Returns the subCompCode.
	 */
	public String getSubCompCode() {
		return subCompCode;
	}

	/**
	 * @param subCompCode
	 *            The subCompCode to set.
	 */
	public void setSubCompCode(String subCompCode) {
		this.subCompCode = subCompCode;
	}

	/**
	 * @return Returns the subCompName.
	 */
	public String getSubCompName() {
		return subCompName;
	}

	/**
	 * @param subCompName
	 *            The subCompName to set.
	 */
	public void setSubCompName(String subCompName) {
		this.subCompName = subCompName;
	}

	/**
	 * @return Returns the label.
	 */
	public String getLabel() {
		return label;
	}

	/**
	 * @param label
	 *            The label to set.
	 */
	public void setLabel(String label) {
		this.label = label;
	}

	/**
	 * @return Returns the value.
	 */
	public String getValue() {
		return value;
	}

	/**
	 * @param value
	 *            The value to set.
	 */
	public void setValue(String value) {
		this.value = value;
	}

	/**
	 * @return Returns the mstone.
	 */
	public String getMstone() {
		return mstone;
	}

	/**
	 * @param mstone
	 *            The mstone to set.
	 */
	public void setMstone(String mstone) {
		this.mstone = mstone;
	}

	/**
	 * @return Returns the percentComp.
	 */
	public String getPercentComp() {
		return percentComp;
	}

	/**
	 * @param percentComp
	 *            The percentComp to set.
	 */
	public void setPercentComp(String percentComp) {
		this.percentComp = percentComp;
	}

	/**
	 * @return Returns the stages.
	 */
	public String getStages() {
		return stages;
	}

	/**
	 * @param stages
	 *            The stages to set.
	 */
	public void setStages(String stages) {
		this.stages = stages;
	}

	/**
	 * @return Returns the targetDate.
	 */
	public String getTargetDate() {
		return targetDate;
	}

	/**
	 * @param targetDate
	 *            The targetDate to set.
	 */
	public void setTargetDate(String targetDate) {
		this.targetDate = targetDate;
	}

	/**
	 * @return Returns the mstoneCode.
	 */
	public String getMstoneCode() {
		return mstoneCode;
	}

	/**
	 * @param mstoneCode
	 *            The mstoneCode to set.
	 */
	public void setMstoneCode(String mstoneCode) {
		this.mstoneCode = mstoneCode;
	}

	/**
	 * @return Returns the mstoneName.
	 */
	public String getMstoneName() {
		return mstoneName;
	}

	/**
	 * @param mstoneName
	 *            The mstoneName to set.
	 */
	public void setMstoneName(String mstoneName) {
		this.mstoneName = mstoneName;
	}

	/**
	 * @return Returns the mstoneStageCode.
	 */
	public String getMstoneStageCode() {
		return mstoneStageCode;
	}

	/**
	 * @param mstoneStageCode
	 *            The mstoneStageCode to set.
	 */
	public void setMstoneStageCode(String mstoneStageCode) {
		this.mstoneStageCode = mstoneStageCode;
	}

	/**
	 * @return Returns the mstoneStageName.
	 */
	public String getMstoneStageName() {
		return mstoneStageName;
	}

	/**
	 * @param mstoneStageName
	 *            The mstoneStageName to set.
	 */
	public void setMstoneStageName(String mstoneStageName) {
		this.mstoneStageName = mstoneStageName;
	}

	public String getMileStones() {
		return mileStones;
	}

	/**
	 * @param mileStones
	 *            The mileStones to set.
	 */
	public void setMileStones(String mileStones) {
		this.mileStones = mileStones;
	}

	/**
	 * @return Returns the stage.
	 */
	/*
	 * public String getStage() { return stage; } /**
	 * 
	 * @param stage The stage to set.
	 */
	/*
	 * public void setStage(String stage) { this.stage = stage; }
	 */
	/**
	 * @return Returns the mileStone.
	 */
	public ArrayList getMileStone() {
		return mileStone;
	}

	/**
	 * @param mileStone
	 *            The mileStone to set.
	 */
	public void setMileStone(ArrayList mileStone) {
		this.mileStone = mileStone;
	}

	/**
	 * @return Returns the stage.
	 */
	public ArrayList getStage() {
		return stage;
	}

	/**
	 * @param stage
	 *            The stage to set.
	 */
	public void setStage(ArrayList stage) {
		this.stage = stage;
	}

	/**
	 * @param sno
	 *            The sno to set.
	 */
	public void setSno(String sno) {
		this.sno = sno;
	}

	/**
	 * @return Returns the expMonth.
	 */
	public String getExpMonth() {
		return expMonth;
	}

	/**
	 * @param expMonth
	 *            The expMonth to set.
	 */
	public void setExpMonth(String expMonth) {
		this.expMonth = expMonth;
	}

	/**
	 * @return Returns the expMonthDuring.
	 */
	public String getExpMonthDuring() {
		return expMonthDuring;
	}

	/**
	 * @param expMonthDuring
	 *            The expMonthDuring to set.
	 */
	public void setExpMonthDuring(String expMonthDuring) {
		this.expMonthDuring = expMonthDuring;
	}

	/**
	 * @return Returns the expMonthUp.
	 */
	public String getExpMonthUp() {
		return expMonthUp;
	}

	/**
	 * @param expMonthUp
	 *            The expMonthUp to set.
	 */
	public void setExpMonthUp(String expMonthUp) {
		this.expMonthUp = expMonthUp;
	}

	/**
	 * @return Returns the expYear.
	 */
	public String getExpYear() {
		return expYear;
	}

	/**
	 * @param expYear
	 *            The expYear to set.
	 */
	public void setExpYear(String expYear) {
		this.expYear = expYear;
	}

	/**
	 * @return Returns the expUptoPrevYear.
	 */
	public String getExpUptoPrevYear() {
		return expUptoPrevYear;
	}

	/**
	 * @param expUptoPrevYear
	 *            The expUptoPrevYear to set.
	 */
	public void setExpUptoPrevYear(String expUptoPrevYear) {
		this.expUptoPrevYear = expUptoPrevYear;
	}

	public ArrayList getMileStoneStagesList() {
		return mileStoneStagesList;
	}

	public void setMileStoneStagesList(ArrayList mileStoneStagesList) {
		this.mileStoneStagesList = mileStoneStagesList;
	}

	/**
	 * @return Returns the achievementDate.
	 */
	public String getAchievementDate() {
		return achievementDate;
	}

	/**
	 * @param achievementDate
	 *            The achievementDate to set.
	 */
	public void setAchievementDate(String achievementDate) {
		this.achievementDate = achievementDate;
	}

	/**
	 * @return Returns the sno.
	 */
	public String getSno() {
		return sno;
	}

	/**
	 * @return Returns the valueOFWorkDone.
	 */
	public String getValueOFWorkDone() {
		return valueOFWorkDone;
	}

	/**
	 * @param valueOFWorkDone
	 *            The valueOFWorkDone to set.
	 */
	public void setValueOFWorkDone(String valueOFWorkDone) {
		this.valueOFWorkDone = valueOFWorkDone;
	}

	/**
	 * @return Returns the progCode.
	 */
	public String getProgCode() {
		return progCode;
	}

	/**
	 * @param progCode
	 *            The progCode to set.
	 */
	public void setProgCode(String progCode) {
		this.progCode = progCode;
	}

	/**
	 * @return Returns the progName.
	 */
	public String getProgName() {
		return progName;
	}

	/**
	 * @param progName
	 *            The progName to set.
	 */
	public void setProgName(String progName) {
		this.progName = progName;
	}

	/**
	 * @return Returns the aggrigateExpenditureForProg.
	 */
	public String getAggrigateExpenditureForProg() {
		return aggrigateExpenditureForProg;
	}

	/**
	 * @param aggrigateExpenditureForProg
	 *            The aggrigateExpenditureForProg to set.
	 */
	public void setAggrigateExpenditureForProg(
			String aggrigateExpenditureForProg) {
		this.aggrigateExpenditureForProg = aggrigateExpenditureForProg;
	}

	public String getChecks() {
		return checks;
	}

	public void setChecks(String checks) {
		this.checks = checks;
	}

	public String getInQua() {
		return inQua;
	}

	public void setInQua(String inQua) {
		this.inQua = inQua;
	}

	public String getMain() {
		return main;
	}

	public void setMain(String main) {
		this.main = main;
	}

	public String getPlainCov() {
		return plainCov;
	}

	public void setPlainCov(String plainCov) {
		this.plainCov = plainCov;
	}

	public String getPlainPop() {
		return plainPop;
	}

	public void setPlainPop(String plainPop) {
		this.plainPop = plainPop;
	}

	public String getQa() {
		return qa;
	}

	public void setQa(String qa) {
		this.qa = qa;
	}

	public String getQp1() {
		return qp1;
	}

	public void setQp1(String qp1) {
		this.qp1 = qp1;
	}

	public String getQp2() {
		return qp2;
	}

	public void setQp2(String qp2) {
		this.qp2 = qp2;
	}

	public String getQp3() {
		return qp3;
	}

	public void setQp3(String qp3) {
		this.qp3 = qp3;
	}

	public String getQp4() {
		return qp4;
	}

	public void setQp4(String qp4) {
		this.qp4 = qp4;
	}

	public String getScCov() {
		return scCov;
	}

	public void setScCov(String scCov) {
		this.scCov = scCov;
	}

	public String getScPop() {
		return scPop;
	}

	public void setScPop(String scPop) {
		this.scPop = scPop;
	}

	public String getSfncpop() {
		return sfncpop;
	}

	public void setSfncpop(String sfncpop) {
		this.sfncpop = sfncpop;
	}

	public String getStCov() {
		return stCov;
	}

	public void setStCov(String stCov) {
		this.stCov = stCov;
	}

	public String getStPop() {
		return stPop;
	}

	public void setStPop(String stPop) {
		this.stPop = stPop;
	}

	public String getTotalCov() {
		return totalCov;
	}

	public void setTotalCov(String totalCov) {
		this.totalCov = totalCov;
	}

	public String getTotalPop() {
		return totalPop;
	}

	public void setTotalPop(String totalPop) {
		this.totalPop = totalPop;
	}

	public String getVcode() {
		return vcode;
	}

	public void setVcode(String vcode) {
		this.vcode = vcode;
	}

	public String getVname() {
		return vname;
	}

	public void setVname(String vname) {
		this.vname = vname;
	}

	public String getHabCode() {
		return habCode;
	}

	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}

	/**
	 * @return Returns the valueOFWorkDoneButnotPaid.
	 */
	public String getValueOFWorkDoneButnotPaid() {
		return valueOFWorkDoneButnotPaid;
	}

	/**
	 * @param valueOFWorkDoneButnotPaid
	 *            The valueOFWorkDoneButnotPaid to set.
	 */
	public void setValueOFWorkDoneButnotPaid(String valueOFWorkDoneButnotPaid) {
		this.valueOFWorkDoneButnotPaid = valueOFWorkDoneButnotPaid;
	}

	public String getVoucherAmount() {
		return voucherAmount;
	}

	public void setVoucherAmount(String voucherAmount) {
		this.voucherAmount = voucherAmount;
	}

	public String getChequeDate() {
		return chequeDate;
	}

	public void setChequeDate(String chequeDate) {
		this.chequeDate = chequeDate;
	}

	public String getChequeNo() {
		return chequeNo;
	}

	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}

	public String getVoucherDate() {
		return voucherDate;
	}

	public void setVoucherDate(String voucherDate) {
		this.voucherDate = voucherDate;
	}

	public String getVoucherNo() {
		return voucherNo;
	}

	public void setVoucherNo(String voucherNo) {
		this.voucherNo = voucherNo;
	}

	public String getCheckMesuaredDate() {
		return checkMesuaredDate;
	}

	public void setCheckMesuaredDate(String checkMesuaredDate) {
		this.checkMesuaredDate = checkMesuaredDate;
	}

	public String getCheckMesuaredRemarks() {
		return checkMesuaredRemarks;
	}

	public void setCheckMesuaredRemarks(String checkMesuaredRemarks) {
		this.checkMesuaredRemarks = checkMesuaredRemarks;
	}

	public String getEmpCode() {
		return empCode;
	}

	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	public String getEmpCodeSuper() {
		return empCodeSuper;
	}

	public void setEmpCodeSuper(String empCodeSuper) {
		this.empCodeSuper = empCodeSuper;
	}

	public String getSuperCheckMesuaredDate() {
		return superCheckMesuaredDate;
	}

	public void setSuperCheckMesuaredDate(String superCheckMesuaredDate) {
		this.superCheckMesuaredDate = superCheckMesuaredDate;
	}

	public String getEmpCodeRecorded() {
		return empCodeRecorded;
	}

	public void setEmpCodeRecorded(String empCodeRecorded) {
		this.empCodeRecorded = empCodeRecorded;
	}

	public String getRecordedDate() {
		return RecordedDate;
	}

	public void setRecordedDate(String recordedDate) {
		RecordedDate = recordedDate;
	}

	public String getMBookNo() {
		return mBookNo;
	}

	public void setMBookNo(String bookNo) {
		mBookNo = bookNo;
	}

	public String getMBookNum() {
		return mBookNum;
	}

	public void setMBookNum(String bookNum) {
		mBookNum = bookNum;
	}

	public String getCompInNo() {
		return compInNo;
	}

	public void setCompInNo(String compInNo) {
		this.compInNo = compInNo;
	}

	public String getMajorMileStone() {
		return majorMileStone;
	}

	public void setMajorMileStone(String majorMileStone) {
		this.majorMileStone = majorMileStone;
	}

	public String getPerCompInWork() {
		return perCompInWork;
	}

	public void setPerCompInWork(String perCompInWork) {
		this.perCompInWork = perCompInWork;
	}

	public String getMileStoneSno() {
		return mileStoneSno;
	}

	public void setMileStoneSno(String mileStoneSno) {
		this.mileStoneSno = mileStoneSno;
	}

	public String getBudgetInfo() {
		return budgetInfo;
	}

	public void setBudgetInfo(String budgetInfo) {
		this.budgetInfo = budgetInfo;
	}

	public String getContCode() {
		return contCode;
	}

	public void setContCode(String contCode) {
		this.contCode = contCode;
	}

	public String getBillDate() {
		return billDate;
	}

	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	public String getBillNo() {
		return billNo;
	}

	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	public String getBillSlNo() {
		return billSlNo;
	}

	public void setBillSlNo(String billSlNo) {
		this.billSlNo = billSlNo;
	}

	public String getGrossValueAdmissable() {
		return grossValueAdmissable;
	}

	public void setGrossValueAdmissable(String grossValueAdmissable) {
		this.grossValueAdmissable = grossValueAdmissable;
	}

	public String getGrossValueContractor() {
		return grossValueContractor;
	}

	public void setGrossValueContractor(String grossValueContractor) {
		this.grossValueContractor = grossValueContractor;
	}

	public String getGrossValueOfBill() {
		return grossValueOfBill;
	}

	public void setGrossValueOfBill(String grossValueOfBill) {
		this.grossValueOfBill = grossValueOfBill;
	}

	public String getGrossValuePaid() {
		return grossValuePaid;
	}

	public void setGrossValuePaid(String grossValuePaid) {
		this.grossValuePaid = grossValuePaid;
	}

	public String getGrossValuePaidTotal() {
		return grossValuePaidTotal;
	}

	public void setGrossValuePaidTotal(String grossValuePaidTotal) {
		this.grossValuePaidTotal = grossValuePaidTotal;
	}

	public String getPaymentAdmissable() {
		return paymentAdmissable;
	}

	public void setPaymentAdmissable(String paymentAdmissable) {
		this.paymentAdmissable = paymentAdmissable;
	}

	public String getBillVoucherAmount() {
		return billVoucherAmount;
	}

	public void setBillVoucherAmount(String billVoucherAmount) {
		this.billVoucherAmount = billVoucherAmount;
	}

	public String getPaymentInHand() {
		return paymentInHand;
	}

	public void setPaymentInHand(String paymentInHand) {
		this.paymentInHand = paymentInHand;
	}

	public String getPerCompValue() {
		return perCompValue;
	}

	public void setPerCompValue(String perCompValue) {
		this.perCompValue = perCompValue;
	}

	public String getMileRemarks() {
		return mileRemarks;
	}

	public void setMileRemarks(String mileRemarks) {
		this.mileRemarks = mileRemarks;
	}

	public String getMileStoneProgress() {
		return mileStoneProgress;
	}

	public void setMileStoneProgress(String mileStoneProgress) {
		this.mileStoneProgress = mileStoneProgress;
	}

	public String getPerCompInWorkValue() {
		return perCompInWorkValue;
	}

	public void setPerCompInWorkValue(String perCompInWorkValue) {
		this.perCompInWorkValue = perCompInWorkValue;
	}

	public String getCompInNoAch() {
		return compInNoAch;
	}

	public void setCompInNoAch(String compInNoAch) {
		this.compInNoAch = compInNoAch;
	}

	public String getEoatTargetDate() {
		return eoatTargetDate;
	}

	public void setEoatTargetDate(String eoatTargetDate) {
		this.eoatTargetDate = eoatTargetDate;
	}

	public String getTypeOfContractor() {
		return typeOfContractor;
	}

	public void setTypeOfContractor(String typeOfContractor) {
		this.typeOfContractor = typeOfContractor;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public String getBillDateEE() {
		return billDateEE;
	}

	public void setBillDateEE(String billDateEE) {
		this.billDateEE = billDateEE;
	}

	public String getBillReleaseAmount() {
		return billReleaseAmount;
	}

	public void setBillReleaseAmount(String billReleaseAmount) {
		this.billReleaseAmount = billReleaseAmount;
	}

	public void setPaoAdmissable(String paoAdmissable) {
		this.paoAdmissable = paoAdmissable;
	}

	public String getPaoAdmissable() {
		return paoAdmissable;
	}

	

	public void setApprovedOn(String approvedOn) {
		this.approvedOn = approvedOn;
	}

	public String getApprovedOn() {
		return approvedOn;
	}

	public void setIsApproved(String isApproved) {
		this.isApproved = isApproved;
	}

	public String getIsApproved() {
		return isApproved;
	}

}