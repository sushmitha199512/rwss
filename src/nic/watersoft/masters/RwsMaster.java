package nic.watersoft.masters;
import java.io.Serializable;
import java.util.*;

import org.apache.struts.upload.FormFile;


public class RwsMaster  implements Serializable
{
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

	
	private String hoImgStatus;
	
	private String nrdwprelated;
	private String cmcoredb;
	private String branchAddress;
	private String progBelongTo;
	
	public String getBranchAddress() {
		return branchAddress;
	}
	public void setBranchAddress(String branchAddress) {
		this.branchAddress = branchAddress;
	}
	private String ifscCode;
    private String accountNo;



    private String adharNo;
    private FormFile hoImage;//TEJA
	
	 //Added by Sai Prasad N  on 15/10/2012
	private String divStatus;
	
	//	added by swapna on 19-12-2011
	private int plainHCon;
	private int stHCon;
	private int scHCon;
	
	private int plainHHold;
	private int stHHold;
	private int scHHold; 
//	added by swapna on 12-01-2012
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
//	added by swapna on 23-01-2012
	private String landmark;
//	added by swapna on 30-01-2012
	private int minorityHCon;
	private int minorityHHold;
//	added by swapna on 01-02-2012
	private int minorityCovered;
//	added by swapna on 02-02-2012
	private int censusMinority;
	//added by swapna
	private String bankCode;
	private String bankName;
	private String bankAbb;
	private String branchCode;
	private String branchName;
	private String bcode;
	private String  micrCode;
	private String offCode;
	private String accNo;
	private String bName;
	private String circleCode;
	private String divisionCode;
	private String circleName;
	private String divisionName;
	//
//	added by swapna 02-04-2011
	private String isItda;
	//
	//Added by sreelaxmi on 11-06-2012
//	Added on 11 june 2012
	private String waterAssetname;
	private String waterAssettype;
	private String waterSourcename;
	
	
	
	//added by jyothi on 24/09/2014
	
		private int publicTap;
		private int publicStandpost;	
		
		
		private int existCheckDams;
		private int reqCheckDams;
		
		
		//////added by anupama 09032015
		
		
		private int glsrno;
		private int glsrqty;
		private int ohsrno;
		private int ohsrqty;
		private String schemesource;
		
		private String linkageHabSupply;
		private String waterBeingSupplied="";
		private String lastRepairedDate="";
		private String typeofTreatment;
		private String plantCapacity;
		//////////////////	
		private String agencyCode;
		private String agencyName;
		private String hoImageStatus;
		private String aveCansSupplied;
		private String SourceExist;
		
	
	public String getAveCansSupplied() {
			return aveCansSupplied;
		}
		public void setAveCansSupplied(String aveCansSupplied) {
			this.aveCansSupplied = aveCansSupplied;
		}
	public String getHoImageStatus() {
			return hoImageStatus;
		}
		public void setHoImageStatus(String hoImageStatus) {
			this.hoImageStatus = hoImageStatus;
		}
	public String getHoImgStatus() {
			return hoImgStatus;
		}
		public void setHoImgStatus(String hoImgStatus) {
			this.hoImgStatus = hoImgStatus;
		}
	public int getExistCheckDams() {
			return existCheckDams;
		}
		public FormFile getHoImage() {
		return hoImage;
	}
	public void setHoImage(FormFile hoImage) {
		this.hoImage = hoImage;
	}
		public String getTypeofTreatment() {
		return typeofTreatment;
	}
	public void setTypeofTreatment(String typeofTreatment) {
		this.typeofTreatment = typeofTreatment;
	}
	public String getPlantCapacity() {
		return plantCapacity;
	}
	public void setPlantCapacity(String plantCapacity) {
		this.plantCapacity = plantCapacity;
	}
		public String getWaterBeingSupplied() {
		return waterBeingSupplied;
	}
	public void setWaterBeingSupplied(String waterBeingSupplied) {
		this.waterBeingSupplied = waterBeingSupplied;
	}
	
	public String getLastRepairedDate() {
		return lastRepairedDate;
	}
	public void setLastRepairedDate(String lastRepairedDate) {
		this.lastRepairedDate = lastRepairedDate;
	}
		public String getLinkageHabSupply() {
		return linkageHabSupply;
	}
	public void setLinkageHabSupply(String linkageHabSupply) {
		this.linkageHabSupply = linkageHabSupply;
	}
		public String getbName() {
		return bName;
	}
	public void setbName(String bName) {
		this.bName = bName;
	}

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
	public String getpCode() {
		return pCode;
	}
	public void setpCode(String pCode) {
		this.pCode = pCode;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getvCode() {
		return vCode;
	}
	public void setvCode(String vCode) {
		this.vCode = vCode;
	}
	public String getvName() {
		return vName;
	}
	public void setvName(String vName) {
		this.vName = vName;
	}
	public String getpRHabCode() {
		return pRHabCode;
	}
	public void setpRHabCode(String pRHabCode) {
		this.pRHabCode = pRHabCode;
	}
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
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
	public String getWaterAssetname() {
		return waterAssetname;
	}
	public void setWaterAssetname(String waterAssetname) {
		this.waterAssetname = waterAssetname;
	}
	public String getWaterAssettype() {
		return waterAssettype;
	}
	public void setWaterAssettype(String waterAssettype) {
		this.waterAssettype = waterAssettype;
	}
	public String getWaterSourcename() {
		return waterSourcename;
	}
	public void setWaterSourcename(String waterSourcename) {
		this.waterSourcename = waterSourcename;
	}
	// added by sadiq
	private java.util.ArrayList selectedHabLinks;
	private boolean isSaved=false;
	private boolean isChecked=false;

	//common fields
	
	
	private String noOfRecords;
	private String message;
	
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
	private String dpYield;
	
	private String user;
	
	private String constituencyCode;
	private String constituencyName;
	private String mcode;
	private String mname;
	private String pcode;
	private String pname;
	 //end
	private Collection assetHabs;
	private Collection assetSubComponents;
	private Collection assetPipeLine;
	private Collection assetHeadWorks;
	private Collection assetReservior;
	private Collection habInsts;
	private Collection sourceHabs;
	private Collection habWaterSupply;
	private Collection contaminations;
	  
	
	private String component;
	private String qualityAffected;
	
	private String prevYrStatus ="";       
	private String presentvYrStatus="";  
	private String proposedFcYr;
	private float proposedFCAmt;
	
	private String district;
	private String codeName;
	private String noOfMandals;
	
	private String othersNo;
	private String othersSupply;
	
	private int plainPop;
	private int scPop;
	private int stPop;

	private int totalPop;
	private int netPop;
	private int totalCovered;
	
	private int totHabs;
	private int totPopBenfit;

	private String assetCode="";
	private String assetName="";
	private String habitationCode;
	private String dateofCreation="";
	private String yield;
	private String pumpingHours;
	private String assetStatus="";
	private String assetCost="";
	private String startYear="";
	private String endYear="";
	private String defunctReasons;

	private String assetTypeCode;
	private String assetTypeName;
	private String codeSeries;
	private String assetCompTypeCode;
	private String assetCompTypeName;
	private String assetSubCompTypeCode;
	private String assetSubCompTypeName;

	private String remarks;
	private String valueOfWork;
	private String dimension;
	private String assetCompCode;
	private String workSpecCode;
	private String workSpecName;

	private String scopeOfAccess;
	private String accountActDate;
	private String accountDeActDate;
	private String passwordRecovery;

	private String dcode;
	private String dname;
	private String vcode;
	private String vname;
	private String districtDisp;
	
	private String contamCode;
	private String contamName="";
	private String contamNoName;
	private String contamPer;
	private String statusDate;
	
	
	private String Percent="";

	private String desgnCode;
	private String desgnAcr;
	private String desgnName;

	private String priorityCode;
	private String priorityDesc;
	private String priorityFrom;

	private String roleId;
	private String roleName;
	private String roleDesc;

	private String sourceCode;
	private String sourceName;
	private String sourceTypeCode;
	private String sourceTypeName;
	private String subSourceTypeName;
	private String subSourceTypeCode;
	private String noOfHab;
	private String seasonal;
	private String seasonalBorewell;
	private String presentCondition;
	private String waterQuality;
	private String levelOfCont;
	private String sourceAndLocation;


	private String diameterOfBorewell;
	private String depthOfBorewell;
	private String contType;
	private String popbenefited;
	private String waterLevel;
	private String distFromSource;
	private String street;

	private String hoc;
	private String hon;
	
//	added by jyothi 
	private String hoName;
	private ArrayList headdetails;
	
	
	public ArrayList getHeaddetails() {
		return headdetails;
	}
	public void setHeaddetails(ArrayList headdetails) {
		this.headdetails = headdetails;
	}
public String getHoName() {
	return hoName;
}
public void setHoName(String hoName) {
	this.hoName = hoName;
}
	private String coc;
	private String con;
	private String doc;
	private String don;
	private String mancode;
	private String sdoc;
	private String sdon;
	private String soc;
	private String son;
	private String roc;
	private String address;
	private String area;
	private String city;
	private String pin;
	private String phone;
	private String mobile;
	private String fax;
	private String email;
	private String building;
	private String hof;
	private String project;
	private String otherDet;
	
	private String sector;
	private String empcode;
	private String empname;
	private String dob;
	private String appointdate;
	private String doj;
	private String currentpostdate;
	private String totalworkscomp;
	private String qual;
	private String addqual1;
	private String addqual2;
	private String presentation;
	private String assetStatusName;
	private String checkType;
	private int noOfChecks=0;
	private String checkPeriod;
	private String appOrderRef;
	private String workSpecial;
	private String postCode;
	private int normalworks=0;
	private int projectworks=0;
	private int schemes=0;
	private int roads=0;
	private int bridges=0;
	
	private String qualCode;
	private String qualName;

	private String userId;
	private String userid;
	private String password;
	private String scope;
	private String permission;
	private String accActivateDate;
	private String accDeactivateDate;
	private String passRecovery;
	private String pCode;
	private String pName;
	private String vCode;
	private String vName;
	private String habName;
	private String mandal;
	private String storeCode;
	private String storeInCharge;
	private String postheld;
	private String subdivision;
	private String mandalCode;
	private String mandalName;
	private String supplierCode;
	private String supplierName;
	private String supplierRegNo;
	
	private String distNoName;
	private String desgnNoName;
	private String qualNoName;

	private String sourceTypeNoName;
	private String assetTypeNoName;

	private String publicRepCode;
	private String publicRepName;
	private String instituteCode="";
	private String instituteName="";
	private String insDisplay;
	private String panchRajCode;
	private String panchRajName;
	private String pRHabCode;
	private String habCode;
	private String jbCode;
	private String instituteNo="";
	private String instituteCovered="";
	private float nearWaterSource;
	private float nearWaterGroundSource;
	private String censusYear;
	private String habYear;
	private int censusPop;
	private int censusSc;
	private int censusSt;
	private int totPop;
	private int floatPop;
	private String floatReason="";
	
	private int popCovered;
	private int scCovered;
	private int stCovered;
	private int drinkingHp;
	private int drinkingShp;
	private int drinkingPsp;
	private int drinkingHc;
	private int drinkingOthers;
	private int drinkingPcpd;
	private int otherHp;
	private int otherShp;
	private int otherOw;
	private int otherPonds;
	private int otherOthers;
	private int otherPcpd;
	private int totPopCvrd;
	private String pwsSupply="";
	private String pwsNo="";
	private String cpwsNo="";
	private String cpwsSupply="";
	private String mpwsSupply="";
	private String othersSafeSupply="";
	private String othersSafeeNo="";
	private String mpwsNo="";
	private String dpSupply="";
	private String dpNo="";
	private String dwNo="";
	private String dwSupply="";
	private String cattleSupply="";
	private String cattleNo="";
	private String coveredStatus="";
	private int totalWaterSupply;
	private int totalWaterSupplySafe;
	private int totalWaterSupplyUnsafe;
	private int totalWaterSupplySafeOnly;
	private String levelOfWaterSupplySafeOnly;
	
	private String totOthersNo;
	private int totCattle;
	private int glsrCount;
	private int ohsrCount;
	private int glbrCount;
	private int ohbrCount;
	private int elsrCount;
	private String statusAsOn1405="";
	private String updateDate="";
	
	
	private int cattleReq;
	private int existWaterSupply;
	private int existWaterLevel;
	private int totBorewells;
	private int borewellsWorking;
	private int cpwsScheme;
	private int mpwsScheme;
	private int pwsScheme;
	private String fiqty;
	private String brqty;
	private String irqty;
	private String others="";
	private String habitation;
	private String totPopu;
	private String covStatus;
	
	private String sysDate;
	
	
	private String majorHeadCode;
	private String majorHeadName;
	private String submajorHeadCode;
	private String submajorHeadName;

	private String submajorDisplay;

	private String accountDisplay;

	private String minorHeadCode;
	private String minorHeadName;

	private String minorDisplay;

	private String grpSubHeadCode;
	private String grpSubHeadName;

	private String grpShDisplay;

	private String subHeadCode;
	private String subHeadName;

	private String shDisplay;

	private String detailHeadCode;
	private String detailHeadName;

	private String dhDisplay;

	private String subDetailHeadCode;
	private String subDetailHeadName;
	
	private String distcode; 
	private String paocode;  
	private String paoadd1;  
	private String paoadd2;  
	private String paoadd3;  
	private String paophone; 
	private String paoemail; 
	private String paofax;   

	/*
	 * varaibles added for PAO on 03/11/08
	 */
	
	private String address1;
	private String address2;
	private String address3;
	private String paoName;
	private String paoapao;
	
	
	
	private String prgmCode;
	private String prgmName;
	private String prgmStartYr;
	private double centralShare;
	private double stateShare;
	private double publicShare;
	private double otherShare;
	
	private String prgmEndDate;

	private String subprgmCode;
	private String subprgmName;
	private String subPrgDisplay;

	private String workid;         
	private String workeoatcode;  
	private String eoatno;        
	private String eoatdate;      
	private String daysextended;
		
		
	private String contractorCode;    
	private String contractorName;
	private String contractorClass;    
	private String contractorRating;
	private String contractorRegno;    
	private String registerAt;
	private String registrationDate;  
	
	private String panNo;
	private String tinNo;    
	private String validFrom;
	private String validTo;    
	private String projectsExecuted;
	private String projectsInhand;    
	private String projectsCompletedLastYear;
	private String projectsCompletedInTime;    
	private String projectsAbandoned;
	private String noofEoat;    
	private String noofSupplentary;
	private String noofPenalised;
	private String vatNo;
	private String specialize;
	
	private String firstName;
    private String lastName;
    private String middleName;
    private String voterId;

	private String testCode;
	private String testName; 
	private String testPeriod;

	private String testPCode; 
	private String testPName;
	private String minPerVal; 
	private String maxPerVal;
	private String testCodeDisplay;
	private String undesirableEffect;

	private String itemCode;      
	private String itemName;  
	private String distCode;    
	private String finyear;  
	private String units;
	private String rate;
	
	private int depth;
	private String measureType;
	private String uom;
	private String measureValue;
	private String labEstablishedYear;
	private String contactNum;
	private String levelCode;
 
	 private String labCode;
	 private String labName;
	 // Asset Borewell parameters
	 private String schemeCode;
	 private String location="";
	 private String tappingPoint;
	 private String yearOfDrilling;
	 private String diameter;
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
	// private String qualityAffected;
	 private double flouride;
	 private double brakish;
	 private double iron;
	 private double aresenic;
	 private double nitrate;
	 
	 private String flourideContamination;
	 private String brakishContamination;
	 private String ironContamination;
	 private String aresenicContamination;
	 private String nitrateContamination;
	
	 private String otherspecify="";
	 
	 
	 private String schemeCodeName;
	  
	 
	 //PONDS
	 private String pondCode;
	 private String pondName;
	 private String pondSize;
	 private String pondVolume;
	 private String pondServiceMonths;
	 
	 //OPEN WELLS
	 

	 private String owCode;
	 private String owLocation;
	 private String owDiameter;
	 private String owDepth;
	 private String owNormalwl;
	 private String owMinwl;
	 private String owMaxwl;
	 private String owPlatformExists;
	 private String owPlatformCondition;
	 private String owPurpose;
	 private String owQuality;
	 private String owFlouridePer;
	 private String owBrakishPer;
	 private String owIronPer;
	 private String owOtherType;
	 private String owOtherPer;
	 
	
	//Shallow Handpump Parameters
	 
	 private String shpCode;
	 private String shpLocation;
	 private String shpDiameter;
	 private String shpDepth;
	 private String shpHygiene;
	 private String shpAvgHours;
	 private String shpAvgTime;
	 private String shpYield;
	 
	 
	 
	
	 // Asset PWS BOREWELL PARAMETERS
	 
	 
	 private String popDes;
	 private String source;
	 private String sourceQuality;
	 private String sourceYield;
	 private String sourceDepend;
	 private String sourceDepth;
	 private String sourceDiameter;
	 private String sourceCondition;
	 private String sourceSwl;
	 private String sourceNwl;
	 private String phSize;
	 private String phCondition;
	 private String phType;
	 private String pumpName;
	 private String pumpCapacity;
	 private String pumpType;
	 private String purYear;
	 private String hrRun;
	 private String hrSin;
	 private String hrMs;
	 private String staExe;
	 private String pumpDutyLpm;
	 private String pumpDutyHead;
	 private String ifNss;
	 private String pumpNo;
	 private String standByPumpCapacity;
	 private String standByPumpNo ;
	 private String pmpCode;
	 private String number;
	 private String total_hp;
	 private String stand_by_numbers;
	 private String stand_by_total_hp;
	 
	 //added by ramesh
	 
	 private String isLast;
		int rowCount;
		int currentRow;
		
	 // PWS  GLSR Parameters
	 
	 private String glsrNo;
	 private String glsrLocation;
	 private String glsrCapacityInLts;
	 private String glsrMade;
	 private String glsrCondition;
	 private String glsrFillHrs;
	 private String glsrEmptyHrs;
	 private String glsrDraCondition;
	 private String glsrHygiene;
	 private String glsrNoOfFillings;
	 
	 private String noOfFillings;
	 
	 private String pumpCode;	  
	 private String designation;
	 private String office;
	 private String lowerlimit;
	 private String upperlimit;
	 
	 
	 // OHSR Parameters
	 	 
	 
	 
	 private String ohsrNo;
	 private String ohrsLts;
	 private String ohsrLocation;
	 private String ohsrHabLinkNo;
	 private String ohsrCapacityLts;
	 private String ohsrMade;
	 private String ohsrHt;
	 private String ohsrCond;
	 private String ohsrFillHrs;
	 private String ohsrEmptyHrs;
	 private String ohsrHygiene;
	 private String ohsrFen;
	 
	 // CPWS OHSR Parameters
	 

	 private String ohsrCode;
	 private String ohsrStages;
	 private String ohsrLwl;
	 private String ohsrMwl;
 
	 // CPWS OHBR Parameters
	 
 
	 
	 private String ohbrCode;
	 private String ohbrCapacityLts;
	 private String ohbrLocation;
	 private String ohbrStages;
	 private String ohbrLwl;
	 private String ohbrMwl;
	 private String ohbrFillHrs;
	 private String ohbrEmptyHrs;

	 // CPWS GLSR Parameters
 
	 
	 private String glsrCode;
	 private String glsrStages;
	 private String glsrLwl;
	 private String glsrMwl;
	 
 
	 
	 
	 private String GlbrCode;
	 private String glbrLocation;
	 private String glbrCapacityInLts;
	 private String glbrLwl;
	 private String glbrMwl;
	 private String glbrFillHrs;
	 private String glbrEmptyHrs;
	 
	 //Cisterns
	 
	 private String cisNo;
	 private String cisCode;
	 private String cisLocation;
	 private String cisCapLts;
	 private String cisCond;
	 private String cisPf;
	 private String cisPfCond;
	 private String cisDrain;
	 private String cisTap;
	 private String cisTapCond;
	 private String cisHr;
	 private String cisNoOfTaps;
	 
	 //PWS-PipeLine-Distribution
	 
	 private String disMaterial;
	 private String noOfPipes;
	 private String disNoOfPipes;
	 private String disClass;
	 private String disDiameter;
	 private String disLength;
	 private String disCovered;
	 private String disTotLength;
	 private String disTotLenProvided;
	 private String disBalanceNeeded;
	 private String disCode;
	 private String disMaterialCode;
	 
	 
	//PWS-PipeLine-Stand Posts
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
	 
	 //CPWS-Headworks-SS Tank
	 
	 private String ssTankCode;
	 private String ssSize;
	 private float ssDepth;
	 private String ssCapacityDays;
	 private String ssCapacityMcum;
	 private String ssTankAdeq;
	 private String ssTankLocation;
	 private String ssTankYield;
	 private String ssTankYieldDate;
	 private String powerConn;
	 private String powerConnOthers;
	 private String powerHours;
	
	 
	 // CPWS-Headworks-WTP
	 
	 private String wtpCode;
	 private String wtpType;
	 private String wtpMld;
	 private String wtpUnits;
	 private String wtpSize;
	 private String wtpUnitsStandby;
	 private String wtpBackwashFreq;
	 private String wtpPerformance;
	 private String wtpCapacityUse;
	 private String wtpExtentionScope;
	 private String wtpLocation;
	 private float wtpNoOfHoursOfUsage;
	 private double wtpRateOfFiltration;
	 private String wtpChkFilter;
	 private int wtpFreqSandScrap;
	 private int wtpShelter;
	 private String wtpRawWater;
	 private String wtpProductWater;
	 private boolean wtpSedimentationTank;
	 private boolean wtpHorizontalRoughingFilter;
	 private boolean wtpVerticalRoughingFilter;
	 private boolean wtpClarifloculator;
	 private String wtpSedimentationTankValue;
	 private String wtpHorizontalRoughingFilterValue;
	 private String wtpVerticalRoughingFilterValue;
	 private String wtpClarifloculatorValue;
	 
	  
	 //CPWS-Headworks-Sump
	 
	 private String sumpCode;
	 private String sumpType;
	 private String sumpCapacity;
	 private String sumpFillHr;
	 private String sumpEmptyHr;
	 private String sumpCondition;
	 private String sumpLocation;
	 private String sumpMadeOf;
	 private float sumpDiameter;
	 private float sumpDepth;
	 
	 private String collectionWellLocation;
	 
	 //CPWS-HeadWorks-Raw Water Collection well
	 
	 private String collectionWellCode;
	 private String rwDiameter;
	 private String rwDepth;
	 private String rwTypeOfFlooring;
	 private String rwCapacity;
	 private String rwLocation;
	
	   
	 
	 //CPWS-HeadWorks-Foot Path Bridge
	 
	 private String bridgeCode;
	 private String bridgeType;
	 private String bridgeLength;
	 private String bridgeWidth;
	 private String bridgeWalkwaywidth;
	 private String bridgeSpanLength;
	 private String bridgeLocation;
	 
	 //CPWS-HeadWorks-Pump House &&	 PWS-PUMPSETS-Pump House
	 
	 private String pumpHouseType;
	 private String pumpHouseArea;
	 private String pumpHouseHeight;
	 private String pumpHouseCode;
	 private String pumpCond;
	 private String pumpHouseLocation;
	// CPWS-HeadWorks-WATCHMAN QUARTER
	 
	 private String watchManCode;
	 private String watchManType;
	 private String watchManArea;
	 private String watchManLocation;
	 private String watchManNoOfQuarters;
	 
	 //CPWS-PipeLine-Distribution
	 
	 private String disType;
	 private String disNoOfStandPosts;
	 private String disNoOfHouseConnections;
	 private String disNoOfPipeLines;
	 private String disLengths;
	 
	 //CPWS-SR.Reservoirs-BPT
	 
	 private String bptCode;
	 private String bptLocation;
	 private String bptCapacity;
	 private String bptStaging;
	 private String bptMaxwl;
	 private String bptMinwl;
	 
	 //PWS-PUMPSETS-CAPACITORS
	 
	 
	 private String cpExist;
	 private String cpCond;
	 private String capacitors;
	 private String capacitorsConnect;
	 private String cpMainSwitch;
	 private String cpPilotLamps;
	 private String cpCutouts;
	 private String cpPhasing;
	 private String cpVoltMeter;
	 private String cpAmmeter;
	 private String cpStarter;
	 private String cpMs;
	 private String cpSb;
	 private String cpCode;
	 
	 private String date;
	 private String toDate;
	 private String fromDate;
	 private String module;
	 private String browser;
	 private String page; 
	 private String authType;
	 private String accessDate;
	 private String accessTime;
	 private String host;
	 
	 private String shpSupply="";
	private String shpNo="";
	private String cisternsSupply="";
	private String cisternsNo="";
	private String glsrSupply="";
	
	private String ohsrSupply="";
	private String drinkTotalSupply="";
	private String drinkTotalNo="";
	private String hpSupply="";
	private String hpNo="";
	private String owsSupply="";
	private String owsNo="";
	private String pondsSupply="";
	private String pondsNo="";
	private String shwSupply="";
	private String shwNo="";
	private String otherTotalSupply="";
	private String otherTotalNo="";
	private String pcpdDrink="";
	private String pcpdOthers="";
	private String pcpdTotal="";
	
	private String levelOfWaterSupply="";
	private String lpcdCooking ="";
	
//	PWS-Pumping-Main

	private String pmCond;
	private String pmRep;
	private String pmNat;
	private String pmScrvNo;
	private String pmSvNo;
	private String pmRvNo;
	private String ssNo;
	private String pmCode;
	
	private String pmAvNo;
	private String pmNatLoc;
	private String pmMat;
	private String pmCla;
	private String pmDia ;
	private String pmLen;
	private String pmAvConG;
	private String pmAvConB;
	private String pmAvConNr;
	private String pmAvConCp;
	
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
	
	//CPWS PIPELINE GRAVITYMAIN
	

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

//	CPWS PUMPSET PUMPDETAILS
	private String pumpdet_code; 
	private String pumpcode ;    
	private String hp  ; 
	private String type ;
	private String duty_con;
	private String head_mts;
	private String discharge_lpm ; 
	private String standby_hp   ;  
	private String years_used     ;
	private String failure_freq   ;
	private String avg_hr_pumping_day;
	private String repair_cost_year  ;
	private String capasitor     ;
	private String control_panel ;
	private String power_hours   ;
	private String work_hrs    ;
	private String qty_water_cum; 
	private String power_supply_available_hrs;  
	
	//cpws pumping main
	private String pumpingMainCode="";
	private String length="";
	private String metType="";
	private String failFreq="";
	private String failType="";
	private String failReason="";
	private String airValveNo="";
	private String airValvePitNo="";
	private String airValvePitCondGood="";
	private String airValvePitCondBad="";
	private String airValvePitCondNrc="";
	private String airValvePitCover="";
	private String airValvePitCoveredNo="";
	private String scoureValve="";
	private String srValvePitNo="";
	private String srValvePitCondGood="";
	private String srValvePitCondBad="";
	private String srValvePitCondNrc="";
	private String srValvePitCover="";
	private String srValvePitCoveredNo="";
	private String reflexValve="";
	private String rfValvePitNo="";
	private String rfValvePitCondGood="";
	private String rfValvePitCondBad="";
	private String rfValvePitCondNrc="";
	
	private String rfValvePitCover="";
	private String rfValvePitCoveredNo="";
	private String sluiceValve="";
	private String slValvePitNo="";
	private String slValvePitCondGood="" ;
	private String slValvePitCondBad="" ;
	private String slValvePitCondNrc ="";
	private String slValvePitCover ="" ;
	private String slValvePitCoveredNo="" ;
	
	
	//pumpsets
	 String pumpLocation;
	 String pumpMake;
	 String pumpYearOfCommissioning;
	 String pumpHoursRunningPerDay;
	 String pumpUsage;
	 String pumpDesignedHead;
	 String pumpDesignedLpm;
	 String pumpControlPanel;
	 String pmFeeder;
	 String pmHoursOfPowerAvailability;
	 String pmLowVoltageProblems;
	 String pmFeasiblityOfGettingUrbanLine;
	 String pmAppCostOfUrbanFeeder;
	 String pmDistanceFromWhereUrbanLineCanBeHad;
	 String pmLowVoltabeProblems;
	 String pmRemarks;

	
	
	//end of pumpsets
	//miscellaneous
	
	
	//HandPump Borewell
	
	//private String location;
	
	private String drillYear;
	//private String diameter;
   //	private String casing;;
	//private String status;
	//private String genCondition; 
	private String giNo; 
	//private String painted;
	private String staticWl; 
	private String summerWl;
	private String Cond; 
	private String dryDuring; 
	//private String service; 
	private String serNo; 
	private String serHrs; 
	//private String repairs;  
	private String platFormCondition; 
	private String Drain;   
	//private String drainCondition; 
	private String drainSd;  
	private String drainLp;
	//private String hygiene;  
	private String avgTime;  
	//private String yield;  
	private String yieldLocal; 
	//private String period; 
	private String asssetCode; 
	//private String depth ;
	private String hpCode ;
	private String othersType="";
	
	
	private String totOthersSupply;
	
	
	//code added for employeeDetails
	private String surname;
	private String relation;
	private String dacctest;
	private String diststudied4;
	private String diststudied5;
    private String diststudied6;
    private String diststudied7;
	private String diststudied8;
    private String diststudied9;
    private String diststudied10;
    private String localdist;
    private String noofyrs;
    private String noofyrs1;
    private String localzone;
    private String pvtdist;
    private String pvtzone;
    private String gender;
    private String nrevenue;
    private String testpassed;
    private String deputation;
    private String panno;
    private String aplgi;
    private String payscale;
    private String incrementdate;
    private String presentdesig;
    private String social;
    private String religion;
    private String zone;
    private String ndist;
    private String nmand;
    private String moap;
    private String apgli;
    private String tempdesig;
    private String perdesig;
    private String updatedate;
	private String tempdesgCode;
	private String narecruit;
	private String apcatog;
	
	
	//added on july 23
	private String moapCode;
	private String moapName;
	private String casteCode;
	private String casteName;
	private String relgCode;
	private String relgName;
	private String zoneCode;
	private String zoneName;
	private String catCode;
	private String catName;
	private String Doatest;
	private String dcommprob;
	private String ddeclprob;

	private String modeNoName;
	private String casteNoName;
	private String relgNoName;
	private String zoneNoName;
	private String catNoName;

	private String desig;
	
	private String distName4;
	private String distName5;
	private String distName6;
	private String distName7;
	private String distName8;
	private String distName9;
	private String distName10;
	private String localdistName;
	private String localzoneName;
	private String pvtdistName;
	private String pvtdistZone;
	
	private String gpfno;
	
	//end of code added for employee details

	
//	Variables used for Free Format report

	private int noOfHabs=0;
	private String panchCode="";
	private String panchName="";
	private String villCode="";
	private String villName="";
	private String distName="";
	private String[] compl_stat;
	private String[] prev_stat1;
	private String cp="";
	private String csc="";
	private String cst="";
	private String ctot="";
	private String flopop1="";
	private String censusFloat="";
	private String censusTotal="";
	private String floreason=null;
	private String tot_wat_supl="";
	private String ext_wat_lvl="";
	private String near_surf_source="";
	private String near_ground_source="";
	private String prop_year1="";
	private String amnt_reqd1="";
	private String cp_condition="";
	private String csc_condition="";
	private String cst_condition="";
	private String ctot_condition="";
	private String flopop_condition="";
	private String tot_wat_supl_condition="";
	private String ext_wat_lvl_condition="";
	private String near_surf_source_condition="";
	private String near_ground_source_condition="";
	private String amnt_reqd_condition="";
	
	
	private String habType;
	
	// added by ramesh on 17/09/08
	private String habSubType;
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
	private int houseConn;
	private int safeSource;
	private int existSource;
	private String habCat;
	private int cattles;
	private String slipReasonCode;
	
	/*
	 * added by ramesh for work free format
	 */
	
	private String mode;
	private String panchayat;
	private String village;
	private String habcode;
	private String offices;
	private String division;
	private String program;
	private String subprogram;
	private String workcategory;
	private String scheme;
	private String expyear;
	private String noh_condition;
	private String nohabs;
	private String plan;
	private String augnew;
	private String addate_condition;
	private String adminSancDate;
	private String asa_condition;
	private String asa;
	private String tsdate_condition;
	private String techSancDate;
	private String tsa_condition;
	private String tsa;
	private String sid_condition;
	private String sidDate;
	private String sidhand_condition;
	private String sidhandDate;
	private String condate_condition;
	private String conDate;
	private String condur_condition;
	private String conDur;
	private String wrkexp_condition;
	private String wrkExp;
	private String wrkcompdt_condition;
	private String wrkcompDate;
	private String wrkcommdt_condition;
	private String wrkcommDate;
	private String creport;
	private String constituency;
	
	//added by sridhar 
	private String wrkprobDate;
	private String wrkprob_condition;
	
	public String getWrkprob_condition() {
		return wrkprob_condition;
	}
	public void setWrkprob_condition(String wrkprob_condition) {
		this.wrkprob_condition = wrkprob_condition;
	}
	public String getWrkprobDate() {
		return wrkprobDate;
	}
	public void setWrkprobDate(String wrkprobDate) {
		this.wrkprobDate = wrkprobDate;
	}
	// end 
	/*
	 * added by ramesh on 250509 for unsafe field addition
	 */

	private String pwsUnsafeNo;
	private String pwsUnsafeSupply;
	private String mpwsUnsafeNo;
	private String mpwsUnsafeSupply;
	private String ncSourceType;
	private String sourceDistance;
	
	//added by ramesh on 231009
	private String contTypes1;
	private String contTypes2;
	private String contTypes3;
	private String contTypes4;
	private String contTypes5;
	
	//added by ramesh on 051009
	
	private String compExists;
	
	//added by ramesh on 181209
	private int surfaceSourceCount;
	private int subsurfaceSourceCount;
	
	/*
	 * end of the variables by ramesh
	 */
//	added by ramesh on 150510
	private String isMinorityHab;
	private String isLwe;
	private String unsafeLpcd;
	
	
	private String safeSHPNo;

	private String safeSHPSupply;
	private String imageStatus;
	
	//	added by pranavi
	
	private String ftktestid;
	
	
	
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	public String getAdharNo() {
		return adharNo;
	}
	public void setAdharNo(String adharNo) {
		this.adharNo = adharNo;
	}
	public String getIfscCode() {
		return ifscCode;
	}
	public void setIfscCode(String ifscCode) {
		this.ifscCode = ifscCode;
	}
	/**
	 * @return Returns the ftktestid
	 */
	public String getFtktestid() {
		return ftktestid;
	}
	/**
	 * @param ftktestid The ftktestid to set.
	 */
	public void setFtktestid(String ftktestid) {
		this.ftktestid = ftktestid;
	}
	
	// end of code  added by pranavi
	
	
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
//end of free format report variables
	
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
	 public void setOffice(String office)
	{
		this.office=office;
	}
	public String getOffice()
	{
		return office;
	}

	public void setDesignation(String designation)
	{
		this.designation=designation;
	}
	public String getDesignation()
	{
		return designation;
	}
		
	public void setLowerLimit(String lowerlimit)
	{
		this.lowerlimit=lowerlimit;
	}
	public String getLowerLimit()
	{
		return lowerlimit;
	}
	public void setUpperLimit(String upperlimit)
	{
		this.upperlimit=upperlimit;
	}
	public String getUpperLimit()
	{
		return upperlimit;
	}
	
	public void setToDate(String toDate)
	{
		this.toDate=toDate;
	}
	public String getToDate()
	{
		return toDate;
	}
	public void setFromDate(String fromDate)
	{
		this.fromDate=fromDate;
	}
	public String getFromDate()
	{
		return fromDate;
	}
	
	//for view
	/*
	public void setUserId(String userId)
	{
		this.userId=userId;
	}
	public String getUserId()
	{
		return userId;
	}
	*/
	public void setAuthType(String authType)
	{
		this.authType=authType;
	}
	public String getAuthType()
	{
		return authType;
	}
	public void setAccessDate(String accessDate)
	{
		this.accessDate=accessDate;
	}
	public String getAccessDate()
	{
		return accessDate;
	}
	public void setAccessTime(String accessTime)
	{
		this.accessTime=accessTime;
	}
	public String getAccessTime()
	{
		return accessTime;
	}
	public void setModule(String module)
	{
		this.module=module;
	}
	public String getModule()
	{
		return module;
	}
	public void setPage(String page)
	{
		this.page=page;
	}
	public String getPage()
	{
		return page;
	}
	/*
	public void setAddress(String address)
	{
		this.address=address;
	}
	public String getAddress()
	{
		return address;
	}
	*/
	public void setHost(String host)
	{
		this.host=host;
	}
	public String getHost()
	{
		return host;
	}
	public void setBrowser(String browser)
	{
		this.browser=browser;
	}
	public String getBrowser()
	{
		return browser;
	}
	
	
	//***********************Programme Methods********************//
		public void setPrgmCode(String prgmCode)
	{
		this.prgmCode=prgmCode;
	}
	public String getPrgmCode()
	{
		return prgmCode;
	}
	public void setPrgmName(String prgmName)
	{
		this.prgmName=prgmName;
	}
	public String getPrgmName()
	{
		return prgmName;
	}
	public void setPrgmStartYr(String prgmStartYr)
	{
		this.prgmStartYr=prgmStartYr;
	}
	public String getPrgmStartYr()
	{
		return prgmStartYr;
	}
	
	public double getCentralShare() {
		return centralShare;
	}
	public void setCentralShare(double centralShare) {
		this.centralShare = centralShare;
	}
	public double getStateShare() {
		return stateShare;
	}
	public void setStateShare(double stateShare) {
		this.stateShare = stateShare;
	}
	public double getPublicShare() {
		return publicShare;
	}
	public void setPublicShare(double publicShare) {
		this.publicShare = publicShare;
	}
	public double getOtherShare() {
		return otherShare;
	}
	public void setOtherShare(double otherShare) {
		this.otherShare = otherShare;
	}
	public void setStatus(String status)
	{
		this.status=status;
	}
	public String getStatus()
	{
		return status;
	}
	public void setPrgmEndDate(String prgmEndDate)
	{
		this.prgmEndDate=prgmEndDate;
	}
	public String getPrgmEndDate()
	{
		return prgmEndDate;
	}
	public void setSubPrgDisplay(String subPrgDisplay)
	{
		this.subPrgDisplay=subPrgDisplay;
	}
	public String getSubPrgDisplay()
	{
		return subPrgDisplay;
	}

	//************************SubProgramme Methods********************//
	
	public void setSubprgmCode(String subprgmCode)
	{
		this.subprgmCode=subprgmCode;
	}
	public String getSubprgmCode()
	{
		return subprgmCode;
	}
	public void setSubprgmName(String subprgmName)
	{
		this.subprgmName=subprgmName;
	}
	public String getSubprgmName()
	{
		return subprgmName;
	}

	
	//**********************HEAD ACCOUNT METHODS************************//

	public void setMajorHeadCode(String majorHeadCode)
	{
		this.majorHeadCode=majorHeadCode;
	}
	public String getMajorHeadCode()
	{
		return majorHeadCode;
	}
	public void setMajorHeadName(String majorHeadName)
	{
		this.majorHeadName=majorHeadName;
	}
	public String getMajorHeadName()
	{
		return majorHeadName;
	}

	public void setSubmajorHeadCode(String submajorHeadCode)
	{
		this.submajorHeadCode=submajorHeadCode;
	}
	public String getSubmajorHeadCode()
	{
		return submajorHeadCode;
	}

	public void setSubmajorHeadName(String submajorHeadName)
	{
		this.submajorHeadName=submajorHeadName;
	}
	public String getSubmajorHeadName()
	{
		return submajorHeadName;
	}
	public void setAccountDisplay(String accountDisplay)
	{
		this.accountDisplay=accountDisplay;
	}
	public String getAccountDisplay()
	{
		return accountDisplay;
	}
	
	public void setSubmajorDisplay(String submajorDisplay)
	{
		this.submajorDisplay=submajorDisplay;
	}
	public String getSubmajorDisplay()
	{
		return submajorDisplay;
	}
	public void setMinorHeadCode(String minorHeadCode)
	{
		this.minorHeadCode=minorHeadCode;
	}
	public String getMinorHeadCode()
	{
		return minorHeadCode;
	}
	public void setMinorHeadName(String minorHeadName)
	{
		this.minorHeadName=minorHeadName;
	}
	public String getMinorHeadName()
	{
		return minorHeadName;
	}

	public void setMinorDisplay(String minorDisplay)
	{
		this.minorDisplay=minorDisplay;
	}
	public String getMinorDisplay()
	{
		return minorDisplay;
	}
	public void setSubHeadCode(String subHeadCode)
	{
		this.subHeadCode=subHeadCode;
	}
	public String getSubHeadCode()
	{
		return subHeadCode;
	}
	public void setSubHeadName(String subHeadName)
	{
		this.subHeadName=subHeadName;
	}
	public String getSubHeadName()
	{
		return subHeadName;
	}

	public void setShDisplay(String shDisplay)
	{
		this.shDisplay=shDisplay;
	}
	public String getShDisplay()
	{
		return shDisplay;
	}
		

	public void setDetailHeadCode(String detailHeadCode)
	{
		this.detailHeadCode=detailHeadCode;
	}
	public String getDetailHeadCode()
	{
		return detailHeadCode;
	}
	public void setDetailHeadName(String detailHeadName)
	{
		this.detailHeadName=detailHeadName;
	}
	public String getDetailHeadName()
	{
		return detailHeadName;
	}
	public void setDhDisplay(String dhDisplay)
	{
		this.dhDisplay=dhDisplay;
	}
	public String getDhDisplay()
	{
		return dhDisplay;
	}
	
	public void setSubDetailHeadCode(String subDetailHeadCode)
	{
		this.subDetailHeadCode=subDetailHeadCode;
	}
	public String getSubDetailHeadCode()
	{
		return subDetailHeadCode;
	}
	public void setSubDetailHeadName(String subDetailHeadName)
	{
		this.subDetailHeadName=subDetailHeadName;
	}
	public String getSubDetailHeadName()
	{
		return subDetailHeadName;
	}
	public void setGrpSubHeadCode(String grpSubHeadCode)
	{
		this.grpSubHeadCode=grpSubHeadCode;
	}
	public String getGrpSubHeadCode()
	{
		return grpSubHeadCode;
	}
	public void setGrpSubHeadName(String grpSubHeadName)
	{
		this.grpSubHeadName=grpSubHeadName;
	}
	public String getGrpSubHeadName()
	{
		return grpSubHeadName;
	}
	
	public void setGrpShDisplay(String grpShDisplay)
	{
		this.grpShDisplay=grpShDisplay;
	}
	public String getGrpShDisplay()
	{
		return grpShDisplay;
	}
//**********************************************************
public void setDistcode(String distcode)
	{
		this.distcode=distcode;
	}
	public String getDistcode()
	{
		return distcode;
	}
	public void setPaocode(String paocode)
	{
		this.paocode=paocode;
	}
	public String getPaocode()
	{
		return paocode;
	}
	public void setPaoadd1(String paoadd1)
	{
		this.paoadd1=paoadd1;
	}
	public String getPaoadd1()
	{
		return paoadd1;
	}
	public void setPaoadd2(String paoadd2)
	{
		this.paoadd2=paoadd2;
	}
	public String getPaoadd2()
	{
		return paoadd2;
	}
	public void setPaoadd3(String paoadd3)
	{
		this.paoadd3=paoadd3;
	}
	public String getPaoadd3()
	{
		return paoadd3;
	}
	public void setPaophone(String paophone)
	{
		this.paophone=paophone;
	}
	public String getPaophone()
	{
		return paophone;
	}
	public void setPaoemail(String paoemail)
	{
		this.paoemail=paoemail;
	}
	public String getPaoemail()
	{
		return paoemail;
	}
	public void setPaofax(String paofax)
	{
		this.paofax=paofax;
	}
	public String getPaofax()
	{
		return paofax;
	}
//*********************************************************************************//
	public void setWorkid(String workid)
	{
		this.workid=workid;
	}
	public String getWorkid()
	{
		return workid;
	}
	public void setWorkeoatcode(String workeoatcode)
	{
		this.workeoatcode=workeoatcode;
	}
	public String getWorkeoatcode()
	{
		return workeoatcode;
	}
	public void setEoatno(String eoatno)
	{
		this.eoatno=eoatno;
	}
	public String getEoatno()
	{
		return eoatno;
	}
		public void setEoatdate(String eoatdate)
	{
		this.eoatdate=eoatdate;
	}
	public String getEoatdate()
	{
		return eoatdate;
	}
	public void setDaysextended(String daysextended)
	{
		this.daysextended=daysextended;
	}
	public String getDaysextended()
	{
		return daysextended;
	}
	
//**************************************************************************************//
		public void setContractorName(String contractorName)
	{
		this.contractorName=contractorName;
	}
	public String getContractorName()
	{
		return contractorName;
	}
	public void setContractorCode(String contractorCode)
	{
		this.contractorCode=contractorCode;
	}
	public String getContractorCode()
	{
		return contractorCode;
	}
	public void setContractorClass(String contractorClass)
	{
		this.contractorClass=contractorClass;
	}
	public String getContractorClass()
	{
		return contractorClass;
	}
	public void setContractorRating(String contractorRating)
	{
		this.contractorRating=contractorRating;
	}
	public String getContractorRating()
	{
		return contractorRating;
	}
	public void setContractorRegno(String contractorRegno)
	{
		this.contractorRegno=contractorRegno;
	}
	public String getContractorRegno()
	{
		return contractorRegno;
	}
	public void setRegisterAt(String registerAt)
	{
		this.registerAt=registerAt;
	}
	public String getRegisterAt()
	{
		return registerAt;
	}
	public void setRegistrationDate(String registrationDate)
	{
		this.registrationDate=registrationDate;
	}
	public String getRegistrationDate()
	{
		return registrationDate;
	}
	
	public void setPanNo(String panNo)
	{
		this.panNo=panNo;
	}
	public String getPanNo()
	{
		return panNo;
	}
	public void setVatNo(String vatNo)
	{
		this.vatNo=vatNo;
	}
	public String getVatNo()
	{
		return vatNo;
	}
	public void setSpecialize(String specialize)
	{
		this.specialize=specialize;
	}
	public String getSpecialize()
	{
		return specialize;
	}

	public void setTinNo(String tinNo)
	{
		this.tinNo=tinNo;
	}
	public String getTinNo()
	{
		return tinNo;
	}
	public void setValidFrom(String validFrom)
	{
		this.validFrom=validFrom;
	}
	public String getValidFrom()
	{
		return validFrom;
	}
	public void setValidTo(String validTo)
	{
		this.validTo=validTo;
	}
	public String getValidTo()
	{
		return validTo;
	}
	public void setProjectsExecuted(String projectsExecuted)
	{
		this.projectsExecuted=projectsExecuted;
	}
	public String getProjectsExecuted()
	{
		return projectsExecuted;
	}
	public void setProjectsInhand(String projectsInhand)
	{
		this.projectsInhand=projectsInhand;
	}
	public String getProjectsInhand()
	{
		return projectsInhand;
	}
	public void setProjectsCompletedLastYear(String projectsCompletedLastYear)
	{
		this.projectsCompletedLastYear=projectsCompletedLastYear;
	}
	public String getProjectsCompletedLastYear()
	{
		return projectsCompletedLastYear;
	}
	public void setProjectsCompletedInTime(String projectsCompletedInTime)
	{
		this.projectsCompletedInTime=projectsCompletedInTime;
	}
	public String getProjectsCompletedInTime()
	{
		return projectsCompletedInTime;
	}
	public void setProjectsAbandoned(String projectsAbandoned)
	{
		this.projectsAbandoned=projectsAbandoned;
	}
	public String getProjectsAbandoned()
	{
		return projectsAbandoned;
	}
	public void setNoofEoat(String noofEoat)
	{
		this.noofEoat=noofEoat;
	}
	public String getNoofEoat()
	{
		return noofEoat;
	}
	public void setNoofSupplentary(String noofSupplentary)
	{
		this.noofSupplentary=noofSupplentary;
	}
	public String getNoofSupplentary()
	{
		return noofSupplentary;
	}
	public void setNoofPenalised(String noofPenalised)
	{
		this.noofPenalised=noofPenalised;
	}
	public String getNoofPenalised()
	{
		return noofPenalised;
	}
	public void setStreet(String street)
	{
		this.street=street;
	}
	public String getStreet()
	{
		return street;
	}

	//*********************************Water Quality Methods**************************//
	public void setTestCode(String testCode)
	{
		this.testCode=testCode;
	}
	public String getTestCode()
	{
		return testCode;
	}
	

		public void setTestCodeDisplay(String testCodeDisplay)
	{
		this.testCodeDisplay=testCodeDisplay;
	}
	public String getTestCodeDisplay()
	{
		return testCodeDisplay;
	}

	public void setTestName(String testName)
	{
		this.testName=testName;
	}
	public String getTestName()
	{
		return testName;
	}
	public void setTestPeriod(String testPeriod)
	{
		this.testPeriod=testPeriod;
	}
	public String getTestPeriod()
	{
		return testPeriod;
	}
//*********************************************************************************//


	public void setTestPCode(String testPCode)
	{
		this.testPCode=testPCode;
	}
	public String getTestPCode()
	{
		return testPCode;
	}
	public void setTestPName(String testPName)
	{
		this.testPName=testPName;
	}
	public String getTestPName()
	{
		return testPName;
	}
	public void setMinPerVal(String minPerVal)
	{
		this.minPerVal=minPerVal;
	}
	public String getMinPerVal()
	{
		return minPerVal;
	}
	public void setMaxPerVal(String maxPerVal)
	{
		this.maxPerVal=maxPerVal;
	}
	public String getMaxPerVal()
	{
		return maxPerVal;
	}

	//*********************************Item Methods*********************************//
	public void setItemCode(String itemCode)
	{
		this.itemCode=itemCode;
	}
	public String getItemCode()
	{
		return itemCode;
	}
	public void setItemName(String itemName)
	{
		this.itemName=itemName;
	}
	public String getItemName()
	{
		return itemName;
	}
	public void setDistCode(String distCode)
	{
		this.distCode=distCode;
	}
	public String getDistCode()
	{
		return distCode;
	}
		public void setFinyear(String finyear)
	{
		this.finyear=finyear;
	}
	public String getFinyear()
	{
		return finyear;
	}
	public void setUnits(String units)
	{
		this.units=units;
	}
	public String getUnits()
	{
		return units;
	}
	public void setRate(String rate)
	{
		this.rate=rate;
	}
	public String getRate()
	{
		return rate;
	}
//*************ASSETCOMPONENT METHODS & ASSET COMPONENT TYPE METHODS*********//
	
	
	
	public void setAssetTypeCode(String assetTypeCode)
	{
		this.assetTypeCode=assetTypeCode;
	}
	public String getAssetTypeCode()
	{
		return assetTypeCode;
	}
	public void setAssetTypeName(String assetTypeName)
	{
		this.assetTypeName=assetTypeName;
	}
	public String getAssetTypeName()
	{
		return assetTypeName;
	}
	public void setAssetCompTypeCode(String assetCompTypeCode)
	{
		this.assetCompTypeCode=assetCompTypeCode;
	}
	public String getAssetCompTypeCode()
	{
		return assetCompTypeCode;
	}
	public void setAssetCompTypeName(String assetCompTypeName)
	{
		this.assetCompTypeName=assetCompTypeName;
	}
	public String getAssetCompTypeName()
	{
		return assetCompTypeName;
	}
	public void setUom(String uom)
	{
		this.uom=uom;
	}
	public String getUom()
	{
		return uom;
	}
	public void setAssetTypeNoName(String assetTypeNoName)
	{
		this.assetTypeNoName=assetTypeNoName;
	}
	public String getAssetTypeNoName()
	{
		return assetTypeNoName;
	}

	
	
	
	
	
	//*************ASSET METHODS ***********************//

	public void setAssetCode(String assetCode)
	{
		this.assetCode=assetCode;
	}
	public String getAssetCode()
	{
		return assetCode;
	}
	public void setAssetName(String assetName)
	{
		this.assetName=assetName;
	}
	public String getAssetName()
	{
		return assetName;
	}
	
	public void setHabitationCode(String habitationCode)
	{
		this.habitationCode=habitationCode;
	}
	public String getHabitationCode()
	{
		return habitationCode;
	}
	public void setDateofCreation(String dateofCreation)
	{
		this.dateofCreation=dateofCreation;
	}
	public String getDateofCreation()
	{
		return dateofCreation;
	}
	public void setLocation(String location)
	{
		this.location=location;
	}
	public String getLocation()
	{
		return location;
	}
	public void setYield(String yield)
	{
		this.yield=yield;
	}
	public String getYield()
	{
		return yield;
	}
	public void setPumpingHours(String pumpingHours)
	{
		this.pumpingHours=pumpingHours;
	}
	public String getPumpingHours()
	{
		return pumpingHours;
	}
	public void setAssetStatus(String assetStatus)
	{
		this.assetStatus=assetStatus;
	}
	public String getAssetStatus()
	{
		return assetStatus;
	}
	public void setStartYear(String startYear)
	{
		this.startYear=startYear;
	}
	public String getStartYear()
	{
		return startYear;
	}
	public void setEndYear(String endYear)
	{
		this.endYear=endYear;
	}
	public String getEndYear()
	{
		return endYear;
	}

	public void setAssetCost(String assetCost)
	{
		this.assetCost=assetCost;
	}
	public String getAssetCost()
	{
		return assetCost;
	}

	public void setRemarks(String remarks)
	{
		this.remarks=remarks;
	}
	public String getRemarks()
	{
		return remarks;
	}
	public void setValueOfWork(String valueOfWork)
	{
		this.valueOfWork=valueOfWork;
	}
	public String getValueOfWork()
	{
		return valueOfWork;
	}
	public void setDimension(String dimension)
	{
		this.dimension=dimension;
	}
	public String getDimension()
	{
		return dimension;
	}
	public void setAssetCompCode(String assetCompCode)
	{
		this.assetCompCode=assetCompCode;
	}
	public String getAssetCompCode()
	{
		return assetCompCode;
	}
//*****************asset Sub component methods***************
	public void setAssetSubCompTypeCode(String assetSubCompTypeCode)
	{
		this.assetSubCompTypeCode=assetSubCompTypeCode;
	}
	public String getAssetSubCompTypeCode()
	{
		return assetSubCompTypeCode;
	}
	public void setAssetSubCompTypeName(String assetSubCompTypeName)
	{
		this.assetSubCompTypeName=assetSubCompTypeName;
	}
	public String getAssetSubCompTypeName()
	{
		return assetSubCompTypeName;
	}
	 
	 //*********************CONTAMINATION METHOS***************** 

	public void setContamCode(String contamCode)
	{
		this.contamCode=contamCode;
	}
	public String getContamCode()
	{
		return contamCode;
	}
	public void setContamName(String contamName)
	{
		 
		this.contamName=contamName;
	}
	public String getContamName()
	{
		return contamName;
	}
	public void setContamNoName(String contamNoName)
	{
		this.contamNoName=contamNoName;
	}
	public String getContamNoName()
	{
		return contamNoName;
	}

    //*************DESIGNATION METHODS****************//

	public void setDesgnCode(String desgnCode)
	{
		this.desgnCode=desgnCode;
	}
	public String getDesgnCode()
	{
		return desgnCode;
	}
	public void setDesgnAcr(String desgnAcr)
	{
		this.desgnAcr=desgnAcr;
	}
	public String getDesgnAcr()
	{
		return desgnAcr;
	}
	public void setDesgnName(String desgnName)
	{
		this.desgnName=desgnName;
	}
	public String getDesgnName()
	{
		return desgnName;
	}
	//*********District Codes****************//
	public void setDcode(String dcode)
	{
		this.dcode=dcode;
	}
	public String getDcode()
	{
		return dcode;
	}
	public void setDname(String dname)
	{
		this.dname=dname;
	}
	public String getDname()
	{
		return dname;
	}
	
	//*************ROLES METHODS****************//
	
	public void setRoleId(String roleId)
	{
		this.roleId=roleId;
	}
	public String getRoleId()
	{
		return roleId;
	}
	public void setRoleName(String roleName)
	{
		this.roleName=roleName;
	}
	public String getRoleName()
	{
		return roleName;
	}
	public void setRoleDesc(String roleDesc)
	{
		this.roleDesc=roleDesc;
	}
	public String getRoleDesc()
	{
		return roleDesc;
	}


//************************SOURCE METHODS*******************//

    public void setSourceCode(String sourceCode)
	{
		this.sourceCode=sourceCode;
	}
	public String getSourceCode()
	{
		return sourceCode;
	}
	public void setSourceTypeCode(String sourceTypeCode)
	{
		this.sourceTypeCode=sourceTypeCode;
	}
	public String getSourceTypeCode()
	{
		return sourceTypeCode;
	}
	public void setSourceTypeName(String sourceTypeName)
	{
		this.sourceTypeName=sourceTypeName;
	}
	public String getSourceTypeName()
	{
		return sourceTypeName;
	}
	public void setSourceName(String sourceName)
	{
		this.sourceName=sourceName;
	}
	public String getSourceName()
	{
		return sourceName;
	}
	public void setSubSourceTypeCode(String subSourceTypeCode)
	{
		this.subSourceTypeCode=subSourceTypeCode;
	}
	public String getSubSourceTypeCode()
	{
		return subSourceTypeCode;
	}
	public void setSubSourceTypeName(String subSourceTypeName)
	{
		this.subSourceTypeName=subSourceTypeName;
	}
	public String getSubSourceTypeName()
	{
		return subSourceTypeName;
	}
	public void setNoOfHab(String noOfHab)
	{
		this.noOfHab=noOfHab;
	}
	public String getNoOfHab()
	{
		return noOfHab;
	}
	
	public void setSeasonal(String seasonal)
	{
		this.seasonal=seasonal;
	}
	public String getSeasonal()
	{
		return seasonal;
	}
	public void setContType(String contType)
	{
		this.contType=contType;
	}
	public String getContType()
	{
		return contType;
	}
	public void setPopbenefited(String popbenefited)
	{
		this.popbenefited=popbenefited;
	}
	public String getPopbenefited()
	{
		return popbenefited;
	}
	
	public void setDistFromSource(String distFromSource)
	{
		this.distFromSource=distFromSource;
	}
	public String getDistFromSource()
	{
		return distFromSource;
	}
	public void setWaterQuality(String waterQuality)
	{
		this.waterQuality=waterQuality;
	}
	public String getWaterQuality()
	{
	   if(this.waterQuality!=null && this.waterQuality.equals("SAFE SOURCE")){
		   	waterQuality="SAFESOURCE";	
		   }
		return waterQuality;
	}
	public void setLevelOfCont(String levelOfCont)
	{
		this.levelOfCont=levelOfCont;
	}
	public String getLevelOfCont()
	{
		return levelOfCont;
	}
	public void setPresentCondition(String presentCondition)
	{
		this.presentCondition=presentCondition;
	}
	public String getPresentCondition()
	{
		return presentCondition;
	}
	public void setStaticWaterLevel(String staticWaterLevel)
	{
		this.staticWaterLevel=staticWaterLevel;
	}
	public String getStaticWaterLevel()
	{
		return staticWaterLevel;
	}
	public void setSummerWaterLevel(String summerWaterLevel)
	{
		this.summerWaterLevel=summerWaterLevel;
	}
	public String getSummerWaterLevel()
	{
		return summerWaterLevel;
	}
	public void setDiameterOfBorewell(String diameterOfBorewell)
	{
		this.diameterOfBorewell=diameterOfBorewell;
	}
	public String getDiameterOfBorewell()
	{
		return diameterOfBorewell;
	}
	public void setDepthOfBorewell(String depthOfBorewell)
	{
		this.depthOfBorewell=depthOfBorewell;
	}
	public String getDepthOfBorewell()
	{
		return depthOfBorewell;
	}
	public void setYearOfDrilling(String yearOfDrilling)
	{
		this.yearOfDrilling=yearOfDrilling;
	}
	public String getYearOfDrilling()
	{
		return yearOfDrilling;
	}
	//--------*********District Display------------**********

	public void setDistrictDisp(String districtDisp)
	{
		this.districtDisp=districtDisp;
	}
	public String getDistrictDisp()
	{
		return districtDisp;
	}

	//***********************OFFICE METHODS*********************//

	public void setHoc(String hoc)
	{
		this.hoc=hoc;
	}
	public String getHoc()
	{
		return hoc;
	}
	public void setHon(String hon)
	{
		this.hon=hon;
	}
	public String getHon()
	{
		return hon;
	}
	public void setCoc(String coc)
	{
		this.coc=coc;
	}
	public String getCoc()
	{
		return coc;
	}
	public void setCon(String con)
	{
		this.con=con;
	}
	public String getCon()
	{
		return con;
	}
	public void setDoc(String doc)
	{
		this.doc=doc;
	}
	public String getDoc()
	{
		return doc;
	}
	public void setDon(String don)
	{
		this.don=don;
	}
	public String getDon()
	{
		return don;
	}
	public void setMancode(String mancode)
	{
		this.mancode=mancode;
	}
	public String getMancode()
	{
		return mancode;
	}
	public void setSdoc(String sdoc)
	{
		this.sdoc=sdoc;
	}
	public String getSdoc()
	{
		return sdoc;
	}
	public void setSdon(String sdon)
	{
		this.sdon=sdon;
	}
	public String getSdon()
	{
		return sdon;
	}
	public void setSoc(String soc)
	{
		this.soc=soc;
	}
	public String getSoc()
	{
		return soc;
	}
	public void setSon(String son)
	{
		this.son=son;
	}
	public String getSon()
	{
		return son;
	}
	public void setRoc(String roc)
	{
		this.roc=roc;
	}
	public String getRoc()
	{
		return roc;
	}
	public void setAddress(String address)
	{
		this.address=address;
	}
	public String getAddress()
	{
		return address;
	}

	public void setArea(String area)
	{
		this.area=area;
	}
	public String getArea()
	{
		return area;
	}
	public void setCity(String city)
	{
		this.city=city;
	}
	public String getCity()
	{
		return city;
	}
	public void setPin(String pin)
	{
		this.pin=pin;
	}
	public String getPin()
	{
		return pin;
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
	public void setFax(String fax)
	{
		this.fax=fax;
	}
	public String getFax()
	{
		return fax;
	}
	public void setEmail(String email)
	{
		this.email=email;
	}
	public String getEmail()
	{
		return email;
	}
	public void setBuilding(String building)
	{
		this.building=building;
	}
	public String getBuilding()
	{
		return building;
	}
	public void setHof(String hof)
	{
		this.hof=hof;
	}
	public String getHof()
	{
		return hof;
	}
	public void setProject(String project)
	{
		this.project=project;
	}
	public String getProject()
	{
		return project;
	}
	
	//**********************EMPLOYEE METODS************************//
	
	public void setSector(String sector)
	{
		this.sector=sector;
	}
	public String getSector()
	{
		return sector;
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
	////////////////////////////////////////////////////////////////////////////
	public void setNormalworks(int normalworks)
	{
		this.normalworks=normalworks;
	}
	public int getNormalworks()
	{
		return normalworks;
	}
	public void setProjectworks(int projectworks)
	{
		this.projectworks=projectworks;
	}
	public int getProjectworks()
	{
		return projectworks;
	}
	public void setSchemes(int schemes)
	{
		this.schemes=schemes;
	}
	public int getSchemes()
	{
		return schemes;
	}
	public void setRoads(int roads)
	{
		this.roads=roads;
	}
	public int getRoads()
	{
		return roads;
	}
	public void setBridges(int bridges)
	{
		this.bridges=bridges;
	}
	public int getBridges()
	{
		return bridges;
	}
	
	public void setQualCode(String qualCode)
	{
		this.qualCode=qualCode;
	}
	public String getQualCode()
	{
		return qualCode;
	}
	public void setQualName(String qualName)
	{
		this.qualName=qualName;
	}
	public String getQualName()
	{
		return qualName;
	}
	
	
	//*********************PASSWORD METHODS********************//
	
	public void setUserId(String userId)
	{
		this.userId=userId;
	}
	public String getUserId()
	{
		return userId;
	}
	public void setPassword(String password)
	{
		this.password=password;
	}
	public String getPassword()
	{
		return password;
	}
	public void setScope(String scope)
	{
		this.scope=scope;
	}
	public String getScope()
	{
		return scope;
	}
	public void setPermission(String permission)
	{
		this.permission=permission;
	}
	public String getPermission()
	{
		return permission;
	}
	public void setAccActivateDate(String accActivateDate)
	{
		this.accActivateDate=accActivateDate;
	}
	public String getAccActivateDate()
	{
		return accActivateDate;
	}
	public void setAccDeactivateDate(String accDeactivateDate)
	{
		this.accDeactivateDate=accDeactivateDate;
	}
	public String getAccDeactivateDate()
	{
		return accDeactivateDate;
	}
	public void setPassRecovery(String passRecovery)
	{
		this.passRecovery=passRecovery;
	}
	public String getPassRecovery()
	{
		return passRecovery;
	}
//************************District Number and Name***************//

	public void setDistNoName(String distNoName)
	{
		this.distNoName=distNoName;
	}
	public String getDistNoName()
	{
		return distNoName;
	}
	public void setDesgnNoName(String desgnNoName)
	{
		this.desgnNoName=desgnNoName;
	}
	public String getDesgnNoName()
	{
		return desgnNoName;
	}
	public void setQualNoName(String qualNoName)
	{
		this.qualNoName=qualNoName;
	}
	public String getQualNoName()
	{
		return qualNoName;
	}
	public void setSourceTypeNoName(String sourceTypeNoName)
	{
		this.sourceTypeNoName=sourceTypeNoName;
	}
	public String getSourceTypeNoName()
	{
		return sourceTypeNoName;
	}
	
	public void setScopeOfAccess(String scopeOfAccess)
	{
		this.scopeOfAccess=scopeOfAccess;
	}
	public String getScopeOfAccess()
	{
		return scopeOfAccess;
	}
		
	public void setAccountActDate(String accountActDate)
	{
		this.accountActDate=accountActDate;
	}
	public String getAccountActDate()
	{
		return accountActDate;
	}
	public void setAccountDeActDate(String accountDeActDate)
	{
		this.accountDeActDate=accountDeActDate;
	}
	public String getAccountDeActDate()
	{
		return accountDeActDate;
	}
	public void setPasswordRecovery(String passwordRecovery)
	{
		this.passwordRecovery=passwordRecovery;
	}
	public String getPasswordRecovery()
	{
		return passwordRecovery;
	}
	//*************************Stores Methods**********************

	public void setMandal(String mandal)
	{
		this.mandal=mandal;
	}
	public String getMandal()
	{
		return mandal;
	}
	public void setStoreCode(String storeCode)
	{
		this.storeCode=storeCode;
	}
	public String getStoreCode()
	{
		return storeCode;
	}
	public void setStoreInCharge(String storeInCharge)
	{
		this.storeInCharge=storeInCharge;
	}
	public String getStoreInCharge()
	{
		return storeInCharge;
	}
	public void setPostheld(String postheld)
	{
		this.postheld=postheld;
	}
	public String getPostheld()
	{
		return postheld;
	}
	public void setDistrict(String district)
	{
		this.district=district;
	}
	public String getDistrict()
	{
		return district;
	}
	public void setSubdivision(String subdivision)
	{
		this.subdivision=subdivision;
	}
	public String getSubdivision()
	{
		return subdivision;
	}
	public void setNoOfMandals(String noOfMandals)
	{
		this.noOfMandals=noOfMandals;
	}
	public String getNoOfMandals()
	{
	   return noOfMandals;
	}
	
	//*********************Mandal Methods*********************
	public void setMandalCode(String mandalCode)
	{
		this.mandalCode=mandalCode;
	}
	public String getMandalCode()
	{
		return mandalCode;
	}
	public void setMandalName(String mandalName)
	{
		this.mandalName=mandalName;
	}
	public String getMandalName()
	{
		return mandalName;
	}
	//*********************Supplier Methods*********************

	public void setSupplierCode(String supplierCode)
	{
		this.supplierCode=supplierCode;
	}
	public String getSupplierCode()
	{
		return supplierCode;
	}
	public void setSupplierName(String supplierName)
	{
		this.supplierName=supplierName;
	}
	public String getSupplierName()
	{
		return supplierName;
	}
	public void setSupplierRegNo(String supplierRegNo)
	{
		this.supplierRegNo=supplierRegNo;
	}
	public String getSupplierRegNo()
	{
		return supplierRegNo;
	}
	//*********************Public Representatives Methods***********************

	public void setPublicRepCode(String publicRepCode)
	{
		this.publicRepCode=publicRepCode;
	}
	public String getPublicRepCode()
	{
		return publicRepCode;
	}
	public void setPublicRepName(String publicRepName)
	{
		this.publicRepName=publicRepName;
	}
	public String getPublicRepName()
	{
		return publicRepName;
	}
	//*********************Public Institutions Methods***********************

	public void setInstituteCode(String instituteCode)
	{
		this.instituteCode=instituteCode;
	}
	public String getInstituteCode()
	{
		return instituteCode;
	}
	public void setInstituteName(String instituteName)
	{
		this.instituteName=instituteName;
	}
	public String getInstituteName()
	{
		return instituteName;
	}
	//*********************Panchayat Methods***********************
	
	public void setPanchRajCode(String panchRajCode)
	{
		this.panchRajCode=panchRajCode;
	}
	public String getPanchRajCode()
	{
		return panchRajCode;
	}
	public void setPanchRajName(String panchRajName)
	{
		this.panchRajName=panchRajName;
	}
	public String getPanchRajName()
	{
		return panchRajName;
	}
	public void setPCode(String pCode)
	{
		this.pCode=pCode;
	}
	public String getPCode()
	{
		return pCode;
	}
	public void setVCode(String vCode)
	{
		this.vCode=vCode;
	}
	public String getVCode()
	{
		return vCode;
	}
	public void setVName(String vName)
	{
		this.vName=vName;
	}
	public String getVName()
	{
		return vName;
	}
	public void setHabName(String habName)
	{
		this.habName=habName;
	}
	public String getHabName()
	{
		return habName;
	}

	public void setPName(String pName)
	{
		this.pName=pName;
	}
	public String getPName()
	{
		return pName;
	}
	public void setPRHabCode(String pRHabCode)
	{
		this.pRHabCode=pRHabCode;
	}
	public String getPRHabCode()
	{
		return pRHabCode;
	}
	public void setInsDisplay(String insDisplay)
	{
		this.insDisplay=insDisplay;
	}
	public String getInsDisplay()
	{
		return insDisplay;
	}
	//*********************************************************************//
	
	public void setHabCode(String habCode)
	{
	this.habCode = habCode;
	}
	public void setJBCode(String jbCode)
	{
	this.jbCode = jbCode;
	}
	public void setInstituteNo(String instituteNo)
	{
	this.instituteNo = instituteNo;
	}
	public void setInstituteCovered(String instituteCovered)
	{
	this.instituteCovered = instituteCovered;
	}
	public void setNearWaterSource(float nearWaterSource)
	{
	this.nearWaterSource = nearWaterSource;
	}
	public void setCensusYear(String censusYear)
	{
	this.censusYear = censusYear;
	}
	public void setHabYear(String habYear)
	{
	this.habYear = habYear;
	}
	public void setCensusPop(int censusPop)
	{
	this.censusPop = censusPop;
	}
	public void setCensusSc(int censusSc)
	{
	this.censusSc = censusSc;
	}
	public void setCensusSt(int censusSt)
	{
	this.censusSt = censusSt;
	}
	public void setPopCovered(int popCovered)
	{
	this.popCovered = popCovered;
	}
	public void setScCovered(int scCovered)
	{
	this.scCovered= scCovered;
	}
	public void setStCovered(int stCovered)
	{
	this.stCovered = stCovered;
	}
	public void setCoveredStatus(String coveredStatus)
	{
	this.coveredStatus = coveredStatus;
	}
	public void setTotalWaterSupply(int totalWaterSupply)
	{
	this.totalWaterSupply = totalWaterSupply;
	}
	public void setTotCattle(int totCattle)
	{
	this.totCattle = totCattle;
	}
	public void setCattleReq(int cattleReq)
	{
	this.cattleReq = cattleReq;
	}
	public void setExistWaterSupply(int existWaterSupply)
	{
	this.existWaterSupply = existWaterSupply;
	}
	public void setExistWaterLevel(int existWaterLevel)
	{		this.existWaterLevel = existWaterLevel;
	}
	
	public void setTotBorewells(int totBorewells)
	{
	this.totBorewells = totBorewells;
	}

	public String getHabCode()
	{
		return habCode;
	}
	public String getJBCode()
	{
		return jbCode;
	}
	public String getInstituteNo()
	{
	return instituteNo;
	}
	public String getInstituteCovered()
	{
	return instituteCovered;
	}
	public float getNearWaterSource()
	{
	return nearWaterSource;
	}
	public int getCensusPop()
	{
	return censusPop;
	}
	public int getCensusSc()
	{
	return censusSc;
	}
	public int getCensusSt()
	{
	return censusSt;
	}
	public int getPopCovered()
	{
	return popCovered;
	}
	public int getScCovered()
	{
	return scCovered;
	}
	public int getStCovered()
	{
	return stCovered;
	}
	public String getCoveredStatus()
	{
	return coveredStatus;
	}
	public int getTotalWaterSupply()
	{
	return totalWaterSupply;
	}
	public int getTotCattle()
	{
	return totCattle;
	}
	public int getCattleReq()
	{
	return cattleReq;
	}
	public int getExistWaterSupply()
	{
	return existWaterSupply;
	}
	public int getExistWaterLevel()
	{
	return existWaterLevel;
	}
	
	public String getCensusYear()
	{
	return censusYear;
	}
	public String getHabYear()
	{
	return habYear;
	}
	public int getTotBorewells()
	{
	return totBorewells;
	}
	public void setBorewellsWorking(int borewellsWorking)
	{
	this.borewellsWorking = borewellsWorking;
	}
	public int getBorewellsWorking()
	{
	return borewellsWorking;
	}
	public void setCpwsScheme(int cpwsScheme)
	{
	this.cpwsScheme = cpwsScheme;
	}
	public int getCpwsScheme()
	{
	return cpwsScheme;
	}
	public void setPwsScheme(int pwsScheme)
	{
	this.pwsScheme = pwsScheme;
	}
	public int getPwsScheme()
	{
	return pwsScheme;
	}
	public void setMpwsScheme(int mpwsScheme)
	{
	this.mpwsScheme = mpwsScheme;
	}
	public int getMpwsScheme()
	{
	return mpwsScheme;
	}
	public void setTotPop(int totPop)
	{
	this.totPop = totPop;
	}
	public int getTotPop()
	{
	return totPop;
	}
	public void setTotPopCvrd(int totPopCvrd)
	{
	this.totPopCvrd = totPopCvrd;
	}
	public int getTotPopCvrd()
	{
	return totPopCvrd;
	}
	public void setFiqty(String fiqty)
	{
	this.fiqty = fiqty;
	}
	public String getFiqty()
	{
	return fiqty;
	}
	public void setBrqty(String brqty)
	{
	this.brqty = brqty;
	}
	public String getBrqty()
	{
	return brqty;
	}
	public void setIrqty(String irqty)
	{
	this.irqty = irqty;
	}
	public String getIrqty()
	{
	return irqty;
	}
	public void setFloatPop(int floatPop)
	{
	this.floatPop = floatPop;
	}
	public int getFloatPop()
	{
	return floatPop;
	}
	public void setFloatReason(String floatReason)
	{
	this.floatReason = floatReason;
	}
	public String getFloatReason()
	{
	return floatReason;
	}
	public void setNetPop(int netPop)
	{
	this.netPop = netPop;
	}
	public int getNetPop()
	{
	return netPop;
	}
	public void setOthers(String others)
	{
	this.others = others;
	}
	public String getOthers()
	{
	return others;
	}
	public void setDrinkingHp(int drinkingHp)
	{
	this.drinkingHp = drinkingHp;
	}
	public int getDrinkingHp()
	{
	return drinkingHp;
	}
	public void setDrinkingShp(int drinkingShp)
	{
	this.drinkingShp = drinkingShp;
	}
	public int getDrinkingShp()
	{
	return drinkingShp;
	}
	public void setDrinkingPsp(int drinkingPsp)
	{
	this.drinkingPsp = drinkingPsp;
	}
	public int getDrinkingPsp()
	{
	return drinkingPsp;
	}
	public void setDrinkingHc(int drinkingHc)
	{
	this.drinkingHc = drinkingHc;
	}
	public int getDrinkingHc()
	{
	return drinkingHc;
	}
	public void setDrinkingOthers(int drinkingOthers)
	{
	this.drinkingOthers = drinkingOthers;
	}
	public int getDrinkingOthers()
	{
	return drinkingOthers;
	}
	public void setDrinkingPcpd(int drinkingPcpd)
	{
	this.drinkingPcpd = drinkingPcpd;
	}
	public int getDrinkingPcpd()
	{
	return drinkingPcpd;
	}
	public void setOtherHp(int otherHp)
	{
	this.otherHp = otherHp;
	}
	public int getOtherHp()
	{
	return otherHp;
	}
	public void setOtherShp(int otherShp)
	{
	this.otherShp = otherShp;
	}
	public int getOtherShp()
	{
	return otherShp;
	}
	public void setOtherOw(int otherOw)
	{
	this.otherOw = otherOw;
	}
	public int getOtherOw()
	{
	return otherOw;
	}
	public void setOtherPonds(int otherPonds)
	{
	this.otherPonds = otherPonds;
	}
	public int getOtherPonds()
	{
	return otherPonds;
	}
	public void setOtherOthers(int otherOthers)
	{
	this.otherOthers = otherOthers;
	}
	public int getOtherOthers()
	{
	return otherOthers;
	}
	public void setOtherPcpd(int otherPcpd)
	{
	this.otherPcpd = otherPcpd;
	}
	public int getOtherPcpd()
	{
	return otherPcpd;
	}	
	//*******************Priotity methods********************
	public void setPriorityCode(String priorityCode)
	{
		this.priorityCode=priorityCode;
	}
	public String getPriorityCode()
	{
		return priorityCode;
	}
	public void setPriorityDesc(String priorityDesc)
	{
		this.priorityDesc=priorityDesc;
	}
	public String getPriorityDesc()
	{
		return priorityDesc;
	}
	public void setPriorityFrom(String priorityFrom)
	{
		this.priorityFrom=priorityFrom;
	}
	public String getPriorityFrom()
	{
		return priorityFrom;
	}
	//****************Work Specialization Methods*************************
	public void setWorkSpecCode(String workSpecCode)
	{
		this.workSpecCode=workSpecCode;
	}
	public String getWorkSpecCode()
	{
		return workSpecCode;
	}
	public void setWorkSpecName(String workSpecName)
	{
		this.workSpecName=workSpecName;
	}
	public String getWorkSpecName()
	{
		return workSpecName;
	}
	public void setDiameter(String diameter)
	{
		this.diameter=diameter;
	}
	public String getDiameter()
	{
		return diameter;
	}
	public void setDepth(int depth)
	{
		this.depth=depth;
	}
	public int getDepth()
	{
		return depth;
	}

	public void setNearWaterGroundSource(float nearWaterGroundSource)
	{
	this.nearWaterGroundSource = nearWaterGroundSource;
	}
	public float getNearWaterGroundSource()
	{
	return nearWaterGroundSource;
	}
	public Collection getAssetHabs() 
	{
		return assetHabs;		
	}
	public void setAssetHabs(Collection assetHabs) 
	{
		this.assetHabs = assetHabs;
	}
	public Collection getAssetHeadWorks() 
	{
		return assetHeadWorks;		
	}
	public void setAssetHeadWorks(Collection assetHeadWorks) 
	{
		this.assetHeadWorks = assetHeadWorks;
	}
	public Collection getAssetPipeLine() 
	{
		return assetPipeLine;		
	}
	public void setAssetPipeLine(Collection assetPipeLine) 
	{
		this.assetPipeLine = assetPipeLine;
	}
	public Collection getAssetReservior() 
	{
		return assetReservior;		
	}
	public void setAssetReservior(Collection assetReservior) 
	{
		this.assetReservior = assetReservior;
	}
	public Collection getAssetSubComponents() 
	{
		return assetSubComponents;		
	}
	public void setAssetSubComponents(Collection assetSubComponents) 
	{
		this.assetSubComponents = assetSubComponents;
	}	
	/**
	 * @return Returns the labCode.
	 */
	public String getLabCode() {
		return labCode;
	}
	/**
	 * @param labCode The labCode to set.
	 */
	public void setLabCode(String labCode) {
		this.labCode = labCode;
	}
	/**
	 * @return Returns the labName.
	 */
	public String getLabName() {
		return labName;
	}
	/**
	 * @param labCode The labCode to set.
	 */
	public void setLabName(String labName) {
		this.labName = labName;
	}
	/**
	 * @return Returns the natureOfTest.
	 */
	
	public void setlabEstablishedYear(String labEstablishedYear)
	{
		this.labEstablishedYear=labEstablishedYear;
	}
	public String getlabEstablishedYear()
	{
		return labEstablishedYear;
	}
	public void setcontactNum(String contactNum)
	{
		this.contactNum=contactNum;
	}
	public String getcontactNum()
	{
		return contactNum;
	}
	public void setlevelCode(String levelCode)
	{
		this.levelCode=levelCode;
	}
	public String getlevelCode()
	{
		return levelCode;
	}
	public int getTotalPop() {
		return totalPop;
	}
	
	public void setTotalPop(int totalPop) {
		this.totalPop = totalPop;
	}
	
	public int getTotalCovered() {
		return totalCovered;
	}
	
	
	/**
	 * @return Returns the totHabs.
	 */
	public int getTotHabs() {
		return totHabs;
	}
	/**
	 * @param totHabs The totHabs to set.
	 */
	public void setTotHabs(int totHabs) {
		this.totHabs = totHabs;
	}
	/**
	 * @return Returns the totPopBenfit.
	 */
	public int getTotPopBenfit() {
		return totPopBenfit;
	}
	/**
	 * @param totPopBenfit The totPopBenfit to set.
	 */
	public void setTotPopBenfit(int totPopBenfit) {
		this.totPopBenfit = totPopBenfit;
	}
	public void setTotalCovered(int totalCovered) {
		this.totalCovered = totalCovered;
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
	}
	
	public Collection getContaminations() {
		return contaminations;
	}
	
	public void setContaminations(Collection contaminations) {
		this.contaminations = contaminations;
	}
	
	/**
	 * @return Returns the component.
	 */
	public String getComponent() {
		return component;
	}
	/**
	 * @param component The component to set.
	 */
	public void setComponent(String component) {
		this.component = component;
	}
//	  Asset HandPump BoreWell Parameter Methods
	/**
	 * @return Returns the plainPop.
	 */
	public int getPlainPop() {
		return plainPop;
	}
	/**
	 * @param plainPop The plainPop to set.
	 */
	public void setPlainPop(int plainPop) {
		this.plainPop = plainPop;
	}
	/**
	 * @return Returns the scPop.
	 */
	public int getScPop() {
		return scPop;
	}
	/**
	 * @param scPop The scPop to set.
	 */
	public void setScPop(int scPop) {
		this.scPop = scPop;
	}
	/**
	 * @return Returns the stPop.
	 */
	public int getStPop() {
		return stPop;
	}
	/**
	 * @param stPop The stPop to set.
	 */
	public void setStPop(int stPop) {
		this.stPop = stPop;
	}
	
	
	/**
	 * @return Returns the codeName.
	 */
	public String getCodeName() {
		return codeName;
	}
	/**
	 * @param codeName The codeName to set.
	 */
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	/**
	 * @return Returns the seasonalBorewell.
	 */
	public String getSeasonalBorewell() {
		return seasonalBorewell;
	}
	/**
	 * @param seasonalBorewell The seasonalBorewell to set.
	 */
	public void setSeasonalBorewell(String seasonalBorewell) {
		this.seasonalBorewell = seasonalBorewell;
	}
	/**
	 * @return Returns the waterLevel.
	 */
	public String getWaterLevel() {
		return waterLevel;
	}
	/**
	 * @param waterLevel The waterLevel to set.
	 */
	public void setWaterLevel(String waterLevel) {
		this.waterLevel = waterLevel;
	}
	/**
	 * @return Returns the habitation.
	 */
	public String getHabitation() {
		return habitation;
	}
	
	/**
	 * @return Returns the covStatus.
	 */
	public String getCovStatus() {
		return covStatus;
	}
	/**
	 * @param covStatus The covStatus to set.
	 */
	public void setCovStatus(String covStatus) {
		this.covStatus = covStatus;
	}
	/**
	 * @return Returns the totPopu.
	 */
	public String getTotPopu() {
		return totPopu;
	}
	/**
	 * @param totPopu The totPopu to set.
	 */
	public void setTotPopu(String totPopu) {
		this.totPopu = totPopu;
	}
	/**
	 * @param habitation The habitation to set.
	 */
	public void setHabitation(String habitation) {
		this.habitation = habitation;
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
	 * @return Returns the measureType.
	 */
	public String getMeasureType() {
		return measureType;
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
	 * @param measureType The measureType to set.
	 */
	public void setMeasureType(String measureType) {
		this.measureType = measureType;
	}
	
	/**
	 * @return Returns the measureValue.
	 */
	public String getMeasureValue() {
		return measureValue;
	}
	/**
	 * @param measureValue The measureValue to set.
	 */
	public void setMeasureValue(String measureValue) {
		this.measureValue = measureValue;
	}
	/**
	 * @return Returns the sourceHabs.
	 */
	public Collection getSourceHabs() {
		return sourceHabs;
	}
	/**
	 * @param sourceHabs The sourceHabs to set.
	 */
	public void setSourceHabs(Collection sourceHabs) {
		this.sourceHabs = sourceHabs;
	}
	/**
	 * @return Returns the avgtime.
	 */
	public String getAvgtime() {
		return avgtime;
	}
	/**
	 * @param avgtime The avgtime to set.
	 */
	public void setAvgtime(String avgtime) {
		this.avgtime = avgtime;
	}
	/**
	 * @return Returns the casing.
	 */
	public String getCasing() {
		return casing;
	}
	/**
	 * @param casing The casing to set.
	 */
	public void setCasing(String casing) {
		this.casing = casing;
	}
	/**
	 * @return Returns the drain.
	 */
	public String getDrain() {
		return drain;
	}
	/**
	 * @param drain The drain to set.
	 */
	public void setDrain(String drain) {
		this.drain = drain;
	}
	/**
	 * @return Returns the drainCondition.
	 */
	public String getDrainCondition() {
		return drainCondition;
	}
	/**
	 * @param drainCondition The drainCondition to set.
	 */
	public void setDrainCondition(String drainCondition) {
		this.drainCondition = drainCondition;
	}
	/**
	 * @return Returns the drainlp.
	 */
	public String getDrainlp() {
		return drainlp;
	}
	/**
	 * @param drainlp The drainlp to set.
	 */
	public void setDrainlp(String drainlp) {
		this.drainlp = drainlp;
	}
	/**
	 * @return Returns the drainsd.
	 */
	public String getDrainsd() {
		return drainsd;
	}
	/**
	 * @param drainsd The drainsd to set.
	 */
	public void setDrainsd(String drainsd) {
		this.drainsd = drainsd;
	}
	/**
	 * @return Returns the dryduring.
	 */
	public String getDryduring() {
		return dryduring;
	}
	/**
	 * @param dryduring The dryduring to set.
	 */
	public void setDryduring(String dryduring) {
		this.dryduring = dryduring;
	}
	/**
	 * @return Returns the genCondition.
	 */
	public String getGenCondition() {
		return genCondition;
	}
	/**
	 * @param genCondition The genCondition to set.
	 */
	public void setGenCondition(String genCondition) {
		this.genCondition = genCondition;
	}
	/**
	 * @return Returns the gino.
	 */
	public String getGino() {
		return gino;
	}
	/**
	 * @param gino The gino to set.
	 */
	public void setGino(String gino) {
		this.gino = gino;
	}
	/**
	 * @return Returns the hygiene.
	 */
	public String getHygiene() {
		return hygiene;
	}
	/**
	 * @param hygiene The hygiene to set.
	 */
	public void setHygiene(String hygiene) {
		this.hygiene = hygiene;
	}
	/**
	 * @return Returns the jbCode.
	 */
	public String getJbCode() {
		return jbCode;
	}
	/**
	 * @param jbCode The jbCode to set.
	 */
	public void setJbCode(String jbCode) {
		this.jbCode = jbCode;
	}
	/**
	 * @return Returns the painted.
	 */
	public String getPainted() {
		return painted;
	}
	/**
	 * @param painted The painted to set.
	 */
	public void setPainted(String painted) {
		this.painted = painted;
	}
	/**
	 * @return Returns the pcond.
	 */
	public String getPcond() {
		return pcond;
	}
	/**
	 * @param pcond The pcond to set.
	 */
	public void setPcond(String pcond) {
		this.pcond = pcond;
	}
	/**
	 * @return Returns the period.
	 */
	public String getPeriod() {
		return period;
	}
	/**
	 * @param period The period to set.
	 */
	public void setPeriod(String period) {
		this.period = period;
	}
	/**
	 * @return Returns the platformCondition.
	 */
	public String getPlatformCondition() {
		return platformCondition;
	}
	/**
	 * @param platformCondition The platformCondition to set.
	 */
	public void setPlatformCondition(String platformCondition) {
		this.platformCondition = platformCondition;
	}
	/**
	 * @return Returns the pyield.
	 */
	public String getPyield() {
		return pyield;
	}
	/**
	 * @param pyield The pyield to set.
	 */
	public void setPyield(String pyield) {
		this.pyield = pyield;
	}
	
	/**
	 * @return Returns the hpCode.
	 */
	public String getHpCode() {
		return hpCode;
	}
	/**
	 * @param hpCode The hpCode to set.
	 */
	public void setHpCode(String hpCode) {
		this.hpCode = hpCode;
	}
	/**
	 * @return Returns the pyieldLocal.
	 */
	public String getPyieldLocal() {
		return pyieldLocal;
	}
	/**
	 * @param pyieldLocal The pyieldLocal to set.
	 */
	public void setPyieldLocal(String pyieldLocal) {
		this.pyieldLocal = pyieldLocal;
	}
	/**
	 * @return Returns the repairs.
	 */
	public String getRepairs() {
		return repairs;
	}
	/**
	 * @param repairs The repairs to set.
	 */
	public void setRepairs(String repairs) {
		this.repairs = repairs;
	}
	/**
	 * @return Returns the schemeCode.
	 */
	public String getSchemeCode() {
		return schemeCode;
	}
	/**
	 * @param schemeCode The schemeCode to set.
	 */
	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}
	/**
	 * @return Returns the serhrs.
	 */
	public String getSerhrs() {
		return serhrs;
	}
	/**
	 * @param serhrs The serhrs to set.
	 */
	public void setSerhrs(String serhrs) {
		this.serhrs = serhrs;
	}
	/**
	 * @return Returns the serno.
	 */
	public String getSerno() {
		return serno;
	}
	/**
	 * @param serno The serno to set.
	 */
	public void setSerno(String serno) {
		this.serno = serno;
	}
	/**
	 * @return Returns the service.
	 */
	public String getService() {
		return service;
	}
	/**
	 * @param service The service to set.
	 */
	
	public void setService(String service) {
		this.service = service;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public String getLowerlimit() {
		return lowerlimit;
	}
	public void setLowerlimit(String lowerlimit) {
		this.lowerlimit = lowerlimit;
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
	public String getUpperlimit() {
		return upperlimit;
	}
	public void setUpperlimit(String upperlimit) {
		this.upperlimit = upperlimit;
	}
   //	  Asset PWS BoreWell Parameter Methods
	/**
	 * @return Returns the hrMs.
	 */
	public String getHrMs() {
		return hrMs;
	}
	/**
	 * @param hrMs The hrMs to set.
	 */
	public void setHrMs(String hrMs) {
		this.hrMs = hrMs;
	}
	/**
	 * @return Returns the hrRun.
	 */
	public String getHrRun() {
		return hrRun;
	}
	/**
	 * @param hrRun The hrRun to set.
	 */
	public void setHrRun(String hrRun) {
		this.hrRun = hrRun;
	}
	/**
	 * @return Returns the hrSin.
	 */
	public String getHrSin() {
		return hrSin;
	}
	/**
	 * @param hrSin The hrSin to set.
	 */
	public void setHrSin(String hrSin) {
		this.hrSin = hrSin;
	}
	/**
	 * @return Returns the phCondition.
	 */
	public String getPhCondition() {
		return phCondition;
	}
	/**
	 * @param phCondition The phCondition to set.
	 */
	public void setPhCondition(String phCondition) {
		this.phCondition = phCondition;
	}
	/**
	 * @return Returns the phSize.
	 */
	public String getPhSize() {
		return phSize;
	}
	/**
	 * @param phSize The phSize to set.
	 */
	public void setPhSize(String phSize) {
		this.phSize = phSize;
	}
	/**
	 * @return Returns the phType.
	 */
	public String getPhType() {
		return phType;
	}
	/**
	 * @param phType The phType to set.
	 */
	public void setPhType(String phType) {
		this.phType = phType;
	}
	/**
	 * @return Returns the popDes.
	 */
	public String getPopDes() {
		return popDes;
	}
	/**
	 * @param popDes The popDes to set.
	 */
	public void setPopDes(String popDes) {
		this.popDes = popDes;
	}
	/**
	 * @return Returns the pumpCapacity.
	 */
	public String getPumpCapacity() {
		return pumpCapacity;
	}
	/**
	 * @param pumpCapacity The pumpCapacity to set.
	 */
	public void setPumpCapacity(String pumpCapacity) {
		this.pumpCapacity = pumpCapacity;
	}
	/**
	 * @return Returns the pumpDutyHead.
	 */
	public String getPumpDutyHead() {
		return pumpDutyHead;
	}
	/**
	 * @param pumpDutyHead The pumpDutyHead to set.
	 */
	public void setPumpDutyHead(String pumpDutyHead) {
		this.pumpDutyHead = pumpDutyHead;
	}
	/**
	 * @return Returns the pumpDutyLpm.
	 */
	public String getPumpDutyLpm() {
		return pumpDutyLpm;
	}
	/**
	 * @param pumpDutyLpm The pumpDutyLpm to set.
	 */
	public void setPumpDutyLpm(String pumpDutyLpm) {
		this.pumpDutyLpm = pumpDutyLpm;
	}
	/**
	 * @return Returns the pumpName.
	 */
	public String getPumpName() {
		return pumpName;
	}
	/**
	 * @param pumpName The pumpName to set.
	 */
	public void setPumpName(String pumpName) {
		this.pumpName = pumpName;
	}
	/**
	 * @return Returns the pumpType.
	 */
	public String getPumpType() {
		return pumpType;
	}
	/**
	 * @param pumpType The pumpType to set.
	 */
	public void setPumpType(String pumpType) {
		this.pumpType = pumpType;
	}
	/**
	 * @return Returns the purYear.
	 */
	public String getPurYear() {
		return purYear;
	}
	/**
	 * @param purYear The purYear to set.
	 */
	public void setPurYear(String purYear) {
		this.purYear = purYear;
	}
	/**
	 * @return Returns the source.
	 */
	public String getSource() {
		return source;
	}
	/**
	 * @param source The source to set.
	 */
	public void setSource(String source) {
		this.source = source;
	}
	/**
	 * @return Returns the sourceCondition.
	 */
	public String getSourceCondition() {
		return sourceCondition;
	}
	/**
	 * @param sourceCondition The sourceCondition to set.
	 */
	public void setSourceCondition(String sourceCondition) {
		this.sourceCondition = sourceCondition;
	}
	/**
	 * @return Returns the sourceDepend.
	 */
	public String getSourceDepend() {
		return sourceDepend;
	}
	/**
	 * @param sourceDepend The sourceDepend to set.
	 */
	public void setSourceDepend(String sourceDepend) {
		this.sourceDepend = sourceDepend;
	}
	/**
	 * @return Returns the sourceDepth.
	 */
	public String getSourceDepth() {
		return sourceDepth;
	}
	/**
	 * @param sourceDepth The sourceDepth to set.
	 */
	public void setSourceDepth(String sourceDepth) {
		this.sourceDepth = sourceDepth;
	}
	/**
	 * @return Returns the sourceDiameter.
	 */
	public String getSourceDiameter() {
		return sourceDiameter;
	}
	/**
	 * @param sourceDiameter The sourceDiameter to set.
	 */
	public void setSourceDiameter(String sourceDiameter) {
		this.sourceDiameter = sourceDiameter;
	}
	/**
	 * @return Returns the sourceNwl.
	 */
	public String getSourceNwl() {
		return sourceNwl;
	}
	/**
	 * @param sourceNwl The sourceNwl to set.
	 */
	public void setSourceNwl(String sourceNwl) {
		this.sourceNwl = sourceNwl;
	}
	/**
	 * @return Returns the sourceQuality.
	 */
	public String getSourceQuality() {
		return sourceQuality;
	}
	/**
	 * @param sourceQuality The sourceQuality to set.
	 */
	public void setSourceQuality(String sourceQuality) {
		this.sourceQuality = sourceQuality;
	}
	/**
	 * @return Returns the sourceSwl.
	 */
	public String getSourceSwl() {
		return sourceSwl;
	}
	/**
	 * @param sourceSwl The sourceSwl to set.
	 */
	public void setSourceSwl(String sourceSwl) {
		this.sourceSwl = sourceSwl;
	}
	/**
	 * @return Returns the sourceYield.
	 */
	public String getSourceYield() {
		return sourceYield;
	}
	/**
	 * @param sourceYield The sourceYield to set.
	 */
	public void setSourceYield(String sourceYield) {
		this.sourceYield = sourceYield;
	}
	/**
	 * @return Returns the staExe.
	 */
	public String getStaExe() {
		return staExe;
	}
	/**
	 * @param staExe The staExe to set.
	 */
	public void setStaExe(String staExe) {
		this.staExe = staExe;
	}
	 
	 
 
   //   Asset PWS GLSR Parameter Methods
	
	
	
	/**
	 * @return Returns the glsrCapacityInLts.
	 */
	public String getGlsrCapacityInLts() {
		return glsrCapacityInLts;
	}
	/**
	 * @param glsrCapacityInLts The glsrCapacityInLts to set.
	 */
	public void setGlsrCapacityInLts(String glsrCapacityInLts) {
		this.glsrCapacityInLts = glsrCapacityInLts;
	}
	 
	/**
	 * @return Returns the glsrCondition.
	 */
	public String getGlsrCondition() {
		return glsrCondition;
	}
	/**
	 * @param glsrCondition The glsrCondition to set.
	 */
	public void setGlsrCondition(String glsrCondition) {
		this.glsrCondition = glsrCondition;
	}
	 
	/**
	 * @return Returns the glsrDraCondition.
	 */
	public String getGlsrDraCondition() {
		return glsrDraCondition;
	}
	/**
	 * @param glsrDraCondition The glsrDraCondition to set.
	 */
	public void setGlsrDraCondition(String glsrDraCondition) {
		this.glsrDraCondition = glsrDraCondition;
	}
	/**
	 * @return Returns the glsrDraConditionName.
	 */
 
	/**
	 * @return Returns the glsrEmptyHrs.
	 */
	public String getGlsrEmptyHrs() {
		return glsrEmptyHrs;
	}
	/**
	 * @param glsrEmptyHrs The glsrEmptyHrs to set.
	 */
	public void setGlsrEmptyHrs(String glsrEmptyHrs) {
		this.glsrEmptyHrs = glsrEmptyHrs;
	}
	 
	/**
	 * @return Returns the glsrFillHrs.
	 */
	public String getGlsrFillHrs() {
		return glsrFillHrs;
	}
	/**
	 * @param glsrFillHrs The glsrFillHrs to set.
	 */
	public void setGlsrFillHrs(String glsrFillHrs) {
		this.glsrFillHrs = glsrFillHrs;
	}
 
	/**
	 * @return Returns the glsrHygiene.
	 */
	public String getGlsrHygiene() {
		return glsrHygiene;
	}
	
	/**
	 * @return Returns the glsrNoOfFillings.
	 */
	public String getGlsrNoOfFillings() {
		return glsrNoOfFillings;
	}
	/**
	 * @param glsrNoOfFillings The glsrNoOfFillings to set.
	 */
	public void setGlsrNoOfFillings(String glsrNoOfFillings) {
		this.glsrNoOfFillings = glsrNoOfFillings;
	}
	/**
	 * @param glsrHygiene The glsrHygiene to set.
	 */
	public void setGlsrHygiene(String glsrHygiene) {
		this.glsrHygiene = glsrHygiene;
	}
	 
	/**
	 * @return Returns the glsrLocation.
	 */
	public String getGlsrLocation() {
		return glsrLocation;
	}
	/**
	 * @param glsrLocation The glsrLocation to set.
	 */
	public void setGlsrLocation(String glsrLocation) {
		this.glsrLocation = glsrLocation;
	}
	 
	/**
	 * @return Returns the glsrMade.
	 */
	public String getGlsrMade() {
		return glsrMade;
	}
	/**
	 * @param glsrMade The glsrMade to set.
	 */
	public void setGlsrMade(String glsrMade) {
		this.glsrMade = glsrMade;
	}
	 
	/**
	 * @return Returns the glsrNo.
	 */
	public String getGlsrNo() {
		return glsrNo;
	}
	/**
	 * @param glsrNo The glsrNo to set.
	 */
	public void setGlsrNo(String glsrNo) {
		this.glsrNo = glsrNo;
	}
	 
	
	/**
	 * @return Returns the pumpCode.
	 */
	public String getPumpCode() {
		return pumpCode;
	}
	/**
	 * @param pumpCode The pumpCode to set.
	 */
	public void setPumpCode(String pumpCode) {
		this.pumpCode = pumpCode;
	}
		
	/**
	 * @return Returns the assetStatusName.
	 */
	public String getAssetStatusName() {
		return assetStatusName;
	}
	/**
	 * @param assetStatusName The assetStatusName to set.
	 */
	public void setAssetStatusName(String assetStatusName) {
		this.assetStatusName = assetStatusName;
	}
	
	// OHSR Parameters

	
	/**
	 * @return Returns the ohrsLts.
	 */
	public String getOhrsLts() {
		return ohrsLts;
	}
	/**
	 * @param ohrsLts The ohrsLts to set.
	 */
	public void setOhrsLts(String ohrsLts) {
		this.ohrsLts = ohrsLts;
	}
	/**
	 * @return Returns the ohsrCapacityLts.
	 */
	public String getOhsrCapacityLts() {
		return ohsrCapacityLts;
	}
	/**
	 * @param ohsrCapacityLts The ohsrCapacityLts to set.
	 */
	public void setOhsrCapacityLts(String ohsrCapacityLts) {
		this.ohsrCapacityLts = ohsrCapacityLts;
	}
	/**
	 * @return Returns the ohsrCond.
	 */
	public String getOhsrCond() {
		return ohsrCond;
	}
	/**
	 * @param ohsrCond The ohsrCond to set.
	 */
	public void setOhsrCond(String ohsrCond) {
		this.ohsrCond = ohsrCond;
	}
	/**
	 * @return Returns the ohsrEmptyHrs.
	 */
	public String getOhsrEmptyHrs() {
		return ohsrEmptyHrs;
	}
	/**
	 * @param ohsrEmptyHrs The ohsrEmptyHrs to set.
	 */
	public void setOhsrEmptyHrs(String ohsrEmptyHrs) {
		this.ohsrEmptyHrs = ohsrEmptyHrs;
	}
	/**
	 * @return Returns the ohsrFen.
	 */
	public String getOhsrFen() {
		return ohsrFen;
	}
	/**
	 * @param ohsrFen The ohsrFen to set.
	 */
	public void setOhsrFen(String ohsrFen) {
		this.ohsrFen = ohsrFen;
	}
	/**
	 * @return Returns the ohsrFillHrs.
	 */
	public String getOhsrFillHrs() {
		return ohsrFillHrs;
	}
	/**
	 * @param ohsrFillHrs The ohsrFillHrs to set.
	 */
	public void setOhsrFillHrs(String ohsrFillHrs) {
		this.ohsrFillHrs = ohsrFillHrs;
	}
	/**
	 * @return Returns the ohsrHt.
	 */
	public String getOhsrHt() {
		return ohsrHt;
	}
	/**
	 * @param ohsrHt The ohsrHt to set.
	 */
	public void setOhsrHt(String ohsrHt) {
		this.ohsrHt = ohsrHt;
	}
	/**
	 * @return Returns the ohsrHygiene.
	 */
	public String getOhsrHygiene() {
		return ohsrHygiene;
	}
	/**
	 * @param ohsrHygiene The ohsrHygiene to set.
	 */
	public void setOhsrHygiene(String ohsrHygiene) {
		this.ohsrHygiene = ohsrHygiene;
	}
	/**
	 * @return Returns the ohsrLocation.
	 */
	public String getOhsrLocation() {
		return ohsrLocation;
	}
	/**
	 * @param ohsrLocation The ohsrLocation to set.
	 */
	public void setOhsrLocation(String ohsrLocation) {
		this.ohsrLocation = ohsrLocation;
	}
	/**
	 * @return Returns the ohsrMade.
	 */
	public String getOhsrMade() {
		return ohsrMade;
	}
	/**
	 * @param ohsrMade The ohsrMade to set.
	 */
	public void setOhsrMade(String ohsrMade) {
		this.ohsrMade = ohsrMade;
	}
	 
 
	 
	 
	 
 //CPWS Parameters
	
	/**
	 * @return Returns the ohbrCapacityLts.
	 */
	public String getOhbrCapacityLts() {
		return ohbrCapacityLts;
	}
	/**
	 * @param ohbrCapacityLts The ohbrCapacityLts to set.
	 */
	public void setOhbrCapacityLts(String ohbrCapacityLts) {
		this.ohbrCapacityLts = ohbrCapacityLts;
	}
 
	/**
	 * @return Returns the ohbrCode.
	 */
	public String getOhbrCode() {
		return ohbrCode;
	}
	/**
	 * @param ohbrCode The ohbrCode to set.
	 */
	public void setOhbrCode(String ohbrCode) {
		this.ohbrCode = ohbrCode;
	}
 
	/**
	 * @return Returns the ohbrEmptyHrs.
	 */
	public String getOhbrEmptyHrs() {
		return ohbrEmptyHrs;
	}
	/**
	 * @param ohbrEmptyHrs The ohbrEmptyHrs to set.
	 */
	public void setOhbrEmptyHrs(String ohbrEmptyHrs) {
		this.ohbrEmptyHrs = ohbrEmptyHrs;
	}
	 
	/**
	 * @return Returns the ohbrFillHrs.
	 */
	public String getOhbrFillHrs() {
		return ohbrFillHrs;
	}
	/**
	 * @param ohbrFillHrs The ohbrFillHrs to set.
	 */
	public void setOhbrFillHrs(String ohbrFillHrs) {
		this.ohbrFillHrs = ohbrFillHrs;
	}
	 
	/**
	 * @return Returns the ohbrLocation.
	 */
	public String getOhbrLocation() {
		return ohbrLocation;
	}
	/**
	 * @param ohbrLocation The ohbrLocation to set.
	 */
	public void setOhbrLocation(String ohbrLocation) {
		this.ohbrLocation = ohbrLocation;
	}
 
	/**
	 * @return Returns the ohbrLwl.
	 */
	public String getOhbrLwl() {
		return ohbrLwl;
	}
	/**
	 * @param ohbrLwl The ohbrLwl to set.
	 */
	public void setOhbrLwl(String ohbrLwl) {
		this.ohbrLwl = ohbrLwl;
	}
	 
	/**
	 * @return Returns the ohbrMwl.
	 */
	public String getOhbrMwl() {
		return ohbrMwl;
	}
	/**
	 * @param ohbrMwl The ohbrMwl to set.
	 */
	public void setOhbrMwl(String ohbrMwl) {
		this.ohbrMwl = ohbrMwl;
	}
	 
	/**
	 * @return Returns the ohbrStages.
	 */
	public String getOhbrStages() {
		return ohbrStages;
	}
	/**
	 * @param ohbrStages The ohbrStages to set.
	 */
	public void setOhbrStages(String ohbrStages) {
		this.ohbrStages = ohbrStages;
	}
	 
	/**
	 * @return Returns the ohsrCode.
	 */
	public String getOhsrCode() {
		return ohsrCode;
	}
	/**
	 * @param ohsrCode The ohsrCode to set.
	 */
	public void setOhsrCode(String ohsrCode) {
		this.ohsrCode = ohsrCode;
	}
	 
	/**
	 * @return Returns the ohsrLwl.
	 */
	public String getOhsrLwl() {
		return ohsrLwl;
	}
	/**
	 * @param ohsrLwl The ohsrLwl to set.
	 */
	public void setOhsrLwl(String ohsrLwl) {
		this.ohsrLwl = ohsrLwl;
	}
	 
	/**
	 * @return Returns the ohsrMwl.
	 */
	public String getOhsrMwl() {
		return ohsrMwl;
	}
	/**
	 * @param ohsrMwl The ohsrMwl to set.
	 */
	public void setOhsrMwl(String ohsrMwl) {
		this.ohsrMwl = ohsrMwl;
	}
	 
	/**
	 * @return Returns the ohsrStages.
	 */
	public String getOhsrStages() {
		return ohsrStages;
	}
	/**
	 * @param ohsrStages The ohsrStages to set.
	 */
	public void setOhsrStages(String ohsrStages) {
		this.ohsrStages = ohsrStages;
	}
	 
	
	 
	public String getNoOfFillings() {
		return noOfFillings;
	}
	public void setNoOfFillings(String noOfFillings) {
		this.noOfFillings = noOfFillings;
	}
	/**
	 * @return Returns the glsrCode.
	 */
	public String getGlsrCode() {
		return glsrCode;
	}
	/**
	 * @param glsrCode The glsrCode to set.
	 */
	public void setGlsrCode(String glsrCode) {
		this.glsrCode = glsrCode;
	}
 
	/**
	 * @return Returns the glsrLwl.
	 */
	public String getGlsrLwl() {
		return glsrLwl;
	}
	/**
	 * @param glsrLwl The glsrLwl to set.
	 */
	public void setGlsrLwl(String glsrLwl) {
		this.glsrLwl = glsrLwl;
	}
	 
	/**
	 * @return Returns the glsrMwl.
	 */
	public String getGlsrMwl() {
		return glsrMwl;
	}
	/**
	 * @param glsrMwl The glsrMwl to set.
	 */
	public void setGlsrMwl(String glsrMwl) {
		this.glsrMwl = glsrMwl;
	}
	 
	/**
	 * @return Returns the glsrStages.
	 */
	public String getGlsrStages() {
		return glsrStages;
	}
	/**
	 * @param glsrStages The glsrStages to set.
	 */
	public void setGlsrStages(String glsrStages) {
		this.glsrStages = glsrStages;
	}
	 
	
	
	/**
	 * @return Returns the glbrCapacityInLts.
	 */
	public String getGlbrCapacityInLts() {
		return glbrCapacityInLts;
	}
	/**
	 * @param glbrCapacityInLts The glbrCapacityInLts to set.
	 */
	public void setGlbrCapacityInLts(String glbrCapacityInLts) {
		this.glbrCapacityInLts = glbrCapacityInLts;
	}
	 
	/**
	 * @return Returns the glbrCode.
	 */
	public String getGlbrCode() {
		return GlbrCode;
	}
	/**
	 * @param glbrCode The glbrCode to set.
	 */
	public void setGlbrCode(String glbrCode) {
		GlbrCode = glbrCode;
	}
	 
	/**
	 * @return Returns the glbrEmptyHrs.
	 */
	public String getGlbrEmptyHrs() {
		return glbrEmptyHrs;
	}
	/**
	 * @param glbrEmptyHrs The glbrEmptyHrs to set.
	 */
	public void setGlbrEmptyHrs(String glbrEmptyHrs) {
		this.glbrEmptyHrs = glbrEmptyHrs;
	}
	 
	 
	/**
	 * @return Returns the glbrFillHrs.
	 */
	public String getGlbrFillHrs() {
		return glbrFillHrs;
	}
	/**
	 * @param glbrFillHrs The glbrFillHrs to set.
	 */
	public void setGlbrFillHrs(String glbrFillHrs) {
		this.glbrFillHrs = glbrFillHrs;
	}
 
	/**
	 * @return Returns the glbrLocation.
	 */
	public String getGlbrLocation() {
		return glbrLocation;
	}
	/**
	 * @param glbrLocation The glbrLocation to set.
	 */
	public void setGlbrLocation(String glbrLocation) {
		this.glbrLocation = glbrLocation;
	}
	 
	/**
	 * @return Returns the glbrLwl.
	 */
	public String getGlbrLwl() {
		return glbrLwl;
	}
	/**
	 * @param glbrLwl The glbrLwl to set.
	 */
	public void setGlbrLwl(String glbrLwl) {
		this.glbrLwl = glbrLwl;
	}
	 
	/**
	 * @return Returns the glbrMwl.
	 */
	public String getGlbrMwl() {
		return glbrMwl;
	}
	/**
	 * @param glbrMwl The glbrMwl to set.
	 */
	public void setGlbrMwl(String glbrMwl) {
		this.glbrMwl = glbrMwl;
	}
	 
	
	
	public String getSchemeCodeName() {
		return schemeCodeName;
	}
	public void setSchemeCodeName(String schemeCodeName) {
		this.schemeCodeName = schemeCodeName;
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
	 * @return Returns the elsrCount.
	 */
	public int getElsrCount() {
		return elsrCount;
	}
	/**
	 * @param elsrCount The elsrCount to set.
	 */
	public void setElsrCount(int elsrCount) {
		this.elsrCount = elsrCount;
	}
	/**
	 * @return Returns the glbrCount.
	 */
	public int getGlbrCount() {
		return glbrCount;
	}
	/**
	 * @param glbrCount The glbrCount to set.
	 */
	public void setGlbrCount(int glbrCount) {
		this.glbrCount = glbrCount;
	}
	/**
	 * @return Returns the glsrCount.
	 */
	public int getGlsrCount() {
		return glsrCount;
	}
	/**
	 * @param glsrCount The glsrCount to set.
	 */
	public void setGlsrCount(int glsrCount) {
		this.glsrCount = glsrCount;
	}
	/**
	 * @return Returns the ohbrCount.
	 */
	public int getOhbrCount() {
		return ohbrCount;
	}
	/**
	 * @param ohbrCount The ohbrCount to set.
	 */
	public void setOhbrCount(int ohbrCount) {
		this.ohbrCount = ohbrCount;
	}
	/**
	 * @return Returns the ohsrCount.
	 */
	public int getOhsrCount() {
		return ohsrCount;
	}
	/**
	 * @param ohsrCount The ohsrCount to set.
	 */
	public void setOhsrCount(int ohsrCount) {
		this.ohsrCount = ohsrCount;
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
	 * @return Returns the pondCode.
	 */
	public String getPondCode() {
		return pondCode;
	}
	/**
	 * @param pondCode The pondCode to set.
	 */
	public void setPondCode(String pondCode) {
		this.pondCode = pondCode;
	}
	/**
	 * @return Returns the pondName.
	 */
	public String getPondName() {
		return pondName;
	}
	/**
	 * @param pondName The pondName to set.
	 */
	public void setPondName(String pondName) {
		this.pondName = pondName;
	}
	/**
	 * @return Returns the pondServiceMonths.
	 */
	public String getPondServiceMonths() {
		return pondServiceMonths;
	}
	/**
	 * @param pondServiceMonths The pondServiceMonths to set.
	 */
	public void setPondServiceMonths(String pondServiceMonths) {
		this.pondServiceMonths = pondServiceMonths;
	}
	/**
	 * @return Returns the pondSize.
	 */
	public String getPondSize() {
		return pondSize;
	}
	/**
	 * @param pondSize The pondSize to set.
	 */
	public void setPondSize(String pondSize) {
		this.pondSize = pondSize;
	}
	/**
	 * @return Returns the pondVolume.
	 */
	public String getPondVolume() {
		return pondVolume;
	}
	/**
	 * @param pondVolume The pondVolume to set.
	 */
	public void setPondVolume(String pondVolume) {
		this.pondVolume = pondVolume;
	}
	
	
	/**
	 * @return Returns the owCode.
	 */
	public String getOwCode() {
		return owCode;
	}
	/**
	 * @param owCode The owCode to set.
	 */
	public void setOwCode(String owCode) {
		this.owCode = owCode;
	}
	/**
	 * @return Returns the owDepth.
	 */
	public String getOwDepth() {
		return owDepth;
	}
	/**
	 * @param owDepth The owDepth to set.
	 */
	public void setOwDepth(String owDepth) {
		this.owDepth = owDepth;
	}
	/**
	 * @return Returns the owDiameter.
	 */
	public String getOwDiameter() {
		return owDiameter;
	}
	/**
	 * @param owDiameter The owDiameter to set.
	 */
	public void setOwDiameter(String owDiameter) {
		this.owDiameter = owDiameter;
	}
	/**
	 * @return Returns the owMaxwl.
	 */
	public String getOwMaxwl() {
		return owMaxwl;
	}
	/**
	 * @param owMaxwl The owMaxwl to set.
	 */
	public void setOwMaxwl(String owMaxwl) {
		this.owMaxwl = owMaxwl;
	}
	/**
	 * @return Returns the owMinwl.
	 */
	public String getOwMinwl() {
		return owMinwl;
	}
	/**
	 * @param owMinwl The owMinwl to set.
	 */
	public void setOwMinwl(String owMinwl) {
		this.owMinwl = owMinwl;
	}
	
	/**
	 * @return Returns the percent.
	 */
	public String getPercent() {
		return Percent;
	}
	/**
	 * @param percent The percent to set.
	 */
	public void setPercent(String percent) {
		Percent = percent;
	}
	
	//Cistern Methods
	
	
	/**
	 * @return Returns the cisCapLts.
	 */
	public String getCisCapLts() {
		return cisCapLts;
	}
	/**
	 * @param cisCapLts The cisCapLts to set.
	 */
	public void setCisCapLts(String cisCapLts) {
		this.cisCapLts = cisCapLts;
	}
	/**
	 * @return Returns the cisCond.
	 */
	public String getCisCond() {
		return cisCond;
	}
	/**
	 * @param cisCond The cisCond to set.
	 */
	public void setCisCond(String cisCond) {
		this.cisCond = cisCond;
	}
	/**
	 * @return Returns the cisDrain.
	 */
	public String getCisDrain() {
		return cisDrain;
	}
	/**
	 * @param cisDrain The cisDrain to set.
	 */
	public void setCisDrain(String cisDrain) {
		this.cisDrain = cisDrain;
	}
	/**
	 * @return Returns the cisHr.
	 */
	public String getCisHr() {
		return cisHr;
	}
	/**
	 * @param cisHr The cisHr to set.
	 */
	public void setCisHr(String cisHr) {
		this.cisHr = cisHr;
	}
	/**
	 * @return Returns the cisLocation.
	 */
	public String getCisLocation() {
		return cisLocation;
	}
	/**
	 * @param cisLocation The cisLocation to set.
	 */
	public void setCisLocation(String cisLocation) {
		this.cisLocation = cisLocation;
	}
	/**
	 * @return Returns the cisNo.
	 */
	public String getCisNo() {
		return cisNo;
	}
	
	/**
	 * @return Returns the cisCode.
	 */
	public String getCisCode() {
		return cisCode;
	}
	/**
	 * @param cisCode The cisCode to set.
	 */
	public void setCisCode(String cisCode) {
		this.cisCode = cisCode;
	}
	/**
	 * @param cisNo The cisNo to set.
	 */
	public void setCisNo(String cisNo) {
		this.cisNo = cisNo;
	}
	/**
	 * @return Returns the cisPf.
	 */
	public String getCisPf() {
		return cisPf;
	}
	/**
	 * @param cisPf The cisPf to set.
	 */
	public void setCisPf(String cisPf) {
		this.cisPf = cisPf;
	}
	/**
	 * @return Returns the cisPfCond.
	 */
	public String getCisPfCond() {
		return cisPfCond;
	}
	/**
	 * @param cisPfCond The cisPfCond to set.
	 */
	public void setCisPfCond(String cisPfCond) {
		this.cisPfCond = cisPfCond;
	}
	/**
	 * @return Returns the cisTap.
	 */
	public String getCisTap() {
		return cisTap;
	}
	/**
	 * @param cisTap The cisTap to set.
	 */
	public void setCisTap(String cisTap) {
		this.cisTap = cisTap;
	}
	/**
	 * @return Returns the cisTapCond.
	 */
	public String getCisTapCond() {
		return cisTapCond;
	}
	/**
	 * @param cisTapCond The cisTapCond to set.
	 */
	public void setCisTapCond(String cisTapCond) {
		this.cisTapCond = cisTapCond;
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
	public String getDisLength() {
		return disLength;
	}
	public void setDisLength(String disLength) {
		this.disLength = disLength;
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
	 * @return Returns the noOfPipes.
	 */
	public String getNoOfPipes() {
		return noOfPipes;
	}
	/**
	 * @param NoOfPipes The NoOfPipes to set.
	 */
	public void setNoOfPipes(String noOfPipes) {
		this.noOfPipes = noOfPipes;
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
	public String getIfNss() {
		return ifNss;
	}
	public void setIfNss(String ifNss) {
		this.ifNss = ifNss;
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
	public String getPmpCode() {
		return pmpCode;
	}
	public void setPmpCode(String pmpCode) {
		this.pmpCode = pmpCode;
	}
	public String getPumpNo() {
		return pumpNo;
	}
	public void setPumpNo(String pumpNo) {
		this.pumpNo = pumpNo;
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
	public String getStandByPumpCapacity() {
		return standByPumpCapacity;
	}
	public void setStandByPumpCapacity(String standByPumpCapacity) {
		this.standByPumpCapacity = standByPumpCapacity;
	}
	public String getStandByPumpNo() {
		return standByPumpNo;
	}
	public void setStandByPumpNo(String standByPumpNo) {
		this.standByPumpNo = standByPumpNo;
	}
	
	
	
	/**
	 * @return Returns the number.
	 */
	public String getNumber() {
		return number;
	}
	/**
	 * @param number The number to set.
	 */
	public void setNumber(String number) {
		this.number = number;
	}
	
	/**
	 * @return Returns the stand_by_numbers.
	 */
	public String getStand_by_numbers() {
		return stand_by_numbers;
	}
	/**
	 * @param stand_by_numbers The stand_by_numbers to set.
	 */
	public void setStand_by_numbers(String stand_by_numbers) {
		this.stand_by_numbers = stand_by_numbers;
	}
	/**
	 * @return Returns the stand_by_total_hp.
	 */
	public String getStand_by_total_hp() {
		return stand_by_total_hp;
	}
	/**
	 * @param stand_by_total_hp The stand_by_total_hp to set.
	 */
	public void setStand_by_total_hp(String stand_by_total_hp) {
		this.stand_by_total_hp = stand_by_total_hp;
	}
	/**
	 * @return Returns the total_hp.
	 */
	public String getTotal_hp() {
		return total_hp;
	}
	/**
	 * @param total_hp The total_hp to set.
	 */
	public void setTotal_hp(String total_hp) {
		this.total_hp = total_hp;
	}
	public String getPowerConn() {
		return powerConn;
	}
	public void setPowerConn(String powerConn) {
		this.powerConn = powerConn;
	}
	public String getPowerHours() {
		return powerHours;
	}
	public void setPowerHours(String powerHours) {
		this.powerHours = powerHours;
	}
	public String getSsCapacityDays() {
		return ssCapacityDays;
	}
	public void setSsCapacityDays(String ssCapacityDays) {
		this.ssCapacityDays = ssCapacityDays;
	}
	public String getSsCapacityMcum() {
		return ssCapacityMcum;
	}
	public void setSsCapacityMcum(String ssCapacityMcum) {
		this.ssCapacityMcum = ssCapacityMcum;
	}
	public String getSsSize() {
		return ssSize;
	}
	public void setSsSize(String ssSize) {
		this.ssSize = ssSize;
	}
	
	public float getSsDepth() {
		return ssDepth;
	}
	
	public void setSsDepth(float ssDepth) {
		this.ssDepth = ssDepth;
	}
	public String getSsTankAdeq() {
		return ssTankAdeq;
	}
	public void setSsTankAdeq(String ssTankAdeq) {
		this.ssTankAdeq = ssTankAdeq;
	}
	public String getSsTankCode() {
		return ssTankCode;
	}
	public void setSsTankCode(String ssTankCode) {
		this.ssTankCode = ssTankCode;
	}
	public String getSsTankLocation() {
		return ssTankLocation;
	}
	public void setSsTankLocation(String ssTankLocation) {
		this.ssTankLocation = ssTankLocation;
	}
	public String getSsTankYield() {
		return ssTankYield;
	}
	public void setSsTankYield(String ssTankYield) {
		this.ssTankYield = ssTankYield;
	}
	public String getSsTankYieldDate() {
		return ssTankYieldDate;
	}
	public void setSsTankYieldDate(String ssTankYieldDate) {
		this.ssTankYieldDate = ssTankYieldDate;
	}
	
	public String getWtpBackwashFreq() {
		return wtpBackwashFreq;
	}
	public void setWtpBackwashFreq(String wtpBackwashFreq) {
		this.wtpBackwashFreq = wtpBackwashFreq;
	}
	public String getWtpCapacityUse() {
		return wtpCapacityUse;
	}
	public void setWtpCapacityUse(String wtpCapacityUse) {
		this.wtpCapacityUse = wtpCapacityUse;
	}
	public String getWtpCode() {
		return wtpCode;
	}
	public void setWtpCode(String wtpCode) {
		this.wtpCode = wtpCode;
	}
	public String getWtpExtentionScope() {
		return wtpExtentionScope;
	}
	public void setWtpExtentionScope(String wtpExtentionScope) {
		this.wtpExtentionScope = wtpExtentionScope;
	}
	
	public String getAirValveNo() {
		return airValveNo;
	}
	
	public void setAirValveNo(String airValveNo) {
		this.airValveNo = airValveNo;
	}
	
	public String getAirValvePitCondBad() {
		return airValvePitCondBad;
	}
	
	public void setAirValvePitCondBad(String airValvePitCondBad) {
		this.airValvePitCondBad = airValvePitCondBad;
	}
	
	public String getAirValvePitCondGood() {
		return airValvePitCondGood;
	}
	
	public void setAirValvePitCondGood(String airValvePitCondGood) {
		this.airValvePitCondGood = airValvePitCondGood;
	}
	
	public String getAirValvePitCondNrc() {
		return airValvePitCondNrc;
	}
	
	public void setAirValvePitCondNrc(String airValvePitCondNrc) {
		this.airValvePitCondNrc = airValvePitCondNrc;
	}
	
	public String getAirValvePitCover() {
		return airValvePitCover;
	}
	
	public void setAirValvePitCover(String airValvePitCover) {
		this.airValvePitCover = airValvePitCover;
	}
	
	public String getAirValvePitCoveredNo() {
		return airValvePitCoveredNo;
	}
	
	public void setAirValvePitCoveredNo(String airValvePitCoveredNo) {
		this.airValvePitCoveredNo = airValvePitCoveredNo;
	}
	
	public String getAirValvePitNo() {
		return airValvePitNo;
	}
	
	public void setAirValvePitNo(String airValvePitNo) {
		this.airValvePitNo = airValvePitNo;
	}
	
	public String getAsssetCode() {
		return asssetCode;
	}
	
	public void setAsssetCode(String asssetCode) {
		this.asssetCode = asssetCode;
	}
	
	public String getAvgTime() {
		return avgTime;
	}
	
	public void setAvgTime(String avgTime) {
		this.avgTime = avgTime;
	}
	
	public String getCond() {
		return Cond;
	}
	
	public void setCond(String cond) {
		Cond = cond;
	}
	
	public String getDrainLp() {
		return drainLp;
	}
	
	public void setDrainLp(String drainLp) {
		this.drainLp = drainLp;
	}
	
	public String getDrainSd() {
		return drainSd;
	}
	
	public void setDrainSd(String drainSd) {
		this.drainSd = drainSd;
	}
	
	public String getDrillYear() {
		return drillYear;
	}
	
	public void setDrillYear(String drillYear) {
		this.drillYear = drillYear;
	}
	
	public String getDryDuring() {
		return dryDuring;
	}
	
	public void setDryDuring(String dryDuring) {
		this.dryDuring = dryDuring;
	}

	public String getFailFreq() {
		return failFreq;
	}
	
	public void setFailFreq(String failFreq) {
		this.failFreq = failFreq;
	}
	
	public String getFailReason() {
		return failReason;
	}
	
	public void setFailReason(String failReason) {
		this.failReason = failReason;
	}
	/**
	 * @return Returns the failType.
	 */
	public String getFailType() {
		return failType;
	}
	/**
	 * @param failType The failType to set.
	 */
	public void setFailType(String failType) {
		this.failType = failType;
	}
	/**
	 * @return Returns the giNo.
	 */
	public String getGiNo() {
		return giNo;
	}
	/**
	 * @param giNo The giNo to set.
	 */
	public void setGiNo(String giNo) {
		this.giNo = giNo;
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
	 * @return Returns the metType.
	 */
	public String getMetType() {
		return metType;
	}
	/**
	 * @param metType The metType to set.
	 */
	public void setMetType(String metType) {
		this.metType = metType;
	}
	/**
	 * @return Returns the platFormCondition.
	 */
	public String getPlatFormCondition() {
		return platFormCondition;
	}
	/**
	 * @param platFormCondition The platFormCondition to set.
	 */
	public void setPlatFormCondition(String platFormCondition) {
		this.platFormCondition = platFormCondition;
	}
	/**
	 * @return Returns the pumpingMainCode.
	 */
	public String getPumpingMainCode() {
		return pumpingMainCode;
	}
	/**
	 * @param pumpingMainCode The pumpingMainCode to set.
	 */
	public void setPumpingMainCode(String pumpingMainCode) {
		this.pumpingMainCode = pumpingMainCode;
	}
	/**
	 * @return Returns the reflexValve.
	 */
	public String getReflexValve() {
		return reflexValve;
	}
	/**
	 * @param reflexValve The reflexValve to set.
	 */
	public void setReflexValve(String reflexValve) {
		this.reflexValve = reflexValve;
	}
	/**
	 * @return Returns the rfValvePitCondBad.
	 */
	public String getRfValvePitCondBad() {
		return rfValvePitCondBad;
	}
	/**
	 * @param rfValvePitCondBad The rfValvePitCondBad to set.
	 */
	public void setRfValvePitCondBad(String rfValvePitCondBad) {
		this.rfValvePitCondBad = rfValvePitCondBad;
	}
	/**
	 * @return Returns the rfValvePitCondGood.
	 */
	public String getRfValvePitCondGood() {
		return rfValvePitCondGood;
	}
	/**
	 * @param rfValvePitCondGood The rfValvePitCondGood to set.
	 */
	public void setRfValvePitCondGood(String rfValvePitCondGood) {
		this.rfValvePitCondGood = rfValvePitCondGood;
	}
	/**
	 * @return Returns the rfValvePitCondNrc.
	 */
	public String getRfValvePitCondNrc() {
		return rfValvePitCondNrc;
	}
	/**
	 * @param rfValvePitCondNrc The rfValvePitCondNrc to set.
	 */
	public void setRfValvePitCondNrc(String rfValvePitCondNrc) {
		this.rfValvePitCondNrc = rfValvePitCondNrc;
	}
	/**
	 * @return Returns the rfValvePitCover.
	 */
	public String getRfValvePitCover() {
		return rfValvePitCover;
	}
	/**
	 * @param rfValvePitCover The rfValvePitCover to set.
	 */
	public void setRfValvePitCover(String rfValvePitCover) {
		this.rfValvePitCover = rfValvePitCover;
	}
	/**
	 * @return Returns the rfValvePitCoveredNo.
	 */
	public String getRfValvePitCoveredNo() {
		return rfValvePitCoveredNo;
	}
	/**
	 * @param rfValvePitCoveredNo The rfValvePitCoveredNo to set.
	 */
	public void setRfValvePitCoveredNo(String rfValvePitCoveredNo) {
		this.rfValvePitCoveredNo = rfValvePitCoveredNo;
	}
	/**
	 * @return Returns the rfValvePitNo.
	 */
	public String getRfValvePitNo() {
		return rfValvePitNo;
	}
	/**
	 * @param rfValvePitNo The rfValvePitNo to set.
	 */
	public void setRfValvePitNo(String rfValvePitNo) {
		this.rfValvePitNo = rfValvePitNo;
	}
	/**
	 * @return Returns the scoureValve.
	 */
	public String getScoureValve() {
		return scoureValve;
	}
	/**
	 * @param scoureValve The scoureValve to set.
	 */
	public void setScoureValve(String scoureValve) {
		this.scoureValve = scoureValve;
	}
	/**
	 * @return Returns the serHrs.
	 */
	public String getSerHrs() {
		return serHrs;
	}
	/**
	 * @param serHrs The serHrs to set.
	 */
	public void setSerHrs(String serHrs) {
		this.serHrs = serHrs;
	}
	/**
	 * @return Returns the serNo.
	 */
	public String getSerNo() {
		return serNo;
	}
	/**
	 * @param serNo The serNo to set.
	 */
	public void setSerNo(String serNo) {
		this.serNo = serNo;
	}
	/**
	 * @return Returns the sluiceValve.
	 */
	public String getSluiceValve() {
		return sluiceValve;
	}
	/**
	 * @param sluiceValve The sluiceValve to set.
	 */
	public void setSluiceValve(String sluiceValve) {
		this.sluiceValve = sluiceValve;
	}
	/**
	 * @return Returns the slValvePitCondBad.
	 */
	public String getSlValvePitCondBad() {
		return slValvePitCondBad;
	}
	/**
	 * @param slValvePitCondBad The slValvePitCondBad to set.
	 */
	public void setSlValvePitCondBad(String slValvePitCondBad) {
		this.slValvePitCondBad = slValvePitCondBad;
	}
	/**
	 * @return Returns the slValvePitCondGood.
	 */
	public String getSlValvePitCondGood() {
		return slValvePitCondGood;
	}
	/**
	 * @param slValvePitCondGood The slValvePitCondGood to set.
	 */
	public void setSlValvePitCondGood(String slValvePitCondGood) {
		this.slValvePitCondGood = slValvePitCondGood;
	}
	/**
	 * @return Returns the slValvePitCondNrc.
	 */
	public String getSlValvePitCondNrc() {
		return slValvePitCondNrc;
	}
	/**
	 * @param slValvePitCondNrc The slValvePitCondNrc to set.
	 */
	public void setSlValvePitCondNrc(String slValvePitCondNrc) {
		this.slValvePitCondNrc = slValvePitCondNrc;
	}
	/**
	 * @return Returns the slValvePitCover.
	 */
	public String getSlValvePitCover() {
		return slValvePitCover;
	}
	/**
	 * @param slValvePitCover The slValvePitCover to set.
	 */
	public void setSlValvePitCover(String slValvePitCover) {
		this.slValvePitCover = slValvePitCover;
	}
	/**
	 * @return Returns the slValvePitCoveredNo.
	 */
	public String getSlValvePitCoveredNo() {
		return slValvePitCoveredNo;
	}
	/**
	 * @param slValvePitCoveredNo The slValvePitCoveredNo to set.
	 */
	public void setSlValvePitCoveredNo(String slValvePitCoveredNo) {
		this.slValvePitCoveredNo = slValvePitCoveredNo;
	}
	/**
	 * @return Returns the slValvePitNo.
	 */
	public String getSlValvePitNo() {
		return slValvePitNo;
	}
	/**
	 * @param slValvePitNo The slValvePitNo to set.
	 */
	public void setSlValvePitNo(String slValvePitNo) {
		this.slValvePitNo = slValvePitNo;
	}
	/**
	 * @return Returns the srValvePitCondBad.
	 */
	public String getSrValvePitCondBad() {
		return srValvePitCondBad;
	}
	/**
	 * @param srValvePitCondBad The srValvePitCondBad to set.
	 */
	public void setSrValvePitCondBad(String srValvePitCondBad) {
		this.srValvePitCondBad = srValvePitCondBad;
	}
	/**
	 * @return Returns the srValvePitCondGood.
	 */
	public String getSrValvePitCondGood() {
		return srValvePitCondGood;
	}
	/**
	 * @param srValvePitCondGood The srValvePitCondGood to set.
	 */
	public void setSrValvePitCondGood(String srValvePitCondGood) {
		this.srValvePitCondGood = srValvePitCondGood;
	}
	/**
	 * @return Returns the srValvePitCondNrc.
	 */
	public String getSrValvePitCondNrc() {
		return srValvePitCondNrc;
	}
	/**
	 * @param srValvePitCondNrc The srValvePitCondNrc to set.
	 */
	public void setSrValvePitCondNrc(String srValvePitCondNrc) {
		this.srValvePitCondNrc = srValvePitCondNrc;
	}
	/**
	 * @return Returns the srValvePitCover.
	 */
	public String getSrValvePitCover() {
		return srValvePitCover;
	}
	/**
	 * @param srValvePitCover The srValvePitCover to set.
	 */
	public void setSrValvePitCover(String srValvePitCover) {
		this.srValvePitCover = srValvePitCover;
	}
	/**
	 * @return Returns the srValvePitCoveredNo.
	 */
	public String getSrValvePitCoveredNo() {
		return srValvePitCoveredNo;
	}
	/**
	 * @param srValvePitCoveredNo The srValvePitCoveredNo to set.
	 */
	public void setSrValvePitCoveredNo(String srValvePitCoveredNo) {
		this.srValvePitCoveredNo = srValvePitCoveredNo;
	}
	/**
	 * @return Returns the srValvePitNo.
	 */
	public String getSrValvePitNo() {
		return srValvePitNo;
	}
	/**
	 * @param srValvePitNo The srValvePitNo to set.
	 */
	public void setSrValvePitNo(String srValvePitNo) {
		this.srValvePitNo = srValvePitNo;
	}
	/**
	 * @return Returns the staticWl.
	 */
	public String getStaticWl() {
		return staticWl;
	}
	/**
	 * @param staticWl The staticWl to set.
	 */
	public void setStaticWl(String staticWl) {
		this.staticWl = staticWl;
	}
	/**
	 * @return Returns the summerWl.
	 */
	public String getSummerWl() {
		return summerWl;
	}
	/**
	 * @param summerWl The summerWl to set.
	 */
	public void setSummerWl(String summerWl) {
		this.summerWl = summerWl;
	}
	/**
	 * @return Returns the wtpChkFilter.
	 */
	public String getWtpChkFilter() {
		return wtpChkFilter;
	}
	/**
	 * @param wtpChkFilter The wtpChkFilter to set.
	 */
	public void setWtpChkFilter(String wtpChkFilter) {
		this.wtpChkFilter = wtpChkFilter;
	}
	
	/**
	 * @return Returns the wtpLocation.
	 */
	public String getWtpLocation() {
		return wtpLocation;
	}
	/**
	 * @param wtpLocation The wtpLocation to set.
	 */
	public void setWtpLocation(String wtpLocation) {
		this.wtpLocation = wtpLocation;
	}
	/**
	 * @return Returns the wtpNoOfHoursOfUsage.
	 */
	public float getWtpNoOfHoursOfUsage() {
		return wtpNoOfHoursOfUsage;
	}
	/**
	 * @param wtpNoOfHoursOfUsage The wtpNoOfHoursOfUsage to set.
	 */
	public void setWtpNoOfHoursOfUsage(float wtpNoOfHoursOfUsage) {
		this.wtpNoOfHoursOfUsage = wtpNoOfHoursOfUsage;
	}
	/**
	 * @return Returns the wtpRateOfFiltration.
	 */
	
	/**
	 * @return Returns the wtpFreqSandScrap.
	 */
	public int getWtpFreqSandScrap() {
		return wtpFreqSandScrap;
	}
	/**
	 * @param wtpFreqSandScrap The wtpFreqSandScrap to set.
	 */
	public void setWtpFreqSandScrap(int wtpFreqSandScrap) {
		this.wtpFreqSandScrap = wtpFreqSandScrap;
	}
	/**
	 * @return Returns the yieldLocal.
	 */
	public String getYieldLocal() {
		return yieldLocal;
	}
	/**
	 * @param yieldLocal The yieldLocal to set.
	 */
	public void setYieldLocal(String yieldLocal) {
		this.yieldLocal = yieldLocal;
	}
	/**
	 * @return Returns the disMaterialCode.
	 */
	public String getDisMaterialCode() {
		return disMaterialCode;
	}
	/**
	 * @param lengths The lengths to set.
	 */
	public void setLengths(String lengths) {
		this.lengths = lengths;
	}
	public String getWtpMld() {
		return wtpMld;
	}
	public void setWtpMld(String wtpMld) {
		this.wtpMld = wtpMld;
	}
	public String getWtpPerformance() {
		return wtpPerformance;
	}
	public void setWtpPerformance(String wtpPerformance) {
		this.wtpPerformance = wtpPerformance;
	}
	public String getWtpSize() {
		return wtpSize;
	}
	public void setWtpSize(String wtpSize) {
		this.wtpSize = wtpSize;
	}
	public String getWtpType() {
		return wtpType;
	}
	public void setWtpType(String wtpType) {
		this.wtpType = wtpType;
	}
	public String getWtpUnits() {
		return wtpUnits;
	}
	public void setWtpUnits(String wtpUnits) {
		this.wtpUnits = wtpUnits;
	}
	public String getWtpUnitsStandby() {
		return wtpUnitsStandby;
	}
	public void setWtpUnitsStandby(String wtpUnitsStandby) {
		this.wtpUnitsStandby = wtpUnitsStandby;
	}	
	
	public String getSumpCapacity() {
		return sumpCapacity;
	}
	public void setSumpCapacity(String sumpCapacity) {
		this.sumpCapacity = sumpCapacity;
	}
	public String getSumpCode() {
		return sumpCode;
	}
	public void setSumpCode(String sumpCode) {
		this.sumpCode = sumpCode;
	}
	public String getSumpCondition() {
		return sumpCondition;
	}
	public void setSumpCondition(String sumpCondition) {
		this.sumpCondition = sumpCondition;
	}
	/**
	 * @return Returns the sumpDepth.
	 */
	public float getSumpDepth() {
		return sumpDepth;
	}
	/**
	 * @param sumpDepth The sumpDepth to set.
	 */
	public void setSumpDepth(float sumpDepth) {
		this.sumpDepth = sumpDepth;
	}
	/**
	 * @return Returns the sumpDiameter.
	 */
	public float getSumpDiameter() {
		return sumpDiameter;
	}
	/**
	 * @param sumpDiameter The sumpDiameter to set.
	 */
	public void setSumpDiameter(float sumpDiameter) {
		this.sumpDiameter = sumpDiameter;
	}
	/**
	 * @return Returns the sumpLocation.
	 */
	public String getSumpLocation() {
		return sumpLocation;
	}
	/**
	 * @param sumpLocation The sumpLocation to set.
	 */
	public void setSumpLocation(String sumpLocation) {
		this.sumpLocation = sumpLocation;
	}
	/**
	 * @return Returns the sumpMadeOf.
	 */
	public String getSumpMadeOf() {
		return sumpMadeOf;
	}
	/**
	 * @param sumpMadeOf The sumpMadeOf to set.
	 */
	public void setSumpMadeOf(String sumpMadeOf) {
		this.sumpMadeOf = sumpMadeOf;
	}
	public String getSumpEmptyHr() {
		return sumpEmptyHr;
	}
	public void setSumpEmptyHr(String sumpEmptyHr) {
		this.sumpEmptyHr = sumpEmptyHr;
	}
	public String getSumpFillHr() {
		return sumpFillHr;
	}
	public void setSumpFillHr(String sumpFillHr) {
		this.sumpFillHr = sumpFillHr;
	}
	public String getSumpType() {
		return sumpType;
	}
	public void setSumpType(String sumpType) {
		this.sumpType = sumpType;
	}
	
	
	public String getCollectionWellCode() {
		return collectionWellCode;
	}
	public void setCollectionWellCode(String collectionWellCode) {
		this.collectionWellCode = collectionWellCode;
	}
	public String getRwDepth() {
		return rwDepth;
	}
	public void setRwDepth(String rwDepth) {
		this.rwDepth = rwDepth;
	}
	public String getRwDiameter() {
		return rwDiameter;
	}
	public void setRwDiameter(String rwDiameter) {
		this.rwDiameter = rwDiameter;
	}
	public String getRwTypeOfFlooring() {
		return rwTypeOfFlooring;
	}
	public void setRwTypeOfFlooring(String rwTypeOfFlooring) {
		this.rwTypeOfFlooring = rwTypeOfFlooring;
	}
	
	/**
	 * @return Returns the rwCapacity.
	 */
	
	/**
	 * @return Returns the rwLocation.
	 */
	public String getRwLocation() {
		return rwLocation;
	}
	/**
	 * @param rwLocation The rwLocation to set.
	 */
	public void setRwLocation(String rwLocation) {
		this.rwLocation = rwLocation;
	}
	public String getBridgeCode() {
		return bridgeCode;
	}
	public void setBridgeCode(String bridgeCode) {
		this.bridgeCode = bridgeCode;
	}
	public String getBridgeLength() {
		return bridgeLength;
	}
	public void setBridgeLength(String bridgeLength) {
		this.bridgeLength = bridgeLength;
	}
	public String getBridgeSpanLength() {
		return bridgeSpanLength;
	}
	public void setBridgeSpanLength(String bridgeSpanLength) {
		this.bridgeSpanLength = bridgeSpanLength;
	}
	public String getBridgeType() {
		return bridgeType;
	}
	public void setBridgeType(String bridgeType) {
		this.bridgeType = bridgeType;
	}
	public String getBridgeWalkwaywidth() {
		return bridgeWalkwaywidth;
	}
	public void setBridgeWalkwaywidth(String bridgeWalkwaywidth) {
		this.bridgeWalkwaywidth = bridgeWalkwaywidth;
	}
	public String getBridgeWidth() {
		return bridgeWidth;
	}
	public void setBridgeWidth(String bridgeWidth) {
		this.bridgeWidth = bridgeWidth;
	}
		
	public String getPumpHouseArea() {
		return pumpHouseArea;
	}
	public void setPumpHouseArea(String pumpHouseArea) {
		this.pumpHouseArea = pumpHouseArea;
	}
	public String getPumpHouseCode() {
		return pumpHouseCode;
	}
	
	/**
	 * @return Returns the pumpCond.
	 */
	public String getPumpCond() {
		return pumpCond;
	}
	/**
	 * @param pumpCond The pumpCond to set.
	 */
	public void setPumpCond(String pumpCond) {
		this.pumpCond = pumpCond;
	}
	public void setPumpHouseCode(String pumpHouseCode) {
		this.pumpHouseCode = pumpHouseCode;
	}
	public String getPumpHouseHeight() {
		return pumpHouseHeight;
	}
	public void setPumpHouseHeight(String pumpHouseHeight) {
		this.pumpHouseHeight = pumpHouseHeight;
	}
	public String getPumpHouseType() {
		return pumpHouseType;
	}
	public void setPumpHouseType(String pumpHouseType) {
		this.pumpHouseType = pumpHouseType;
	}
	
	
	public String getWatchManArea() {
		return watchManArea;
	}
	public void setWatchManArea(String watchManArea) {
		this.watchManArea = watchManArea;
	}
	public String getWatchManCode() {
		return watchManCode;
	}
	public void setWatchManCode(String watchManCode) {
		this.watchManCode = watchManCode;
	}
	public String getWatchManNoOfQuarters() {
		return watchManNoOfQuarters;
	}
	public void setWatchManNoOfQuarters(String watchManNoOfQuarters) {
		this.watchManNoOfQuarters = watchManNoOfQuarters;
	}
	public String getWatchManType() {
		return watchManType;
	}
	public void setWatchManType(String watchManType) {
		this.watchManType = watchManType;
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
	
	public String getBptCapacity() {
		return bptCapacity;
	}
	public void setBptCapacity(String bptCapacity) {
		this.bptCapacity = bptCapacity;
	}
	public String getBptCode() {
		return bptCode;
	}
	public void setBptCode(String bptCode) {
		this.bptCode = bptCode;
	}
	public String getBptMaxwl() {
		return bptMaxwl;
	}
	public void setBptMaxwl(String bptMaxwl) {
		this.bptMaxwl = bptMaxwl;
	}
	public String getBptMinwl() {
		return bptMinwl;
	}
	public void setBptMinwl(String bptMinwl) {
		this.bptMinwl = bptMinwl;
	}
	public String getBptStaging() {
		return bptStaging;
	}
	public void setBptStaging(String bptStaging) {
		this.bptStaging = bptStaging;
	}
	
	
	public String getCapacitors() {
		return capacitors;
	}
	public void setCapacitors(String capacitors) {
		this.capacitors = capacitors;
	}
	public String getCapacitorsConnect() {
		return capacitorsConnect;
	}
	public void setCapacitorsConnect(String capacitorsConnect) {
		this.capacitorsConnect = capacitorsConnect;
	}
	public String getCpAmmeter() {
		return cpAmmeter;
	}
	public void setCpAmmeter(String cpAmmeter) {
		this.cpAmmeter = cpAmmeter;
	}
	public String getCpCond() {
		return cpCond;
	}
	public void setCpCond(String cpCond) {
		this.cpCond = cpCond;
	}
	public String getCpCutouts() {
		return cpCutouts;
	}
	public void setCpCutouts(String cpCutouts) {
		this.cpCutouts = cpCutouts;
	}
	public String getCpExist() {
		return cpExist;
	}
	public void setCpExist(String cpExist) {
		this.cpExist = cpExist;
	}
	public String getCpMainSwitch() {
		return cpMainSwitch;
	}
	public void setCpMainSwitch(String cpMainSwitch) {
		this.cpMainSwitch = cpMainSwitch;
	}
	public String getCpMs() {
		return cpMs;
	}
	public void setCpMs(String cpMs) {
		this.cpMs = cpMs;
	}
	public String getCpPhasing() {
		return cpPhasing;
	}
	public void setCpPhasing(String cpPhasing) {
		this.cpPhasing = cpPhasing;
	}
	public String getCpPilotLamps() {
		return cpPilotLamps;
	}
	public void setCpPilotLamps(String cpPilotLamps) {
		this.cpPilotLamps = cpPilotLamps;
	}
	public String getCpSb() {
		return cpSb;
	}
	public void setCpSb(String cpSb) {
		this.cpSb = cpSb;
	}
	public String getCpStarter() {
		return cpStarter;
	}
	public void setCpStarter(String cpStarter) {
		this.cpStarter = cpStarter;
	}
	public String getCpVoltMeter() {
		return cpVoltMeter;
	}
	public void setCpVoltMeter(String cpVoltMeter) {
		this.cpVoltMeter = cpVoltMeter;
	}
	
	public String getCpCode() {
		return cpCode;
	}
	public void setCpCode(String cpCode) {
		this.cpCode = cpCode;
	}
	
	public String getPmAvConB() {
		return pmAvConB;
	}
	public void setPmAvConB(String pmAvConB) {
		this.pmAvConB = pmAvConB;
	}
	public String getPmAvConCp() {
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
		//System.out.println("iam in rwsMasterbean");
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
	 * @return Returns the length.
	 */
	public String getLengths() {
		return lengths;
	}
	/**
	 * @param length The length to set.
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
	
	/**
	 * @return Returns the avg_hr_pumping_day.
	 */
	public String getAvg_hr_pumping_day() {
		return avg_hr_pumping_day;
	}
	/**
	 * @param avg_hr_pumping_day The avg_hr_pumping_day to set.
	 */
	public void setAvg_hr_pumping_day(String avg_hr_pumping_day) {
		this.avg_hr_pumping_day = avg_hr_pumping_day;
	}
	/**
	 * @return Returns the capasitor.
	 */
	public String getCapasitor() {
		return capasitor;
	}
	/**
	 * @param capasitor The capasitor to set.
	 */
	public void setCapasitor(String capasitor) {
		this.capasitor = capasitor;
	}
	/**
	 * @return Returns the control_panel.
	 */
	public String getControl_panel() {
		return control_panel;
	}
	/**
	 * @param control_panel The control_panel to set.
	 */
	public void setControl_panel(String control_panel) {
		this.control_panel = control_panel;
	}
	/**
	 * @return Returns the discharge_lpm.
	 */
	public String getDischarge_lpm() {
		return discharge_lpm;
	}
	/**
	 * @param discharge_lpm The discharge_lpm to set.
	 */
	public void setDischarge_lpm(String discharge_lpm) {
		this.discharge_lpm = discharge_lpm;
	}
	/**
	 * @return Returns the duty_con.
	 */
	public String getDuty_con() {
		return duty_con;
	}
	/**
	 * @param duty_con The duty_con to set.
	 */
	public void setDuty_con(String duty_con) {
		this.duty_con = duty_con;
	}
	/**
	 * @return Returns the failure_freq.
	 */
	public String getFailure_freq() {
		return failure_freq;
	}
	/**
	 * @param failure_freq The failure_freq to set.
	 */
	public void setFailure_freq(String failure_freq) {
		this.failure_freq = failure_freq;
	}
	/**
	 * @return Returns the head_mts.
	 */
	public String getHead_mts() {
		return head_mts;
	}
	/**
	 * @param head_mts The head_mts to set.
	 */
	public void setHead_mts(String head_mts) {
		this.head_mts = head_mts;
	}
	/**
	 * @return Returns the hp.
	 */
	public String getHp() {
		return hp;
	}
	/**
	 * @param hp The hp to set.
	 */
	public void setHp(String hp) {
		this.hp = hp;
	}
	/**
	 * @return Returns the power_hours.
	 */
	public String getPower_hours() {
		return power_hours;
	}
	/**
	 * @param power_hours The power_hours to set.
	 */
	public void setPower_hours(String power_hours) {
		this.power_hours = power_hours;
	}
	/**
	 * @return Returns the power_supply_available_hrs.
	 */
	public String getPower_supply_available_hrs() {
		return power_supply_available_hrs;
	}
	/**
	 * @param power_supply_available_hrs The power_supply_available_hrs to set.
	 */
	public void setPower_supply_available_hrs(String power_supply_available_hrs) {
		this.power_supply_available_hrs = power_supply_available_hrs;
	}
	/**
	 * @return Returns the pumpcode.
	 */
	public String getPumpcode() {
		return pumpcode;
	}
	/**
	 * @param pumpcode The pumpcode to set.
	 */
	public void setPumpcode(String pumpcode) {
		this.pumpcode = pumpcode;
	}
/**
 * @return Returns the pumpdet_code.
 */
public String getPumpdet_code() {
	return pumpdet_code;
}
/**
 * @param pumpdet_code The pumpdet_code to set.
 */
public void setPumpdet_code(String pumpdet_code) {
	this.pumpdet_code = pumpdet_code;
}
	/**
	 * @return Returns the qty_water_cum.
	 */
	public String getQty_water_cum() {
		return qty_water_cum;
	}
	/**
	 * @param qty_water_cum The qty_water_cum to set.
	 */
	public void setQty_water_cum(String qty_water_cum) {
		this.qty_water_cum = qty_water_cum;
	}
	/**
	 * @return Returns the repair_cost_year.
	 */
	public String getRepair_cost_year() {
		return repair_cost_year;
	}
	/**
	 * @param repair_cost_year The repair_cost_year to set.
	 */
	public void setRepair_cost_year(String repair_cost_year) {
		this.repair_cost_year = repair_cost_year;
	}
	/**
	 * @return Returns the standby_hp.
	 */
	public String getStandby_hp() {
		return standby_hp;
	}
	/**
	 * @param standby_hp The standby_hp to set.
	 */
	public void setStandby_hp(String standby_hp) {
		this.standby_hp = standby_hp;
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
	 * @return Returns the work_hrs.
	 */
	public String getWork_hrs() {
		return work_hrs;
	}
	/**
	 * @param work_hrs The work_hrs to set.
	 */
	public void setWork_hrs(String work_hrs) {
		this.work_hrs = work_hrs;
	}
	/**
	 * @return Returns the years_used.
	 */
	public String getYears_used() {
		return years_used;
	}
	/**
	 * @param years_used The years_used to set.
	 */
	public void setYears_used(String years_used) {
		this.years_used = years_used;
	}
	
	/**
	 * @return Returns the disLengths.
	 */
	public String getDisLengths() {
		return disLengths;
	}
	/**
	 * @param disLengths The disLengths to set.
	 */
	public void setDisLengths(String disLengths) {
		this.disLengths = disLengths;
	}
	/**
	 * @return Returns the brakish.
	 */
	public double getBrakish() {
		return brakish;
	}
	/**
	 * @param brakish The brakish to set.
	 */
	public void setBrakish(double brakish) {
		this.brakish = brakish;
	}
	/**
	 * @return Returns the flouride.
	 */
	public double getFlouride() {
		return flouride;
	}
	/**
	 * @param flouride The flouride to set.
	 */
	public void setFlouride(double flouride) {
		this.flouride = flouride;
	}
	/**
	 * @return Returns the iron.
	 */
	public double getIron() {
		return iron;
	}
	/**
	 * @param iron The iron to set.
	 */
	public void setIron(double iron) {
		this.iron = iron;
	}
	
	/**
	 * @return Returns the otherspecify.
	 */
	public String getOtherspecify() {
		return otherspecify;
	}
	/**
	 * @param otherspecify The otherspecify to set.
	 */
	public void setOtherspecify(String otherspecify) {
		this.otherspecify = otherspecify;
	}
	public String getPowerConnOthers() {
		return powerConnOthers;
	}
	public void setPowerConnOthers(String powerConnOthers) {
		this.powerConnOthers = powerConnOthers;
	}
	public String getBptLocation() {
		return bptLocation;
	}
	public void setBptLocation(String bptLocation) {
		this.bptLocation = bptLocation;
	}
	public String getCollectionWellLocation() {
		return collectionWellLocation;
	}
	public void setCollectionWellLocation(String collectionWellLocation) {
		this.collectionWellLocation = collectionWellLocation;
	}
	public boolean isWtpClarifloculator() {
		return wtpClarifloculator;
	}
	public void setWtpClarifloculator(boolean wtpClarifloculator) {
		this.wtpClarifloculator = wtpClarifloculator;
	}
	public boolean isWtpHorizontalRoughingFilter() {
		return wtpHorizontalRoughingFilter;
	}
	public void setWtpHorizontalRoughingFilter(
			boolean wtpHorizontalRoughingFilter) {
		this.wtpHorizontalRoughingFilter = wtpHorizontalRoughingFilter;
	}
	public boolean isWtpSedimentationTank() {
		return wtpSedimentationTank;
	}
	public void setWtpSedimentationTank(boolean wtpSedimentationTank) {
		this.wtpSedimentationTank = wtpSedimentationTank;
	}
	public boolean isWtpVerticalRoughingFilter() {
		return wtpVerticalRoughingFilter;
	}
	public void setWtpVerticalRoughingFilter(boolean wtpVerticalRoughingFilter) {
		this.wtpVerticalRoughingFilter = wtpVerticalRoughingFilter;
	}
	public String getWtpClarifloculatorValue() {
		return wtpClarifloculatorValue;
	}
	public void setWtpClarifloculatorValue(String wtpClarifloculatorValue) {
		this.wtpClarifloculatorValue = wtpClarifloculatorValue;
	}
	public String getWtpHorizontalRoughingFilterValue() {
		return wtpHorizontalRoughingFilterValue;
	}
	public void setWtpHorizontalRoughingFilterValue(
			String wtpHorizontalRoughingFilterValue) {
		this.wtpHorizontalRoughingFilterValue = wtpHorizontalRoughingFilterValue;
	}
	public String getWtpSedimentationTankValue() {
		return wtpSedimentationTankValue;
	}
	public void setWtpSedimentationTankValue(String wtpSedimentationTankValue) {
		this.wtpSedimentationTankValue = wtpSedimentationTankValue;
	}
	public String getWtpVerticalRoughingFilterValue() {
		return wtpVerticalRoughingFilterValue;
	}
	public void setWtpVerticalRoughingFilterValue(
			String wtpVerticalRoughingFilterValue) {
		this.wtpVerticalRoughingFilterValue = wtpVerticalRoughingFilterValue;
	}
	
	public String getPmAppCostOfUrbanFeeder() {
		return pmAppCostOfUrbanFeeder;
	}
	public void setPmAppCostOfUrbanFeeder(String pmAppCostOfUrbanFeeder) {
		this.pmAppCostOfUrbanFeeder = pmAppCostOfUrbanFeeder;
	}
	public String getPmDistanceFromWhereUrbanLineCanBeHad() {
		return pmDistanceFromWhereUrbanLineCanBeHad;
	}
	public void setPmDistanceFromWhereUrbanLineCanBeHad(
			String pmDistanceFromWhereUrbanLineCanBeHad) {
		this.pmDistanceFromWhereUrbanLineCanBeHad = pmDistanceFromWhereUrbanLineCanBeHad;
	}
	public String getPmFeasiblityOfGettingUrbanLine() {
		return pmFeasiblityOfGettingUrbanLine;
	}
	public void setPmFeasiblityOfGettingUrbanLine(
			String pmFeasiblityOfGettingUrbanLine) {
		this.pmFeasiblityOfGettingUrbanLine = pmFeasiblityOfGettingUrbanLine;
	}
	public String getPmFeeder() {
		return pmFeeder;
	}
	public void setPmFeeder(String pmFeeder) {
		this.pmFeeder = pmFeeder;
	}
	public String getPmHoursOfPowerAvailability() {
		return pmHoursOfPowerAvailability;
	}
	public void setPmHoursOfPowerAvailability(String pmHoursOfPowerAvailability) {
		this.pmHoursOfPowerAvailability = pmHoursOfPowerAvailability;
	}
	public String getPmLowVoltabeProblems() {
		return pmLowVoltabeProblems;
	}
	public void setPmLowVoltabeProblems(String pmLowVoltabeProblems) {
		this.pmLowVoltabeProblems = pmLowVoltabeProblems;
	}
	public String getPmLowVoltageProblems() {
		return pmLowVoltageProblems;
	}
	public void setPmLowVoltageProblems(String pmLowVoltageProblems) {
		this.pmLowVoltageProblems = pmLowVoltageProblems;
	}
	public String getPmRemarks() {
		return pmRemarks;
	}
	public void setPmRemarks(String pmRemarks) {
		this.pmRemarks = pmRemarks;
	}
	public String getPumpControlPanel() {
		return pumpControlPanel;
	}
	public void setPumpControlPanel(String pumpControlPanel) {
		this.pumpControlPanel = pumpControlPanel;
	}
	public String getPumpDesignedHead() {
		return pumpDesignedHead;
	}
	public void setPumpDesignedHead(String pumpDesignedHead) {
		this.pumpDesignedHead = pumpDesignedHead;
	}
	public String getPumpDesignedLpm() {
		return pumpDesignedLpm;
	}
	public void setPumpDesignedLpm(String pumpDesignedLpm) {
		this.pumpDesignedLpm = pumpDesignedLpm;
	}
	public String getPumpHoursRunningPerDay() {
		return pumpHoursRunningPerDay;
	}
	public void setPumpHoursRunningPerDay(String pumpHoursRunningPerDay) {
		this.pumpHoursRunningPerDay = pumpHoursRunningPerDay;
	}
	public String getPumpLocation() {
		return pumpLocation;
	}
	public void setPumpLocation(String pumpLocation) {
		this.pumpLocation = pumpLocation;
	}
	public String getPumpMake() {
		return pumpMake;
	}
	public void setPumpMake(String pumpMake) {
		this.pumpMake = pumpMake;
	}
	public String getPumpUsage() {
		return pumpUsage;
	}
	public void setPumpUsage(String pumpUsage) {
		this.pumpUsage = pumpUsage;
	}
	public String getPumpYearOfCommissioning() {
		return pumpYearOfCommissioning;
	}
	public void setPumpYearOfCommissioning(String pumpYearOfCommissioning) {
		this.pumpYearOfCommissioning = pumpYearOfCommissioning;
	}
	public String getGravitymain_location() {
		return gravitymain_location;
	}
	public void setGravitymain_location(String gravitymain_location) {
		this.gravitymain_location = gravitymain_location;
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
	public String getPumpHouseLocation() {
		return pumpHouseLocation;
	}
	public void setPumpHouseLocation(String pumpHouseLocation) {
		this.pumpHouseLocation = pumpHouseLocation;
	}
	public String getRwCapacity() {
		return rwCapacity;
	}
	public void setRwCapacity(String rwCapacity) {
		this.rwCapacity = rwCapacity;
	}
	public String getCisNoOfTaps() {
		return cisNoOfTaps;
	}
	public void setCisNoOfTaps(String cisNoOfTaps) {
		this.cisNoOfTaps = cisNoOfTaps;
	}

	
	public double getWtpRateOfFiltration() {
		return wtpRateOfFiltration;
	}
	public void setWtpRateOfFiltration(double wtpRateOfFiltration) {
		this.wtpRateOfFiltration = wtpRateOfFiltration;
	}
	public java.util.ArrayList getSelectedHabLinks() {
		return selectedHabLinks;
	}
	public void setSelectedHabLinks(java.util.ArrayList selectedHabLinks) {
		this.selectedHabLinks = selectedHabLinks;
	}
	public boolean isSaved() {
		return isSaved;
	}
	public void setSaved(boolean isSaved) {
		this.isSaved = isSaved;
	}

	public boolean isChecked() {
		return isChecked;
	}
	public void setChecked(boolean isChecked) {
		this.isChecked = isChecked;
	}
	public String getWatchManLocation() {
		return watchManLocation;
	}
	public void setWatchManLocation(String watchManLocation) {
		this.watchManLocation = watchManLocation;
	}
	public String getOthersType() {
		return othersType;
	}
	public void setOthersType(String othersType) {
		this.othersType = othersType;
	}
	public String getOwBrakishPer() {
		return owBrakishPer;
	}
	public void setOwBrakishPer(String owBrakishPer) {
		this.owBrakishPer = owBrakishPer;
	}
	public String getOwFlouridePer() {
		return owFlouridePer;
	}
	public void setOwFlouridePer(String owFlouridePer) {
		this.owFlouridePer = owFlouridePer;
	}
	public String getOwIronPer() {
		return owIronPer;
	}
	public void setOwIronPer(String owIronPer) {
		this.owIronPer = owIronPer;
	}
	public String getOwLocation() {
		return owLocation;
	}
	public void setOwLocation(String owLocation) {
		this.owLocation = owLocation;
	}
	public String getOwNormalwl() {
		return owNormalwl;
	}
	public void setOwNormalwl(String owNormalwl) {
		this.owNormalwl = owNormalwl;
	}
	public String getOwOtherPer() {
		return owOtherPer;
	}
	public void setOwOtherPer(String owOtherPer) {
		this.owOtherPer = owOtherPer;
	}
	public String getOwOtherType() {
		return owOtherType;
	}
	public void setOwOtherType(String owOtherType) {
		this.owOtherType = owOtherType;
	}
	public String getOwPlatformCondition() {
		return owPlatformCondition;
	}
	public void setOwPlatformCondition(String owPlatformCondition) {
		this.owPlatformCondition = owPlatformCondition;
	}
	public String getOwPlatformExists() {
		return owPlatformExists;
	}
	public void setOwPlatformExists(String owPlatformExists) {
		this.owPlatformExists = owPlatformExists;
	}
	public String getOwPurpose() {
		return owPurpose;
	}
	public void setOwPurpose(String owPurpose) {
		this.owPurpose = owPurpose;
	}
	public String getOwQuality() {
		return owQuality;
	}
	public void setOwQuality(String owQuality) {
		this.owQuality = owQuality;
	}
	public String getShpAvgHours() {
		return shpAvgHours;
	}
	public void setShpAvgHours(String shpAvgHours) {
		this.shpAvgHours = shpAvgHours;
	}
	public String getShpAvgTime() {
		return shpAvgTime;
	}
	public void setShpAvgTime(String shpAvgTime) {
		this.shpAvgTime = shpAvgTime;
	}
	public String getShpCode() {
		return shpCode;
	}
	public void setShpCode(String shpCode) {
		this.shpCode = shpCode;
	}
	public String getShpDepth() {
		return shpDepth;
	}
	public void setShpDepth(String shpDepth) {
		this.shpDepth = shpDepth;
	}
	public String getShpDiameter() {
		return shpDiameter;
	}
	public void setShpDiameter(String shpDiameter) {
		this.shpDiameter = shpDiameter;
	}
	public String getShpHygiene() {
		return shpHygiene;
	}
	public void setShpHygiene(String shpHygiene) {
		this.shpHygiene = shpHygiene;
	}
	public String getShpLocation() {
		return shpLocation;
	}
	public void setShpLocation(String shpLocation) {
		this.shpLocation = shpLocation;
	}
	public String getShpYield() {
		return shpYield;
	}
	public void setShpYield(String shpYield) {
		this.shpYield = shpYield;
	}
	public String getUndesirableEffect() {
		return undesirableEffect;
	}
	public void setUndesirableEffect(String undesirableEffect) {
		this.undesirableEffect = undesirableEffect;
	}
	public String getTotOthersSupply() {
		return totOthersSupply;
	}
	public void setTotOthersSupply(String totOthersSupply) {
		this.totOthersSupply = totOthersSupply;
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
	public String getVcode() {
		return vcode;
	}
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	public String getVname() {
		return vname;
	}
	public void setVname(String vname) {
		this.vname = vname;
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
	public String getContamPer() {
		return contamPer;
	}
	public void setContamPer(String contamPer) {
		this.contamPer = contamPer;
	}
	public String getStatusDate() {
		return statusDate;
	}
	public void setStatusDate(String statusDate) {
		this.statusDate = statusDate;
	}
	public String getBrakishContamination() {
		return brakishContamination;
	}
	public void setBrakishContamination(String brakishContamination) {
		this.brakishContamination = brakishContamination;
	}
	
	public String getIronContamination() {
		return ironContamination;
	}
	public void setIronContamination(String ironContamination) {
		this.ironContamination = ironContamination;
	}
	public String getFlourideContamination() {
		return flourideContamination;
	}
	public void setFlourideContamination(String flourideContamination) {
		this.flourideContamination = flourideContamination;
	}
	public String getSysDate() {
		return sysDate;
	}
	public void setSysDate(String sysDate) {
		this.sysDate = sysDate;
	}
	public String getSourceAndLocation() {
		return sourceAndLocation;
	}
	public void setSourceAndLocation(String sourceAndLocation) {
		this.sourceAndLocation = sourceAndLocation;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getNoOfRecords() {
		return noOfRecords;
	}
	public void setNoOfRecords(String noOfRecords) {
		this.noOfRecords = noOfRecords;
	}
	
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getApcatog() {
		return apcatog;
	}
	public void setApcatog(String apcatog) {
		this.apcatog = apcatog;
	}
	public String getApgli() {
		return apgli;
	}
	public void setApgli(String apgli) {
		this.apgli = apgli;
	}
	public String getAplgi() {
		return aplgi;
	}
	public void setAplgi(String aplgi) {
		this.aplgi = aplgi;
	}
	public String getCasteCode() {
		return casteCode;
	}
	public void setCasteCode(String casteCode) {
		this.casteCode = casteCode;
	}
	public String getCasteName() {
		return casteName;
	}
	public void setCasteName(String casteName) {
		this.casteName = casteName;
	}
	public String getCasteNoName() {
		return casteNoName;
	}
	public void setCasteNoName(String casteNoName) {
		this.casteNoName = casteNoName;
	}
	public String getCatCode() {
		return catCode;
	}
	public void setCatCode(String catCode) {
		this.catCode = catCode;
	}
	public String getCatName() {
		return catName;
	}
	public void setCatName(String catName) {
		this.catName = catName;
	}
	public String getCatNoName() {
		return catNoName;
	}
	public void setCatNoName(String catNoName) {
		this.catNoName = catNoName;
	}
	public String getDacctest() {
		return dacctest;
	}
	public void setDacctest(String dacctest) {
		this.dacctest = dacctest;
	}
	public String getDcommprob() {
		return dcommprob;
	}
	public void setDcommprob(String dcommprob) {
		this.dcommprob = dcommprob;
	}
	public String getDdeclprob() {
		return ddeclprob;
	}
	public void setDdeclprob(String ddeclprob) {
		this.ddeclprob = ddeclprob;
	}
	public String getDeputation() {
		return deputation;
	}
	public void setDeputation(String deputation) {
		this.deputation = deputation;
	}
	public String getDiststudied10() {
		return diststudied10;
	}
	public void setDiststudied10(String diststudied10) {
		this.diststudied10 = diststudied10;
	}
	public String getDiststudied4() {
		return diststudied4;
	}
	public void setDiststudied4(String diststudied4) {
		this.diststudied4 = diststudied4;
	}
	public String getDiststudied5() {
		return diststudied5;
	}
	public void setDiststudied5(String diststudied5) {
		this.diststudied5 = diststudied5;
	}
	public String getDiststudied6() {
		return diststudied6;
	}
	public void setDiststudied6(String diststudied6) {
		this.diststudied6 = diststudied6;
	}
	public String getDiststudied7() {
		return diststudied7;
	}
	public void setDiststudied7(String diststudied7) {
		this.diststudied7 = diststudied7;
	}
	public String getDiststudied8() {
		return diststudied8;
	}
	public void setDiststudied8(String diststudied8) {
		this.diststudied8 = diststudied8;
	}
	public String getDiststudied9() {
		return diststudied9;
	}
	public void setDiststudied9(String diststudied9) {
		this.diststudied9 = diststudied9;
	}
	public String getDoatest() {
		return Doatest;
	}
	public void setDoatest(String doatest) {
		Doatest = doatest;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getIncrementdate() {
		return incrementdate;
	}
	public void setIncrementdate(String incrementdate) {
		this.incrementdate = incrementdate;
	}
	public String getLocaldist() {
		return localdist;
	}
	public void setLocaldist(String localdist) {
		this.localdist = localdist;
	}
	public String getLocalzone() {
		return localzone;
	}
	public void setLocalzone(String localzone) {
		this.localzone = localzone;
	}
	public String getMoap() {
		return moap;
	}
	public void setMoap(String moap) {
		this.moap = moap;
	}
	public String getMoapCode() {
		return moapCode;
	}
	public void setMoapCode(String moapCode) {
		this.moapCode = moapCode;
	}
	public String getMoapName() {
		return moapName;
	}
	public void setMoapName(String moapName) {
		this.moapName = moapName;
	}
	public String getModeNoName() {
		return modeNoName;
	}
	public void setModeNoName(String modeNoName) {
		this.modeNoName = modeNoName;
	}
	public String getNarecruit() {
		return narecruit;
	}
	public void setNarecruit(String narecruit) {
		this.narecruit = narecruit;
	}
	public String getNdist() {
		return ndist;
	}
	public void setNdist(String ndist) {
		this.ndist = ndist;
	}
	public String getNmand() {
		return nmand;
	}
	public void setNmand(String nmand) {
		this.nmand = nmand;
	}
	public String getNoofyrs() {
		return noofyrs;
	}
	public void setNoofyrs(String noofyrs) {
		this.noofyrs = noofyrs;
	}
	public String getNoofyrs1() {
		return noofyrs1;
	}
	public void setNoofyrs1(String noofyrs1) {
		this.noofyrs1 = noofyrs1;
	}
	public String getNrevenue() {
		return nrevenue;
	}
	public void setNrevenue(String nrevenue) {
		this.nrevenue = nrevenue;
	}
	public String getPanno() {
		return panno;
	}
	public void setPanno(String panno) {
		this.panno = panno;
	}
	public String getPayscale() {
		return payscale;
	}
	public void setPayscale(String payscale) {
		this.payscale = payscale;
	}
	public String getPerdesig() {
		return perdesig;
	}
	public void setPerdesig(String perdesig) {
		this.perdesig = perdesig;
	}
	public String getPresentdesig() {
		return presentdesig;
	}
	public void setPresentdesig(String presentdesig) {
		this.presentdesig = presentdesig;
	}
	public String getPvtdist() {
		return pvtdist;
	}
	public void setPvtdist(String pvtdist) {
		this.pvtdist = pvtdist;
	}
	public String getPvtzone() {
		return pvtzone;
	}
	public void setPvtzone(String pvtzone) {
		this.pvtzone = pvtzone;
	}
	public String getRelation() {
		return relation;
	}
	public void setRelation(String relation) {
		this.relation = relation;
	}
	public String getRelgCode() {
		return relgCode;
	}
	public void setRelgCode(String relgCode) {
		this.relgCode = relgCode;
	}
	public String getRelgName() {
		return relgName;
	}
	public void setRelgName(String relgName) {
		this.relgName = relgName;
	}
	public String getRelgNoName() {
		return relgNoName;
	}
	public void setRelgNoName(String relgNoName) {
		this.relgNoName = relgNoName;
	}
	public String getReligion() {
		return religion;
	}
	public void setReligion(String religion) {
		this.religion = religion;
	}
	public String getSocial() {
		return social;
	}
	public void setSocial(String social) {
		this.social = social;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public String getTempdesgCode() {
		return tempdesgCode;
	}
	public void setTempdesgCode(String tempdesgCode) {
		this.tempdesgCode = tempdesgCode;
	}
	public String getTempdesig() {
		return tempdesig;
	}
	public void setTempdesig(String tempdesig) {
		this.tempdesig = tempdesig;
	}
	public String getTestpassed() {
		return testpassed;
	}
	public void setTestpassed(String testpassed) {
		this.testpassed = testpassed;
	}
	public String getUpdatedate() {
		return updatedate;
	}
	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}
	public String getZone() {
		return zone;
	}
	public void setZone(String zone) {
		this.zone = zone;
	}
	public String getZoneCode() {
		return zoneCode;
	}
	public void setZoneCode(String zoneCode) {
		this.zoneCode = zoneCode;
	}
	public String getZoneName() {
		return zoneName;
	}
	public void setZoneName(String zoneName) {
		this.zoneName = zoneName;
	}
	public String getZoneNoName() {
		return zoneNoName;
	}
	public void setZoneNoName(String zoneNoName) {
		this.zoneNoName = zoneNoName;
	}
	public String getDesig() {
		return desig;
	}
	public void setDesig(String desig) {
		this.desig = desig;
	}
	public String getDistName10() {
		return distName10;
	}
	public void setDistName10(String distName10) {
		this.distName10 = distName10;
	}
	public String getDistName4() {
		return distName4;
	}
	public void setDistName4(String distName4) {
		this.distName4 = distName4;
	}
	public String getDistName5() {
		return distName5;
	}
	public void setDistName5(String distName5) {
		this.distName5 = distName5;
	}
	public String getDistName6() {
		return distName6;
	}
	public void setDistName6(String distName6) {
		this.distName6 = distName6;
	}
	public String getDistName7() {
		return distName7;
	}
	public void setDistName7(String distName7) {
		this.distName7 = distName7;
	}
	public String getDistName8() {
		return distName8;
	}
	public void setDistName8(String distName8) {
		this.distName8 = distName8;
	}
	public String getDistName9() {
		return distName9;
	}
	public void setDistName9(String distName9) {
		this.distName9 = distName9;
	}
	public String getGpfno() {
		return gpfno;
	}
	public void setGpfno(String gpfno) {
		this.gpfno = gpfno;
	}
	public String getLocaldistName() {
		return localdistName;
	}
	public void setLocaldistName(String localdistName) {
		this.localdistName = localdistName;
	}
	public String getLocalzoneName() {
		return localzoneName;
	}
	public void setLocalzoneName(String localzoneName) {
		this.localzoneName = localzoneName;
	}
	public String getPvtdistName() {
		return pvtdistName;
	}
	public void setPvtdistName(String pvtdistName) {
		this.pvtdistName = pvtdistName;
	}
	public String getPvtdistZone() {
		return pvtdistZone;
	}
	public void setPvtdistZone(String pvtdistZone) {
		this.pvtdistZone = pvtdistZone;
	}
	public String getTappingPoint() {
		return tappingPoint;
	}
	public void setTappingPoint(String tappingPoint) {
		this.tappingPoint = tappingPoint;
	}
	public String getBridgeLocation() {
		return bridgeLocation;
	}
	public void setBridgeLocation(String bridgeLocation) {
		this.bridgeLocation = bridgeLocation;
	}
	/**
	 * @return Returns the amnt_reqd1.
	 */
	public String getAmnt_reqd1() {
		return amnt_reqd1;
	}
	/**
	 * @param amnt_reqd1 The amnt_reqd1 to set.
	 */
	public void setAmnt_reqd1(String amnt_reqd1) {
		this.amnt_reqd1 = amnt_reqd1;
	}
	/**
	 * @return Returns the compl_stat.
	 */
	public String[] getCompl_stat() {
		return compl_stat;
	}
	/**
	 * @param compl_stat The compl_stat to set.
	 */
	public void setCompl_stat(String[] compl_stat) {
		this.compl_stat = compl_stat;
	}
	/**
	 * @return Returns the cp.
	 */
	public String getCp() {
		return cp;
	}
	/**
	 * @param cp The cp to set.
	 */
	public void setCp(String cp) {
		this.cp = cp;
	}
	/**
	 * @return Returns the csc.
	 */
	public String getCsc() {
		return csc;
	}
	/**
	 * @param csc The csc to set.
	 */
	public void setCsc(String csc) {
		this.csc = csc;
	}
	/**
	 * @return Returns the cst.
	 */
	public String getCst() {
		return cst;
	}
	/**
	 * @param cst The cst to set.
	 */
	public void setCst(String cst) {
		this.cst = cst;
	}
	/**
	 * @return Returns the ctot.
	 */
	public String getCtot() {
		return ctot;
	}
	/**
	 * @param ctot The ctot to set.
	 */
	public void setCtot(String ctot) {
		this.ctot = ctot;
	}
	/**
	 * @return Returns the distName.
	 */
	public String getDistName() {
		return distName;
	}
	/**
	 * @param distName The distName to set.
	 */
	public void setDistName(String distName) {
		this.distName = distName;
	}
	/**
	 * @return Returns the ext_wat_lvl.
	 */
	public String getExt_wat_lvl() {
		return ext_wat_lvl;
	}
	/**
	 * @param ext_wat_lvl The ext_wat_lvl to set.
	 */
	public void setExt_wat_lvl(String ext_wat_lvl) {
		this.ext_wat_lvl = ext_wat_lvl;
	}
	/**
	 * @return Returns the flopop1.
	 */
	public String getFlopop1() {
		return flopop1;
	}
	/**
	 * @param flopop1 The flopop1 to set.
	 */
	public void setFlopop1(String flopop1) {
		this.flopop1 = flopop1;
	}
	/**
	 * @return Returns the floreason.
	 */
	public String getFloreason() {
		return floreason;
	}
	/**
	 * @param floreason The floreason to set.
	 */
	public void setFloreason(String floreason) {
		this.floreason = floreason;
	}
	/**
	 * @return Returns the near_ground_source.
	 */
	public String getNear_ground_source() {
		return near_ground_source;
	}
	/**
	 * @param near_ground_source The near_ground_source to set.
	 */
	public void setNear_ground_source(String near_ground_source) {
		this.near_ground_source = near_ground_source;
	}
	/**
	 * @return Returns the near_surf_source.
	 */
	public String getNear_surf_source() {
		return near_surf_source;
	}
	/**
	 * @param near_surf_source The near_surf_source to set.
	 */
	public void setNear_surf_source(String near_surf_source) {
		this.near_surf_source = near_surf_source;
	}
	/**
	 * @return Returns the noOfHabs.
	 */
	public int getNoOfHabs() {
		return noOfHabs;
	}
	/**
	 * @param noOfHabs The noOfHabs to set.
	 */
	public void setNoOfHabs(int noOfHabs) {
		this.noOfHabs = noOfHabs;
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
	 * @return Returns the panchName.
	 */
	public String getPanchName() {
		return panchName;
	}
	/**
	 * @param panchName The panchName to set.
	 */
	public void setPanchName(String panchName) {
		this.panchName = panchName;
	}
	/**
	 * @return Returns the prev_stat1.
	 */
	public String[] getPrev_stat1() {
		return prev_stat1;
	}
	/**
	 * @param prev_stat1 The prev_stat1 to set.
	 */
	public void setPrev_stat1(String[] prev_stat1) {
		this.prev_stat1 = prev_stat1;
	}
	/**
	 * @return Returns the prop_year1.
	 */
	public String getProp_year1() {
		return prop_year1;
	}
	/**
	 * @param prop_year1 The prop_year1 to set.
	 */
	public void setProp_year1(String prop_year1) {
		this.prop_year1 = prop_year1;
	}
	/**
	 * @return Returns the tot_wat_supl.
	 */
	public String getTot_wat_supl() {
		return tot_wat_supl;
	}
	/**
	 * @param tot_wat_supl The tot_wat_supl to set.
	 */
	public void setTot_wat_supl(String tot_wat_supl) {
		this.tot_wat_supl = tot_wat_supl;
	}
	/**
	 * @return Returns the villCode.
	 */
	public String getVillCode() {
		return villCode;
	}
	/**
	 * @param villCode The villCode to set.
	 */
	public void setVillCode(String villCode) {
		this.villCode = villCode;
	}
	/**
	 * @return Returns the villName.
	 */
	public String getVillName() {
		return villName;
	}
	/**
	 * @param villName The villName to set.
	 */
	public void setVillName(String villName) {
		this.villName = villName;
	}
	/**
	 * @return Returns the cp_condition.
	 */
	public String getCp_condition() {
		return cp_condition;
	}
	/**
	 * @param cp_condition The cp_condition to set.
	 */
	public void setCp_condition(String cp_condition) {
		this.cp_condition = cp_condition;
	}
	/**
	 * @return Returns the csc_condition.
	 */
	public String getCsc_condition() {
		return csc_condition;
	}
	/**
	 * @param csc_condition The csc_condition to set.
	 */
	public void setCsc_condition(String csc_condition) {
		this.csc_condition = csc_condition;
	}
	/**
	 * @return Returns the cst_condition.
	 */
	public String getCst_condition() {
		return cst_condition;
	}
	/**
	 * @param cst_condition The cst_condition to set.
	 */
	public void setCst_condition(String cst_condition) {
		this.cst_condition = cst_condition;
	}
	/**
	 * @return Returns the ctot_condition.
	 */
	public String getCtot_condition() {
		return ctot_condition;
	}
	/**
	 * @param ctot_condition The ctot_condition to set.
	 */
	public void setCtot_condition(String ctot_condition) {
		this.ctot_condition = ctot_condition;
	}
	/**
	 * @return Returns the ext_wat_lvl_condition.
	 */
	public String getExt_wat_lvl_condition() {
		return ext_wat_lvl_condition;
	}
	/**
	 * @param ext_wat_lvl_condition The ext_wat_lvl_condition to set.
	 */
	public void setExt_wat_lvl_condition(String ext_wat_lvl_condition) {
		this.ext_wat_lvl_condition = ext_wat_lvl_condition;
	}
	/**
	 * @return Returns the flopop_condition.
	 */
	public String getFlopop_condition() {
		return flopop_condition;
	}
	/**
	 * @param flopop_condition The flopop_condition to set.
	 */
	public void setFlopop_condition(String flopop_condition) {
		this.flopop_condition = flopop_condition;
	}
	/**
	 * @return Returns the near_ground_source_condition.
	 */
	public String getNear_ground_source_condition() {
		return near_ground_source_condition;
	}
	/**
	 * @param near_ground_source_condition The near_ground_source_condition to set.
	 */
	public void setNear_ground_source_condition(
			String near_ground_source_condition) {
		this.near_ground_source_condition = near_ground_source_condition;
	}
	/**
	 * @return Returns the near_surf_source_condition.
	 */
	public String getNear_surf_source_condition() {
		return near_surf_source_condition;
	}
	/**
	 * @param near_surf_source_condition The near_surf_source_condition to set.
	 */
	public void setNear_surf_source_condition(String near_surf_source_condition) {
		this.near_surf_source_condition = near_surf_source_condition;
	}
	/**
	 * @return Returns the tot_wat_supl_condition.
	 */
	public String getTot_wat_supl_condition() {
		return tot_wat_supl_condition;
	}
	/**
	 * @param tot_wat_supl_condition The tot_wat_supl_condition to set.
	 */
	public void setTot_wat_supl_condition(String tot_wat_supl_condition) {
		this.tot_wat_supl_condition = tot_wat_supl_condition;
	}
	/**
	 * @return Returns the amnt_reqd_condition.
	 */
	public String getAmnt_reqd_condition() {
		return amnt_reqd_condition;
	}
	/**
	 * @param amnt_reqd_condition The amnt_reqd_condition to set.
	 */
	public void setAmnt_reqd_condition(String amnt_reqd_condition) {
		this.amnt_reqd_condition = amnt_reqd_condition;
	}
	/**
	 * @return Returns the censusFloat.
	 */
	public String getCensusFloat() {
		return censusFloat;
	}
	/**
	 * @param censusFloat The censusFloat to set.
	 */
	public void setCensusFloat(String censusFloat) {
		this.censusFloat = censusFloat;
	}
	/**
	 * @return Returns the censusTotal.
	 */
	public String getCensusTotal() {
		return censusTotal;
	}
	/**
	 * @param censusTotal The censusTotal to set.
	 */
	public void setCensusTotal(String censusTotal) {
		this.censusTotal = censusTotal;
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
	
	/*
	 * methods added by ramesh
	 */

	/**
	 * @return Returns the addate_condition.
	 */
	public String getAddate_condition() {
		return addate_condition;
	}
	/**
	 * @param addate_condition The addate_condition to set.
	 */
	public void setAddate_condition(String addate_condition) {
		this.addate_condition = addate_condition;
	}
	/**
	 * @return Returns the adminSancDate.
	 */
	public String getAdminSancDate() {
		return adminSancDate;
	}
	/**
	 * @param adminSancDate The adminSancDate to set.
	 */
	public void setAdminSancDate(String adminSancDate) {
		this.adminSancDate = adminSancDate;
	}
	/**
	 * @return Returns the asa.
	 */
	public String getAsa() {
		return asa;
	}
	/**
	 * @param asa The asa to set.
	 */
	public void setAsa(String asa) {
		this.asa = asa;
	}
	/**
	 * @return Returns the asa_condition.
	 */
	public String getAsa_condition() {
		return asa_condition;
	}
	/**
	 * @param asa_condition The asa_condition to set.
	 */
	public void setAsa_condition(String asa_condition) {
		this.asa_condition = asa_condition;
	}
	/**
	 * @return Returns the augnew.
	 */
	public String getAugnew() {
		return augnew;
	}
	/**
	 * @param augnew The augnew to set.
	 */
	public void setAugnew(String augnew) {
		this.augnew = augnew;
	}
	/**
	 * @return Returns the conDate.
	 */
	public String getConDate() {
		return conDate;
	}
	/**
	 * @param conDate The conDate to set.
	 */
	public void setConDate(String conDate) {
		this.conDate = conDate;
	}
	/**
	 * @return Returns the condate_condition.
	 */
	public String getCondate_condition() {
		return condate_condition;
	}
	/**
	 * @param condate_condition The condate_condition to set.
	 */
	public void setCondate_condition(String condate_condition) {
		this.condate_condition = condate_condition;
	}
	/**
	 * @return Returns the conDur.
	 */
	public String getConDur() {
		return conDur;
	}
	/**
	 * @param conDur The conDur to set.
	 */
	public void setConDur(String conDur) {
		this.conDur = conDur;
	}
	/**
	 * @return Returns the condur_condition.
	 */
	public String getCondur_condition() {
		return condur_condition;
	}
	/**
	 * @param condur_condition The condur_condition to set.
	 */
	public void setCondur_condition(String condur_condition) {
		this.condur_condition = condur_condition;
	}
	/**
	 * @return Returns the constituency.
	 */
	public String getConstituency() {
		return constituency;
	}
	/**
	 * @param constituency The constituency to set.
	 */
	public void setConstituency(String constituency) {
		this.constituency = constituency;
	}
	/**
	 * @return Returns the creport.
	 */
	public String getCreport() {
		return creport;
	}
	/**
	 * @param creport The creport to set.
	 */
	public void setCreport(String creport) {
		this.creport = creport;
	}
	/**
	 * @return Returns the division.
	 */
	public String getDivision() {
		return division;
	}
	/**
	 * @param division The division to set.
	 */
	public void setDivision(String division) {
		this.division = division;
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
	 * @return Returns the habcode.
	 */
	public String getHabcode() {
		return habcode;
	}
	/**
	 * @param habcode The habcode to set.
	 */
	public void setHabcode(String habcode) {
		this.habcode = habcode;
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
	 * @return Returns the noh_condition.
	 */
	public String getNoh_condition() {
		return noh_condition;
	}
	/**
	 * @param noh_condition The noh_condition to set.
	 */
	public void setNoh_condition(String noh_condition) {
		this.noh_condition = noh_condition;
	}
	/**
	 * @return Returns the nohabs.
	 */
	public String getNohabs() {
		return nohabs;
	}
	/**
	 * @param nohabs The nohabs to set.
	 */
	public void setNohabs(String nohabs) {
		this.nohabs = nohabs;
	}
	/**
	 * @return Returns the offices.
	 */
	public String getOffices() {
		return offices;
	}
	/**
	 * @param offices The offices to set.
	 */
	public void setOffices(String offices) {
		this.offices = offices;
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
	 * @return Returns the program.
	 */
	public String getProgram() {
		return program;
	}
	/**
	 * @param program The program to set.
	 */
	public void setProgram(String program) {
		this.program = program;
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
	 * @return Returns the sid_condition.
	 */
	public String getSid_condition() {
		return sid_condition;
	}
	/**
	 * @param sid_condition The sid_condition to set.
	 */
	public void setSid_condition(String sid_condition) {
		this.sid_condition = sid_condition;
	}
	/**
	 * @return Returns the sidDate.
	 */
	public String getSidDate() {
		return sidDate;
	}
	/**
	 * @param sidDate The sidDate to set.
	 */
	public void setSidDate(String sidDate) {
		this.sidDate = sidDate;
	}
	/**
	 * @return Returns the sidhand_condition.
	 */
	public String getSidhand_condition() {
		return sidhand_condition;
	}
	/**
	 * @param sidhand_condition The sidhand_condition to set.
	 */
	public void setSidhand_condition(String sidhand_condition) {
		this.sidhand_condition = sidhand_condition;
	}
	/**
	 * @return Returns the sidhandDate.
	 */
	public String getSidhandDate() {
		return sidhandDate;
	}
	/**
	 * @param sidhandDate The sidhandDate to set.
	 */
	public void setSidhandDate(String sidhandDate) {
		this.sidhandDate = sidhandDate;
	}
	/**
	 * @return Returns the subprogram.
	 */
	public String getSubprogram() {
		return subprogram;
	}
	/**
	 * @param subprogram The subprogram to set.
	 */
	public void setSubprogram(String subprogram) {
		this.subprogram = subprogram;
	}
	/**
	 * @return Returns the techSancDate.
	 */
	public String getTechSancDate() {
		return techSancDate;
	}
	/**
	 * @param techSancDate The techSancDate to set.
	 */
	public void setTechSancDate(String techSancDate) {
		this.techSancDate = techSancDate;
	}
	/**
	 * @return Returns the tsa.
	 */
	public String getTsa() {
		return tsa;
	}
	/**
	 * @param tsa The tsa to set.
	 */
	public void setTsa(String tsa) {
		this.tsa = tsa;
	}
	/**
	 * @return Returns the tsa_condition.
	 */
	public String getTsa_condition() {
		return tsa_condition;
	}
	/**
	 * @param tsa_condition The tsa_condition to set.
	 */
	public void setTsa_condition(String tsa_condition) {
		this.tsa_condition = tsa_condition;
	}
	/**
	 * @return Returns the tsdate_condition.
	 */
	public String getTsdate_condition() {
		return tsdate_condition;
	}
	/**
	 * @param tsdate_condition The tsdate_condition to set.
	 */
	public void setTsdate_condition(String tsdate_condition) {
		this.tsdate_condition = tsdate_condition;
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
	/**
	 * @return Returns the workcategory.
	 */
	public String getWorkcategory() {
		return workcategory;
	}
	/**
	 * @param workcategory The workcategory to set.
	 */
	public void setWorkcategory(String workcategory) {
		this.workcategory = workcategory;
	}
	/**
	 * @return Returns the wrkcommDate.
	 */
	public String getWrkcommDate() {
		return wrkcommDate;
	}
	/**
	 * @param wrkcommDate The wrkcommDate to set.
	 */
	public void setWrkcommDate(String wrkcommDate) {
		this.wrkcommDate = wrkcommDate;
	}
	/**
	 * @return Returns the wrkcommdt_condition.
	 */
	public String getWrkcommdt_condition() {
		return wrkcommdt_condition;
	}
	/**
	 * @param wrkcommdt_condition The wrkcommdt_condition to set.
	 */
	public void setWrkcommdt_condition(String wrkcommdt_condition) {
		this.wrkcommdt_condition = wrkcommdt_condition;
	}
	/**
	 * @return Returns the wrkcompDate.
	 */
	public String getWrkcompDate() {
		return wrkcompDate;
	}
	/**
	 * @param wrkcompDate The wrkcompDate to set.
	 */
	public void setWrkcompDate(String wrkcompDate) {
		this.wrkcompDate = wrkcompDate;
	}
	/**
	 * @return Returns the wrkcompdt_condition.
	 */
	public String getWrkcompdt_condition() {
		return wrkcompdt_condition;
	}
	/**
	 * @param wrkcompdt_condition The wrkcompdt_condition to set.
	 */
	public void setWrkcompdt_condition(String wrkcompdt_condition) {
		this.wrkcompdt_condition = wrkcompdt_condition;
	}
	/**
	 * @return Returns the wrkExp.
	 */
	public String getWrkExp() {
		return wrkExp;
	}
	/**
	 * @param wrkExp The wrkExp to set.
	 */
	public void setWrkExp(String wrkExp) {
		this.wrkExp = wrkExp;
	}
	/**
	 * @return Returns the wrkexp_condition.
	 */
	public String getWrkexp_condition() {
		return wrkexp_condition;
	}
	/**
	 * @param wrkexp_condition The wrkexp_condition to set.
	 */
	public void setWrkexp_condition(String wrkexp_condition) {
		this.wrkexp_condition = wrkexp_condition;
	}
	
	/*
	 * 
	 * @author ramesh ended
	 */

	/**
	 * @return Returns the address1.
	 */
	public String getAddress1() {
		return address1;
	}
	/**
	 * @param address1 The address1 to set.
	 */
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	/**
	 * @return Returns the address2.
	 */
	public String getAddress2() {
		return address2;
	}
	/**
	 * @param address2 The address2 to set.
	 */
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	/**
	 * @return Returns the address3.
	 */
	public String getAddress3() {
		return address3;
	}
	/**
	 * @param address3 The address3 to set.
	 */
	public void setAddress3(String address3) {
		this.address3 = address3;
	}
	/**
	 * @return Returns the paoName.
	 */
	public String getPaoName() {
		return paoName;
	}
	/**
	 * @param paoName The paoName to set.
	 */
	public void setPaoName(String paoName) {
		this.paoName = paoName;
	}
	
	/**
	 * @return Returns the paoapao.
	 */
	public String getPaoapao() {
		return paoapao;
	}
	/**
	 * @param paoapao The paoapao to set.
	 */
	public void setPaoapao(String paoapao) {
		this.paoapao = paoapao;
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
	 * @return Returns the othersSafeNo.
	 */
	public String getOthersSafeeNo() {
		return othersSafeeNo;
	}
	/**
	 * @param othersSafeNo The othersSafeNo to set.
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
	
	/**
	 * @return Returns the aresenic.
	 */
	public double getAresenic() {
		return aresenic;
	}
	/**
	 * @param aresenic The aresenic to set.
	 */
	public void setAresenic(double aresenic) {
		this.aresenic = aresenic;
	}
	/**
	 * @return Returns the nitrate.
	 */
	public double getNitrate() {
		return nitrate;
	}
	/**
	 * @param nitrate The nitrate to set.
	 */
	public void setNitrate(double nitrate) {
		this.nitrate = nitrate;
	}
	
	/**
	 * @return Returns the aresenicContamination.
	 */
	public String getAresenicContamination() {
		return aresenicContamination;
	}
	/**
	 * @param aresenicContamination The aresenicContamination to set.
	 */
	public void setAresenicContamination(String aresenicContamination) {
		this.aresenicContamination = aresenicContamination;
	}
	/**
	 * @return Returns the nitrateContamination.
	 */
	public String getNitrateContamination() {
		return nitrateContamination;
	}
	/**
	 * @param nitrateContamination The nitrateContamination to set.
	 */
	public void setNitrateContamination(String nitrateContamination) {
		this.nitrateContamination = nitrateContamination;
	}
	
	public String getDefunctReasons() {
		return defunctReasons;
	}
	public void setDefunctReasons(String defunctReasons) {
		this.defunctReasons = defunctReasons;
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
	
	public String getPipeLength() {
		return pipeLength;
	}
	public void setPipeLength(String pipeLength) {
		this.pipeLength = pipeLength;
	}
	
	/**
	 * @return Returns the wtpShelter.
	 */
	public int getWtpShelter() {
		return wtpShelter;
	}
	/**
	 * @param wtpShelter The wtpShelter to set.
	 */
	public void setWtpShelter(int wtpShelter) {
		this.wtpShelter = wtpShelter;
	}
	
	public String getWtpProductWater() {
		return wtpProductWater;
	}
	public void setWtpProductWater(String wtpProductWater) {
		this.wtpProductWater = wtpProductWater;
	}
	public String getWtpRawWater() {
		return wtpRawWater;
	}
	public void setWtpRawWater(String wtpRawWater) {
		this.wtpRawWater = wtpRawWater;
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
	
	public String getOhsrHabLinkNo() {
		return ohsrHabLinkNo;
	}
	public void setOhsrHabLinkNo(String ohsrHabLinkNo) {
		this.ohsrHabLinkNo = ohsrHabLinkNo;
	}
	
		public int getCurrentRow() {
			return currentRow;
		}
		public void setCurrentRow(int currentRow) {
			this.currentRow = currentRow;
		}
	public String getIsLast() {
		return isLast;
	}
	public void setIsLast(String isLast) {
		this.isLast = isLast;
	}
		public int getRowCount() {
			return rowCount;
		}
		public void setRowCount(int rowCount) {
			this.rowCount = rowCount;
		}
		
	public String getCompExists() {
		return compExists;
	}
	public void setCompExists(String compExists) {
		this.compExists = compExists;
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
	
	public String getDpYield() {
		return dpYield;
	}
	public void setDpYield(String dpYield) {
		this.dpYield = dpYield;
	}
	
	/**
	 * @return Returns the subsurfaceSourceCount.
	 */
	public int getSubsurfaceSourceCount() {
		return subsurfaceSourceCount;
	}
	/**
	 * @param subsurfaceSourceCount The subsurfaceSourceCount to set.
	 */
	public void setSubsurfaceSourceCount(int subsurfaceSourceCount) {
		this.subsurfaceSourceCount = subsurfaceSourceCount;
	}
	/**
	 * @return Returns the surfaceSourceCount.
	 */
	public int getSurfaceSourceCount() {
		return surfaceSourceCount;
	}
	/**
	 * @param surfaceSourceCount The surfaceSourceCount to set.
	 */
	public void setSurfaceSourceCount(int surfaceSourceCount) {
		this.surfaceSourceCount = surfaceSourceCount;
	}

	// code added by sridhar for asset free format report
	private String assettype;
	private String assetstatus;
	private String yrcreation;
	private String costasset;
	private String nofhab;
	private String yrcreationcond;
	private String costassetcond;
	private String nofhabcond;
	private String popbencond;
	private String popben;
	
	// Added by swapna on 08112010
	private int projectexecutedCount;
	private String contractRadio;
    private String divisionRadio;
    private String cName;
    private String workId;
	private String workName;
	private String adminNo;
	private String adminDate;
	private String sancAmount;
	private String dateofCommencement;
	private String stipulateddateofCompletion;
	private String dateofCompletion;
	private String name;
	private String contCode;
	private String agreeValue;
	private String tenderNomination;
    
	/**
	 * @return Returns the costassetcond.
	 */
	public String getCostassetcond() {
		return costassetcond;
	}
	/**
	 * @param costassetcond The costassetcond to set.
	 */
	public void setCostassetcond(String costassetcond) {
		this.costassetcond = costassetcond;
	}
	/**
	 * @return Returns the nofhabcond.
	 */
	public String getNofhabcond() {
		return nofhabcond;
	}
	/**
	 * @param nofhabcond The nofhabcond to set.
	 */
	public void setNofhabcond(String nofhabcond) {
		this.nofhabcond = nofhabcond;
	}
	/**
	 * @return Returns the popbencond.
	 */
	public String getPopbencond() {
		return popbencond;
	}
	/**
	 * @param popbencond The popbencond to set.
	 */
	public void setPopbencond(String popbencond) {
		this.popbencond = popbencond;
	}
	/**
	 * @return Returns the yrcreationcond.
	 */
	public String getYrcreationcond() {
		return yrcreationcond;
	}
	/**
	 * @param yrcreationcond The yrcreationcond to set.
	 */
	public void setYrcreationcond(String yrcreationcond) {
		this.yrcreationcond = yrcreationcond;
	}
	/**
	 * @return Returns the assetstatus.
	 */
	public String getAssetstatus() {
		return assetstatus;
	}
	/**
	 * @param assetstatus The assetstatus to set.
	 */
	public void setAssetstatus(String assetstatus) {
		this.assetstatus = assetstatus;
	}
	/**
	 * @return Returns the assettype.
	 */
	public String getAssettype() {
		return assettype;
	}
	/**
	 * @param assettype The assettype to set.
	 */
	public void setAssettype(String assettype) {
		this.assettype = assettype;
	}
	/**
	 * @return Returns the costasset.
	 */
	public String getCostasset() {
		return costasset;
	}
	/**
	 * @param costasset The costasset to set.
	 */
	public void setCostasset(String costasset) {
		this.costasset = costasset;
	}
	/**
	 * @return Returns the nofhab.
	 */
	public String getNofhab() {
		return nofhab;
	}
	/**
	 * @param nofhab The nofhab to set.
	 */
	public void setNofhab(String nofhab) {
		this.nofhab = nofhab;
	}
	/**
	 * @return Returns the popben.
	 */
	public String getPopben() {
		return popben;
	}
	/**
	 * @param popben The popben to set.
	 */
	public void setPopben(String popben) {
		this.popben = popben;
	}
	/**
	 * @return Returns the yrcreation.
	 */
	public String getYrcreation() {
		return yrcreation;
	}
	/**
	 * @param yrcreation The yrcreation to set.
	 */
	public void setYrcreation(String yrcreation) {
		this.yrcreation = yrcreation;
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
	
	public String getIsLwe() {
		return isLwe;
	}
	public void setIsLwe(String isLwe) {
		this.isLwe = isLwe;
	}
	public String getUnsafeLpcd() {
		return unsafeLpcd;
	}
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
	
	public String getContactNum() {
		return contactNum;
	}
	public void setContactNum(String contactNum) {
		this.contactNum = contactNum;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLabEstablishedYear() {
		return labEstablishedYear;
	}
	public void setLabEstablishedYear(String labEstablishedYear) {
		this.labEstablishedYear = labEstablishedYear;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getLevelCode() {
		return levelCode;
	}
	public void setLevelCode(String levelCode) {
		this.levelCode = levelCode;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getVoterId() {
		return voterId;
	}
	public void setVoterId(String voterId) {
		this.voterId = voterId;
	}
	
	public String getCName() {
		return cName;
	}
	public void setCName(String name) {
		cName = name;
	}
	public String getContractRadio() {
		return contractRadio;
	}
	public void setContractRadio(String contractRadio) {
		this.contractRadio = contractRadio;
	}
	public String getDivisionRadio() {
		return divisionRadio;
	}
	public void setDivisionRadio(String divisionRadio) {
		this.divisionRadio = divisionRadio;
	}
	public int getProjectexecutedCount() {
		return projectexecutedCount;
	}
	public void setProjectexecutedCount(int projectexecutedCount) {
		this.projectexecutedCount = projectexecutedCount;
	}
	
	public String getAdminDate() {
		return adminDate;
	}
	public void setAdminDate(String adminDate) {
		this.adminDate = adminDate;
	}
	public String getAdminNo() {
		return adminNo;
	}
	public void setAdminNo(String adminNo) {
		this.adminNo = adminNo;
	}
	public String getAgreeValue() {
		return agreeValue;
	}
	public void setAgreeValue(String agreeValue) {
		this.agreeValue = agreeValue;
	}
	public String getContCode() {
		return contCode;
	}
	public void setContCode(String contCode) {
		this.contCode = contCode;
	}
	public String getDateofCommencement() {
		return dateofCommencement;
	}
	public void setDateofCommencement(String dateofCommencement) {
		this.dateofCommencement = dateofCommencement;
	}
	public String getDateofCompletion() {
		return dateofCompletion;
	}
	public void setDateofCompletion(String dateofCompletion) {
		this.dateofCompletion = dateofCompletion;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSancAmount() {
		return sancAmount;
	}
	public void setSancAmount(String sancAmount) {
		this.sancAmount = sancAmount;
	}
	public String getStipulateddateofCompletion() {
		return stipulateddateofCompletion;
	}
	public void setStipulateddateofCompletion(String stipulateddateofCompletion) {
		this.stipulateddateofCompletion = stipulateddateofCompletion;
	}
	public String getTenderNomination() {
		return tenderNomination;
	}
	public void setTenderNomination(String tenderNomination) {
		this.tenderNomination = tenderNomination;
	}
	public String getWorkId() {
		return workId;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public String getWorkName() {
		return workName;
	}
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	public String getAccNo() {
		return accNo;
	}
	public void setAccNo(String accNo) {
		this.accNo = accNo;
	}
	public String getBankAbb() {
		return bankAbb;
	}
	public void setBankAbb(String bankAbb) {
		this.bankAbb = bankAbb;
	}
	public String getBankCode() {
		return bankCode;
	}
	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBcode() {
		return bcode;
	}
	public void setBcode(String bcode) {
		this.bcode = bcode;
	}
	public String getBName() {
		return bName;
	}
	public void setBName(String name) {
		bName = name;
	}
	public String getBranchCode() {
		return branchCode;
	}
	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getCircleCode() {
		return circleCode;
	}
	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}
	public String getCircleName() {
		return circleName;
	}
	public void setCircleName(String circleName) {
		this.circleName = circleName;
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
	public String getMicrCode() {
		return micrCode;
	}
	public void setMicrCode(String micrCode) {
		this.micrCode = micrCode;
	}
	public String getOffCode() {
		return offCode;
	}
	public void setOffCode(String offCode) {
		this.offCode = offCode;
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
 * @return Returns the codeSeries.
 */
public String getCodeSeries() {
	return codeSeries;
}
/**
 * @param codeSeries The codeSeries to set.
 */
public void setCodeSeries(String codeSeries) {
	this.codeSeries = codeSeries;
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
	/**
	 * @return Returns the divStatus.
	 */
	public String getDivStatus() {
		return divStatus;
	}
	/**
	 * @param divStatus The divStatus to set.
	 */
	public void setDivStatus(String divStatus) {
		this.divStatus = divStatus;
	}
	public void setSchemesource(String schemesource) {
		this.schemesource = schemesource;
	}
	public String getSchemesource() {
		return schemesource;
	}
	public String getNrdwprelated() {
		return nrdwprelated;
	}
	public void setNrdwprelated(String nrdwprelated) {
		this.nrdwprelated = nrdwprelated;
	}
	public String getImageStatus() {
		return imageStatus;
	}
	public void setImageStatus(String imageStatus) {
		this.imageStatus = imageStatus;
	}
	public String getAgencyCode() {
		return agencyCode;
	}
	public void setAgencyCode(String agencyCode) {
		this.agencyCode = agencyCode;
	}
	public String getAgencyName() {
		return agencyName;
	}
	public void setAgencyName(String agencyName) {
		this.agencyName = agencyName;
	}
	public String getCmcoredb() {
		return cmcoredb;
	}
	public void setCmcoredb(String cmcoredb) {
		this.cmcoredb = cmcoredb;
	}
	public String getProgBelongTo() {
		return progBelongTo;
	}
	public void setProgBelongTo(String progBelongTo) {
		this.progBelongTo = progBelongTo;
	}
	public String getSourceExist() {
		return SourceExist;
	}
	public void setSourceExist(String sourceExist) {
		SourceExist = sourceExist;
	}
	
	
} 