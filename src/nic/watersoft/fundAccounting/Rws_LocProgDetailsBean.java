/*
 * Created on Aug 10, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import java.io.Serializable;
import java.util.ArrayList;

import nic.watersoft.commons.Debug;
/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_LocProgDetailsBean implements Serializable{
	
	String locId;
	String circleLocId;
	String district;
	String districtName;
	String program;
	String programName;
	String subprogram;
	String subprogramName;
	String locAmount;
	String office;
	String officeFrom;
	String place;
	String paoApaoFlag;
	String remarks;
	String headOfAccount;
	String headOfAccountName;
	String locDate;
	String project;
	String workDesc;
	String workId;
	String workName;
	String broId;
	
	ArrayList subProgrammesList;
	ArrayList officeList;
	ArrayList workIdList;
	ArrayList paoList;
	String paoName;
	//ArrayList paoList;

	
	Rws_LocProgDetailsBean()
	{
		ArrayList emptyList=new ArrayList(0);
		subProgrammesList=emptyList;
		officeList=emptyList;
		workIdList=emptyList;
		
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getLocAmount() {
		return locAmount;
	}
	public void setLocAmount(String locAmount) {
		this.locAmount = locAmount;
	}
	public String getOffice() {
		return office;
	}
	public void setOffice(String office) {
		this.office = office;
	}
	public String getPaoApaoFlag() {
		return paoApaoFlag;
	}
	public void setPaoApaoFlag(String paoApaoFlag) {
		this.paoApaoFlag = paoApaoFlag;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getProgram() {
		return program;
	}
	public void setProgram(String program) {
		this.program = program;
	}
	
	public String getSubprogram() {
		return subprogram;
	}
	public void setSubprogram(String subprogram) {
		this.subprogram = subprogram;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public ArrayList getSubProgrammesList() {
		return subProgrammesList;
	}
	public void setSubProgrammesList(ArrayList subProgrammesList) {
		this.subProgrammesList = subProgrammesList;
	}
	public String getLocId() {
		return locId;
	}
	public void setLocId(String locId) {
		this.locId = locId;
	}
	public String getProgramName() {
		return programName;
	}
	public void setProgramName(String programName) {
		this.programName = programName;
	}
	public String getSubprogramName() {
		return subprogramName;
	}
	public void setSubprogramName(String subprogramName) {
		this.subprogramName = subprogramName;
	}
	public String getHeadOfAccount() {
		return headOfAccount;
	}
	public void setHeadOfAccount(String headOfAccount) {
		this.headOfAccount = headOfAccount;
	}
	public String getLocDate() {
		return locDate;
	}
	public void setLocDate(String locDate) {
		this.locDate = locDate;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getHeadOfAccountName() {
		return headOfAccountName;
	}
	public void setHeadOfAccountName(String headOfAccountName) {
		this.headOfAccountName = headOfAccountName;
	}
	public ArrayList getOfficeList() {
		return officeList;
	}
	public void setOfficeList(ArrayList officeList) {
		this.officeList = officeList;
	}
	public String getProject() {
		return project;
	}
	public void setProject(String project) {
		this.project = project;
	}
	public String getOfficeFrom() {
		return officeFrom;
	}
	public void setOfficeFrom(String officeFrom) {
		this.officeFrom = officeFrom;
	}
	public String getWorkDesc() {
		return workDesc;
	}
	public void setWorkDesc(String workDesc) {
		this.workDesc = workDesc;
	}
	public String getWorkId() {
		return workId;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public ArrayList getWorkIdList() {
		return workIdList;
	}
	public void setWorkIdList(ArrayList workIdList) {
		this.workIdList = workIdList;
	}
	public String getWorkName() {
		return workName;
	}
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	public String getCircleLocId() {
		return circleLocId;
	}
	public void setCircleLocId(String circleLocId) {
		this.circleLocId = circleLocId;
	}
    /**
     * @return Returns the paoList.
     */
    public ArrayList getPaoList() {
        return paoList;
    }
    /**
     * @param paoList The paoList to set.
     */
    public void setPaoList(ArrayList paoList) {
        //Debug.println("IN set PaoList "+paoList.get(0));
        this.paoList = paoList;
        
    }
    /**
     * @return Returns the paoName.
     */
    public String getPaoName() {
        return paoName;
    }
    /**
     * @param paoName The paoName to set.
     */
    public void setPaoName(String paoName) {
        this.paoName = paoName;
    }
    
	/**
	 * @return Returns the broId.
	 */
	public String getBroId() {
		return broId;
	}
	/**
	 * @param broId The broId to set.
	 */
	public void setBroId(String broId) {
		this.broId = broId;
	}
}
