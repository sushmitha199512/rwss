package nic.watersoft.masters;
import java.util.ArrayList;

/**
 * @author Administrator
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Asset_PipeLine
{
	
	private String assetSubComp;
	private String assetCode="";
	private	ArrayList pipeClass;
	private	ArrayList pipeDia;
	private String isLast;
	private int currentRow;
	private int rowCount;
	private String rowId;
	
	
	
   //	PWS-PipeLine-Distribution
	 
	 private String disMaterial;
	 private String disClass;
	 private String disDiameter;
	 private String disLengths;
	 private String disCovered;
	 private String disTotLength;
	 private String disTotLenProvided;
	 private String length;
	
	
     private String disMaterialCode;
     private String disNoOfPipes;
     private String noOfPipes;
     private String habCode;
     private String airValvesNo;
     private String courValvesNo;
     private String sluiceValvesNo;
     private String pr_Hc_No;
     private String location;
     private String standPostsNo;
	 
     //PipeLine Distribution New 
    private String disHabCode;
    private String disCode;
    private String disLocation;
    private String disTotalLengthNeeded;
    private String disTotalLengthProvided;
    private String disFullVillagesCovered;
    private String disBalanceNeeded;
    private String disNoOfAirValves;
    private String disNoOfSluiceValves;
    private String disNoOfStandPosts;
    private String disNoOfScourValves;
    private String disNoOfPrivateHouseConnections;
     
     


    
     //CPWS-PipeLine-Distribution
	 
	 private String disType;
	
	 private String disNoOfHouseConnections;
	 private String disNoOfPipeLines;
	 
	 //	PWS-PipeLine-Stand Posts
	 private String spCode;
	 private String spNo;
	 private String hcNo;
	 private String pcRf;
	 private String pcUf;
	 private String pcHrs;
	 private String pcLv;
	 private String pcSuggestions;
	 private String pcFea;
	 private String pcCost;
	 private String pcDistance;
	 
	private String diameter;
	private String type;
	private String pclass;
	
	
	private String material;
	private String valves;
	private String publicStandPosts;
	private String houseConnections;
	private ArrayList pipeMaterialList;
	private ArrayList pipeDiameterList;
	private ArrayList pipeClassList;
	//PWS-Pumping-Main
	
	private String pmCond;
	private String pmRep;
	private String pmNat;
	private String pmScrvNo;
	private String pmSvNo;
	private String pmRvNo;
	private String pmAvNo;
	
	private String pmCode;
	private String pmMat;
	
	private String pmCla;
	private String pmDia ;
	private String pmLen;
	
	private String pmNatLoc;
	
	private String pmAvConG;
	private String pmAvConB;
	private String pmAvConNr;
	private String pmAvConCp;
	private String ssNo;
	private String pmScrvCondG;
	private String pmScrvCondB;
	private String pmScrvCondNr;
	private String pmScrvCondCp;
	
	private String pmSvCondG ;
	private String pmSvCondB;
	private String pmSvCondNr ;
	private String pmSvCondCp ;
	
	private String pmRvCondG ;
	private String pmRvCondB  ;
	private String pmRvCondNr ;
	private String pmRvCondCp ;
	
	private String pmZeroVelocityValve;
	private String pmAirCusionValve;
	private String pmNonReturnValve;
	private String PmLocation;
	private String pmHabCode;
	
//	CPWS PIPELINE GRAVITYMAIN
	

	private String  gravitymain_code;
	private String  hab_code;     
	private String  lengths; 
	private String  met_type;
	private String  fail_freq;
	private String  fail_type;
	private String  fail_reason;
	private String  airvalve_no;
	private String  airvalvepit_no; 
	private String  airvalvepit_cond_good;
	private String  airvalvepit_cond_bad;  
	private String  airvalvepit_cond_nrc; 
	private String  airvalvepit_cover;
	private String  airvalvepit_covered_no;
	private String  scourevalve;
	private String  sr_valvepit_no;
	private String  sr_valvepit_cond_good;   
	private String  sr_valvepit_cond_bad;
	private String  sr_valvepit_cond_nrc; 
	private String  sr_valvepit_cover ;
	private String  sr_valvepit_covered_no;
	private String  reflexvalve;
	private String  r_valvepit_no;
	private String  r_valvepit_cond_good;  
	private String  r_valvepit_cond_bad; 
	private String  r_valvepit_cond_nrc;
	private String  r_valvepit_cover;
	private String  r_valvepit_covered_no; 
	private String  sluicevalve ;
	private String  zeroVelocityValve ;
	private String  airCushionValve;
	private String  nonReturnValve;
	private String  sl_valvepit_no;
	private String  sl_valvepit_cond_good;
	private String  sl_valvepit_cond_bad ;
	private String  sl_valvepit_cond_nrc ;
	private String  sl_valvepit_cover;
	private String  sl_valvepit_covered_no;  
	private String gravitymain_location;
	
	//added for borewell
	
	 private String casing;
	 private String status;
	 private String genCondition;
	 private String pipeLength;
	 private String gino;
	 private String painted;
	 private String staticWaterLevel;
	 private String summerWaterLevel;
	 private String pcond;
	 private String dryduring;
	 private String service;
	 private String serno;
	 private String serhrs;
	 private String repairs;
	 private String platformCondition="";
	 private String drain;
	 private String drainCondition="";
	 private String drainsd;
	 private String drainlp;
	 private String hygiene;
	 private String avgtime;
	 private String pyield;
	 private String pyieldLocal;
	 private String period;
	
	/**
	 * @param assetCode
	 * @param pmCond
	 * @param pmRep
	 * @param pmNat
	 * @param pmScrvNo
	 * @param pmSvNo
	 * @param pmRvNo
	 * @param ssNo
	 * @param pmCode
	 */
	public Asset_PipeLine(String pmCode,String assetCode,String noOfPipes, String pmCond, String pmRep,
			String pmNat,String pmAvNo , String pmScrvNo, String pmSvNo, String pmRvNo) {
		super();
		this.assetCode = assetCode;
		this.pmCode = pmCode;
		this.noOfPipes = noOfPipes;
		this.pmCond = pmCond;
		this.pmRep = pmRep;
		this.pmNat = pmNat;
		this.pmAvNo = pmAvNo;
		this.pmScrvNo = pmScrvNo;
		this.pmSvNo = pmSvNo;
		this.pmRvNo = pmRvNo;
		
		
	}
	public Asset_PipeLine()
	{
		pipeMaterialList=new ArrayList();
		pipeDiameterList=new ArrayList();
		pipeClassList=new ArrayList();
	}
	
	
	public Asset_PipeLine(String assetSubComp,String diameter,String type,String pclass,String length,String valves,String publicStandPosts,String houseConnections)
	{
		this.assetSubComp=assetSubComp;    
		this.diameter=diameter;        
		this.type=type;            
		this.pclass=pclass;          
		this.length=length;          
		this.valves=valves;          
		this.publicStandPosts=publicStandPosts;
		this.houseConnections=houseConnections;

	}
	
	
 
	public Asset_PipeLine(String assetSubComp)
	{
		this.assetSubComp = assetSubComp;
	}
	/**
	 * @return Returns the assetSubComp.
	 */
	public String getAssetSubComp() {
		return assetSubComp;
	}
	/**
	 * @param assetSubComp The assetSubComp to set.
	 */
	public void setAssetSubComp(String assetSubComp) {
		this.assetSubComp = assetSubComp;
	}

/**
	 * @return Returns the assetCode
	 */
	public String getAssetCode() {
		return assetCode;
	}
	/**
	 * @param diameter The assetCode to set.
	 */
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}

	/**
	 * @return Returns the diameter.
	 */
	public String getDiameter() {
		return diameter;
	}
	/**
	 * @param diameter The diameter to set.
	 */
	public void setDiameter(String diameter) {
		this.diameter = diameter;
	}
	/**
	 * @return Returns the houseConnections.
	 */
	public String getHouseConnections() {
		return houseConnections;
	}
	/**
	 * @param houseConnections The houseConnections to set.
	 */
	public void setHouseConnections(String houseConnections) {
		this.houseConnections = houseConnections;
	}
	/**
	 * @return Returns the length.
	 */
	public String getLength() {
		return length;
	}
	/**
	 * @param length The length to set.
	 */
	public void setLength(String length) {
		this.length = length;
	}
	/**
	 * @return Returns the pclass.
	 */
	public String getPclass() {
		return pclass;
	}
	/**
	 * @param pclass The pclass to set.
	 */
	public void setPclass(String pclass) {
		this.pclass = pclass;
	}
	/**
	 * @return Returns the publicStandPosts.
	 */
	public String getPublicStandPosts() {
		return publicStandPosts;
	}
	/**
	 * @param publicStandPosts The publicStandPosts to set.
	 */
	public void setPublicStandPosts(String publicStandPosts) {
		this.publicStandPosts = publicStandPosts;
	}
	/**
	 * @return Returns the type.
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type The type to set.
	 */
	public void setType(String type) {
		this.type = type;
	}
	/**
	 * @return Returns the valves.
	 */
	public String getValves() {
		return valves;
	}
	/**
	 * @param valves The valves to set.
	 */
	public void setValves(String valves) {
		this.valves = valves;
	}
	
	public String getDisBalanceNeeded() {
		return disBalanceNeeded;
	}
	public void setDisBalanceNeeded(String disBalanceNeeded) {
		this.disBalanceNeeded = disBalanceNeeded;
	}
	public String getDisClass() {
		return disClass;
	}
	public void setDisClass(String disClass) {
		this.disClass = disClass;
	}
	public String getDisCovered() {
		return disCovered;
	}
	public void setDisCovered(String disCovered) {
		this.disCovered = disCovered;
	}
	public String getDisDiameter() {
		return disDiameter;
	}
	public void setDisDiameter(String disDiameter) {
		this.disDiameter = disDiameter;
	}
	public String getDisLengths() {
		return disLengths;
	}
	public void setDisLengths(String disLengths) {
		this.disLengths = disLengths;
	}
   public String getDisMaterial() {
	return disMaterial;
   }
   public void setDisMaterial(String disMaterial) {
	this.disMaterial = disMaterial;
   }
   	public String getdisMaterialCode() {
		return disMaterialCode;
	}
	public void setDisMaterialCode(String disMaterialCode) {
		this.disMaterialCode = disMaterialCode;
	}
	
	/**
	 * @return Returns the disNoOfPipes.
	 */
	public String getDisNoOfPipes() {
		return disNoOfPipes;
	}
	/**
	 * @param disNoOfPipes The disNoOfPipes to set.
	 */
	public void setDisNoOfPipes(String disNoOfPipes) {
		this.disNoOfPipes = disNoOfPipes;
	}
	
	/**
	 * @return Returns the noOfPipes.
	 */
	public String getNoOfPipes() {
		return noOfPipes;
	}
	/**
	 * @param noOfPipes The noOfPipes to set.
	 */
	public void setNoOfPipes(String noOfPipes) {
		this.noOfPipes = noOfPipes;
	}
	public String getDisTotLength() {
		return disTotLength;
	}
	public void setDisTotLength(String disTotLength) {
		this.disTotLength = disTotLength;
	}
	public String getDisTotLenProvided() {
		return disTotLenProvided;
	}
	public void setDisTotLenProvided(String disTotLenProvided) {
		this.disTotLenProvided = disTotLenProvided;
	}
	
	public String getDisCode() {
		return disCode;
	}
	public void setDisCode(String disCode) {
		this.disCode = disCode;
	}
	
	
	public String getHcNo() {
		return hcNo;
	}
	public void setHcNo(String hcNo) {
		this.hcNo = hcNo;
	}
	public String getPcCost() {
		return pcCost;
	}
	public void setPcCost(String pcCost) {
		this.pcCost = pcCost;
	}
	public String getPcDistance() {
		return pcDistance;
	}
	public void setPcDistance(String pcDistance) {
		this.pcDistance = pcDistance;
	}
	public String getPcFea() {
		return pcFea;
	}
	public void setPcFea(String pcFea) {
		this.pcFea = pcFea;
	}
	public String getPcHrs() {
		return pcHrs;
	}
	public void setPcHrs(String pcHrs) {
		this.pcHrs = pcHrs;
	}
	public String getPcLv() {
		return pcLv;
	}
	public void setPcLv(String pcLv) {
		this.pcLv = pcLv;
	}
	public String getPcRf() {
		return pcRf;
	}
	public void setPcRf(String pcRf) {
		this.pcRf = pcRf;
	}
	public String getPcSuggestions() {
		return pcSuggestions;
	}
	public void setPcSuggestions(String pcSuggestions) {
		this.pcSuggestions = pcSuggestions;
	}
	public String getPcUf() {
		return pcUf;
	}
	public void setPcUf(String pcUf) {
		this.pcUf = pcUf;
	}
	public String getSpCode() {
		return spCode;
	}
	public void setSpCode(String spCode) {
		this.spCode = spCode;
	}
	public String getSpNo() {
		return spNo;
	}
	public void setSpNo(String spNo) {
		this.spNo = spNo;
	}
	
	
	public String getDisNoOfHouseConnections() {
		return disNoOfHouseConnections;
	}
	public void setDisNoOfHouseConnections(String disNoOfHouseConnections) {
		this.disNoOfHouseConnections = disNoOfHouseConnections;
	}
	public String getDisNoOfPipeLines() {
		return disNoOfPipeLines;
	}
	public void setDisNoOfPipeLines(String disNoOfPipeLines) {
		this.disNoOfPipeLines = disNoOfPipeLines;
	}
	public String getDisNoOfStandPosts() {
		return disNoOfStandPosts;
	}
	public void setDisNoOfStandPosts(String disNoOfStandPosts) {
		this.disNoOfStandPosts = disNoOfStandPosts;
	}
	public String getDisType() {
		return disType;
	}
	public void setDisType(String disType) {
		this.disType = disType;
	}
	/*added by madhu*/
	
	/*end of madhu*/
	public String getPmAvConB() {
		return pmAvConB;
	}
	public void setPmAvConB(String pmAvConB) {
		//System.out.println("in aaet pipeline set");
		this.pmAvConB = pmAvConB;
	}
	public String getPmAvConCp() {
		//System.out.println("in aaet pipeline get");
		
		return pmAvConCp;
	}
	public void setPmAvConCp(String pmAvConCp) {
		this.pmAvConCp = pmAvConCp;
	}
	public String getPmAvConG() {
		return pmAvConG;
	}
	public void setPmAvConG(String pmAvConG) {
		this.pmAvConG = pmAvConG;
	}
	public String getPmAvConNr() {
		return pmAvConNr;
	}
	public void setPmAvConNr(String pmAvConNr) {
		this.pmAvConNr = pmAvConNr;
	}
	public String getPmAvNo() {
		return pmAvNo;
	}
	public void setPmAvNo(String pmAvNo) {
		this.pmAvNo = pmAvNo;
	}
	public String getPmCla() {
		return pmCla;
	}
	public void setPmCla(String pmCla) {
		this.pmCla = pmCla;
	}
	public String getPmCode() {
		return pmCode;
	}
	public void setPmCode(String pmCode) {
		this.pmCode = pmCode;
	}
	public String getPmCond() {
		return pmCond;
	}
	public void setPmCond(String pmCond) {
		this.pmCond = pmCond;
	}
	public String getPmDia() {
		return pmDia;
	}
	public void setPmDia(String pmDia) {
		this.pmDia = pmDia;
	}
	public String getPmLen() {
		return pmLen;
	}
	public void setPmLen(String pmLen) {
		this.pmLen = pmLen;
	}
	public String getPmMat() {
		//System.out.println("in saaet pipeline get");
		
		return pmMat;
	}
	public void setPmMat(String pmMat) {
		this.pmMat = pmMat;
	}
	public String getPmNat() {
		return pmNat;
	}
	public void setPmNat(String pmNat) {
		this.pmNat = pmNat;
	}
	public String getPmNatLoc() {
		return pmNatLoc;
	}
	public void setPmNatLoc(String pmNatLoc) {
		this.pmNatLoc = pmNatLoc;
	}
	public String getPmRep() {
		return pmRep;
	}
	public void setPmRep(String pmRep) {
		this.pmRep = pmRep;
	}
	public String getPmRvCondB() {
		return pmRvCondB;
	}
	public void setPmRvCondB(String pmRvCondB) {
		this.pmRvCondB = pmRvCondB;
	}
	public String getPmRvCondCp() {
		return pmRvCondCp;
	}
	public void setPmRvCondCp(String pmRvCondCp) {
		this.pmRvCondCp = pmRvCondCp;
	}
	public String getPmRvCondG() {
		return pmRvCondG;
	}
	public void setPmRvCondG(String pmRvCondG) {
		this.pmRvCondG = pmRvCondG;
	}
	public String getPmRvCondNr() {
		return pmRvCondNr;
	}
	public void setPmRvCondNr(String pmRvCondNr) {
		this.pmRvCondNr = pmRvCondNr;
	}
	public String getPmRvNo() {
		return pmRvNo;
	}
	public void setPmRvNo(String pmRvNo) {
		this.pmRvNo = pmRvNo;
	}
	public String getPmScrvCondB() {
		return pmScrvCondB;
	}
	public void setPmScrvCondB(String pmScrvCondB) {
		this.pmScrvCondB = pmScrvCondB;
	}
	public String getPmScrvCondCp() {
		return pmScrvCondCp;
	}
	public void setPmScrvCondCp(String pmScrvCondCp) {
		this.pmScrvCondCp = pmScrvCondCp;
	}
	public String getPmScrvCondG() {
		return pmScrvCondG;
	}
	public void setPmScrvCondG(String pmScrvCondG) {
		this.pmScrvCondG = pmScrvCondG;
	}
	public String getPmScrvCondNr() {
		return pmScrvCondNr;
	}
	public void setPmScrvCondNr(String pmScrvCondNr) {
		this.pmScrvCondNr = pmScrvCondNr;
	}
	public String getPmScrvNo() {
		return pmScrvNo;
	}
	public void setPmScrvNo(String pmScrvNo) {
		this.pmScrvNo = pmScrvNo;
	}
	public String getPmSvCondB() {
		return pmSvCondB;
	}
	public void setPmSvCondB(String pmSvCondB) {
		this.pmSvCondB = pmSvCondB;
	}
	public String getPmSvCondCp() {
		return pmSvCondCp;
	}
	public void setPmSvCondCp(String pmSvCondCp) {
		this.pmSvCondCp = pmSvCondCp;
	}
	public String getPmSvCondG() {
		return pmSvCondG;
	}
	public void setPmSvCondG(String pmSvCondG) {
		this.pmSvCondG = pmSvCondG;
	}
	public String getPmSvCondNr() {
		return pmSvCondNr;
	}
	public void setPmSvCondNr(String pmSvCondNr) {
		this.pmSvCondNr = pmSvCondNr;
	}
	public String getPmSvNo() {
		return pmSvNo;
	}
	public void setPmSvNo(String pmSvNo) {
		this.pmSvNo = pmSvNo;
	}
	public String getSsNo() {
		return ssNo;
	}
	public void setSsNo(String ssNo) {
		this.ssNo = ssNo;
	}
	
	/**
	 * @return Returns the lengths.
	 */
	public String getLengths() {
		return lengths;
	}
	/**
	 * @param lengths The lengths to set.
	 */
	public void setLengths(String lengths) {
		this.lengths = lengths;
	}
	/**
	 * @return Returns the airvalve_no.
	 */
	public String getAirvalve_no() {
		return airvalve_no;
	}
	/**
	 * @param airvalve_no The airvalve_no to set.
	 */
	public void setAirvalve_no(String airvalve_no) {
		this.airvalve_no = airvalve_no;
	}
	/**
	 * @return Returns the airvalvepit_cond_bad.
	 */
	public String getAirvalvepit_cond_bad() {
		return airvalvepit_cond_bad;
	}
	/**
	 * @param airvalvepit_cond_bad The airvalvepit_cond_bad to set.
	 */
	public void setAirvalvepit_cond_bad(String airvalvepit_cond_bad) {
		this.airvalvepit_cond_bad = airvalvepit_cond_bad;
	}
	/**
	 * @return Returns the airvalvepit_cond_good.
	 */
	public String getAirvalvepit_cond_good() {
		return airvalvepit_cond_good;
	}
	/**
	 * @param airvalvepit_cond_good The airvalvepit_cond_good to set.
	 */
	public void setAirvalvepit_cond_good(String airvalvepit_cond_good) {
		this.airvalvepit_cond_good = airvalvepit_cond_good;
	}
	/**
	 * @return Returns the airvalvepit_cond_nrc.
	 */
	public String getAirvalvepit_cond_nrc() {
		return airvalvepit_cond_nrc;
	}
	/**
	 * @param airvalvepit_cond_nrc The airvalvepit_cond_nrc to set.
	 */
	public void setAirvalvepit_cond_nrc(String airvalvepit_cond_nrc) {
		this.airvalvepit_cond_nrc = airvalvepit_cond_nrc;
	}
	/**
	 * @return Returns the airvalvepit_cover.
	 */
	public String getAirvalvepit_cover() {
		return airvalvepit_cover;
	}
	/**
	 * @param airvalvepit_cover The airvalvepit_cover to set.
	 */
	public void setAirvalvepit_cover(String airvalvepit_cover) {
		this.airvalvepit_cover = airvalvepit_cover;
	}
	/**
	 * @return Returns the airvalvepit_covered_no.
	 */
	public String getAirvalvepit_covered_no() {
		return airvalvepit_covered_no;
	}
	/**
	 * @param airvalvepit_covered_no The airvalvepit_covered_no to set.
	 */
	public void setAirvalvepit_covered_no(String airvalvepit_covered_no) {
		this.airvalvepit_covered_no = airvalvepit_covered_no;
	}
	/**
	 * @return Returns the airvalvepit_no.
	 */
	public String getAirvalvepit_no() {
		return airvalvepit_no;
	}
	/**
	 * @param airvalvepit_no The airvalvepit_no to set.
	 */
	public void setAirvalvepit_no(String airvalvepit_no) {
		this.airvalvepit_no = airvalvepit_no;
	}
	/**
	 * @return Returns the fail_freq.
	 */
	public String getFail_freq() {
		return fail_freq;
	}
	/**
	 * @param fail_freq The fail_freq to set.
	 */
	public void setFail_freq(String fail_freq) {
		this.fail_freq = fail_freq;
	}
	/**
	 * @return Returns the fail_reason.
	 */
	public String getFail_reason() {
		return fail_reason;
	}
	/**
	 * @param fail_reason The fail_reason to set.
	 */
	public void setFail_reason(String fail_reason) {
		this.fail_reason = fail_reason;
	}
	/**
	 * @return Returns the fail_type.
	 */
	public String getFail_type() {
		return fail_type;
	}
	/**
	 * @param fail_type The fail_type to set.
	 */
	public void setFail_type(String fail_type) {
		this.fail_type = fail_type;
	}
	/**
	 * @return Returns the gravitymain_code.
	 */
	public String getGravitymain_code() {
		
		return gravitymain_code;
	}
	/**
	 * @param gravitymain_code The gravitymain_code to set.
	 */
	public void setGravitymain_code(String gravitymain_code) {
		
		this.gravitymain_code = gravitymain_code;
	}
	/**
	 * @return Returns the hab_code.
	 */
	public String getHab_code() {
		return hab_code;
	}
	/**
	 * @param hab_code The hab_code to set.
	 */
	public void setHab_code(String hab_code) {
		this.hab_code = hab_code;
	}
	/**
	 * @return Returns the met_type.
	 */
	public String getMet_type() {
		return met_type;
	}
	/**
	 * @param met_type The met_type to set.
	 */
	public void setMet_type(String met_type) {
		this.met_type = met_type;
	}
	/**
	 * @return Returns the r_valvepit_cond_bad.
	 */
	public String getR_valvepit_cond_bad() {
		return r_valvepit_cond_bad;
	}
	/**
	 * @param r_valvepit_cond_bad The r_valvepit_cond_bad to set.
	 */
	public void setR_valvepit_cond_bad(String r_valvepit_cond_bad) {
		this.r_valvepit_cond_bad = r_valvepit_cond_bad;
	}
	/**
	 * @return Returns the r_valvepit_cond_good.
	 */
	public String getR_valvepit_cond_good() {
		return r_valvepit_cond_good;
	}
	/**
	 * @param r_valvepit_cond_good The r_valvepit_cond_good to set.
	 */
	public void setR_valvepit_cond_good(String r_valvepit_cond_good) {
		this.r_valvepit_cond_good = r_valvepit_cond_good;
	}
	/**
	 * @return Returns the r_valvepit_cond_nrc.
	 */
	public String getR_valvepit_cond_nrc() {
		return r_valvepit_cond_nrc;
	}
	/**
	 * @param r_valvepit_cond_nrc The r_valvepit_cond_nrc to set.
	 */
	public void setR_valvepit_cond_nrc(String r_valvepit_cond_nrc) {
		this.r_valvepit_cond_nrc = r_valvepit_cond_nrc;
	}
	/**
	 * @return Returns the r_valvepit_cover.
	 */
	public String getR_valvepit_cover() {
		return r_valvepit_cover;
	}
	/**
	 * @param r_valvepit_cover The r_valvepit_cover to set.
	 */
	public void setR_valvepit_cover(String r_valvepit_cover) {
		this.r_valvepit_cover = r_valvepit_cover;
	}
	/**
	 * @return Returns the r_valvepit_covered_no.
	 */
	public String getR_valvepit_covered_no() {
		return r_valvepit_covered_no;
	}
	/**
	 * @param r_valvepit_covered_no The r_valvepit_covered_no to set.
	 */
	public void setR_valvepit_covered_no(String r_valvepit_covered_no) {
		this.r_valvepit_covered_no = r_valvepit_covered_no;
	}
	/**
	 * @return Returns the r_valvepit_no.
	 */
	public String getR_valvepit_no() {
		return r_valvepit_no;
	}
	/**
	 * @param r_valvepit_no The r_valvepit_no to set.
	 */
	public void setR_valvepit_no(String r_valvepit_no) {
		this.r_valvepit_no = r_valvepit_no;
	}
	/**
	 * @return Returns the reflexvalve.
	 */
	public String getReflexvalve() {
		return reflexvalve;
	}
	/**
	 * @param reflexvalve The reflexvalve to set.
	 */
	public void setReflexvalve(String reflexvalve) {
		this.reflexvalve = reflexvalve;
	}
	/**
	 * @return Returns the scourevalve.
	 */
	public String getScourevalve() {
		return scourevalve;
	}
	/**
	 * @param scourevalve The scourevalve to set.
	 */
	public void setScourevalve(String scourevalve) {
		this.scourevalve = scourevalve;
	}
	/**
	 * @return Returns the sl_valvepit_cond_bad.
	 */
	public String getSl_valvepit_cond_bad() {
		return sl_valvepit_cond_bad;
	}
	/**
	 * @param sl_valvepit_cond_bad The sl_valvepit_cond_bad to set.
	 */
	public void setSl_valvepit_cond_bad(String sl_valvepit_cond_bad) {
		this.sl_valvepit_cond_bad = sl_valvepit_cond_bad;
	}
	/**
	 * @return Returns the sl_valvepit_cond_good.
	 */
	public String getSl_valvepit_cond_good() {
		return sl_valvepit_cond_good;
	}
	/**
	 * @param sl_valvepit_cond_good The sl_valvepit_cond_good to set.
	 */
	public void setSl_valvepit_cond_good(String sl_valvepit_cond_good) {
		this.sl_valvepit_cond_good = sl_valvepit_cond_good;
	}
	/**
	 * @return Returns the sl_valvepit_cond_nrc.
	 */
	public String getSl_valvepit_cond_nrc() {
		return sl_valvepit_cond_nrc;
	}
	/**
	 * @param sl_valvepit_cond_nrc The sl_valvepit_cond_nrc to set.
	 */
	public void setSl_valvepit_cond_nrc(String sl_valvepit_cond_nrc) {
		this.sl_valvepit_cond_nrc = sl_valvepit_cond_nrc;
	}
	/**
	 * @return Returns the sl_valvepit_cover.
	 */
	public String getSl_valvepit_cover() {
		return sl_valvepit_cover;
	}
	/**
	 * @param sl_valvepit_cover The sl_valvepit_cover to set.
	 */
	public void setSl_valvepit_cover(String sl_valvepit_cover) {
		this.sl_valvepit_cover = sl_valvepit_cover;
	}
	/**
	 * @return Returns the sl_valvepit_covered_no.
	 */
	public String getSl_valvepit_covered_no() {
		return sl_valvepit_covered_no;
	}
	/**
	 * @param sl_valvepit_covered_no The sl_valvepit_covered_no to set.
	 */
	public void setSl_valvepit_covered_no(String sl_valvepit_covered_no) {
		this.sl_valvepit_covered_no = sl_valvepit_covered_no;
	}
	/**
	 * @return Returns the sl_valvepit_no.
	 */
	public String getSl_valvepit_no() {
		return sl_valvepit_no;
	}
	/**
	 * @param sl_valvepit_no The sl_valvepit_no to set.
	 */
	public void setSl_valvepit_no(String sl_valvepit_no) {
		this.sl_valvepit_no = sl_valvepit_no;
	}
	/**
	 * @return Returns the sluicevalve.
	 */
	public String getSluicevalve() {
		return sluicevalve;
	}
	/**
	 * @param sluicevalve The sluicevalve to set.
	 */
	public void setSluicevalve(String sluicevalve) {
		this.sluicevalve = sluicevalve;
	}
	/**
	 * @return Returns the sr_valvepit_cond_bad.
	 */
	public String getSr_valvepit_cond_bad() {
		return sr_valvepit_cond_bad;
	}
	/**
	 * @param sr_valvepit_cond_bad The sr_valvepit_cond_bad to set.
	 */
	public void setSr_valvepit_cond_bad(String sr_valvepit_cond_bad) {
		this.sr_valvepit_cond_bad = sr_valvepit_cond_bad;
	}
	/**
	 * @return Returns the sr_valvepit_cond_good.
	 */
	public String getSr_valvepit_cond_good() {
		return sr_valvepit_cond_good;
	}
	/**
	 * @param sr_valvepit_cond_good The sr_valvepit_cond_good to set.
	 */
	public void setSr_valvepit_cond_good(String sr_valvepit_cond_good) {
		this.sr_valvepit_cond_good = sr_valvepit_cond_good;
	}
	/**
	 * @return Returns the sr_valvepit_cond_nrc.
	 */
	public String getSr_valvepit_cond_nrc() {
		return sr_valvepit_cond_nrc;
	}
	/**
	 * @param sr_valvepit_cond_nrc The sr_valvepit_cond_nrc to set.
	 */
	public void setSr_valvepit_cond_nrc(String sr_valvepit_cond_nrc) {
		this.sr_valvepit_cond_nrc = sr_valvepit_cond_nrc;
	}
	/**
	 * @return Returns the sr_valvepit_cover.
	 */
	public String getSr_valvepit_cover() {
		return sr_valvepit_cover;
	}
	/**
	 * @param sr_valvepit_cover The sr_valvepit_cover to set.
	 */
	public void setSr_valvepit_cover(String sr_valvepit_cover) {
		this.sr_valvepit_cover = sr_valvepit_cover;
	}
	/**
	 * @return Returns the sr_valvepit_covered_no.
	 */
	public String getSr_valvepit_covered_no() {
		return sr_valvepit_covered_no;
	}
	/**
	 * @param sr_valvepit_covered_no The sr_valvepit_covered_no to set.
	 */
	public void setSr_valvepit_covered_no(String sr_valvepit_covered_no) {
		this.sr_valvepit_covered_no = sr_valvepit_covered_no;
	}
	/**
	 * @return Returns the sr_valvepit_no.
	 */
	public String getSr_valvepit_no() {
		return sr_valvepit_no;
	}
	/**
	 * @param sr_valvepit_no The sr_valvepit_no to set.
	 */
	public void setSr_valvepit_no(String sr_valvepit_no) {
		this.sr_valvepit_no = sr_valvepit_no;
	}

	public void setPipeClass(ArrayList pipeClass)
	{	this.pipeClass = pipeClass;
	}
	public ArrayList getPipeClass()
	{	return pipeClass;
	}
	
	/**
	 * @return Returns the pipeDia.
	 */
	public ArrayList getPipeDia() {
		return pipeDia;
	}
	/**
	 * @param pipeDia The pipeDia to set.
	 */
	public void setPipeDia(ArrayList pipeDia) {
		this.pipeDia = pipeDia;
	}
	/**
	 * @return Returns the disMaterialCode.
	 */
	public String getDisMaterialCode() {
		return disMaterialCode;
	}
	public String getMaterial() {
		return material;
	}
	public void setMaterial(String material) {
		this.material = material;
	}
	
	public ArrayList getPipeClassList() {
		return pipeClassList;
	}
	public void setPipeClassList(ArrayList pipeClassList) {
		this.pipeClassList = pipeClassList;
	}
	public ArrayList getPipeDiameterList() {
		return pipeDiameterList;
	}
	public void setPipeDiameterList(ArrayList pipeDiameterList) {
		this.pipeDiameterList = pipeDiameterList;
	}
	public ArrayList getPipeMaterialList() {
		return pipeMaterialList;
	}
	public void setPipeMaterialList(ArrayList pipeMaterialList) {
		this.pipeMaterialList = pipeMaterialList;
	}
	public String getIsLast() {
		return isLast;
	}
	public void setIsLast(String isLast) {
		this.isLast = isLast;
	}
	public String getGravitymain_location() {
		return gravitymain_location;
	}
	public void setGravitymain_location(String gravitymain_location) {
		this.gravitymain_location = gravitymain_location;
	}
	
	public String getAirValvesNo() {
		return airValvesNo;
	}
	public void setAirValvesNo(String airValvesNo) {
		this.airValvesNo = airValvesNo;
	}
	public String getCourValvesNo() {
		return courValvesNo;
	}
	public void setCourValvesNo(String courValvesNo) {
		this.courValvesNo = courValvesNo;
	}
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getPr_Hc_No() {
		return pr_Hc_No;
	}
	public void setPr_Hc_No(String pr_Hc_No) {
		this.pr_Hc_No = pr_Hc_No;
	}
	public String getSluiceValvesNo() {
		return sluiceValvesNo;
	}
	public void setSluiceValvesNo(String sluiceValvesNo) {
		this.sluiceValvesNo = sluiceValvesNo;
	}
	public String getStandPostsNo() {
		return standPostsNo;
	}
	public void setStandPostsNo(String standPostsNo) {
		this.standPostsNo = standPostsNo;
	}
	public String getDisFullVillagesCovered() {
		return disFullVillagesCovered;
	}
	public void setDisFullVillagesCovered(String disFullVillagesCovered) {
		this.disFullVillagesCovered = disFullVillagesCovered;
	}
	public String getDisHabCode() {
		return disHabCode;
	}
	public void setDisHabCode(String disHabCode) {
		this.disHabCode = disHabCode;
	}
	public String getDisLocation() {
		return disLocation;
	}
	public void setDisLocation(String disLocation) {
		this.disLocation = disLocation;
	}
	public String getDisNoOfAirValves() {
		return disNoOfAirValves;
	}
	public void setDisNoOfAirValves(String disNoOfAirValves) {
		this.disNoOfAirValves = disNoOfAirValves;
	}
	public String getDisNoOfPrivateHouseConnections() {
		return disNoOfPrivateHouseConnections;
	}
	public void setDisNoOfPrivateHouseConnections(
			String disNoOfPrivateHouseConnections) {
		this.disNoOfPrivateHouseConnections = disNoOfPrivateHouseConnections;
	}
	public String getDisNoOfScourValves() {
		return disNoOfScourValves;
	}
	public void setDisNoOfScourValves(String disNoOfScourValves) {
		this.disNoOfScourValves = disNoOfScourValves;
	}
	public String getDisNoOfSluiceValves() {
		return disNoOfSluiceValves;
	}
	public void setDisNoOfSluiceValves(String disNoOfSluiceValves) {
		this.disNoOfSluiceValves = disNoOfSluiceValves;
	}
	public String getDisTotalLengthNeeded() {
		return disTotalLengthNeeded;
	}
	public void setDisTotalLengthNeeded(String disTotalLengthNeeded) {
		this.disTotalLengthNeeded = disTotalLengthNeeded;
	}
	public String getDisTotalLengthProvided() {
		return disTotalLengthProvided;
	}
	public void setDisTotalLengthProvided(String disTotalLengthProvided) {
		this.disTotalLengthProvided = disTotalLengthProvided;
	}
	public void displayDistribution()
	{
		    //System.out.println(disHabCode);
		    //System.out.println(disCode);
		    //System.out.println(disLocation);
		    //System.out.println(disTotalLengthNeeded);
		    //System.out.println(disTotalLengthProvided);
		    //System.out.println(disFullVillagesCovered);
		    //System.out.println(disBalanceNeeded);
		    //System.out.println(disNoOfAirValves);
		    //System.out.println(disNoOfStandPosts);
		    //System.out.println(disNoOfScourValves);
		    //System.out.println(disNoOfPrivateHouseConnections);
	
	}
	public String getPmAirCusionValve() {
		return pmAirCusionValve;
	}
	public void setPmAirCusionValve(String pmAirCusionValve) {
		this.pmAirCusionValve = pmAirCusionValve;
	}
	public String getPmLocation() {
		return PmLocation;
	}
	public void setPmLocation(String pmLocation) {
		PmLocation = pmLocation;
	}
	public String getPmZeroVelocityValve() {
		return pmZeroVelocityValve;
	}
	public void setPmZeroVelocityValve(String pmZeroVelocityValve) {
		this.pmZeroVelocityValve = pmZeroVelocityValve;
	}
	public String getPmHabCode() {
		return pmHabCode;
	}
	public void setPmHabCode(String pmHabCode) {
		this.pmHabCode = pmHabCode;
	}
	public int getCurrentRow() {
		return currentRow;
	}
	public void setCurrentRow(int currentRow) {
		this.currentRow = currentRow;
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}
	public String getRowId() {
		return rowId;
	}
	public void setRowId(String rowId) {
		this.rowId = rowId;
	}
	
	public String getPmNonReturnValve() {
		return pmNonReturnValve;
	}
	public void setPmNonReturnValve(String pmNonReturnValve) {
		this.pmNonReturnValve = pmNonReturnValve;
	}
	
	public String getAirCushionValve() {
		return airCushionValve;
	}
	public void setAirCushionValve(String airCushionValve) {
		this.airCushionValve = airCushionValve;
	}
	public String getNonReturnValve() {
		return nonReturnValve;
	}
	public void setNonReturnValve(String nonReturnValve) {
		this.nonReturnValve = nonReturnValve;
	}
	public String getZeroVelocityValve() {
		return zeroVelocityValve;
	}
	public void setZeroVelocityValve(String zeroVelocityValve) {
		this.zeroVelocityValve = zeroVelocityValve;
	}
	
	public String getAvgtime() {
		return avgtime;
	}
	public void setAvgtime(String avgtime) {
		this.avgtime = avgtime;
	}
	public String getCasing() {
		return casing;
	}
	public void setCasing(String casing) {
		this.casing = casing;
	}
	public String getDrain() {
		return drain;
	}
	public void setDrain(String drain) {
		this.drain = drain;
	}
	public String getDrainCondition() {
		return drainCondition;
	}
	public void setDrainCondition(String drainCondition) {
		this.drainCondition = drainCondition;
	}
	public String getDrainlp() {
		return drainlp;
	}
	public void setDrainlp(String drainlp) {
		this.drainlp = drainlp;
	}
	public String getDrainsd() {
		return drainsd;
	}
	public void setDrainsd(String drainsd) {
		this.drainsd = drainsd;
	}
	public String getDryduring() {
		return dryduring;
	}
	public void setDryduring(String dryduring) {
		this.dryduring = dryduring;
	}
	public String getGenCondition() {
		return genCondition;
	}
	public void setGenCondition(String genCondition) {
		this.genCondition = genCondition;
	}
	public String getGino() {
		return gino;
	}
	public void setGino(String gino) {
		this.gino = gino;
	}
	public String getHygiene() {
		return hygiene;
	}
	public void setHygiene(String hygiene) {
		this.hygiene = hygiene;
	}
	public String getPainted() {
		return painted;
	}
	public void setPainted(String painted) {
		this.painted = painted;
	}
	public String getPcond() {
		return pcond;
	}
	public void setPcond(String pcond) {
		this.pcond = pcond;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getPipeLength() {
		return pipeLength;
	}
	public void setPipeLength(String pipeLength) {
		this.pipeLength = pipeLength;
	}
	public String getPlatformCondition() {
		return platformCondition;
	}
	public void setPlatformCondition(String platformCondition) {
		this.platformCondition = platformCondition;
	}
	public String getPyield() {
		return pyield;
	}
	public void setPyield(String pyield) {
		this.pyield = pyield;
	}
	public String getPyieldLocal() {
		return pyieldLocal;
	}
	public void setPyieldLocal(String pyieldLocal) {
		this.pyieldLocal = pyieldLocal;
	}
	public String getRepairs() {
		return repairs;
	}
	public void setRepairs(String repairs) {
		this.repairs = repairs;
	}
	public String getSerhrs() {
		return serhrs;
	}
	public void setSerhrs(String serhrs) {
		this.serhrs = serhrs;
	}
	public String getSerno() {
		return serno;
	}
	public void setSerno(String serno) {
		this.serno = serno;
	}
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public String getStaticWaterLevel() {
		return staticWaterLevel;
	}
	public void setStaticWaterLevel(String staticWaterLevel) {
		this.staticWaterLevel = staticWaterLevel;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSummerWaterLevel() {
		return summerWaterLevel;
	}
	public void setSummerWaterLevel(String summerWaterLevel) {
		this.summerWaterLevel = summerWaterLevel;
	}
}
