/*
 * Created on Jan 17, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.contractor;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

 

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * @author  
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TenderScheduleACompForm extends ActionForm
{
	private String assetComponentCode;
	private String assetComponent;
	private String assetSubCompTypeCode; 
	private ArrayList workSubComps;
	private String quantity;
	private String unitRate;
	private String amount;
	
	public TenderScheduleACompForm() 
	{
		workSubComps = new ArrayList();
	}
	public 	TenderScheduleACompForm(String assetComponentCode,String assetComponent,String assetSubCompTypeCode,ArrayList workSubComps,String quantity,String unitRate,String amount)
	{
	  this.assetComponent=assetComponent;
	  this.assetComponentCode=assetComponentCode;
	  this.assetSubCompTypeCode=assetSubCompTypeCode;
	  this.workSubComps=workSubComps;
	  this.quantity=quantity;
	  this.unitRate=unitRate;
	  this.amount=amount;
	}
	/**
	 * @return Returns the amount.
	 */
	public String getAmount() {
		return amount;
	}
	/**
	 * @param amount The amount to set.
	 */
	public void setAmount(String amount) {
		this.amount = amount;
	}
	/**
	 * @return Returns the assetComponent.
	 */
	public String getAssetComponent() {
		return assetComponent;
	}
	/**
	 * @param assetComponent The assetComponent to set.
	 */
	public void setAssetComponent(String assetComponent) {
		this.assetComponent = assetComponent;
	}
	/**
	 * @return Returns the assetComponentCode.
	 */
	public String getAssetComponentCode() {
		return assetComponentCode;
	}
	/**
	 * @param assetComponentCode The assetComponentCode to set.
	 */
	public void setAssetComponentCode(String assetComponentCode) {
		this.assetComponentCode = assetComponentCode;
	}
	 
	/**
	 * @return Returns the assetSubCompTypeCode.
	 */
	public String getAssetSubCompTypeCode() {
		return assetSubCompTypeCode;
	}
	/**
	 * @param assetSubCompTypeCode The assetSubCompTypeCode to set.
	 */
	public void setAssetSubCompTypeCode(String assetSubCompTypeCode) {
		this.assetSubCompTypeCode = assetSubCompTypeCode;
	}
	/**
	 * @return Returns the quantity.
	 */
	public String getQuantity() {
		return quantity;
	}
	/**
	 * @param quantity The quantity to set.
	 */
	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}
	/**
	 * @return Returns the unitRate.
	 */
	public String getUnitRate() {
		return unitRate;
	}
	/**
	 * @param unitRate The unitRate to set.
	 */
	public void setUnitRate(String unitRate) {
		this.unitRate = unitRate;
	}
	/**
	 * @return Returns the workSubComps.
	 */
	public ArrayList getWorkSubComps() {
		return workSubComps;
	}
	/**
	 * @param workSubComps The workSubComps to set.
	 */
	public void setWorkSubComps(ArrayList workSubComps) {
		this.workSubComps = workSubComps;
	}

 	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
	 		unitRate="";
	 		quantity="";
	 		assetComponentCode="";
	 		assetSubCompTypeCode="";
	 		assetComponent="";
	 		workSubComps.clear();
    }

}
