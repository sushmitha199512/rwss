/*
 * Created on 29-05-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * @author RWSS_DPT1
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsContratorWorkBindBean extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList contractorList = new ArrayList();

	private ArrayList allContractorsList = new ArrayList();

	private String ccode;
	private String circle;

	private String division;

	private ArrayList authList;

	private String contractorId;

	private String contractorName;

	private String bankIFSC;

	private String contractorACC;

	private String bank;

	private String audhendication;

	private String circleCode;

	private String divName;

	private int divCode;

	private String workIdList;

	private String subDivCode;

	private String subDivName;

	private String workName;

	private String subProgName;

	private String subProgCode;

	private int cmbDivision;

	String programCode;

	String program;

	String finYear;
	
	

	public String getCircle() {
		return circle;
	}

	public void setCircle(String circle) {
		this.circle = circle;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getCcode() {
		return ccode;
	}

	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

	public ArrayList getAllContractorsList() {
		return allContractorsList;
	}

	public void setAllContractorsList(ArrayList allContractorsList) {
		this.allContractorsList = allContractorsList;
	}

	public ArrayList getContractorList() {
		return contractorList;
	}

	public void setContractorList(ArrayList contractorList) {
		this.contractorList = contractorList;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public ArrayList getAuthList() {
		return authList;
	}

	public void setAuthList(ArrayList authList) {
		this.authList = authList;
	}

	private String mileStoneAmount;

	public String getAudhendication() {
		return audhendication;
	}

	public void setAudhendication(String audhendication) {
		this.audhendication = audhendication;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public String getBankIFSC() {
		return bankIFSC;
	}

	public void setBankIFSC(String bankIFSC) {
		this.bankIFSC = bankIFSC;
	}

	public String getCircleCode() {
		return circleCode;
	}

	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}

	public String getContractorACC() {
		return contractorACC;
	}

	public void setContractorACC(String contractorACC) {
		this.contractorACC = contractorACC;
	}

	public String getContractorName() {
		return contractorName;
	}

	public void setContractorName(String contractorName) {
		this.contractorName = contractorName;
	}

	public String getContractorId() {
		return contractorId;
	}

	public void setContractorId(String contractorId) {
		this.contractorId = contractorId;
	}

	public String getMileStoneAmount() {
		return mileStoneAmount;
	}

	public void setMileStoneAmount(String mileStoneAmount) {
		this.mileStoneAmount = mileStoneAmount;
	}

	public String getFinYear() {
		return finYear;
	}

	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}

	public String getProgram() {
		return program;
	}

	public void setProgram(String program) {
		this.program = program;
	}

	public String getProgramCode() {
		return programCode;
	}

	public void setProgramCode(String programCode) {
		this.programCode = programCode;
	}

	public String getSanctionedAmount() {
		return sanctionedAmount;
	}

	public void setSanctionedAmount(String sanctionedAmount) {
		this.sanctionedAmount = sanctionedAmount;
	}

	public String getSanctionedDate() {
		return sanctionedDate;
	}

	public void setSanctionedDate(String sanctionedDate) {
		this.sanctionedDate = sanctionedDate;
	}

	public String getSanctionYear() {
		return sanctionYear;
	}

	public void setSanctionYear(String sanctionYear) {
		this.sanctionYear = sanctionYear;
	}

	public String getSubProgCode() {
		return subProgCode;
	}

	public void setSubProgCode(String subProgCode) {
		this.subProgCode = subProgCode;
	}

	public String getSubProgName() {
		return subProgName;
	}

	public void setSubProgName(String subProgName) {
		this.subProgName = subProgName;
	}

	public String getWorkid() {
		return workid;
	}

	public void setWorkid(String workid) {
		this.workid = workid;
	}

	private String workid;

	private String sanctionedAmount;

	private String sanctionedDate;

	private String sanctionYear;

	public String getWorkIdList() {
		return workIdList;
	}

	public void setWorkIdList(String workIdList) {
		this.workIdList = workIdList;
	}

	public int getCmbDivision() {
		return cmbDivision;
	}

	public void setCmbDivision(int cmbDivision) {
		this.cmbDivision = cmbDivision;
	}

	public int getDivCode() {
		return divCode;
	}

	public void setDivCode(int divCode) {
		this.divCode = divCode;
	}

	public String getDivName() {
		return divName;
	}

	public void setDivName(String divName) {
		this.divName = divName;
	}

	public String getSubDivCode() {
		return subDivCode;
	}

	public void setSubDivCode(String subDivCode) {
		this.subDivCode = subDivCode;
	}

	public String getSubDivName() {
		return subDivName;
	}

	public void setSubDivName(String subDivName) {
		this.subDivName = subDivName;
	}

	public String getWorkName() {
		return workName;
	}

	public void setWorkName(String workName) {
		this.workName = workName;
	}
}