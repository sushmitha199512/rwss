package nic.watersoft.drought;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;
import org.apache.struts.upload.FormFile;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsDroughtNewsItemForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String district;
	private String division;
	private String level;
	private String mandal;
	private ArrayList habData;

	private String paperDt;
	
	private String panchayat;
	private String village;
	private String habitation;

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

	public String getHabitation() {
		return habitation;
	}

	public void setHabitation(String habitation) {
		this.habitation = habitation;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getPaperDt() {
		return paperDt;
	}

	public void setPaperDt(String paperDt) {
		this.paperDt = paperDt;
	}

	public ArrayList getHabData() {
		if (this.habData == null) {
			return new ArrayList();
		}
		return habData;
	}

	public void setHabData(ArrayList habData) {
		this.habData = habData;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getMandal() {
		return mandal;
	}

	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	private String slNo;

	private String districtName;
	private String mandalName;
	private String panchayathName;
	private String villageName;
	private String habCode;
	private String habName;
	private String totPopulation;
	private String coverageStatus;
	private String paperDate;
	private String paperName;
	private String paperEdition;
	private String paperNews;
	private String actionReport;
	private String remarks;
	private String checks;
	private String isSavedRecord;
	//private String scannedCopy;
	private String scannedCopyStatus;
	private String newsId;
	private String slNoCount;
	private FormFile scannedCopy;
	private String typeOfAdverseNewsItem;
	private FormFile atrScannedCopy;
	
	
	
	public FormFile getAtrScannedCopy() {
		return atrScannedCopy;
	}

	public void setAtrScannedCopy(FormFile atrScannedCopy) {
		this.atrScannedCopy = atrScannedCopy;
	}

	public String getTypeOfAdverseNewsItem() {
		return typeOfAdverseNewsItem;
	}

	public void setTypeOfAdverseNewsItem(String typeOfAdverseNewsItem) {
		this.typeOfAdverseNewsItem = typeOfAdverseNewsItem;
	}

	public FormFile getScannedCopy() {
		return scannedCopy;
	}

	public void setScannedCopy(FormFile scannedCopy) {
		this.scannedCopy = scannedCopy;
	}

	public String getSlNoCount() {
		return slNoCount;
	}

	public void setSlNoCount(String slNoCount) {
		this.slNoCount = slNoCount;
	}

	public String getNewsId() {
		return newsId;
	}

	public void setNewsId(String newsId) {
		this.newsId = newsId;
	}

	public String getScannedCopyStatus() {
		return scannedCopyStatus;
	}

	public void setScannedCopyStatus(String scannedCopyStatus) {
		this.scannedCopyStatus = scannedCopyStatus;
	}

	public String getIsSavedRecord() {
		return isSavedRecord;
	}

	public String getDistrictName() {
		return districtName;
	}

	public void setDistrictName(String districtName) {
		this.districtName = districtName;
	}

	public String getVillageName() {
		return villageName;
	}

	public void setVillageName(String villageName) {
		this.villageName = villageName;
	}

	/*public String getScannedCopy() {
		return scannedCopy;
	}

	public void setScannedCopy(String scannedCopy) {
		this.scannedCopy = scannedCopy;
	}*/

	public void setIsSavedRecord(String isSavedRecord) {
		this.isSavedRecord = isSavedRecord;
	}

	public String getChecks() {
		return checks;
	}

	public void setChecks(String checks) {
		this.checks = checks;
	}

	public String getSlNo() {
		return slNo;
	}

	public void setSlNo(String slNo) {
		this.slNo = slNo;
	}

	public String getMandalName() {
		return mandalName;
	}

	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}

	public String getPanchayathName() {
		return panchayathName;
	}

	public void setPanchayathName(String panchayathName) {
		this.panchayathName = panchayathName;
	}

	public String getHabCode() {
		return habCode;
	}

	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}

	public String getHabName() {
		return habName;
	}

	public void setHabName(String habName) {
		this.habName = habName;
	}

	public String getTotPopulation() {
		return totPopulation;
	}

	public void setTotPopulation(String totPopulation) {
		this.totPopulation = totPopulation;
	}

	public String getCoverageStatus() {
		return coverageStatus;
	}

	public void setCoverageStatus(String coverageStatus) {
		this.coverageStatus = coverageStatus;
	}

	public String getPaperDate() {
		return paperDate;
	}

	public void setPaperDate(String paperDate) {
		this.paperDate = paperDate;
	}

	public String getPaperName() {
		return paperName;
	}

	public void setPaperName(String paperName) {
		this.paperName = paperName;
	}

	public String getPaperEdition() {
		return paperEdition;
	}

	public void setPaperEdition(String paperEdition) {
		this.paperEdition = paperEdition;
	}

	public String getPaperNews() {
		return paperNews;
	}

	public void setPaperNews(String paperNews) {
		this.paperNews = paperNews;
	}

	public String getActionReport() {
		return actionReport;
	}

	public void setActionReport(String actionReport) {
		this.actionReport = actionReport;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}


}
