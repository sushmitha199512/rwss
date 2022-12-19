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
public class Asset_PipeMat {
	private String disMaterial;
	private String disMatCode;
	private String assetSubComp;
	

	/**
	 * 
	 */
	public Asset_PipeMat() {
		
	}
	
	
	/**
	 * @param disMaterial
	 * @param disMatCode
	 */
	public Asset_PipeMat(String disMaterial, String disMatCode) {
		super();
		this.disMaterial = disMaterial;
		this.disMatCode = disMatCode;
	}
	public Asset_PipeMat(String assetSubComp)
	{
		this.assetSubComp = assetSubComp;
	}
	
	/**
	 * @return Returns the disMatCode.
	 */
	public String getDisMatCode() {
		//System.out.println("it is in getdismatcode");
		return disMatCode;
	}
	/**
	 * @param disMatCode The disMatCode to set.
	 */
	public void setDisMatCode(String disMatCode) {
		this.disMatCode = disMatCode;
	}
	/**
	 * @return Returns the disMaterial.
	 */
	public String getDisMaterial() {
		return disMaterial;
	}
	/**
	 * @param disMaterial The disMaterial to set.
	 */
	public void setDisMaterial(String disMaterial) {
		this.disMaterial = disMaterial;
	}
}
