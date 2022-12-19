package nic.watersoft.masters;
import java.io.Serializable;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Asset_SubComponent implements Serializable
{
//	added by swapna on 20-01-2012 for gis data entry
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
	//
	private String habCode;
	private String assetCode; 
	private String assetSubCompType;
	 private String location;
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
	 private String qualityAffected;
	 private double flouride;
	 private double brakish;
	 private double iron;
	 private int depth;
	 private String otherspecify;
	 private String othersType;
	 private String others;
	 
	 // PWS Borewell Parameters
	 
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
	 private String number;
	 private String total_hp;
	 private String stand_by_numbers;
	 private String stand_by_total_hp;
	 
	 private String standByPumpCapacity;
	 private String standByPumpNo ;
	 private String pmpCode; 
	 private String hpCode; 
//	code added by pranavi
	 private String habitation;
	 public String getHabitation() {
		return habitation;
		}
		public void setHabitation(String habitation) {
			this.habitation = habitation;
		}
	//end of code added by pranavi 
	 
	//added by ramesh
		
	private String isLast;
	int rowCount;
	int currentRow;

	public Asset_SubComponent()
	{
		
	}
	  
	
	 
	/**
	 * @param assetSubCompType
	 */
	public Asset_SubComponent(String assetSubCompType) {
		super();
		this.assetSubCompType = assetSubCompType;
	}
	/**
	 * @param yearOfDrilling
	 * @param diameter
	 * @param casing
	 * @param status
	 * @param genCondition
	 * @param gino
	 * @param painted
	 * @param staticWaterLevel
	 * @param summerWaterLevel
	 * @param pcond
	 * @param dryduring
	 * @param service
	 * @param serno
	 * @param serhrs
	 * @param repairs
	 * @param platformCondition
	 * @param drain
	 * @param drainCondition
	 * @param drainsd
	 * @param drainlp
	 * @param hygiene
	 * @param avgtime
	 * @param pyield
	 * @param pyieldLocal
	 * @param period
	 */
	//updated by swapna on 20-01-2012 for gis data entry
	//,String latitude,String longitude,String elevation,String waypoint
	public Asset_SubComponent(String location,String yearOfDrilling, String diameter,
			String casing, String status, String genCondition, String gino,
			String painted, String staticWaterLevel, String summerWaterLevel,
			String pcond, String dryduring, String service, String serno,
			String serhrs, String repairs, String platformCondition,
			String drain, String drainCondition, String drainsd,
			String drainlp, String hygiene, String avgtime, String pyield,
			String pyieldLocal, String period,String qualityAffected, 
			double flouride, double brakish, double iron,int depth,
			String hpCode,String assetCode,String otherspecify,String pipeLength ) {
		 
		this.location = location;
		this.yearOfDrilling = yearOfDrilling;
		this.diameter = diameter;
		this.casing = casing;
		this.status = status;
		this.genCondition = genCondition;
		this.gino = gino;
		this.painted = painted;
		this.staticWaterLevel = staticWaterLevel;
		this.summerWaterLevel = summerWaterLevel;
		this.pcond = pcond;
		this.dryduring = dryduring;
		this.service = service;
		this.serno = serno;
		this.serhrs = serhrs;
		this.repairs = repairs;
		this.platformCondition = platformCondition;
		this.drain = drain;
		this.drainCondition = drainCondition;
		this.drainsd = drainsd;
		this.drainlp = drainlp;
		this.hygiene = hygiene;
		this.avgtime = avgtime;
		this.pyield = pyield;
		this.pyieldLocal = pyieldLocal;
		this.period = period;
		this.qualityAffected=qualityAffected;
		this.flouride=flouride;
		this.brakish=brakish;
		this.iron=iron;
		this.depth=depth;
		this.hpCode=hpCode;
		this.assetCode=assetCode;
		this.otherspecify=otherspecify;
		this.pipeLength = pipeLength;
	}
	
	
	
	/**
	 * @param popDes
	 * @param source
	 * @param sourceQuality
	 * @param sourceYield
	 * @param sourceDepend
	 * @param sourceDepth
	 * @param sourceDiameter
	 * @param sourceCondition
	 * @param sourceSwl
	 * @param sourceNwl
	 * @param phSize
	 * @param phCondition
	 * @param phType
	 * @param pumpName
	 * @param pumpCapacity
	 * @param pumpType
	 * @param purYear
	 * @param hrRun
	 * @param hrSin
	 * @param hrMs
	 * @param staExe
	 * @param pumpDutyLpm
	 * @param pumpDutyHead
	 */
	public Asset_SubComponent(String popDes, String source,
			String sourceQuality, String sourceYield, String sourceDepend,
			String sourceDepth, String sourceDiameter, String sourceCondition,
			String sourceSwl, String sourceNwl, String phSize,
			String phCondition, String phType, String pumpName,
			String pumpCapacity, String pumpType, String purYear, String hrRun,
			String hrSin, String hrMs, String staExe, String pumpDutyLpm,
			String pumpDutyHead,String ifNss,String pumpNo,String standByPumpCapacity,
			String standByPumpNo,String pmpCode) {
		//super();
		this.popDes = popDes;
		this.source = source;
		this.sourceQuality = sourceQuality;
		this.sourceYield = sourceYield;
		this.sourceDepend = sourceDepend;
		this.sourceDepth = sourceDepth;
		this.sourceDiameter = sourceDiameter;
		this.sourceCondition = sourceCondition;
		this.sourceSwl = sourceSwl;
		this.sourceNwl = sourceNwl;
		this.phSize = phSize;
		this.phCondition = phCondition;
		this.phType = phType;
		this.pumpName = pumpName;
		this.pumpCapacity = pumpCapacity;
		this.pumpType = pumpType;
		this.purYear = purYear;
		this.hrRun = hrRun;
		this.hrSin = hrSin;
		this.hrMs = hrMs;
		this.staExe = staExe;
		this.pumpDutyLpm = pumpDutyLpm;
		this.pumpDutyHead = pumpDutyHead;
		this.ifNss = ifNss;
		this.pumpNo = pumpNo;
		this.standByPumpCapacity = standByPumpCapacity;
		this.standByPumpNo = standByPumpNo;
		this.pmpCode = pmpCode;
		
		
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
	/**
	 * @return Returns the staticWaterLevel.
	 */
	public String getStaticWaterLevel() {
		return staticWaterLevel;
	}
	/**
	 * @param staticWaterLevel The staticWaterLevel to set.
	 */
	public void setStaticWaterLevel(String staticWaterLevel) {
		this.staticWaterLevel = staticWaterLevel;
	}
	/**
	 * @return Returns the status.
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status The status to set.
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return Returns the summerWaterLevel.
	 */
	public String getSummerWaterLevel() {
		return summerWaterLevel;
	}
	/**
	 * @param summerWaterLevel The summerWaterLevel to set.
	 */
	public void setSummerWaterLevel(String summerWaterLevel) {
		this.summerWaterLevel = summerWaterLevel;
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
	 * @return Returns the depth.
	 */
	public int getDepth() {
		return depth;
	}
	/**
	 * @param depth The depth to set.
	 */
	public void setDepth(int depth) {
		this.depth = depth;
	}
	/**
	 * @return Returns the location.
	 */
	public String getLocation() {
		return location;
	}
	/**
	 * @param location The location to set.
	 */
	public void setLocation(String location) {
		this.location = location;
	}
	/**
	 * @return Returns the qualityAffected.
	 */
	public String getQualityAffected() {
		return qualityAffected;
	}
	/**
	 * @param qualityAffected The qualityAffected to set.
	 */
	public void setQualityAffected(String qualityAffected) {
		this.qualityAffected = qualityAffected;
	}
	/**
	 * @return Returns the yearOfDrilling.
	 */
	public String getYearOfDrilling() {
		return yearOfDrilling;
	}
	/**
	 * @param yearOfDrilling The yearOfDrilling to set.
	 */
	public void setYearOfDrilling(String yearOfDrilling) {
		this.yearOfDrilling = yearOfDrilling;
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
	

	/**
	 * @return Returns the ifNss.
	 */
	public String getIfNss() {
		return ifNss;
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
	/**
	 * @param ifNss The ifNss to set.
	 */
	public void setIfNss(String ifNss) {
		this.ifNss = ifNss;
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
	public String getOthers() {
		return others;
	}
	public void setOthers(String others) {
		this.others = others;
	}
	
	public String getPipeLength() {
		return pipeLength;
	}
	public void setPipeLength(String pipeLength) {
		this.pipeLength = pipeLength;
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
