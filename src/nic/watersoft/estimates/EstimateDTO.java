package nic.watersoft.estimates;

import java.util.ArrayList;

import nic.watersoft.commons.BaseDTO;

public class EstimateDTO extends BaseDTO
{
	private String assetType;
	private String assetTypeCode;
	private String workId;
	private String workName;
	private String sourceType;
	private String subsourceType;
	private String sourceCode;
	private String financialYear;
	private String totalComponents;
	private String estimateAmount;
	private String sanctionedAmount;
	private String tsOffice;
	private String tsGivenBy;
	private String tsEndtNo;
	private String tsEndtDate;
	private String tsAmount;
	private String ssrYear; 
	private boolean allowed;
	private String remarks;
	private String preparedBy;
	private String preparedOn;
	private String manpowerCharges;
	private String powerCharges;
	private String consumables;
	private String repairs;
	private String others;
	private String submitTo;
	private String submitOffice;
	private String forwardTo;
	private String forwardOffice;
	
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
	private String flag;
	
	private String message;

	private ArrayList components;

	public void setAssetType(String assetType)
	{	this.assetType = assetType;
	}
	public String getAssetType()
	{	return assetType;
	}
	
	public void setAssetTypeCode(String assetTypeCode)
	{	this.assetTypeCode = assetTypeCode;
	}
	public String getAssetTypeCode()
	{	return assetTypeCode;
	}

	public void setWorkId(String workId)
	{	this.workId = workId;
	}
	public String getWorkId()
	{	return workId;
	}
	
	public void setWorkName(String workName)
	{	this.workName = workName;
	}
	public String getWorkName()
	{	return workName;
	}
	
	public void setSourceType(String sourceType)
	{	this.sourceType = sourceType;
	}
	public String getSourceType()
	{	return sourceType;
	}

	public void setSubsourceType(String subsourceType)
	{	this.subsourceType = subsourceType;
	}
	
	public String getSubsourceType()
	{	return subsourceType;
	}

	public void setSourceCode(String sourceCode)
	{	this.sourceCode = sourceCode;
	}
	public String getSourceCode()
	{	return sourceCode;	
	}
	
	public void setFinancialYear(String financialYear)
	{	this.financialYear = financialYear;
	}
	public String getFinancialYear()
	{	return financialYear;	
	}
	
	public void setTotalComponents(String totalComponents)
	{	this.totalComponents = totalComponents;
	}
	public String getTotalComponents()
	{	return totalComponents;	
	}
	
	public void setEstimateAmount(String estimateAmount)
	{	this.estimateAmount = estimateAmount;
	}
	public String getEstimateAmount()
	{	return estimateAmount;
	}
	
	public void setSanctionedAmount(String sanctionedAmount)
	{	this.sanctionedAmount = sanctionedAmount;
	}
	public String getSanctionedAmount()
	{	return sanctionedAmount;
	}
	
	public void setTsOffice(String tsOffice)
	{	this.tsOffice = tsOffice;	
	}
	public String getTsOffice()
	{	return tsOffice;
	}
	
	public void setTsGivenBy(String tsGivenBy)
	{	this.tsGivenBy = tsGivenBy;
	}
	public String getTsGivenBy()
	{	return tsGivenBy;
	}
	
	public void setTsEndtNo(String tsEndtNo)
	{	this.tsEndtNo = tsEndtNo;
	}
	public String getTsEndtNo()
	{	return tsEndtNo;
	}
	
	public void setTsEndtDate(String tsEndtDate)
	{	this.tsEndtDate = tsEndtDate;
	}
	public String getTsEndtDate()
	{	return tsEndtDate;
	}
	
	public void setTsAmount(String tsAmount)
	{	this.tsAmount = tsAmount;		
	}
	public String getTsAmount()
	{	return tsAmount; 
	}
	
	public void setSsrYear(String ssrYear)
	{	this.ssrYear = ssrYear;
	}
	public String getSsrYear()
	{	return ssrYear;
	}
	
	public void setAllowed(boolean allowed)
	{	this.allowed = allowed;
	}
	public boolean isAllowed()
	{	return allowed;
	}

	public void setRemarks(String remarks)
	{	this.remarks = remarks;
	}
	public String getRemarks()
	{	return remarks;
	}
	
	public void setPreparedBy(String preparedBy)
	{	this.preparedBy = preparedBy;
	}
	public String getPreparedBy()
	{	return preparedBy;
	}
	
	public void setPreparedOn(String preparedOn)
	{	this.preparedOn = preparedOn;
	}
	public String getPreparedOn()
	{	return preparedOn;
	}

	public void setManpowerCharges(String manpowerCharges)
	{	this.manpowerCharges = manpowerCharges;
	}			   
	public String getManpowerCharges()
	{	return manpowerCharges;
	}			   
				   
	public void setPowerCharges(String powerCharges)
	{	this.powerCharges = powerCharges;
	}			   
	public String getPowerCharges()
	{	return powerCharges;
	}			   
				   
	public void setConsumables(String consumables)
	{	this.consumables = consumables;
	}			   
	public String getConsumables()
	{	return consumables;
	}			   
				   
	public void setRepairs(String repairs)
	{	this.repairs = repairs;
	}			   
	public String getRepairs()
	{	return repairs;
	}			   
				   
	public void setOthers(String others)
	{	this.others = others;
	}			   
	public String getOthers()
	{	return others;
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
	
	public void setForwardTo(String forwardTo)
	{	this.forwardTo = forwardTo;
	}
	public String getForwardTo()
	{	return forwardTo; 
	}
		
	public void setForwardOffice(String forwardOffice)
	{	this.forwardOffice = forwardOffice;
	}
	public String getForwardOffice()
	{	return forwardOffice; 
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
	
	public void setFlag(String flag)
	{	this.flag = flag;		
	}
	public String getFlag()
	{	return flag;		
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
	
	public void setComponents(ArrayList components)
	{	this.components = components;
	}
	public ArrayList getComponents()
	{	return components;
	}
	
	public EstimateHolder getCOMPONENT(int index) 
	{	
		while(index >= components.size())
		{
			components.add(new EstimateHolder());
		}
		return (EstimateHolder)components.get(index);
	}
}