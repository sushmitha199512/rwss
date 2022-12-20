package nic.watersoft.smsmobile;

import org.apache.struts.action.ActionForm;

public class Rws_dlpoForm  extends ActionForm{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	 private String district;
	 private String mandal;

	private String panchayat;

	private String pcode;

	private String pname;


	private String dcode;

	private String dname;

	private String mcode;

	private String mname;

	private String districtName;
	private String sarpanchMobile;

	private String sarpanchName;
	private String sarpanchList;
	
	private String status;
	private String frmDate;
	private String toDate;
	private String dlpoNo;
	private String divmandals;
	private String[] divmandals1;
	private String division;
	private String divisionName;
	private String oldDivision;
	private String oldMandal;
	private String oldCircle;
	
	
	public String getDivisionName() {
		return divisionName;
	}

	public void setDivisionName(String divisionName) {
		this.divisionName = divisionName;
	}

	public String getOldDivision() {
		return oldDivision;
	}

	public void setOldDivision(String oldDivision) {
		this.oldDivision = oldDivision;
	}

	public String getOldMandal() {
		return oldMandal;
	}

	public void setOldMandal(String oldMandal) {
		this.oldMandal = oldMandal;
	}

	public String getOldCircle() {
		return oldCircle;
	}

	public void setOldCircle(String oldCircle) {
		this.oldCircle = oldCircle;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getFrmDate() {
		return frmDate;
	}

	public void setFrmDate(String frmDate) {
		this.frmDate = frmDate;
	}

	public String getToDate() {
		return toDate;
	}

	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	public String getSarpanchList() {
		return sarpanchList;
	}

	public void setSarpanchList(String sarpanchList) {
		this.sarpanchList = sarpanchList;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	
	public String getDcode() {
		return dcode;
	}

	public void setDcode(String dcode) {
		this.dcode = dcode;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}

	public String getMandal() {
		return mandal;
	}

	public void setMandal(String mandal) {
		this.mandal = mandal;
	}

	public String getMcode() {
		return mcode;
	}

	public void setMcode(String mcode) {
		this.mcode = mcode;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getPanchayat() {
		return panchayat;
	}

	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getSarpanchMobile() {
		return sarpanchMobile;
	}

	public void setSarpanchMobile(String sarpanchMobile) {
		this.sarpanchMobile = sarpanchMobile;
	}

	public String getSarpanchName() {
		return sarpanchName;
	}

	public void setSarpanchName(String sarpanchName) {
		this.sarpanchName = sarpanchName;
	}

	public void setDlpoNo(String dlpoNo) {
		this.dlpoNo = dlpoNo;
	}

	public String getDlpoNo() {
		return dlpoNo;
	}

	

	public void setDivmandals(String divmandals) {
		this.divmandals = divmandals;
	}

	public String getDivmandals() {
		return divmandals;
	}
	public void setDivmandals1(String[] divmandals1) {
		this.divmandals1 = divmandals1;
	}

	public String[] getDivmandals1() {
		return divmandals1;
	}
}
