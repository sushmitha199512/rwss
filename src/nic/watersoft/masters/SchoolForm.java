package nic.watersoft.masters;

import java.util.ArrayList;

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
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class SchoolForm extends ActionForm {
	private String district;
	private String distName;
	private String mandal;
	private String mandName;
	private String panchayat;
	private String panchName;
	private String village;
	private String villName;
	private String habitation;
	private String habName;
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
	private String sourceDrkFund;
	private String sourceSaniFund;
	// Added on 13-01-2012
	private String schoolLatitude;
	private String schoolLongitude;
	private String schoolElevation;
	private String schoolWaypoint;

	private String complDateDW;
	private String complDateSanitation;
	private String runningwater;
	
	

	public String getComplDateDW() {
		return complDateDW;
	}

	public void setComplDateDW(String complDateDW) {
		this.complDateDW = complDateDW;
	}

	public String getComplDateSanitation() {
		return complDateSanitation;
	}

	public void setComplDateSanitation(String complDateSanitation) {
		this.complDateSanitation = complDateSanitation;
	}

	/**
	 * @return Returns the schoolElevation.
	 */
	public String getSchoolElevation() {
		return schoolElevation;
	}

	/**
	 * @param schoolElevation
	 *            The schoolElevation to set.
	 */
	public void setSchoolElevation(String schoolElevation) {
		this.schoolElevation = schoolElevation;
	}

	/**
	 * @return Returns the schoolLatitude.
	 */
	public String getSchoolLatitude() {
		return schoolLatitude;
	}

	/**
	 * @param schoolLatitude
	 *            The schoolLatitude to set.
	 */
	public void setSchoolLatitude(String schoolLatitude) {
		this.schoolLatitude = schoolLatitude;
	}

	/**
	 * @return Returns the schoolLongitude.
	 */
	public String getSchoolLongitude() {
		return schoolLongitude;
	}

	/**
	 * @param schoolLongitude
	 *            The schoolLongitude to set.
	 */
	public void setSchoolLongitude(String schoolLongitude) {
		this.schoolLongitude = schoolLongitude;
	}

	/**
	 * @return Returns the schoolWaypoint.
	 */
	public String getSchoolWaypoint() {
		return schoolWaypoint;
	}

	/**
	 * @param schoolWaypoint
	 *            The schoolWaypoint to set.
	 */
	public void setSchoolWaypoint(String schoolWaypoint) {
		this.schoolWaypoint = schoolWaypoint;
	}

	// Added on 13-01-2012

	private String schoolName;
	private String mode;
	private String noBoys;
	private String noGirls;
	private String schoolCode;
	private String schoolLoc;
	private String schoolDetails;

	private String noStudents1;
	private String noBoys1;
	private String noGirls1;
	private String assetTypeCode;

	ArrayList list;

	String dname;
	String mname;
	String pname;
	String vname;
	String habname;
	String habCode;
	String schoolname;
	String students;
	String boysgirls;
	String classification;
	String schoolcode;
	String assetCode;
	String update;

	ArrayList assetTypes;
	ArrayList assetsList;

	public void reset(ActionMapping mapping, HttpServletRequest request) {
		this.district = "-1";
		this.mandal = "-1";
		this.panchayat = "-1";
		this.village = "-1";
		this.habitation = "-1";
		this.schoolName = "";
		this.noBoys = "";
		this.noGirls = "";
		this.noStudents = "";

		this.category = "";
		this.classify = "";
		this.noStudents = "";
		this.facilities = "";
		this.toilets = "";
		this.urinals = "";
		this.nonDrink = "";
		this.nonSani = "";
		this.drkMonth = "";
		this.drkYear = "";
		this.saniMonth = "";
		this.saniYear = "";
		this.sourceDrkFund = "";
		this.sourceSaniFund = "";
		this.mode = "";
		this.schoolCode = "";
		this.schoolLoc = "";
		this.habName = "";

		this.noStudents1 = "";
		this.noBoys1 = "";
		this.noGirls1 = "";

	}

	public String getSourceSaniFund() {
		return sourceSaniFund;
	}

	public void setSourceSaniFund(String sourceSaniFund) {
		this.sourceSaniFund = sourceSaniFund;
	}

	/**
	 * @return Returns the distName.
	 */
	public String getDistName() {
		return distName;
	}

	/**
	 * @param distName
	 *            The distName to set.
	 */
	public void setDistName(String distName) {
		this.distName = distName;
	}

	/**
	 * @return Returns the mandName.
	 */
	public String getMandName() {
		return mandName;
	}

	/**
	 * @param mandName
	 *            The mandName to set.
	 */
	public void setMandName(String mandName) {
		this.mandName = mandName;
	}

	/**
	 * @return Returns the panchName.
	 */
	public String getPanchName() {
		return panchName;
	}

	/**
	 * @param panchName
	 *            The panchName to set.
	 */
	public void setPanchName(String panchName) {
		this.panchName = panchName;
	}

	/**
	 * @return Returns the villName.
	 */
	public String getVillName() {
		return villName;
	}

	/**
	 * @param villName
	 *            The villName to set.
	 */
	public void setVillName(String villName) {
		this.villName = villName;
	}

	/**
	 * @return Returns the noBoys1.
	 */
	public String getNoBoys1() {
		return noBoys1;
	}

	/**
	 * @param noBoys1
	 *            The noBoys1 to set.
	 */
	public void setNoBoys1(String noBoys1) {
		this.noBoys1 = noBoys1;
	}

	/**
	 * @return Returns the noGirls1.
	 */
	public String getNoGirls1() {
		return noGirls1;
	}

	/**
	 * @param noGirls1
	 *            The noGirls1 to set.
	 */
	public void setNoGirls1(String noGirls1) {
		this.noGirls1 = noGirls1;
	}

	/**
	 * @return Returns the noStudents1.
	 */
	public String getNoStudents1() {
		return noStudents1;
	}

	/**
	 * @param noStudents1
	 *            The noStudents1 to set.
	 */
	public void setNoStudents1(String noStudents1) {
		this.noStudents1 = noStudents1;
	}

	/**
	 * @return Returns the habName.
	 */
	public String getHabName() {
		return habName;
	}

	/**
	 * @param habName
	 *            The habName to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
	}

	/**
	 * @return Returns the schoolLoc.
	 */
	public String getSchoolLoc() {
		return schoolLoc;
	}

	/**
	 * @param schoolLoc
	 *            The schoolLoc to set.
	 */
	public void setSchoolLoc(String schoolLoc) {
		this.schoolLoc = schoolLoc;
	}

	/**
	 * @return Returns the schoolCode.
	 */
	public String getSchoolCode() {
		return schoolCode;
	}

	/**
	 * @param schoolCode
	 *            The schoolCode to set.
	 */
	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}

	/**
	 * @return Returns the noBoys.
	 */
	public String getNoBoys() {
		return noBoys;
	}

	/**
	 * @param noBoys
	 *            The noBoys to set.
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
	 * @param noGirls
	 *            The noGirls to set.
	 */
	public void setNoGirls(String noGirls) {
		this.noGirls = noGirls;
	}

	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}

	/**
	 * @param mode
	 *            The mode to set.
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
	 * @param category
	 *            The category to set.
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
	 * @param classify
	 *            The classify to set.
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
	 * @param district
	 *            The district to set.
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
	 * @param drkMonth
	 *            The drkMonth to set.
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
	 * @param drkYear
	 *            The drkYear to set.
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
	 * @param facilities
	 *            The facilities to set.
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
	 * @param habitation
	 *            The habitation to set.
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
	 * @param mandal
	 *            The mandal to set.
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
	 * @param nonDrink
	 *            The nonDrink to set.
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
	 * @param nonSani
	 *            The nonSani to set.
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
	 * @param noStudents
	 *            The noStudents to set.
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
	 * @param panchayat
	 *            The panchayat to set.
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
	 * @param saniMonth
	 *            The saniMonth to set.
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
	 * @param saniYear
	 *            The saniYear to set.
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
	 * @param schoolName
	 *            The schoolName to set.
	 */
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public String getSourceDrkFund() {
		return sourceDrkFund;
	}

	public void setSourceDrkFund(String sourceDrkFund) {
		this.sourceDrkFund = sourceDrkFund;
	}

	public String getToilets() {
		return toilets;
	}

	/**
	 * @param toilets
	 *            The toilets to set.
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
	 * @param urinals
	 *            The urinals to set.
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
	 * @param village
	 *            The village to set.
	 */
	public void setVillage(String village) {
		this.village = village;
	}

	public String getSchoolDetails() {
		return schoolDetails;
	}

	public void setSchoolDetails(String schoolDetails) {
		this.schoolDetails = schoolDetails;
	}

	public String getAssetTypeCode() {
		return assetTypeCode;
	}

	public void setAssetTypeCode(String assetTypeCode) {
		this.assetTypeCode = assetTypeCode;
	}

	public ArrayList getList() {
		return list;
	}

	public void setList(ArrayList list) {
		this.list = list;
	}

	public String getAssetCode() {
		return assetCode;
	}

	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}

	public ArrayList getAssetsList() {
		return assetsList;
	}

	public void setAssetsList(ArrayList assetsList) {
		this.assetsList = assetsList;
	}

	public ArrayList getAssetTypes() {
		return assetTypes;
	}

	public void setAssetTypes(ArrayList assetTypes) {
		this.assetTypes = assetTypes;
	}

	public String getBoysgirls() {
		return boysgirls;
	}

	public void setBoysgirls(String boysgirls) {
		this.boysgirls = boysgirls;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	public String getHabCode() {
		return habCode;
	}

	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}

	public String getHabname() {
		return habname;
	}

	public void setHabname(String habname) {
		this.habname = habname;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getSchoolcode() {
		return schoolcode;
	}

	public void setSchoolcode(String schoolcode) {
		this.schoolcode = schoolcode;
	}

	public String getSchoolname() {
		return schoolname;
	}

	public void setSchoolname(String schoolname) {
		this.schoolname = schoolname;
	}

	public String getStudents() {
		return students;
	}

	public void setStudents(String students) {
		this.students = students;
	}

	public String getUpdate() {
		return update;
	}

	public void setUpdate(String update) {
		this.update = update;
	}

	public String getVname() {
		return vname;
	}

	public void setVname(String vname) {
		this.vname = vname;
	}

	public String getRunningwater() {
		return runningwater;
	}

	public void setRunningwater(String runningwater) {
		this.runningwater = runningwater;
	}

}
