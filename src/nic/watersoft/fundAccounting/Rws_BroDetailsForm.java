/*
 * Created on Aug 6, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import java.util.ArrayList;

//import nic.watersoft.masters.PanchRaj;

import org.apache.struts.action.ActionForm;


public class Rws_BroDetailsForm extends ActionForm{
	
	String bro_id;
	String bro_reference;
	String bro_date;
	String bro_budgetEstimate;
	String bro_sanctionAmount;
	String bro_amount;
	String bro_financialYear;
	ArrayList broDetailsList;
	String bro_appAmount;
	String bro_addAmount;
	String appflag;
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
		this.tsp = tsp;
	}
	public String getAppflag() {
		return appflag;
	}
	public void setAppflag(String appflag) {
		this.appflag = appflag;
	}
	public String getBro_appAmount() {
		return bro_appAmount;
	}
	public void setBro_appAmount(String bro_appAmount) {
		this.bro_appAmount = bro_appAmount;
	}
	public Rws_BroDetailsForm()
	{
		broDetailsList=new ArrayList();
		
	}
	
	public Rws_BroProgDetailsBean getBRO_DETAILS_LIST(int index)
	{
		//System.out.println("index ::"+index);
		//System.out.println("broDetailsList.size() ::"+broDetailsList.size());
		while(index >= broDetailsList.size())
		{
			broDetailsList.add(new Rws_BroProgDetailsBean());
		}
		return (Rws_BroProgDetailsBean)((ArrayList) broDetailsList).get(index);
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
	public String getBro_addAmount() {
		return bro_addAmount;
	}
	public void setBro_addAmount(String bro_addAmount) {
		this.bro_addAmount = bro_addAmount;
	}
	
	
}
