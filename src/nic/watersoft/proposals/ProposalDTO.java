package nic.watersoft.proposals;

import java.io.Serializable;
import java.util.ArrayList;

import nic.watersoft.commons.BaseDTO;

import org.apache.struts.upload.FormFile;

public class ProposalDTO extends BaseDTO implements Serializable
{
//	added by swapna on 06-04-2011 for adding the no.of schools and labs
	private String noOfSchools;
	private String noOfLabs;
	private String noOfOffices;
	//
	private String constituencyName;
	private String repCode;
	private String constituencyCode;
	private String repName;
	private String repAddress;
	private String repDate;
	private String endorsedBy;
	private String ministerFor;
	private String endorsementNo;
	private String endorsementDate;
	private String description;
	private String recommendations;
	private String revNoOfHabs;
	private String proposalId;
	private String proposalName;
	private String proposalDate;
	private String noOfHabs;
	private String typeOfAsset;
	private String programmeCode;
	private String programmeName;
	private String subprogrammeCode;
	private String subprogrammeName;
	private String priorityCode;
	private String estimateCost;
	private String revAdminDate;
	private String revAdminNo;
	private String sanctionedAmount;
	private String sanctioningAuthority;
	private String sanctionedAt;
	private String goNo;
	private String adminNo;
	private String adminDate;
	private String financialYear;
	private String workId;
	private String assetCode;
	private String assetName;
	private String revSanctionedAmount;
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
	
	private String letterMemoNo;
	private String forSubDate;
	private String subject;
	private String ref;
	private String content;
		
	private String forwardTo;
	private String forwardOffice;
	private String submitTo;
	private String submitOffice;
	
	private String forwardToDivision;
	private String forwardToSubDivision;
	
	private String actionFrom;
	private String actionTo;
	private String actionType;
	private String actionDate;
	private String sentTo;
	private String sentBy;
	private String trackNo;
	private String flag;
	private String phased;
	private String phaseNo;
	private int noOfWorks;
	private String message;
	
	private String centralShare;
	private String stateShare;
	private String gpShare;
	private String publicContribution;
	private String others;
	
	private String typeOfAssetCode;
	private String habCode;
	private String dateCreation;
	private String location;
	private String assetStatus;
	private String startYear;
	private String endYear;
	private String assetCost;
	private String sourceCode;
	private String sourceName;
	private String habName; 
	
	 
	 
	
	private String otherRemarks;
	private String leadHabitation;
	private FormFile lineEstimate;
	private FormFile budjetEstimate;
	private String status; 
	private ArrayList programmes; 
	private ArrayList habs; 
	private String sanctionLevel;
	private String subdivisionOfficeCode;
	
	private String noOfFunctionalHabs;
	
	//code added
	private String circle;
	private String division;
	private String subDivision;

	private ArrayList circleList;
	private ArrayList divisionList;
	private ArrayList subDivisionList;
	
	
	private String spillOver;
	private String preparedBy;
	private String preparedOn;
	
	/////////////
	private String mandalsCout;
	private String villagesCount;
 	private String ncCountAdm;
	private String pc1CountAdm;
	private String pc2CountAdm;
	private String pc3CountAdm;
	private String pc4CountAdm;
	private String fcCountAdm;
	

	private String ncCountTec;
	private String pc1CountTec;
	private String pc2CountTec;
	private String pc3CountTec;
	private String pc4CountTec;
	private String fcCountTec;
	
	private String ncCountRev;
	private String pc1CountRev;
	private String pc2CountRev;
	private String pc3CountRev;
	private String pc4CountRev;
	private String fcCountRev;
	private String tsAmount;
	private String qaRevHabs;
	
	private String ncCountTeRev;
	private String pc1CountTeRev;
	private String pc2CountTeRev;
	private String pc3CountTeRev;
	private String pc4CountTeRev;
	private String fcCountTeRev;
	private String tsRevAmount;
	
	private String noOfTechHabs;
	private String noOfRevhHabs;
	
	private String tenderTyp;
	private String tenderIssDate;
	private String tenEngPaper;
	private String tenTelPaper;
	private String tenRecievedOn;
	private String tenConName;
	private String tenconAdd1;
	private String tenconAdd3;
	private String tenconAdd2;
	private String tenCommitte;
	private String tenCompeAu;
	private String tenAppvOn;
	private String tenLoaIssOn;
	private String tenAggrDate;
	
	private String noOfConst;
	private String qaAdmHabs;
	private String  admFlouride;
	private String admBrackish;
	private String qaTecHabs;
	private String tecFlouride;
	private String tecBrackish;
	private String taRevHabs;
	private String revFlouride;
	private String revBrackish;
	private String qaRevTecHabs;
	private String revTecFlouride;
	private String revTecBrackish;
	private String noOfRevTeHabs;
	
	/*
	 * @AUTHOR MANOJ
	 */
	private String workCat;
	private String wrkType;
	private String plan;
	
	/*
	 * ramesh added
	 */
	private String augsch;
	private String prooved;
	private String coreDashboardStatus;
	private String approoved;
	private String physicalSatus;
	/**
	 * @return Returns the augch.
	 */
	public String getAugsch() {
		return augsch;
	}
	/**
	 * @param augch The augch to set.
	 */
	public void setAugsch(String augsch) {
		this.augsch = augsch;
	}
	/**
	 * @return Returns the prooved.
	 */
	public String getProoved() {
		return prooved;
	}
	/**
	 * @param prooved The prooved to set.
	 */
	public void setProoved(String prooved) {
		this.prooved = prooved;
	}
	private String siteHandingOverDate;
	private String workStartDate;
	private String assignedSubdivision;
	private String assignedEngg1;
	private String assignedEngg2;
	private String assignedEngg3;
	private String assignedEngg4;
	private String dateOfCompletion;
	private String dateOfCommmisioning;
	private String expUptoPreYear;
	private String yearMonth;
	private int totExpenditure;
	private String programWiseExp;
	
	////////////////
	
	public ProposalDTO()
	{
		circleList=new ArrayList();
	}
	//end of code added

	public void setConstituencyName(String constituencyName)
	{	this.constituencyName = constituencyName;
	}
	public String getConstituencyName()
	{	return constituencyName;
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
	
	public void setProposalDate(String proposalDate)
	{	this.proposalDate = proposalDate;
	}
	public String getProposalDate()
	{	return proposalDate;
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

	public void setProgrammeName(String programmeName)
	{	this.programmeName = programmeName;
	}
	public String getProgrammeName()
	{	return programmeName;
	}
	
	public void setSubprogrammeCode(String subprogrammeCode)   
	{	this.subprogrammeCode = subprogrammeCode;				 
	}
	public String getSubprogrammeCode()
	{	return subprogrammeCode;
	}
	
	public void setSubprogrammeName(String subprogrammeName)
	{	this.subprogrammeName = subprogrammeName;
	}
	public String getSubprogrammeName()
	{	return subprogrammeName;
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

	public void setAssetName(String assetName)
	{ this.assetName = assetName;
	}
	public String getAssetName()
	{	return assetName;
	}
	
	public void setLetterNo(String letterNo)
	{	this.letterNo = letterNo;
		this.letterMemoNo = letterNo;
	}
	public String getLetterNo()
	{	return letterNo;
	}
	public void setSubmitDate(String submitDate)
	{	this.submitDate = submitDate;
		this.forSubDate = submitDate;
	}
	public String getSubmitDate()
	{	return submitDate;
	}
	
	public void setSubmitSubject(String submitSubject)
	{	this.submitSubject = submitSubject; 
		this.subject = submitSubject;
	}
	public String getSubmitSubject()
	{	return submitSubject;
	}
	
	public void setSubmitRef(String submitRef)
	{	this.submitRef = submitRef;
		this.ref = submitRef;
	}
	public String getSubmitRef()
	{	return submitRef;
	}
	
	public void setSubmitContent(String submitContent)
	{	this.submitContent = submitContent;
		this.content = submitContent;
	}
	public String getSubmitContent()
	{	return submitContent;
	}
	
	public void setMemoNo(String memoNo)
	{	this.memoNo = memoNo;
		this.letterMemoNo = memoNo;
	}
	public String getMemoNo()
	{	return memoNo;
	}
		
	public void setForwardDate(String forwardDate)
	{	this.forwardDate = forwardDate;
		this.forSubDate = forwardDate;
	}
	public String getForwardDate()
	{	return forwardDate;
	}
	
	public void setForwardSubject(String forwardSubject)
	{	this.forwardSubject = forwardSubject;
		this.subject = forwardSubject;
	}
	public String getForwardSubject()
	{	return forwardSubject;
	}
	
	public void setForwardRef(String forwardRef)
	{	this.forwardRef = forwardRef;
		this.ref = forwardRef;
	}
	public String getForwardRef()
	{	return forwardRef;
	}
	
	public void setForwardContent(String forwardContent)
	{	this.forwardContent = forwardContent;
		this.content = forwardContent;
	}
	public String getForwardContent()
	{	return forwardContent;
	}
	
	// Accessors for forwardTo property
	public void setForwardTo(String forwardTo)
	{	this.forwardTo = forwardTo;
	}
	public String getForwardTo()
	{	return forwardTo; 
	}
	
	// Accessors for forwardOffice property
	public void setForwardOffice(String forwardOffice)
	{	this.forwardOffice = forwardOffice;
	}
	public String getForwardOffice()
	{	return forwardOffice; 
	}
	
	// Accessors for submitTo property
	public void setSubmitTo(String submitTo)
	{	this.submitTo = submitTo;
	}
	public String getSubmitTo()
	{	return submitTo; 
	}

	// Accessors for submitOffice property
	public void setSubmitOffice(String submitOffice)
	{	this.submitOffice = submitOffice;
	}
	public String getSubmitOffice()
	{	return submitOffice; 
	}

	// Accessors for lineEstimate property
	public void setLineEstimate(FormFile lineEstimate)
	{	this.lineEstimate = lineEstimate;
	}
	public FormFile getLineEstimate()
	{	return lineEstimate; 
	}

	// Accessors for budjetEstimate property
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

	public void setActionFrom(String actionFrom)
	{	this.actionFrom = actionFrom;
	}
	public String getActionFrom()
	{	return actionFrom;
	}

	public void setActionTo(String actionTo)
	{	this.actionTo = actionTo;
	}
	public String getActionTo()
	{	return actionTo;
	}

	public void setActionType(String actionType)
	{	this.actionType = actionType;
	}
	public String getActionType()
	{	return actionType;
	}

	public void setActionDate(String actionDate)
	{	this.actionDate = actionDate;
	}
	public String getActionDate()
	{	return actionDate;
	}

	public void setSentTo(String sentTo)
	{	this.sentTo = sentTo;
	}
	public String getSentTo()
	{	return sentTo;
	}

	public void setSentBy(String sentBy)
	{	this.sentBy = sentBy;
	}
	public String getSentBy()
	{	return sentBy;
	}

	public void setTrackNo(String trackNo)
	{	this.trackNo = trackNo;
	}
	public String getTrackNo()
	{	return trackNo;
	}

	public void setFlag(String flag)
	{	this.flag = flag;
	}
	public String getFlag()
	{	return flag;
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

	public String getMessage()
	{
		String memoLetterNo="Memo No";
		String flag = getFlag();
		if(flag!=null && flag.equals("F"))
			memoLetterNo = "Memo No.";
		if(flag!=null && flag.equals("S"))
			memoLetterNo = "Letter No.";
		if(flag!=null && flag.equals("P"))
			memoLetterNo = "Letter No.";
				
		 String tempMessage = "<table width=350>"
						    + "<tbody class=message>"
							+ "<tr>"
							+ "<td nowrap>"+memoLetterNo+"</td>"
							+ "<td>:</td>"
							+ "<td nowrap>" + letterMemoNo + "</td>"
							+ "</tr>"
							+ "<tr>"
							+ "<td nowrap>Date</td>"
							+ "<td>:</td>"
							+ "<td nowrap>" + forSubDate + "</td>"
							+ "</tr>"
							+ "<tr>" 
							+ "<td nowrap>Subject</td>"
							+ "<td>:</td>"
							+ "<td>" + subject + "</td>"
							+ "</tr>"
							+ "<tr>" 
							+ "<td nowrap>Ref.</td>"
							+ "<td>:</td>"
							+ "<td>" + ref + "</td>"
							+ "</tr>"
							+ "<tr>" 
							+ "<td valign=top nowrap>Content</td>"
							+ "<td valign=top>:</td>"
							+ "<td>" + content + "</td>"
							+ "</tr>"
							+ "</tbody>"
							+ "</table>";
		
		message = tempMessage;
		return message;
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
	
	public void setLeadHabitation(String leadHabitation)
	{	this.leadHabitation = leadHabitation;
	}
	public String getLeadHabitation()
	{	return leadHabitation;
	}
	
	public void setOtherRemarks(String otherRemarks)
	{	this.otherRemarks = otherRemarks;
	}
	public String getOtherRemarks()
	{	return otherRemarks;
	}
	
	public void setMinisterFor(String ministerFor)
	{	this.ministerFor = ministerFor;
	}
	public String getMinisterFor()
	{	return ministerFor;
	}

	public void setStatus(String status)
	{	this.status = status;
	}
	
	public String getStatus()
	{	return status;
	}
	
	public void setProgrammes(ArrayList programmes)
	{	this.programmes = programmes;
	}
	public ArrayList getProgrammes()
	{	return programmes;
	}
	
	
	public void setHabs(ArrayList habs)
	{	this.habs = habs;
	}
	public ArrayList getHabs()
	{	return habs;
	}
	
	public void setNoOfFunctionalHabs(String noOfFunctionalHabs)
	{	this.noOfFunctionalHabs = noOfFunctionalHabs;
	}
	public String getNoOfFunctionalHabs()
	{	return noOfFunctionalHabs;
	}
	
	/**
	 * @return Returns the assetCost.
	 */
	public String getAssetCost() {
		return assetCost;
	}
	/**
	 * @param assetCost The assetCost to set.
	 */
	public void setAssetCost(String assetCost) {
		this.assetCost = assetCost;
	}
	/**
	 * @return Returns the assetStatus.
	 */
	public String getAssetStatus() {
		return assetStatus;
	}
	/**
	 * @param assetStatus The assetStatus to set.
	 */
	public void setAssetStatus(String assetStatus) {
		this.assetStatus = assetStatus;
	}
	/**
	 * @return Returns the endYear.
	 */
	public String getEndYear() {
		return endYear;
	}
	/**
	 * @param endYear The endYear to set.
	 */
	public void setEndYear(String endYear) {
		this.endYear = endYear;
	}
	/**
	 * @return Returns the location.
	 */
	public String getLocation() {
		return location;
	}
	/**
	 * @param location The location to set.
	 */
	public void setLocation(String location) {
		this.location = location;
	}
	/**
	 * @return Returns the startYear.
	 */
	public String getStartYear() {
		return startYear;
	}
	
	/**
	 * @return Returns the sourceCode.
	 */
	public String getSourceCode() {
		return sourceCode;
	}
	/**
	 * @param sourceCode The sourceCode to set.
	 */
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}
	
	/**
	 * @return Returns the habName.
	 */
	public String getHabName() {
		return habName;
	}
	/**
	 * @param habName The habName to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
	}
	/**
	 * @return Returns the sourceName.
	 */
	public String getSourceName() {
		return sourceName;
	}
	/**
	 * @param sourceName The sourceName to set.
	 */
	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}
	/**
	 * @param startYear The startYear to set.
	 */
	public void setStartYear(String startYear) {
		this.startYear = startYear;
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
	/**
	 * @return Returns the subdivisionOfficeCode.
	 */
	public String getSubdivisionOfficeCode() {
		return subdivisionOfficeCode;
	}
	/**
	 * @param subdivisionOfficeCode The subdivisionOfficeCode to set.
	 */
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
		this.subdivisionOfficeCode = subdivisionOfficeCode;
	}
	/**
	 * @return Returns the dateCreation.
	 */
	public String getDateCreation() {
		return dateCreation;
	}
	/**
	 * @param dateCreation The dateCreation to set.
	 */
	public void setDateCreation(String dateCreation) {
		this.dateCreation = dateCreation;
	}
	/**
	 * @return Returns the habCode.
	 */
	public String getHabCode() {
		return habCode;
	}
	/**
	 * @param habCode The habCode to set.
	 */
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	/**
	 * @return Returns the typeOfAssetCode.
	 */
	public String getTypeOfAssetCode() {
		return typeOfAssetCode;
	}
	/**
	 * @param typeOfAssetCode The typeOfAssetCode to set.
	 */
	public void setTypeOfAssetCode(String typeOfAssetCode) {
		this.typeOfAssetCode = typeOfAssetCode;
	}
	public String getCircle() {
		return circle;
	}
	public void setCircle(String circle) {
		this.circle = circle;
	}
	public ArrayList getCircleList() {
		return circleList;
	}
	public void setCircleList(ArrayList circleList) {
		this.circleList = circleList;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public ArrayList getDivisionList() {
		return divisionList;
	}
	public void setDivisionList(ArrayList divisionList) {
		this.divisionList = divisionList;
	}
	public String getSubDivision() {
		return subDivision;
	}
	public void setSubDivision(String subDivision) {
		this.subDivision = subDivision;
	}
	public ArrayList getSubDivisionList() {
		return subDivisionList;
	}
	public void setSubDivisionList(ArrayList subDivisionList) {
		this.subDivisionList = subDivisionList;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getForSubDate() {
		return forSubDate;
	}
	public void setForSubDate(String forSubDate) {
		this.forSubDate = forSubDate;
	}
	public String getLetterMemoNo() {
		return letterMemoNo;
	}
	public void setLetterMemoNo(String letterMemoNo) {
		this.letterMemoNo = letterMemoNo;
	}
	public String getPreparedBy() {
		return preparedBy;
	}
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	public String getPreparedOn() {
		return preparedOn;
	}
	public void setPreparedOn(String preparedOn) {
		this.preparedOn = preparedOn;
	}
	public String getRef() {
		return ref;
	}
	public void setRef(String ref) {
		this.ref = ref;
	}
	public String getSpillOver() {
		return spillOver;
	}
	public void setSpillOver(String spillOver) {
		this.spillOver = spillOver;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getRevNoOfHabs() {
		return revNoOfHabs;
	}
	public void setRevNoOfHabs(String revNoOfHabs) {
		this.revNoOfHabs = revNoOfHabs;
	}
	public String getRevAdminDate() {
		return revAdminDate;
	}
	public void setRevAdminDate(String revAdminDate) {
		this.revAdminDate = revAdminDate;
	}
	public String getRevAdminNo() {
		return revAdminNo;
	}
	public void setRevAdminNo(String revAdminNo) {
		this.revAdminNo = revAdminNo;
	}
	public String getRevSanctionedAmount() {
		return revSanctionedAmount;
	}
	public void setRevSanctionedAmount(String revSanctionedAmount) {
		this.revSanctionedAmount = revSanctionedAmount;
	}
	public String getFcCountAdm() {
		return fcCountAdm;
	}
	public void setFcCountAdm(String fcCountAdm) {
		this.fcCountAdm = fcCountAdm;
	}
	public String getFcCountRev() {
		return fcCountRev;
	}
	public void setFcCountRev(String fcCountRev) {
		this.fcCountRev = fcCountRev;
	}
	public String getFcCountTec() {
		return fcCountTec;
	}
	public void setFcCountTec(String fcCountTec) {
		this.fcCountTec = fcCountTec;
	}
	public String getFcCountTeRev() {
		return fcCountTeRev;
	}
	public void setFcCountTeRev(String fcCountTeRev) {
		this.fcCountTeRev = fcCountTeRev;
	}
	public String getMandalsCout() {
		return mandalsCout;
	}
	public void setMandalsCout(String mandalsCout) {
		this.mandalsCout = mandalsCout;
	}
	public String getNcCountAdm() {
		return ncCountAdm;
	}
	public void setNcCountAdm(String ncCountAdm) {
		this.ncCountAdm = ncCountAdm;
	}
	public String getNcCountRev() {
		return ncCountRev;
	}
	public void setNcCountRev(String ncCountRev) {
		this.ncCountRev = ncCountRev;
	}
	public String getNcCountTec() {
		return ncCountTec;
	}
	public void setNcCountTec(String ncCountTec) {
		this.ncCountTec = ncCountTec;
	}
	public String getNcCountTeRev() {
		return ncCountTeRev;
	}
	public void setNcCountTeRev(String ncCountTeRev) {
		this.ncCountTeRev = ncCountTeRev;
	}
	public String getNoOfRevhHabs() {
		return noOfRevhHabs;
	}
	public void setNoOfRevhHabs(String noOfRevhHabs) {
		this.noOfRevhHabs = noOfRevhHabs;
	}
	public String getNoOfTechHabs() {
		return noOfTechHabs;
	}
	public void setNoOfTechHabs(String noOfTechHabs) {
		this.noOfTechHabs = noOfTechHabs;
	}
	public String getPc1CountAdm() {
		return pc1CountAdm;
	}
	public void setPc1CountAdm(String pc1CountAdm) {
		this.pc1CountAdm = pc1CountAdm;
	}
	public String getPc1CountRev() {
		return pc1CountRev;
	}
	public void setPc1CountRev(String pc1CountRev) {
		this.pc1CountRev = pc1CountRev;
	}
	public String getPc1CountTec() {
		return pc1CountTec;
	}
	public void setPc1CountTec(String pc1CountTec) {
		this.pc1CountTec = pc1CountTec;
	}
	public String getPc1CountTeRev() {
		return pc1CountTeRev;
	}
	public void setPc1CountTeRev(String pc1CountTeRev) {
		this.pc1CountTeRev = pc1CountTeRev;
	}
	public String getPc2CountAdm() {
		return pc2CountAdm;
	}
	public void setPc2CountAdm(String pc2CountAdm) {
		this.pc2CountAdm = pc2CountAdm;
	}
	public String getPc2CountRev() {
		return pc2CountRev;
	}
	public void setPc2CountRev(String pc2CountRev) {
		this.pc2CountRev = pc2CountRev;
	}
	public String getPc2CountTec() {
		return pc2CountTec;
	}
	public void setPc2CountTec(String pc2CountTec) {
		this.pc2CountTec = pc2CountTec;
	}
	public String getPc2CountTeRev() {
		return pc2CountTeRev;
	}
	public void setPc2CountTeRev(String pc2CountTeRev) {
		this.pc2CountTeRev = pc2CountTeRev;
	}
	public String getPc3CountAdm() {
		return pc3CountAdm;
	}
	public void setPc3CountAdm(String pc3CountAdm) {
		this.pc3CountAdm = pc3CountAdm;
	}
	public String getPc3CountRev() {
		return pc3CountRev;
	}
	public void setPc3CountRev(String pc3CountRev) {
		this.pc3CountRev = pc3CountRev;
	}
	public String getPc3CountTec() {
		return pc3CountTec;
	}
	public void setPc3CountTec(String pc3CountTec) {
		this.pc3CountTec = pc3CountTec;
	}
	public String getPc3CountTeRev() {
		return pc3CountTeRev;
	}
	public void setPc3CountTeRev(String pc3CountTeRev) {
		this.pc3CountTeRev = pc3CountTeRev;
	}
	public String getPc4CountAdm() {
		return pc4CountAdm;
	}
	public void setPc4CountAdm(String pc4CountAdm) {
		this.pc4CountAdm = pc4CountAdm;
	}
	public String getPc4CountRev() {
		return pc4CountRev;
	}
	public void setPc4CountRev(String pc4CountRev) {
		this.pc4CountRev = pc4CountRev;
	}
	public String getPc4CountTec() {
		return pc4CountTec;
	}
	public void setPc4CountTec(String pc4CountTec) {
		this.pc4CountTec = pc4CountTec;
	}
	public String getPc4CountTeRev() {
		return pc4CountTeRev;
	}
	public void setPc4CountTeRev(String pc4CountTeRev) {
		this.pc4CountTeRev = pc4CountTeRev;
	}
	public String getTenAggrDate() {
		return tenAggrDate;
	}
	public void setTenAggrDate(String tenAggrDate) {
		this.tenAggrDate = tenAggrDate;
	}
	public String getTenAppvOn() {
		return tenAppvOn;
	}
	public void setTenAppvOn(String tenAppvOn) {
		this.tenAppvOn = tenAppvOn;
	}
	public String getTenCommitte() {
		return tenCommitte;
	}
	public void setTenCommitte(String tenCommitte) {
		this.tenCommitte = tenCommitte;
	}
	public String getTenCompeAu() {
		return tenCompeAu;
	}
	public void setTenCompeAu(String tenCompeAu) {
		this.tenCompeAu = tenCompeAu;
	}
	public String getTenconAdd1() {
		return tenconAdd1;
	}
	public void setTenconAdd1(String tenconAdd1) {
		this.tenconAdd1 = tenconAdd1;
	}
	public String getTenconAdd2() {
		return tenconAdd2;
	}
	public void setTenconAdd2(String tenconAdd2) {
		this.tenconAdd2 = tenconAdd2;
	}
	public String getTenconAdd3() {
		return tenconAdd3;
	}
	public void setTenconAdd3(String tenconAdd3) {
		this.tenconAdd3 = tenconAdd3;
	}
	public String getTenConName() {
		return tenConName;
	}
	public void setTenConName(String tenConName) {
		this.tenConName = tenConName;
	}
	public String getTenderIssDate() {
		return tenderIssDate;
	}
	public void setTenderIssDate(String tenderIssDate) {
		this.tenderIssDate = tenderIssDate;
	}
	public String getTenderTyp() {
		return tenderTyp;
	}
	public void setTenderTyp(String tenderTyp) {
		this.tenderTyp = tenderTyp;
	}
	public String getTenEngPaper() {
		return tenEngPaper;
	}
	public void setTenEngPaper(String tenEngPaper) {
		this.tenEngPaper = tenEngPaper;
	}
	public String getTenLoaIssOn() {
		return tenLoaIssOn;
	}
	public void setTenLoaIssOn(String tenLoaIssOn) {
		this.tenLoaIssOn = tenLoaIssOn;
	}
	public String getTenRecievedOn() {
		return tenRecievedOn;
	}
	public void setTenRecievedOn(String tenRecievedOn) {
		this.tenRecievedOn = tenRecievedOn;
	}
	public String getTenTelPaper() {
		return tenTelPaper;
	}
	public void setTenTelPaper(String tenTelPaper) {
		this.tenTelPaper = tenTelPaper;
	}
	public String getTsAmount() {
		return tsAmount;
	}
	public void setTsAmount(String tsAmount) {
		this.tsAmount = tsAmount;
	}
	public String getTsRevAmount() {
		return tsRevAmount;
	}
	public void setTsRevAmount(String tsRevAmount) {
		this.tsRevAmount = tsRevAmount;
	}
	public String getVillagesCount() {
		return villagesCount;
	}
	public void setVillagesCount(String villagesCount) {
		this.villagesCount = villagesCount;
	}
	public String getAdmBrackish() {
		return admBrackish;
	}
	public void setAdmBrackish(String admBrackish) {
		this.admBrackish = admBrackish;
	}
	public String getAdmFlouride() {
		return admFlouride;
	}
	public void setAdmFlouride(String admFlouride) {
		this.admFlouride = admFlouride;
	}
	public String getNoOfConst() {
		return noOfConst;
	}
	public void setNoOfConst(String noOfConst) {
		this.noOfConst = noOfConst;
	}
	public String getNoOfRevTeHabs() {
		return noOfRevTeHabs;
	}
	public void setNoOfRevTeHabs(String noOfRevTeHabs) {
		this.noOfRevTeHabs = noOfRevTeHabs;
	}
	public String getQaAdmHabs() {
		return qaAdmHabs;
	}
	public void setQaAdmHabs(String qaAdmHabs) {
		this.qaAdmHabs = qaAdmHabs;
	}
	public String getQaRevTecHabs() {
		return qaRevTecHabs;
	}
	public void setQaRevTecHabs(String qaRevTecHabs) {
		this.qaRevTecHabs = qaRevTecHabs;
	}
	public String getQaTecHabs() {
		return qaTecHabs;
	}
	public void setQaTecHabs(String qaTecHabs) {
		this.qaTecHabs = qaTecHabs;
	}
	public String getRevBrackish() {
		return revBrackish;
	}
	public void setRevBrackish(String revBrackish) {
		this.revBrackish = revBrackish;
	}
	public String getRevFlouride() {
		return revFlouride;
	}
	public void setRevFlouride(String revFlouride) {
		this.revFlouride = revFlouride;
	}
	public String getRevTecBrackish() {
		return revTecBrackish;
	}
	public void setRevTecBrackish(String revTecBrackish) {
		this.revTecBrackish = revTecBrackish;
	}
	public String getRevTecFlouride() {
		return revTecFlouride;
	}
	public void setRevTecFlouride(String revTecFlouride) {
		this.revTecFlouride = revTecFlouride;
	}
	public String getTaRevHabs() {
		return taRevHabs;
	}
	public void setTaRevHabs(String taRevHabs) {
		this.taRevHabs = taRevHabs;
	}
	public String getTecBrackish() {
		return tecBrackish;
	}
	public void setTecBrackish(String tecBrackish) {
		this.tecBrackish = tecBrackish;
	}
	public String getTecFlouride() {
		return tecFlouride;
	}
	public void setTecFlouride(String tecFlouride) {
		this.tecFlouride = tecFlouride;
	}
	public String getQaRevHabs() {
		return qaRevHabs;
	}
	public void setQaRevHabs(String qaRevHabs) {
		this.qaRevHabs = qaRevHabs;
	}
	/**
	 * @return Returns the workCat.
	 */
	public String getWorkCat() {
		return workCat;
	}
	/**
	 * @param workCat The workCat to set.
	 */
	public void setWorkCat(String workCat) {
		this.workCat = workCat;
	}
	/**
	 * @return Returns the wrkType.
	 */
	public String getWrkType() {
		return wrkType;
	}
	/**
	 * @param wrkType The wrkType to set.
	 */
	public void setWrkType(String wrkType) {
		this.wrkType = wrkType;
	}
	/**
	 * @return Returns the plan.
	 */
	public String getPlan() {
		return plan;
	}
	/**
	 * @param plan The plan to set.
	 */
	public void setPlan(String plan) {
		this.plan = plan;
	}
	/**
	 * @return Returns the assignedEngg1.
	 */
	public String getAssignedEngg1() {
		return assignedEngg1;
	}
	/**
	 * @param assignedEngg1 The assignedEngg1 to set.
	 */
	public void setAssignedEngg1(String assignedEngg1) {
		this.assignedEngg1 = assignedEngg1;
	}
	/**
	 * @return Returns the assignedEngg2.
	 */
	public String getAssignedEngg2() {
		return assignedEngg2;
	}
	/**
	 * @param assignedEngg2 The assignedEngg2 to set.
	 */
	public void setAssignedEngg2(String assignedEngg2) {
		this.assignedEngg2 = assignedEngg2;
	}
	/**
	 * @return Returns the assignedEngg3.
	 */
	public String getAssignedEngg3() {
		return assignedEngg3;
	}
	/**
	 * @param assignedEngg3 The assignedEngg3 to set.
	 */
	public void setAssignedEngg3(String assignedEngg3) {
		this.assignedEngg3 = assignedEngg3;
	}
	/**
	 * @return Returns the assignedEngg4.
	 */
	public String getAssignedEngg4() {
		return assignedEngg4;
	}
	/**
	 * @param assignedEngg4 The assignedEngg4 to set.
	 */
	public void setAssignedEngg4(String assignedEngg4) {
		this.assignedEngg4 = assignedEngg4;
	}
	/**
	 * @return Returns the assignedSubdivision.
	 */
	public String getAssignedSubdivision() {
		return assignedSubdivision;
	}
	/**
	 * @param assignedSubdivision The assignedSubdivision to set.
	 */
	public void setAssignedSubdivision(String assignedSubdivision) {
		this.assignedSubdivision = assignedSubdivision;
	}
	/**
	 * @return Returns the dateOfCommmisioning.
	 */
	public String getDateOfCommmisioning() {
		return dateOfCommmisioning;
	}
	/**
	 * @param dateOfCommmisioning The dateOfCommmisioning to set.
	 */
	public void setDateOfCommmisioning(String dateOfCommmisioning) {
		this.dateOfCommmisioning = dateOfCommmisioning;
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
	 * @return Returns the expUptoPreYear.
	 */
	public String getExpUptoPreYear() {
		return expUptoPreYear;
	}
	/**
	 * @param expUptoPreYear The expUptoPreYear to set.
	 */
	public void setExpUptoPreYear(String expUptoPreYear) {
		this.expUptoPreYear = expUptoPreYear;
	}
	/**
	 * @return Returns the programWiseExp.
	 */
	public String getProgramWiseExp() {
		return programWiseExp;
	}
	/**
	 * @param programWiseExp The programWiseExp to set.
	 */
	public void setProgramWiseExp(String programWiseExp) {
		this.programWiseExp = programWiseExp;
	}
	/**
	 * @return Returns the siteHandingOverDate.
	 */
	public String getSiteHandingOverDate() {
		return siteHandingOverDate;
	}
	/**
	 * @param siteHandingOverDate The siteHandingOverDate to set.
	 */
	public void setSiteHandingOverDate(String siteHandingOverDate) {
		this.siteHandingOverDate = siteHandingOverDate;
	}
	/**
	 * @return Returns the totExpenditure.
	 */
	public int getTotExpenditure() {
		return totExpenditure;
	}
	/**
	 * @param totExpenditure The totExpenditure to set.
	 */
	public void setTotExpenditure(int totExpenditure) {
		this.totExpenditure = totExpenditure;
	}
	/**
	 * @return Returns the workStartDate.
	 */
	public String getWorkStartDate() {
		return workStartDate;
	}
	/**
	 * @param workStartDate The workStartDate to set.
	 */
	public void setWorkStartDate(String workStartDate) {
		this.workStartDate = workStartDate;
	}
	/**
	 * @return Returns the yearMonth.
	 */
	public String getYearMonth() {
		return yearMonth;
	}
	/**
	 * @param yearMonth The yearMonth to set.
	 */
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public String getNoOfLabs() {
		return noOfLabs;
	}
	public void setNoOfLabs(String noOfLabs) {
		this.noOfLabs = noOfLabs;
	}
	public String getNoOfOffices() {
		return noOfOffices;
	}
	public void setNoOfOffices(String noOfOffices) {
		this.noOfOffices = noOfOffices;
	}
public String getNoOfSchools() {
	return noOfSchools;
}
public void setNoOfSchools(String noOfSchools) {
	this.noOfSchools = noOfSchools;
}
public String getCoreDashboardStatus() {
	return coreDashboardStatus;
}
public void setCoreDashboardStatus(String coreDashboardStatus) {
	this.coreDashboardStatus = coreDashboardStatus;
}
public String getApprooved() {
	return approoved;
}
public void setApprooved(String approoved) {
	this.approoved = approoved;
}
public String getPhysicalSatus() {
	return physicalSatus;
}
public void setPhysicalSatus(String physicalSatus) {
	this.physicalSatus = physicalSatus;
}


}
