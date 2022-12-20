package nic.watersoft.works;

public class RWS_SCHOOL_BEAN {
	private String schoolCode;
	private String schoolDetails;
	private String schoolClassification;
	private String isSchoolHavingTap;
	private String schoolCategory;
	private String habCode;
	private String schoolCategoryCode;
	public RWS_SCHOOL_BEAN(RWS_SCHOOL_BEAN object) {
		this.schoolCode = object.schoolCode;
		this.schoolDetails = object.schoolDetails;
		this.schoolClassification = object.schoolClassification;
		this.isSchoolHavingTap = object.isSchoolHavingTap;
		this.schoolCategory = object.schoolCategory;
		this.habCode = object.habCode;
		this.schoolCategoryCode = object.schoolCategoryCode;
		// TODO Auto-generated constructor stub
		/*System.out.println("object.schoolCode :"+object.schoolCode+" object.schoolDetails :"+object.schoolDetails+" object.schoolClassification :"+object.schoolClassification
				+" object.isSchoolHavingTap:"+object.isSchoolHavingTap+" object.habCode:"+object.habCode);*/
	}
	public RWS_SCHOOL_BEAN() {
		// TODO Auto-generated constructor stub
	}
	public String getSchoolCode() {
		return schoolCode;
	}
	public void setSchoolCode(String schoolCode) {
		this.schoolCode = schoolCode;
	}
	public String getSchoolDetails() {
		return schoolDetails;
	}
	public void setSchoolDetails(String schoolDetails) {
		this.schoolDetails = schoolDetails;
	}
	public String getSchoolClassification() {
		return schoolClassification;
	}
	public void setSchoolClassification(String schoolClassification) {
		this.schoolClassification = schoolClassification;
	}
	
	public String getSchoolCategory() {
		return schoolCategory;
	}
	public void setSchoolCategory(String schoolCategory) {
		this.schoolCategory = schoolCategory;
	}
	public String getHabCode() {
		return habCode;
	}
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
	public String getIsSchoolHavingTap() {
		return isSchoolHavingTap;
	}
	public void setIsSchoolHavingTap(String isSchoolHavingTap) {
		this.isSchoolHavingTap = isSchoolHavingTap;
	}
	public String getSchoolCategoryCode() {
		return schoolCategoryCode;
	}
	public void setSchoolCategoryCode(String schoolCategoryCode) {
		this.schoolCategoryCode = schoolCategoryCode;
	}
	
	
	
}
