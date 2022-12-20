package nic.watersoft.masters;
import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

public class ProposalVO extends ActionForm
{
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
	private String programmeName;
	private String subprogrammeCode;
	private String subprogrammeName;
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
	private String assetName;
	
	private String memoNo;
	private String ref;
	private String subject;
	private String content;
	
	private String forwardTo;
	private String forwardOffice;
	private String submitTo;
	private String submitOffice;
	
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


	private FormFile lineEstimate;
	private FormFile budjetEstimate;

	
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
	
	
	// Accessors for memoNo property
	public void setMemoNo(String memoNo)
	{	this.memoNo = memoNo;
	}
	public String getMemoNo()
	{	return memoNo;
	}
	
	// Accessors for ref property
	public void setRef(String ref)
	{	this.ref = ref;
	}
	public String getRef()
	{	return  ref;
	}
	
	// Accessors for subject property
	public void setSubject(String subject)
	{	this.subject = subject; 
	}
	public String getSubject()
	{	return subject;
	}
	
	// Accessors for content property
	public void setContent(String content)
	{	this.content = content;
	}
	public String getContent()
	{	return content; 
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
}
