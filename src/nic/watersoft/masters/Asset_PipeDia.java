/*
 * Created on Sep 4, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Asset_PipeDia {
	private String disDiameter;
	private String disMatCode;
	private String assetSubComp;

	
	/**
	 * 
	 */
	public Asset_PipeDia() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * @param disDiameter
	 * @param disMatCode
	 * @param assetSubComp
	 */
	public Asset_PipeDia(String disDiameter, String disMatCode,
			String assetSubComp) {
		super();
		this.disDiameter = disDiameter;
		this.disMatCode = disMatCode;
		this.assetSubComp = assetSubComp;
	}
	/**
	 * @return Returns the assetSubComp.
	 */
	public String getAssetSubComp() {
		return assetSubComp;
	}
	/**
	 * @param assetSubComp The assetSubComp to set.
	 */
	public void setAssetSubComp(String assetSubComp) {
		this.assetSubComp = assetSubComp;
	}
	/**
	 * @return Returns the disDiameter.
	 */
	public String getDisDiameter() {
		return disDiameter;
	}
	/**
	 * @param disDiameter The disDiameter to set.
	 */
	public void setDisDiameter(String disDiameter) {
		this.disDiameter = disDiameter;
	}
	/**
	 * @return Returns the disMatCode.
	 */
	public String getDisMatCode() {
		return disMatCode;
	}
	/**
	 * @param disMatCode The disMatCode to set.
	 */
	public void setDisMatCode(String disMatCode) {
		this.disMatCode = disMatCode;
	}
}
