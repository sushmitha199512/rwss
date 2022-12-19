package nic.watersoft.wquality;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

/*
 * Created on Nov 16, 2005
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

/**
 * @author Administrator
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class WQFinalise_IdenForm extends ActionForm
{
	 private String circleOfficeCode;
	 private String divisionOfficeCode;
	 private String subdivisionOfficeCode;
	 private String habCode;
	 private String sourceCode;
	 private String prgmCode;
	 private String subprgmCode;
	 private String workCode;
	 private FormFile sitePlan;
	 private String casing;
	 private String depth;
	 private String yield;
	 private String source1;
	 private String depth1;
	 private String yield1;
	 private String source2;
	 private String depth2;
	 private String yield2;
	 private String source3;
	 private String depth3;
	 private String yield3;
	 private String empcode;
	 private String siteIdenData;
	 private String finalised;
	 private String finalDate;
	 private String remarks;
	 private String preparedBy;
	 private String preparedOn;
	 private String mode;
	 
	 private String newSource;
	 private String sourceType; 
	 private String schemeCode;
	 private String rno;
	 private String schemeRep;
	 private String sourceCode1;
	 private String sourceCode2;
	 private String SourceCode3;
	 private String assetTypeCode;
	 private String compTypeCode;
	 private String subCompTypeCode;
	 
	 
	public String getNewSource() {
		return newSource;
	}
	public void setNewSource(String newSource) {
		this.newSource = newSource;
	}
	 
	/**
	 * @return Returns the casing.
	 */
	public String getCasing() {
		return casing;
	}
	/**
	 * @param casing The casing to set.
	 */
	public void setCasing(String casing) {
		this.casing = casing;
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
	 * @return Returns the depth.
	 */
	public String getDepth() {
		return depth;
	}
	/**
	 * @param depth The depth to set.
	 */
	public void setDepth(String depth) {
		this.depth = depth;
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
	 * @return Returns the empcode.
	 */
	public String getEmpcode() {
		return empcode;
	}
	/**
	 * @param empcode The empcode to set.
	 */
	public void setEmpcode(String empcode) {
		this.empcode = empcode;
	}
	/**
	 * @return Returns the finalDate.
	 */
	public String getFinalDate() {
		return finalDate;
	}
	/**
	 * @param finalDate The finalDate to set.
	 */
	public void setFinalDate(String finalDate) {
		this.finalDate = finalDate;
	}
	/**
	 * @return Returns the finalised.
	 */
	public String getFinalised() {
		return finalised;
	}
	/**
	 * @param finalised The finalised to set.
	 */
	public void setFinalised(String finalised) {
		this.finalised = finalised;
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
		return preparedOn;
	}
	/**
	 * @param preparedOn The preparedOn to set.
	 */
	public void setPreparedOn(String preparedOn) {
		this.preparedOn = preparedOn;
	}
	/**
	 * @return Returns the prgmCode.
	 */
	public String getPrgmCode() {
		return prgmCode;
	}
	/**
	 * @param prgmCode The prgmCode to set.
	 */
	public void setPrgmCode(String prgmCode) {
		this.prgmCode = prgmCode;
	}
	/**
	 * @return Returns the remarks.
	 */
	public String getRemarks() {
		return remarks;
	}
	/**
	 * @param remarks The remarks to set.
	 */
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	/**
	 * @return Returns the siteIdenData.
	 */
	public String getSiteIdenData() {
		return siteIdenData;
	}
	/**
	 * @param siteIdenData The siteIdenData to set.
	 */
	public void setSiteIdenData(String siteIdenData) {
		this.siteIdenData = siteIdenData;
	}
	/**
	 * @return Returns the sitePlan.
	 */
	public FormFile getSitePlan() {
		return sitePlan;
	}
	/**
	 * @param sitePlan The sitePlan to set.
	 */
	public void setSitePlan(FormFile sitePlan) {
		this.sitePlan = sitePlan;
	}
	/**
	 * @return Returns the sourceCode.
	 */
	public String getSourceCode() {
		return sourceCode;
	}
	/**
	 * @param sourceCode The sourceCode to set.
	 */
	public void setSourceCode(String sourceCode) {
		this.sourceCode = sourceCode;
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
	 * @return Returns the subprgmCode.
	 */
	public String getSubprgmCode() {
		return subprgmCode;
	}
	/**
	 * @param subprgmCode The subprgmCode to set.
	 */
	public void setSubprgmCode(String subprgmCode) {
		this.subprgmCode = subprgmCode;
	}
	/**
	 * @return Returns the source1.
	 */
	public String getSource1() {
		return source1;
	}
	/**
	 * @param source1 The source1 to set.
	 */
	public void setSource1(String source1) {
		this.source1 = source1;
	}
	/**
	 * @return Returns the depth1.
	 */
	public String getDepth1() {
		return depth1;
	}
	/**
	 * @param depth1 The depth1 to set.
	 */
	public void setDepth1(String depth1) {
		this.depth1 = depth1;
	}
	/**
	 * @return Returns the yield1.
	 */
	public String getYield1() {
		return yield1;
	}
	/**
	 * @param yield1 The yield1 to set.
	 */
	public void setYield1(String yield1) {
		this.yield1 = yield1;
	}
	/**
	 * @return Returns the source2.
	 */
	public String getSource2() {
		return source2;
	}
	/**
	 * @param source2 The source2 to set.
	 */
	public void setSource2(String source2) {
		this.source2 = source2;
	}
	/**
	 * @return Returns the depth2.
	 */
	public String getDepth2() {
		return depth2;
	}
	/**
	 * @param depth2 The depth2 to set.
	 */
	public void setDepth2(String depth2) {
		this.depth2 = depth2;
	}
	/**
	 * @return Returns the yield2.
	 */
	public String getYield2() {
		return yield2;
	}
	/**
	 * @param yield2 The yield2 to set.
	 */
	public void setYield2(String yield2) {
		this.yield2 = yield2;
	}
	/**
	 * @return Returns the source3.
	 */
	public String getSource3() {
		return source3;
	}
	/**
	 * @param source3 The source3 to set.
	 */
	public void setSource3(String source3) {
		this.source3 = source3;
	}
	/**
	 * @return Returns the depth3.
	 */
	public String getDepth3() {
		return depth3;
	}
	/**
	 * @param depth3 The depth3 to set.
	 */
	public void setDepth3(String depth3) {
		this.depth3 = depth3;
	}
	/**
	 * @return Returns the yield3.
	 */
	public String getYield3() {
		return yield3;
	}
	/**
	 * @param yield3 The yield3 to set.
	 */
	public void setYield3(String yield3) {
		this.yield3 = yield3;
	}

	/**
	 * @return Returns the workCode.
	 */
	public String getWorkCode() {
		return workCode;
	}
	/**
	 * @param workCode The workCode to set.
	 */
	public void setWorkCode(String workCode) {
		this.workCode = workCode;
	}
	/**
	 * @return Returns the yield.
	 */
	public String getYield() {
		return yield;
	}
	/**
	 * @param yield The yield to set.
	 */
	public void setYield(String yield) {
		this.yield = yield;
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
		this.habCode="";              
		this.sourceCode="";           
		this.prgmCode="";             
		this.subprgmCode="";          
		this.workCode="";             
		this.casing="";               
		this.depth="";                
		this.yield="";                
		this.source1="";
		this.source2="";
		this.source3="";
		this.depth1="";
		this.depth2="";
		this.depth3="";
		this.yield1="";            
		this.yield2=""; 
		this.yield3=""; 
		this.empcode="";              
		this.siteIdenData="";         
		this.finalised="";            
		this.finalDate="";            
		this.remarks="";              
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	public String getRno() {
		return rno;
	}
	public void setRno(String rno) {
		this.rno = rno;
	}
	public String getSchemeCode() {
		return schemeCode;
	}
	public void setSchemeCode(String schemeCode) {
		this.schemeCode = schemeCode;
	}
	public String getSchemeRep() {
		return schemeRep;
	}
	public void setSchemeRep(String schemeRep) {
		this.schemeRep = schemeRep;
	}
	public String getSourceCode1() {
		return sourceCode1;
	}
	public void setSourceCode1(String sourceCode1) {
		this.sourceCode1 = sourceCode1;
	}
	public String getSourceCode2() {
		return sourceCode2;
	}
	public void setSourceCode2(String sourceCode2) {
		this.sourceCode2 = sourceCode2;
	}
	public String getSourceCode3() {
		return SourceCode3;
	}
	public void setSourceCode3(String sourceCode3) {
		SourceCode3 = sourceCode3;
	}
	public String getAssetTypeCode() {
		return assetTypeCode;
	}
	public void setAssetTypeCode(String assetTypeCode) {
		this.assetTypeCode = assetTypeCode;
	}
	public String getSubCompTypeCode() {
		return subCompTypeCode;
	}
	public void setSubCompTypeCode(String subCompTypeCode) {
		this.subCompTypeCode = subCompTypeCode;
	}
	public String getCompTypeCode() {
		return compTypeCode;
	}
	public void setCompTypeCode(String compTypeCode) {
		this.compTypeCode = compTypeCode;
	}
}
