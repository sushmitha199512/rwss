package nic.watersoft.masters;

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class HabInstitute
{
	private String instituteCode;
	private String instituteName;
	private String instituteNo;
	private String instituteCovered;
	private String instituteWorking;
	private String instituteNotWorking;
	
	public HabInstitute()
	{
		
	}
	public HabInstitute(String instituteCode,String instituteName,String instituteNo,String instituteCovered)
	{
		this.instituteCode=instituteCode;
		this.instituteName=instituteName;
		this.instituteNo = instituteNo;
		this.instituteCovered = instituteCovered;
	}
	public HabInstitute(String instituteCode,String instituteName)
	{
		this.instituteCode=instituteCode;
		this.instituteName=instituteName;
	}
	/**
	 * @return Returns the instituteCode.
	 */
	public String getInstituteCode() {
		return instituteCode;
	}
	/**
	 * @param instituteCode The instituteCode to set.
	 */
	public void setInstituteCode(String instituteCode) {
		this.instituteCode = instituteCode;
	}
	/**
	 * @return Returns the instituteName.
	 */
	public String getInstituteName() {
		return instituteName;
	}
	/**
	 * @param instituteName The instituteName to set.
	 */
	public void setInstituteName(String instituteName) {
		this.instituteName = instituteName;
	}
	/**
	 * @return Returns the instituteCovered.
	 */
	public String getInstituteCovered() {
		return instituteCovered;
	}
	/**
	 * @param instituteCovered The instituteCovered to set.
	 */
	public void setInstituteCovered(String instituteCovered) {
		this.instituteCovered = instituteCovered;
	}
	/**
	 * @return Returns the instituteNo.
	 */
	public String getInstituteNo() {
		return instituteNo;
	}
	/**
	 * @param instituteNo The instituteNo to set.
	 */
	public void setInstituteNo(String instituteNo) {
		this.instituteNo = instituteNo;
	}
	public String getInstituteNotWorking() {
		return instituteNotWorking;
	}
	public void setInstituteNotWorking(String instituteNotWorking) {
		this.instituteNotWorking = instituteNotWorking;
	}
	public String getInstituteWorking() {
		return instituteWorking;
	}
	public void setInstituteWorking(String instituteWorking) {
		this.instituteWorking = instituteWorking;
	}
}
