package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class SourceForm extends ActionForm
{
	
//	added by swapna on 19-01-2012 for gis data entry
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
	//
		private String assetTypeCode;
		private String circleOfficeCode;
		private String districtName;
		private String district;
		private String mandal;
		private String pcode;
		private String vcode;
		private String sourceCode;      
		private String sourceName;
		private String sourceTypeCode;
		private String subSourceTypeCode;   
		private String noOfHab;         
		private String habCode; 
		private String sourceDiameter;
		private String seasonal;        
		private String popbenefited;
		private String presentCondition;
		private String waterQuality;
		private String levelOfCont;
		private String staticWaterLevel;
		private String summerWaterLevel;
		private String yield;
		private String distFromSource;
		private String contType;
		private String percent;
		private String location;
		private String assetCode;
		private String addHab;
		private String mode;
		private String type;
		
		private String flouride;
		private String brakish;
		private String iron;
		private String others;
		private String othersType;
		
		
		private String tappingPoint;
		private String sourceDepth;
		private ArrayList sourceAssets;
		private ArrayList contaminations;
		private ArrayList sourceHabs;
		
		private String typeofTreatment;
		private String plantCapacity;
		
		private String opType="";
		
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

	public SourceForm()
	{
		sourceAssets = new ArrayList();
		sourceHabs = new ArrayList();
	}
	
	public ArrayList getSourceAssets() {
		return sourceAssets;
	}
	
	public void setSourceAssets(ArrayList sourceAssets) {
		this.sourceAssets = sourceAssets;
	}
	public AssetSourceBean getSOURCEASSET_LIST(int index)
	{
		while(index >= sourceAssets.size())
		{
			//System.out.println("index in getSOURCEASSET_LIST= "+index);
			sourceAssets.add(new AssetSourceBean());
		}
		return (AssetSourceBean)sourceAssets.get(index);
	}
	
	public HabSourceBean getSOURCEHAB_LIST(int index)
	{
		while(index >= sourceHabs.size())
		{
			//System.out.println("index in getSOURCEHAB_LIST= "+index);
			sourceHabs.add(new HabSourceBean());
			
		}
		return (HabSourceBean)sourceHabs.get(index);
	}
	
	public void setContaminations(ArrayList contaminations)
	{	this.contaminations = contaminations;
	}
	public ArrayList getContaminations()
	{	return contaminations;
	}
	public ContaminationTypes getCONTS(int index)
	{
		while(index >= contaminations.size())
		{
			contaminations.add(new ContaminationTypes());
		}
		return (ContaminationTypes)contaminations.get(index);
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
		 * @return Returns the distFromSource.
		 */
		public String getDistFromSource() {
			return distFromSource;
		}
		/**
		 * @param distFromSource The distFromSource to set.
		 */
		public void setDistFromSource(String distFromSource) {
			this.distFromSource = distFromSource;
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
		 * @return Returns the levelOfCont.
		 */
		public String getLevelOfCont() {
			return levelOfCont;
		}
		/**
		 * @param levelOfCont The levelOfCont to set.
		 */
		public void setLevelOfCont(String levelOfCont) {
			this.levelOfCont = levelOfCont;
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
		 * @return Returns the noOfHab.
		 */
		public String getNoOfHab() {
			 
			return noOfHab;
		}
		/**
		 * @param noOfHab The noOfHab to set.
		 */
		public void setNoOfHab(String noOfHab) {
			 
			this.noOfHab = noOfHab;
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
		 * @return Returns the popbenefited.
		 */
		public String getPopbenefited() {
			return popbenefited;
		}
		/**
		 * @param popbenefited The popbenefited to set.
		 */
		public void setPopbenefited(String popbenefited) {
			this.popbenefited = popbenefited;
		}
		/**
		 * @return Returns the presentCondition.
		 */
		public String getPresentCondition() {
			return presentCondition;
		}
		/**
		 * @param presentCondition The presentCondition to set.
		 */
		public void setPresentCondition(String presentCondition) {
			this.presentCondition = presentCondition;
		}
		/**
		 * @return Returns the seasonal.
		 */
		public String getSeasonal() {
			return seasonal;
		}
		/**
		 * @param seasonal The seasonal to set.
		 */
		public void setSeasonal(String seasonal) {
			this.seasonal = seasonal;
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
		/**
		 * @return Returns the sourceTypeCode.
		 */
		public String getSourceTypeCode() {
			return sourceTypeCode;
		}
		/**
		 * @param sourceTypeCode The sourceTypeCode to set.
		 */
		public void setSourceTypeCode(String sourceTypeCode) {
			this.sourceTypeCode = sourceTypeCode;
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
		 * @return Returns the subSourceTypeCode.
		 */
		public String getSubSourceTypeCode() {
			return subSourceTypeCode;
		}
		/**
		 * @param subSourceTypeCode The subSourceTypeCode to set.
		 */
		public void setSubSourceTypeCode(String subSourceTypeCode) {
			this.subSourceTypeCode = subSourceTypeCode;
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
		 * @return Returns the waterQuality.
		 */
		public String getWaterQuality() {
			return waterQuality;
		}
		/**
		 * @param waterQuality The waterQuality to set.
		 */
		public void setWaterQuality(String waterQuality) {
			this.waterQuality = waterQuality;
		}
		
		/**
		 * @return Returns the yield.
		 */
		public String getYield() {
			return yield;
		}
		/**
		 * @param yield The yield to set.
		 */
		public void setYield(String yield) {
			this.yield = yield;
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
		 * @return Returns the addHab.
		 */
		public String getAddHab() {
			return addHab;
		}
		/**
		 * @param addHab The addHab to set.
		 */
		public void setAddHab(String addHab) {
			this.addHab = addHab;
		}
		
		/**
		 * @return Returns the sourceHabs.
		 */
		public ArrayList getSourceHabs() {
			return sourceHabs;
		}
		
		/**
		 * @return Returns the opType.
		 */
		public String getOpType() {
			return opType;
		}
		/**
		 * @param opType The opType to set.
		 */
		public void setOpType(String opType) {
			this.opType = opType;
		}
		/**
		 * @param sourceHabs The sourceHabs to set.
		 */
		public void setSourceHabs(ArrayList sourceHabs) {
			this.sourceHabs = sourceHabs;
		}
		public void reset(ActionMapping mapping,HttpServletRequest request)
		{
			this.district="";
			this.mandal="";
			this.pcode="";
			this.vcode="";
			this.sourceName="";
			this.sourceTypeCode="";      
			this.subSourceTypeCode="";   
			this.noOfHab="";         
			this.habCode="";        
			this.seasonal="";        
			this.sourceCode="";
			this.presentCondition="";
			this.contType="";        
			this.yield="";           
			this.popbenefited="";    
			this.staticWaterLevel=""; 
			this.summerWaterLevel="";
			this.waterQuality="";
			this.levelOfCont="";
			this.location="";
			this.distFromSource="";
			this.type="";
		}
		public String getType() {
			return type;
		}
		public void setType(String type) {
			this.type = type;
		}
		public String getTappingPoint() {
			return tappingPoint;
		}
		public void setTappingPoint(String tappingPoint) {
			this.tappingPoint = tappingPoint;
		}
		public String getSourceDepth() {
			return sourceDepth;
		}
		public void setSourceDepth(String sourceDepth) {
			this.sourceDepth = sourceDepth;
		}
		public String getSourceDiameter() {
			return sourceDiameter;
		}
		public void setSourceDiameter(String sourceDiameter) {
			this.sourceDiameter = sourceDiameter;
		}
		public String getAssetTypeCode() {
			return assetTypeCode;
		}
		public void setAssetTypeCode(String assetTypeCode) {
			this.assetTypeCode = assetTypeCode;
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
		public String getOthers() {
			return others;
		}
		public void setOthers(String others) {
			this.others = others;
		}
		public String getOthersType() {
			return othersType;
		}
		public void setOthersType(String othersType) {
			this.othersType = othersType;
		}
		public String getCircleOfficeCode() {
			return circleOfficeCode;
		}
		public void setCircleOfficeCode(String circleOfficeCode) {
			this.circleOfficeCode = circleOfficeCode;
		}
		public String getDistrictName() {
			return districtName;
		}
		public void setDistrictName(String districtName) {
			this.districtName = districtName;
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