package nic.watersoft.drought;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.BaseActionForm;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.drought.DroughtHolder;

public class Rws_Drought_Admin_Sanction_Frm extends BaseActionForm 
{
	
		private String repCode;
		private String constituencyCode;
		private String repName;
		private String location;
		private String repAddress;
		private String repDate;
		private String description;
		private String endorsedBy;
		private String ministerFor;
		private String others;
		private String endorsementNo;
		private String endorsementDate;
		private String recommendations;
		private boolean init;
		private String selectedHabCode;
		private String leadHabitation;
		private String expectedStatus;
		
		private ArrayList proposals;
		private ArrayList habitations;
		private ArrayList proposals1;
		private String circleOfficeCode;
		private String circleOfficeName;
	    private String divisionOfficeCode;
	    private String divisionOfficeName;
		private String typeOfAsset;
	 	private String programs;
	    private String subPrograms;
	    private String workId;
	    private String subdivisionOfficeCode;
	    private String subdivisionOfficeName;
	    private String workCat;
	    private String susType;
	   
		/**
		 * @return Returns the susTypes.
		 */
		public String getSusType() {
			return susType;
		}
		/**
		 * @param susTypes The susTypes to set.
		 */
		public void setSusType(String susType) {
			this.susType = susType;
		}
	    private String siteHab;
	    private String sourceCode;
	    private String sourceName;
	   
	    private String prooved;
	 	private String augsch;
	 	private String ccode;
	    private String expyear;
	    private String scheme;
	    private Collection works;
	    private String divCode;
	    private String subDivCode;
	 		
	    private String sustainDetails;
	    private String tsdate;
	    private String tsno;
	    private String tsamt;
	    private String ssryr;
	    private String srhabcode;
	    private String srtypecode;
	    private String subsrtypecode;
	    private String scrcode;
	    private String workStage;
	    private String sourcecode;
		private String subsourcecode;
		private String sourceSelected;
		private String souCode;
		private String souName;
		private String souLocation;
		private ArrayList sourceDetails;
		private int resultCount;
		private String asttype;
		private String noofhabs;
		private String workType;
		/**
		 * @return Returns the workType.
		 */
		public String getWorkType() {
			return workType;
		}
		/**
		 * @param workType The workType to set.
		 */
		public void setWorkType(String workType) {
			this.workType = workType;
		}
		/**
		 * @return Returns the noofhabs.
		 */
		public String getNoofhabs() {
			return noofhabs;
		}
		/**
		 * @param noofhabs The noofhabs to set.
		 */
		public void setNoofhabs(String noofhabs) {
			this.noofhabs = noofhabs;
		}
		private ArrayList AdministrativeSanctionList1;
		/**
		 * @return Returns the administrativeSanctionList1.
		 */
		public ArrayList getAdministrativeSanctionList1() {
			return AdministrativeSanctionList1;
		}
		/**
		 * @param administrativeSanctionList1 The administrativeSanctionList1 to set.
		 */
		public void setAdministrativeSanctionList1(
				ArrayList administrativeSanctionList1) {
			AdministrativeSanctionList1 = administrativeSanctionList1;
		}
		/**
		 * @return Returns the asttype.
		 */
		public String getAsttype() {
			return asttype;
		}
		/**
		 * @param asttype The asttype to set.
		 */
		public void setAsttype(String asttype) {
			this.asttype = asttype;
		}
		/**
		 * @return Returns the resultCount.
		 */
		public int getResultCount() {
			return resultCount;
		}
		/**
		 * @param resultCount The resultCount to set.
		 */
		public void setResultCount(int resultCount) {
			this.resultCount = resultCount;
		}
		/**
		 * @return Returns the souCode.
		 */
		public String getSouCode() {
			return souCode;
		}
		/**
		 * @param souCode The souCode to set.
		 */
		public void setSouCode(String souCode) {
			this.souCode = souCode;
		}
		/**
		 * @return Returns the souLocation.
		 */
		public String getSouLocation() {
			return souLocation;
		}
		/**
		 * @param souLocation The souLocation to set.
		 */
		public void setSouLocation(String souLocation) {
			this.souLocation = souLocation;
		}
		/**
		 * @return Returns the souName.
		 */
		public String getSouName() {
			return souName;
		}
		/**
		 * @param souName The souName to set.
		 */
		public void setSouName(String souName) {
			this.souName = souName;
		}
		/**
		 * @return Returns the sourceSelected.
		 */
		public String getSourceSelected() {
			return sourceSelected;
		}
		/**
		 * @param sourceSelected The sourceSelected to set.
		 */
		public void setSourceSelected(String sourceSelected) {
			this.sourceSelected = sourceSelected;
		}
		/**
		 * @return Returns the srcode.
		 */
		
		/**
		 * @return Returns the workStage.
		 */
		public String getWorkStage() {
			return workStage;
		}
		/**
		 * @param workStage The workStage to set.
		 */
		public void setWorkStage(String workStage) {
			this.workStage = workStage;
		}
       // Source Identification
		
		
		private String mandalCode;
		private String sitehab;
		private String subcompType;
		
		/**
		 * @return Returns the newsrcCode.
		 */
		public String getNewsrcCode() {
			return newsrcCode;
		}
		/**
		 * @param newsrcCode The newsrcCode to set.
		 */
		public void setNewsrcCode(String newsrcCode) {
			this.newsrcCode = newsrcCode;
		}
		/**
		 * @return Returns the newsrcName.
		 */
		public String getNewsrcName() {
			return newsrcName;
		}
		/**
		 * @param newsrcName The newsrcName to set.
		 */
		public void setNewsrcName(String newsrcName) {
			this.newsrcName = newsrcName;
		}
		/**
		 * @return Returns the panchCode.
		 */
		public String getPanchCode() {
			return panchCode;
		}
		/**
		 * @param panchCode The panchCode to set.
		 */
		public void setPanchCode(String panchCode) {
			this.panchCode = panchCode;
		}
		/**
		 * @return Returns the sitehab.
		 */
		public String getSitehab() {
			return sitehab;
		}
		/**
		 * @param sitehab The sitehab to set.
		 */
		public void setSitehab(String sitehab) {
			this.sitehab = sitehab;
		}
		/**
		 * @return Returns the spradgroup.
		 */
		public String getSpradgroup() {
			return spradgroup;
		}
		/**
		 * @param spradgroup The spradgroup to set.
		 */
		public void setSpradgroup(String spradgroup) {
			this.spradgroup = spradgroup;
		}
		/**
		 * @return Returns the srcCode.
		 */
		public String getSrcCode() {
			return srcCode;
		}
		/**
		 * @param srcCode The srcCode to set.
		 */
		public void setSrcCode(String srcCode) {
			this.srcCode = srcCode;
		}
		/**
		 * @return Returns the srcName.
		 */
		public String getSrcName() {
			return srcName;
		}
		/**
		 * @param srcName The srcName to set.
		 */
		public void setSrcName(String srcName) {
			this.srcName = srcName;
		}
		/**
		 * @return Returns the subcompType.
		 */
		public String getSubcompType() {
			return subcompType;
		}
		/**
		 * @param subcompType The subcompType to set.
		 */
		public void setSubcompType(String subcompType) {
			this.subcompType = subcompType;
		}
		/**
		 * @return Returns the subSourceType.
		 */
		
		private String spradgroup;
		private String srcCode;
		private String srcName;
		private String newsrcCode;
		private String newsrcName;
		private String panchCode;
		private String subSourceType;
		/**
		 * @return Returns the subSourceType.
		 */
		public String getSubSourceType() {
			return subSourceType;
		}
		/**
		 * @param subSourceType The subSourceType to set.
		 */
		public void setSubSourceType(String subSourceType) {
			this.subSourceType = subSourceType;
		}
	    //end
	    
		/**
		 * @return Returns the scrcode.
		 */
		public String getScrcode() {
			return scrcode;
		}
		/**
		 * @param scrcode The scrcode to set.
		 */
		public void setScrcode(String scrcode) {
			this.scrcode = scrcode;
		}
	    private String srname;
	    private String srloc;
	    private String astcode;
	    private String newext;
		private String sitedate;
		private String grounddate;
		private String expupto;
		private String expuptodate;
		private String notpaidvalue;
		private String compdate;
		private String fincompdate;
		private String commdate;
		private ArrayList mandals;
		private ArrayList sourcehabs;
		private String sourceId;
		private ArrayList sources;
		private String habDetails;
		/**
		 * @return Returns the habDetails.
		 */
		public String getHabDetails() {
			return habDetails;
		}
		/**
		 * @param habDetails The habDetails to set.
		 */
		public void setHabDetails(String habDetails) {
			this.habDetails = habDetails;
		}
		/**
		 * @return Returns the sourceId.
		 */
		public String getSourceId() {
			return sourceId;
		}
		/**
		 * @param sourceId The sourceId to set.
		 */
		public void setSourceId(String sourceId) {
			this.sourceId = sourceId;
		}
		/**
		 * @return Returns the sourcehabs.
		 */
		public ArrayList getSourcehabs() {
			return sourcehabs;
		}
		/**
		 * @param sourcehabs The sourcehabs to set.
		 */
		public void setSourcehabs(ArrayList sourcehabs) {
			this.sourcehabs = sourcehabs;
		}
		/**
		 * @return Returns the mandals.
		 */
		public ArrayList getMandals() {
			return mandals;
		}
		/**
		 * @param mandals The mandals to set.
		 */
		public void setMandals(ArrayList mandals) {
			this.mandals = mandals;
		}
		/**
		 * @return Returns the works.
		 */
		public Collection getWorks() {
			return works;
		}
		/**
		 * @param works The works to set.
		 */
		public void setWorks(Collection works) {
			this.works = works;
		}
		/**
		 * @return Returns the ccode.
		 */
		public String getCcode() {
			return ccode;
		}
		/**
		 * @param ccode The ccode to set.
		 */
		public void setCcode(String ccode) {
			this.ccode = ccode;
		}
		/**
		 * @return Returns the expyear.
		 */
		public String getExpyear() {
			return expyear;
		}
		/**
		 * @param expyear The expyear to set.
		 */
		public void setExpyear(String expyear) {
			this.expyear = expyear;
		}
		/**
		 * @return Returns the scheme.
		 */
		public String getScheme() {
			return scheme;
		}
		/**
		 * @param scheme The scheme to set.
		 */
		public void setScheme(String scheme) {
			this.scheme = scheme;
		}
		/**
		 * @return Returns the augsch.
		 */
		public String getAugsch() {
			return augsch;
		}
		/**
		 * @param augsch The augsch to set.
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
		/**
		 * @return Returns the plan.
		 */
		public String getPlan() {
			return plan;
		}
		/**
		 * @param plan The plan to set.
		 */
		public void setPlan(String plan) {
			this.plan = plan;
		}
		/**
		 * @return Returns the wrktype.
		 */
		public String getWrktype() {
			return wrktype;
		}
		
		/**
		 * @param wrktype The wrktype to set.
		 */
		public void setWrktype(String wrktype) {
			this.wrktype = wrktype;
		}
	    private String wrktype;
	    private String plan;
	    
		public Rws_Drought_Admin_Sanction_Frm()
		{
			this.init = true;
			proposals = new ArrayList();
		}
		
		public void setRepCode(String repCode)
		{	this.repCode = repCode;
		}
		public String getRepCode()
		{	return repCode;
		}
		
		public void setConstituencyCode(String constituencyCode)
		{	this.constituencyCode = constituencyCode;
		}
		public String getConstituencyCode()
		{	return constituencyCode;
		}

		public void setRepName(String repName)
		{	this.repName = repName;
		}
		public String getRepName()
		{	return repName;
		}

		public void setRepAddress(String repAddress)
		{	this.repAddress = repAddress;
		}
		public String getRepAddress()
		{	return repAddress;
		}
		
		public void setRepDate(String repDate)
		{	this.repDate = repDate;
		}
		public String getRepDate()
		{	return repDate;
		}

		public void setEndorsedBy(String endorsedBy)
		{	this.endorsedBy = endorsedBy;
		}
		public String getEndorsedBy()
		{	return endorsedBy;
		}
		
		public void setMinisterFor(String ministerFor)
		{	this.ministerFor = ministerFor;
		}
		public String getMinisterFor()
		{	return ministerFor;
		}
		
		public void setOthers(String others)
		{	this.others = others;
		}
		public String getOthers()
		{	return others;
		}
		
		public void setEndorsementNo(String endorsementNo)
		{	this.endorsementNo = endorsementNo;
		}
		public String getEndorsementNo()
		{	return endorsementNo;
		}
		
		public void setEndorsementDate(String endorsementDate)
		{	this.endorsementDate = endorsementDate;
		}
		public String getEndorsementDate()
		{	return endorsementDate;
		}
		
		public void setDescription(String description)
		{	this.description = description;
		}
		public String getDescription()
		{	return description;
		}

		public void setRecommendations(String recommendations)
		{	this.recommendations = recommendations;
		}
		public String getRecommendations()
		{	return recommendations;
		}

		public void setInit(boolean init)
		{	this.init = init;
		}
		public boolean getInit()
		{	return init;
		}
		
		public void setSelectedHabCode(String selectedHabCode)
		{	this.selectedHabCode = selectedHabCode;
		}
		public String getSelectedHabCode()
		{	return selectedHabCode;
		}
		
		public void setLeadHabitation(String leadHabitation)
		{	this.leadHabitation = leadHabitation;
		}
		public String getLeadHabitation()
		{	return leadHabitation;
		}
		
		public void setExpectedStatus(String expectedStatus)
		{	this.expectedStatus = expectedStatus;
		}
		public String getExpectedStatus()
		{	return expectedStatus;
		}
		
		
		public void setProposals(ArrayList proposals)
		{	this.proposals = proposals;
		}
		public ArrayList getProposals()
		{	return proposals;
		}
		
		public DroughtHolder getWORK(int index)
		{
			while(index >= proposals.size())
			{
				proposals.add(new DroughtHolder());
			}
			return (DroughtHolder)proposals.get(index);
		}

		public void setHabitations(ArrayList habitations)
		{	this.habitations = habitations;
		}

		public ArrayList getHabitations()
		{	return habitations;
		}
		
		public RwsLocationBean getHABITATIONS(int index)
		{
			while(index >= habitations.size())
			{
				habitations.add(new RwsLocationBean());
			}
			return (RwsLocationBean)habitations.get(index);
		}
		
		/*public void reset(ActionMapping mapping, HttpServletRequest request)
		{
			HttpSession session = request.getSession();
					
			this.repCode = null;
			this.constituencyCode = null;
			this.repName = null;
			this.repAddress = null;
			this.repDate = null;
			this.description = null;
			this.endorsementNo = null;
			this.endorsementDate = null;
			this.endorsedBy = null;
			this.recommendations = null;
			this.init = true;
			this.selectedHabCode = null;
			this.circleOfficeCode=null;
			this.divisionOfficeCode=null;
			this.typeOfAsset=null;
			this.programs=null;
			this.subPrograms=null;
			this.subdivisionOfficeCode=null;
		}*/
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
		public String getPrograms() {
			return programs;
		}
		public void setPrograms(String programs) {
			this.programs = programs;
		}
		public String getSubPrograms() {
			return subPrograms;
		}
		public void setSubPrograms(String subPrograms) {
			this.subPrograms = subPrograms;
		}
		public String getTypeOfAsset() {
			return typeOfAsset;
		}
		public void setTypeOfAsset(String typeOfAsset) {
			this.typeOfAsset = typeOfAsset;
		}
		public String getWorkId() {
			return workId;
		}
		public void setWorkId(String workId) {
			this.workId = workId;
		}
		/**
		 * @return Returns the subDivision.
		 */
		public String getSubdivisionOfficeCode() {
			return subdivisionOfficeCode;
		}
		/**
		 * @param subDivision The subDivision to set.
		 */
		public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
			this.subdivisionOfficeCode = subdivisionOfficeCode;
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
		 * @return Returns the divisionOfficeName.
		 */
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
		 * @return Returns the siteHab.
		 */
		public String getSiteHab() {
			return siteHab;
		}
		/**
		 * @param siteHab The siteHab to set.
		 */
		public void setSiteHab(String siteHab) {
			this.siteHab = siteHab;
		}
		/**
		 * @return Returns the sourceCode.
		 */
		public String getSourceCode() {
			return sourceCode;
		}
		/**
		 * @param sourceCode The sourceCode to set.
		 */
		public void setSourceCode(String sourceCode) {
			this.sourceCode = sourceCode;
		}
		/**
		 * @return Returns the sourceName.
		 */
		public String getSourceName() {
			return sourceName;
		}
		/**
		 * @param sourceName The sourceName to set.
		 */
		public void setSourceName(String sourceName) {
			this.sourceName = sourceName;
		}
		private String workname;
		private String workid;
		private String admin_no;
		/**
		 * @return Returns the admin_amount.
		 */
		public String getAdmin_amount() {
			return admin_amount;
		}
		/**
		 * @param admin_amount The admin_amount to set.
		 */
		public void setAdmin_amount(String admin_amount) {
			this.admin_amount = admin_amount;
		}
		/**
		 * @return Returns the admin_date.
		 */
		public String getAdmin_date() {
			return admin_date;
		}
		/**
		 * @param admin_date The admin_date to set.
		 */
		public void setAdmin_date(String admin_date) {
			this.admin_date = admin_date;
		}
		/**
		 * @return Returns the admin_no.
		 */
		public String getAdmin_no() {
			return admin_no;
		}
		/**
		 * @param admin_no The admin_no to set.
		 */
		public void setAdmin_no(String admin_no) {
			this.admin_no = admin_no;
		}
		private String admin_date;
		private String admin_amount;
		
		
		/**
		 * @return Returns the workid.
		 */
		public String getWorkid() {
			return workid;
		}
		/**
		 * @param workid The workid to set.
		 */
		public void setWorkid(String workid) {
			this.workid = workid;
		}
		/**
		 * @return Returns the workname.
		 */
		public String getWorkname() {
			return workname;
		}
		/**
		 * @param workname The workname to set.
		 */
		public void setWorkname(String workname) {
			this.workname = workname;
		}
		
		public String getDivCode() {
			return divCode;
		}
		public void setDivCode(String divCode) {
			this.divCode = divCode;
		}
		public String getSubDivCode() {
			return subDivCode;
		}
		public void setSubDivCode(String subDivCode) {
			this.subDivCode = subDivCode;
		}
		
		public String getSustainDetails() {
			return sustainDetails;
		}
		public void setSustainDetails(String sustainDetails) {
			this.sustainDetails = sustainDetails;
		}
		
		public String getLocation() {
			return location;
		}
		public void setLocation(String location) {
			this.location = location;
		}

		/**
		 * @return Returns the astcode.
		 */
		public String getAstcode() {
			return astcode;
		}
		/**
		 * @param astcode The astcode to set.
		 */
		public void setAstcode(String astcode) {
			this.astcode = astcode;
		}
		/**
		 * @return Returns the commdate.
		 */
		public String getCommdate() {
			return commdate;
		}
		/**
		 * @param commdate The commdate to set.
		 */
		public void setCommdate(String commdate) {
			this.commdate = commdate;
		}
		/**
		 * @return Returns the compdate.
		 */
		public String getCompdate() {
			return compdate;
		}
		/**
		 * @param compdate The compdate to set.
		 */
		public void setCompdate(String compdate) {
			this.compdate = compdate;
		}
		/**
		 * @return Returns the expupto.
		 */
		public String getExpupto() {
			return expupto;
		}
		/**
		 * @param expupto The expupto to set.
		 */
		public void setExpupto(String expupto) {
			this.expupto = expupto;
		}
		/**
		 * @return Returns the expuptodate.
		 */
		public String getExpuptodate() {
			return expuptodate;
		}
		/**
		 * @param expuptodate The expuptodate to set.
		 */
		public void setExpuptodate(String expuptodate) {
			this.expuptodate = expuptodate;
		}
		/**
		 * @return Returns the fincompdate.
		 */
		public String getFincompdate() {
			return fincompdate;
		}
		/**
		 * @param fincompdate The fincompdate to set.
		 */
		public void setFincompdate(String fincompdate) {
			this.fincompdate = fincompdate;
		}
		/**
		 * @return Returns the grounddate.
		 */
		public String getGrounddate() {
			return grounddate;
		}
		/**
		 * @param grounddate The grounddate to set.
		 */
		public void setGrounddate(String grounddate) {
			this.grounddate = grounddate;
		}
		/**
		 * @return Returns the newext.
		 */
		public String getNewext() {
			return newext;
		}
		/**
		 * @param newext The newext to set.
		 */
		public void setNewext(String newext) {
			this.newext = newext;
		}
		/**
		 * @return Returns the notpaidvalue.
		 */
		public String getNotpaidvalue() {
			return notpaidvalue;
		}
		/**
		 * @param notpaidvalue The notpaidvalue to set.
		 */
		public void setNotpaidvalue(String notpaidvalue) {
			this.notpaidvalue = notpaidvalue;
		}
		/**
		 * @return Returns the sitedate.
		 */
		public String getSitedate() {
			return sitedate;
		}
		/**
		 * @param sitedate The sitedate to set.
		 */
		public void setSitedate(String sitedate) {
			this.sitedate = sitedate;
		}
		
		/**
		 * @return Returns the srhabcode.
		 */
		public String getSrhabcode() {
			return srhabcode;
		}
		/**
		 * @param srhabcode The srhabcode to set.
		 */
		public void setSrhabcode(String srhabcode) {
			this.srhabcode = srhabcode;
		}
		/**
		 * @return Returns the srloc.
		 */
		public String getSrloc() {
			return srloc;
		}
		/**
		 * @param srloc The srloc to set.
		 */
		public void setSrloc(String srloc) {
			this.srloc = srloc;
		}
		/**
		 * @return Returns the srname.
		 */
		public String getSrname() {
			return srname;
		}
		/**
		 * @param srname The srname to set.
		 */
		public void setSrname(String srname) {
			this.srname = srname;
		}
		/**
		 * @return Returns the srtypecode.
		 */
		public String getSrtypecode() {
			return srtypecode;
		}
		/**
		 * @param srtypecode The srtypecode to set.
		 */
		public void setSrtypecode(String srtypecode) {
			this.srtypecode = srtypecode;
		}
		/**
		 * @return Returns the ssryr.
		 */
		public String getSsryr() {
			return ssryr;
		}
		/**
		 * @param ssryr The ssryr to set.
		 */
		public void setSsryr(String ssryr) {
			this.ssryr = ssryr;
		}
		/**
		 * @return Returns the subsrtypecode.
		 */
		public String getSubsrtypecode() {
			return subsrtypecode;
		}
		/**
		 * @param subsrtypecode The subsrtypecode to set.
		 */
		public void setSubsrtypecode(String subsrtypecode) {
			this.subsrtypecode = subsrtypecode;
		}
		/**
		 * @return Returns the tsamt.
		 */
		public String getTsamt() {
			return tsamt;
		}
		/**
		 * @param tsamt The tsamt to set.
		 */
		public void setTsamt(String tsamt) {
			this.tsamt = tsamt;
		}
		/**
		 * @return Returns the tsdate.
		 */
		public String getTsdate() {
			return tsdate;
		}
		/**
		 * @param tsdate The tsdate to set.
		 */
		public void setTsdate(String tsdate) {
			this.tsdate = tsdate;
		}
		/**
		 * @return Returns the tsno.
		 */
		public String getTsno() {
			return tsno;
		}
		/**
		 * @param tsno The tsno to set.
		 */
		public void setTsno(String tsno) {
			this.tsno = tsno;
		}
		/**
		 * @return Returns the codeStatus.
		 */
		
		/**
		 * @return Returns the mandalCode.
		 */
		public String getMandalCode() {
			return mandalCode;
		}
		/**
		 * @param mandalCode The mandalCode to set.
		 */
		public void setMandalCode(String mandalCode) {
			this.mandalCode = mandalCode;
		}
		
		
		
		
		/**
		 * @return Returns the sourcecode.
		 */
		public String getSourcecode() {
			return sourcecode;
		}
		/**
		 * @param sourcecode The sourcecode to set.
		 */
		public void setSourcecode(String sourcecode) {
			this.sourcecode = sourcecode;
		}
		/**
		 * @return Returns the subsourcecode.
		 */
		public String getSubsourcecode() {
			return subsourcecode;
		}
		/**
		 * @param subsourcecode The subsourcecode to set.
		 */
		public void setSubsourcecode(String subsourcecode) {
			this.subsourcecode = subsourcecode;
		}
		/**
		 * @return Returns the sources.
		 */
		public ArrayList getSources() {
			return sources;
		}
		/**
		 * @param sources The sources to set.
		 */
		public void setSources(ArrayList sources) {
			this.sources = sources;
		}
		/**
		 * @return Returns the sourceDetails.
		 */
		public ArrayList getSourceDetails() {
			return sourceDetails;
		}
		/**
		 * @param sourceDetails The sourceDetails to set.
		 */
		public void setSourceDetails(ArrayList sourceDetails) {
			this.sourceDetails = sourceDetails;
		}
		/**
		 * @return Returns the proposals1.
		 */
		public ArrayList getProposals1() {
			return proposals1;
		}
		/**
		 * @param proposals1 The proposals1 to set.
		 */
		public void setProposals1(ArrayList proposals1) {
			this.proposals1 = proposals1;
		}
}
