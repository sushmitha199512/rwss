package nic.watersoft.works;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class Rws_Rfd_Trainings_Frm  extends ActionForm
{

	private String dist;
	private String mand;
	private String panch;
	private String districtName;
	private String mandalName;
	private String panchayatName;
	private ArrayList hps;
	private ArrayList dryears;
	private String distCode;
	private String distName;
	private String vwscTarget;
	private String vwscAchmt;
	private String ftkTarget;
	private String finYear;
	private String preparedBy;
	private String updateDate;

	public String getPreparedBy() {
		return preparedBy;
	}
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getFinYear() {
		return finYear;
	}
	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}
	public String getVwscTarget() {
		return vwscTarget;
	}
	public void setVwscTarget(String vwscTarget) {
		this.vwscTarget = vwscTarget;
	}
	public String getVwscAchmt() {
		return vwscAchmt;
	}
	public void setVwscAchmt(String vwscAchmt) {
		this.vwscAchmt = vwscAchmt;
	}
	public String getFtkTarget() {
		return ftkTarget;
	}
	public void setFtkTarget(String ftkTarget) {
		this.ftkTarget = ftkTarget;
	}
	public String getFtkAchmt() {
		return ftkAchmt;
	}
	public void setFtkAchmt(String ftkAchmt) {
		this.ftkAchmt = ftkAchmt;
	}
	private String ftkAchmt;
	
	public String getDistCode() {
		return distCode;
	}
	public void setDistCode(String distCode) {
		this.distCode = distCode;
	}
	public String getDistName() {
		return distName;
	}
	public void setDistName(String distName) {
		this.distName = distName;
	}
	public ArrayList getDryears() {
		return dryears;
	}
	public void setDryears(ArrayList dryears) {
		this.dryears = dryears;
	}
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
	public String getPanch() {
		return panch;
	}
	public void setPanch(String panch) {
		this.panch = panch;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getMandalName() {
		return mandalName;
	}
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	public String getPanchayatName() {
		return panchayatName;
	}
	public void setPanchayatName(String panchayatName) {
		this.panchayatName = panchayatName;
	}
	public ArrayList getHps() {
		return hps;
	}
	public void setHps(ArrayList hps) {
		this.hps = hps;
	}
	
	
	
}
