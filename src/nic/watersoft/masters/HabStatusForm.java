package nic.watersoft.masters;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;


/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class HabStatusForm extends ActionForm
{
	//ADDED BY NAGENDRA KANKATALA 06/04/2020
	private int actPlainPop;
	private int actScPop;
	private int actStPop;
	private int actHouseHold;
	private int actHouseConn;
	private int actTotPop;
	
	
	public int getActTotPop() {
		return actTotPop;
	}
	public void setActTotPop(int actTotPop) {
		this.actTotPop = actTotPop;
	}
	public int getActPlainPop() {
		return actPlainPop;
	}
	public void setActPlainPop(int actPlainPop) {
		this.actPlainPop = actPlainPop;
	}
	public int getActScPop() {
		return actScPop;
	}
	public void setActScPop(int actScPop) {
		this.actScPop = actScPop;
	}
	public int getActStPop() {
		return actStPop;
	}
	public void setActStPop(int actStPop) {
		this.actStPop = actStPop;
	}
	public int getActHouseHold() {
		return actHouseHold;
	}
	public void setActHouseHold(int actHouseHold) {
		this.actHouseHold = actHouseHold;
	}
	public int getActHouseConn() {
		return actHouseConn;
	}
	public void setActHouseConn(int actHouseConn) {
		this.actHouseConn = actHouseConn;
	}
	
	
	
	//added by swapna on 19-12-2011
	private int plainHCon;
	private int stHCon;
	private int scHCon;
	
	private int plainHHold;
	private int stHHold;
	private int scHHold;
//	added by swapna on 12-01-2011
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
	//added by swapna on 23-01-2012
	private String landmark;
	//
//	added by swapna on 30-01-2012
	private int minorityHCon;
	private int minorityHHold;
	
//	added by swapna on 01-02-2012
	private int minorityCovered;
//	added by swapna on 02-02-2012
	private int censusMinority;
//	added by swapna 02-04-2011
	private String isItda;
	//
//	 added by sadiq
	private int houseConn;
	private String officeCode;
	private String officeName;
	private String headOfficeCode;
	private String headOfficeName;
	private String circleOfficeCode;
	private String circleOfficeName;
	private String divisionOfficeCode;
	private String divisionOfficeName;
	private String subdivisionOfficeCode;
	private String subdivisionOfficeName;
	
	 //end
	private String coc;
	private String doc;
	private String sdoc;
	private String district;
	private String dcode;
	private String districtName;
	
	private String dname;
	private String mcode;
	private String mname;
	
	
	
	private String mandal;
	private String panchayat;
	private String village;
	private String constituency;
	private String habitation;
	private String pcode;
	private String pname;
	private String vname;
	private String vcode;
	
//	added by ramesh
	private String district1;
	private String mandal1;
	private String panchayat1;
	private String village1;
	private String constituency1;
	private String habitation1;
	private String habName1;
	
	private String hcode;
	private String prcode;
	private String prHabName;
	
 	private String habCode;
 	private String existingHabCode;
 	private String mandalName;
    private String con;
    private String don;
    private String sdon;
    private String habName;
	private String censusYear;
	private int censusPop;
	private int censusSc;
	private int censusSt;
	private int totPop;
	private int floatPop;
	private String floatReason;
	private int netPop;
	private String habYear;
	private int popCovered;
	private int scCovered;
	private int stCovered;
	private int totPopCvrd;
	private String coveredStatus;
	private String statusDate;
	private String statusAsOn1405;
	private String updateDate;
	private int totalWaterSupply;
	private int totalWaterSupplySafe;
	private int totalWaterSupplyUnsafe;
	private int totalWaterSupplySafeOnly;
	private String levelOfWaterSupplySafeOnly;
	
	private int existWaterLevel;
	private float nearWaterSource;
	private float nearWaterGroundSource;
	private String qualityAffected;
	
	private String prevYrStatus="";       
	private String presentvYrStatus="";  
	private String proposedFcYr;
	private float proposedFCAmt;


	
	private String remarks;
	private String contType="";
	private String percent="";
	private String contName="";
	private String buttonName;
	
	
	
	private Collection habInsts;
	private Collection habWaterSupply;
	private Collection contaminations;
	private String mode;
	private boolean init;
	private boolean contaminationDetailsEntryFrmInit;
	
	private String dcode1;
	private String mcode1;
	private String vcode1;
	private String pcode1;
	
	private String shpSupply;
	private String shpNo;
	private String cisternsSupply;
	private String cisternsNo;
	private String glsrSupply;
	private String glsrNo;
	private String ohsrSupply;
	private String ohsrNo;
	private String drinkTotalSupply;
	private String drinkTotalNo;
	private String hpSupply;
	private String hpNo;
	private String owsSupply;
	private String owsNo;
	private String pondsSupply;
	private String pondsNo;
	private String shwSupply;
	private String shwNo;
	private String otherTotalSupply;
	private String otherTotalNo;
	private String pcpdDrink;
	private String pcpdOthers;
	private String pcpdTotal;
	private String levelOfWaterSupply;
	private String lpcdCooking;
	private String pwsSupply;
	private String pwsNo;
	private String cpwsNo;
	private String cpwsSupply;
	private String mpwsSupply;
	private String mpwsNo;
	private String othersSafeSupply;
	private String othersSafeeNo;
	private String dpSupply;
	private String dpNo;
	private String dwNo;
	private String dwSupply;
	private String cattleSupply;
	private String cattleNo;
	
	private String status;
	//private String totOthersSuppl;
	private String totOthersSupply;
	private String totOthersNo;
	
	private String othersNo;
	private String othersSupply;
	
	private HabWaterSupply waterSupply; 
	
	private String brakish;
	private String flouride;
	private String iron;
	private String aresenic;
	private String nitrate;
	
	
	//////added by anupama 09032015
	
	private String schemesource;
	private int glsrno;
	public int getGlsrno() {
		return glsrno;
	}
	public void setGlsrno(int glsrno) {
		this.glsrno = glsrno;
	}
	public int getGlsrqty() {
		return glsrqty;
	}
	public void setGlsrqty(int glsrqty) {
		this.glsrqty = glsrqty;
	}
	public int getOhsrno() {
		return ohsrno;
	}
	public void setOhsrno(int ohsrno) {
		this.ohsrno = ohsrno;
	}
	public int getOhsrqty() {
		return ohsrqty;
	}
	public void setOhsrqty(int ohsrqty) {
		this.ohsrqty = ohsrqty;
	}
	private int glsrqty;
	private int ohsrno;
	private int ohsrqty;
	
	
	
	//////////////////
	//added by Sai Prasad on 21/04/2012
	
	
	private String safeSHPNo;
	private String safeSHPSupply;
	
	//added by jyothi on 24/09/2014
	
	private int publicTap;
	private int publicStandpost;	
	
	private int existCheckDams;
	private int reqCheckDams;
	private String linkageHabSupply;
	
	
	
	
	public String getLinkageHabSupply() {
		return linkageHabSupply;
	}
	public void setLinkageHabSupply(String linkageHabSupply) {
		this.linkageHabSupply = linkageHabSupply;
	}
	public int getExistCheckDams() {
		return existCheckDams;
	}
	public void setExistCheckDams(int existCheckDams) {
		this.existCheckDams = existCheckDams;
	}
	public int getReqCheckDams() {
		return reqCheckDams;
	}
	public void setReqCheckDams(int reqCheckDams) {
		this.reqCheckDams = reqCheckDams;
	}
	public int getPublicTap() {
				return publicTap;
			}
			public void setPublicTap(int publicTap) {
				this.publicTap = publicTap;
			}
			public int getPublicStandpost() {
				return publicStandpost;
			}
			public void setPublicStandpost(int publicStandpost) {
				this.publicStandpost = publicStandpost;
			}
	/**
	 * @return Returns the safeSHPNo.
	 */
	public String getSafeSHPNo() {
		return safeSHPNo;
	}
	/**
	 * @param safeSHPNo The safeSHPNo to set.
	 */
	public void setSafeSHPNo(String safeSHPNo) {
		this.safeSHPNo = safeSHPNo;
	}
	/**
	 * @return Returns the safeSHPSupply.
	 */
	public String getSafeSHPSupply() {
		return safeSHPSupply;
	}
	/**
	 * @param safeSHPSupply The safeSHPSupply to set.
	 */
	public void setSafeSHPSupply(String safeSHPSupply) {
		this.safeSHPSupply = safeSHPSupply;
	}
	private String habType;
	
	//added by Ramesh on 17/09/08
	private String habSubType;
	
//	added by Ramesh on 04/03/10
	private String SlipDivStatus;
	
	/**
	 * @return Returns the habSubType.
	 */
	public String getHabSubType() {
		return habSubType;
	}
	/**
	 * @param habSubType The habSubType to set.
	 */
	public void setHabSubType(String habSubType) {
		this.habSubType = habSubType;
	}
	private int houseHold;
	private int safeSource;
	private int existSource;
	private String habCat;
	private int cattles;
	private String slipReasonCode;
	
	/*
	 * added by ramesh on 250509 for unsafe field addition
	 */

	private String pwsUnsafeNo;
	private String pwsUnsafeSupply;
	private String mpwsUnsafeNo;
	private String mpwsUnsafeSupply;
	private String ncSourceType;
	private String sourceDistance;
	
	/*
	 * added by ramesh 231009 for NSS contaminations
	 */
	
	private String contTypes1;
	private String contTypes2;
	private String contTypes3;
	private String contTypes4;
	private String contTypes5;
	
	//added by ramesh
	private String isMinorityHab;
	private String isLwe;
	private String unsafeLpcd;
	
	public HabStatusForm()
	{
		this.init = true;
		this.contaminationDetailsEntryFrmInit=true;
		habInsts = new ArrayList();
		habWaterSupply = new ArrayList();
		contaminations = new ArrayList();
		
	}
	
	
	
	
	
	/**
	 * @return Returns the habType.
	 */
	public String getHabType() {
		return habType;
	}
	/**
	 * @param habType The habType to set.
	 */
	public void setHabType(String habType) {
		this.habType = habType;
	}
	/**
	 * @return Returns the houseHold.
	 */
	public int getHouseHold() {
		return houseHold;
	}
	/**
	 * @param houseHold The houseHold to set.
	 */
	public void setHouseHold(int houseHold) {
		this.houseHold = houseHold;
	}
	/**
	 * @return Returns the circleOfficeCode.
	 */
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	/**
	 * @param circleOfficeCode The circleOfficeCode to set.
	 */
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
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
	 * @return Returns the divisionOfficeCode.
	 */
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	/**
	 * @param divisionOfficeCode The divisionOfficeCode to set.
	 */
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
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
	 * @return Returns the headOfficeCode.
	 */
	public String getHeadOfficeCode() {
		return headOfficeCode;
	}
	/**
	 * @param headOfficeCode The headOfficeCode to set.
	 */
	public void setHeadOfficeCode(String headOfficeCode) {
		this.headOfficeCode = headOfficeCode;
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
	 * @return Returns the subdivisionOfficeCode.
	 */
	public String getSubdivisionOfficeCode() {
		return subdivisionOfficeCode;
	}
	/**
	 * @param subdivisionOfficeCode The subdivisionOfficeCode to set.
	 */
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
		this.subdivisionOfficeCode = subdivisionOfficeCode;
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
	 * @return Returns the censusPop.
	 */
	public int getCensusPop() {
		return censusPop;
	}
	/**
	 * @param censusPop The censusPop to set.
	 */
	public void setCensusPop(int censusPop) {
		this.censusPop = censusPop;
	}
	/**
	 * @return Returns the censusSc.
	 */
	public int getCensusSc() {
		return censusSc;
	}
	/**
	 * @param censusSc The censusSc to set.
	 */
	public void setCensusSc(int censusSc) {
		this.censusSc = censusSc;
	}
	/**
	 * @return Returns the censusSt.
	 */
	public int getCensusSt() {
		return censusSt;
	}
	/**
	 * @param censusSt The censusSt to set.
	 */
	public void setCensusSt(int censusSt) {
		this.censusSt = censusSt;
	}
	/**
	 * @return Returns the censusYear.
	 */
	public String getCensusYear() {
		return censusYear;
	}
	/**
	 * @param censusYear The censusYear to set.
	 */
	public void setCensusYear(String censusYear) {
		this.censusYear = censusYear;
	}
	/**
	 * @return Returns the coc.
	 */
	public String getCoc() {
		return coc;
	}
	/**
	 * @param coc The coc to set.
	 */
	public void setCoc(String coc)
	{
		this.coc = coc;
	}
	/**
	 * @return Returns the contType.
	 */
	public String getContType() {
		return contType;
	}
	/**
	 * @param contType The contType to set.
	 */
	public void setContType(String contType) {
		this.contType = contType;
	}
	/**
	 * @return Returns the coveredStatus.
	 */
	public String getCoveredStatus() {
		return coveredStatus;
	}
	/**
	 * @param coveredStatus The coveredStatus to set.
	 */
	public void setCoveredStatus(String coveredStatus) {
		this.coveredStatus = coveredStatus;
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
	 * @return Returns the doc.
	 */
	public String getDoc() {
		return doc;
	}
	/**
	 * @param doc The doc to set.
	 */
	public void setDoc(String doc) {
		this.doc = doc;
	}
	/**
	 * @return Returns the existWaterLevel.
	 */
	public int getExistWaterLevel() {
		return existWaterLevel;
	}
	/**
	 * @param existWaterLevel The existWaterLevel to set.
	 */
	public void setExistWaterLevel(int existWaterLevel) {
		this.existWaterLevel = existWaterLevel;
	}
	/**
	 * @return Returns the floatPop.
	 */
	public int getFloatPop() {
		return floatPop;
	}
	/**
	 * @param floatPop The floatPop to set.
	 */
	public void setFloatPop(int floatPop) {
		this.floatPop = floatPop;
	}
	/**
	 * @return Returns the floatReason.
	 */
	public String getFloatReason() {
		return floatReason;
	}
	/**
	 * @param floatReason The floatReason to set.
	 */
	public void setFloatReason(String floatReason) {
		this.floatReason = floatReason;
	}
	/**
	 * @return Returns the habCode.
	 */
	public String getHabCode() {
		return habCode;
	}
	/**
	 * @param habCode The habCode to set.
	 */
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	/**
	 * @return Returns the habInsts.
	 */
	public Collection getHabInsts() {
		return habInsts;
	}
	/**
	 * @param habInsts The habInsts to set.
	 */
	public void setHabInsts(Collection habInsts) {
		this.habInsts = habInsts;
	}
	/**
	 * @return Returns the habWaterSupply.
	 */
	public Collection getHabWaterSupply() {
		return habWaterSupply;
	}
	/**
	 * @param habWaterSupply The habWaterSupply to set.
	 */
	public void setHabWaterSupply(Collection habWaterSupply) {
		this.habWaterSupply = habWaterSupply;
		//System.out.println("HabWaterSupply Size in FormBean " + habWaterSupply.size());
	}
	/**
	 * @return Returns the habYear.
	 */
	public String getHabYear() {
		return habYear;
	}
	/**
	 * @param habYear The habYear to set.
	 */
	public void setHabYear(String habYear) {
		this.habYear = habYear;
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
	 * @return Returns the nearWaterGroundSource.
	 */
	public float getNearWaterGroundSource() {
		return nearWaterGroundSource;
	}
	/**
	 * @param nearWaterGroundSource The nearWaterGroundSource to set.
	 */
	public void setNearWaterGroundSource(float nearWaterGroundSource) {
		this.nearWaterGroundSource = nearWaterGroundSource;
	}
	/**
	 * @return Returns the nearWaterSource.
	 */
	public float getNearWaterSource() {
		return nearWaterSource;
	}
	/**
	 * @param nearWaterSource The nearWaterSource to set.
	 */
	public void setNearWaterSource(float nearWaterSource) {
		this.nearWaterSource = nearWaterSource;
	}
	/**
	 * @return Returns the netPop.
	 */
	public int getNetPop() {
		return netPop;
	}
	/**
	 * @param netPop The netPop to set.
	 */
	public void setNetPop(int netPop) {
		this.netPop = netPop;
	}
	/**
	 * @return Returns the pcode.
	 */
	public String getPcode() {
		return pcode;
	}
	/**
	 * @param pcode The pcode to set.
	 */
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	/**
	 * @return Returns the percent.
	 */
	public String getPercent() {
		return percent;
	}
	/**
	 * @param percent The percent to set.
	 */
	public void setPercent(String percent) {
		this.percent = percent;
	}
	/**
	 * @return Returns the popCovered.
	 */
	public int getPopCovered() {
		return popCovered;
	}
	/**
	 * @param popCovered The popCovered to set.
	 */
	public void setPopCovered(int popCovered) {
		this.popCovered = popCovered;
	}
	/**
	 * @return Returns the remarks.
	 */
	public String getRemarks() {
		return remarks;
	}
	/**
	 * @param remarks The remarks to set.
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	/**
	 * @return Returns the scCovered.
	 */
	public int getScCovered() {
		return scCovered;
	}
	/**
	 * @param scCovered The scCovered to set.
	 */
	public void setScCovered(int scCovered) {
		this.scCovered = scCovered;
	}
	/**
	 * @return Returns the sdoc.
	 */
	public String getSdoc() {
		return sdoc;
	}
	/**
	 * @param sdoc The sdoc to set.
	 */
	public void setSdoc(String sdoc) {
		this.sdoc = sdoc;
	}
	/**
	 * @return Returns the stCovered.
	 */
	public int getStCovered() {
		return stCovered;
	}
	/**
	 * @param stCovered The stCovered to set.
	 */
	public void setStCovered(int stCovered) {
		this.stCovered = stCovered;
	}
	/**
	 * @return Returns the totalWaterSupply.
	 */
	public int getTotalWaterSupply() {
		return totalWaterSupply;
	}
	/**
	 * @param totalWaterSupply The totalWaterSupply to set.
	 */
	public void setTotalWaterSupply(int totalWaterSupply) {
		this.totalWaterSupply = totalWaterSupply;
	}
	/**
	 * @return Returns the totPop.
	 */
	public int getTotPop() {
		return totPop;
	}
	/**
	 * @param totPop The totPop to set.
	 */
	public void setTotPop(int totPop) {
		this.totPop = totPop;
	}
	/**
	 * @return Returns the totPopCvrd.
	 */
	public int getTotPopCvrd() {
		return totPopCvrd;
	}
	/**
	 * @param totPopCvrd The totPopCvrd to set.
	 */
	public void setTotPopCvrd(int totPopCvrd) {
		this.totPopCvrd = totPopCvrd;
	}
	/**
	 * @return Returns the vcode.
	 */
	public String getVcode() {
		return vcode;
	}
	/**
	 * @param vcode The vcode to set.
	 */
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	/**
	 * @return Returns the qualityAffected.
	 */
	public String getQualityAffected() {
		return qualityAffected;
	}
	
	/**
	 * @return Returns the presentvYrStatus.
	 */
	public String getPresentvYrStatus() {
		return presentvYrStatus;
	}
	/**
	 * @param presentvYrStatus The presentvYrStatus to set.
	 */
	public void setPresentvYrStatus(String presentvYrStatus) {
		this.presentvYrStatus = presentvYrStatus;
	}
	/**
	 * @return Returns the prevYrStatus.
	 */
	public String getPrevYrStatus() {
		return prevYrStatus;
	}
	
	/**
	 * @return Returns the proposedFCAmt.
	 */
	public float getProposedFCAmt() {
		return proposedFCAmt;
	}
	/**
	 * @param proposedFCAmt The proposedFCAmt to set.
	 */
	public void setProposedFCAmt(float proposedFCAmt) {
		this.proposedFCAmt = proposedFCAmt;
	}
	/**
	 * @return Returns the proposedFcYr.
	 */
	public String getProposedFcYr() {
		return proposedFcYr;
	}
	/**
	 * @param proposedFcYr The proposedFcYr to set.
	 */
	public void setProposedFcYr(String proposedFcYr) {
		this.proposedFcYr = proposedFcYr;
	}
	/**
	 * @param prevYrStatus The prevYrStatus to set.
	 */
	public void setPrevYrStatus(String prevYrStatus) {
		this.prevYrStatus = prevYrStatus;
	}
	/**
	 * @param qualityAffected The qualityAffected to set.
	 */
	public void setQualityAffected(String qualityAffected) {
		this.qualityAffected = qualityAffected;
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
	 * @return Returns the init.
	 */
	public boolean getInit() {
		return init;
	}
	/**
	 * @param init The init to set.
	 */
	public void setInit(boolean init) {
		this.init = init;
	}
	public HabInstitute getHABINST_LIST(int index)
	{
		while(index >= habInsts.size())
		{
			habInsts.add(new HabInstitute());
		}
		
	return (HabInstitute)((ArrayList) habInsts).get(index);
	}
	
	public HabWaterSupply getHABWATERSUPPLY_LIST(int index)
	{
		while(index >= habWaterSupply.size())
		{
			habWaterSupply.add(new HabWaterSupply());
		}
		
		return (HabWaterSupply)((ArrayList) habWaterSupply).get(index);
	}
	
	public ContaminationTypes getHABCONTAMINATION_LIST(int index)
	{
		while(index >= contaminations.size())
		{
			contaminations.add(new ContaminationTypes());
		}
		
	return (ContaminationTypes)((ArrayList) contaminations).get(index);
	}
	
	/**
	 * @return Returns the contaminations.
	 */
	public Collection getContaminations() {
		return contaminations;
	}
	/**
	 * @param contaminations The contaminations to set.
	 */
	public void setContaminations(Collection contaminations) {
		this.contaminations = contaminations;
	}
	
	
	/**
	 * @return Returns the buttonName.
	 */
	public String getButtonName() {
		return buttonName;
	}
	/**
	 * @param buttonName The buttonName to set.
	 */
	public void setButtonName(String buttonName) {
		this.buttonName = buttonName;
	}
	
	
	/**
	 * @return Returns the dcode.
	 */
	public String getDcode() {
		return dcode;
	}
	/**
	 * @param dcode The dcode to set.
	 */
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	
	
	
	/**
	 * @return Returns the dcode1.
	 */
	public String getDcode1() {
		return dcode1;
	}
	/**
	 * @param dcode1 The dcode1 to set.
	 */
	public void setDcode1(String dcode1) {
		this.dcode1 = dcode1;
	}
	/**
	 * @return Returns the mcode1.
	 */
	public String getMcode1() {
		return mcode1;
	}
	/**
	 * @param mcode1 The mcode1 to set.
	 */
	public void setMcode1(String mcode1) {
		this.mcode1 = mcode1;
	}
	/**
	 * @return Returns the pcode1.
	 */
	public String getPcode1() {
		return pcode1;
	}
	/**
	 * @param pcode1 The pcode1 to set.
	 */
	public void setPcode1(String pcode1) {
		this.pcode1 = pcode1;
	}
	/**
	 * @return Returns the vcode1.
	 */
	public String getVcode1() {
		return vcode1;
	}
	/**
	 * @param vcode1 The vcode1 to set.
	 */
	public void setVcode1(String vcode1) {
		this.vcode1 = vcode1;
	}
	
	
	public String getCisternsNo() {
		return cisternsNo;
	}
	public void setCisternsNo(String cisternsNo) {
		this.cisternsNo = cisternsNo;
	}
	public String getCisternsSupply() {
		return cisternsSupply;
	}
	public void setCisternsSupply(String cisternsSupply) {
		this.cisternsSupply = cisternsSupply;
	}
	public String getDrinkTotalNo() {
		return drinkTotalNo;
	}
	public void setDrinkTotalNo(String drinkTotalNo) {
		this.drinkTotalNo = drinkTotalNo;
	}
	public String getDrinkTotalSupply() {
		return drinkTotalSupply;
	}
	public void setDrinkTotalSupply(String drinkTotalSupply) {
		this.drinkTotalSupply = drinkTotalSupply;
	}
	public String getGlsrNo() {
		return glsrNo;
	}
	public void setGlsrNo(String glsrNo) {
		this.glsrNo = glsrNo;
	}
	public String getGlsrSupply() {
		return glsrSupply;
	}
	public void setGlsrSupply(String glsrSupply) {
		this.glsrSupply = glsrSupply;
	}
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getHpSupply() {
		return hpSupply;
	}
	public void setHpSupply(String hpSupply) {
		this.hpSupply = hpSupply;
	}
	public String getLevelOfWaterSupply() {
		return levelOfWaterSupply;
	}
	public void setLevelOfWaterSupply(String levelOfWaterSupply) {
		this.levelOfWaterSupply = levelOfWaterSupply;
	}
	public String getOhsrNo() {
		return ohsrNo;
	}
	public void setOhsrNo(String ohsrNo) {
		this.ohsrNo = ohsrNo;
	}
	public String getOhsrSupply() {
		return ohsrSupply;
	}
	public void setOhsrSupply(String ohsrSupply) {
		this.ohsrSupply = ohsrSupply;
	}
	public String getOtherTotalNo() {
		return otherTotalNo;
	}
	public void setOtherTotalNo(String otherTotalNo) {
		this.otherTotalNo = otherTotalNo;
	}
	public String getOtherTotalSupply() {
		return otherTotalSupply;
	}
	public void setOtherTotalSupply(String otherTotalSupply) {
		this.otherTotalSupply = otherTotalSupply;
	}
	public String getOwsNo() {
		return owsNo;
	}
	public void setOwsNo(String owsNo) {
		this.owsNo = owsNo;
	}
	public String getOwsSupply() {
		return owsSupply;
	}
	public void setOwsSupply(String owsSupply) {
		this.owsSupply = owsSupply;
	}
	public String getPcpdDrink() {
		return pcpdDrink;
	}
	public void setPcpdDrink(String pcpdDrink) {
		this.pcpdDrink = pcpdDrink;
	}
	public String getPcpdOthers() {
		return pcpdOthers;
	}
	public void setPcpdOthers(String pcpdOthers) {
		this.pcpdOthers = pcpdOthers;
	}
	public String getPcpdTotal() {
		return pcpdTotal;
	}
	public void setPcpdTotal(String pcpdTotal) {
		this.pcpdTotal = pcpdTotal;
	}
	public String getPondsNo() {
		return pondsNo;
	}
	public void setPondsNo(String pondsNo) {
		this.pondsNo = pondsNo;
	}
	public String getPondsSupply() {
		return pondsSupply;
	}
	public void setPondsSupply(String pondsSupply) {
		this.pondsSupply = pondsSupply;
	}
	public String getShpNo() {
		return shpNo;
	}
	public void setShpNo(String shpNo) {
		this.shpNo = shpNo;
	}
	public String getShpSupply() {
		return shpSupply;
	}
	public void setShpSupply(String shpSupply) {
		this.shpSupply = shpSupply;
	}
	public String getShwNo() {
		return shwNo;
	}
	public void setShwNo(String shwNo) {
		this.shwNo = shwNo;
	}
	public String getShwSupply() {
		return shwSupply;
	}
	public void setShwSupply(String shwSupply) {
		this.shwSupply = shwSupply;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public void setWaterSupply(HabWaterSupply waterSupply)
	{	
		this.waterSupply = waterSupply; 
	}
	public HabWaterSupply getWaterSupply()
	{	return waterSupply; 
	}
	
		 
	/**
	 * @return Returns the pname.
	 */
	public String getPname() {
		return pname;
	}
	/**
	 * @param pname The pname to set.
	 */
	public void setPname(String pname) {
		this.pname = pname;
	}
	/**
	 * @return Returns the vname.
	 */
	public String getVname() {
		return vname;
	}
	/**
	 * @param vname The vname to set.
	 */
	public void setVname(String vname) {
		this.vname = vname;
	}
	/**
	 * @return Returns the con.
	 */
	public String getCon() {
		return con;
	}
	/**
	 * @param con The con to set.
	 */
	public void setCon(String con) {
		this.con = con;
	}
	/**
	 * @return Returns the don.
	 */
	public String getDon() {
		return don;
	}
	/**
	 * @param don The don to set.
	 */
	public void setDon(String don) {
		this.don = don;
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
	 * @return Returns the mandalName.
	 */
	public String getMandalName() {
		return mandalName;
	}
	/**
	 * @param mandalName The mandalName to set.
	 */
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	/**
	 * @return Returns the sdon.
	 */
	public String getSdon() {
		return sdon;
	}
	/**
	 * @param sdon The sdon to set.
	 */
	public void setSdon(String sdon) {
		this.sdon = sdon;
	}
	
	
	
	
	/**
	 * @return Returns the cattleNo.
	 */
	public String getCattleNo() {
		return cattleNo;
	}
	/**
	 * @param cattleNo The cattleNo to set.
	 */
	public void setCattleNo(String cattleNo) {
		this.cattleNo = cattleNo;
	}
	/**
	 * @return Returns the cattleSupply.
	 */
	public String getCattleSupply() {
		return cattleSupply;
	}
	/**
	 * @param cattleSupply The cattleSupply to set.
	 */
	public void setCattleSupply(String cattleSupply) {
		this.cattleSupply = cattleSupply;
	}
	/**
	 * @return Returns the cpwsNo.
	 */
	public String getCpwsNo() {
		return cpwsNo;
	}
	/**
	 * @param cpwsNo The cpwsNo to set.
	 */
	public void setCpwsNo(String cpwsNo) {
		this.cpwsNo = cpwsNo;
	}
	/**
	 * @return Returns the cpwsSupply.
	 */
	public String getCpwsSupply() {
		return cpwsSupply;
	}
	/**
	 * @param cpwsSupply The cpwsSupply to set.
	 */
	public void setCpwsSupply(String cpwsSupply) {
		this.cpwsSupply = cpwsSupply;
	}
	/**
	 * @return Returns the dpNo.
	 */
	public String getDpNo() {
		return dpNo;
	}
	/**
	 * @param dpNo The dpNo to set.
	 */
	public void setDpNo(String dpNo) {
		this.dpNo = dpNo;
	}
	/**
	 * @return Returns the dpSupply.
	 */
	public String getDpSupply() {
		return dpSupply;
	}
	/**
	 * @param dpSupply The dpSupply to set.
	 */
	public void setDpSupply(String dpSupply) {
		this.dpSupply = dpSupply;
	}
	/**
	 * @return Returns the dwNo.
	 */
	public String getDwNo() {
		return dwNo;
	}
	/**
	 * @param dwNo The dwNo to set.
	 */
	public void setDwNo(String dwNo) {
		this.dwNo = dwNo;
	}
	/**
	 * @return Returns the dwSupply.
	 */
	public String getDwSupply() {
		return dwSupply;
	}
	/**
	 * @param dwSupply The dwSupply to set.
	 */
	public void setDwSupply(String dwSupply) {
		this.dwSupply = dwSupply;
	}
	/**
	 * @return Returns the mpwsNo.
	 */
	public String getMpwsNo() {
		return mpwsNo;
	}
	/**
	 * @param mpwsNo The mpwsNo to set.
	 */
	public void setMpwsNo(String mpwsNo) {
		this.mpwsNo = mpwsNo;
	}
	/**
	 * @return Returns the mpwsSupply.
	 */
	public String getMpwsSupply() {
		return mpwsSupply;
	}
	/**
	 * @param mpwsSupply The mpwsSupply to set.
	 */
	public void setMpwsSupply(String mpwsSupply) {
		this.mpwsSupply = mpwsSupply;
	}
	/**
	 * @return Returns the pwsNo.
	 */
	public String getPwsNo() {
		return pwsNo;
	}
	/**
	 * @param pwsNo The pwsNo to set.
	 */
	public void setPwsNo(String pwsNo) {
		this.pwsNo = pwsNo;
	}
	/**
	 * @return Returns the pwsSupply.
	 */
	public String getPwsSupply() {
		return pwsSupply;
	}
	/**
	 * @param pwsSupply The pwsSupply to set.
	 */
	public void setPwsSupply(String pwsSupply) {
		this.pwsSupply = pwsSupply;
	}
	
	/**
	 * @return Returns the statusAsOn1405.
	 */
	public String getStatusAsOn1405() {
		return statusAsOn1405;
	}
	/**
	 * @param statusAsOn1405 The statusAsOn1405 to set.
	 */
	public void setStatusAsOn1405(String statusAsOn1405) {
		this.statusAsOn1405 = statusAsOn1405;
	}
	
	/**
	 * @return Returns the updateDate.
	 */
	public String getUpdateDate() {
		return updateDate;
	}
	/**
	 * @param updateDate The updateDate to set.
	 */
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	/**
	 * @return Returns the contName.
	 */
	public String getContName() {
		return contName;
	}
	/**
	 * @param contName The contName to set.
	 */
	public void setContName(String contName) {
		this.contName = contName;
	}
	
	public String getTotOthersSupply() {
		return totOthersSupply;
	}
	public void setTotOthersSupply(String totOthersSupply) {
		this.totOthersSupply = totOthersSupply;
	}
	
	
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		//System.out.println("it is in reset");
		 HttpSession session = request.getSession();
		 ArrayList divcodes = (ArrayList)session.getAttribute("divcodes");
		 ArrayList subdivcodes = (ArrayList)session.getAttribute("subdivcodes");
		 ArrayList mandals = (ArrayList)session.getAttribute("mandals");
		 ArrayList panchayats = (ArrayList)session.getAttribute("panchyats");
		 ArrayList villages = (ArrayList)session.getAttribute("villages");
		 ArrayList habs = (ArrayList)session.getAttribute("habs");
		 this.circleOfficeName="";
		 this.divisionOfficeName="";
		// this.divisionOfficeCode="";
		// this.subdivisionOfficeCode="";
		 this.district="";
		 this.censusYear="";
		 this.censusPop=0;             
		 this.censusSc=0;             
		 this.censusSt=0;              
		 this.totPop=0;              
		 this.floatPop=0;              
		 this.floatReason="";        
		 this.netPop=0;          
		 this.statusAsOn1405="";
		 this.habYear="";       
		 this.popCovered=0;
		 this.scCovered=0;            
		 this.stCovered=0;             
		 this.totPopCvrd=0;            
		 this.coveredStatus="";
		 this.totalWaterSupply=0;
		 this.existWaterLevel=0;      
		 this.nearWaterSource=0;       
		 this.nearWaterGroundSource=0;
		 this.contType="";
		 this.percent="";
		 this.remarks="";    
		 this.status="";
		 this.shpNo="";
		 this.cisternsNo="";
		 this.glsrNo="";
		 this.ohsrNo="";
		 this.drinkTotalNo="";
		 this.hpNo="";
		 this.owsNo="";
		 this.pondsNo="";
		 this.shwNo="";
		 this.otherTotalNo="";
		 this.shpSupply="";
		 this.cisternsSupply="";
		 this.glsrSupply="";
		 this.ohsrSupply="";
		 this.drinkTotalSupply="";
		 this.hpSupply="";
		 this.owsSupply="";
		 this.shwSupply="";
		 this.pondsSupply="";
		 this.pwsNo="";
		 this.pwsSupply="";
		 this.cpwsNo="";
		 this.cpwsSupply="";
		 this.mpwsNo="";
		 this.mpwsSupply="";
		 this.dpNo="";
		 this.dpSupply="";
		 this.dwNo="";
		 this.dwSupply="";
		 this.cattleNo="";
		 this.cattleSupply="";
		 this.pcpdDrink="";
		 this.pcpdOthers="";
		 this.pcpdTotal="";
		 this.levelOfWaterSupply="";
		 this.nearWaterGroundSource=0;
		 this.nearWaterSource=0;
		 this.qualityAffected="";
		 this.isMinorityHab="";
		 if(divcodes != null)
		  	divcodes.clear();
		 if(subdivcodes != null)
		 	subdivcodes.clear();
		 if(mandals != null)
		   	mandals.clear();
		 if(panchayats != null)
		 	panchayats.clear();
		 if(villages != null)
		 	villages.clear();
		 if(habs != null)
		 	habs.clear();
		 this.habInsts.clear();
		 this.habWaterSupply.clear(); 
		 this.init = true;
		 this.habType="";
		 this.houseHold=0;
		 //added by swapna on 12-01-2012
				
		 this.plainHCon=0;
		 this.stHCon=0;
		 this.scHCon=0;
		 this.plainHHold=0;
		 this.stHHold=0;
		 this.scHHold=0;
		 this.latitude="";
		 this.longitude="";
		 this.elevation="";
		 this.waypoint="";
		 //added by swapna on 23-01-2012 for landmark field
		 this.landmark="";
	}
		
	
	public String getTotOthersNo() {
		return totOthersNo;
	}
	public void setTotOthersNo(String totOthersNo) {
		this.totOthersNo = totOthersNo;
	}
	public String getOthersNo() {
		return othersNo;
	}
	public void setOthersNo(String othersNo) {
		this.othersNo = othersNo;
	}
	public String getOthersSupply() {
		return othersSupply;
	}
	public void setOthersSupply(String othersSupply) {
		this.othersSupply = othersSupply;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getMcode() {
		return mcode;
	}
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getPanchayat() {
		return panchayat;
	}
	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getConstituency() {
		return constituency;
	}
	public void setConstituency(String constituency) {
		this.constituency = constituency;
	}
	public String getHabitation() {
		return habitation;
	}
	public void setHabitation(String habitation) {
		this.habitation = habitation;
	}
	public String getVillage() {
		return village;
	}
	public void setVillage(String village) {
		this.village = village;
	}
	public String getHcode() {
		return hcode;
	}
	public void setHcode(String hcode) {
		this.hcode = hcode;
	}
	
	public String getPrHabName() {
		return prHabName;
	}
	public void setPrHabName(String prHabName) {
		this.prHabName = prHabName;
	}
	public String getPrcode() {
		return prcode;
	}
	public void setPrcode(String prcode) {
		this.prcode = prcode;
	}
	public String getExistingHabCode() {
		return existingHabCode;
	}
	public void setExistingHabCode(String existingHabCode) {
		this.existingHabCode = existingHabCode;
	}
	public String getBrakish() {
		return brakish;
	}
	public void setBrakish(String brakish) {
		this.brakish = brakish;
	}
	public String getFlouride() {
		return flouride;
	}
	public void setFlouride(String flouride) {
		this.flouride = flouride;
	}
	public String getIron() {
		return iron;
	}
	public void setIron(String iron) {
		this.iron = iron;
	}
	public String getStatusDate() {
		return statusDate;
	}
	public void setStatusDate(String statusDate) {
		this.statusDate = statusDate;
	}
	public boolean isContaminationDetailsEntryFrmInit() {
		return contaminationDetailsEntryFrmInit;
	}
	public void setContaminationDetailsEntryFrmInit(
			boolean contaminationDetailsEntryFrmInit) {
		this.contaminationDetailsEntryFrmInit = contaminationDetailsEntryFrmInit;
	}
	/**
	 * @return Returns the cattles.
	 */
	public int getCattles() {
		return cattles;
	}
	/**
	 * @param cattles The cattles to set.
	 */
	public void setCattles(int cattles) {
		this.cattles = cattles;
	}
	/**
	 * @return Returns the existSource.
	 */
	public int getExistSource() {
		return existSource;
	}
	/**
	 * @param existSource The existSource to set.
	 */
	public void setExistSource(int existSource) {
		this.existSource = existSource;
	}
	/**
	 * @return Returns the habCat.
	 */
	public String getHabCat() {
		return habCat;
	}
	/**
	 * @param habCat The habCat to set.
	 */
	public void setHabCat(String habCat) {
		this.habCat = habCat;
	}
	/**
	 * @return Returns the safeSource.
	 */
	public int getSafeSource() {
		return safeSource;
	}
	/**
	 * @param safeSource The safeSource to set.
	 */
	public void setSafeSource(int safeSource) {
		this.safeSource = safeSource;
	}
	/**
	 * @return Returns the slipReasonCode.
	 */
	public String getSlipReasonCode() {
		return slipReasonCode;
	}
	/**
	 * @param slipReasonCode The slipReasonCode to set.
	 */
	public void setSlipReasonCode(String slipReasonCode) {
		this.slipReasonCode = slipReasonCode;
	}
	/**
	 * @return Returns the totalWaterSupplySafe.
	 */
	public int getTotalWaterSupplySafe() {
		return totalWaterSupplySafe;
	}
	/**
	 * @param totalWaterSupplySafe The totalWaterSupplySafe to set.
	 */
	public void setTotalWaterSupplySafe(int totalWaterSupplySafe) {
		this.totalWaterSupplySafe = totalWaterSupplySafe;
	}
	/**
	 * @return Returns the totalWaterSupplyUnsafe.
	 */
	public int getTotalWaterSupplyUnsafe() {
		return totalWaterSupplyUnsafe;
	}
	/**
	 * @param totalWaterSupplyUnsafe The totalWaterSupplyUnsafe to set.
	 */
	public void setTotalWaterSupplyUnsafe(int totalWaterSupplyUnsafe) {
		this.totalWaterSupplyUnsafe = totalWaterSupplyUnsafe;
	}
	
	/**
	 * @return Returns the otherSafeNo.
	 */
	public String getOthersSafeeNo() {
		return othersSafeeNo;
	}
	/**
	 * @param otherSafeNo The otherSafeNo to set.
	 */
	public void setOthersSafeeNo(String othersSafeeNo) {
		this.othersSafeeNo = othersSafeeNo;
	}
	/**
	 * @return Returns the othersSafeSupply.
	 */
	public String getOthersSafeSupply() {
		return othersSafeSupply;
	}
	/**
	 * @param othersSafeSupply The othersSafeSupply to set.
	 */
	public void setOthersSafeSupply(String othersSafeSupply) {
		this.othersSafeSupply = othersSafeSupply;
	}
	
	public String getAresenic() {
		return aresenic;
	}
	public void setAresenic(String aresenic) {
		this.aresenic = aresenic;
	}
	public String getNitrate() {
		return nitrate;
	}
	public void setNitrate(String nitrate) {
		this.nitrate = nitrate;
	}
	
	public String getMpwsUnsafeNo() {
		return mpwsUnsafeNo;
	}
	public void setMpwsUnsafeNo(String mpwsUnsafeNo) {
		this.mpwsUnsafeNo = mpwsUnsafeNo;
	}
	public String getMpwsUnsafeSupply() {
		return mpwsUnsafeSupply;
	}
	public void setMpwsUnsafeSupply(String mpwsUnsafeSupply) {
		this.mpwsUnsafeSupply = mpwsUnsafeSupply;
	}
	public String getNcSourceType() {
		return ncSourceType;
	}
	public void setNcSourceType(String ncSourceType) {
		this.ncSourceType = ncSourceType;
	}
	public String getPwsUnsafeNo() {
		return pwsUnsafeNo;
	}
	public void setPwsUnsafeNo(String pwsUnsafeNo) {
		this.pwsUnsafeNo = pwsUnsafeNo;
	}
	public String getPwsUnsafeSupply() {
		return pwsUnsafeSupply;
	}
	public void setPwsUnsafeSupply(String pwsUnsafeSupply) {
		this.pwsUnsafeSupply = pwsUnsafeSupply;
	}
	public String getSourceDistance() {
		return sourceDistance;
	}
	public void setSourceDistance(String sourceDistance) {
		this.sourceDistance = sourceDistance;
	}
	
	public String getContTypes1() {
		return contTypes1;
	}
	public void setContTypes1(String contTypes1) {
		this.contTypes1 = contTypes1;
	}
	public String getContTypes2() {
		return contTypes2;
	}
	public void setContTypes2(String contTypes2) {
		this.contTypes2 = contTypes2;
	}
	public String getContTypes3() {
		return contTypes3;
	}
	public void setContTypes3(String contTypes3) {
		this.contTypes3 = contTypes3;
	}
	public String getContTypes4() {
		return contTypes4;
	}
	public void setContTypes4(String contTypes4) {
		this.contTypes4 = contTypes4;
	}
	public String getContTypes5() {
		return contTypes5;
	}
	public void setContTypes5(String contTypes5) {
		this.contTypes5 = contTypes5;
	}
	
	/**
	 * @return Returns the lpcdCooking.
	 */
	public String getLpcdCooking() {
		return lpcdCooking;
	}
	/**
	 * @param lpcdCooking The lpcdCooking to set.
	 */
	public void setLpcdCooking(String lpcdCooking) {
		this.lpcdCooking = lpcdCooking;
	}
	
public String getSlipDivStatus() {
	return SlipDivStatus;
}
public void setSlipDivStatus(String slipDivStatus) {
	SlipDivStatus = slipDivStatus;
}

	/**
	 * @return Returns the constituency1.
	 */
	public String getConstituency1() {
		return constituency1;
	}
	/**
	 * @param constituency1 The constituency1 to set.
	 */
	public void setConstituency1(String constituency1) {
		this.constituency1 = constituency1;
	}
/**
 * @return Returns the district1.
 */
public String getDistrict1() {
	return district1;
}
/**
 * @param district1 The district1 to set.
 */
public void setDistrict1(String district1) {
	this.district1 = district1;
}
	/**
	 * @return Returns the habitation1.
	 */
	public String getHabitation1() {
		return habitation1;
	}
	/**
	 * @param habitation1 The habitation1 to set.
	 */
	public void setHabitation1(String habitation1) {
		this.habitation1 = habitation1;
	}
	/**
	 * @return Returns the habName1.
	 */
	public String getHabName1() {
		return habName1;
	}
	/**
	 * @param habName1 The habName1 to set.
	 */
	public void setHabName1(String habName1) {
		this.habName1 = habName1;
	}
	/**
	 * @return Returns the mandal1.
	 */
	public String getMandal1() {
		return mandal1;
	}
	/**
	 * @param mandal1 The mandal1 to set.
	 */
	public void setMandal1(String mandal1) {
		this.mandal1 = mandal1;
	}
	/**
	 * @return Returns the panchayat1.
	 */
	public String getPanchayat1() {
		return panchayat1;
	}
	/**
	 * @param panchayat1 The panchayat1 to set.
	 */
	public void setPanchayat1(String panchayat1) {
		this.panchayat1 = panchayat1;
	}
	/**
	 * @return Returns the village1.
	 */
	public String getVillage1() {
		return village1;
	}
	/**
	 * @param village1 The village1 to set.
	 */
	public void setVillage1(String village1) {
		this.village1 = village1;
	}
	
	/**
	 * @return Returns the isMinorityHab.
	 */
	public String getIsMinorityHab() {
		return isMinorityHab;
	}
	/**
	 * @param isMinorityHab The isMinorityHab to set.
	 */
	public void setIsMinorityHab(String isMinorityHab) {
		this.isMinorityHab = isMinorityHab;
	}
	
	/**
	 * @return Returns the isLwe.
	 */
	public String getIsLwe() {
		return isLwe;
	}
	/**
	 * @param isLwe The isLwe to set.
	 */
	public void setIsLwe(String isLwe) {
		this.isLwe = isLwe;
	}
	/**
	 * @return Returns the unsafeLpcd.
	 */
	public String getUnsafeLpcd() {
		return unsafeLpcd;
	}
	/**
	 * @param unsafeLpcd The unsafeLpcd to set.
	 */
	public void setUnsafeLpcd(String unsafeLpcd) {
		this.unsafeLpcd = unsafeLpcd;
	}
	
	
	public String getLevelOfWaterSupplySafeOnly() {
		return levelOfWaterSupplySafeOnly;
	}
	public void setLevelOfWaterSupplySafeOnly(String levelOfWaterSupplySafeOnly) {
		this.levelOfWaterSupplySafeOnly = levelOfWaterSupplySafeOnly;
	}
	public int getTotalWaterSupplySafeOnly() {
		return totalWaterSupplySafeOnly;
	}
	public void setTotalWaterSupplySafeOnly(int totalWaterSupplySafeOnly) {
		this.totalWaterSupplySafeOnly = totalWaterSupplySafeOnly;
	}
public int getHouseConn() {
	return houseConn;
}
public void setHouseConn(int houseConn) {
	this.houseConn = houseConn;
}
public String getIsItda() {
	return isItda;
}
public void setIsItda(String isItda) {
	this.isItda = isItda;
}
	
	/**
	 * @return Returns the plainHCon.
	 */
	public int getPlainHCon() {
		return plainHCon;
	}
	/**
	 * @param plainHCon The plainHCon to set.
	 */
	public void setPlainHCon(int plainHCon) {
		this.plainHCon = plainHCon;
	}
	/**
	 * @return Returns the plainHHold.
	 */
	public int getPlainHHold() {
		return plainHHold;
	}
	/**
	 * @param plainHHold The plainHHold to set.
	 */
	public void setPlainHHold(int plainHHold) {
		this.plainHHold = plainHHold;
	}
	/**
	 * @return Returns the scHCon.
	 */
	public int getScHCon() {
		return scHCon;
	}
	/**
	 * @param scHCon The scHCon to set.
	 */
	public void setScHCon(int scHCon) {
		this.scHCon = scHCon;
	}
	/**
	 * @return Returns the scHHold.
	 */
	public int getScHHold() {
		return scHHold;
	}
	/**
	 * @param scHHold The scHHold to set.
	 */
	public void setScHHold(int scHHold) {
		this.scHHold = scHHold;
	}
	/**
	 * @return Returns the stHCon.
	 */
	public int getStHCon() {
		return stHCon;
	}
	/**
	 * @param stHCon The stHCon to set.
	 */
	public void setStHCon(int stHCon) {
		this.stHCon = stHCon;
	}
	/**
	 * @return Returns the stHHold.
	 */
	public int getStHHold() {
		return stHHold;
	}
	/**
	 * @param stHHold The stHHold to set.
	 */
	public void setStHHold(int stHHold) {
		this.stHHold = stHHold;
	}
	
	/**
	 * @param elevation The elevation to set.
	 */
	public void setElevation(String elevation) {
		this.elevation = elevation;
	}
/**
 * @param latitude The latitude to set.
 */
public void setLatitude(String latitude) {
	this.latitude = latitude;
}
	/**
	 * @param longitude The longitude to set.
	 */
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	/**
	 * @param waypoint The waypoint to set.
	 */
	public void setWaypoint(String waypoint) {
		this.waypoint = waypoint;
	}
	/**
	 * @return Returns the elevation.
	 */
	public String getElevation() {
		return elevation;
	}
/**
 * @return Returns the latitude.
 */
public String getLatitude() {
	return latitude;
}
	/**
	 * @return Returns the longitude.
	 */
	public String getLongitude() {
		return longitude;
	}
	/**
	 * @return Returns the waypoint.
	 */
	public String getWaypoint() {
		return waypoint;
	}
	/**
	 * @return Returns the landmark.
	 */
	public String getLandmark() {
		return landmark;
	}
	/**
	 * @param landmark The landmark to set.
	 */
	public void setLandmark(String landmark) {
		this.landmark = landmark;
	}
public int getCensusMinority() {
	return censusMinority;
}
public void setCensusMinority(int censusMinority) {
	this.censusMinority = censusMinority;
}
public int getMinorityCovered() {
	return minorityCovered;
}
public void setMinorityCovered(int minorityCovered) {
	this.minorityCovered = minorityCovered;
}
	public int getMinorityHCon() {
		return minorityHCon;
	}
	public void setMinorityHCon(int minorityHCon) {
		this.minorityHCon = minorityHCon;
	}
	public int getMinorityHHold() {
		return minorityHHold;
	}
	public void setMinorityHHold(int minorityHHold) {
		this.minorityHHold = minorityHHold;
	}
	public void setSchemesource(String schemesource) {
		this.schemesource = schemesource;
	}
	public String getSchemesource() {
		return schemesource;
	}
}
