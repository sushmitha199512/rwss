package nic.watersoft.works;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionMapping;

/**
 * @author MANOJ
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_EOAT_bean {
	String dcode;
	String circleOfficeCode;
	String divisionOfficeCode;
	String subDivisionOfficeCode;
	String workId;
	String workName;
	String sno;
	String adminNo;
	String adminDate;
	String tsNo;
	String tsDate;
	String programmeCode;
	String programmeName;
	String valueOfWorkDone;
	String costOfWork;
	String valueOfWorkBeyondAgreement;
	String valueOfWorkToBeDone;
	String dateOfCompletion;
	String eoatOrderNo;
	String eoatDate;
	String costEsclationSought;
	String eoatPeriod;
	String eoatOldRefNo1;
	String eoatOldRefDate1;
	String eoatOldRefNo2;
	String eoatOldRefDate2;
	String fineImposed;
	String fineRecovered;
	String reasonsForNotRecoveringFine;
	String officerResponsible1;
	String officerResponsible2;
	String officerResponsible3;
	String exemptRecommendedBySE;
	String totalDaysExemptBySe;
	String rateOfPenalty;
	String totalPenalty;
	String reasonsByContractor;
	String contractorRepMadeUpd;
	String agreementCopyPenaltyUpd;
	String suppDocumentForExempUpd;
	String aeeRecommend;
	String deeRecommend;
	String eeRecommend;
	String seRecommend;
	String ceRecommend;
	String eoatGrantAuthority;
	String suppAgreeNo;
	String suppAgreeDt;
	String preparedBy;
	String preparedDate;
	
	String contractValue;
	String contractName;
	String dateOfAgreement;
	String dateOfHandOverSite;
	String periodOfContract;
	
	String tenderCommittee;
	String competentAuthority;
	String districtName;
	String typeOfAsset;
	
	

	/**
	 * @return Returns the aeeRecommend.
	 */
	public String getAeeRecommend() {
		return aeeRecommend;
	}
	/**
	 * @param aeeRecommend The aeeRecommend to set.
	 */
	public void setAeeRecommend(String aeeRecommend) {
		this.aeeRecommend = aeeRecommend;
	}
	/**
	 * @return Returns the agreementCopyPenaltyUpd.
	 */
	public String getAgreementCopyPenaltyUpd() {
		return agreementCopyPenaltyUpd;
	}
	/**
	 * @param agreementCopyPenaltyUpd The agreementCopyPenaltyUpd to set.
	 */
	public void setAgreementCopyPenaltyUpd(String agreementCopyPenaltyUpd) {
		this.agreementCopyPenaltyUpd = agreementCopyPenaltyUpd;
	}
	/**
	 * @return Returns the ceRecommend.
	 */
	public String getCeRecommend() {
		return ceRecommend;
	}
	/**
	 * @param ceRecommend The ceRecommend to set.
	 */
	public void setCeRecommend(String ceRecommend) {
		this.ceRecommend = ceRecommend;
	}
	/**
	 * @return Returns the circleOfficeCode.
	 */
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	/**
	 * @param circleOfficeCode The circleOfficeCode to set.
	 */
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	/**
	 * @return Returns the contractorRepMadeUpd.
	 */
	public String getContractorRepMadeUpd() {
		return contractorRepMadeUpd;
	}
	/**
	 * @param contractorRepMadeUpd The contractorRepMadeUpd to set.
	 */
	public void setContractorRepMadeUpd(String contractorRepMadeUpd) {
		this.contractorRepMadeUpd = contractorRepMadeUpd;
	}
	/**
	 * @return Returns the costEsclationSought.
	 */
	public String getCostEsclationSought() {
		return costEsclationSought;
	}
	/**
	 * @param costEsclationSought The costEsclationSought to set.
	 */
	public void setCostEsclationSought(String costEsclationSought) {
		this.costEsclationSought = costEsclationSought;
	}
	/**
	 * @return Returns the costOfWork.
	 */
	public String getCostOfWork() {
		return costOfWork;
	}
	/**
	 * @param costOfWork The costOfWork to set.
	 */
	public void setCostOfWork(String costOfWork) {
		this.costOfWork = costOfWork;
	}
	
	/**
	 * @return Returns the dcode.
	 */
	public String getDcode() {
		return dcode;
	}
	/**
	 * @param dcode The dcode to set.
	 */
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	/**
	 * @return Returns the deeRecommend.
	 */
	public String getDeeRecommend() {
		return deeRecommend;
	}
	/**
	 * @param deeRecommend The deeRecommend to set.
	 */
	public void setDeeRecommend(String deeRecommend) {
		this.deeRecommend = deeRecommend;
	}
	/**
	 * @return Returns the divisionOfficeCode.
	 */
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	/**
	 * @param divisionOfficeCode The divisionOfficeCode to set.
	 */
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	/**
	 * @return Returns the eeRecommend.
	 */
	public String getEeRecommend() {
		return eeRecommend;
	}
	/**
	 * @param eeRecommend The eeRecommend to set.
	 */
	public void setEeRecommend(String eeRecommend) {
		this.eeRecommend = eeRecommend;
	}
	/**
	 * @return Returns the eoatDate.
	 */
	public String getEoatDate() {
		return eoatDate;
	}
	/**
	 * @param eoatDate The eoatDate to set.
	 */
	public void setEoatDate(String eoatDate) {
		this.eoatDate = eoatDate;
	}
	/**
	 * @return Returns the eoatGrantAuthority.
	 */
	public String getEoatGrantAuthority() {
		return eoatGrantAuthority;
	}
	/**
	 * @param eoatGrantAuthority The eoatGrantAuthority to set.
	 */
	public void setEoatGrantAuthority(String eoatGrantAuthority) {
		this.eoatGrantAuthority = eoatGrantAuthority;
	}
	/**
	 * @return Returns the eoatOldRefDate1.
	 */
	public String getEoatOldRefDate1() {
		return eoatOldRefDate1;
	}
	/**
	 * @param eoatOldRefDate1 The eoatOldRefDate1 to set.
	 */
	public void setEoatOldRefDate1(String eoatOldRefDate1) {
		this.eoatOldRefDate1 = eoatOldRefDate1;
	}
	/**
	 * @return Returns the eoatOldRefDate2.
	 */
	public String getEoatOldRefDate2() {
		return eoatOldRefDate2;
	}
	/**
	 * @param eoatOldRefDate2 The eoatOldRefDate2 to set.
	 */
	public void setEoatOldRefDate2(String eoatOldRefDate2) {
		this.eoatOldRefDate2 = eoatOldRefDate2;
	}
	/**
	 * @return Returns the eoatOldRefNo1.
	 */
	public String getEoatOldRefNo1() {
		return eoatOldRefNo1;
	}
	/**
	 * @param eoatOldRefNo1 The eoatOldRefNo1 to set.
	 */
	public void setEoatOldRefNo1(String eoatOldRefNo1) {
		this.eoatOldRefNo1 = eoatOldRefNo1;
	}
	/**
	 * @return Returns the eoatOldRefNo2.
	 */
	public String getEoatOldRefNo2() {
		return eoatOldRefNo2;
	}
	/**
	 * @param eoatOldRefNo2 The eoatOldRefNo2 to set.
	 */
	public void setEoatOldRefNo2(String eoatOldRefNo2) {
		this.eoatOldRefNo2 = eoatOldRefNo2;
	}
	/**
	 * @return Returns the eoatOrderNo.
	 */
	public String getEoatOrderNo() {
		return eoatOrderNo;
	}
	/**
	 * @param eoatOrderNo The eoatOrderNo to set.
	 */
	public void setEoatOrderNo(String eoatOrderNo) {
		this.eoatOrderNo = eoatOrderNo;
	}
	/**
	 * @return Returns the eoatPeriod.
	 */
	public String getEoatPeriod() {
		return eoatPeriod;
	}
	/**
	 * @param eoatPeriod The eoatPeriod to set.
	 */
	public void setEoatPeriod(String eoatPeriod) {
		this.eoatPeriod = eoatPeriod;
	}
	/**
	 * @return Returns the exemptRecommendedBySE.
	 */
	public String getExemptRecommendedBySE() {
		return exemptRecommendedBySE;
	}
	/**
	 * @param exemptRecommendedBySE The exemptRecommendedBySE to set.
	 */
	public void setExemptRecommendedBySE(String exemptRecommendedBySE) {
		this.exemptRecommendedBySE = exemptRecommendedBySE;
	}
	/**
	 * @return Returns the fineImposed.
	 */
	public String getFineImposed() {
		return fineImposed;
	}
	/**
	 * @param fineImposed The fineImposed to set.
	 */
	public void setFineImposed(String fineImposed) {
		this.fineImposed = fineImposed;
	}
	/**
	 * @return Returns the fineRecovered.
	 */
	public String getFineRecovered() {
		return fineRecovered;
	}
	/**
	 * @param fineRecovered The fineRecovered to set.
	 */
	public void setFineRecovered(String fineRecovered) {
		this.fineRecovered = fineRecovered;
	}
	/**
	 * @return Returns the officerResponsible1.
	 */
	public String getOfficerResponsible1() {
		return officerResponsible1;
	}
	/**
	 * @param officerResponsible1 The officerResponsible1 to set.
	 */
	public void setOfficerResponsible1(String officerResponsible1) {
		this.officerResponsible1 = officerResponsible1;
	}
	/**
	 * @return Returns the officerResponsible2.
	 */
	public String getOfficerResponsible2() {
		return officerResponsible2;
	}
	/**
	 * @param officerResponsible2 The officerResponsible2 to set.
	 */
	public void setOfficerResponsible2(String officerResponsible2) {
		this.officerResponsible2 = officerResponsible2;
	}
	/**
	 * @return Returns the officerResponsible3.
	 */
	public String getOfficerResponsible3() {
		return officerResponsible3;
	}
	/**
	 * @param officerResponsible3 The officerResponsible3 to set.
	 */
	public void setOfficerResponsible3(String officerResponsible3) {
		this.officerResponsible3 = officerResponsible3;
	}
	/**
	 * @return Returns the preparedBy.
	 */
	public String getPreparedBy() {
		return preparedBy;
	}
	/**
	 * @param preparedBy The preparedBy to set.
	 */
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	/**
	 * @return Returns the preparedDate.
	 */
	public String getPreparedDate() {
		return preparedDate;
	}
	/**
	 * @param preparedDate The preparedDate to set.
	 */
	public void setPreparedDate(String preparedDate) {
		this.preparedDate = preparedDate;
	}
	/**
	 * @return Returns the programmeCode.
	 */
	public String getProgrammeCode() {
		return programmeCode;
	}
	/**
	 * @param programmeCode The programmeCode to set.
	 */
	public void setProgrammeCode(String programmeCode) {
		this.programmeCode = programmeCode;
	}
	/**
	 * @return Returns the rateOfPenalty.
	 */
	public String getRateOfPenalty() {
		return rateOfPenalty;
	}
	/**
	 * @param rateOfPenalty The rateOfPenalty to set.
	 */
	public void setRateOfPenalty(String rateOfPenalty) {
		this.rateOfPenalty = rateOfPenalty;
	}
	/**
	 * @return Returns the reasonsByContractor.
	 */
	public String getReasonsByContractor() {
		return reasonsByContractor;
	}
	/**
	 * @param reasonsByContractor The reasonsByContractor to set.
	 */
	public void setReasonsByContractor(String reasonsByContractor) {
		this.reasonsByContractor = reasonsByContractor;
	}
	/**
	 * @return Returns the reasonsForNotRecoveringFine.
	 */
	public String getReasonsForNotRecoveringFine() {
		return reasonsForNotRecoveringFine;
	}
	/**
	 * @param reasonsForNotRecoveringFine The reasonsForNotRecoveringFine to set.
	 */
	public void setReasonsForNotRecoveringFine(
			String reasonsForNotRecoveringFine) {
		this.reasonsForNotRecoveringFine = reasonsForNotRecoveringFine;
	}
	/**
	 * @return Returns the seRecommend.
	 */
	public String getSeRecommend() {
		return seRecommend;
	}
	/**
	 * @param seRecommend The seRecommend to set.
	 */
	public void setSeRecommend(String seRecommend) {
		this.seRecommend = seRecommend;
	}
	/**
	 * @return Returns the subDivisionOfficeCode.
	 */
	public String getSubDivisionOfficeCode() {
		return subDivisionOfficeCode;
	}
	/**
	 * @param subDivisionOfficeCode The subDivisionOfficeCode to set.
	 */
	public void setSubDivisionOfficeCode(String subDivisionOfficeCode) {
		this.subDivisionOfficeCode = subDivisionOfficeCode;
	}
	/**
	 * @return Returns the suppAgreeDt.
	 */
	public String getSuppAgreeDt() {
		return suppAgreeDt;
	}
	/**
	 * @param suppAgreeDt The suppAgreeDt to set.
	 */
	public void setSuppAgreeDt(String suppAgreeDt) {
		this.suppAgreeDt = suppAgreeDt;
	}
	/**
	 * @return Returns the suppAgreeNo.
	 */
	public String getSuppAgreeNo() {
		return suppAgreeNo;
	}
	/**
	 * @param suppAgreeNo The suppAgreeNo to set.
	 */
	public void setSuppAgreeNo(String suppAgreeNo) {
		this.suppAgreeNo = suppAgreeNo;
	}
	/**
	 * @return Returns the suppDocumentForExempUpd.
	 */
	public String getSuppDocumentForExempUpd() {
		return suppDocumentForExempUpd;
	}
	/**
	 * @param suppDocumentForExempUpd The suppDocumentForExempUpd to set.
	 */
	public void setSuppDocumentForExempUpd(String suppDocumentForExempUpd) {
		this.suppDocumentForExempUpd = suppDocumentForExempUpd;
	}
	/**
	 * @return Returns the totalDaysExemptBySe.
	 */
	public String getTotalDaysExemptBySe() {
		return totalDaysExemptBySe;
	}
	/**
	 * @param totalDaysExemptBySe The totalDaysExemptBySe to set.
	 */
	public void setTotalDaysExemptBySe(String totalDaysExemptBySe) {
		this.totalDaysExemptBySe = totalDaysExemptBySe;
	}
	/**
	 * @return Returns the totalPenalty.
	 */
	public String getTotalPenalty() {
		return totalPenalty;
	}
	/**
	 * @param totalPenalty The totalPenalty to set.
	 */
	public void setTotalPenalty(String totalPenalty) {
		this.totalPenalty = totalPenalty;
	}
	/**
	 * @return Returns the valueOfWorkBeyondAgreement.
	 */
	public String getValueOfWorkBeyondAgreement() {
		return valueOfWorkBeyondAgreement;
	}
	/**
	 * @param valueOfWorkBeyondAgreement The valueOfWorkBeyondAgreement to set.
	 */
	public void setValueOfWorkBeyondAgreement(String valueOfWorkBeyondAgreement) {
		this.valueOfWorkBeyondAgreement = valueOfWorkBeyondAgreement;
	}
	/**
	 * @return Returns the valueOfWorkDone.
	 */
	public String getValueOfWorkDone() {
		return valueOfWorkDone;
	}
	/**
	 * @param valueOfWorkDone The valueOfWorkDone to set.
	 */
	public void setValueOfWorkDone(String valueOfWorkDone) {
		this.valueOfWorkDone = valueOfWorkDone;
	}
	/**
	 * @return Returns the valueOfWorkToBeDone.
	 */
	public String getValueOfWorkToBeDone() {
		return valueOfWorkToBeDone;
	}
	/**
	 * @param valueOfWorkToBeDone The valueOfWorkToBeDone to set.
	 */
	public void setValueOfWorkToBeDone(String valueOfWorkToBeDone) {
		this.valueOfWorkToBeDone = valueOfWorkToBeDone;
	}
	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}
	/**
	 * @param workId The workId to set.
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	/**
	 * @return Returns the workName.
	 */
	public String getWorkName() {
		return workName;
	}
	/**
	 * @param workName The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	/**
	 * @return Returns the dateOfCompletion.
	 */
	public String getDateOfCompletion() {
		return dateOfCompletion;
	}
	/**
	 * @param dateOfCompletion The dateOfCompletion to set.
	 */
	public void setDateOfCompletion(String dateOfCompletion) {
		this.dateOfCompletion = dateOfCompletion;
	}
	/**
	 * @return Returns the programmeName.
	 */
	public String getProgrammeName() {
		return programmeName;
	}
	/**
	 * @param programmeName The programmeName to set.
	 */
	public void setProgrammeName(String programmeName) {
		this.programmeName = programmeName;
	}
	/**
	 * @return Returns the sNo.
	 */
	
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
	 * @return Returns the adminDate.
	 */
	public String getAdminDate() {
		return adminDate;
	}
	/**
	 * @param adminDate The adminDate to set.
	 */
	public void setAdminDate(String adminDate) {
		this.adminDate = adminDate;
	}
	/**
	 * @return Returns the adminNo.
	 */
	public String getAdminNo() {
		return adminNo;
	}
	/**
	 * @param adminNo The adminNo to set.
	 */
	public void setAdminNo(String adminNo) {
		this.adminNo = adminNo;
	}
	/**
	 * @return Returns the tsDate.
	 */
	public String getTsDate() {
		return tsDate;
	}
	/**
	 * @param tsDate The tsDate to set.
	 */
	public void setTsDate(String tsDate) {
		this.tsDate = tsDate;
	}
	/**
	 * @return Returns the tsNo.
	 */
	public String getTsNo() {
		return tsNo;
	}
	/**
	 * @param tsNo The tsNo to set.
	 */
	public void setTsNo(String tsNo) {
		this.tsNo = tsNo;
	}
	/**
	 * @return Returns the contractName.
	 */
	public String getContractName() {
		return contractName;
	}
	/**
	 * @param contractName The contractName to set.
	 */
	public void setContractName(String contractName) {
		this.contractName = contractName;
	}
	/**
	 * @return Returns the contractValue.
	 */
	public String getContractValue() {
		return contractValue;
	}
	/**
	 * @param contractValue The contractValue to set.
	 */
	public void setContractValue(String contractValue) {
		this.contractValue = contractValue;
	}
	/**
	 * @return Returns the dateOfAgreement.
	 */
	public String getDateOfAgreement() {
		return dateOfAgreement;
	}
	/**
	 * @param dateOfAgreement The dateOfAgreement to set.
	 */
	public void setDateOfAgreement(String dateOfAgreement) {
		this.dateOfAgreement = dateOfAgreement;
	}
	/**
	 * @return Returns the dateOfHandOverSite.
	 */
	public String getDateOfHandOverSite() {
		return dateOfHandOverSite;
	}
	/**
	 * @param dateOfHandOverSite The dateOfHandOverSite to set.
	 */
	public void setDateOfHandOverSite(String dateOfHandOverSite) {
		this.dateOfHandOverSite = dateOfHandOverSite;
	}
	/**
	 * @return Returns the periodOfContract.
	 */
	public String getPeriodOfContract() {
		return periodOfContract;
	}
	/**
	 * @param periodOfContract The periodOfContract to set.
	 */
	public void setPeriodOfContract(String periodOfContract) {
		this.periodOfContract = periodOfContract;
	}
	/**
	 * @return Returns the competentAuthority.
	 */
	public String getCompetentAuthority() {
		return competentAuthority;
	}
	/**
	 * @param competentAuthority The competentAuthority to set.
	 */
	public void setCompetentAuthority(String competentAuthority) {
		this.competentAuthority = competentAuthority;
	}
	/**
	 * @return Returns the tenderCommittee.
	 */
	public String getTenderCommittee() {
		return tenderCommittee;
	}
	/**
	 * @param tenderCommittee The tenderCommittee to set.
	 */
	public void setTenderCommittee(String tenderCommittee) {
		this.tenderCommittee = tenderCommittee;
	}
	/**
	 * @return Returns the districtName.
	 */
	public String getDistrictName() {
		return districtName;
	}
	/**
	 * @param districtName The districtName to set.
	 */
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	/**
	 * @return Returns the typeOfAsset.
	 */
	public String getTypeOfAsset() {
		return typeOfAsset;
	}
	/**
	 * @param typeOfAsset The typeOfAsset to set.
	 */
	public void setTypeOfAsset(String typeOfAsset) {
		this.typeOfAsset = typeOfAsset;
	}
}
