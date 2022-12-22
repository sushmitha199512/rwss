package nic.watersoft.masters;

import java.io.Serializable;

public class RwsContractorRecord implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String workId;
	private String workName;
	
	private String contractorCode;

	private String contractorName;

	private String bankName;

	private String branchName;

	private String ifscCode;
	private String accountNo;

	private String primaryContractor;

	private String approvedOn;
	private String checks;

	private String recordCorrupted;
	
	
	

	public String getWorkName() {
		return workName;
	}

	public void setWorkName(String workName) {
		this.workName = workName;
	}

	public String getWorkId() {
		return workId;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public String getRecordCorrupted() {
		return recordCorrupted;
	}

	public void setRecordCorrupted(String recordCorrupted) {
		this.recordCorrupted = recordCorrupted;
	}

	public String getChecks() {
		return checks;
	}

	public void setChecks(String checks) {
		this.checks = checks;
	}

	public String getApprovedOn() {
		return approvedOn;
	}

	public void setApprovedOn(String approvedOn) {
		this.approvedOn = approvedOn;
	}

	public String getPrimaryContractor() {
		return primaryContractor;
	}

	public void setPrimaryContractor(String primaryContractor) {
		this.primaryContractor = primaryContractor;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public String getIfscCode() {
		return ifscCode;
	}

	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setContractorCode(String contractorCode) {
		this.contractorCode = contractorCode;
	}

	public String getContractorCode() {
		return contractorCode;
	}

	public void setContractorName(String contractorName) {
		this.contractorName = contractorName;
	}

	public String getContractorName() {
		return contractorName;
	}

}
