/*
 * Created on Dec 21, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.io.Serializable;

/**
 * @author NIC-APSU-RD
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsLocationBean implements Serializable {
	
    private String year;
	private String districtCode;
	private String districtName;
	private String mandalCode;
	private String mandalName;
	private String panchayatCode;
	private String panchayatName;
	private String villageCode;
	private String villageName;
	private String urbanDistCode;
	private String urbanDistName;
	private String urbanMandCode;
	private String urbanMandName;
	private String municipalityCode;
	private String municipalityName;
	private String wardCode;
	private String wardName;
	private String LocalityCode;
	private String LocalityName;
	private String habitationCode;
	private String habCode;
	private String habName;
	private String codeName;
	private String population;
	private String status;
	private String leadHabitation;
	private String proposalId;
	private String AssemblyCode;
	private String AssemblyName;
	private String habMatch;
	private String constituencyCode;
	private String constituencyName;
	// added by ramesh on 19112010 for work completion form changes
	private String standPosts;
	private String houseCons;
	private String houseHolds;
	// added by swapna on 07-04-2011 for labs display
	private String divisionCode;
	private String divisionName;
	private String labCode;
	private String labName;
	// added by swapan on 16-04-2011 for displaying school details
	private String location;
	private String schoolCode;
	private String schoolName;
	private String schoolLocation;
	private String schoolClasification;
	private String noofStudents;
	private String facilities;

	private String distributionLength;
	
	private String actHouseCons;
	private String actHouseHolds;
	private String currMonthHC;
	private String invTapTot;
	private String invTapCurr;
	private String schoolTapTot;
	private String schoolTapCurr;
	private String balHouseConn;
	private String tothouseconnIMIS;
	private String tothouseholdsIMIS;
	private String aganwadiTaptot;
	private String aganwadiTapCurr;	
	private String pendingFHTC;
	private String schNoofTapConn;
	private String piCode;
	private String piLocation;
	private String piCategory;
	private String piAvailTapConn;
	private String pis_no_tap_conn;
	
	public String getPendingFHTC() {
		return pendingFHTC;
	}

	public void setPendingFHTC(String pendingFHTC) {
		this.pendingFHTC = pendingFHTC;
	}

	public String getUrbanDistCode() {
		return urbanDistCode;
	}

	public void setUrbanDistCode(String urbanDistCode) {
		this.urbanDistCode = urbanDistCode;
	}

	public String getUrbanDistName() {
		return urbanDistName;
	}

	public void setUrbanDistName(String urbanDistName) {
		this.urbanDistName = urbanDistName;
	}

	public String getUrbanMandCode() {
		return urbanMandCode;
	}

	public void setUrbanMandCode(String urbanMandCode) {
		this.urbanMandCode = urbanMandCode;
	}

	public String getUrbanMandName() {
		return urbanMandName;
	}

	public void setUrbanMandName(String urbanMandName) {
		this.urbanMandName = urbanMandName;
	}

	public String getMunicipalityCode() {
		return municipalityCode;
	}

	public void setMunicipalityCode(String municipalityCode) {
		this.municipalityCode = municipalityCode;
	}

	public String getMunicipalityName() {
		return municipalityName;
	}

	public void setMunicipalityName(String municipalityName) {
		this.municipalityName = municipalityName;
	}

	public String getWardCode() {
		return wardCode;
	}

	public void setWardCode(String wardCode) {
		this.wardCode = wardCode;
	}

	public String getWardName() {
		return wardName;
	}

	public void setWardName(String wardName) {
		this.wardName = wardName;
	}

	public String getLocalityCode() {
		return LocalityCode;
	}

	public void setLocalityCode(String localityCode) {
		LocalityCode = localityCode;
	}

	public String getLocalityName() {
		return LocalityName;
	}

	public void setLocalityName(String localityName) {
		LocalityName = localityName;
	}

	/**
	 * @return Returns the codeName.
	 */
	public String getCodeName() {
		return codeName;
	}

	/**
	 * @param codeName
	 *            The codeName to set.
	 */
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}

	/**
	 * @return Returns the districtCode.
	 */
	public String getDistrictCode() {
		return districtCode;
	}

	/**
	 * @param districtCode
	 *            The districtCode to set.
	 */
	public void setDistrictCode(String districtCode) {
		this.districtCode = districtCode;
	}

	/**
	 * @return Returns the districtName.
	 */
	public String getDistrictName() {
		return districtName;
	}

	/**
	 * @param districtName
	 *            The districtName to set.
	 */
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	/**
	 * @return Returns the habCode.
	 */
	public String getHabCode() {
		return habCode;
	}

	/**
	 * @param habCode
	 *            The habCode to set.
	 */
	public void setHabCode(String habCode) {
		this.habCode = habCode;
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
	 * @return Returns the mandalCode.
	 */
	public String getMandalCode() {
		return mandalCode;
	}

	/**
	 * @param mandalCode
	 *            The mandalCode to set.
	 */
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
	}

	/**
	 * @return Returns the mandalName.
	 */
	public String getMandalName() {
		return mandalName;
	}

	/**
	 * @param mandalName
	 *            The mandalName to set.
	 */
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}

	/**
	 * @return Returns the panchayatCode.
	 */
	public String getPanchayatCode() {
		return panchayatCode;
	}

	/**
	 * @param panchayatCode
	 *            The panchayatCode to set.
	 */
	public void setPanchayatCode(String panchayatCode) {
		this.panchayatCode = panchayatCode;
	}

	/**
	 * @return Returns the panchayatName.
	 */
	public String getPanchayatName() {
		return panchayatName;
	}

	/**
	 * @param panchayatName
	 *            The panchayatName to set.
	 */
	public void setPanchayatName(String panchayatName) {
		this.panchayatName = panchayatName;
	}

	/**
	 * @return Returns the villageCode.
	 */
	public String getVillageCode() {
		return villageCode;
	}

	/**
	 * @param villageCode
	 *            The villageCode to set.
	 */
	public void setVillageCode(String villageCode) {
		this.villageCode = villageCode;
	}

	/**
	 * @return Returns the villageName.
	 */
	public String getVillageName() {
		return villageName;
	}

	/**
	 * @param villageName
	 *            The villageName to set.
	 */
	public void setVillageName(String villageName) {
		this.villageName = villageName;
	}

	/**
	 * @return Returns the leadHabitation.
	 */
	public String getLeadHabitation() {
		return leadHabitation;
	}

	/**
	 * @param leadHabitation
	 *            The leadHabitation to set.
	 */
	public void setLeadHabitation(String leadHabitation) {
		this.leadHabitation = leadHabitation;
	}

	/**
	 * @return Returns the population.
	 */
	public String getPopulation() {
		return population;
	}

	/**
	 * @param population
	 *            The population to set.
	 */
	public void setPopulation(String population) {
		this.population = population;
	}

	/**
	 * @return Returns the status.
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status
	 *            The status to set.
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return Returns the proposalId.
	 */
	public String getProposalId() {
		return proposalId;
	}

	/**
	 * @param proposalId
	 *            The proposalId to set.
	 */
	public void setProposalId(String proposalId) {
		this.proposalId = proposalId;
	}

	/**
	 * @return Returns the habitationCode.
	 */
	public String getHabitationCode() {
		return habitationCode;
	}

	/**
	 * @param habitationCode
	 *            The habitationCode to set.
	 */
	public void setHabitationCode(String habitationCode) {
		this.habitationCode = habitationCode;
	}

	public String getAssemblyCode() {
		return AssemblyCode;
	}

	public void setAssemblyCode(String assemblyCode) {
		AssemblyCode = assemblyCode;
	}

	public String getAssemblyName() {
		return AssemblyName;
	}

	public void setAssemblyName(String assemblyName) {
		AssemblyName = assemblyName;
	}

	public String getHabMatch() {
		return habMatch;
	}

	public void setHabMatch(String habMatch) {
		this.habMatch = habMatch;
	}

	public String getConstituencyCode() {
		return constituencyCode;
	}

	public void setConstituencyCode(String constituencyCode) {
		this.constituencyCode = constituencyCode;
	}

	public String getConstituencyName() {
		return constituencyName;
	}

	public void setConstituencyName(String constituencyName) {
		this.constituencyName = constituencyName;
	}

	public String getStandPosts() {
		return standPosts;
	}

	public void setStandPosts(String standPosts) {
		this.standPosts = standPosts;
	}

	public String getHouseCons() {
		return houseCons;
	}

	public void setHouseCons(String houseCons) {
		this.houseCons = houseCons;
	}

	public String getHouseHolds() {
		return houseHolds;
	}

	public void setHouseHolds(String houseHolds) {
		this.houseHolds = houseHolds;
	}

	public String getDivisionCode() {
		return divisionCode;
	}

	public void setDivisionCode(String divisionCode) {
		this.divisionCode = divisionCode;
	}

	public String getDivisionName() {
		return divisionName;
	}

	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}

	public String getLabCode() {
		return labCode;
	}

	public void setLabCode(String labCode) {
		this.labCode = labCode;
	}

	public String getLabName() {
		return labName;
	}

	public void setLabName(String labName) {
		this.labName = labName;
	}

	public String getFacilities() {
		return facilities;
	}

	public void setFacilities(String facilities) {
		this.facilities = facilities;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getNoofStudents() {
		return noofStudents;
	}

	public void setNoofStudents(String noofStudents) {
		this.noofStudents = noofStudents;
	}

	public String getSchoolClasification() {
		return schoolClasification;
	}

	public void setSchoolClasification(String schoolClasification) {
		this.schoolClasification = schoolClasification;
	}

	public String getSchoolCode() {
		return schoolCode;
	}

	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}

	public String getSchoolLocation() {
		return schoolLocation;
	}

	public void setSchoolLocation(String schoolLocation) {
		this.schoolLocation = schoolLocation;
	}

	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public void setDistributionLength(String distributionLength) {
		this.distributionLength = distributionLength;
	}

	public String getDistributionLength() {
		return distributionLength;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getYear() {
		return year;
	}

	public String getActHouseCons() {
		return actHouseCons;
	}

	public void setActHouseCons(String actHouseCons) {
		this.actHouseCons = actHouseCons;
	}

	public String getActHouseHolds() {
		return actHouseHolds;
	}

	public void setActHouseHolds(String actHouseHolds) {
		this.actHouseHolds = actHouseHolds;
	}

	public String getCurrMonthHC() {
		return currMonthHC;
	}

	public void setCurrMonthHC(String currMonthHC) {
		this.currMonthHC = currMonthHC;
	}

	public String getInvTapTot() {
		return invTapTot;
	}

	public void setInvTapTot(String invTapTot) {
		this.invTapTot = invTapTot;
	}

	public String getInvTapCurr() {
		return invTapCurr;
	}

	public void setInvTapCurr(String invTapCurr) {
		this.invTapCurr = invTapCurr;
	}

	public String getSchoolTapTot() {
		return schoolTapTot;
	}

	public void setSchoolTapTot(String schoolTapTot) {
		this.schoolTapTot = schoolTapTot;
	}

	public String getSchoolTapCurr() {
		return schoolTapCurr;
	}

	public void setSchoolTapCurr(String schoolTapCurr) {
		this.schoolTapCurr = schoolTapCurr;
	}

	public String getBalHouseConn() {
		return balHouseConn;
	}

	public void setBalHouseConn(String balHouseConn) {
		this.balHouseConn = balHouseConn;
	}

	public String getTothouseconnIMIS() {
		return tothouseconnIMIS;
	}

	public void setTothouseconnIMIS(String tothouseconnIMIS) {
		this.tothouseconnIMIS = tothouseconnIMIS;
	}

	public String getTothouseholdsIMIS() {
		return tothouseholdsIMIS;
	}

	public void setTothouseholdsIMIS(String tothouseholdsIMIS) {
		this.tothouseholdsIMIS = tothouseholdsIMIS;
	}

	public String getAganwadiTaptot() {
		return aganwadiTaptot;
	}

	public void setAganwadiTaptot(String aganwadiTaptot) {
		this.aganwadiTaptot = aganwadiTaptot;
	}

	public String getAganwadiTapCurr() {
		return aganwadiTapCurr;
	}

	public void setAganwadiTapCurr(String aganwadiTapCurr) {
		this.aganwadiTapCurr = aganwadiTapCurr;
	}

	public String getSchNoofTapConn() {
		return schNoofTapConn;
	}

	public void setSchNoofTapConn(String schNoofTapConn) {
		this.schNoofTapConn = schNoofTapConn;
	}

	public String getPiCode() {
		return piCode;
	}

	public void setPiCode(String piCode) {
		this.piCode = piCode;
	}

	public String getPiLocation() {
		return piLocation;
	}

	public void setPiLocation(String piLocation) {
		this.piLocation = piLocation;
	}

	public String getPiCategory() {
		return piCategory;
	}

	public void setPiCategory(String piCategory) {
		this.piCategory = piCategory;
	}

	public String getPiAvailTapConn() {
		return piAvailTapConn;
	}

	public void setPiAvailTapConn(String piAvailTapConn) {
		this.piAvailTapConn = piAvailTapConn;
	}

	public String getPis_no_tap_conn() {
		return pis_no_tap_conn;
	}

	public void setPis_no_tap_conn(String pis_no_tap_conn) {
		this.pis_no_tap_conn = pis_no_tap_conn;
	}

	
}
