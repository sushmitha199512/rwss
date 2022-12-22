/*
 * Created on Dec 11, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;
import org.apache.struts.action.*;

/**
 * @author nic
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Admn_Sanc_Graph_Form extends ActionForm{
	String mfin_year;
	String mode;

	/**
	 * @return Returns the mfin_year.
	 */
	public String getMfin_year() {
		return mfin_year;
	}
	/**
	 * @param mfin_year The mfin_year to set.
	 */
	public void setMfin_year(String mfin_year) {
		this.mfin_year = mfin_year;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode() {
		return mode;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}
}
