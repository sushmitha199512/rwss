package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class AssetCompTypeForm extends ActionForm
{
	private String mode;
	private String assetTypeCode; 
	private String assetCompTypeCode; 
	private String assetCompTypeName; 
	
	public void setAssetTypeCode(String assetTypeCode)
	{
		this.assetTypeCode=assetTypeCode;
	}
	public String getAssetTypeCode()
	{
		return assetTypeCode;
	}
	public void setAssetCompTypeCode(String assetCompTypeCode)
	{
		this.assetCompTypeCode=assetCompTypeCode;
	}
	public String getAssetCompTypeCode()
	{
		return assetCompTypeCode;
	}
	public void setAssetCompTypeName(String assetCompTypeName)
	{
		this.assetCompTypeName=assetCompTypeName;
	}
	public String getAssetCompTypeName()
	{
		return assetCompTypeName;
	}
	/**
	 * @param mode The mode to set.
	 */
	public void setMode(String mode)
	{
		this.mode=mode;
	}
	/**
	 * @return Returns the mode.
	 */
	public String getMode()
	{
		return mode;
	}
	
		


		public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		

		 this.assetTypeCode="";
		 this.assetCompTypeCode="";
		 this.assetCompTypeName="";
	
		 
				
	}
	
}