package nic.watersoft.proposals;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.BaseActionForm;
import nic.watersoft.commons.RwsLocationBean;

public class RepresentativeProposalForm extends BaseActionForm 
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
	/*
	 * @ AUTHOR MANOJ
	 */
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
    private String siteHab;
    private String sourceCode;
    private String sourceName;
    //ADDED BY RAMESH
    private String prooved;
 	private String augsch;
 	private String ccode;
    private String expyear;
    private String scheme;
    private Collection works;
    private String divCode;
    private String subDivCode;
 		
    private String sustainDetails;
    private String approoved;
    private String coreDashboardStatus;
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
    
	public RepresentativeProposalForm()
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
	
	public ProposalHolder getWORK(int index)
	{
		while(index >= proposals.size())
		{
			proposals.add(new ProposalHolder());
		}
		return (ProposalHolder)proposals.get(index);
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
	
	public String getApprooved() {
		return approoved;
	}
	public void setApprooved(String approoved) {
		this.approoved = approoved;
	}
	public String getCoreDashboardStatus() {
		return coreDashboardStatus;
	}
	public void setCoreDashboardStatus(String coreDashboardStatus) {
		this.coreDashboardStatus = coreDashboardStatus;
	}
	
}
