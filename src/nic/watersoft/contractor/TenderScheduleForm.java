/*
 * Created on Jan 17, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.contractor;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

 

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

/**
 * @author  
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class TenderScheduleForm extends ActionForm
{
	private String headOfficeCode;
	private String circleOfficeCode;
	private String divisionOfficeCode;
	private String subdivisionOfficeCode;
	private String workId;
	private String assetTypeCode;
	private String preparedBy;
	private String PreparedOn;
	private String mode;
	private FormFile tenderForm;
	private ArrayList workComponents;
	
	public TenderScheduleForm() 
	{
		workComponents = new ArrayList();
	}
	/**
	 * @return Returns the circleOfficeCode.
	 */
	public String getCircleOfficeCode() {
		return circleOfficeCode;
	}
	/**
	 * @param circleOfficeCode The circleOfficeCode to set.
	 */
	public void setCircleOfficeCode(String circleOfficeCode) {
		this.circleOfficeCode = circleOfficeCode;
	}
	/**
	 * @return Returns the divisionOfficeCode.
	 */
	public String getDivisionOfficeCode() {
		return divisionOfficeCode;
	}
	/**
	 * @param divisionOfficeCode The divisionOfficeCode to set.
	 */
	public void setDivisionOfficeCode(String divisionOfficeCode) {
		this.divisionOfficeCode = divisionOfficeCode;
	}
	/**
	 * @return Returns the headOfficeCode.
	 */
	public String getHeadOfficeCode() {
		return headOfficeCode;
	}
	/**
	 * @param headOfficeCode The headOfficeCode to set.
	 */
	public void setHeadOfficeCode(String headOfficeCode) {
		this.headOfficeCode = headOfficeCode;
	}
	/**
	 * @return Returns the subdivisionOfficeCode.
	 */
	public String getSubdivisionOfficeCode() {
		return subdivisionOfficeCode;
	}
	/**
	 * @param subdivisionOfficeCode The subdivisionOfficeCode to set.
	 */
	public void setSubdivisionOfficeCode(String subdivisionOfficeCode) {
		this.subdivisionOfficeCode = subdivisionOfficeCode;
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
	 * @return Returns the preparedBy.
	 */
	public String getPreparedBy() {
		return preparedBy;
	}
	/**
	 * @param preparedBy The preparedBy to set.
	 */
	public void setPreparedBy(String preparedBy) {
		this.preparedBy = preparedBy;
	}
	/**
	 * @return Returns the preparedOn.
	 */
	public String getPreparedOn() {
		return PreparedOn;
	}
	/**
	 * @param preparedOn The preparedOn to set.
	 */
	public void setPreparedOn(String preparedOn) {
		PreparedOn = preparedOn;
	}
	/**
	 * @return Returns the workId.
	 */
	public String getWorkId() {
		return workId;
	}
	/**
	 * @param workId The workId to set.
	 */
	public void setWorkId(String workId) {
		this.workId = workId;
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
	 * @return Returns the workComponents.
	 */
	public ArrayList getWorkComps() {
		return workComponents;
	}
	
	
	/**
	 * @return Returns the tenderForm.
	 */
	public FormFile getTenderForm() {
		return tenderForm;
	}
	/**
	 * @param tenderForm The tenderForm to set.
	 */
	public void setTenderForm(FormFile tenderForm) {
		this.tenderForm = tenderForm;
	
	}
	/**
	 * @param workComponents The workComponents to set.
	 */
	public void setWorkComps(ArrayList workComponents) {
		this.workComponents = workComponents;
	}
	public TenderScheduleACompForm getWORKCOMPONENT_LIST(int index)
	{
		//System.out.println("index in  getWORKCOMPONENT_LIST():"+index);
		while(index >= workComponents.size())
		{
			workComponents.add(new TenderScheduleACompForm());
		}
		 
	return (TenderScheduleACompForm)((ArrayList) workComponents).get(index);
	}
	
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		assetTypeCode="";
		preparedBy="";
		PreparedOn="";
	}
	
}
