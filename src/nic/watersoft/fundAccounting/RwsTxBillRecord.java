package nic.watersoft.fundAccounting;

import java.io.Serializable;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsTxBillRecord implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String txId;
	private String workId;
	private String workName;
	private String officeCode;
	private String billAmount;
	private String billSlNo;
	private String bankSendDate;

	public String getTxId() {
		return txId;
	}

	public void setTxId(String txId) {
		this.txId = txId;
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

	public String getBillAmount() {
		return billAmount;
	}

	public void setBillAmount(String billAmount) {
		this.billAmount = billAmount;
	}

	public String getBillSlNo() {
		return billSlNo;
	}

	public void setBillSlNo(String billSlNo) {
		this.billSlNo = billSlNo;
	}

	public String getBankSendDate() {
		return bankSendDate;
	}

	public void setBankSendDate(String bankSendDate) {
		this.bankSendDate = bankSendDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}

	public String getOfficeCode() {
		return officeCode;
	}

}
