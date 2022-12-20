package nic.watersoft.reports;

import org.apache.struts.action.ActionForm;

public class Rws_Asset_FormBean extends ActionForm{
public String getDistrictcode() {
		return districtcode;
	}
	public void setDistrictcode(String districtcode) {
		this.districtcode = districtcode;
	}
	public String getDistrictname() {
		return districtname;
	}
	public void setDistrictname(String districtname) {
		this.districtname = districtname;
	}
	public String getFromDate() {
		return fromDate;
	}
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	public String getToDate() {
		return toDate;
	}
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
private String districtcode;
private String districtname;
private String fromDate;
private String toDate;
private String districtname1;
public String getDistrictname1() {
	return districtname1;
}
public void setDistrictname1(String districtname1) {
	this.districtname1 = districtname1;
}
}
