package nic.watersoft.fundAccounting;

import java.io.Serializable;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsVoucher implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String voucherDate;

	private String checks;

	private String circle;
	private String division;
	private String workId;
	private String workName;
	private String paoInAdmissible;
	private String voucherAmt;
	private String checkMeasuredBy;

	private String checkMeasuredDate;

	private String superCheckMeasuredBy;

	private String superCheckMeasuredDate;

	private String checkNo;

	private String checkDT;

	private String eeFwdDate;

	private String billAmountContractor;
	private String billAmountAdmissible;

	private String billNo;
	private String billSlNo;

	public String getBillAmountContractor() {
		return billAmountContractor;
	}

	public void setBillAmountContractor(String billAmountContractor) {
		this.billAmountContractor = billAmountContractor;
	}

	public String getBillAmountAdmissible() {
		return billAmountAdmissible;
	}

	public void setBillAmountAdmissible(String billAmountAdmissible) {
		this.billAmountAdmissible = billAmountAdmissible;
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

	public String getCheckMeasuredBy() {
		return checkMeasuredBy;
	}

	public void setCheckMeasuredBy(String checkMeasuredBy) {
		this.checkMeasuredBy = checkMeasuredBy;
	}

	public String getCheckMeasuredDate() {
		return checkMeasuredDate;
	}

	public void setCheckMeasuredDate(String checkMeasuredDate) {
		this.checkMeasuredDate = checkMeasuredDate;
	}

	public String getSuperCheckMeasuredBy() {
		return superCheckMeasuredBy;
	}

	public void setSuperCheckMeasuredBy(String superCheckMeasuredBy) {
		this.superCheckMeasuredBy = superCheckMeasuredBy;
	}

	public String getSuperCheckMeasuredDate() {
		return superCheckMeasuredDate;
	}

	public void setSuperCheckMeasuredDate(String superCheckMeasuredDate) {
		this.superCheckMeasuredDate = superCheckMeasuredDate;
	}

	public String getCheckNo() {
		return checkNo;
	}

	public void setCheckNo(String checkNo) {
		this.checkNo = checkNo;
	}

	public String getCheckDT() {
		return checkDT;
	}

	public void setCheckDT(String checkDT) {
		this.checkDT = checkDT;
	}

	public String getEeFwdDate() {
		return eeFwdDate;
	}

	public void setEeFwdDate(String eeFwdDate) {
		this.eeFwdDate = eeFwdDate;
	}

	public String getVoucherDate() {
		return voucherDate;
	}

	public void setVoucherDate(String voucherDate) {
		this.voucherDate = voucherDate;
	}

	public String getCircle() {
		return circle;
	}

	public void setCircle(String circle) {
		this.circle = circle;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getWorkId() {
		return workId;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public String getPaoInAdmissible() {
		return paoInAdmissible;
	}

	public void setPaoInAdmissible(String paoInAdmissible) {
		this.paoInAdmissible = paoInAdmissible;
	}

	public String getVoucherAmt() {
		return voucherAmt;
	}

	public void setVoucherAmt(String voucherAmt) {
		this.voucherAmt = voucherAmt;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setWorkName(String workName) {
		this.workName = workName;
	}

	public String getWorkName() {
		return workName;
	}

	public void setChecks(String checks) {
		this.checks = checks;
	}

	public String getChecks() {
		return checks;
	}

}
