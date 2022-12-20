/*
 * Created on 16-Feb-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.io.Serializable;

/**
 * @author NIC
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class DroughtHabWorkDetails implements Serializable{
	
	String type;
	String name;
	double amount;
	String pdate;
	
	
	

	/**
	 * @return Returns the amount.
	 */
	public double getAmount() {
		return amount;
	}
	/**
	 * @param amount The amount to set.
	 */
	public void setAmount(double amount) {
		this.amount = amount;
	}
	/**
	 * @return Returns the name.
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name The name to set.
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return Returns the pdate.
	 */
	public String getPdate() {
		if(pdate!=null)
		{
		return pdate;
		}else{
			return "";
		}
	}
	/**
	 * @param pdate The pdate to set.
	 */
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	/**
	 * @return Returns the type.
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type The type to set.
	 */
	public void setType(String type) {
		this.type = type;
	}
}
