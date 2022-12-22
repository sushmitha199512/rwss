package nic.watersoft.works;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsWorkDetailsForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String circleOfficeCode;

	private String circleOfficeName;

	private String programCode;

	private String schemeCode;

	private String workId;
	
	private String searchString;
	
	
	
	

	public String getSearchString() {
		return searchString;
	}

	public void setSearchString(String searchString) {
		this.searchString = searchString;
	}

	public String getWorkId() {
		return workId;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}

	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}

	public String getCircleOfficeName() {
		return circleOfficeName;
	}

	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
	}

	public String getProgramCode() {
		return programCode;
	}

	public void setProgramCode(String programCode) {
		this.programCode = programCode;
	}

	public String getSchemeCode() {
		return schemeCode;
	}

	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
