package nic.watersoft.masters;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class AssetTypeForm extends ActionForm
{
	
		private String mode;
		private String assetTypeCode; 
		private String assetTypeName; 
		private String codeSeries;		

	public void setAssetTypeCode(String assetTypeCode)
	{
		this.assetTypeCode=assetTypeCode;
	}
	public String getAssetTypeCode()
	{
		return assetTypeCode;
	}
	public void setAssetTypeName(String assetTypeName)
	{
		this.assetTypeName=assetTypeName;
	}
	public String getAssetTypeName()
	{
		return assetTypeName;
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
		
			//System.out.println("sadiq in reset");
		 this.assetTypeCode="";
		 this.assetTypeName="";
		 this.codeSeries="";
		 
				
	}
	/**
 * @return Returns the codeSeries.
 */
public String getCodeSeries() {
	return codeSeries;
}
/**
 * @param codeSeries The codeSeries to set.
 */
public void setCodeSeries(String codeSeries) {
	this.codeSeries = codeSeries;
}

}