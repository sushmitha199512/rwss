package nic.watersoft.fundAccounting;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

/**
 * 
 * @author RWSS_DPT1
 * 
 */
public class RwsVoucherFwdActionForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String circle;
	private String division;
	private String workId;
	private String paoInAdmissible;
	private String voucherAmt;
	private String eeFWDDate;

	private ArrayList<RwsVoucher> vouchersList;

	public String getCircle() {
		return circle;
	}

	public void setCircle(String circle) {
		this.circle = circle;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getWorkId() {
		return workId;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public String getVoucherAmt() {
		return voucherAmt;
	}

	public void setVoucherAmt(String voucherAmt) {
		this.voucherAmt = voucherAmt;
	}

	public String getEeFWDDate() {
		return eeFWDDate;
	}

	public void setEeFWDDate(String eeFWDDate) {
		this.eeFWDDate = eeFWDDate;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setPaoInAdmissible(String paoInAdmissible) {
		this.paoInAdmissible = paoInAdmissible;
	}

	public String getPaoInAdmissible() {
		return paoInAdmissible;
	}

	public void setVouchersList(ArrayList<RwsVoucher> vouchersList) {
		this.vouchersList = vouchersList;
	}

	public ArrayList<RwsVoucher> getVouchersList() {
		if (this.vouchersList == null) {
			return new ArrayList<RwsVoucher>();
		}
		return vouchersList;
	}

}
