package nic.watersoft.masters;

import java.io.Serializable;
import java.util.ArrayList;

public class Rws_Direct_Bills_Bean implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4706623471417385864L;
	private String remove;
	private String sno;
	private String groundDate;
	private String workname;
	private String works;
	private String habName;
	private String panchCode;
	private String panchName;
	private String mandalName;
	private String mandalCode;
	private String subCompCode;
	private String subCompName;
	private String value;
	private String label;
	private String mstone;
	private String targetDate;
	private String mstoneCode;
	private String mstoneName;
	private ArrayList mileStone;
	private ArrayList stage;
	private ArrayList mileStoneStagesList;
	private String achievementDate;
	private String mileStoneSno;
	private String progName;
	private String progCode;
    private String mileRemarks;
    private String contCode;
    private String budgetInfo;
    private String billVoucherAmount;
	private String subprogName;
	private String noofhabs;
	private String checks;
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
	private String wrkCanDate;
	private String workid;
	private String mstoneStageName;
	private String percentComp;
	private String mstoneStageCode;
	private String perCompInWorkValue;
	private String majorMileStone;
	private String compInNo;
	private String perCompInWork;
	private String perCompValue;
	private String mileStoneProgress;
	private String typeOfContractor;
	private String eoatTargetDate;
	private String compInNoAch;
	
	public String getWrkCanDate() {
		return wrkCanDate;
	}
	public void setWrkCanDate(String wrkCanDate) {
		this.wrkCanDate = wrkCanDate;
	}
	public void setNoofhabs(String noofhabs)
	{
		this.noofhabs = noofhabs;
	}
	public String getNoofhabs()
	{
		return noofhabs;
	}
	public void setSubprogName(String subprogName)
	{
		this.subprogName = subprogName;
	}
	public String getSubprogName()
	{
		return subprogName;
	}
	
	public Rws_Direct_Bills_Bean()
	{
		mileStoneStagesList=new ArrayList();
	}
	public void setWorks(String works)
	{
		this.works = works;
	}
	public String getWorks()
	{
		return works;
	}
	public void setGroundDate(String groundDate)
	{
		this.groundDate = groundDate;
	}
	public String getGroundDate()
	{
		return groundDate;
	}
	 
	public String getRemove() {
		return remove;
	}
	public void setRemove(String remove) {
		this.remove = remove;
	}
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	public String getWorkname() {
		return workname;
	}
	public void setWorkname(String workname) {
		this.workname = workname;
	}
	public String getHabName() {
		return habName;
	}
	public void setHabName(String habName) {
		this.habName = habName;
	}
	public String getPanchCode() {
		return panchCode;
	}
	public void setPanchCode(String panchCode) {
		this.panchCode = panchCode;
	}
	public String getPanchName() {
		return panchName;
	}
	public void setPanchName(String panchName) {
		this.panchName = panchName;
	}
	public String getMandalName() {
		return mandalName;
	}
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	public String getMandalCode() {
		return mandalCode;
	}
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
	}
	public String getSubCompCode() {
		return subCompCode;
	}
	public void setSubCompCode(String subCompCode) {
		this.subCompCode = subCompCode;
	}
	public String getSubCompName() {
		return subCompName;
	}
	public void setSubCompName(String subCompName) {
		this.subCompName = subCompName;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getMstone() {
		return mstone;
	}
	public void setMstone(String mstone) {
		this.mstone = mstone;
	}
	public String getTargetDate() {
		return targetDate;
	}
	public void setTargetDate(String targetDate) {
		this.targetDate = targetDate;
	}
	public String getMstoneCode() {
		return mstoneCode;
	}
	public void setMstoneCode(String mstoneCode) {
		this.mstoneCode = mstoneCode;
	}
	public String getMstoneName() {
		return mstoneName;
	}
	public void setMstoneName(String mstoneName) {
		this.mstoneName = mstoneName;
	}
	public ArrayList getMileStone() {
		return mileStone;
	}
	public void setMileStone(ArrayList mileStone) {
		this.mileStone = mileStone;
	}
	public ArrayList getStage() {
		return stage;
	}
	public void setStage(ArrayList stage) {
		this.stage = stage;
	}
	public ArrayList getMileStoneStagesList() {
		return mileStoneStagesList;
	}
	public void setMileStoneStagesList(ArrayList mileStoneStagesList) {
		this.mileStoneStagesList = mileStoneStagesList;
	}
	public String getAchievementDate() {
		return achievementDate;
	}
	public void setAchievementDate(String achievementDate) {
		this.achievementDate = achievementDate;
	}
	public String getProgName() {
		return progName;
	}
	public void setProgName(String progName) {
		this.progName = progName;
	}
	public String getProgCode() {
		return progCode;
	}
	public void setProgCode(String progCode) {
		this.progCode = progCode;
	}
	public String getmBookNo() {
		return mBookNo;
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	public String getChecks() {
		return checks;
	}
	public void setChecks(String checks) {
		this.checks = checks;
	}

	
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
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
	public String getMileRemarks() {
		return mileRemarks;
	}
	public void setMileRemarks(String mileRemarks) {
		this.mileRemarks = mileRemarks;
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
	
	public String getMstoneStageName() {
		return mstoneStageName;
	}
	public void setMstoneStageName(String mstoneStageName) {
		this.mstoneStageName = mstoneStageName;
	}
	public String getPercentComp() {
		return percentComp;
	}
	public void setPercentComp(String percentComp) {
		this.percentComp = percentComp;
	}
	public String getMstoneStageCode() {
		return mstoneStageCode;
	}
	public void setMstoneStageCode(String mstoneStageCode) {
		this.mstoneStageCode = mstoneStageCode;
	}
	public String getWorkid() {
		return workid;
	}
	public void setWorkid(String workid) {
		this.workid = workid;
	}
	public String getPerCompInWorkValue() {
		return perCompInWorkValue;
	}
	public void setPerCompInWorkValue(String perCompInWorkValue) {
		this.perCompInWorkValue = perCompInWorkValue;
	}
	public String getMajorMileStone() {
		return majorMileStone;
	}
	public void setMajorMileStone(String majorMileStone) {
		this.majorMileStone = majorMileStone;
	}
	public String getCompInNo() {
		return compInNo;
	}
	public void setCompInNo(String compInNo) {
		this.compInNo = compInNo;
	}
	public String getPerCompInWork() {
		return perCompInWork;
	}
	public void setPerCompInWork(String perCompInWork) {
		this.perCompInWork = perCompInWork;
	}
	public String getPerCompValue() {
		return perCompValue;
	}
	public void setPerCompValue(String perCompValue) {
		this.perCompValue = perCompValue;
	}
	public String getMileStoneProgress() {
		return mileStoneProgress;
	}
	public void setMileStoneProgress(String mileStoneProgress) {
		this.mileStoneProgress = mileStoneProgress;
	}
	public String getTypeOfContractor() {
		return typeOfContractor;
	}
	public void setTypeOfContractor(String typeOfContractor) {
		this.typeOfContractor = typeOfContractor;
	}
	public String getEoatTargetDate() {
		return eoatTargetDate;
	}
	public void setEoatTargetDate(String eoatTargetDate) {
		this.eoatTargetDate = eoatTargetDate;
	}
	public String getCompInNoAch() {
		return compInNoAch;
	}
	public void setCompInNoAch(String compInNoAch) {
		this.compInNoAch = compInNoAch;
	}
	
	
}
