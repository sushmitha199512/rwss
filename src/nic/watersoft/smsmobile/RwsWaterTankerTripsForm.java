package nic.watersoft.smsmobile;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class RwsWaterTankerTripsForm extends ActionForm{	
	private static final long serialVersionUID = 1L;
	private String dist;
	private String mand;
	private String panchayat;
	private String HabCode;
	private String HabName;
	private int noOfTrips;
	private String date;
	private ArrayList<RwsWaterTankerTripsForm> tankerTripDetails;
	private String mandalName;
	private String districtName;
	private String flag;
	public String getDist() {
		return dist;
	}
	public void setDist(String dist) {
		this.dist = dist;
	}
	public String getMand() {
		return mand;
	}
	public void setMand(String mand) {
		this.mand = mand;
	}
	public String getPanchayat() {
		return panchayat;
	}
	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}
	public String getHabCode() {
		return HabCode;
	}
	public void setHabCode(String habCode) {
		HabCode = habCode;
	}
	public String getHabName() {
		return HabName;
	}
	public void setHabName(String habName) {
		HabName = habName;
	}
	public int getNoOfTrips() {
		return noOfTrips;
	}
	public void setNoOfTrips(int noOfTrips) {
		this.noOfTrips = noOfTrips;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public ArrayList<RwsWaterTankerTripsForm> getTankerTripDetails() {
		return tankerTripDetails;
	}
	public void setTankerTripDetails(ArrayList<RwsWaterTankerTripsForm> tankerTripDetails) {
		this.tankerTripDetails = tankerTripDetails;
	}
	public String getMandalName() {
		return mandalName;
	}
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}		
}
