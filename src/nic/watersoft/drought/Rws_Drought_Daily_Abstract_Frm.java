package nic.watersoft.drought;

import java.util.ArrayList;

import org.apache.struts.action.ActionForm;

public class Rws_Drought_Daily_Abstract_Frm extends ActionForm
{
	private String dist;
	
	private String absDate;
	private String trhabs;
	private String trpopserv;
	private String trqty;
	private String hshabs;
	private ArrayList abs;
	 private String trnooftrips;
	 private String cathabs;
	    
	    private String catpopserv;
	    private String catnooftrips;
	    private String catqty;
	
	public String getTrnooftrips() {
			return trnooftrips;
		}
		public void setTrnooftrips(String trnooftrips) {
			this.trnooftrips = trnooftrips;
		}
		public String getCathabs() {
			return cathabs;
		}
		public void setCathabs(String cathabs) {
			this.cathabs = cathabs;
		}
		public String getCatpopserv() {
			return catpopserv;
		}
		public void setCatpopserv(String catpopserv) {
			this.catpopserv = catpopserv;
		}
		public String getCatnooftrips() {
			return catnooftrips;
		}
		public void setCatnooftrips(String catnooftrips) {
			this.catnooftrips = catnooftrips;
		}
		public String getCatqty() {
			return catqty;
		}
		public void setCatqty(String catqty) {
			this.catqty = catqty;
		}
	/**
	 * @return Returns the abs.
	 */
	public ArrayList getAbs() {
		return abs;
	}
	/**
	 * @param abs The abs to set.
	 */
	public void setAbs(ArrayList abs) {
		this.abs = abs;
	}
	/**
	 * @return Returns the dist.
	 */
	public String getDist() {
		return dist;
	}
	/**
	 * @param dist The dist to set.
	 */
	public void setDist(String dist) {
		this.dist = dist;
	}
	/**
	 * @return Returns the hshabs.
	 */
	public String getHshabs() {
		return hshabs;
	}
	/**
	 * @param hshabs The hshabs to set.
	 */
	public void setHshabs(String hshabs) {
		this.hshabs = hshabs;
	}
	/**
	 * @return Returns the hspopserv.
	 */
	public String getHspopserv() {
		return hspopserv;
	}
	/**
	 * @param hspopserv The hspopserv to set.
	 */
	public void setHspopserv(String hspopserv) {
		this.hspopserv = hspopserv;
	}
	/**
	 * @return Returns the hssour.
	 */
	public String getHssour() {
		return hssour;
	}
	/**
	 * @param hssour The hssour to set.
	 */
	public void setHssour(String hssour) {
		this.hssour = hssour;
	}
	/**
	 * @return Returns the powhabs.
	 */
	public String getPowhabs() {
		return powhabs;
	}
	/**
	 * @param powhabs The powhabs to set.
	 */
	public void setPowhabs(String powhabs) {
		this.powhabs = powhabs;
	}
	/**
	 * @return Returns the sdrDate.
	 */
	
	/**
	 * @return Returns the tothabs.
	 */
	public String getTothabs() {
		return tothabs;
	}
	/**
	 * @param tothabs The tothabs to set.
	 */
	public void setTothabs(String tothabs) {
		this.tothabs = tothabs;
	}
	/**
	 * @return Returns the trhabs.
	 */
	public String getTrhabs() {
		return trhabs;
	}
	/**
	 * @param trhabs The trhabs to set.
	 */
	public void setTrhabs(String trhabs) {
		this.trhabs = trhabs;
	}
	/**
	 * @return Returns the trpopserv.
	 */
	public String getTrpopserv() {
		return trpopserv;
	}
	/**
	 * @param trpopserv The trpopserv to set.
	 */
	public void setTrpopserv(String trpopserv) {
		this.trpopserv = trpopserv;
	}
	/**
	 * @return Returns the trqty.
	 */
	public String getTrqty() {
		return trqty;
	}
	/**
	 * @param trqty The trqty to set.
	 */
	public void setTrqty(String trqty) {
		this.trqty = trqty;
	}
	private String hssour;
	private String hspopserv;
	private String powhabs;
	private String tothabs;
	
	
	/**
	 * @return Returns the absDate.
	 */
	public String getAbsDate() {
		return absDate;
	}
	/**
	 * @param absDate The absDate to set.
	 */
	public void setAbsDate(String absDate) {
		this.absDate = absDate;
	}
}