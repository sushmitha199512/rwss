package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class AssetSubCompTypeForm extends ActionForm
{
		private String mode;
		private String assetTypeCode; 
		private String assetCompTypeCode; 
		private String assetSubCompTypeName; 
		private String assetSubCompTypeCode; 
		
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
	public void setAssetSubCompTypeName(String assetSubCompTypeName)
	{
		this.assetSubCompTypeName=assetSubCompTypeName;
	}
	public String getAssetSubCompTypeName()
	{
		return assetSubCompTypeName;
	}
	public void setAssetSubCompTypeCode(String assetSubCompTypeCode)
	{
		this.assetSubCompTypeCode=assetSubCompTypeCode;
	}
	public String getAssetSubCompTypeCode()
	{
		return assetSubCompTypeCode;
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
		

		 this.assetTypeCode=" ";
		 this.assetCompTypeCode=" ";
		 this.assetSubCompTypeName=" ";
		 this.assetSubCompTypeCode=" ";
		 
				
	}
	
}