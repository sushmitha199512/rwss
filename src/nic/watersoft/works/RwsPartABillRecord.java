/*
 * Created on 3-12-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.io.Serializable;

import org.apache.struts.upload.FormFile;

/**
 * @author RWSS_DPT1(Sai Prasad N)
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class RwsPartABillRecord implements Serializable {

	private String billSlNo;

	private String billNo;

	private String billDate;

	private String itemCode;

	private String billAmount;

	private String billAmountAsPerPayOrder;

	private String grossValueUpToThisBill;

	private String grossValueAsPerPayOrderUpToThisBill;

	private String amountReleased;

	private String amountPaid;

	private String amountToBePaid;

	private String billEEForwardDate;

	//vouchers related
	private String progCode;

	private String mBookNo;

	private String mBookNum;

	private String empCodeRecorded;

	private String RecordedDate;

	private String voucherNo;

	private String voucherDate;

	private String chequeNo;

	private String chequeDate;

	private String voucherAmount;

	private String empCode;

	private String checkMesuaredDate;

	private String superCheckMesuaredDate;

	private String checkMesuaredRemarks;

	private String empCodeSuper;
	
	private String paymentAdmissable;
	
	private String billVoucherAmount;
	private String contCode;
	
	private String budgetInfo;
	
	private String sno;
	private String paymentMode;
	
	// added on 10.03.2014
	
	private String cmMBookNo;
	private String cmPageNo;

	private String scmMBookNo;
	private String scmPageNo;
	
    private String superCheckBySE;
    
    private String superCheckPgNo;
    
    private String superCheckSEDate;
    
    private String billSaved;
    
    private String passOrderScanCopyAvailable;
	
    private FormFile passOrderScanCopy;
    
    
    
    
	
	

	public FormFile getPassOrderScanCopy() {
		return passOrderScanCopy;
	}
	public void setPassOrderScanCopy(FormFile passOrderScanCopy) {
		this.passOrderScanCopy = passOrderScanCopy;
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
	public String getBillSaved() {
		return billSaved;
	}
	public void setBillSaved(String billSaved) {
		this.billSaved = billSaved;
	}
	public String getPassOrderScanCopyAvailable() {
		return passOrderScanCopyAvailable;
	}
	public void setPassOrderScanCopyAvailable(String passOrderScanCopyAvailable) {
		this.passOrderScanCopyAvailable = passOrderScanCopyAvailable;
	}
	/**
	 * @return Returns the budgetInfo.
	 */
	public String getBudgetInfo() {
		return budgetInfo;
	}
	/**
	 * @param budgetInfo The budgetInfo to set.
	 */
	public void setBudgetInfo(String budgetInfo) {
		this.budgetInfo = budgetInfo;
	}
	/**
	 * @return Returns the paymentMode.
	 */
	public String getPaymentMode() {
		return paymentMode;
	}
	/**
	 * @param paymentMode The paymentMode to set.
	 */
	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	/**
	 * @return Returns the sno.
	 */
	public String getSno() {
		return sno;
	}
	/**
	 * @param sno The sno to set.
	 */
	public void setSno(String sno) {
		this.sno = sno;
	}
	/**
	 * @return Returns the contCode.
	 */
	public String getContCode() {
		return contCode;
	}
	/**
	 * @param contCode The contCode to set.
	 */
	public void setContCode(String contCode) {
		this.contCode = contCode;
	}
	/**
	 * @return Returns the billVoucherAmount.
	 */
	public String getBillVoucherAmount() {
		return billVoucherAmount;
	}
	/**
	 * @param billVoucherAmount The billVoucherAmount to set.
	 */
	public void setBillVoucherAmount(String billVoucherAmount) {
		this.billVoucherAmount = billVoucherAmount;
	}
	/**
	 * @return Returns the paymentAdmissable.
	 */
	public String getPaymentAdmissable() {
		return paymentAdmissable;
	}
	/**
	 * @param paymentAdmissable The paymentAdmissable to set.
	 */
	public void setPaymentAdmissable(String paymentAdmissable) {
		this.paymentAdmissable = paymentAdmissable;
	}
	/**
	 * @return Returns the empCodeSuper.
	 */
	public String getEmpCodeSuper() {
		return empCodeSuper;
	}
	/**
	 * @param empCodeSuper The empCodeSuper to set.
	 */
	public void setEmpCodeSuper(String empCodeSuper) {
		this.empCodeSuper = empCodeSuper;
	}
	/**
	 * @return Returns the billEEForwardDate.
	 */
	public String getBillEEForwardDate() {
		return billEEForwardDate;
	}

	/**
	 * @param billEEForwardDate
	 *            The billEEForwardDate to set.
	 */
	public void setBillEEForwardDate(String billEEForwardDate) {
		this.billEEForwardDate = billEEForwardDate;
	}

	/**
	 * @return Returns the amountPaid.
	 */
	public String getAmountPaid() {
		return amountPaid;
	}

	/**
	 * @param amountPaid
	 *            The amountPaid to set.
	 */
	public void setAmountPaid(String amountPaid) {
		this.amountPaid = amountPaid;
	}

	/**
	 * @return Returns the amountReleased.
	 */
	public String getAmountReleased() {
		return amountReleased;
	}

	/**
	 * @param amountReleased
	 *            The amountReleased to set.
	 */
	public void setAmountReleased(String amountReleased) {
		this.amountReleased = amountReleased;
	}

	/**
	 * @return Returns the amountToBePaid.
	 */
	public String getAmountToBePaid() {
		return amountToBePaid;
	}

	/**
	 * @param amountToBePaid
	 *            The amountToBePaid to set.
	 */
	public void setAmountToBePaid(String amountToBePaid) {
		this.amountToBePaid = amountToBePaid;
	}

	/**
	 * @return Returns the billAmount.
	 */
	public String getBillAmount() {
		return billAmount;
	}

	/**
	 * @param billAmount
	 *            The billAmount to set.
	 */
	public void setBillAmount(String billAmount) {
		this.billAmount = billAmount;
	}

	/**
	 * @return Returns the billAmountAsPerPayOrder.
	 */
	public String getBillAmountAsPerPayOrder() {
		return billAmountAsPerPayOrder;
	}

	/**
	 * @param billAmountAsPerPayOrder
	 *            The billAmountAsPerPayOrder to set.
	 */
	public void setBillAmountAsPerPayOrder(String billAmountAsPerPayOrder) {
		this.billAmountAsPerPayOrder = billAmountAsPerPayOrder;
	}

	/**
	 * @return Returns the billDate.
	 */
	public String getBillDate() {
		return billDate;
	}

	/**
	 * @param billDate
	 *            The billDate to set.
	 */
	public void setBillDate(String billDate) {
		this.billDate = billDate;
	}

	/**
	 * @return Returns the billNo.
	 */
	public String getBillNo() {
		return billNo;
	}

	/**
	 * @param billNo
	 *            The billNo to set.
	 */
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}

	/**
	 * @return Returns the billSlNo.
	 */
	public String getBillSlNo() {
		return billSlNo;
	}

	/**
	 * @param billSlNo
	 *            The billSlNo to set.
	 */
	public void setBillSlNo(String billSlNo) {
		this.billSlNo = billSlNo;
	}

	/**
	 * @return Returns the grossValueAsPerPayOrderUpToThisBill.
	 */
	public String getGrossValueAsPerPayOrderUpToThisBill() {
		return grossValueAsPerPayOrderUpToThisBill;
	}

	/**
	 * @param grossValueAsPerPayOrderUpToThisBill
	 *            The grossValueAsPerPayOrderUpToThisBill to set.
	 */
	public void setGrossValueAsPerPayOrderUpToThisBill(
			String grossValueAsPerPayOrderUpToThisBill) {
		this.grossValueAsPerPayOrderUpToThisBill = grossValueAsPerPayOrderUpToThisBill;
	}

	/**
	 * @return Returns the grossValueUpToThisBill.
	 */
	public String getGrossValueUpToThisBill() {
		return grossValueUpToThisBill;
	}

	/**
	 * @param grossValueUpToThisBill
	 *            The grossValueUpToThisBill to set.
	 */
	public void setGrossValueUpToThisBill(String grossValueUpToThisBill) {
		this.grossValueUpToThisBill = grossValueUpToThisBill;
	}

	/**
	 * @return Returns the itemCode.
	 */
	public String getItemCode() {
		return itemCode;
	}

	/**
	 * @param itemCode
	 *            The itemCode to set.
	 */
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	/**
	 * @return Returns the checkMesuaredDate.
	 */
	public String getCheckMesuaredDate() {
		return checkMesuaredDate;
	}

	/**
	 * @param checkMesuaredDate
	 *            The checkMesuaredDate to set.
	 */
	public void setCheckMesuaredDate(String checkMesuaredDate) {
		this.checkMesuaredDate = checkMesuaredDate;
	}

	/**
	 * @return Returns the checkMesuaredRemarks.
	 */
	public String getCheckMesuaredRemarks() {
		return checkMesuaredRemarks;
	}

	/**
	 * @param checkMesuaredRemarks
	 *            The checkMesuaredRemarks to set.
	 */
	public void setCheckMesuaredRemarks(String checkMesuaredRemarks) {
		this.checkMesuaredRemarks = checkMesuaredRemarks;
	}

	/**
	 * @return Returns the chequeDate.
	 */
	public String getChequeDate() {
		return chequeDate;
	}

	/**
	 * @param chequeDate
	 *            The chequeDate to set.
	 */
	public void setChequeDate(String chequeDate) {
		this.chequeDate = chequeDate;
	}

	/**
	 * @return Returns the chequeNo.
	 */
	public String getChequeNo() {
		return chequeNo;
	}

	/**
	 * @param chequeNo
	 *            The chequeNo to set.
	 */
	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}

	/**
	 * @return Returns the empCode.
	 */
	public String getEmpCode() {
		return empCode;
	}

	/**
	 * @param empCode
	 *            The empCode to set.
	 */
	public void setEmpCode(String empCode) {
		this.empCode = empCode;
	}

	/**
	 * @return Returns the empCodeRecorded.
	 */
	public String getEmpCodeRecorded() {
		return empCodeRecorded;
	}

	/**
	 * @param empCodeRecorded
	 *            The empCodeRecorded to set.
	 */
	public void setEmpCodeRecorded(String empCodeRecorded) {
		this.empCodeRecorded = empCodeRecorded;
	}

	/**
	 * @return Returns the mBookNo.
	 */
	public String getMBookNo() {
		return mBookNo;
	}

	/**
	 * @param bookNo
	 *            The mBookNo to set.
	 */
	public void setMBookNo(String bookNo) {
		mBookNo = bookNo;
	}

	/**
	 * @return Returns the mBookNum.
	 */
	public String getMBookNum() {
		return mBookNum;
	}

	/**
	 * @param bookNum
	 *            The mBookNum to set.
	 */
	public void setMBookNum(String bookNum) {
		mBookNum = bookNum;
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
	 * @return Returns the recordedDate.
	 */
	public String getRecordedDate() {
		return RecordedDate;
	}

	/**
	 * @param recordedDate
	 *            The recordedDate to set.
	 */
	public void setRecordedDate(String recordedDate) {
		RecordedDate = recordedDate;
	}

	/**
	 * @return Returns the superCheckMesuaredDate.
	 */
	public String getSuperCheckMesuaredDate() {
		return superCheckMesuaredDate;
	}

	/**
	 * @param superCheckMesuaredDate
	 *            The superCheckMesuaredDate to set.
	 */
	public void setSuperCheckMesuaredDate(String superCheckMesuaredDate) {
		this.superCheckMesuaredDate = superCheckMesuaredDate;
	}

	/**
	 * @return Returns the voucherAmount.
	 */
	public String getVoucherAmount() {
		return voucherAmount;
	}

	/**
	 * @param voucherAmount
	 *            The voucherAmount to set.
	 */
	public void setVoucherAmount(String voucherAmount) {
		this.voucherAmount = voucherAmount;
	}

	/**
	 * @return Returns the voucherDate.
	 */
	public String getVoucherDate() {
		return voucherDate;
	}

	/**
	 * @param voucherDate
	 *            The voucherDate to set.
	 */
	public void setVoucherDate(String voucherDate) {
		this.voucherDate = voucherDate;
	}

	/**
	 * @return Returns the voucherNo.
	 */
	public String getVoucherNo() {
		return voucherNo;
	}

	/**
	 * @param voucherNo
	 *            The voucherNo to set.
	 */
	public void setVoucherNo(String voucherNo) {
		this.voucherNo = voucherNo;
	}
}