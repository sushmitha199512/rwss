/*
 * Created on Aug 10, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.util.ArrayList;

import nic.watersoft.commons.Debug;
/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_SchoolDetails {
	
	String dname;
	String mname;
	String pname;
	String vname;
	String habname;
	String habCode;
	String schoolname;
	String students;
	String boysgirls;
	String category;
	String classification;
	String schoolcode;
	String assetTypeCode;
	String assetCode;
	String update;
	String selCriteria;
	
	ArrayList assetTypes;
	ArrayList assetsList;
	
	
	Rws_SchoolDetails()
	{
		ArrayList emptyList=new ArrayList(0);
		assetTypes=emptyList;
		assetsList=emptyList;
	}
	
	public ArrayList getAssetTypes() {
		return assetTypes;
	}
	public void setAssetTypes(ArrayList assetTypes) {
		this.assetTypes = assetTypes;
	}
	public String getBoysgirls() {
		return boysgirls;
	}
	public void setBoysgirls(String boysgirls) {
		this.boysgirls = boysgirls;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getClassification() {
		return classification;
	}
	public void setClassification(String classification) {
		this.classification = classification;
	}
	public String getHabname() {
		return habname;
	}
	public void setHabname(String habname) {
		this.habname = habname;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getSchoolname() {
		return schoolname;
	}
	public void setSchoolname(String schoolname) {
		this.schoolname = schoolname;
	}
	public String getStudents() {
		return students;
	}
	public void setStudents(String students) {
		this.students = students;
	}
	public String getVname() {
		return vname;
	}
	public void setVname(String vname) {
		this.vname = vname;
	}
	public ArrayList getWorksList() {
		return assetsList;
	}
	public void setWorksList(ArrayList worksList) {
		this.assetsList = worksList;
	}
	
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	
	public String getAssetCode() {
		return assetCode;
	}
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	public ArrayList getAssetsList() {
		return assetsList;
	}
	public void setAssetsList(ArrayList assetsList) {
		this.assetsList = assetsList;
	}
	public String getAssetTypeCode() {
		return assetTypeCode;
	}
	public void setAssetTypeCode(String assetTypeCode) {
		this.assetTypeCode = assetTypeCode;
	}
	public String getSchoolcode() {
		return schoolcode;
	}
	public void setSchoolcode(String schoolcode) {
		this.schoolcode = schoolcode;
	}
	
	public String getUpdate() {
		return update;
	}
	public void setUpdate(String update) {
		this.update = update;
	}
	
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	
	/**
	 * @return Returns the selCriteria.
	 */
	public String getSelCriteria() {
		return selCriteria;
	}
	/**
	 * @param selCriteria The selCriteria to set.
	 */
	public void setSelCriteria(String selCriteria) {
		this.selCriteria = selCriteria;
	}
}
