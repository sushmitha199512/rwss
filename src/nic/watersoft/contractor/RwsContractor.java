package nic.watersoft.contractor;

import java.io.Serializable;
import java.util.ArrayList;
/**
 * @author venugopal
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

public class RwsContractor implements Serializable
{
	
		private String officeCode;
		private String workId;
		private String workName;
		private String assetTypeCode;
		private String assetTypeName;
		
		
		private String preparedBy;
		private String PreparedOn;
	    private String issueDate;
	    private String noOfWorks;
	    private String typeOfTender;
	    private String tenderType ;
	    private String tenderIdNo;
	    private String closeDate;
	    private ArrayList workComps;
	    private String costOfTender; 
		private String salesTax ;
		private String estContractValue;  
		private String modeOfExecution;
	   
	   
	    
	    private String assetComponentCode;
		private String assetComponent;
		private String assetSubCompTypeCode; 
		private String assetSubCompTypeName;
		private ArrayList workSubComps;
		private String quantity;
		private String unitRate;
		private String amount;
	    
		
		
		
		
		/**
		 * @return Returns the assetSubCompTypeName.
		 */
		public String getAssetSubCompTypeName() {
			return assetSubCompTypeName;
		}
		/**
		 * @param assetSubCompTypeName The assetSubCompTypeName to set.
		 */
		public void setAssetSubCompTypeName(String assetSubCompTypeName) {
			this.assetSubCompTypeName = assetSubCompTypeName;
		}
		/**
		 * @return Returns the assetTypeName.
		 */
		public String getAssetTypeName() {
			return assetTypeName;
		}
		/**
		 * @param assetTypeName The assetTypeName to set.
		 */
		public void setAssetTypeName(String assetTypeName) {
			this.assetTypeName = assetTypeName;
		}
	    /**
	     * Get workId
	     * @return String
	     */
	    public String getWorkId() {
	        return workId;
	    }
		/**
		 * @return Returns the workComps.
		 */
		public ArrayList getWorkComps() {
			return workComps;
		}
		/**
		 * @param workComps The workComps to set.
		 */
		public void setWorkComps(ArrayList workComps) {
			this.workComps = workComps;
		}
	    /**
	     * Set workId
	     * @param <code>String</code>
	     */
	    public void setWorkId(String w) {
	        this.workId = w;
	    }
	    /**
	     * Get issueDate
	     * @return String
	     */
	    public String getIssueDate() {
	        return issueDate;
	    }
	    /**
	     * Set issueDate
	     * @param <code>String</code>
	     */
	    public void setIssueDate(String i) {
	        this.issueDate = i;
	    }
	    /**
	     * Get noOfWorks
	     * @return String
	     */
	    public String getNoOfWorks() {
	        return noOfWorks;
	    }
	    /**
	     * Set noOfWorks
	     * @param <code>String</code>
	     */
	    public void setNoOfWorks(String n) {
	        this.noOfWorks = n;
	    }
	    /**
	     * Get typeOfTender
	     * @return String
	     */
	    public String getTypeOfTender() {
	        return typeOfTender;
	    }
	    /**
	     * Set typeOfTender
	     * @param <code>String</code>
	     */
	    public void setTypeOfTender(String t) {
	        this.typeOfTender = t;
	    }
	    /**
	     * Get tenderIdNo
	     * @return String
	     */
	    public String getTenderIdNo() {
	        return tenderIdNo;
	    }
	    /**
	     * Set tenderIdNo
	     * @param <code>String</code>
	     */
	    public void setTenderIdNo(String t) {
	        this.tenderIdNo = t;
	    }
	    /**
	     * Get closeDate
	     * @return String
	     */
	    public String getCloseDate() {
	        return closeDate;
	    }
	    /**
	     * Set closeDate
	     * @param <code>String</code>
	     */
	    public void setCloseDate(String c) {
	        this.closeDate = c;
	    }

		/**
		 * @return Returns the assetTypeCode.
		 */
		public String getAssetTypeCode() {
			return assetTypeCode;
		}
		/**
		 * @param assetTypeCode The assetTypeCode to set.
		 */
		public void setAssetTypeCode(String assetTypeCode) {
			this.assetTypeCode = assetTypeCode;
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
		 * @return Returns the preparedBy.
		 */
		public String getPreparedBy() {
			return preparedBy;
		}
		/**
		 * @param preparedBy The preparedBy to set.
		 */
		public void setPreparedBy(String preparedBy) {
			this.preparedBy = preparedBy;
		}
		/**
		 * @return Returns the preparedOn.
		 */
		public String getPreparedOn() {
			return PreparedOn;
		}
		/**
		 * @param preparedOn The preparedOn to set.
		 */
		public void setPreparedOn(String preparedOn) {
			PreparedOn = preparedOn;
		}
		
		/**
		 * @return Returns the workName.
		 */
		public String getWorkName() {
			return workName;
		}
		/**
		 * @param workName The workName to set.
		 */
		public void setWorkName(String workName) {
			this.workName = workName;
		}
		/**
		 * @return Returns the amount.
		 */
		public String getAmount() {
			return amount;
		}
		/**
		 * @param amount The amount to set.
		 */
		public void setAmount(String amount) {
			this.amount = amount;
		}
		/**
		 * @return Returns the assetComponent.
		 */
		public String getAssetComponent() {
			return assetComponent;
		}
		/**
		 * @param assetComponent The assetComponent to set.
		 */
		public void setAssetComponent(String assetComponent) {
			this.assetComponent = assetComponent;
		}
		/**
		 * @return Returns the assetComponentCode.
		 */
		public String getAssetComponentCode() {
			return assetComponentCode;
		}
		/**
		 * @param assetComponentCode The assetComponentCode to set.
		 */
		public void setAssetComponentCode(String assetComponentCode) {
			this.assetComponentCode = assetComponentCode;
		}
		/**
		 * @return Returns the assetSubCompTypeCode.
		 */
		public String getAssetSubCompTypeCode() {
			return assetSubCompTypeCode;
		}
		/**
		 * @param assetSubCompTypeCode The assetSubCompTypeCode to set.
		 */
		public void setAssetSubCompTypeCode(String assetSubCompTypeCode) {
			this.assetSubCompTypeCode = assetSubCompTypeCode;
		}
		/**
		 * @return Returns the quantity.
		 */
		public String getQuantity() {
			return quantity;
		}
		/**
		 * @param quantity The quantity to set.
		 */
		public void setQuantity(String quantity) {
			this.quantity = quantity;
		}
		/**
		 * @return Returns the unitRate.
		 */
		public String getUnitRate() {
			return unitRate;
		}
		/**
		 * @param unitRate The unitRate to set.
		 */
		public void setUnitRate(String unitRate) {
			this.unitRate = unitRate;
		}
		/**
		 * @return Returns the workSubComps.
		 */
		public ArrayList getWorkSubComps() {
			return workSubComps;
		}
		/**
		 * @param workSubComps The workSubComps to set.
		 */
		public void setWorkSubComps(ArrayList workSubComps) {
			this.workSubComps = workSubComps;
		}
			
		/**
		 * @return Returns the tenderType.
		 */
		public String getTenderType() {
			return tenderType;
		}
		/**
		 * @param tenderType The tenderType to set.
		 */
		public void setTenderType(String tenderType) {
			this.tenderType = tenderType;
		}
		
		
		/**
		 * @return Returns the costOfTender.
		 */
		public String getCostOfTender() {
			return costOfTender;
		}
		/**
		 * @param costOfTender The costOfTender to set.
		 */
		public void setCostOfTender(String costOfTender) {
			this.costOfTender = costOfTender;
		}
		/**
		 * @return Returns the estContractValue.
		 */
		public String getEstContractValue() {
			return estContractValue;
		}
		/**
		 * @param estContractValue The estContractValue to set.
		 */
		public void setEstContractValue(String estContractValue) {
			this.estContractValue = estContractValue;
		}
		/**
		 * @return Returns the modeOfExecution.
		 */
		public String getModeOfExecution() {
			return modeOfExecution;
		}
		/**
		 * @param modeOfExecution The modeOfExecution to set.
		 */
		public void setModeOfExecution(String modeOfExecution) {
			this.modeOfExecution = modeOfExecution;
		}
		/**
		 * @return Returns the salesTax.
		 */
		public String getSalesTax() {
			return salesTax;
		}
		/**
		 * @param salesTax The salesTax to set.
		 */
		public void setSalesTax(String salesTax) {
			this.salesTax = salesTax;
		}
	}

     

