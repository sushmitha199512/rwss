package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

//import nic.watersoft.commons.Debug;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class EmpForm extends ActionForm
{
	
	
	private String sector;
	private String surname;
	private String relation;
	private String social;
	private String ndist;
	private String nmand;
	private String religion;
	private String narecruit;
	private String zone;
	private String apcatog;
	private String moap;
	private String dacctest;
	private String dcommprob;
	private String ddeclprob;
	private String nemploy;
	private String tempdesig;
	private String tempdesgCode;
	private String officeCode;
	private String selection;

	private String department;
	private String promotedate;
	private String depu;
	private String leavesuspend;
	private String leavedate;
	private String depudept;
	
	private String diststudied4;
	private String diststudied5;
	private String diststudied6;
	private String diststudied7;
	private String diststudied8;
	private String diststudied9;
	private String diststudied10;
	
	private String localdist;
	private String localzone;
	private String noofyrs;
	private String noofyrs1;
	private String pvtdist;
	private String pvtzone;
	private String desig;
	
	private String fromDate;
	private String toDate;
	private String year;
	
	private String hoc;
	private String coc;
	private String doc;
	private String sdoc;

	private String empcode;
	private String empname;
	
	private String roc;
	private String dob;
	private String appointdate;
	private String doj;
	private String currentpostdate;
	private String phone;
	private String mobile;
	private String totalworkscomp;
	private String qual;
	private String desgnCode;
	private String addqual1;
	private String addqual2;
	private String hof;
	private String presentation;
	private String otherDet;
	private String checkType;
	private int noOfChecks;
	private String checkPeriod;
	private String appOrderRef;
	private String workSpecial;
	private String postCode;
	private String mode;
	
	//edit part of EmployeeForm
	private String handicap;
	private String spouseemployd;
	private String spouseworking;
	private String spouseworkdist;
	private String spouseworkdiv;
	private String spouseworkmand;
	private String apptcategory;
	private String disciplinecase;
	private String disciplinetype;
	private String dept;
	private String deputationDate;
	
	private String qualName;
	private String desgnName;
	
	//setDesgnName
	
	public String getQualName() {
		return qualName;
	}
	public void setQualName(String qualName) {
		this.qualName = qualName;
	}
	
		
	/**
	 * @return Returns the depudept.
	 */
	public String getDepudept() {
		return depudept;
	}
	/**
	 * @param depudept The depudept to set.
	 */
	public void setDepudept(String depudept) {
		this.depudept = depudept;
	}
	/**
	 * @return Returns the leavedate.
	 */
	public String getLeavedate() {
		return leavedate;
	}
	/**
	 * @param leavedate The leavedate to set.
	 */
	public void setLeavedate(String leavedate) {
		this.leavedate = leavedate;
	}
	/**
	 * @return Returns the leavesuspend.
	 */
	public String getLeavesuspend() {
		return leavesuspend;
	}
	/**
	 * @param leavesuspend The leavesuspend to set.
	 */
	public void setLeavesuspend(String leavesuspend) {
		this.leavesuspend = leavesuspend;
	}
	/**
	 * @return Returns the depu.
	 */
	public String getDepu() {
		return depu;
	}
	/**
	 * @param depu The depu to set.
	 */
	public void setDepu(String depu) {
		this.depu = depu;
	}
	/**
	 * @return Returns the promotedate.
	 */
	public String getPromotedate() {
		return promotedate;
	}
	/**
	 * @param promotedate The promotedate to set.
	 */
	public void setPromotedate(String promotedate) {
		this.promotedate = promotedate;
	}
	/**
	 * @return Returns the department.
	 */
	public String getDepartment() {
		return department;
	}
	/**
	 * @param department The department to set.
	 */
	public void setDepartment(String department) {
		this.department = department;
	}
	/**
	 * @return Returns the selection.
	 */
	public String getSelection() {
		return selection;
	}
	/**
	 * @param selection The selection to set.
	 */
	public void setSelection(String selection) {
		this.selection = selection;
	}
	/**
	 * @return Returns the officeCode.
	 */
	public String getOfficeCode() {
		return officeCode;
	}
	/**
	 * @param officeCode The officeCode to set.
	 */
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	//Added on Aug 2
	
	
	/**
	 * @return Returns the deputationDate.
	 */
	public String getDeputationDate() {
		return deputationDate;
	}
	/**
	 * @param deputationDate The deputationDate to set.
	 */
	public void setDeputationDate(String deputationDate) {
		this.deputationDate = deputationDate;
	}
	/**
	 * @return Returns the dept.
	 */
	public String getDept() {
		return dept;
	}
	/**
	 * @param dept The dept to set.
	 */
	public void setDept(String dept) {
		this.dept = dept;
	}
	/**
	 * @return Returns the disciplinecase.
	 */
	public String getDisciplinecase() {
		return disciplinecase;
	}
	/**
	 * @param disciplinecase The disciplinecase to set.
	 */
	public void setDisciplinecase(String disciplinecase) {
		this.disciplinecase = disciplinecase;
	}
	/**
	 * @return Returns the disciplinetype.
	 */
	public String getDisciplinetype() {
		return disciplinetype;
	}
	/**
	 * @param disciplinetype The disciplinetype to set.
	 */
	public void setDisciplinetype(String disciplinetype) {
		this.disciplinetype = disciplinetype;
	}
	/**
	 * @return Returns the apptcategory.
	 */
	public String getApptcategory() {
		return apptcategory;
	}
	/**
	 * @param apptcategory The apptcategory to set.
	 */
	public void setApptcategory(String apptcategory) {
		this.apptcategory = apptcategory;
	}
	/**
	 * @return Returns the spouseemployd.
	 */
	public String getSpouseemployd() {
		return spouseemployd;
	}
	/**
	 * @param spouseemployd The spouseemployd to set.
	 */
	public void setSpouseemployd(String spouseemployd) {
		this.spouseemployd = spouseemployd;
	}
	/**
	 * @return Returns the spouseworkdist.
	 */
	public String getSpouseworkdist() {
		return spouseworkdist;
	}
	/**
	 * @param spouseworkdist The spouseworkdist to set.
	 */
	public void setSpouseworkdist(String spouseworkdist) {
		this.spouseworkdist = spouseworkdist;
	}
	/**
	 * @return Returns the spouseworkdiv.
	 */
	public String getSpouseworkdiv() {
		return spouseworkdiv;
	}
	/**
	 * @param spouseworkdiv The spouseworkdiv to set.
	 */
	public void setSpouseworkdiv(String spouseworkdiv) {
		this.spouseworkdiv = spouseworkdiv;
	}
	/**
	 * @return Returns the spouseworking.
	 */
	public String getSpouseworking() {
		return spouseworking;
	}
	/**
	 * @param spouseworking The spouseworking to set.
	 */
	public void setSpouseworking(String spouseworking) {
		this.spouseworking = spouseworking;
	}
	/**
	 * @return Returns the spouseworkmand.
	 */
	public String getSpouseworkmand() {
		return spouseworkmand;
	}
	/**
	 * @param spouseworkmand The spouseworkmand to set.
	 */
	public void setSpouseworkmand(String spouseworkmand) {
		this.spouseworkmand = spouseworkmand;
	}
	/**
	 * @return Returns the handicap.
	 */
	public String getHandicap() {
		return handicap;
	}
	/**
	 * @param handicap The handicap to set.
	 */
	public void setHandicap(String handicap) {
		this.handicap = handicap;
	}
	//code for testing Ajax programme
	private String officeName;
	private String circleName;
	private String circleCode;
	private String divisionName;
	private String divisionCode;
	private String subdivName;
	
	private String circleOfficeCode;
	private String divName;
	private String divisionOfficeCode;
	private String subdivisionOfficeCode;
	
	/**
	 * @return Returns the officeName.
	 */
	public String getOfficeName() {
		return officeName;
	}
	/**
	 * @param officeName The officeName to set.
	 */
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
	}
	
	/**
	 * @return Returns the circleCode.
	 */
	public String getCircleCode() {
		return circleCode;
	}
	/**
	 * @param circleCode The circleCode to set.
	 */
	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}
	/**
	 * @return Returns the divisionCode.
	 */
	public String getDivisionCode() {
		return divisionCode;
	}
	/**
	 * @param divisionCode The divisionCode to set.
	 */
	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}
	/**
	 * @return Returns the circleName.
	 */
	public String getCircleName() {
		return circleName;
	}
	/**
	 * @param circleName The circleName to set.
	 */
	public void setCircleName(String circleName) {
		this.circleName = circleName;
	}
	/**
	 * @return Returns the divisionName.
	 */
	public String getDivisionName() {
		return divisionName;
	}
	/**
	 * @param divisionName The divisionName to set.
	 */
	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}
	/**
	 * @return Returns the subdivName.
	 */
	public String getSubdivName() {
		return subdivName;
	}
	/**
	 * @param subdivName The subdivName to set.
	 */
	public void setSubdivName(String subdivName) {
		this.subdivName = subdivName;
	}
	//end of code
		
	//Added on Aug 13
	private String headOfficeName;
	private String divisionOfficeName;
	private String circleOfficeName;
	private String subdivisionOfficeName;
	
	private String gender;
	private String nrevenue;
	private String deputation;
    private String presentdesig;
	private String panno;
	private String apgli;
	private String gpfno;
	private String payscale;
	private String incrementdate;
	private String updatedate;
	private String testpassed;
	private String seniority;
	private String section;	
	
	
	
	/**
	 * @return Returns the section.
	 */
	public String getSection() {
		return section;
	}
	/**
	 * @param section The section to set.
	 */
	public void setSection(String section) {
		this.section = section;
	}
	/**
	 * @return Returns the seniority.
	 */
	public String getSeniority() {
		return seniority;
	}
	/**
	 * @param seniority The seniority to set.
	 */
	public void setSeniority(String seniority) {
		this.seniority = seniority;
	}
	//code added for Emp Status forms
	private String detailedWise;
	private String temp1;
	private String submitReport;
	
	private String[] selectedItems = {}; 
	
	public String[] getSelectedItems() { 
	  return this.selectedItems; 
	} 
	public void setSelectedItems(String[] selectedItems) { 
	  this.selectedItems = selectedItems; 
	}
	 public void reset(ActionMapping mapping,HttpServletRequest request)
	 {
	     this.selectedItems=new String[0];
	     
	     	this.empcode="";
			//added on july 21
			this.surname="";
			this.empname="";
			this.gender="";
			this.relation="";
			this.dob="";
			this.religion="";
			this.social="";
			this.nmand="";
			this.ndist="";
			this.nrevenue="";
			this.qual="";
			this.handicap="";
		
			this.diststudied4="";
			this.diststudied5="";
			this.diststudied6="";
			this.diststudied7="";
			this.diststudied8="";
			this.diststudied9="";
			this.diststudied10="";
			this.localdist="";
			this.localzone="";
			this.noofyrs="";
			this.noofyrs1="";
			this.pvtdist="";
			this.pvtzone="";
						
			this.spouseemployd="";
			this.spouseworking="";
			this.spouseworkdist="";
			this.spouseworkdiv="";
			this.spouseworkmand="";
		
			this.desig="";
			this.desgnCode="";
			this.appointdate="";
			this.apptcategory="";
			this.doj="";
			this.moap="";
			this.zone="";
			this.narecruit="";
			this.apcatog="";
			this.dcommprob="";
			this.ddeclprob="";
			this.currentpostdate="";
		
			this.promotedate="";
			this.testpassed="";
			this.dacctest="";
			this.addqual1="";
			this.addqual2="";
			this.presentdesig="";
			
			this.workSpecial="";
							
			this.otherDet="";
		
			this.hoc="";
			this.coc="";
			this.doc="";
			this.sdoc="";
			this.section="";
			this.roc="";
			this.dept="";				
			this.deputation="";
			this.deputationDate="";
			this.seniority="";
			this.disciplinecase="";
			this.disciplinetype="";
			
			this.panno="";
			this.apgli="";
			this.gpfno="";
			this.payscale="";
			this.incrementdate="";
			this.updatedate="";
							
			this.leavesuspend="";
			this.leavedate="";
			this.depudept="";			
	    
	     
     }

 
	 /**
		 * @return Returns the gpfno.
		 */
		public String getGpfno() {
			return gpfno;
		}
		/**
		 * @param gpfno The gpfno to set.
		 */
		public void setGpfno(String gpfno) {
			this.gpfno = gpfno;
		}
		/**
		 * @return Returns the updatedate.
		 */
		public String getUpdatedate() {
			return updatedate;
		}
		/**
		 * @param updatedate The updatedate to set.
		 */
		public void setUpdatedate(String updatedate) {
			this.updatedate = updatedate;
		}
	
	
	/**
	 * @return Returns the submitReport.
	 */
	public String getSubmitReport() {
		return submitReport;
	}
	/**
	 * @param submitReport The submitReport to set.
	 */
	public void setSubmitReport(String submitReport) {
		this.submitReport = submitReport;
	}
	/**
	 * @return Returns the temp1.
	 */
	public String getTemp1() {
		return temp1;
	}
	/**
	 * @param temp1 The temp1 to set.
	 */
	public void setTemp1(String temp1) {
		this.temp1 = temp1;
	}
	/**
	 * @return Returns the detailedWise.
	 */
	public String getDetailedWise() {
		return detailedWise;
	}
	/**
	 * @param detailedWise The detailedWise to set.
	 */
	public void setDetailedWise(String detailedWise) {
		this.detailedWise = detailedWise;
	}
	/**
	 * @return Returns the testpassed.
	 */
	public String getTestpassed() {
		return testpassed;
	}
	/**
	 * @param testpassed The testpassed to set.
	 */
	public void setTestpassed(String testpassed) {
		this.testpassed = testpassed;
	}
	/**
	 * @return Returns the apgli.
	 */
	public String getApgli() {
		return apgli;
	}
	/**
	 * @param apgli The apgli to set.
	 */
	public void setApgli(String apgli) {
		this.apgli = apgli;
	}
	/**
	 * @return Returns the deputation.
	 */
	public String getDeputation() {
		return deputation;
	}
	/**
	 * @param deputation The deputation to set.
	 */
	public void setDeputation(String deputation) {
		this.deputation = deputation;
	}
	/**
	 * @return Returns the gender.
	 */
	public String getGender() {
		return gender;
	}
	/**
	 * @param gender The gender to set.
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}
	/**
	 * @return Returns the incrementdate.
	 */
	public String getIncrementdate() {
		return incrementdate;
	}
	/**
	 * @param incrementdate The incrementdate to set.
	 */
	public void setIncrementdate(String incrementdate) {
		this.incrementdate = incrementdate;
	}
	/**
	 * @return Returns the nrevenue.
	 */
	public String getNrevenue() {
		return nrevenue;
	}
	/**
	 * @param nrevenue The nrevenue to set.
	 */
	public void setNrevenue(String nrevenue) {
		this.nrevenue = nrevenue;
	}
	/**
	 * @return Returns the panno.
	 */
	public String getPanno() {
		return panno;
	}
	/**
	 * @param panno The panno to set.
	 */
	public void setPanno(String panno) {
		this.panno = panno;
	}
	/**
	 * @return Returns the payscale.
	 */
	public String getPayscale() {
		return payscale;
	}
	/**
	 * @param payscale The payscale to set.
	 */
	public void setPayscale(String payscale) {
		this.payscale = payscale;
	}
	/**
	 * @return Returns the presentdesig.
	 */
	public String getPresentdesig() {
		return presentdesig;
	}
	/**
	 * @param presentdesig The presentdesig to set.
	 */
	public void setPresentdesig(String presentdesig) {
		this.presentdesig = presentdesig;
	}
	public String getDivisionOfficeName() {
		return divisionOfficeName;
	}
	/**
	 * @param divisionOfficeName The divisionOfficeName to set.
	 */
	public void setDivisionOfficeName(String divisionOfficeName) {
		this.divisionOfficeName = divisionOfficeName;
	}
	/**
	 * @return Returns the headOfficeName.
	 */
	public String getHeadOfficeName() {
		return headOfficeName;
	}
	/**
	 * @param headOfficeName The headOfficeName to set.
	 */
	public void setHeadOfficeName(String headOfficeName) {
		this.headOfficeName = headOfficeName;
	}
	/**
	 * @return Returns the subdivisionOfficeName.
	 */
	public String getSubdivisionOfficeName() {
		return subdivisionOfficeName;
	}
	/**
	 * @param subdivisionOfficeName The subdivisionOfficeName to set.
	 */
	public void setSubdivisionOfficeName(String subdivisionOfficeName) {
		this.subdivisionOfficeName = subdivisionOfficeName;
	}
	/**
	 * @return Returns the year.
	 */
	public String getYear() {
		return year;
	}
	/**
	 * @param year The year to set.
	 */
	public void setYear(String year) {
		this.year = year;
	}
	/**
	 * @return Returns the fromdate.
	 */
	
	/**
	 * @return Returns the desig.
	 */
	public String getDesig() {
		return desig;
	}
	/**
	 * @param desig The desig to set.
	 */
	public void setDesig(String desig) {
		this.desig = desig;
	}
	/**
	 * @return Returns the noofyrs.
	 */
	public String getNoofyrs() {
		return noofyrs;
	}
	/**
	 * @param noofyrs The noofyrs to set.
	 */
	public void setNoofyrs(String noofyrs) {
		this.noofyrs = noofyrs;
	}
	/**
	 * @return Returns the noofyrs1.
	 */
	public String getNoofyrs1() {
		return noofyrs1;
	}
	/**
	 * @param noofyrs1 The noofyrs1 to set.
	 */
	public void setNoofyrs1(String noofyrs1) {
		this.noofyrs1 = noofyrs1;
	}
	/**
	 * @return Returns the pvtdist.
	 */
	public String getPvtdist() {
		return pvtdist;
	}
	/**
	 * @param pvtdist The pvtdist to set.
	 */
	public void setPvtdist(String pvtdist) {
		this.pvtdist = pvtdist;
	}
	/**
	 * @return Returns the pvtzone.
	 */
	public String getPvtzone() {
		return pvtzone;
	}
	/**
	 * @param pvtzone The pvtzone to set.
	 */
	public void setPvtzone(String pvtzone) {
		this.pvtzone = pvtzone;
	}
	/**
	 * @return Returns the localzone.
	 */
	public String getLocalzone() {
		return localzone;
	}
	/**
	 * @param localzone The localzone to set.
	 */
	public void setLocalzone(String localzone) {
		this.localzone = localzone;
	}
	/**
	 * @return Returns the localdist.
	 */
	public String getLocaldist() {
		return localdist;
	}
	/**
	 * @param localdist The localdist to set.
	 */
	public void setLocaldist(String localdist) {
		this.localdist = localdist;
	}
	/**
	 * @return Returns the diststudied10.
	 */
	public String getDiststudied10() {
		return diststudied10;
	}
	/**
	 * @param diststudied10 The diststudied10 to set.
	 */
	public void setDiststudied10(String diststudied10) {
		this.diststudied10 = diststudied10;
	}
	/**
	 * @return Returns the diststudied5.
	 */
	public String getDiststudied5() {
		return diststudied5;
	}
	/**
	 * @param diststudied5 The diststudied5 to set.
	 */
	public void setDiststudied5(String diststudied5) {
		this.diststudied5 = diststudied5;
	}
	/**
	 * @return Returns the diststudied6.
	 */
	public String getDiststudied6() {
		return diststudied6;
	}
	/**
	 * @param diststudied6 The diststudied6 to set.
	 */
	public void setDiststudied6(String diststudied6) {
		this.diststudied6 = diststudied6;
	}
	/**
	 * @return Returns the diststudied7.
	 */
	public String getDiststudied7() {
		return diststudied7;
	}
	/**
	 * @param diststudied7 The diststudied7 to set.
	 */
	public void setDiststudied7(String diststudied7) {
		this.diststudied7 = diststudied7;
	}
	/**
	 * @return Returns the diststudied8.
	 */
	public String getDiststudied8() {
		return diststudied8;
	}
	/**
	 * @param diststudied8 The diststudied8 to set.
	 */
	public void setDiststudied8(String diststudied8) {
		this.diststudied8 = diststudied8;
	}
	/**
	 * @return Returns the diststudied9.
	 */
	public String getDiststudied9() {
		return diststudied9;
	}
	/**
	 * @param diststudied9 The diststudied9 to set.
	 */
	public void setDiststudied9(String diststudied9) {
		this.diststudied9 = diststudied9;
	}
	/**
	 * @return Returns the diststudied4.
	 */
	public String getDiststudied4() {
		return diststudied4;
	}
	/**
	 * @param diststudied4 The diststudied4 to set.
	 */
	public void setDiststudied4(String diststudied4) {
		this.diststudied4 = diststudied4;
	}
	/**
	 * @return Returns the tempdesgCode.
	 */
	public String getTempdesgCode() {
		return tempdesgCode;
	}
	/**
	 * @param tempdesgCode The tempdesgCode to set.
	 */
	public void setTempdesgCode(String tempdesgCode) {
		this.tempdesgCode = tempdesgCode;
	}
	/**
	 * @return Returns the perdesig.
	 */
	public String getPerdesig() {
		return perdesig;
	}
	/**
	 * @param perdesig The perdesig to set.
	 */
	public void setPerdesig(String perdesig) {
		this.perdesig = perdesig;
	}
	/**
	 * @return Returns the tempdesig.
	 */
	public String getTempdesig() {
		return tempdesig;
	}
	/**
	 * @param tempdesig The tempdesig to set.
	 */
	public void setTempdesig(String tempdesig) {
		this.tempdesig = tempdesig;
	}
	private String perdesig;
	
	/**
	 * @return Returns the apcatog.
	 */
	public String getApcatog() {
		return apcatog;
	}
	/**
	 * @param apcatog The apcatog to set.
	 */
	public void setApcatog(String apcatog) {
		this.apcatog = apcatog;
	}
	/**
	 * @return Returns the narecruit.
	 */
	public String getNarecruit() {
		return narecruit;
	}
	/**
	 * @param narecruit The narecruit to set.
	 */
	public void setNarecruit(String narecruit) {
		this.narecruit = narecruit;
	}
	/**
	 * @return Returns the zone.
	 */
	public String getZone() {
		return zone;
	}
	/**
	 * @param zone The zone to set.
	 */
	public void setZone(String zone) {
		this.zone = zone;
	}
	
	
	/**
	 * @return Returns the moap.
	 */
	public String getMoap() {
		return moap;
	}
	/**
	 * @param moap The moap to set.
	 */
	public void setMoap(String moap) {
		this.moap = moap;
	}
	
	
	
	/**
	 * @return Returns the sector.
	 */
	public String getSector() {
		return sector;
	}
	/**
	 * @param sector The sector to set.
	 */
	public void setSector(String sector) {
		this.sector = sector;
	}
	public void setHoc(String hoc)
	{
		this.hoc=hoc;
	}
	public String getHoc()
	{
		return hoc;
	}
	public void setCoc(String coc)
	{
		this.coc=coc;
	}
	public String getCoc()
	{
		return coc;
	}
	public void setDoc(String doc)
	{
		this.doc=doc;
	}
	public String getDoc()
	{
		return doc;
	}
	public void setSdoc(String sdoc)
	{
		this.sdoc=sdoc;
	}
	public String getSdoc()
	{
		return sdoc;
	}
	public void setEmpcode(String empcode)
	{
		this.empcode=empcode;
	}
	public String getEmpcode()
	{
		return empcode;
	}

	public void setEmpname(String empname)
	{
		this.empname=empname;
	}
	public String getEmpname()
	{
		return empname;
	}

	public void setRoc(String roc)
	{
		this.roc=roc;
	}
	public String getRoc()
	{
		return roc;
	}
	public void setDob(String dob)
	{
		this.dob=dob;
	}
	public String getDob()
	{
		return dob;
	}
	public void setAppointdate(String appointdate)
	{
		this.appointdate=appointdate;
	}
	public String getAppointdate()
	{
		return appointdate;
	}
	public void setDoj(String doj)
	{
		this.doj=doj;
	}
	public String getDoj()
	{
		return doj;
	}
	public void setCurrentpostdate(String currentpostdate)
	{
		this.currentpostdate=currentpostdate;
	}
	public String getCurrentpostdate()
	{
		return currentpostdate;
	}
	public void setPhone(String phone)
	{
		this.phone=phone;
	}
	public String getPhone()
	{
		return phone;
	}
	public void setMobile(String mobile)
	{
		this.mobile=mobile;
	}
	public String getMobile()
	{
		return mobile;
	}
	public void setTotalworkscomp(String totalworkscomp)
	{
		this.totalworkscomp=totalworkscomp;
	}
	public String getTotalworkscomp()
	{
		return totalworkscomp;
	}
	public void setQual(String qual)
	{
		this.qual=qual;
	}
	public String getQual()
	{
		return qual;
	}
	public void setAddqual1(String addqual1)
	{
		this.addqual1=addqual1;
	}
	public String getAddqual1()
	{
		return addqual1;
	}
	public void setAddqual2(String addqual2)
	{
		this.addqual2=addqual2;
	}
	public String getAddqual2()
	{
		return addqual2;
	}
	public void setHof(String hof)
	{
		this.hof=hof;
	}
	public String getHof()
	{
		return hof;
	}
	public void setPresentation(String presentation)
	{
		this.presentation=presentation;
	}
	public String getPresentation()
	{
		return presentation;
	}
	public void setOtherDet(String otherDet)
	{
		this.otherDet=otherDet;
	}
	public String getOtherDet()
	{
		return otherDet;
	}
	public void setDesgnCode(String desgnCode)
	{
		this.desgnCode=desgnCode;
	}
	public String getDesgnCode()
	{
		return desgnCode;
	}
	public void setCheckType(String checkType)
	{
		this.checkType=checkType;
	}
	public String getCheckType()
	{
		return checkType;
	}
	public void setNoOfChecks(int noOfChecks)
	{
		this.noOfChecks=noOfChecks;
	}
	public int getNoOfChecks()
	{
		return noOfChecks;
	}
	public void setCheckPeriod(String checkPeriod)
	{
		this.checkPeriod=checkPeriod;
	}
	public String getCheckPeriod()
	{
		return checkPeriod;
	}
	public void setAppOrderRef(String appOrderRef)
	{
		this.appOrderRef=appOrderRef;
	}
	public String getAppOrderRef()
	{
		return appOrderRef;
	}
	public void setWorkSpecial(String workSpecial)
	{
		this.workSpecial=workSpecial;
	}
	public String getWorkSpecial()
	{
		return workSpecial;
	}
	public void setPostCode(String postCode)
	{
		this.postCode=postCode;
	}
	public String getPostCode()
	{
		return postCode;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode)
	{
		this.mode=mode;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode()
	{
		return mode;
	}
	
	/**
	 * @return Returns the surname.
	 */
	public String getSurname() {
		return surname;
	}
	/**
	 * @param surname The surname to set.
	 */
	public void setSurname(String surname) {
		this.surname = surname;
	}
	/**
	 * @return Returns the relation.
	 */
	public String getRelation() {
		return relation;
	}
	/**
	 * @param relation The relation to set.
	 */
	public void setRelation(String relation) {
		this.relation = relation;
	}
	/**
	 * @return Returns the social.
	 */
	public String getSocial() {
		return social;
	}
	/**
	 * @param social The social to set.
	 */
	public void setSocial(String social) {
		this.social = social;
	}
	/**
	 * @return Returns the religion.
	 */
	public String getReligion() {
		return religion;
	}
	/**
	 * @param religion The religion to set.
	 */
	public void setReligion(String religion) {
		this.religion = religion;
	}
	/**
	 * @return Returns the ndist.
	 */
	public String getNdist() {
		return ndist;
	}
	/**
	 * @param ndist The ndist to set.
	 */
	public void setNdist(String ndist) {
		this.ndist = ndist;
	}
	/**
	 * @return Returns the nmand.
	 */
	public String getNmand() {
		return nmand;
	}
	/**
	 * @param nmand The nmand to set.
	 */
	public void setNmand(String nmand) {
		this.nmand = nmand;
	}
	/**
	 * @return Returns the dacctest.
	 */
	public String getDacctest() {
		return dacctest;
	}
	/**
	 * @param dacctest The dacctest to set.
	 */
	public void setDacctest(String dacctest) {
		this.dacctest = dacctest;
	}
	/**
	 * @return Returns the dcommprob.
	 */
	public String getDcommprob() {
		return dcommprob;
	}
	/**
	 * @param dcommprob The dcommprob to set.
	 */
	public void setDcommprob(String dcommprob) {
		this.dcommprob = dcommprob;
	}
	/**
	 * @return Returns the ddeclprob.
	 */
	public String getDdeclprob() {
		return ddeclprob;
	}
	/**
	 * @param ddeclprob The ddeclprob to set.
	 */
	public void setDdeclprob(String ddeclprob) {
		this.ddeclprob = ddeclprob;
	}
	/**
	 * @return Returns the nemploy.
	 */
	public String getNemploy() {
		return nemploy;
	}
	/**
	 * @param nemploy The nemploy to set.
	 */
	public void setNemploy(String nemploy) {
		this.nemploy = nemploy;
	}
	
	/**
	 * @return Returns the circleOfficeName.
	 */
	public String getCircleOfficeName() {
		return circleOfficeName;
	}
	/**
	 * @param circleOfficeName The circleOfficeName to set.
	 */
	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}
	/**
	 * @return Returns the fromDate.
	 */
	public String getFromDate() {
		return fromDate;
	}
	/**
	 * @param fromDate The fromDate to set.
	 */
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	/**
	 * @return Returns the toDate.
	 */
	public String getToDate() {
		return toDate;
	}
	/**
	 * @param toDate The toDate to set.
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	public String getDivName() {
		return divName;
	}
	public void setDivName(String divName) {
		this.divName = divName;
	}
	public String getSubdivisionOfficeCode() {
		return subdivisionOfficeCode;
	}
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
		this.subdivisionOfficeCode = subdivisionOfficeCode;
	}
	public String getDesgnName() {
		return desgnName;
	}
	public void setDesgnName(String desgnName) {
		this.desgnName = desgnName;
	}
}