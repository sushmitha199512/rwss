/*
 * Created on 27-Feb-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;

import java.io.Serializable;

/**
 * @author NIC(Sai Prasad N)
 * 
 * Created bean for daily transport
 */
public class DialyDroughtDetailsBean implements Serializable {

	
	String habCode;
	String habName;

	String dateOfEntry;

	String dateEntered;

	int  transportPopulationServed;
	int hiringPopulationServed;

	float noOfTrips;

	float tanker_Capacity;

	float tanker_QTY;

	String tanker_Remarks;

	String assetType;

	int pvtSourceHiredNo;

	float  pvtSourceQTY;

	String pvtModeOfSupply;

	String pvtRemarks;

	String powerProblemType;

	String powerSupplyRemarks;
	
	String checks;
	
	boolean isUpdate;
	
	 String mandal;
	  String mandals;
	
	  double tankerCostPerTrip;
	  double tankerCost;
	
	  int  cattle_transportPopulationServed;
		

		float cattle_noOfTrips;

		float cattle_tanker_Capacity;

		float cattle_tanker_QTY;

		String cattle_tanker_Remarks;
		double cattle_tankerCostPerTrip;
		  double cattle_tankerCost;
	
	
	
	
	
	
	
	
	
	
	

	public double getTankerCostPerTrip() {
			return tankerCostPerTrip;
		}
		public void setTankerCostPerTrip(double tankerCostPerTrip) {
			this.tankerCostPerTrip = tankerCostPerTrip;
		}
		public double getTankerCost() {
			return tankerCost;
		}
		public void setTankerCost(double tankerCost) {
			this.tankerCost = tankerCost;
		}
		public int getCattle_transportPopulationServed() {
			return cattle_transportPopulationServed;
		}
		public void setCattle_transportPopulationServed(
				int cattle_transportPopulationServed) {
			this.cattle_transportPopulationServed = cattle_transportPopulationServed;
		}
		public float getCattle_noOfTrips() {
			return cattle_noOfTrips;
		}
		public void setCattle_noOfTrips(float cattle_noOfTrips) {
			this.cattle_noOfTrips = cattle_noOfTrips;
		}
		public float getCattle_tanker_Capacity() {
			return cattle_tanker_Capacity;
		}
		public void setCattle_tanker_Capacity(float cattle_tanker_Capacity) {
			this.cattle_tanker_Capacity = cattle_tanker_Capacity;
		}
		public float getCattle_tanker_QTY() {
			return cattle_tanker_QTY;
		}
		public void setCattle_tanker_QTY(float cattle_tanker_QTY) {
			this.cattle_tanker_QTY = cattle_tanker_QTY;
		}
		public String getCattle_tanker_Remarks() {
			return cattle_tanker_Remarks;
		}
		public void setCattle_tanker_Remarks(String cattle_tanker_Remarks) {
			this.cattle_tanker_Remarks = cattle_tanker_Remarks;
		}
		public double getCattle_tankerCostPerTrip() {
			return cattle_tankerCostPerTrip;
		}
		public void setCattle_tankerCostPerTrip(double cattle_tankerCostPerTrip) {
			this.cattle_tankerCostPerTrip = cattle_tankerCostPerTrip;
		}
		public double getCattle_tankerCost() {
			return cattle_tankerCost;
		}
		public void setCattle_tankerCost(double cattle_tankerCost) {
			this.cattle_tankerCost = cattle_tankerCost;
		}
	/**
	 * @return Returns the hiringPopulationServed.
	 */
	public int getHiringPopulationServed() {
		return hiringPopulationServed;
	}
	/**
	 * @param hiringPopulationServed The hiringPopulationServed to set.
	 */
	public void setHiringPopulationServed(int hiringPopulationServed) {
		this.hiringPopulationServed = hiringPopulationServed;
	}
	/**
	 * @return Returns the transportPopulationServed.
	 */
	public int getTransportPopulationServed() {
		return transportPopulationServed;
	}
	/**
	 * @param transportPopulationServed The transportPopulationServed to set.
	 */
	public void setTransportPopulationServed(int transportPopulationServed) {
		this.transportPopulationServed = transportPopulationServed;
	}
	/**
	 * @return Returns the isUpdate.
	 */
	public boolean isUpdate() {
		return isUpdate;
	}
	/**
	 * @param isUpdate The isUpdate to set.
	 */
	public void setUpdate(boolean isUpdate) {
		this.isUpdate = isUpdate;
	}
	/**
	 * @return Returns the checks.
	 */
	public String getChecks() {
		return checks;
	}
	/**
	 * @param checks The checks to set.
	 */
	public void setChecks(String checks) {
		this.checks = checks;
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
	 * @return Returns the assetType.
	 */
	public String getAssetType() {
		return assetType;
	}
	/**
	 * @param assetType The assetType to set.
	 */
	public void setAssetType(String assetType) {
		this.assetType = assetType;
	}
	/**
	 * @return Returns the dateEntered.
	 */
	public String getDateEntered() {
		return dateEntered;
	}
	/**
	 * @param dateEntered The dateEntered to set.
	 */
	public void setDateEntered(String dateEntered) {
		this.dateEntered = dateEntered;
	}
	/**
	 * @return Returns the dateOfEntry.
	 */
	public String getDateOfEntry() {
		return dateOfEntry;
	}
	/**
	 * @param dateOfEntry The dateOfEntry to set.
	 */
	public void setDateOfEntry(String dateOfEntry) {
		this.dateOfEntry = dateOfEntry;
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
	 * @return Returns the powerProblemType.
	 */
	public String getPowerProblemType() {
		return powerProblemType;
	}
	/**
	 * @param powerProblemType The powerProblemType to set.
	 */
	public void setPowerProblemType(String powerProblemType) {
		this.powerProblemType = powerProblemType;
	}
	/**
	 * @return Returns the powerSupplyRemarks.
	 */
	public String getPowerSupplyRemarks() {
		return powerSupplyRemarks;
	}
	/**
	 * @param powerSupplyRemarks The powerSupplyRemarks to set.
	 */
	public void setPowerSupplyRemarks(String powerSupplyRemarks) {
		this.powerSupplyRemarks = powerSupplyRemarks;
	}
	/**
	 * @return Returns the pvtModeOfSupply.
	 */
	public String getPvtModeOfSupply() {
		return pvtModeOfSupply;
	}
	/**
	 * @param pvtModeOfSupply The pvtModeOfSupply to set.
	 */
	public void setPvtModeOfSupply(String pvtModeOfSupply) {
		this.pvtModeOfSupply = pvtModeOfSupply;
	}
	/**
	 * @return Returns the pvtRemarks.
	 */
	public String getPvtRemarks() {
		return pvtRemarks;
	}
	/**
	 * @param pvtRemarks The pvtRemarks to set.
	 */
	public void setPvtRemarks(String pvtRemarks) {
		this.pvtRemarks = pvtRemarks;
	}
	/**
	 * @return Returns the pvtSourceHiredNo.
	 */
	public int getPvtSourceHiredNo() {
		return pvtSourceHiredNo;
	}
	/**
	 * @param pvtSourceHiredNo The pvtSourceHiredNo to set.
	 */
	public void setPvtSourceHiredNo(int pvtSourceHiredNo) {
		this.pvtSourceHiredNo = pvtSourceHiredNo;
	}
	/**
	 * @return Returns the pvtSourceQTY.
	 */
	public float getPvtSourceQTY() {
		return pvtSourceQTY;
	}
	/**
	 * @param pvtSourceQTY The pvtSourceQTY to set.
	 */
	public void setPvtSourceQTY(float pvtSourceQTY) {
		this.pvtSourceQTY = pvtSourceQTY;
	}
	/**
	 * @return Returns the tanker_Capacity.
	 */
	public float getTanker_Capacity() {
		return tanker_Capacity;
	}
	/**
	 * @param tanker_Capacity The tanker_Capacity to set.
	 */
	public void setTanker_Capacity(float tanker_Capacity) {
		this.tanker_Capacity = tanker_Capacity;
	}
	/**
	 * @return Returns the tanker_QTY.
	 */
	public float getTanker_QTY() {
		return tanker_QTY;
	}
	/**
	 * @param tanker_QTY The tanker_QTY to set.
	 */
	public void setTanker_QTY(float tanker_QTY) {
		this.tanker_QTY = tanker_QTY;
	}
	/**
	 * @return Returns the tanker_Remarks.
	 */
	public String getTanker_Remarks() {
		return tanker_Remarks;
	}
	/**
	 * @param tanker_Remarks The tanker_Remarks to set.
	 */
	public void setTanker_Remarks(String tanker_Remarks) {
		this.tanker_Remarks = tanker_Remarks;
	}
	public float getNoOfTrips() {
		return noOfTrips;
	}
	public void setNoOfTrips(float noOfTrips) {
		this.noOfTrips = noOfTrips;
	}
	public String getMandal() {
		return mandal;
	}
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	public String getMandals() {
		return mandals;
	}
	public void setMandals(String mandals) {
		this.mandals = mandals;
	}
}