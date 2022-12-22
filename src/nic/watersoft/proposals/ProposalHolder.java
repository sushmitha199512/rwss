package nic.watersoft.proposals;

import java.io.Serializable;
import java.util.ArrayList;
public class ProposalHolder implements Serializable
{
	
//	added by swapna on 06-04-2011 for adding the no.of schools and labs
	private String noOfSchools;
	private String noOfLabs;
	private String noOfOffices;
	//
	private String proposalId;
	private String proposalName;
	private String noOfHabs;
	private String typeOfAsset;
	private String programmeCode;
	private String programmeName;
	private String subprogrammeCode;
	private String subProgrammeName;
	private String priorityCode;
	private String estimateCost;
	private String remarks;
	private String augmentation;
	private String workId;
    private String workName;
	private	ArrayList subprogrammes;
	
	private String sanctionAmout;
	private String adminiStrativeNum;
	private String adminiStrativeDate;
	private String spillOver;
	private String revAdminDate;
	
	/*
	 * @author MANOJ
	 */
	private String workCat;
	
	/*
	 * ramesh added
	 */
	private String augsch;
	private String prooved;
	private String coreDashboardStatus;
	private String approoved;
	
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
	public String getRevNoOfHabs() {
		return revNoOfHabs;
	}
	public void setRevNoOfHabs(String revNoOfHabs) {
		this.revNoOfHabs = revNoOfHabs;
	}
    private String revNoOfHabs;
	
	private String revisedSanctionAmout;
	private String revisedAdminiStrativeNum;
	private String revisedAdminiStrativeDate;

	public ProposalHolder()
	{		
	}

	public ProposalHolder(String proposalId)
	{
		this.proposalId = proposalId;
	}

	public void setProposalId(String proposalId)
	{	this.proposalId = proposalId;
	}
	public String getProposalId()
	{	return proposalId;
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

	public void setRemarks(String remarks)
	{	this.remarks = remarks;
	}
	public String getRemarks()
	{	return remarks;
	}
	public void setAugmentation(String augmentation)
	{	this.augmentation = augmentation;
	}
	public String getAugmentation()
	{	return augmentation;
	}

	public void setSubprogrammes(ArrayList subprogrammes)
	{	this.subprogrammes = subprogrammes;
	}
	public ArrayList getSubprogrammes()
	{	return subprogrammes;
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
	public String getAdminiStrativeDate() {
		return adminiStrativeDate;
	}
	public void setAdminiStrativeDate(String adminiStrativeDate) {
		this.adminiStrativeDate = adminiStrativeDate;
	}
	public String getAdminiStrativeNum() {
		return adminiStrativeNum;
	}
	public void setAdminiStrativeNum(String adminiStrativeNum) {
		this.adminiStrativeNum = adminiStrativeNum;
	}
	public String getRevisedAdminiStrativeDate() {
		return revisedAdminiStrativeDate;
	}
	public void setRevisedAdminiStrativeDate(String revisedAdminiStrativeDate) {
		this.revisedAdminiStrativeDate = revisedAdminiStrativeDate;
	}
	public String getRevisedAdminiStrativeNum() {
		return revisedAdminiStrativeNum;
	}
	public void setRevisedAdminiStrativeNum(String revisedAdminiStrativeNum) {
		this.revisedAdminiStrativeNum = revisedAdminiStrativeNum;
	}
	public String getRevisedSanctionAmout() {
		return revisedSanctionAmout;
	}
	public void setRevisedSanctionAmout(String revisedSanctionAmout) {
		this.revisedSanctionAmout = revisedSanctionAmout;
	}
	public String getSanctionAmout() {
		return sanctionAmout;
	}
	public void setSanctionAmout(String sanctionAmout) {
		this.sanctionAmout = sanctionAmout;
	}
	public String getSpillOver() {
		return spillOver;
	}
	public void setSpillOver(String spillOver) {
		this.spillOver = spillOver;
	}
	public String getWorkName() {
		return workName;
	}
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	public String getRevAdminDate() {
		return revAdminDate;
	}
	public void setRevAdminDate(String revAdminDate) {
		this.revAdminDate = revAdminDate;
	}
	public String getProgrammeName() {
		return programmeName;
	}
	public void setProgrammeName(String programmeName) {
		this.programmeName = programmeName;
	}
	public String getSubProgrammeName() {
		return subProgrammeName;
	}
	public void setSubProgrammeName(String subProgrammeName) {
		this.subProgrammeName = subProgrammeName;
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

}
