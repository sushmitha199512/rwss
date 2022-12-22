/*
 * Created on 22-03-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.io.Serializable;

import org.apache.struts.action.ActionForm;

/**
 * @author RWSS_DPT1(Sai Prasad N)
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class RwsHabsEntryActionBean extends ActionForm implements Serializable {

	String workId;

	String workName;

	String programName;

	String sanctionedDate;

	String tsNo;

	String tsDate;

	String tsAmount;

	String sanctionedHabs;

	String techHabs;

	String phisicalDate;

	String financialDate;

	String partialDate;

	String coveredHabs;

	String isTechSancationed;

	String isCompletion;
	String isAdmnSanction;
	
	String typeOfWork;
	String ccode;
	String officecode;
	String cname;
	String divcode;
	String divname;
	String subdivcode;
	String subdivname;
	
	//boolean ishavesubdivcode;
	

	public String getCcode() {
		return ccode;
	}
	public void setCcode(String ccode) {
		this.ccode = ccode;
	}
	public String getOfficecode() {
		return officecode;
	}
	public void setOfficecode(String officecode) {
		this.officecode = officecode;
	}
	public String getCname() {
		return cname;
	}
	public void setCname(String cname) {
		this.cname = cname;
	}
	public String getDivcode() {
		return divcode;
	}
	public void setDivcode(String divcode) {
		this.divcode = divcode;
	}
	public String getDivname() {
		return divname;
	}
	public void setDivname(String divname) {
		this.divname = divname;
	}
	public String getSubdivcode() {
		return subdivcode;
	}
	public void setSubdivcode(String subdivcode) {
		this.subdivcode = subdivcode;
	}
	public String getSubdivname() {
		return subdivname;
	}
	public void setSubdivname(String subdivname) {
		this.subdivname = subdivname;
	}
	/*public boolean isIshavesubdivcode() {
		return ishavesubdivcode;
	}
	public void setIshavesubdivcode(boolean ishavesubdivcode) {
		this.ishavesubdivcode = ishavesubdivcode;
	}*/
	/**
	 * @return Returns the typeOfWork.
	 */
	public String getTypeOfWork() {
		return typeOfWork;
	}
	/**
	 * @param typeOfWork The typeOfWork to set.
	 */
	public void setTypeOfWork(String typeOfWork) {
		this.typeOfWork = typeOfWork;
	}
	/**
	 * @return Returns the isAdmnSanction.
	 */
	public String getIsAdmnSanction() {
		return isAdmnSanction;
	}
	/**
	 * @param isAdmnSanction The isAdmnSanction to set.
	 */
	public void setIsAdmnSanction(String isAdmnSanction) {
		this.isAdmnSanction = isAdmnSanction;
	}
	/**
	 * @return Returns the isCompletion.
	 */
	public String getIsCompletion() {
		return isCompletion;
	}
	/**
	 * @param isCompletion The isCompletion to set.
	 */
	public void setIsCompletion(String isCompletion) {
		this.isCompletion = isCompletion;
	}
	/**
	 * @return Returns the isTechSancationed.
	 */
	public String getIsTechSancationed() {
		return isTechSancationed;
	}
	/**
	 * @param isTechSancationed The isTechSancationed to set.
	 */
	public void setIsTechSancationed(String isTechSancationed) {
		this.isTechSancationed = isTechSancationed;
	}
	/**
	 * @return Returns the coveredHabs.
	 */
	public String getCoveredHabs() {
		return coveredHabs;
	}

	/**
	 * @param coveredHabs
	 *            The coveredHabs to set.
	 */
	public void setCoveredHabs(String coveredHabs) {
		this.coveredHabs = coveredHabs;
	}

	/**
	 * @return Returns the financialDate.
	 */
	public String getFinancialDate() {
		return financialDate;
	}

	/**
	 * @param financialDate
	 *            The financialDate to set.
	 */
	public void setFinancialDate(String financialDate) {
		this.financialDate = financialDate;
	}

	/**
	 * @return Returns the partialDate.
	 */
	public String getPartialDate() {
		return partialDate;
	}

	/**
	 * @param partialDate
	 *            The partialDate to set.
	 */
	public void setPartialDate(String partialDate) {
		this.partialDate = partialDate;
	}

	/**
	 * @return Returns the phisicalDate.
	 */
	public String getPhisicalDate() {
		return phisicalDate;
	}

	/**
	 * @param phisicalDate
	 *            The phisicalDate to set.
	 */
	public void setPhisicalDate(String phisicalDate) {
		this.phisicalDate = phisicalDate;
	}

	/**
	 * @return Returns the techHabs.
	 */
	public String getTechHabs() {
		return techHabs;
	}

	/**
	 * @param techHabs
	 *            The techHabs to set.
	 */
	public void setTechHabs(String techHabs) {
		this.techHabs = techHabs;
	}

	/**
	 * @return Returns the tsAmount.
	 */
	public String getTsAmount() {
		return tsAmount;
	}

	/**
	 * @param tsAmount
	 *            The tsAmount to set.
	 */
	public void setTsAmount(String tsAmount) {
		this.tsAmount = tsAmount;
	}

	/**
	 * @return Returns the tsDate.
	 */
	public String getTsDate() {
		return tsDate;
	}

	/**
	 * @param tsDate
	 *            The tsDate to set.
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
	 * @param tsNo
	 *            The tsNo to set.
	 */
	public void setTsNo(String tsNo) {
		this.tsNo = tsNo;
	}

	/**
	 * @return Returns the programName.
	 */
	public String getProgramName() {
		return programName;
	}

	/**
	 * @param programName
	 *            The programName to set.
	 */
	public void setProgramName(String programName) {
		this.programName = programName;
	}

	/**
	 * @return Returns the sanctionedAmount.
	 */
	public String getSanctionedAmount() {
		return sanctionedAmount;
	}

	/**
	 * @param sanctionedAmount
	 *            The sanctionedAmount to set.
	 */
	public void setSanctionedAmount(String sanctionedAmount) {
		this.sanctionedAmount = sanctionedAmount;
	}

	/**
	 * @return Returns the sanctionedDate.
	 */
	public String getSanctionedDate() {
		return sanctionedDate;
	}

	/**
	 * @param sanctionedDate
	 *            The sanctionedDate to set.
	 */
	public void setSanctionedDate(String sanctionedDate) {
		this.sanctionedDate = sanctionedDate;
	}

	/**
	 * @return Returns the subProgName.
	 */
	public String getSubProgName() {
		return subProgName;
	}

	/**
	 * @param subProgName
	 *            The subProgName to set.
	 */
	public void setSubProgName(String subProgName) {
		this.subProgName = subProgName;
	}

	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}

	/**
	 * @param workId
	 *            The workId to set.
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
	 * @param workName
	 *            The workName to set.
	 */
	public void setWorkName(String workName) {
		this.workName = workName;
	}

	String sanctionedAmount;

	String subProgName;

	/**
	 * @return Returns the sanctionedHabs.
	 */
	public String getSanctionedHabs() {
		return sanctionedHabs;
	}

	/**
	 * @param sanctionedHabs
	 *            The sanctionedHabs to set.
	 */
	public void setSanctionedHabs(String sanctionedHabs) {
		this.sanctionedHabs = sanctionedHabs;
	}
}