/*
 * Created on 16-Feb-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * @author NIC
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class HabDetails implements Serializable {
	 
	String dcode;
	String mcode;
	String vcode;
	String pcode;
	String pname;
	String vname;
	String mname;
	String habName;
	String coverageStatus;
	
	ArrayList habworkdetails=new ArrayList();
	
	
	

	/**
	 * @return Returns the habworkdetails.
	 */
	public ArrayList getHabworkdetails() {
		return habworkdetails;
	}
	/**
	 * @param habworkdetails The habworkdetails to set.
	 */
	public void setHabworkdetails(ArrayList habworkdetails) {
		this.habworkdetails = habworkdetails;
	}
	/**
	 * @return Returns the mname.
	 */
	public String getMname() {
		return mname;
	}
	/**
	 * @param mname The mname to set.
	 */
	public void setMname(String mname) {
		this.mname = mname;
	}
	/**
	 * @return Returns the pname.
	 */
	public String getPname() {
		return pname;
	}
	/**
	 * @param pname The pname to set.
	 */
	public void setPname(String pname) {
		this.pname = pname;
	}
	/**
	 * @return Returns the vname.
	 */
	public String getVname() {
		return vname;
	}
	/**
	 * @param vname The vname to set.
	 */
	public void setVname(String vname) {
		this.vname = vname;
	}
	/**
	 * @return Returns the dcode.
	 */
	public String getDcode() {
		return dcode;
	}
	/**
	 * @param dcode The dcode to set.
	 */
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	/**
	 * @return Returns the mcode.
	 */
	public String getMcode() {
		return mcode;
	}
	/**
	 * @param mcode The mcode to set.
	 */
	public void setMcode(String mcode) {
		this.mcode = mcode;
	}
	/**
	 * @return Returns the pcode.
	 */
	public String getPcode() {
		return pcode;
	}
	/**
	 * @param pcode The pcode to set.
	 */
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	/**
	 * @return Returns the vcode.
	 */
	public String getVcode() {
		return vcode;
	}
	/**
	 * @param vcode The vcode to set.
	 */
	public void setVcode(String vcode) {
		this.vcode = vcode;
	}
	/**
	 * @return Returns the habName.
	 */
	public String getHabName() {
		return habName;
	}
	/**
	 * @param habName The habName to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
	}
	/**
	 * @return Returns the coverageStatus.
	 */
	public String getCoverageStatus() {
		return coverageStatus;
	}
	/**
	 * @param coverageStatus The coverageStatus to set.
	 */
	public void setCoverageStatus(String coverageStatus) {
		this.coverageStatus = coverageStatus;
	}
}
