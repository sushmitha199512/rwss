/*
 * Created on Sep 17, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.fundAccounting;

import org.apache.struts.action.ActionForm;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_BroLocDetails_rpt_Form extends ActionForm{

	String broId;
	String locId;
	public String getBroId() {
		return broId;
	}
	public void setBroId(String broId) {
		this.broId = broId;
	}
	public String getLocId() {
		return locId;
	}
	public void setLocId(String locId) {
		this.locId = locId;
	}
}
