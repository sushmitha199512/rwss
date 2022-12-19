package nic.watersoft.masters;

import java.util.ArrayList;


/**
* @author Administrator
*
* TODO To change the template for this generated type comment go to
* Window - Preferences - Java - Code Style - Code Templates
*/
public class Asset_Reservior
{
	//added by swapna on 18-01-2012 for gis data entry
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
	//
	 private String assetCode="";
	 private String habCode;
	 private java.util.ArrayList selectedHabLinks;
	 
	 // RESERVOIRS OHSR Parameters
	 private String assetSubCompType; 
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
	 private String noOfFillings;
	 private String noOfHab;
	 
	 
	 
	 // PWS Cisterns
	 
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
	 
	 
	 // CPWS OHSR Params
	 
	 private String ohsrCode;
	 private String ohsrStages;
	 private String ohsrLwl;
	 private String ohsrMwl;
	 
	 //CPWS OHBR Params
	 
	 private String ohbrCode;
	 private String ohbrCapacityLts;
	 private String ohbrLocation;
	 private String ohbrStages;
	 private String ohbrLwl;
	 private String ohbrMwl;
	 private String ohbrFillHrs;
	 private String ohbrEmptyHrs;
	 
	 // CPWS/pws GLSR Params
	 
	 private String glsrCode;
	 private String glsrCapacityInLts;
	 private String glsrLocation;
	 private String glsrStages;
	 private String glsrLwl;
	 private String glsrMwl;
	 private String glsrFillHrs;
	 private String glsrEmptyHrs;
	 private String glsrMade;
	 private String glsrCondition;
	 private String glsrDraCondition;
	 private String glsrHygiene;
	 private String glsrnoOfFillings;
	 private String glsrNo;
	 //CPWS GLBR params
	 
	 private String GlbrCode;
	 private String glbrLocation;
	 private String glbrCapacityInLts;
	 private String glbrLwl;
	 private String glbrMwl;
	 private String glbrFillHrs;
	 private String glbrEmptyHrs;
	 
	 //CPWS-SR.Reservoirs-BPT
	 
	 private String bptCode;
	 private String bptLocation;
	 private String bptCapacity;
	 private String bptStaging;
	 private String bptMaxwl;
	 private String bptMinwl;
	
	 
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
	 private String imageStatus;
	 
	 private String standPostCode;//bhagya on24072017
	 private String standPostName;
	 private String spLocation;
	 private String spRemarks;
	 private String spUpdate_Date;
	
	 
	 
	 
	 
		public Asset_Reservior()
		{
			selectedHabLinks=new ArrayList();
		}
		/**
		 * @param assetSubCompType
		 */
		public Asset_Reservior(String assetSubCompType) {
			super();
			this.assetSubCompType = assetSubCompType;
			
			
		}	  
	 /**
	 * @return Returns the assetSubComp
	 */
	 
	 /**
		 * @param ohsrNo
		 * @param ohrsLts
		 * @param ohsrLocation
		 * @param ohsrCapacityLts
		 * @param ohsrMade
		 * @param ohsrHt
		 * @param ohsrCond
		 * @param ohsrFillHrs
		 * @param ohsrEmptyHrs
		 * @param ohsrHygiene
		 * @param ohsrFen
		 */
		public Asset_Reservior(String ohsrNo, String ohrsLts,
				String ohsrLocation, String ohsrCapacityLts, String ohsrMade,
				String ohsrHt, String ohsrCond, String ohsrFillHrs,
				String ohsrEmptyHrs, String ohsrHygiene, String ohsrFen) {
			super();
			this.ohsrNo = ohsrNo;
			this.ohrsLts = ohrsLts;
			this.ohsrLocation = ohsrLocation;
			this.ohsrCapacityLts = ohsrCapacityLts;
			this.ohsrMade = ohsrMade;
			this.ohsrHt = ohsrHt;
			this.ohsrCond = ohsrCond;
			this.ohsrFillHrs = ohsrFillHrs;
			this.ohsrEmptyHrs = ohsrEmptyHrs;
			this.ohsrHygiene = ohsrHygiene;
			this.ohsrFen = ohsrFen;
			
			//System.out.println("IN OHSR");
		}
					
	/**
	 * @param ohsrCode
	 * @param ohsrCapacityLts
	 * @param ohsrLocation
	 * @param ohsrStages
	 * @param ohsrLwl
	 * @param ohsrMwl
	 * @param ohsrFillHrs
	 * @param ohsrEmptyHrs
	 * @param ohbrCode
	 * @param ohbrCapacityLts
	 * @param ohbrLocation
	 * @param ohbrStages
	 * @param ohbrLwl
	 * @param ohbrMwl
	 * @param ohbrFillHrs
	 * @param ohbrEmptyHrs
	 * @param glsrCode
	 * @param glsrCapacityInLts
	 * @param glsrLocation
	 * @param glsrStages
	 * @param glsrLwl
	 * @param glsrMwl
	 * @param glsrFillHrs
	 * @param glsrEmptyHrs

	 */
	public Asset_Reservior(String Code, String CapacityLts,
			String Location, String Stages, String Lwl,
			String Mwl, String FillHrs, String EmptyHrs,int id) {
		super();
		
		if(id==1)
		{
			this.ohsrLocation = Location;
			this.ohsrCapacityLts = CapacityLts;
			this.ohsrFillHrs = FillHrs;
			this.ohsrEmptyHrs = EmptyHrs;
			this.ohsrCode = Code;
			this.ohsrStages = Stages;
			this.ohsrLwl = Lwl;
			this.ohsrMwl = Mwl;	
		}
		else if(id==2)
		{
		    this.ohbrCode = Code;
		    this.ohbrCapacityLts = CapacityLts;
		    this.ohbrLocation = Location;
		    this.ohbrStages = Stages;
		    this.ohbrLwl = Lwl;
		    this.ohbrMwl = Mwl;
		    this.ohbrFillHrs = FillHrs;
		 	this.ohbrEmptyHrs = EmptyHrs;
		}	
		else if(id==3)
		{
			this.glsrCode = Code;
			this.glsrCapacityInLts = CapacityLts;
			this.glsrLocation = Location;
			this.glsrStages = Stages;
			this.glsrLwl = Lwl;
			this.glsrMwl = Mwl;
			this.glsrFillHrs = FillHrs;
			this.glsrEmptyHrs = EmptyHrs;
		}
		else
		{
			this.ohsrLocation = Location;
			this.ohsrCapacityLts = CapacityLts;
			this.ohsrFillHrs = FillHrs;
			this.ohsrEmptyHrs = EmptyHrs;
			this.ohsrCode = Code;
			this.ohsrLwl = Lwl;
			this.ohsrMwl = Mwl;
		}
	}
	/**
	 * @param glsrNo
	 * @param glsrLocation
	 * @param glsrCapacityInLts
	 * @param glsrMade
	 * @param glsrCondition
	 * @param glsrFillHrs
	 * @param glsrEmptyHrs
	 * @param glsrDraCondition
	 * @param glsrHygiene
	 */
	public Asset_Reservior(String glsrNo, String glsrLocation,
			String glsrCapacityInLts, String glsrMade, String glsrCondition,
			String glsrFillHrs, String glsrEmptyHrs, String glsrDraCondition,
			String glsrHygiene,String noOfFillings) 
	{
		super();
		this.glsrCode = glsrNo;
		this.glsrLocation = glsrLocation;
		this.glsrCapacityInLts = glsrCapacityInLts;
		this.glsrMade = glsrMade;
		this.glsrCondition = glsrCondition;
		this.glsrFillHrs = glsrFillHrs;
		this.glsrEmptyHrs = glsrEmptyHrs;
		this.glsrDraCondition = glsrDraCondition;
		this.glsrHygiene = glsrHygiene;
		this.glsrnoOfFillings=noOfFillings;
	}
	
	
	
	
	
	/**
	 * @param glbrCode
	 * @param glbrLocation
	 * @param glbrCapacityInLts
	 * @param glbrLwl
	 * @param glbrMwl
	 * @param glbrFillHrs
	 * @param glbrEmptyHrs
	 */
	public Asset_Reservior(String glbrCode, String glbrLocation,
			String glbrCapacityInLts, String glbrLwl, String glbrMwl,
			String glbrFillHrs, String glbrEmptyHrs) {
		super();
		GlbrCode = glbrCode;
		this.glbrLocation = glbrLocation;
		this.glbrCapacityInLts = glbrCapacityInLts;
		this.glbrLwl = glbrLwl;
		this.glbrMwl = glbrMwl;
		this.glbrFillHrs = glbrFillHrs;
		this.glbrEmptyHrs = glbrEmptyHrs;
	}
	
	/**
	 * @return Returns the noOfFillings.
	 */
	public String getNoOfFillings() {
		return noOfFillings;
	}
	/**
	 * @param noOfFillings The noOfFillings to set.
	 */
	public void setNoOfFillings(String noOfFillings) {
		this.noOfFillings = noOfFillings;
	}
	/**
	 * @return Returns the assetCode.
	 */
	public String getAssetCode() {
		return assetCode;
	}
	/**
	 * @param assetCode The assetCode to set.
	 */
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
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
		/**
		 * @return Returns the ohsrNo.
		 */
		public String getOhsrNo() {
			return ohsrNo;
		}
		/**
		 * @param ohsrNo The ohsrNo to set.
		 */
		public void setOhsrNo(String ohsrNo) {
			this.ohsrNo = ohsrNo;
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
	 * @return Returns the assetSubCompType.
	 */
	public String getAssetSubCompType() {
		return assetSubCompType;
	}
	/**
	 * @param assetSubCompType The assetSubCompType to set.
	 */
	public void setAssetSubCompType(String assetSubCompType) {
		this.assetSubCompType = assetSubCompType;
	}
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
	public String getGlsrCondition() {
		return glsrCondition;
	}
	public void setGlsrCondition(String glsrCondition) {
		this.glsrCondition = glsrCondition;
	}
	public String getGlsrDraCondition() {
		return glsrDraCondition;
	}
	public void setGlsrDraCondition(String glsrDraCondition) {
		this.glsrDraCondition = glsrDraCondition;
	}
	public String getGlsrHygiene() {
		return glsrHygiene;
	}
	public void setGlsrHygiene(String glsrHygiene) {
		this.glsrHygiene = glsrHygiene;
	}
	public String getGlsrMade() {
		return glsrMade;
	}
	public void setGlsrMade(String glsrMade) {
		this.glsrMade = glsrMade;
	}
	 
	public String getGlsrNoOfFillings() {
		return glsrnoOfFillings;
	}
	public void setGlsrNoOfFillings(String noOfFillings) {
		this.glsrnoOfFillings = noOfFillings;
	}
	
	//PWS Cistrens	
	public String getCisCapLts() {
		return cisCapLts;
	}
	public void setCisCapLts(String cisCapLts) {
		this.cisCapLts = cisCapLts;
	}
	public String getCisCond() {
		return cisCond;
	}
	public void setCisCond(String cisCond) {
		this.cisCond = cisCond;
	}
	public String getCisDrain() {
		return cisDrain;
	}
	public void setCisDrain(String cisDrain) {
		this.cisDrain = cisDrain;
	}
	public String getCisHr() {
		return cisHr;
	}
	public void setCisHr(String cisHr) {
		this.cisHr = cisHr;
	}
	public String getCisLocation() {
		return cisLocation;
	}
	public void setCisLocation(String cisLocation) {
		this.cisLocation = cisLocation;
	}
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
	public void setCisNo(String cisNo) {
		this.cisNo = cisNo;
	}
	public String getCisPf() {
		return cisPf;
	}
	public void setCisPf(String cisPf) {
		this.cisPf = cisPf;
	}
	public String getCisPfCond() {
		return cisPfCond;
	}
	public void setCisPfCond(String cisPfCond) {
		this.cisPfCond = cisPfCond;
	}
	public String getCisTap() {
		return cisTap;
	}
	public void setCisTap(String cisTap) {
		this.cisTap = cisTap;
	}
	public String getCisTapCond() {
		return cisTapCond;
	}
	public void setCisTapCond(String cisTapCond) {
		this.cisTapCond = cisTapCond;
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
	 * @return Returns the ifNss.
	 */
	public String getIfNss() {
		return ifNss;
	}
	/**
	 * @param ifNss The ifNss to set.
	 */
	public void setIfNss(String ifNss) {
		this.ifNss = ifNss;
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
	 * @return Returns the pmpCode.
	 */
	public String getPmpCode() {
		return pmpCode;
	}
	/**
	 * @param pmpCode The pmpCode to set.
	 */
	public void setPmpCode(String pmpCode) {
		this.pmpCode = pmpCode;
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
	 * @return Returns the pumpNo.
	 */
	public String getPumpNo() {
		return pumpNo;
	}
	/**
	 * @param pumpNo The pumpNo to set.
	 */
	public void setPumpNo(String pumpNo) {
		this.pumpNo = pumpNo;
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
	/**
	 * @return Returns the standByPumpCapacity.
	 */
	public String getStandByPumpCapacity() {
		return standByPumpCapacity;
	}
	/**
	 * @param standByPumpCapacity The standByPumpCapacity to set.
	 */
	public void setStandByPumpCapacity(String standByPumpCapacity) {
		this.standByPumpCapacity = standByPumpCapacity;
	}
	/**
	 * @return Returns the standByPumpNo.
	 */
	public String getStandByPumpNo() {
		return standByPumpNo;
	}
	/**
	 * @param standByPumpNo The standByPumpNo to set.
	 */
	public void setStandByPumpNo(String standByPumpNo) {
		this.standByPumpNo = standByPumpNo;
	}
	public String getBptLocation() {
		return bptLocation;
	}
	public void setBptLocation(String bptLocation) {
		this.bptLocation = bptLocation;
	}
	
	public String getCisNoOfTaps() {
		return cisNoOfTaps;
	}
	public void setCisNoOfTaps(String cisNoOfTaps) {
		this.cisNoOfTaps = cisNoOfTaps;
	}
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	public String getNoOfHab() {
		return noOfHab;
	}
	public void setNoOfHab(String noOfHab) {
		this.noOfHab = noOfHab;
	}
	public java.util.ArrayList getSelectedHabLinks() {
		return selectedHabLinks;
	}
	public void setSelectedHabLinks(java.util.ArrayList selectedHabLinks) {
		this.selectedHabLinks = selectedHabLinks;
	}
	
	public String getOhsrHabLinkNo() {
		return ohsrHabLinkNo;
	}
	public void setOhsrHabLinkNo(String ohsrHabLinkNo) {
		this.ohsrHabLinkNo = ohsrHabLinkNo;
	}
	/**
	 * @return Returns the elevation.
	 */
	public String getElevation() {
		return elevation;
	}
	/**
	 * @param elevation The elevation to set.
	 */
	public void setElevation(String elevation) {
		this.elevation = elevation;
	}
	/**
	 * @return Returns the glsrnoOfFillings.
	 */
	public String getGlsrnoOfFillings() {
		return glsrnoOfFillings;
	}
	/**
	 * @param glsrnoOfFillings The glsrnoOfFillings to set.
	 */
	public void setGlsrnoOfFillings(String glsrnoOfFillings) {
		this.glsrnoOfFillings = glsrnoOfFillings;
	}
	/**
	 * @return Returns the latitude.
	 */
	public String getLatitude() {
		return latitude;
	}
	/**
	 * @param latitude The latitude to set.
	 */
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	/**
	 * @return Returns the longitude.
	 */
	public String getLongitude() {
		return longitude;
	}
	/**
	 * @param longitude The longitude to set.
	 */
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	/**
	 * @return Returns the waypoint.
	 */
	public String getWaypoint() {
		return waypoint;
	}
	/**
	 * @param waypoint The waypoint to set.
	 */
	public void setWaypoint(String waypoint) {
		this.waypoint = waypoint;
	}
	public String getImageStatus() {
		return imageStatus;
	}
	public void setImageStatus(String imageStatus) {
		this.imageStatus = imageStatus;
	}
	public String getStandPostCode() {
		return standPostCode;
	}
	public void setStandPostCode(String standPostCode) {
		this.standPostCode = standPostCode;
	}
	public String getStandPostName() {
		return standPostName;
	}
	public void setStandPostName(String standPostName) {
		this.standPostName = standPostName;
	}
	public String getSpLocation() {
		return spLocation;
	}
	public void setSpLocation(String spLocation) {
		this.spLocation = spLocation;
	}
	public String getSpRemarks() {
		return spRemarks;
	}
	public void setSpRemarks(String spRemarks) {
		this.spRemarks = spRemarks;
	}
	public String getSpUpdate_Date() {
		return spUpdate_Date;
	}
	public void setSpUpdate_Date(String spUpdate_Date) {
		this.spUpdate_Date = spUpdate_Date;
	}
	
	
}

