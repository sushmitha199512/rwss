package nic.watersoft.masters;

import java.io.Serializable;

public class AssetSourceBean implements Serializable
{
	
	private String habCode;
	private String assetTypeName; 
	private String assetCode;
	private String assetName;
	public AssetSourceBean()
	{
		
	}
	public AssetSourceBean(String habCode,String assetTypeName,String assetCode,String assetName)
	{
		this.habCode=habCode;
		this.assetTypeName=assetTypeName;
		this.assetCode=assetCode;
		this.assetName=assetName;
	}
	/**
	 * @return Returns the assetCode.
	 */
	public String getAssetCode() {
		return assetCode;
	}
	/**
	 * @param assetCode The assetCode to set.
	 */
	public void setAssetCode(String assetCode) {
		this.assetCode = assetCode;
	}
	/**
	 * @return Returns the assetName.
	 */
	public String getAssetName() {
		return assetName;
	}
	/**
	 * @param assetName The assetName to set.
	 */
	public void setAssetName(String assetName) {
		this.assetName = assetName;
	}
	/**
	 * @return Returns the assetTypeName.
	 */
	public String getAssetTypeName() {
		return assetTypeName;
	}
	/**
	 * @param assetTypeName The assetTypeName to set.
	 */
	public void setAssetTypeName(String assetTypeName) {
		this.assetTypeName = assetTypeName;
	}
	/**
	 * @return Returns the habCode.
	 */
	public String getHabCode() {
		return habCode;
	}
	/**
	 * @param habCode The habCode to set.
	 */
	public void setHabCode(String habCode) {
		this.habCode = habCode;
	}
}