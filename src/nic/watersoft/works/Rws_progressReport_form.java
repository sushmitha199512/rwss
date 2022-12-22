package nic.watersoft.works;

import java.util.ArrayList;



import org.apache.struts.action.ActionForm;

/**
 * @author sadiq
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_progressReport_form extends ActionForm{
	private ArrayList progressReportEntries;
	private String district;
	private String dname;
	private String financialYear;
	private String month;
	private String monthName;
	private String openingBalance;
	private String closingBalance;
	private String programme;
	private String navigationMode;
	private String division;
	
	
	public Rws_progressReport_form()
	{
		progressReportEntries=new ArrayList();
	}
	public Rws_progressReport_bean getPROGRESSREPORT_ENTRIES(int index)
	{
		while(index >= progressReportEntries.size())
		{
			progressReportEntries.add(new Rws_progressReport_bean());
		}
		return (Rws_progressReport_bean)((ArrayList) progressReportEntries).get(index);
	}
	/**
	 * @return Returns the progressReportEntries.
	 */
	public ArrayList getProgressReportEntries() {
		return progressReportEntries;
	}
	/**
	 * @param progressReportEntries The progressReportEntries to set.
	 */
	public void setProgressReportEntries(ArrayList progressReportEntries) {
		this.progressReportEntries = progressReportEntries;
	}
	/**
	 * @return Returns the district.
	 */
	public String getDistrict() {
		return district;
	}
	/**
	 * @param district The district to set.
	 */
	public void setDistrict(String district) {
		this.district = district;
	}
	/**
	 * @return Returns the financialYear.
	 */
	public String getFinancialYear() {
		return financialYear;
	}
	/**
	 * @param financialYear The financialYear to set.
	 */
	public void setFinancialYear(String financialYear) {
		this.financialYear = financialYear;
	}
	/**
	 * @return Returns the month.
	 */
	public String getMonth() {
		return month;
	}
	/**
	 * @param month The month to set.
	 */
	public void setMonth(String month) {
		this.month = month;
	}
	/**
	 * @return Returns the dname.
	 */
	public String getDname() {
		return dname;
	}
	/**
	 * @param dname The dname to set.
	 */
	public void setDname(String dname) {
		this.dname = dname;
	}
	/**
	 * @return Returns the monthName.
	 */
	public String getMonthName() {
		return monthName;
	}
	/**
	 * @param monthName The monthName to set.
	 */
	public void setMonthName(String monthName) {
		this.monthName = monthName;
	}
	/**
	 * @return Returns the openingBalance.
	 */
	public String getOpeningBalance() {
		return openingBalance;
	}
	/**
	 * @param openingBalance The openingBalance to set.
	 */
	public void setOpeningBalance(String openingBalance) {
		this.openingBalance = openingBalance;
	}
	/**
	 * @return Returns the programme.
	 */
	public String getProgramme() {
		return programme;
	}
	/**
	 * @param programme The programme to set.
	 */
	public void setProgramme(String programme) {
		this.programme = programme;
	}
	/**
	 * @return Returns the closingBalance.
	 */
	public String getClosingBalance() {
		return closingBalance;
	}
	/**
	 * @param closingBalance The closingBalance to set.
	 */
	public void setClosingBalance(String closingBalance) {
		this.closingBalance = closingBalance;
	}
	
	/**
	 * @return Returns the navigationMode.
	 */
	public String getNavigationMode() {
		return navigationMode;
	}
	/**
	 * @param navigationMode The navigationMode to set.
	 */
	public void setNavigationMode(String navigationMode) {
		this.navigationMode = navigationMode;
	}
	/**
	 * @return Returns the division.
	 */
	public String getDivision() {
		return division;
	}
	/**
	 * @param division The division to set.
	 */
	public void setDivision(String division) {
		this.division = division;
	}
}