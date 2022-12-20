package nic.watersoft.fundAccounting;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.LabelValueBean;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsPAOBillActionForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String circleCode;
	private ArrayList<RwsPAOBillRecord> billsList;
	private ArrayList<LabelValueBean> circles;

	private ArrayList<LabelValueBean> divisions;

	private String divCode;
	private String yearCode;
	private String monthCode;

	private String soFarProcessAmount;

	private String selectedBillCount;

	@Override
	public void reset(ActionMapping mapping, HttpServletRequest request) {

		if (this.billsList != null && this.billsList.size() > 0) {
			for (RwsPAOBillRecord r : this.billsList) {

				System.out.println("a" + r.getChecks());
			}
		}

	}

	public String getSoFarProcessAmount() {
		return soFarProcessAmount;
	}

	public void setSoFarProcessAmount(String soFarProcessAmount) {
		this.soFarProcessAmount = soFarProcessAmount;
	}

	public String getSelectedBillCount() {
		return selectedBillCount;
	}

	public void setSelectedBillCount(String selectedBillCount) {
		this.selectedBillCount = selectedBillCount;
	}

	public String getCircleCode() {
		return circleCode;
	}

	public void setCircleCode(String circleCode) {
		this.circleCode = circleCode;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setCircles(ArrayList<LabelValueBean> circles) {
		this.circles = circles;
	}

	public ArrayList<LabelValueBean> getCircles() {
		return circles;
	}

	public void setBillsList(ArrayList<RwsPAOBillRecord> billsList) {
		this.billsList = billsList;
	}

	public ArrayList<RwsPAOBillRecord> getBillsList() {
		if (this.billsList == null) {
			return new ArrayList<RwsPAOBillRecord>();
		}
		return billsList;
	}

	public void setDivisions(ArrayList<LabelValueBean> divisions) {
		this.divisions = divisions;
	}

	public ArrayList<LabelValueBean> getDivisions() {
		return divisions;
	}

	public void setDivCode(String divCode) {
		this.divCode = divCode;
	}

	public String getDivCode() {
		return divCode;
	}

	public void setYearCode(String yearCode) {
		this.yearCode = yearCode;
	}

	public String getYearCode() {
		return yearCode;
	}

	public void setMonthCode(String monthCode) {
		this.monthCode = monthCode;
	}

	public String getMonthCode() {
		return monthCode;
	}

}
