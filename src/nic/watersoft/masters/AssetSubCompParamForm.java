/*
 * Created on Jan 10, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

/**
 * 
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class AssetSubCompParamForm extends ActionForm 
{
	HttpSession session;
	ArrayList assetSubCompTypes=new ArrayList();
	ArrayList assetCompTypes=new ArrayList();
	
	private String assetTypeCode;
	private String assetCompTypeCode;
	private String assetSubCompTypeCode;
	private String measurementType;
	private String unitOfMeasure;
	private String mode;
	
	/**
	 * @return Returns the assetCompTypeCode.
	 */
	public String getAssetCompTypeCode() {
		return assetCompTypeCode;
	}
	/**
	 * @param assetCompTypeCode The assetCompTypeCode to set.
	 */
	public void setAssetCompTypeCode(String assetCompTypeCode) {
		this.assetCompTypeCode = assetCompTypeCode;
	}
	/**
	 * @return Returns the assetSubCompTypeCode.
	 */
	public String getAssetSubCompTypeCode() {
		return assetSubCompTypeCode;
	}
	/**
	 * @param assetSubCompTypeCode The assetSubCompTypeCode to set.
	 */
	public void setAssetSubCompTypeCode(String assetSubCompTypeCode) {
		this.assetSubCompTypeCode = assetSubCompTypeCode;
	}
	/**
	 * @return Returns the assetTypeCode.
	 */
	public String getAssetTypeCode() {
		return assetTypeCode;
	}
	/**
	 * @param assetTypeCode The assetTypeCode to set.
	 */
	public void setAssetTypeCode(String assetTypeCode) {
		this.assetTypeCode = assetTypeCode;
	}
	/**
	 * @return Returns the measurementType.
	 */
	public String getMeasurementType() {
		return measurementType;
	}
	/**
	 * @param measurementType The measurementType to set.
	 */
	public void setMeasurementType(String measurementType) {
		this.measurementType = measurementType;
	}
	/**
	 * @return Returns the unitOfMeasure.
	 */
	public String getUnitOfMeasure() {
		return unitOfMeasure;
	}
	/**
	 * @param unitOfMeasure The unitOfMeasure to set.
	 */
	public void setUnitOfMeasure(String unitOfMeasure) {
		this.unitOfMeasure = unitOfMeasure;
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
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		session = request.getSession();
		assetCompTypes = (ArrayList)session.getAttribute("assetCompTypes");
		assetSubCompTypes = (ArrayList)session.getAttribute("assetSubCompTypes");
		if(assetCompTypes != null)
			assetCompTypes.clear();
		if(assetSubCompTypes != null)
			assetSubCompTypes.clear();
		assetTypeCode="";
		measurementType="";
		unitOfMeasure="";
		
	}
	
	
}
