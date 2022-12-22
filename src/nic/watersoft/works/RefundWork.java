/*
 * Created on 22-09-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.io.Serializable;

/**
 * @author RWSS_DPT1
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class RefundWork implements Serializable {

	
	String work_id;
	String work_name;
	String programme_name;
	String subProgramme_name;
	String sanctionAmoount;
	String sanctionDate;
	long refundAmount;
	String remarks;
	String officeCode;
	String chequeDate;
	String chequeNo;
	long soFarRefundAmount;
	String releaseAmount;
	String checks;
	String admissibleAmount;
	String billSNo;
	String billNo;
	String admissibleAmountInRs;
	String contractorAmountInRs;
	
	
	
	
	
	public String getAdmissibleAmount() {
		return admissibleAmount;
	}
	public void setAdmissibleAmount(String admissibleAmount) {
		this.admissibleAmount = admissibleAmount;
	}
	public String getBillSNo() {
		return billSNo;
	}
	public void setBillSNo(String billSNo) {
		this.billSNo = billSNo;
	}
	public String getBillNo() {
		return billNo;
	}
	public void setBillNo(String billNo) {
		this.billNo = billNo;
	}
	public String getAdmissibleAmountInRs() {
		return admissibleAmountInRs;
	}
	public void setAdmissibleAmountInRs(String admissibleAmountInRs) {
		this.admissibleAmountInRs = admissibleAmountInRs;
	}
	public String getContractorAmountInRs() {
		return contractorAmountInRs;
	}
	public void setContractorAmountInRs(String contractorAmountInRs) {
		this.contractorAmountInRs = contractorAmountInRs;
	}
	/**
	 * @return Returns the check.
	 */
	public String getChecks() {
				return checks;
	}
	/**
	 * @param check The check to set.
	 */
	public void setChecks(String checks) {
		this.checks = checks;
	}
	/**
	 * @return Returns the releaseAmount.
	 */
	public String getReleaseAmount() {
		return releaseAmount;
	}
	/**
	 * @param releaseAmount The releaseAmount to set.
	 */
	public void setReleaseAmount(String releaseAmount) {
		this.releaseAmount = releaseAmount;
	}
	/**
	 * @return Returns the soFarRefundAmount.
	 */
	public long getSoFarRefundAmount() {
		return soFarRefundAmount;
	}
	/**
	 * @param soFarRefundAmount The soFarRefundAmount to set.
	 */
	public void setSoFarRefundAmount(long soFarRefundAmount) {
		this.soFarRefundAmount = soFarRefundAmount;
	}
	/**
	 * @return Returns the chequeDate.
	 */
	public String getChequeDate() {
		return chequeDate;
	}
	/**
	 * @param chequeDate The chequeDate to set.
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
	 * @param chequeNo The chequeNo to set.
	 */
	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}
	/**
	 * @return Returns the refundAmount.
	 */
	public long getRefundAmount() {
		if(Long.toString(refundAmount)==null){
			return 0;
		}
		return refundAmount;
	}
	/**
	 * @param refundAmount The refundAmount to set.
	 */
	public void setRefundAmount(long refundAmount) {
		this.refundAmount = refundAmount;
	}
	/**
	 * @return Returns the remarks.
	 */
	public String getRemarks() {
		return remarks;
	}
	/**
	 * @param remarks The remarks to set.
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	/**
	 * @return Returns the programme_name.
	 */
	public String getProgramme_name() {
		return programme_name;
	}
	/**
	 * @param programme_name The programme_name to set.
	 */
	public void setProgramme_name(String programme_name) {
		this.programme_name = programme_name;
	}
	/**
	 * @return Returns the sanctionAmoount.
	 */
	public String getSanctionAmoount() {
		return sanctionAmoount;
	}
	/**
	 * @param sanctionAmoount The sanctionAmoount to set.
	 */
	public void setSanctionAmoount(String sanctionAmoount) {
		this.sanctionAmoount = sanctionAmoount;
	}
	/**
	 * @return Returns the sanctionDate.
	 */
	public String getSanctionDate() {
		return sanctionDate;
	}
	/**
	 * @param sanctionDate The sanctionDate to set.
	 */
	public void setSanctionDate(String sanctionDate) {
		this.sanctionDate = sanctionDate;
	}
	/**
	 * @return Returns the subProgramme_name.
	 */
	public String getSubProgramme_name() {
		return subProgramme_name;
	}
	/**
	 * @param subProgramme_name The subProgramme_name to set.
	 */
	public void setSubProgramme_name(String subProgramme_name) {
		this.subProgramme_name = subProgramme_name;
	}
	/**
	 * @return Returns the work_id.
	 */
	public String getWork_id() {
		return work_id;
	}
	/**
	 * @param work_id The work_id to set.
	 */
	public void setWork_id(String work_id) {
		this.work_id = work_id;
	}
	/**
	 * @return Returns the work_name.
	 */
	public String getWork_name() {
		return work_name;
	}
	/**
	 * @param work_name The work_name to set.
	 */
	public void setWork_name(String work_name) {
		this.work_name = work_name;
	}
	/**
	 * @return Returns the officeCode.
	 */
	public String getOfficeCode() {
		return officeCode;
	}
	/**
	 * @param officeCode The officeCode to set.
	 */
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
}
