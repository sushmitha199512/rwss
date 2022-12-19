package nic.watersoft.Sanitation;


import java.util.ArrayList;
import java.io.Serializable;
import java.util.ArrayList;


public class IhhlFormBean implements Serializable {
	
	
	private String district="";
	private String districtName="";
	private String mandal="";
	private String panchayat="";
	private String village="";
	private String habCode="";
	private String cat="";
	private String subcat="";
	private String  gen="";
	private String cardtype="";
	private String distCode="";
	private String mandalCode="";
	private String panchCode="";
	private String villCode="";
	private String habcode="";
	private String FamilyHead="";
	private int noOfHabs=0;
	private int noOfCategory=0;
	private int noOfCardtype=0;
	private int noOfSubCategory=0;
	private int noOfFM=0;
	private String category="";
	private String subcategory="";
	private String CATEGORY_CODE="";
	private String distName4="";
	private String cardid="";
	private String categoryName="";
	private String cardName="";
	private String constituency="";
	private String sourceCode="";
	private String habslist="";
	private String mandalName="";
	private String PanchName="";
	private String villName="";
	private String constituencyCode="";
	private String constituencyName="";
	private String gender="";
	private String value="";
	private String label="";
	
	
		

	public String getCat() {
		return cat;
	}
	public void setCat(String cat) {
		this.cat = cat;
	}
	public String getSubcat() {
		return subcat;
	}
	public void setSubcat(String subcat) {
		this.subcat = subcat;
	}
	public String getGen() {
		return gen;
	}
	public void setGen(String gen) {
		this.gen = gen;
	}
	public String getCardtype() {
		return cardtype;
	}
	public void setCardtype(String cardtype) {
		this.cardtype = cardtype;
	}
	public String getDistrict() {
		return district;
	}
	public void setDistrict(String district) {
		this.district = district;
	}
	public String getDistrictName() {
		return districtName;
	}
	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}
	public String getMandal() {
		return mandal;
	}
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	public String getPanchayat() {
		return panchayat;
	}
	public void setPanchayat(String panchayat) {
		this.panchayat = panchayat;
	}
	public String getVillage() {
		return village;
	}
	public void setVillage(String village) {
		this.village = village;
	}
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	public String getDistCode() {
		return distCode;
	}
	public void setDistCode(String distCode) {
		this.distCode = distCode;
	}
	public String getMandalCode() {
		return mandalCode;
	}
	public void setMandalCode(String mandalCode) {
		this.mandalCode = mandalCode;
	}
	public String getPanchCode() {
		return panchCode;
	}
	public void setPanchCode(String panchCode) {
		this.panchCode = panchCode;
	}
	public String getVillCode() {
		return villCode;
	}
	public void setVillCode(String villCode) {
		this.villCode = villCode;
	}
	public String getHabcode() {
		return habcode;
	}
	public void setHabcode(String habcode) {
		this.habcode = habcode;
	}
	public String getFamilyHead() {
		return FamilyHead;
	}
	public void setFamilyHead(String familyHead) {
		FamilyHead = familyHead;
	}
	public int getNoOfHabs() {
		return noOfHabs;
	}
	public void setNoOfHabs(int noOfHabs) {
		this.noOfHabs = noOfHabs;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSubcategory() {
		return subcategory;
	}
	public void setSubcategory(String subcategory) {
		this.subcategory = subcategory;
	}
	public String getCATEGORY_CODE() {
		return CATEGORY_CODE;
	}
	public void setCATEGORY_CODE(String cATEGORY_CODE) {
		CATEGORY_CODE = cATEGORY_CODE;
	}
	public String getDistName4() {
		return distName4;
	}
	public void setDistName4(String distName4) {
		this.distName4 = distName4;
	}
	public String getCardid() {
		return cardid;
	}
	public void setCardid(String cardid) {
		this.cardid = cardid;
	}
	public int getNoOfCategory() {
		return noOfCategory;
	}
	public void setNoOfCategory(int noOfCategory) {
		this.noOfCategory = noOfCategory;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCardName() {
		return cardName;
	}
	public void setCardName(String cardName) {
		this.cardName = cardName;
	}
	public int getNoOfCardtype() {
		return noOfCardtype;
	}
	public void setNoOfCardtype(int noOfCardtype) {
		this.noOfCardtype = noOfCardtype;
	}
	public String getConstituency() {
		return constituency;
	}
	public void setConstituency(String constituency) {
		this.constituency = constituency;
	}
	public String getSourceCode() {
		return sourceCode;
	}
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
	}
	public String getHabslist() {
		return habslist;
	}
	public void setHabslist(String habslist) {
		this.habslist = habslist;
	}
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	public String getMandalName() {
		return mandalName;
	}
	public void setPanchName(String panchName) {
		PanchName = panchName;
	}
	public String getPanchName() {
		return PanchName;
	}
	public void setVillName(String villName) {
		this.villName = villName;
	}
	public String getVillName() {
		return villName;
	}
	public void setConstituencyCode(String constituencyCode) {
		this.constituencyCode = constituencyCode;
	}
	public String getConstituencyCode() {
		return constituencyCode;
	}
	public void setConstituencyName(String constituencyName) {
		this.constituencyName = constituencyName;
	}
	public String getConstituencyName() {
		return constituencyName;
	}
	public void setNoOfSubCategory(int noOfSubCategory) {
		this.noOfSubCategory = noOfSubCategory;
	}
	public int getNoOfSubCategory() {
		return noOfSubCategory;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getNoOfFM() {
		return noOfFM;
	}
	public void setNoOfFM(int noOfFM) {
		this.noOfFM = noOfFM;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getValue() {
		return value;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getLabel() {
		return label;
	}
	


}
