package nic.watersoft.masters;

import java.util.ArrayList;
import java.util.Date;

import org.apache.struts.action.ActionForm;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/** form bean classes* */
public class Rws_Habitation_Safe_Suplly_Form extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	

	 private String district;
	 private String mandal;

	private String panchayat;
	private String village;
	private String habitation;

	private String pcode;

	private String pname;

	private String dcode;

	private String dname;

	private String mcode;

	private String mname;

	private String districtName;
	
	private int glsrNo;
	
	private int glsrQty;
	
	private int ohsrNo;
	
	private int ohsrQty;
	
	private int pwsNo;
	
	private int mpwsNo;
	
	private int cpwsNo;
	
	private int hpNo;
	
	private int shpNo;
	
	private int othersNo;
	
	private int sNo;
	
	private int pwsHabLPCD;
	
	private int pwsHabUnsafeLPCD;
	
	private String pwsAssetCode;
	
	private String pwsAssetName;
	
	private String pwsSourceCode;
	
	private String pwsSourceName;
	
	private int pwsSafeLPCD;
	
	private int pwsUnSafeLPCD;
	
	private int pwsUnSafeNo;
	
	private String pwsLocation;
	
	private int cpwsHabLPCD;
	
	private String updateDate;
	
	private String waterBeingSupplied;
	
	private String imageStatus;
	
	private String previousCS;
	
private String pwsLinksSourceCode;
	
	private String pwsLinksSourceName;
	
	private int pwsLinksSafeLPCD;
	
	private int pwsLinksUnSafeLPCD;
	
	private String pwsLinksLocation;
	
	private String mpwsLinksSourceCode;
	
	private String mpwsLinksSourceName;
	
	private int mpwsLinksSafeLPCD;
	
	private String cpwsLinksSourceCode;	
	private String cpwsLinksSourceName;	
	private int cpwsLinksSafeLPCD;	
	private String cpwsLinksLocation;
	private String contaminationType;
	private String statusDate;
	
	private int actHouseHold;
	private int actHouseConn;	
	private int actTotPop;
	private double newLpcd;
	
    private String newCoverageStatus;
	

	public String getNewCoverageStatus() {
		return newCoverageStatus;
	}



	public void setNewCoverageStatus(String newCoverageStatus) {
		this.newCoverageStatus = newCoverageStatus;
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



	public int getActTotPop() {
		return actTotPop;
	}



	public void setActTotPop(int actTotPop) {
		this.actTotPop = actTotPop;
	}



	public double getNewLpcd() {
		return newLpcd;
	}



	public void setNewLpcd(double newLpcd) {
		this.newLpcd = newLpcd;
	}



	public String getPwsLinksSourceCode() {
		return pwsLinksSourceCode;
	}



	public void setPwsLinksSourceCode(String pwsLinksSourceCode) {
		this.pwsLinksSourceCode = pwsLinksSourceCode;
	}



	public String getPwsLinksSourceName() {
		return pwsLinksSourceName;
	}



	public void setPwsLinksSourceName(String pwsLinksSourceName) {
		this.pwsLinksSourceName = pwsLinksSourceName;
	}



	public int getPwsLinksSafeLPCD() {
		return pwsLinksSafeLPCD;
	}



	public void setPwsLinksSafeLPCD(int pwsLinksSafeLPCD) {
		this.pwsLinksSafeLPCD = pwsLinksSafeLPCD;
	}



	public int getPwsLinksUnSafeLPCD() {
		return pwsLinksUnSafeLPCD;
	}



	public void setPwsLinksUnSafeLPCD(int pwsLinksUnSafeLPCD) {
		this.pwsLinksUnSafeLPCD = pwsLinksUnSafeLPCD;
	}



	public String getPwsLinksLocation() {
		return pwsLinksLocation;
	}



	public void setPwsLinksLocation(String pwsLinksLocation) {
		this.pwsLinksLocation = pwsLinksLocation;
	}



	public String getMpwsLinksSourceCode() {
		return mpwsLinksSourceCode;
	}



	public void setMpwsLinksSourceCode(String mpwsLinksSourceCode) {
		this.mpwsLinksSourceCode = mpwsLinksSourceCode;
	}



	public String getMpwsLinksSourceName() {
		return mpwsLinksSourceName;
	}



	public void setMpwsLinksSourceName(String mpwsLinksSourceName) {
		this.mpwsLinksSourceName = mpwsLinksSourceName;
	}



	public int getMpwsLinksSafeLPCD() {
		return mpwsLinksSafeLPCD;
	}



	public void setMpwsLinksSafeLPCD(int mpwsLinksSafeLPCD) {
		this.mpwsLinksSafeLPCD = mpwsLinksSafeLPCD;
	}



	public int getMpwsLinksUnSafeLPCD() {
		return mpwsLinksUnSafeLPCD;
	}



	public void setMpwsLinksUnSafeLPCD(int mpwsLinksUnSafeLPCD) {
		this.mpwsLinksUnSafeLPCD = mpwsLinksUnSafeLPCD;
	}



	public String getMpwsLinksLocation() {
		return mpwsLinksLocation;
	}



	public void setMpwsLinksLocation(String mpwsLinksLocation) {
		this.mpwsLinksLocation = mpwsLinksLocation;
	}



	public String getDpLinksSourceCode() {
		return dpLinksSourceCode;
	}



	public void setDpLinksSourceCode(String dpLinksSourceCode) {
		this.dpLinksSourceCode = dpLinksSourceCode;
	}



	public String getDpLinksSourceName() {
		return dpLinksSourceName;
	}



	public void setDpLinksSourceName(String dpLinksSourceName) {
		this.dpLinksSourceName = dpLinksSourceName;
	}



	public int getDpLinksSafeLPCD() {
		return dpLinksSafeLPCD;
	}



	public void setDpLinksSafeLPCD(int dpLinksSafeLPCD) {
		this.dpLinksSafeLPCD = dpLinksSafeLPCD;
	}



	public int getDpLinksUnSafeLPCD() {
		return dpLinksUnSafeLPCD;
	}



	public void setDpLinksUnSafeLPCD(int dpLinksUnSafeLPCD) {
		this.dpLinksUnSafeLPCD = dpLinksUnSafeLPCD;
	}



	public String getDpLinksLocation() {
		return dpLinksLocation;
	}



	public void setDpLinksLocation(String dpLinksLocation) {
		this.dpLinksLocation = dpLinksLocation;
	}



	private int mpwsLinksUnSafeLPCD;
	
	private String mpwsLinksLocation;
	
	private String dpLinksSourceCode;
	
	private String dpLinksSourceName;
	
	private int dpLinksSafeLPCD;
	
	private int dpLinksUnSafeLPCD;
	
	private String dpLinksLocation;
	
	
	
	public String getPreviousCS() {
		return previousCS;
	}



	public void setPreviousCS(String previousCS) {
		this.previousCS = previousCS;
	}



	public String getImageStatus() {
		return imageStatus;
	}



	public void setImageStatus(String imageStatus) {
		this.imageStatus = imageStatus;
	}



	public String getWaterBeingSupplied() {
		return waterBeingSupplied;
	}



	public void setWaterBeingSupplied(String waterBeingSupplied) {
		this.waterBeingSupplied = waterBeingSupplied;
	}



	public int getPwsHabLinkLPCD() {
		return pwsHabLinkLPCD;
	}



	public void setPwsHabLinkLPCD(int pwsHabLinkLPCD) {
		this.pwsHabLinkLPCD = pwsHabLinkLPCD;
	}



	public int getMpwsHabLinkLPCD() {
		return mpwsHabLinkLPCD;
	}



	public void setMpwsHabLinkLPCD(int mpwsHabLinkLPCD) {
		this.mpwsHabLinkLPCD = mpwsHabLinkLPCD;
	}



	public int getDpHabLinkLPCD() {
		return dpHabLinkLPCD;
	}



	public void setDpHabLinkLPCD(int dpHabLinkLPCD) {
		this.dpHabLinkLPCD = dpHabLinkLPCD;
	}



	public String getPwsLinksAssetCode() {
		return pwsLinksAssetCode;
	}



	public void setPwsLinksAssetCode(String pwsLinksAssetCode) {
		this.pwsLinksAssetCode = pwsLinksAssetCode;
	}



	public String getMpwsLinksAssetCode() {
		return mpwsLinksAssetCode;
	}



	public void setMpwsLinksAssetCode(String mpwsLinksAssetCode) {
		this.mpwsLinksAssetCode = mpwsLinksAssetCode;
	}



	public String getDpLinksAssetCode() {
		return dpLinksAssetCode;
	}



	public void setDpLinksAssetCode(String dpLinksAssetCode) {
		this.dpLinksAssetCode = dpLinksAssetCode;
	}



	public String getPwsLinksAssetName() {
		return pwsLinksAssetName;
	}



	public void setPwsLinksAssetName(String pwsLinksAssetName) {
		this.pwsLinksAssetName = pwsLinksAssetName;
	}



	public String getMpwsLinksAssetName() {
		return mpwsLinksAssetName;
	}



	public void setMpwsLinksAssetName(String mpwsLinksAssetName) {
		this.mpwsLinksAssetName = mpwsLinksAssetName;
	}



	public String getDpLinksAssetName() {
		return dpLinksAssetName;
	}



	public void setDpLinksAssetName(String dpLinksAssetName) {
		this.dpLinksAssetName = dpLinksAssetName;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getPwsLinks() {
		return pwsLinks;
	}



	public void setPwsLinks(ArrayList<Rws_Habitation_Safe_Suplly_Form> pwsLinks) {
		this.pwsLinks = pwsLinks;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getMpwsLinks() {
		return mpwsLinks;
	}



	public void setMpwsLinks(ArrayList<Rws_Habitation_Safe_Suplly_Form> mpwsLinks) {
		this.mpwsLinks = mpwsLinks;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getDpLinks() {
		return dpLinks;
	}



	public void setDpLinks(ArrayList<Rws_Habitation_Safe_Suplly_Form> dpLinks) {
		this.dpLinks = dpLinks;
	}



	private int cpwsHabLinkLPCD;
	private int pwsHabLinkLPCD;
	private int mpwsHabLinkLPCD;
	private int dpHabLinkLPCD;
	private int pwsHabLinkUnsafeLPCD;
	private int mpwsHabLinkUnsafeLPCD;
	private int dpHabLinkUnsafeLPCD;
	
	private String cpwsAssetCode;
	
	private String cpwsLinksAssetCode;
	private String pwsLinksAssetCode;
	private String mpwsLinksAssetCode;
	private String dpLinksAssetCode;
	
	private String cpwsAssetName;
	
	private String cpwsLinksAssetName;
	private String pwsLinksAssetName;
	private String mpwsLinksAssetName;
	private String dpLinksAssetName;
	
	private String cpwsSourceCode;
	
	private String cpwsSourceName;
	
	private int cpwsSafeLPCD;
	
	private int cpwsUnSafeLPCD;
	
	private String cpwsLocation;
	
	private int mpwsHabLPCD;
	
	private int mpwsHabUnsafeLPCD;
	
	private String mpwsAssetCode;
	
	private String mpwsAssetName;
	
	private String mpwsSourceCode;
	
	private String mpwsSourceName;
	
	private int mpwsSafeLPCD;
	
	private int mpwsUnSafeLPCD;
	
	private int mpwsUnSafeNo;
	
	private String mpwsLocation;
	
	private int hpHabLPCD;
	
	private int hpHabUnsafeLPCD;
	
	private String hpAssetCode;
	
	private String hpAssetName;
	
	private String hpSourceCode;
	
	private String hpSourceName;
	
	private int hpSafeLPCD;
	
	private int hpUnSafeLPCD;
	
	private int hpUnSafeNo;
	
	private String hpLocation;

	private int shpHabLPCD;
	
	private int shpHabUnsafeLPCD;
	
	private String shpAssetCode;
	
	private String shpAssetName;
	
	private String shpSourceCode;
	
	private String shpSourceName;
	
	private int shpSafeLPCD;
	
	private int shpUnSafeLPCD;
	
	private int shpUnSafeNo;
	
	private String shpLocation;
	
	private int othersHabLPCD;
	
	private int othersHabUnsafeLPCD;
	
	private String othersAssetCode;
	
	private String othersAssetName;
	
	private String othersSourceCode;
	
	private String othersSourceName;
	
	private int othersSafeLPCD;
	
	private int othersUnSafeLPCD;
	
	private int othersUnSafeNo;
	
	private String othersLocation;
	
	private String tableName;
	
	private int houseConn;
	
	private int houseHolds;
	
	private String flouride;
	
	private String iron;
	
	private String nitrate;
	
	private String brakish;
	
	private String preparedOn;
	
	private String testid;
	
	private int totalWaterSupply;
	
	private double levelOfWaterSupplyLPCD;
	
	private int totalWaterSupplySafeSource;
	
	private double levelOfWaterSupplySafeSource;
	
	private int totalWaterSupplyUnSafeSource;
	
	private double levelOfWaterSupplyUnSafeSource;
	
	private int totalWaterSupplySafeUnSafe;
	
	private double levelOfWaterSupplySafeUnSafe;
	
	private String coverageStatus;
	
	private int cYear;
	
	private double netPop;
	
	private int standPosts;
	
	private String sourceType;
	
	private String sourceStatus;
	
	private String platformExisting;
	
	private String soakPit;
	
	private int totPop;
	
	private double previousYearLPCD;
	
	private String yield;
	
	private int dpHabLPCD;
	
	private int dpHabUnsafeLPCD;
	
	private int dpSafeNo;
	
	private int dpUnSafeNo;
	
	private String flouridePPM;
	
	private String ironPPM;
	
	private String nitratePPM;
	
	private String brakishPPM;
	
	
	

	private ArrayList<Rws_Habitation_Safe_Suplly_Form> pws;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> pwsLinks;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> mpws;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> mpwsLinks;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> cpws;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> cpwsLinks;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> hp;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> shp;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> others;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> reservoirs;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> dps;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> dpLinks;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> ppmValues;
	private ArrayList<Rws_Habitation_Safe_Suplly_Form> cpwsResLinks;
	
	

	public String getFlouridePPM() {
		return flouridePPM;
	}



	public void setFlouridePPM(String flouridePPM) {
		this.flouridePPM = flouridePPM;
	}



	public String getIronPPM() {
		return ironPPM;
	}



	public void setIronPPM(String ironPPM) {
		this.ironPPM = ironPPM;
	}



	public String getNitratePPM() {
		return nitratePPM;
	}



	public void setNitratePPM(String nitratePPM) {
		this.nitratePPM = nitratePPM;
	}



	public String getBrakishPPM() {
		return brakishPPM;
	}



	public void setBrakishPPM(String brakishPPM) {
		this.brakishPPM = brakishPPM;
	}





	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getPpmValues() {
		return ppmValues;
	}



	public void setPpmValues(ArrayList<Rws_Habitation_Safe_Suplly_Form> ppmValues) {
		this.ppmValues = ppmValues;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getDps() {
		return dps;
	}



	public void setDps(ArrayList<Rws_Habitation_Safe_Suplly_Form> dps) {
		this.dps = dps;
	}



	public int getDpHabLPCD() {
		return dpHabLPCD;
	}



	public void setDpHabLPCD(int dpHabLPCD) {
		this.dpHabLPCD = dpHabLPCD;
	}



	public int getDpHabUnsafeLPCD() {
		return dpHabUnsafeLPCD;
	}



	public void setDpHabUnsafeLPCD(int dpHabUnsafeLPCD) {
		this.dpHabUnsafeLPCD = dpHabUnsafeLPCD;
	}



	public int getDpSafeNo() {
		return dpSafeNo;
	}



	public void setDpSafeNo(int dpSafeNo) {
		this.dpSafeNo = dpSafeNo;
	}



	public int getDpUnSafeNo() {
		return dpUnSafeNo;
	}



	public void setDpUnSafeNo(int dpUnSafeNo) {
		this.dpUnSafeNo = dpUnSafeNo;
	}



	public String getYield() {
		return yield;
	}



	public void setYield(String yield) {
		this.yield = yield;
	}



	public double getPreviousYearLPCD() {
		return previousYearLPCD;
	}



	public void setPreviousYearLPCD(double previousYearLPCD) {
		this.previousYearLPCD = previousYearLPCD;
	}



	public int getTotPop() {
		return totPop;
	}



	public void setTotPop(int totPop) {
		this.totPop = totPop;
	}



	public String getPlatformExisting() {
		return platformExisting;
	}



	public void setPlatformExisting(String platformExisting) {
		this.platformExisting = platformExisting;
	}



	public String getSoakPit() {
		return soakPit;
	}



	public void setSoakPit(String soakPit) {
		this.soakPit = soakPit;
	}



	public String getSourceStatus() {
		return sourceStatus;
	}



	public void setSourceStatus(String sourceStatus) {
		this.sourceStatus = sourceStatus;
	}



	public String getSourceType() {
		return sourceType;
	}



	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}



	public int getStandPosts() {
		return standPosts;
	}



	public void setStandPosts(int standPosts) {
		this.standPosts = standPosts;
	}



	public int getHouseHolds() {
		return houseHolds;
	}



	public void setHouseHolds(int houseHolds) {
		this.houseHolds = houseHolds;
	}



	public double getNetPop() {
		return netPop;
	}



	public void setNetPop(double netPop) {
		this.netPop = netPop;
	}



	public int getcYear() {
		return cYear;
	}



	public void setcYear(int cYear) {
		this.cYear = cYear;
	}



	public int getTotalWaterSupply() {
		return totalWaterSupply;
	}



	public void setTotalWaterSupply(int totalWaterSupply) {
		this.totalWaterSupply = totalWaterSupply;
	}



	public double getLevelOfWaterSupplyLPCD() {
		return levelOfWaterSupplyLPCD;
	}



	public void setLevelOfWaterSupplyLPCD(double levelOfWaterSupplyLPCD) {
		this.levelOfWaterSupplyLPCD = levelOfWaterSupplyLPCD;
	}



	public int getTotalWaterSupplySafeSource() {
		return totalWaterSupplySafeSource;
	}



	public void setTotalWaterSupplySafeSource(int totalWaterSupplySafeSource) {
		this.totalWaterSupplySafeSource = totalWaterSupplySafeSource;
	}

	public int getCpwsHabLinkLPCD() {
		return cpwsHabLinkLPCD;
	}



	public void setCpwsHabLinkLPCD(int cpwsHabLinkLPCD) {
		this.cpwsHabLinkLPCD = cpwsHabLinkLPCD;
	}

	
	public double getLevelOfWaterSupplySafeSource() {
		return levelOfWaterSupplySafeSource;
	}



	public void setLevelOfWaterSupplySafeSource(double levelOfWaterSupplySafeSource) {
		this.levelOfWaterSupplySafeSource = levelOfWaterSupplySafeSource;
	}



	public int getTotalWaterSupplyUnSafeSource() {
		return totalWaterSupplyUnSafeSource;
	}



	public void setTotalWaterSupplyUnSafeSource(int totalWaterSupplyUnSafeSource) {
		this.totalWaterSupplyUnSafeSource = totalWaterSupplyUnSafeSource;
	}



	public double getLevelOfWaterSupplyUnSafeSource() {
		return levelOfWaterSupplyUnSafeSource;
	}



	public void setLevelOfWaterSupplyUnSafeSource(
			double levelOfWaterSupplyUnSafeSource) {
		this.levelOfWaterSupplyUnSafeSource = levelOfWaterSupplyUnSafeSource;
	}



	public int getTotalWaterSupplySafeUnSafe() {
		return totalWaterSupplySafeUnSafe;
	}



	public void setTotalWaterSupplySafeUnSafe(int totalWaterSupplySafeUnSafe) {
		this.totalWaterSupplySafeUnSafe = totalWaterSupplySafeUnSafe;
	}



	public double getLevelOfWaterSupplySafeUnSafe() {
		return levelOfWaterSupplySafeUnSafe;
	}



	public void setLevelOfWaterSupplySafeUnSafe(double levelOfWaterSupplySafeUnSafe) {
		this.levelOfWaterSupplySafeUnSafe = levelOfWaterSupplySafeUnSafe;
	}



	public String getCoverageStatus() {
		return coverageStatus;
	}



	public void setCoverageStatus(String coverageStatus) {
		this.coverageStatus = coverageStatus;
	}



	public String getPreparedOn() {
		return preparedOn;
	}



	public void setPreparedOn(String preparedOn) {
		this.preparedOn = preparedOn;
	}



	public String getTestid() {
		return testid;
	}



	public void setTestid(String testid) {
		this.testid = testid;
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



	public String getNitrate() {
		return nitrate;
	}



	public void setNitrate(String nitrate) {
		this.nitrate = nitrate;
	}



	



	public String getBrakish() {
		return brakish;
	}



	public void setBrakish(String brakish) {
		this.brakish = brakish;
	}



	public int getHouseConn() {
		return houseConn;
	}



	public void setHouseConn(int houseConn) {
		this.houseConn = houseConn;
	}






	public int getPwsHabUnsafeLPCD() {
		return pwsHabUnsafeLPCD;
	}



	public void setPwsHabUnsafeLPCD(int pwsHabUnsafeLPCD) {
		this.pwsHabUnsafeLPCD = pwsHabUnsafeLPCD;
	}



	public int getMpwsHabUnsafeLPCD() {
		return mpwsHabUnsafeLPCD;
	}



	public void setMpwsHabUnsafeLPCD(int mpwsHabUnsafeLPCD) {
		this.mpwsHabUnsafeLPCD = mpwsHabUnsafeLPCD;
	}



	public int getHpHabUnsafeLPCD() {
		return hpHabUnsafeLPCD;
	}



	public void setHpHabUnsafeLPCD(int hpHabUnsafeLPCD) {
		this.hpHabUnsafeLPCD = hpHabUnsafeLPCD;
	}



	public int getShpHabUnsafeLPCD() {
		return shpHabUnsafeLPCD;
	}



	public void setShpHabUnsafeLPCD(int shpHabUnsafeLPCD) {
		this.shpHabUnsafeLPCD = shpHabUnsafeLPCD;
	}



	public int getOthersHabUnsafeLPCD() {
		return othersHabUnsafeLPCD;
	}



	public void setOthersHabUnsafeLPCD(int othersHabUnsafeLPCD) {
		this.othersHabUnsafeLPCD = othersHabUnsafeLPCD;
	}



	public int getPwsUnSafeNo() {
		return pwsUnSafeNo;
	}



	public void setPwsUnSafeNo(int pwsUnSafeNo) {
		this.pwsUnSafeNo = pwsUnSafeNo;
	}



	public int getMpwsUnSafeNo() {
		return mpwsUnSafeNo;
	}



	public void setMpwsUnSafeNo(int mpwsUnSafeNo) {
		this.mpwsUnSafeNo = mpwsUnSafeNo;
	}



	public int getHpUnSafeNo() {
		return hpUnSafeNo;
	}



	public void setHpUnSafeNo(int hpUnSafeNo) {
		this.hpUnSafeNo = hpUnSafeNo;
	}



	public int getShpUnSafeNo() {
		return shpUnSafeNo;
	}



	public void setShpUnSafeNo(int shpUnSafeNo) {
		this.shpUnSafeNo = shpUnSafeNo;
	}



	public int getOthersUnSafeNo() {
		return othersUnSafeNo;
	}



	public void setOthersUnSafeNo(int othersUnSafeNo) {
		this.othersUnSafeNo = othersUnSafeNo;
	}



	public int getPwsUnSafeLPCD() {
		return pwsUnSafeLPCD;
	}



	public void setPwsUnSafeLPCD(int pwsUnSafeLPCD) {
		this.pwsUnSafeLPCD = pwsUnSafeLPCD;
	}



	public int getCpwsUnSafeLPCD() {
		return cpwsUnSafeLPCD;
	}



	public void setCpwsUnSafeLPCD(int cpwsUnSafeLPCD) {
		this.cpwsUnSafeLPCD = cpwsUnSafeLPCD;
	}



	public int getMpwsUnSafeLPCD() {
		return mpwsUnSafeLPCD;
	}



	public void setMpwsUnSafeLPCD(int mpwsUnSafeLPCD) {
		this.mpwsUnSafeLPCD = mpwsUnSafeLPCD;
	}



	public int getHpUnSafeLPCD() {
		return hpUnSafeLPCD;
	}



	public void setHpUnSafeLPCD(int hpUnSafeLPCD) {
		this.hpUnSafeLPCD = hpUnSafeLPCD;
	}



	public int getShpUnSafeLPCD() {
		return shpUnSafeLPCD;
	}



	public void setShpUnSafeLPCD(int shpUnSafeLPCD) {
		this.shpUnSafeLPCD = shpUnSafeLPCD;
	}



	public int getOthersUnSafeLPCD() {
		return othersUnSafeLPCD;
	}



	public void setOthersUnSafeLPCD(int othersUnSafeLPCD) {
		this.othersUnSafeLPCD = othersUnSafeLPCD;
	}



	public int getGlsrNo() {
		return glsrNo;
	}



	public void setGlsrNo(int glsrNo) {
		this.glsrNo = glsrNo;
	}



	public int getGlsrQty() {
		return glsrQty;
	}



	public void setGlsrQty(int glsrQty) {
		this.glsrQty = glsrQty;
	}



	public int getOhsrNo() {
		return ohsrNo;
	}



	public void setOhsrNo(int ohsrNo) {
		this.ohsrNo = ohsrNo;
	}



	public int getOhsrQty() {
		return ohsrQty;
	}



	public void setOhsrQty(int ohsrQty) {
		this.ohsrQty = ohsrQty;
	}



	public int getPwsNo() {
		return pwsNo;
	}



	public void setPwsNo(int pwsNo) {
		this.pwsNo = pwsNo;
	}



	public int getMpwsNo() {
		return mpwsNo;
	}



	public void setMpwsNo(int mpwsNo) {
		this.mpwsNo = mpwsNo;
	}



	public int getCpwsNo() {
		return cpwsNo;
	}



	public void setCpwsNo(int cpwsNo) {
		this.cpwsNo = cpwsNo;
	}



	public int getHpNo() {
		return hpNo;
	}



	public void setHpNo(int hpNo) {
		this.hpNo = hpNo;
	}



	public int getShpNo() {
		return shpNo;
	}



	public void setShpNo(int shpNo) {
		this.shpNo = shpNo;
	}



	public int getOthersNo() {
		return othersNo;
	}



	public void setOthersNo(int othersNo) {
		this.othersNo = othersNo;
	}



	public String getTableName() {
		return tableName;
	}



	public void setTableName(String tableName) {
		this.tableName = tableName;
	}



	public int getPwsHabLPCD() {
		return pwsHabLPCD;
	}



	public void setPwsHabLPCD(int pwsHabLPCD) {
		this.pwsHabLPCD = pwsHabLPCD;
	}



	public int getPwsSafeLPCD() {
		return pwsSafeLPCD;
	}



	public void setPwsSafeLPCD(int pwsSafeLPCD) {
		this.pwsSafeLPCD = pwsSafeLPCD;
	}



	public int getCpwsHabLPCD() {
		return cpwsHabLPCD;
	}



	public void setCpwsHabLPCD(int cpwsHabLPCD) {
		this.cpwsHabLPCD = cpwsHabLPCD;
	}



	public int getCpwsSafeLPCD() {
		return cpwsSafeLPCD;
	}



	public void setCpwsSafeLPCD(int cpwsSafeLPCD) {
		this.cpwsSafeLPCD = cpwsSafeLPCD;
	}



	public int getMpwsHabLPCD() {
		return mpwsHabLPCD;
	}



	public void setMpwsHabLPCD(int mpwsHabLPCD) {
		this.mpwsHabLPCD = mpwsHabLPCD;
	}



	public int getMpwsSafeLPCD() {
		return mpwsSafeLPCD;
	}



	public void setMpwsSafeLPCD(int mpwsSafeLPCD) {
		this.mpwsSafeLPCD = mpwsSafeLPCD;
	}



	public int getHpHabLPCD() {
		return hpHabLPCD;
	}



	public void setHpHabLPCD(int hpHabLPCD) {
		this.hpHabLPCD = hpHabLPCD;
	}



	public int getHpSafeLPCD() {
		return hpSafeLPCD;
	}



	public void setHpSafeLPCD(int hpSafeLPCD) {
		this.hpSafeLPCD = hpSafeLPCD;
	}



	public int getShpHabLPCD() {
		return shpHabLPCD;
	}



	public void setShpHabLPCD(int shpHabLPCD) {
		this.shpHabLPCD = shpHabLPCD;
	}



	public int getShpSafeLPCD() {
		return shpSafeLPCD;
	}



	public void setShpSafeLPCD(int shpSafeLPCD) {
		this.shpSafeLPCD = shpSafeLPCD;
	}



	public int getOthersHabLPCD() {
		return othersHabLPCD;
	}



	public void setOthersHabLPCD(int othersHabLPCD) {
		this.othersHabLPCD = othersHabLPCD;
	}



	public int getOthersSafeLPCD() {
		return othersSafeLPCD;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getReservoirs() {
		return reservoirs;
	}



	public void setReservoirs(ArrayList<Rws_Habitation_Safe_Suplly_Form> reservoirs) {
		this.reservoirs = reservoirs;
	}



	public void setOthersSafeLPCD(int othersSafeLPCD) {
		this.othersSafeLPCD = othersSafeLPCD;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getPws() {
		return pws;
	}



	public void setPws(ArrayList<Rws_Habitation_Safe_Suplly_Form> pws) {
		this.pws = pws;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getMpws() {
		return mpws;
	}



	public void setMpws(ArrayList<Rws_Habitation_Safe_Suplly_Form> mpws) {
		this.mpws = mpws;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getCpws() {
		return cpws;
	}



	public void setCpws(ArrayList<Rws_Habitation_Safe_Suplly_Form> cpws) {
		this.cpws = cpws;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getHp() {
		return hp;
	}



	public void setHp(ArrayList<Rws_Habitation_Safe_Suplly_Form> hp) {
		this.hp = hp;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getShp() {
		return shp;
	}



	public void setShp(ArrayList<Rws_Habitation_Safe_Suplly_Form> shp) {
		this.shp = shp;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getOthers() {
		return others;
	}



	public void setOthers(ArrayList<Rws_Habitation_Safe_Suplly_Form> others) {
		this.others = others;
	}



	



	public String getOthersAssetCode() {
		return othersAssetCode;
	}



	public void setOthersAssetCode(String othersAssetCode) {
		this.othersAssetCode = othersAssetCode;
	}



	public String getOthersAssetName() {
		return othersAssetName;
	}



	public void setOthersAssetName(String othersAssetName) {
		this.othersAssetName = othersAssetName;
	}



	public String getOthersSourceCode() {
		return othersSourceCode;
	}



	public void setOthersSourceCode(String othersSourceCode) {
		this.othersSourceCode = othersSourceCode;
	}



	public String getOthersSourceName() {
		return othersSourceName;
	}



	public void setOthersSourceName(String othersSourceName) {
		this.othersSourceName = othersSourceName;
	}



	



	public String getOthersLocation() {
		return othersLocation;
	}



	public void setOthersLocation(String othersLocation) {
		this.othersLocation = othersLocation;
	}



	



	public String getShpAssetCode() {
		return shpAssetCode;
	}



	public void setShpAssetCode(String shpAssetCode) {
		this.shpAssetCode = shpAssetCode;
	}



	public String getShpAssetName() {
		return shpAssetName;
	}



	public void setShpAssetName(String shpAssetName) {
		this.shpAssetName = shpAssetName;
	}



	public String getShpSourceCode() {
		return shpSourceCode;
	}



	public void setShpSourceCode(String shpSourceCode) {
		this.shpSourceCode = shpSourceCode;
	}



	public String getShpSourceName() {
		return shpSourceName;
	}



	public void setShpSourceName(String shpSourceName) {
		this.shpSourceName = shpSourceName;
	}



	



	public String getShpLocation() {
		return shpLocation;
	}



	public void setShpLocation(String shpLocation) {
		this.shpLocation = shpLocation;
	}



	



	public String getHpAssetCode() {
		return hpAssetCode;
	}



	public void setHpAssetCode(String hpAssetCode) {
		this.hpAssetCode = hpAssetCode;
	}



	public String getHpAssetName() {
		return hpAssetName;
	}



	public void setHpAssetName(String hpAssetName) {
		this.hpAssetName = hpAssetName;
	}



	public String getHpSourceCode() {
		return hpSourceCode;
	}



	public void setHpSourceCode(String hpSourceCode) {
		this.hpSourceCode = hpSourceCode;
	}



	public String getHpSourceName() {
		return hpSourceName;
	}



	public void setHpSourceName(String hpSourceName) {
		this.hpSourceName = hpSourceName;
	}



	


	public String getHpLocation() {
		return hpLocation;
	}



	public void setHpLocation(String hpLocation) {
		this.hpLocation = hpLocation;
	}



	



	public String getMpwsAssetCode() {
		return mpwsAssetCode;
	}



	public void setMpwsAssetCode(String mpwsAssetCode) {
		this.mpwsAssetCode = mpwsAssetCode;
	}



	public String getMpwsAssetName() {
		return mpwsAssetName;
	}



	public void setMpwsAssetName(String mpwsAssetName) {
		this.mpwsAssetName = mpwsAssetName;
	}



	public String getMpwsSourceCode() {
		return mpwsSourceCode;
	}



	public void setMpwsSourceCode(String mpwsSourceCode) {
		this.mpwsSourceCode = mpwsSourceCode;
	}



	public String getMpwsSourceName() {
		return mpwsSourceName;
	}



	public void setMpwsSourceName(String mpwsSourceName) {
		this.mpwsSourceName = mpwsSourceName;
	}



	



	public String getMpwsLocation() {
		return mpwsLocation;
	}



	public void setMpwsLocation(String mpwsLocation) {
		this.mpwsLocation = mpwsLocation;
	}



	public String getCpwsAssetCode() {
		return cpwsAssetCode;
	}



	public void setCpwsAssetCode(String cpwsAssetCode) {
		this.cpwsAssetCode = cpwsAssetCode;
	}



	public String getCpwsAssetName() {
		return cpwsAssetName;
	}



	public void setCpwsAssetName(String cpwsAssetName) {
		this.cpwsAssetName = cpwsAssetName;
	}



	public String getCpwsSourceName() {
		return cpwsSourceName;
	}



	public void setCpwsSourceName(String cpwsSourceName) {
		this.cpwsSourceName = cpwsSourceName;
	}



	public int getsNo() {
		return sNo;
	}



	public void setsNo(int sNo) {
		this.sNo = sNo;
	}



	public String getPwsAssetCode() {
		return pwsAssetCode;
	}



	public void setPwsAssetCode(String pwsAssetCode) {
		this.pwsAssetCode = pwsAssetCode;
	}



	public String getPwsAssetName() {
		return pwsAssetName;
	}



	public void setPwsAssetName(String pwsAssetName) {
		this.pwsAssetName = pwsAssetName;
	}



	public String getPwsSourceName() {
		return pwsSourceName;
	}



	public void setPwsSourceName(String pwsSourceName) {
		this.pwsSourceName = pwsSourceName;
	}



	



	public String getCpwsSourceCode() {
		return cpwsSourceCode;
	}



	public void setCpwsSourceCode(String cpwsSourceCode) {
		this.cpwsSourceCode = cpwsSourceCode;
	}



	



	public String getCpwsLocation() {
		return cpwsLocation;
	}



	public void setCpwsLocation(String cpwsLocation) {
		this.cpwsLocation = cpwsLocation;
	}



	




	public String getPwsSourceCode() {
		return pwsSourceCode;
	}



	public void setPwsSourceCode(String pwsSourceCode) {
		this.pwsSourceCode = pwsSourceCode;
	}



	



	public String getPwsLocation() {
		return pwsLocation;
	}



	public void setPwsLocation(String pwsLocation) {
		this.pwsLocation = pwsLocation;
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



	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	
	public String getDcode() {
		return dcode;
	}

	public void setDcode(String dcode) {
		this.dcode = dcode;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	public String getMandal() {
		return mandal;
	}

	public void setMandal(String mandal) {
		this.mandal = mandal;
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

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getCpwsLinks() {
		return cpwsLinks;
	}



	public void setCpwsLinks(ArrayList<Rws_Habitation_Safe_Suplly_Form> cpwsLinks) {
		this.cpwsLinks = cpwsLinks;
	}



	public String getCpwsLinksAssetCode() {
		return cpwsLinksAssetCode;
	}

	public void setCpwsLinksAssetCode(String cpwsLinksAssetCode) {
		this.cpwsLinksAssetCode = cpwsLinksAssetCode;
	}

	public String getCpwsLinksAssetName() {
		return cpwsLinksAssetName;
	}

	public void setCpwsLinksAssetName(String cpwsLinksAssetName) {
		this.cpwsLinksAssetName = cpwsLinksAssetName;
	}

	public String getUpdateDate() {
		return updateDate;
	}
	
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public int getPwsHabLinkUnsafeLPCD() {
		return pwsHabLinkUnsafeLPCD;
	}

	public void setPwsHabLinkUnsafeLPCD(int pwsHabLinkUnsafeLPCD) {
		this.pwsHabLinkUnsafeLPCD = pwsHabLinkUnsafeLPCD;
	}

	public int getMpwsHabLinkUnsafeLPCD() {
		return mpwsHabLinkUnsafeLPCD;
	}

	public void setMpwsHabLinkUnsafeLPCD(int mpwsHabLinkUnsafeLPCD) {
		this.mpwsHabLinkUnsafeLPCD = mpwsHabLinkUnsafeLPCD;
	}

	public int getDpHabLinkUnsafeLPCD() {
		return dpHabLinkUnsafeLPCD;
	}

	public void setDpHabLinkUnsafeLPCD(int dpHabLinkUnsafeLPCD) {
		this.dpHabLinkUnsafeLPCD = dpHabLinkUnsafeLPCD;
	}



	public String getCpwsLinksSourceCode() {
		return cpwsLinksSourceCode;
	}



	public void setCpwsLinksSourceCode(String cpwsLinksSourceCode) {
		this.cpwsLinksSourceCode = cpwsLinksSourceCode;
	}



	public String getCpwsLinksSourceName() {
		return cpwsLinksSourceName;
	}



	public void setCpwsLinksSourceName(String cpwsLinksSourceName) {
		this.cpwsLinksSourceName = cpwsLinksSourceName;
	}



	public int getCpwsLinksSafeLPCD() {
		return cpwsLinksSafeLPCD;
	}



	public void setCpwsLinksSafeLPCD(int cpwsLinksSafeLPCD) {
		this.cpwsLinksSafeLPCD = cpwsLinksSafeLPCD;
	}



	public String getCpwsLinksLocation() {
		return cpwsLinksLocation;
	}



	public void setCpwsLinksLocation(String cpwsLinksLocation) {
		this.cpwsLinksLocation = cpwsLinksLocation;
	}



	public String getContaminationType() {
		return contaminationType;
	}



	public void setContaminationType(String contaminationType) {
		this.contaminationType = contaminationType;
	}



	public String getStatusDate() {
		return statusDate;
	}



	public void setStatusDate(String statusDate) {
		this.statusDate = statusDate;
	}



	public ArrayList<Rws_Habitation_Safe_Suplly_Form> getCpwsResLinks() {
		return cpwsResLinks;
	}



	public void setCpwsResLinks(ArrayList<Rws_Habitation_Safe_Suplly_Form> cpwsResLinks) {
		this.cpwsResLinks = cpwsResLinks;
	}
	
	
}
