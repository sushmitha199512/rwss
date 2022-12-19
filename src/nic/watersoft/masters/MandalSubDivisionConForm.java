/*
 * Created on 26-Aug-2011
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

/**
 * @author sadiq
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import nic.watersoft.works.tenderMemo;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class MandalSubDivisionConForm extends ActionForm
{
	private String dcode;
	private String doc;
	private String sdoc;
	private String district;
	private String mandal;
	private String mode;
	private String con;
	private String don;
	private String sdon;
	private String dname;
	private String sdname;
	private String mandalName;
	private String dnameCode;
	private String sdnameCode;
	/**
	 * @return Returns the sdname.
	 */
	public String getSdname() {
		return sdname;
	}
	/**
	 * @param sdname The sdname to set.
	 */
	public void setSdname(String sdname) {
		this.sdname = sdname;
	}
	
	
	/**
	 * @return Returns the con.
	 */
	public String getCon() {
		return con;
	}
	/**
	 * @param con The con to set.
	 */
	public void setCon(String con) {
		this.con = con;
	}
	/**
	 * @return Returns the district.
	 */
	public String getDistrict() {
		return district;
	}
	/**
	 * @param district The district to set.
	 */
	public void setDistrict(String district) {
		this.district = district;
	}
	/**
	 * @return Returns the dname.
	 */
	public String getDname() {
		return dname;
	}
	/**
	 * @param dname The dname to set.
	 */
	public void setDname(String dname) {
		this.dname = dname;
	}
	/**
	 * @return Returns the doc.
	 */
	public String getDoc() {
		return doc;
	}
	/**
	 * @param doc The doc to set.
	 */
	public void setDoc(String doc) {
		this.doc = doc;
	}
	/**
	 * @return Returns the don.
	 */
	public String getDon() {
		return don;
	}
	/**
	 * @param don The don to set.
	 */
	public void setDon(String don) {
		this.don = don;
	}
	/**
	 * @return Returns the mandal.
	 */
	public String getMandal() {
		return mandal;
	}
	/**
	 * @param mandal The mandal to set.
	 */
	public void setMandal(String mandal) {
		this.mandal = mandal;
	}
	/**
	 * @return Returns the mandalName.
	 */
	public String getMandalName() {
		return mandalName;
	}
	/**
	 * @param mandalName The mandalName to set.
	 */
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
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
	/**
	 * @return Returns the sdoc.
	 */
	public String getSdoc() {
		return sdoc;
	}
	/**
	 * @param sdoc The sdoc to set.
	 */
	public void setSdoc(String sdoc) {
		this.sdoc = sdoc;
	}
	/**
	 * @return Returns the sdon.
	 */
	public String getSdon() {
		return sdon;
	}
	/**
	 * @param sdon The sdon to set.
	 */
	public void setSdon(String sdon) {
		this.sdon = sdon;
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
	 * @return Returns the dnameCode.
	 */
	public String getDnameCode() {
		return dnameCode;
	}
	/**
	 * @param dnameCode The dnameCode to set.
	 */
	public void setDnameCode(String dnameCode) {
		this.dnameCode = dnameCode;
	}
	/**
	 * @return Returns the sdnameCode.
	 */
	public String getSdnameCode() {
		return sdnameCode;
	}
	/**
	 * @param sdnameCode The sdnameCode to set.
	 */
	public void setSdnameCode(String sdnameCode) {
		this.sdnameCode = sdnameCode;
	}
}
