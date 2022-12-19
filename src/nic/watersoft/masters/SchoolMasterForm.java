package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;
 
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/*
 * Created on Dec 4, 2008
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author Vikas
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class SchoolMasterForm  extends ActionForm
{
	private String district;
	private String mandal;
	private String panchayat;
	private String village;
	private String habitation;
	private String category;
	private String classify;
	private String noStudents;
	private String facilities;
	private String toilets;
	private String urinals;
	private String nonDrink;
	private String nonSani;
	private String drkMonth;
	private String drkYear;
	private String saniMonth;
	private String saniYear;
	private String srcDrkFund;
	private String srcSaniFund;
	private String schoolName;
	private String mode;
	private String noBoys;
	private String noGirls;
	private String schoolCode;
	private String schoolLoc;
	private String habName;
	private String sourceDrkFund;
	private String sourceSaniFund;
	private String runningwater;

	 public void reset(ActionMapping mapping,HttpServletRequest request)
	 {
	 	this.district="-1";
		this.mandal="-1";
		this.panchayat="-1";
		this.village="-1";
		this.habitation="-1";		
		this.schoolName="";
		this.noBoys="";
		this.noGirls="";
		this.noStudents="";
		
		 this.category="";
		 this.classify="";
		 this.noStudents="";
		 this.facilities="";
		 this.toilets="";
		 this.urinals="";
		 this.nonDrink="";
		 this.nonSani="";
		 this.drkMonth="";
		 this.drkYear="";
		 this.saniMonth="";
		 this.saniYear="";
		 this.srcDrkFund="";
		 this.srcSaniFund="";
		 this.mode="";
		 this.schoolCode="";
		 this.schoolLoc="";
		 this.habName="";
   		 this.sourceDrkFund="";
		 this.sourceSaniFund="";
		 this.setRunningwater("");
     }
	 
	public String getSourceDrkFund() {
		return sourceDrkFund;
	}
	public String getSourceSaniFund() {
		return sourceSaniFund;
	}
	/**
	 * @param sourceSaniFund The sourceSaniFund to set.
	 */
	public void setSourceSaniFund(String sourceSaniFund) {
		this.sourceSaniFund = sourceSaniFund;
	}
	/**
	 * @param sourceDrkFund The sourceDrkFund to set.
	 */
	public void setSourceDrkFund(String sourceDrkFund) {
		this.sourceDrkFund = sourceDrkFund;
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
	 * @return Returns the noBoys.
	 */
	public String getNoBoys() {
		return noBoys;
	}
	/**
	 * @param noBoys The noBoys to set.
	 */
	public void setNoBoys(String noBoys) {
		this.noBoys = noBoys;
	}
	/**
	 * @return Returns the noGirls.
	 */
	public String getNoGirls() {
		return noGirls;
	}
	/**
	 * @param noGirls The noGirls to set.
	 */
	public void setNoGirls(String noGirls) {
		this.noGirls = noGirls;
	}
	/**
	 * @return Returns the schoolCode.
	 */
	public String getSchoolCode() {
		return schoolCode;
	}
	/**
	 * @param schoolCode The schoolCode to set.
	 */
	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}
	/**
	 * @return Returns the schoolLoc.
	 */
	public String getSchoolLoc() {
		return schoolLoc;
	}
	/**
	 * @param schoolLoc The schoolLoc to set.
	 */
	public void setSchoolLoc(String schoolLoc) {
		this.schoolLoc = schoolLoc;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}
	/**
	 * @return Returns the category.
	 */
	public String getCategory() {
		return category;
	}
	/**
	 * @param category The category to set.
	 */
	public void setCategory(String category) {
		this.category = category;
	}
	/**
	 * @return Returns the classify.
	 */
	public String getClassify() {
		return classify;
	}
	/**
	 * @param classify The classify to set.
	 */
	public void setClassify(String classify) {
		this.classify = classify;
	}
	/**
	 * @return Returns the district.
	 */
	public String getDistrict() {
		return district;
	}
	/**
	 * @param district The district to set.
	 */
	public void setDistrict(String district) {
		this.district = district;
	}
	/**
	 * @return Returns the drkMonth.
	 */
	public String getDrkMonth() {
		return drkMonth;
	}
	/**
	 * @param drkMonth The drkMonth to set.
	 */
	public void setDrkMonth(String drkMonth) {
		this.drkMonth = drkMonth;
	}
	/**
	 * @return Returns the drkYear.
	 */
	public String getDrkYear() {
		return drkYear;
	}
	/**
	 * @param drkYear The drkYear to set.
	 */
	public void setDrkYear(String drkYear) {
		this.drkYear = drkYear;
	}
	/**
	 * @return Returns the facilities.
	 */
	public String getFacilities() {
		return facilities;
	}
	/**
	 * @param facilities The facilities to set.
	 */
	public void setFacilities(String facilities) {
		this.facilities = facilities;
	}
	/**
	 * @return Returns the habitation.
	 */
	public String getHabitation() {
		return habitation;
	}
	/**
	 * @param habitation The habitation to set.
	 */
	public void setHabitation(String habitation) {
		this.habitation = habitation;
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
	 * @return Returns the nonDrink.
	 */
	public String getNonDrink() {
		return nonDrink;
	}
	/**
	 * @param nonDrink The nonDrink to set.
	 */
	public void setNonDrink(String nonDrink) {
		this.nonDrink = nonDrink;
	}
	/**
	 * @return Returns the nonSani.
	 */
	public String getNonSani() {
		return nonSani;
	}
	/**
	 * @param nonSani The nonSani to set.
	 */
	public void setNonSani(String nonSani) {
		this.nonSani = nonSani;
	}
	/**
	 * @return Returns the noStudents.
	 */
	public String getNoStudents() {
		return noStudents;
	}
	/**
	 * @param noStudents The noStudents to set.
	 */
	public void setNoStudents(String noStudents) {
		this.noStudents = noStudents;
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
	 * @return Returns the saniMonth.
	 */
	public String getSaniMonth() {
		return saniMonth;
	}
	/**
	 * @param saniMonth The saniMonth to set.
	 */
	public void setSaniMonth(String saniMonth) {
		this.saniMonth = saniMonth;
	}
	/**
	 * @return Returns the saniYear.
	 */
	public String getSaniYear() {
		return saniYear;
	}
	/**
	 * @param saniYear The saniYear to set.
	 */
	public void setSaniYear(String saniYear) {
		this.saniYear = saniYear;
	}
	/**
	 * @return Returns the schoolName.
	 */
	public String getSchoolName() {
		return schoolName;
	}
	/**
	 * @param schoolName The schoolName to set.
	 */
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	/**
	 * @return Returns the srcDrkFund.
	 */
	public String getSrcDrkFund() {
		return srcDrkFund;
	}
	/**
	 * @param srcDrkFund The srcDrkFund to set.
	 */
	public void setSrcDrkFund(String srcDrkFund) {
		this.srcDrkFund = srcDrkFund;
	}
	/**
	 * @return Returns the srcSaniFund.
	 */
	public String getSrcSaniFund() {
		return srcSaniFund;
	}
	/**
	 * @param srcSaniFund The srcSaniFund to set.
	 */
	public void setSrcSaniFund(String srcSaniFund) {
		this.srcSaniFund = srcSaniFund;
	}
	/**
	 * @return Returns the toilets.
	 */
	public String getToilets() {
		return toilets;
	}
	/**
	 * @param toilets The toilets to set.
	 */
	public void setToilets(String toilets) {
		this.toilets = toilets;
	}
	/**
	 * @return Returns the urinals.
	 */
	public String getUrinals() {
		return urinals;
	}
	/**
	 * @param urinals The urinals to set.
	 */
	public void setUrinals(String urinals) {
		this.urinals = urinals;
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

	public String getRunningwater() {
		return runningwater;
	}

	public void setRunningwater(String runningwater) {
		this.runningwater = runningwater;
	}
}
