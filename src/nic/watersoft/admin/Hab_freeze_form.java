/*
 * Created on Nov 6, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.admin;
import java.io.Serializable;

import org.apache.struts.action.*;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Hab_freeze_form  extends ActionForm implements Serializable{
	String mdistrict;
	String mhabstatus;
	
	
	/**
	 * @return Returns the mdistrict.
	 */
	public String getMdistrict() {
		return mdistrict;
		
	}
	/**
	 * @param mdistrict The mdistrict to set.
	 */
	public void setMdistrict(String mdistrict) {
		this.mdistrict = mdistrict;
	}
	/**
	 * @return Returns the mhabstatus.
	 */
	public String getMhabstatus() {
		return mhabstatus;
	}
	/**
	 * @param mhabstatus The mhabstatus to set.
	 */
	public void setMhabstatus(String mhabstatus) {
		this.mhabstatus = mhabstatus;
	}
}
