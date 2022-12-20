/*
 * Created on Aug 10, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.util.ArrayList;

import nic.watersoft.commons.Debug;
import nic.watersoft.fundAccounting.Rws_LocProgDetailsBean;
/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_SchoolDetailsBean {
	
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
	String assetName;
	String location;
	String date;
	String assetCost;
	String type;
	String alreadyExists;
	String assetTypeName;
	
	ArrayList assetTypes;
	ArrayList assetsList;
	ArrayList list;
	
	public Rws_SchoolDetailsBean()
	{
		ArrayList emptyList=new ArrayList(0);
		assetTypes=emptyList;
		assetsList=emptyList;
	}
	
	public Rws_LocProgDetailsBean getLOC_DETAILS_LIST(int index)
	{
		while(index >= list.size())
		{
			list.add(new Rws_SchoolDetailsBean());
		}
		return (Rws_LocProgDetailsBean)((ArrayList)list).get(index);
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
	
	public ArrayList getList() {
		return list;
	}
	public void setList(ArrayList list) {
		this.list = list;
	}
	
	public String getAssetName() {
		return assetName;
	}
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	public String getAssetCost() {
		return assetCost;
	}
	public void setAssetCost(String assetCost) {
		this.assetCost = assetCost;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getAlreadyExists() {
		return alreadyExists;
	}
	public void setAlreadyExists(String alreadyExists) {
		this.alreadyExists = alreadyExists;
	}
	
	public String getAssetTypeName() {
		return assetTypeName;
	}
	public void setAssetTypeName(String assetTypeName) {
		this.assetTypeName = assetTypeName;
	}
}
