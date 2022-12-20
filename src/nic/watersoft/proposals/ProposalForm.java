package nic.watersoft.proposals;

import java.util.ArrayList;

import nic.watersoft.commons.BaseActionForm;
import nic.watersoft.commons.RwsLocationBean;

import org.apache.struts.upload.FormFile;

public class ProposalForm extends BaseActionForm 
{
	private String district;
	private String mandal;
	private String panchayat;
	private String village;
		
	private String repCode;
	private String constituencyCode;
	private String repName;
	private String repAddress;
	private String repDate;
	private String endorsedBy;
	private String endorsementNo;
	private String endorsementDate;
	private String description;
	private String recommendations;
	
	private String proposalId;
	private String proposalName;
	private String noOfHabs;
	private String typeOfAsset;
	private String programmeCode;
	private String subprogrammeCode;
	private String priorityCode;
	private String estimateCost;
	
	private String sanctionedAmount;
	private String sanctioningAuthority;
	private String sanctionedAt;
	private String goNo;
	private String adminNo;
	private String adminDate;
	private String financialYear;
	private String workId;
	private String assetCode;
	private ArrayList selectedHabs;
	private String habCode;
	
	private String letterNo;
	private String submitDate;
	private String submitSubject;
	private String submitRef;
	private String submitContent;
	
	private String memoNo;
	private String forwardDate;
	private String forwardSubject;
	private String forwardRef;
	private String forwardContent;
	
	//code added
	private String forwardDivisionOffice;
	private String forwardSubDivisionOffice;
	private String forwardToDivision;
	private String actionToToDivision;
	private String forwardToSubDivision;
	private String actionToSubDivision;
	//end of code added
	
	private String actionTo;
	private String forwardTo;
	private String forwardOffice;
	private String submitTo;
	private String submitOffice;
	private String actionType;
	private String phased;
	private String phaseNo;
	private int noOfWorks;

	private FormFile lineEstimate;
	private FormFile budjetEstimate;
	private String lineEstimatePath;
	private String budjetEstimatePath;
	private FormFile govtOrder;

	private String centralShare;
	private String stateShare;
	private String gpShare;
	private String publicContribution;
	private String others;
	private String otherRemarks;
	
	
	private ArrayList representatives;
	private ArrayList constituencies;
	private ArrayList assetTypes;
	private ArrayList programmes;
	private ArrayList subprogrammes;
	private ArrayList priorities;
	private ArrayList proposals;
	private ArrayList financialYears;
	private String[] programmeCodes = {}; 
	private String[] selectedHabCode;
	private String sanctionLevel;
	
	public ProposalForm()
	{
		proposals = new ArrayList();
		for(int i=0; i<10; i++)
		{
			proposals.add(new ProposalHolder());
		}
		noOfWorks = 1;
	}
	
	public String getActionType()
	{
		return actionType;
	}
	
	public void setActionType(String actionType)
	{
		this.actionType = actionType;
	}
	
	public void setRepCode(String repCode)
	{	this.repCode = repCode;
	}
	public String getRepCode()
	{	return repCode;
	}
	
	public void setConstituencyCode(String constituencyCode)
	{	this.constituencyCode = constituencyCode;
	}
	public String getConstituencyCode()
	{	return constituencyCode;
	}

	public void setRepName(String repName)
	{	this.repName = repName;
	}
	public String getRepName()
	{	return repName;
	}

	public void setRepAddress(String repAddress)
	{	this.repAddress = repAddress;
	}
	public String getRepAddress()
	{	return repAddress;
	}
	
	public void setRepDate(String repDate)
	{	this.repDate = repDate;
	}
	public String getRepDate()
	{	return repDate;
	}

	public void setEndorsedBy(String endorsedBy)
	{	this.endorsedBy = endorsedBy;
	}
	public String getEndorsedBy()
	{	return endorsedBy;
	}
	
	public void setEndorsementNo(String endorsementNo)
	{	this.endorsementNo = endorsementNo;
	}
	public String getEndorsementNo()
	{	return endorsementNo;
	}
	
	public void setEndorsementDate(String endorsementDate)
	{	this.endorsementDate = endorsementDate;
	}
	public String getEndorsementDate()
	{	return endorsementDate;
	}
	
	public void setDescription(String description)
	{	this.description = description;
	}
	public String getDescription()
	{	return description;
	}

	public void setRecommendations(String recommendations)
	{	this.recommendations = recommendations;
	}
	public String getRecommendations()
	{	return recommendations;
	}

	public void setProposalName(String proposalName)
	{	this.proposalName = proposalName;
	}
	public String getProposalName()
	{	return proposalName;
	}
	
	public void setNoOfHabs(String noOfHabs)
	{	this.noOfHabs = noOfHabs;
	}
	public String getNoOfHabs()
	{	return noOfHabs;
	}
	
	public void setTypeOfAsset(String typeOfAsset)
	{	this.typeOfAsset = typeOfAsset;
	}
	public String getTypeOfAsset()
	{	return typeOfAsset;
	}

	public void setProgrammeCode(String programmeCode)
	{	this.programmeCode = programmeCode;
	}
	public String getProgrammeCode()
	{	return programmeCode;
	}
	
	public void setSubprogrammeCode(String subprogrammeCode)   
	{	this.subprogrammeCode = subprogrammeCode;				 
	}
	public String getSubprogrammeCode()
	{	return subprogrammeCode;
	}
	
	public void setPriorityCode(String priorityCode)   
	{	this.priorityCode = priorityCode;
	}
	public String getPriorityCode()
	{	return priorityCode;
	}
	
	public void setEstimateCost(String estimateCost)
	{	this.estimateCost = estimateCost;
	}
	public String getEstimateCost()
	{	return estimateCost;
	}

	public void setProposalId(String proposalId)
	{	this.proposalId = proposalId;
	}
	public String getProposalId()
	{	return proposalId;
	}

	public void setFinancialYear(String financialYear)
	{	this.financialYear = financialYear;
	}
	public String getFinancialYear()
	{	return financialYear;
	}
	
	public void setSanctionedAt(String sanctionedAt)
	{	this.sanctionedAt = sanctionedAt;
	}
	public String getSanctionedAt()
	{	return sanctionedAt;
	}

	public void setSanctionedAmount(String sanctionedAmount)
	{	this.sanctionedAmount = sanctionedAmount;
	}
	public String getSanctionedAmount()
	{	return sanctionedAmount;
	}
				   
	public void setSanctioningAuthority(String sanctioningAuthority)
	{	this.sanctioningAuthority = sanctioningAuthority;
	}
	public String getSanctioningAuthority()
	{	return sanctioningAuthority;
	}
	
	public void setGoNo(String goNo)
	{	this.goNo = goNo;
	}
	public String getGoNo()
	{	return goNo;
	}
	
	public void setAdminNo(String adminNo)
	{	this.adminNo = adminNo;
	}
	public String getAdminNo()
	{	return adminNo;
	}
	
	public void setAdminDate(String adminDate)
	{	this.adminDate = adminDate;
	}
	public String getAdminDate()
	{	return adminDate;
	}			   
					   
	public void setWorkId(String workId)
	{	this.workId = workId;
	}
	public String getWorkId()
	{	return workId;
	}

	public void setAssetCode(String assetCode)
	{ this.assetCode = assetCode;
	}
	public String getAssetCode()
	{	return assetCode;
	}
	
	public void setLineEstimatePath(String lineEstimatePath)
	{	this.lineEstimatePath = lineEstimatePath;
	}			   
	public String getLineEstimatePath()
	{	return lineEstimatePath;
	}			   
				   
	public void setBudjetEstimatePath(String budjetEstimatePath)
	{	this.budjetEstimatePath = budjetEstimatePath;
	}			   
	public String getBudjetEstimatePath()
	{	return budjetEstimatePath;
	}

	public void setHabCode(String habCode)
	{	this.habCode = habCode;
	}
	public String getHabCode()
	{	return habCode;
	}
	
	public void setLetterNo(String letterNo)
	{	this.letterNo = letterNo;
	}
	public String getLetterNo()
	{	return letterNo;
	}
	public void setSubmitDate(String submitDate)
	{
		this.submitDate = submitDate;
	}
	public String getSubmitDate()
	{
		return submitDate;
	}
	public void setSubmitSubject(String submitSubject)
	{	this.submitSubject = submitSubject; 
	}
	public String getSubmitSubject()
	{	return submitSubject;
	}
	
	public void setSubmitRef(String submitRef)
	{	this.submitRef = submitRef;
	}
	public String getSubmitRef()
	{	return submitRef;
	}
	
	public void setSubmitContent(String submitContent)
	{	this.submitContent = submitContent;
	}
	public String getSubmitContent()
	{	return submitContent;
	}
	
	public void setMemoNo(String memoNo)
	{	this.memoNo = memoNo;
	}
	public String getMemoNo()
	{	return memoNo;
	}
		
	public void setForwardDate(String forwardDate)
	{
		this.forwardDate = forwardDate;
	}
	public String getForwardDate()
	{
		return forwardDate;
	}
	public void setForwardSubject(String forwardSubject)
	{	this.forwardSubject = forwardSubject; 
	}
	public String getForwardSubject()
	{	return forwardSubject;
	}
	
	public void setForwardRef(String forwardRef)
	{	this.forwardRef = forwardRef;
	}
	public String getForwardRef()
	{	return forwardRef;
	}
	public void setForwardContent(String forwardContent)
	{	this.forwardContent = forwardContent;
	}
	public String getForwardContent()
	{	return forwardContent;
	}

	
	public void setForwardTo(String forwardTo)
	{	this.forwardTo = forwardTo;
	}
	public String getForwardTo()
	{	return forwardTo; 
	}
	
	public void setActionTo(String actionTo)
	{	this.actionTo = actionTo;
	}
	public String getActionTo()
	{	return actionTo; 
	}

	
	
	public void setForwardOffice(String forwardOffice)
	{	this.forwardOffice = forwardOffice;
	}
	public String getForwardOffice()
	{	return forwardOffice; 
	}
	
	
	public void setSubmitTo(String submitTo)
	{	this.submitTo = submitTo;
	}
	public String getSubmitTo()
	{	return submitTo; 
	}

	
	public void setSubmitOffice(String submitOffice)
	{	this.submitOffice = submitOffice;
	}
	public String getSubmitOffice()
	{	return submitOffice; 
	}

	public void setPhased(String phased)
	{	this.phased = phased;
	}
	public String getPhased()
	{	return phased;
	}

	public void setPhaseNo(String phaseNo)
	{	this.phaseNo = phaseNo;
	}
	public String getPhaseNo()
	{	return phaseNo;
	}

	
	public void setLineEstimate(FormFile lineEstimate)
	{	this.lineEstimate = lineEstimate;
	}
	public FormFile getLineEstimate()
	{	return lineEstimate; 
	}
	
	public void setBudjetEstimate(FormFile budjetEstimate)
	{	this.budjetEstimate = budjetEstimate;
	}
	public FormFile getBudjetEstimate()
	{	return budjetEstimate; 
	}

	public void setNoOfWorks(int noOfWorks)
	{	this.noOfWorks = noOfWorks;
	}
	public int getNoOfWorks()
	{	return noOfWorks;
	}

	public void setCentralShare(String centralShare)
	{	this.centralShare = centralShare;
	}
	public String getCentralShare()
	{	return centralShare;
	}

	public void setStateShare(String stateShare)
	{	this.stateShare = stateShare;
	}
	public String getStateShare()
	{	return stateShare;
	}

	public void setGpShare(String gpShare)
	{	this.gpShare = gpShare;
	}
	public String getGpShare()
	{	return gpShare;
	}

	public void setPublicContribution(String publicContribution)
	{	this.publicContribution = publicContribution;
	}
	public String getPublicContribution()
	{	return publicContribution;
	}

	public void setOthers(String others)
	{	this.others = others;
	}
	public String getOthers()
	{	return others;
	}
	
	// Accessors for representatives property
	public void setRepresentatives(ArrayList representatives)
	{	this.representatives = representatives; 
		
	}
	public ArrayList getRepresentatives()
	{	return representatives; 
	}
	
	// Accessors for representatives property
	public void setConstituencies(ArrayList constituencies)
	{	this.constituencies = constituencies; 
		
	}
	public ArrayList getConstituencies()
	{	return constituencies; 
	}
	
	// Accessors for assetTypes property
	public void setAssetTypes(ArrayList assetTypes)
	{	this.assetTypes = assetTypes;
	}
	public ArrayList getAssetTypes()
	{	return assetTypes;
	}

	// Accessors for programmes property
	public void setProgrammes(ArrayList programmes)
	{	this.programmes = programmes;
	}
	public ArrayList getProgrammes()
	{	return programmes;
	}

	// Accessors for subprogrammes property
	public void setSubprogrammes(ArrayList subprogrammes)
	{	this.subprogrammes = subprogrammes;
	}
	public ArrayList getSubprogrammes()
	{	return subprogrammes;
	}

	// Accessors for priorities property
	public void setPriorities(ArrayList priorities)
	{	this.priorities = priorities;
	}
	public ArrayList getPriorities()
	{	return priorities;
	}
	
	public void setFinancialYears(ArrayList financialYears)
	{this.financialYears = financialYears;
	}
	public ArrayList getFinancialYears()
	{	return financialYears;
	}

	public void setProposalHolder(int index, ProposalHolder proposalHolder)
	{	proposals.set(index, proposalHolder); 
    }

	public ProposalHolder getProposalHolder(int index)
	{ 
        return (ProposalHolder)proposals.get(index); 
    }
	
	public ArrayList getProposals()
	{	return proposals;
	}

	public void setSelectedHabs(ArrayList selectedHabs)
	{	this.selectedHabs = selectedHabs;
	}
	public ArrayList getSelectedHabs()
	{	return selectedHabs;
	}

	public RwsLocationBean getHABS(int index) 
	{	
		while(index >= selectedHabs.size())
		{
			selectedHabs.add(new String());
		}
		return (RwsLocationBean)selectedHabs.get(index);
	}
	
	public void setGovtOrder(FormFile govtOrder)
	{
		this.govtOrder = govtOrder;
	}
	
	public FormFile getGovtOrder()
	{	return govtOrder;
	}
	
	public void setOtherRemarks(String otherRemarks)
	{	this.otherRemarks = otherRemarks;
	}
	public String getOtherRemarks()
	{	return otherRemarks;
	}
	
	public void setProgrammeCodes(String[] programmeCodes)
	{	this.programmeCodes = programmeCodes;
	}
	public String[] getProgrammeCodes()
	{	return programmeCodes;
	}
	
	public void setSelectedHabCode(String[] selectedHabCode)
	{	this.selectedHabCode = selectedHabCode;
	}
	public String[] getSelectedHabCode()
	{	return selectedHabCode;
	}
	
	/**
	 * @return Returns the distrcit.
	 */
	public String getDistrict() {
		return district;
	}
	/**
	 * @param distrcit The distrcit to set.
	 */
	public void setDistrict(String district) {
		this.district = district;
	}
	/**
	 * @return Returns the mandal.
	 */
	public String getMandal() {
		return mandal;
	}
	/**
	 * @param mandal The mandal to set.
	 */
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	/**
	 * @return Returns the panchayat.
	 */
	public String getPanchayat() {
		return panchayat;
	}
	/**
	 * @param panchayat The panchayat to set.
	 */
	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}
	/**
	 * @return Returns the village.
	 */
	public String getVillage() {
		return village;
	}
	/**
	 * @param village The village to set.
	 */
	public void setVillage(String village) {
		this.village = village;
	}
	/**
	 * @param proposals The proposals to set.
	 */
	public void setProposals(ArrayList proposals) {
		this.proposals = proposals;
	}
	/**
	 * @return Returns the sanctionLevel.
	 */
	public String getSanctionLevel() {
		return sanctionLevel;
	}
	/**
	 * @param sanctionLevel The sanctionLevel to set.
	 */
	public void setSanctionLevel(String sanctionLevel) {
		this.sanctionLevel = sanctionLevel;
	}
	public String getActionToSubDivision() {
		return actionToSubDivision;
	}
	public void setActionToSubDivision(String actionToSubDivision) {
		this.actionToSubDivision = actionToSubDivision;
	}
	public String getActionToToDivision() {
		return actionToToDivision;
	}
	public void setActionToToDivision(String actionToToDivision) {
		this.actionToToDivision = actionToToDivision;
	}
	public String getForwardDivisionOffice() {
		return forwardDivisionOffice;
	}
	public void setForwardDivisionOffice(String forwardDivisionOffice) {
		this.forwardDivisionOffice = forwardDivisionOffice;
	}
	public String getForwardSubDivisionOffice() {
		return forwardSubDivisionOffice;
	}
	public void setForwardSubDivisionOffice(String forwardSubDivisionOffice) {
		this.forwardSubDivisionOffice = forwardSubDivisionOffice;
	}
	public String getForwardToDivision() {
		return forwardToDivision;
	}
	public void setForwardToDivision(String forwardToDivision) {
		this.forwardToDivision = forwardToDivision;
	}
	public String getForwardToSubDivision() {
		return forwardToSubDivision;
	}
	public void setForwardToSubDivision(String forwardToSubDivision) {
		this.forwardToSubDivision = forwardToSubDivision;
	}
}
