/**
 * Created on Jun 15, 2007
 
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

 
public class rws_projectshelf_works_frm extends ActionForm
{
	private String circleOfficeCode;
	private String circleOfficeName;
	private String divisionOfficeCode;
	private ArrayList psWorks;
	private String mode;
	private String type;
	private String programCode;
	private String schemeCode;
	private String category;

	/**
	 * @return Returns the category.
	 */
	public String getCategory() {
		return category;
	}
	/**
	 * @param category The category to set.
	 */
	public void setCategory(String category) {
		this.category = category;
	}
	
	/**
	 * @return Returns the programCode.
	 */
	public String getProgramCode() {
		return programCode;
	}
	/**
	 * @param programCode The programCode to set.
	 */
	public void setProgramCode(String programCode) {
		this.programCode = programCode;
	}
	/**
	 * @return Returns the schemeCode.
	 */
	public String getSchemeCode() {
		return schemeCode;
	}
	/**
	 * @param schemeCode The schemeCode to set.
	 */
	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}
	public rws_projectshelf_works_frm()
	{
		psWorks = new ArrayList();
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
	public ArrayList getPsWorks() {
		return psWorks;
	}

	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public void setPsWorks(ArrayList psWorks) {
		this.psWorks = psWorks;
	}
	
/*	public tenderMemo getWORKS(int index)
	{
		System.out.println("1");
		while(index >= psWorks.size())
		{
			System.out.println("2");
			psWorks.add(new rws_projectshelf_works_bean());
		}
		return (tenderMemo)psWorks.get(index);
	}
*/	
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
