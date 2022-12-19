/*
 * Created on 30-05-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.io.Serializable;

/**
 * @author RWSS_DPT1(Sai Prasad N)
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsContractorAmtRecord implements Serializable {

	private String txType;
	private String ftrDate;
	private String ftrNo;
	private String debitAccNo;
	private String debitIfscCode;
	private String contractorMobile;
	private String transferAmount;
	private String contractorName;
	private String contractorCode;
	private String contractorIFSCCode;

	private String contractorACCNO;

	private String contractorAddress;
	private String contractorBankName;
	private String contractorBranchName;
	private String txStatus;
	private String bankTransactionDate;
	private String bankRefNo;
	private String rejectionLevel;
	private String remarks;
	private String conractorEmail;
	private String description;

	private String narration;

	private String workId;

	private String officeCode;
	private String circle;
	private String division;

	private int fileNumber;

	public String getWorkId() {
		return workId;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public int getFileNumber() {
		return fileNumber;
	}

	public void setFileNumber(int fileNumber) {
		this.fileNumber = fileNumber;
	}

	public String getTxType() {
		return txType;
	}

	public void setTxType(String txType) {
		this.txType = txType;
	}

	public String getFtrDate() {
		return ftrDate;
	}

	public void setFtrDate(String ftrDate) {
		this.ftrDate = ftrDate;
	}

	public String getFtrNo() {
		return ftrNo;
	}

	public void setFtrNo(String ftrNo) {
		this.ftrNo = ftrNo;
	}

	public String getDebitAccNo() {
		return debitAccNo;
	}

	public void setDebitAccNo(String debitAccNo) {
		this.debitAccNo = debitAccNo;
	}

	public String getDebitIfscCode() {
		return debitIfscCode;
	}

	public void setDebitIfscCode(String debitIfscCode) {
		this.debitIfscCode = debitIfscCode;
	}

	public String getContractorMobile() {
		return contractorMobile;
	}

	public void setContractorMobile(String contractorMobile) {
		this.contractorMobile = contractorMobile;
	}

	public String getTransferAmount() {
		return transferAmount;
	}

	public void setTransferAmount(String transferAmount) {
		this.transferAmount = transferAmount;
	}

	public String getContractorName() {
		return contractorName;
	}

	public void setContractorName(String contractorName) {
		this.contractorName = contractorName;
	}

	public String getContractorCode() {
		return contractorCode;
	}

	public void setContractorCode(String contractorCode) {
		this.contractorCode = contractorCode;
	}

	public String getContractorIFSCCode() {
		return contractorIFSCCode;
	}

	public void setContractorIFSCCode(String contractorIFSCCode) {
		this.contractorIFSCCode = contractorIFSCCode;
	}

	public String getContractorACCNO() {
		return contractorACCNO;
	}

	public void setContractorACCNO(String contractorACCNO) {
		this.contractorACCNO = contractorACCNO;
	}

	public String getContractorAddress() {
		return contractorAddress;
	}

	public void setContractorAddress(String contractorAddress) {
		this.contractorAddress = contractorAddress;
	}

	public String getContractorBankName() {
		return contractorBankName;
	}

	public void setContractorBankName(String contractorBankName) {
		this.contractorBankName = contractorBankName;
	}

	public String getContractorBranchName() {
		return contractorBranchName;
	}

	public void setContractorBranchName(String contractorBranchName) {
		this.contractorBranchName = contractorBranchName;
	}

	public String getTxStatus() {
		return txStatus;
	}

	public void setTxStatus(String txStatus) {
		this.txStatus = txStatus;
	}

	public String getBankTransactionDate() {
		return bankTransactionDate;
	}

	public void setBankTransactionDate(String bankTransactionDate) {
		this.bankTransactionDate = bankTransactionDate;
	}

	public String getBankRefNo() {
		return bankRefNo;
	}

	public void setBankRefNo(String bankRefNo) {
		this.bankRefNo = bankRefNo;
	}

	public String getRejectionLevel() {
		return rejectionLevel;
	}

	public void setRejectionLevel(String rejectionLevel) {
		this.rejectionLevel = rejectionLevel;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getConractorEmail() {
		return conractorEmail;
	}

	public void setConractorEmail(String conractorEmail) {
		this.conractorEmail = conractorEmail;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getNarration() {
		return narration;
	}

	public void setNarration(String narration) {
		this.narration = narration;
	}

	public String getOfficeCode() {
		return officeCode;
	}

	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
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

}