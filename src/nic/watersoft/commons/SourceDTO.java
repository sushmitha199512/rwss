package nic.watersoft.commons;

import java.io.Serializable;



public class SourceDTO implements Serializable
{
	
		private String sourceCode;      
		private String sourceName;
		private String sourceTypeCode;
		private String subSourceTypeCode;   
		private String habCode;
		private String noOfHab;
		private String popbenefited;
		private String seasonal;        
		private String presentCondition;
		private String waterQuality;
		private String staticWaterLevel;
		private String summerWaterLevel;
		private String yield;
		private String distFromSource;
		private String location;
		
	
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
}