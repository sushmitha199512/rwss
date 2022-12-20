package nic.watersoft.works;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsWorkUpdationActionForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ArrayList specialCatList = new ArrayList();

	private String aapFinYear;
	private String specialCatCode;
	private String ccode;

	private String pExp;

	private String pExp1;

	private String checks;
	

	
	public String getChecks() {
		return checks;
	}

	public void setChecks(String checks) {
		this.checks = checks;
	}

	public String getpExp() {
		return pExp;
	}

	public void setpExp(String pExp) {
		this.pExp = pExp;
	}

	public String getpExp1() {
		return pExp1;
	}

	public void setpExp1(String pExp1) {
		this.pExp1 = pExp1;
	}

	private String slsccDate;

	private String sanctionHabs;

	public String getSanctionHabs() {
		return sanctionHabs;
	}

	public String getSlsccDate() {
		return slsccDate;
	}

	public void setSlsccDate(String slsccDate) {
		this.slsccDate = slsccDate;
	}

	public void setSanctionHabs(String sanctionHabs) {
		this.sanctionHabs = sanctionHabs;
	}

	private String subplanSubmitted;

	private String probExpNextYear;

	public String getSubplanSubmitted() {
		return subplanSubmitted;
	}

	public String getAapFinYear() {
		return aapFinYear;
	}

	public void setAapFinYear(String aapFinYear) {
		this.aapFinYear = aapFinYear;
	}

	public void setSubplanSubmitted(String subplanSubmitted) {
		this.subplanSubmitted = subplanSubmitted;
	}

	public String getProbExpNextYear() {
		return probExpNextYear;
	}

	public void setProbExpNextYear(String probExpNextYear) {
		this.probExpNextYear = probExpNextYear;
	}

	private String workIdList1;

	private String circle;

	private String division;

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
	private String category;

	String programCode;

	String program;

	String finYear;

	private String workid;

	private String sanctionedAmount;

	private String sanctionedDate;

	private String mileStoneAmount;
	private String programs;

	private String sanYears;

	private String sanctionYear;
	private String probExp;

	private String probDateOfComp;
	private String plain;
	private String sc;
	private String st;

	private String expDuring;
	private String balanceEst;

	private String completionDate;

	private String groundingDate;
	private String updatedateStatus;

	public String getCompletionDate() {
		return completionDate;
	}

	public void setCompletionDate(String completionDate) {
		this.completionDate = completionDate;
	}

	public String getGroundingDate() {
		return groundingDate;
	}

	public void setGroundingDate(String groundingDate) {
		this.groundingDate = groundingDate;
	}

	public String getExpDuring() {
		return expDuring;
	}

	public void setExpDuring(String expDuring) {
		this.expDuring = expDuring;
	}

	public String getBalanceEst() {
		return balanceEst;
	}

	public void setBalanceEst(String balanceEst) {
		this.balanceEst = balanceEst;
	}

	public String getPlain() {
		return plain;
	}

	public void setPlain(String plain) {
		this.plain = plain;
	}

	public String getSc() {
		return sc;
	}

	public void setSc(String sc) {
		this.sc = sc;
	}

	public String getSt() {
		return st;
	}

	public void setSt(String st) {
		this.st = st;
	}

	public String getProbDateOfComp() {
		return probDateOfComp;
	}

	public void setProbDateOfComp(String probDateOfComp) {
		this.probDateOfComp = probDateOfComp;
	}

	public String getProbExp() {
		return probExp;
	}

	public void setProbExp(String probExp) {
		this.probExp = probExp;
	}

	public String getWorkIdList1() {
		return workIdList1;
	}

	public void setWorkIdList1(String workIdList1) {
		this.workIdList1 = workIdList1;
	}

	public String getSanYears() {
		return sanYears;
	}

	public void setSanYears(String sanYears) {
		this.sanYears = sanYears;
	}

	public String getPrograms() {
		return programs;
	}

	public void setPrograms(String programs) {
		this.programs = programs;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public ArrayList getSpecialCatList() {
		return specialCatList;
	}

	public void setSpecialCatList(ArrayList specialCatList) {
		this.specialCatList = specialCatList;
	}

	public String getSpecialCatCode() {
		return specialCatCode;
	}

	public void setSpecialCatCode(String specialCatCode) {
		this.specialCatCode = specialCatCode;
	}

	public String getMileStoneAmount() {
		return mileStoneAmount;
	}

	public void setMileStoneAmount(String mileStoneAmount) {
		this.mileStoneAmount = mileStoneAmount;
	}

	public String getWorkid() {
		return workid;
	}

	public void setWorkid(String workid) {
		this.workid = workid;
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

	public String getCcode() {
		return ccode;
	}

	public void setCcode(String ccode) {
		this.ccode = ccode;
	}

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

	public String getCircleCode() {
		return circleCode;
	}

	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}

	public String getDivName() {
		return divName;
	}

	public void setDivName(String divName) {
		this.divName = divName;
	}

	public int getDivCode() {
		return divCode;
	}

	public void setDivCode(int divCode) {
		this.divCode = divCode;
	}

	public String getWorkIdList() {
		return workIdList;
	}

	public void setWorkIdList(String workIdList) {
		this.workIdList = workIdList;
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

	public String getSubProgName() {
		return subProgName;
	}

	public void setSubProgName(String subProgName) {
		this.subProgName = subProgName;
	}

	public String getSubProgCode() {
		return subProgCode;
	}

	public void setSubProgCode(String subProgCode) {
		this.subProgCode = subProgCode;
	}

	public int getCmbDivision() {
		return cmbDivision;
	}

	public void setCmbDivision(int cmbDivision) {
		this.cmbDivision = cmbDivision;
	}

	public String getProgramCode() {
		return programCode;
	}

	public void setProgramCode(String programCode) {
		this.programCode = programCode;
	}

	public String getProgram() {
		return program;
	}

	public void setProgram(String program) {
		this.program = program;
	}

	public String getFinYear() {
		return finYear;
	}

	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}

	public String getUpdatedateStatus() {
		return updatedateStatus;
	}

	public void setUpdatedateStatus(String updatedateStatus) {
		this.updatedateStatus = updatedateStatus;
	}	

}
