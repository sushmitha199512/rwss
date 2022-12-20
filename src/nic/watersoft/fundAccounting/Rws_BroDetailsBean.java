/*
 * Created on Aug 6, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import java.util.ArrayList;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_BroDetailsBean {
	String bro_id;
	String bro_reference;
	String bro_date;
	String bro_budgetEstimate;
	String bro_sanctionAmount;
	String bro_amount;
	String bro_financialYear;
	

	String bro_appAmount;
	String bro_addAmount;
	String appflag;
	String message;
	ArrayList broDetailsList;
	
	String work_id;
	String work_name;
	String admin_date;
	String sanction_amount;
	String gf;
	String scp;
	String tsp; 
	/**
	 * @return Returns the gf.
	 */
	public String getGf() {
		return gf;
	}
	/**
	 * @param gf The gf to set.
	 */
	public void setGf(String gf) {
		this.gf = gf;
	}
	/**
	 * @return Returns the scp.
	 */
	public String getScp() {
		return scp;
	}
	/**
	 * @param scp The scp to set.
	 */
	public void setScp(String scp) {
		this.scp = scp;
	}
	/**
	 * @return Returns the tsp.
	 */
	public String getTsp() {
		return tsp;
	}
	/**
	 * @param tsp The tsp to set.
	 */
	public void setTsp(String tsp) {
		this.tsp= tsp;
	}
	public String getAdmin_date() {
		return admin_date;
	}
	public void setAdmin_date(String admin_date) {
		this.admin_date = admin_date;
	}
	public String getSanction_amount() {
		return sanction_amount;
	}
	public void setSanction_amount(String sanction_amount) {
		this.sanction_amount = sanction_amount;
	}
	public String getWork_id() {
		return work_id;
	}
	public void setWork_id(String work_id) {
		this.work_id = work_id;
	}
	public String getWork_name() {
		return work_name;
	}
	public void setWork_name(String work_name) {
		this.work_name = work_name;
	}
	public String getBro_amount() {
		return bro_amount;
	}
	public void setBro_amount(String bro_amount) {
		this.bro_amount = bro_amount;
	}
	public String getBro_budgetEstimate() {
		return bro_budgetEstimate;
	}
	public void setBro_budgetEstimate(String bro_budgetEstimate) {
		this.bro_budgetEstimate = bro_budgetEstimate;
	}
	public String getBro_date() {
		return bro_date;
	}
	public void setBro_date(String bro_date) {
		this.bro_date = bro_date;
	}
	public String getBro_financialYear() {
		return bro_financialYear;
	}
	public void setBro_financialYear(String bro_financialYear) {
		this.bro_financialYear = bro_financialYear;
	}
	public String getBro_id() {
		return bro_id;
	}
	public void setBro_id(String bro_id) {
		this.bro_id = bro_id;
	}
	public String getBro_reference() {
		return bro_reference;
	}
	public void setBro_reference(String bro_reference) {
		this.bro_reference = bro_reference;
	}
	public String getBro_sanctionAmount() {
		return bro_sanctionAmount;
	}
	public void setBro_sanctionAmount(String bro_sanctionAmount) {
		this.bro_sanctionAmount = bro_sanctionAmount;
	}
	public ArrayList getBroDetailsList() {
		return broDetailsList;
	}
	public void setBroDetailsList(ArrayList broDetailsList) {
		this.broDetailsList = broDetailsList;
	}
	
	public String getMessage() {
		/*
		String strTmp="BRO ID : "+bro_id;
		strTmp+="BRO Reference : "+bro_reference;
		strTmp+="BRO Date : "+bro_date;
		strTmp+="Budget Estimate : "+bro_budgetEstimate;
		strTmp+="Sanction Amount : "+bro_sanctionAmount;
		strTmp+="BRO Amount : "+bro_amount;
		strTmp+="Financial Year : "+bro_financialYear;
		message=strTmp;
		*/
		
		 String tempMessage = "<table width=350>"
		    + "<tbody class=message>"
			+ "<tr>"
			+ "<td nowrap>BRO ID</td>"
			+ "<td>:</td>"
			+ "<td nowrap>" + bro_id + "</td>"
			+ "</tr>"
			+ "<tr>"
			+ "<td nowrap>BRO Reference</td>"
			+ "<td>:</td>"
			+ "<td nowrap>" + bro_reference + "</td>"
			+ "</tr>"
			+ "<tr>" 
			+ "<td nowrap>BRO Date</td>"
			+ "<td>:</td>"
			+ "<td>" + bro_date + "</td>"
			+ "</tr>"
			+ "<tr>" 
			+ "<td nowrap>Budget Estimate</td>"
			+ "<td>:</td>"
			+ "<td>" + bro_budgetEstimate + "</td>"
			+ "</tr>"
			+ "<tr>" 
			+ "<td valign=top nowrap>Sanction Amount</td>"
			+ "<td valign=top>:</td>"
			+ "<td>" + bro_sanctionAmount + "</td>"
			+ "</tr>"
			+ "<tr>" 
			+ "<td nowrap>BRO Amount </td>"
			+ "<td>:</td>"
			+ "<td>" + bro_amount + "</td>"
			+ "</tr>"
			+ "<tr>" 
			+ "<td nowrap>Financial Year</td>"
			+ "<td>:</td>"
			+ "<td>" + bro_financialYear + "</td>"
			+ "</tr>"
			+ "</tbody>"
			+ "</table>";
		 message=tempMessage;
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getAppflag() {
		return appflag;
	}
	public void setAppflag(String appflag) {
		this.appflag = appflag;
	}
	public String getBro_addAmount() {
		return bro_addAmount;
	}
	public void setBro_addAmount(String bro_addAmount) {
		this.bro_addAmount = bro_addAmount;
	}
public String getBro_appAmount() {
	return bro_appAmount;
}
public void setBro_appAmount(String bro_appAmount) {
	this.bro_appAmount = bro_appAmount;
}
}
