package nic.watersoft.masters;
 

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Asset_Pumpset
{
//	added by swapna on 20-01-2012 for gis data entry
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
	//
	 private String assetSubCompType; 
	 private String assetCode;
	 private String habCode;
	
	 private String isLast;
   //	PWS-PUMPSETS-CAPACITORS
	 
	 
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

	 //CPWS/pws  PUMPSETS PUMPDETAILS
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
		private String repair_cost_year;
		private String capasitor;
		private String control_panel ;
		private String power_hours   ;
		private String work_hrs    ;
		private String qty_water_cum; 
		private String power_supply_available_hrs;   
  //Handpump Borewell
 		private String location;
		private String drillYear;
	    private String diameter;
	   	private String casing;;
		private String status;
		private String genCondition;
		private String pipeLength;
		private String giNo; 
		private String painted;
		private String staticWl; 
		private String summerWl;
		private String Cond; 
		private String dryDuring; 
		private String service; 
		private String serNo; 
		private String serHrs; 
		private String repairs;  
		private String platFormCondition; 
		private String Drain;   
		private String drainCondition; 
		private String drainSd;  
		private String drainLp;
		private String hygiene;  
		private String avgTime;  
		private String yield;  
		private String yieldLocal; 
		private String period; 
		private String asssetCode; 
		private String depth ;
		private String hpCode ;
		private String othersType="";
		
		// PWS-PUMPSETS-Pump House
		 
		 private String pumpHouseType;
		 private String pumpHouseArea;
		 private String pumpHouseHeight;
		 private String pumpHouseCode;
		 private String pumpCond;
		 
		
		 //MISCELLANEOUS
		 private String otherCompCode;     
		 private String compName;     
		 private String compLocation;     
		 private String remarks;
		 
		 //Chlorination
		 
		 private String workingOrNot;
		 private String bp;
		 private String lc;
		 private String gc;
		 private String od;
		 
		      
		 //PUMPSETS
		 String pumpCode;
		 String pumpLocation;
		 String pumpMake;
		 String pumpType;
		 String pumpCapacity;
		 String pumpYearOfCommissioning;
		 String pumpHoursRunningPerDay;
		 String pumpUsage;
		 String pumpDesignedHead;
		 String pumpDesignedLpm;
		 String pumpControlPanel;
		 String pumpFeeder;
		 String pumpHoursOfPowerAvailability;
		 String pumpLowVoltageProblems;
		 String pumpFeasiblityOfGettingUrbanLine;
		 String pumpAppCostOfUrbanFeeder;
		 String pumpDistanceFromWhereUrbanLineCanBeHad;
		 String pumpLowVoltabeProblems;
		 String pumpRemarks;
		 String pumpSuggestions;
		 private String generatorExisting;
		 private String generatorCapacity;
		 private String generatorWorking;
		 String pumpHabCode;

		 int rowCount;
		 int currentRow;

//		oandm on 090709
			
			private String agencyCode;
			private String assetCost;
			private String powerCost;
			private String consumAnnum;
			private String wagesAnnum;
			private String total3;
			private String sourceFund;
			private String tariffMonth;
			private String standPosts;
			private String houseConn;
			private String total2;
			private String noOfHabs;
			private String oandmCode;
	 
	
	/**
	 * @param pumpdet_code
	 * @param pumpcode
	 * @param hp
	 * @param type
	 * @param duty_con
	 * @param head_mts
	 * @param discharge_lpm
	 * @param standby_hp
	 * @param years_used
	 * @param failure_freq
	 * @param avg_hr_pumping_day
	 * @param repair_cost_year
	 * @param capasitor
	 * @param control_panel
	 * @param power_hours
	 * @param work_hrs
	 * @param qty_water_cum
	 */
	public Asset_Pumpset(String pumpdet_code, String pumpcode, String hp,
			String type, String duty_con, String head_mts,
			String discharge_lpm, String standby_hp, String years_used,
			String failure_freq, String avg_hr_pumping_day,
			String repair_cost_year, String capasitor, String control_panel,
			String power_hours, String work_hrs,String qty_water_cum,String latitude,String longitude,String elevation,String waypoint) {
		super();
		this.pumpdet_code = pumpdet_code;
		this.pumpcode = pumpcode;
		this.hp = hp;
		this.type = type;
		this.duty_con = duty_con;
		this.head_mts = head_mts;
		this.discharge_lpm = discharge_lpm;
		this.standby_hp = standby_hp;
		this.years_used = years_used;
		this.failure_freq = failure_freq;
		this.avg_hr_pumping_day = avg_hr_pumping_day;
		this.repair_cost_year = repair_cost_year;
		this.capasitor = capasitor;
		this.control_panel = control_panel;
		this.power_hours = power_hours;
		this.work_hrs = work_hrs;
		this.qty_water_cum = qty_water_cum;
		//added by swapna on 20-01-2012 for gis  data entry
		this.latitude = latitude;
		this.longitude = longitude;
		this.elevation = elevation;
		this.waypoint =waypoint;
		System.out.println("end of the constrctor pumpsets20-01-2012");
	}
		public Asset_Pumpset()
		{
			
		}
		public String getPumpCapacity() {
			return pumpCapacity;
		}
		public void setPumpCapacity(String pumpCapacity) {
			this.pumpCapacity = pumpCapacity;
		}
		public String getPumpCond() {
			return pumpCond;
		}
		public void setPumpCond(String pumpCond) {
			this.pumpCond = pumpCond;
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
		public String getPumpHouseArea() {
			return pumpHouseArea;
		}
		public void setPumpHouseArea(String pumpHouseArea) {
			this.pumpHouseArea = pumpHouseArea;
		}
		public String getPumpHouseCode() {
			return pumpHouseCode;
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
		public String getPumpType() {
			return pumpType;
		}
		public void setPumpType(String pumpType) {
			this.pumpType = pumpType;
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
		/**
		 * @param assetSubCompType
		 */
		public Asset_Pumpset(String assetSubCompType) {
			super();
			this.assetSubCompType = assetSubCompType;			
		}	  
	
		public String getAssetCode() {
			return assetCode;
		}
		public void setAssetCode(String assetCode) {
			this.assetCode = assetCode;
		}
	public String getAssetSubCompType() {
		return assetSubCompType;
	}
	public void setAssetSubCompType(String assetSubCompType) {
		this.assetSubCompType = assetSubCompType;
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
		public void setPower_supply_available_hrs(
				String power_supply_available_hrs) {
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
		public String getCasing() {
			return casing;
		}
		public void setCasing(String casing) {
			this.casing = casing;
		}
		public String getCond() {
			return Cond;
		}
		public void setCond(String cond) {
			Cond = cond;
		}
		public String getDepth() {
			return depth;
		}
		public void setDepth(String depth) {
			this.depth = depth;
		}
		public String getDiameter() {
			return diameter;
		}
		public void setDiameter(String diameter) {
			this.diameter = diameter;
		}
		public String getDrain() {
			return Drain;
		}
		public void setDrain(String drain) {
			Drain = drain;
		}
		public String getDrainCondition() {
			return drainCondition;
		}
		public void setDrainCondition(String drainCondition) {
			this.drainCondition = drainCondition;
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
		
		public String getDryDuring() {
			return dryDuring;
		}
		public void setDryDuring(String dryDuring) {
			this.dryDuring = dryDuring;
		}
		public String getGenCondition() {
			return genCondition;
		}
		public void setGenCondition(String genCondition) {
			this.genCondition = genCondition;
		}
		public String getGiNo() {
			return giNo;
		}
		public void setGiNo(String giNo) {
			this.giNo = giNo;
		}
		public String getHpCode() {
			return hpCode;
		}
		public void setHpCode(String hpCode) {
			this.hpCode = hpCode;
		}
		public String getHygiene() {
			return hygiene;
		}
		public void setHygiene(String hygiene) {
			this.hygiene = hygiene;
		}
public String getLocation() {
	return location;
}
public void setLocation(String location) {
	this.location = location;
}
		public String getPainted() {
			return painted;
		}
		public void setPainted(String painted) {
			this.painted = painted;
		}
		public String getPeriod() {
			return period;
		}
		public void setPeriod(String period) {
			this.period = period;
		}
		public String getPlatFormCondition() {
			return platFormCondition;
		}
		public void setPlatFormCondition(String platFormCondition) {
			this.platFormCondition = platFormCondition;
		}
		public String getRepairs() {
			return repairs;
		}
		public void setRepairs(String repairs) {
			this.repairs = repairs;
		}
		public String getSerHrs() {
			return serHrs;
		}
		public void setSerHrs(String serHrs) {
			this.serHrs = serHrs;
		}
		public String getSerNo() {
			return serNo;
		}
		public void setSerNo(String serNo) {
			this.serNo = serNo;
		}
		public String getService() {
			return service;
		}
		public void setService(String service) {
			this.service = service;
		}
		public String getStaticWl() {
			return staticWl;
		}
		public void setStaticWl(String staticWl) {
			this.staticWl = staticWl;
		}
		public String getStatus() {
			return status;
		}
		public void setStatus(String status) {
			this.status = status;
		}
		public String getSummerWl() {
			return summerWl;
		}
		public void setSummerWl(String summerWl) {
			this.summerWl = summerWl;
		}
		public String getYield() {
			return yield;
		}
		public void setYield(String yield) {
			this.yield = yield;
		}
		public String getYieldLocal() {
			return yieldLocal;
		}
		public void setYieldLocal(String yieldLocal) {
			this.yieldLocal = yieldLocal;
		}
		public String getDrillYear() {
			return drillYear;
		}
		public void setDrillYear(String drillYear) {
			this.drillYear = drillYear;
		}
		public String getCompLocation() {
			return compLocation;
		}
		public void setCompLocation(String compLocation) {
			this.compLocation = compLocation;
		}
		public String getCompName() {
			return compName;
		}
		public void setCompName(String compName) {
			this.compName = compName;
		}
		public String getOtherCompCode() {
			return otherCompCode;
		}
		public void setOtherCompCode(String otherCompCode) {
			this.otherCompCode = otherCompCode;
		}
		public String getRemarks() {
			return remarks;
		}
		public void setRemarks(String remarks) {
			this.remarks = remarks;
		}
		
		public String getPumpAppCostOfUrbanFeeder() {
			return pumpAppCostOfUrbanFeeder;
		}
		public void setPumpAppCostOfUrbanFeeder(String pumpAppCostOfUrbanFeeder) {
			this.pumpAppCostOfUrbanFeeder = pumpAppCostOfUrbanFeeder;
		}
		public String getPumpDistanceFromWhereUrbanLineCanBeHad() {
			return pumpDistanceFromWhereUrbanLineCanBeHad;
		}
		public void setPumpDistanceFromWhereUrbanLineCanBeHad(
				String pumpDistanceFromWhereUrbanLineCanBeHad) {
			this.pumpDistanceFromWhereUrbanLineCanBeHad = pumpDistanceFromWhereUrbanLineCanBeHad;
		}
		public String getPumpFeasiblityOfGettingUrbanLine() {
			return pumpFeasiblityOfGettingUrbanLine;
		}
		public void setPumpFeasiblityOfGettingUrbanLine(
				String pumpFeasiblityOfGettingUrbanLine) {
			this.pumpFeasiblityOfGettingUrbanLine = pumpFeasiblityOfGettingUrbanLine;
		}
		public String getPumpFeeder() {
			return pumpFeeder;
		}
		public void setPumpFeeder(String pumpFeeder) {
			this.pumpFeeder = pumpFeeder;
		}
		public String getPumpHoursOfPowerAvailability() {
			return pumpHoursOfPowerAvailability;
		}
		public void setPumpHoursOfPowerAvailability(
				String pumpHoursOfPowerAvailability) {
			this.pumpHoursOfPowerAvailability = pumpHoursOfPowerAvailability;
		}
		public String getPumpLowVoltabeProblems() {
			return pumpLowVoltabeProblems;
		}
		public void setPumpLowVoltabeProblems(String pumpLowVoltabeProblems) {
			this.pumpLowVoltabeProblems = pumpLowVoltabeProblems;
		}
		public String getPumpLowVoltageProblems() {
			return pumpLowVoltageProblems;
		}
		public void setPumpLowVoltageProblems(String pumpLowVoltageProblems) {
			this.pumpLowVoltageProblems = pumpLowVoltageProblems;
		}
		public String getPumpRemarks() {
			return pumpRemarks;
		}
		public void setPumpRemarks(String pumpRemarks) {
			this.pumpRemarks = pumpRemarks;
		}
		public String getPumpCode() {
			return pumpCode;
		}
		public void setPumpCode(String pumpCode) {
			this.pumpCode = pumpCode;
		}
	public String getIsLast() {
		return isLast;
	}
	public void setIsLast(String isLast) {
		this.isLast = isLast;
	}
		public String getPumpHabCode() {
			return pumpHabCode;
		}
		public void setPumpHabCode(String pumpHabCode) {
			this.pumpHabCode = pumpHabCode;
		}
		public String getPumpSuggestions() {
			return pumpSuggestions;
		}
		public void setPumpSuggestions(String pumpSuggestions) {
			this.pumpSuggestions = pumpSuggestions;
		}
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	
		public String getOthersType() {
			return othersType;
		}
		public void setOthersType(String othersType) {
			this.othersType = othersType;
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
		
		public String getBp() {
			return bp;
		}
		public void setBp(String bp) {
			this.bp = bp;
		}
		public String getGc() {
			return gc;
		}
		public void setGc(String gc) {
			this.gc = gc;
		}
		public String getLc() {
			return lc;
		}
		public void setLc(String lc) {
			this.lc = lc;
		}
		public String getOd() {
			return od;
		}
		public void setOd(String od) {
			this.od = od;
		}
		public String getWorkingOrNot() {
			return workingOrNot;
		}
		public void setWorkingOrNot(String workingOrNot) {
			this.workingOrNot = workingOrNot;
		}
		
		public String getGeneratorCapacity() {
			return generatorCapacity;
		}
		public void setGeneratorCapacity(String generatorCapacity) {
			this.generatorCapacity = generatorCapacity;
		}
		public String getGeneratorExisting() {
			return generatorExisting;
		}
		public void setGeneratorExisting(String generatorExisting) {
			this.generatorExisting = generatorExisting;
		}
		public String getGeneratorWorking() {
			return generatorWorking;
		}
		public void setGeneratorWorking(String generatorWorking) {
			this.generatorWorking = generatorWorking;
		}
		
		public String getPipeLength() {
			return pipeLength;
		}
		public void setPipeLength(String pipeLength) {
			this.pipeLength = pipeLength;
		}
		
			public String getAgencyCode() {
				return agencyCode;
			}
			public void setAgencyCode(String agencyCode) {
				this.agencyCode = agencyCode;
			}
			public String getAssetCost() {
				return assetCost;
			}
			public void setAssetCost(String assetCost) {
				this.assetCost = assetCost;
			}
			public String getConsumAnnum() {
				return consumAnnum;
			}
			public void setConsumAnnum(String consumAnnum) {
				this.consumAnnum = consumAnnum;
			}
			public String getHouseConn() {
				return houseConn;
			}
			public void setHouseConn(String houseConn) {
				this.houseConn = houseConn;
			}
			public String getNoOfHabs() {
				return noOfHabs;
			}
			public void setNoOfHabs(String noOfHabs) {
				this.noOfHabs = noOfHabs;
			}
			public String getOandmCode() {
				return oandmCode;
			}
			public void setOandmCode(String oandmCode) {
				this.oandmCode = oandmCode;
			}
			public String getPowerCost() {
				return powerCost;
			}
			public void setPowerCost(String powerCost) {
				this.powerCost = powerCost;
			}
			public String getSourceFund() {
				return sourceFund;
			}
			public void setSourceFund(String sourceFund) {
				this.sourceFund = sourceFund;
			}
			public String getTariffMonth() {
				return tariffMonth;
			}
			public void setTariffMonth(String tariffMonth) {
				this.tariffMonth = tariffMonth;
			}
			public String getTotal2() {
				return total2;
			}
			public void setTotal2(String total2) {
				this.total2 = total2;
			}
			public String getTotal3() {
				return total3;
			}
			public void setTotal3(String total3) {
				this.total3 = total3;
			}
			public String getWagesAnnum() {
				return wagesAnnum;
			}
			public void setWagesAnnum(String wagesAnnum) {
				this.wagesAnnum = wagesAnnum;
			}
			
			public String getStandPosts() {
				return standPosts;
			}
			public void setStandPosts(String standPosts) {
				this.standPosts = standPosts;
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
}
