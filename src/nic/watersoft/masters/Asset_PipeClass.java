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
public class Asset_PipeClass {
	private String disClass;
	private String disMatCode;
	private String assetSubComp;

	/**
	 * 
	 */
	public Asset_PipeClass() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * @param disClass
	 * @param disMatCode
	 * @param assetSubComp
	 */
	public Asset_PipeClass(String disClass, String disMatCode,
			String assetSubComp) {
		super();
		this.disClass = disClass;
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
	 * @return Returns the disClass.
	 */
	public String getDisClass() {
		return disClass;
	}
	/**
	 * @param disClass The disClass to set.
	 */
	public void setDisClass(String disClass) {
		this.disClass = disClass;
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
