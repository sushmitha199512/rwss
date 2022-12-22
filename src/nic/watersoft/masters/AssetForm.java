package nic.watersoft.masters;

import java.util.ArrayList;
import java.util.Collection;

//import nic.watersoft.commons.Debug;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

public class AssetForm extends ActionForm
{
	//added by swapna on 17-01-2012 for gis data entry
	private String latitude;
	private String longitude;
	private String elevation;
	private String waypoint;
	//
	
	private String officeCode;
	private String officeName;
	private String headOfficeCode;
	private String headOfficeName;
	private String circleOfficeCode;
	private String circleOfficeName;
	private String divisionOfficeCode;
	private String divisionOfficeName;
	private String subdivisionOfficeCode;
	private String subdivisionOfficeName;
	private String dpYield;
	
	//added by ramesh on 060110
	
	private String program;
	private String subprogram;
	
	private String toDo;
	private String mode;
	private String coc;
	private String doc;
	private String sdoc;
	private String district;
	
	private String dcode;
	private String mandal;
	private String mandalName;
    private String con;
    private String don;
    private String sdon;
    private String habName;
	private String pcode;
	private String vcode;
	private String assetCode;
	private String assetName;
	private String assetTypeCode;
	private String assetTypeName;
	private String assetCompTypeCode;
	private String assetSubCompTypeCode;
	private String habCode;
	private String dateofCreation;
	private String location;
	private String assetStatus;
	private String defunctReasons;
	private String assetStatusName;
	private String assetCost;
	private String startYear;
	private String endYear;
	
	private int totHabs;
	private int totPopBenfit;
	private String remarks;
	
	private String yield;
	private Collection assetHabs;
	private ArrayList assetSubComponents;
	private ArrayList  assetPipeLine;
	private ArrayList  rwsMaster;
	private ArrayList assetHeadWorks;
	private ArrayList assetReservior;
	private ArrayList assetPumpSets;
	private ArrayList assetPonds;
	private ArrayList assetSHP;
	private ArrayList assetOpenWells;
	private ArrayList assetOthers;
	private ArrayList sourceHabs;

	
	private String pumpCode;
    private String opType="";
    
    private ArrayList pipeMaterial;
    private ArrayList pipeClass;
    private ArrayList pipeDiameter;
	private String material;
	private String disCode;
	
    private String pclass;
    private String diameter;
    private String length;
	private String pipeMat1;
	private String pipeMat2;
	private String pipeMat3;
	
	private String addHabsDistrict;
	
	private String addHabsDistrictName;
	private String addHabsMandalName;
	private String addHabsMandal;
	private String addHabsHabitation;
	private FormFile uploadAsset;
	private String waterBeingSupplied;
	private String lastRepairedDate;
	private String power;
	private String meterial;
	private String salaries;
	private String finYear;
	private String total;

	public AssetForm() 
	{
		assetHabs = new ArrayList();
		assetSubComponents = new ArrayList();
		assetHeadWorks  = new ArrayList();
		assetPipeLine  = new ArrayList();
		assetReservior = new ArrayList();
		assetPumpSets=new ArrayList();
		assetPonds=new ArrayList();
		assetSHP=new  ArrayList();
		assetOpenWells=new  ArrayList();;
		assetOthers=new  ArrayList();;
		pipeMaterial  = new ArrayList();
		pipeClass  = new ArrayList();
		pipeDiameter=new ArrayList();
		sourceHabs=new ArrayList();
		
	}
	
	
	public String getTotal() {
		return total;
	}


	public void setTotal(String total) {
		this.total = total;
	}


	public String getFinYear() {
		return finYear;
	}


	public void setFinYear(String finYear) {
		this.finYear = finYear;
	}


	public String getPower() {
		return power;
	}


	public void setPower(String power) {
		this.power = power;
	}


	public String getMeterial() {
		return meterial;
	}


	public void setMeterial(String meterial) {
		this.meterial = meterial;
	}


	public String getSalaries() {
		return salaries;
	}


	public void setSalaries(String salaries) {
		this.salaries = salaries;
	}


	public String getLastRepairedDate() {
		return lastRepairedDate;
	}


	public void setLastRepairedDate(String lastRepairedDate) {
		this.lastRepairedDate = lastRepairedDate;
	}


	
	public String getWaterBeingSupplied() {
		return waterBeingSupplied;
	}


	public void setWaterBeingSupplied(String waterBeingSupplied) {
		this.waterBeingSupplied = waterBeingSupplied;
	}


	public FormFile getUploadAsset() {
		return uploadAsset;
	}


	public void setUploadAsset(FormFile uploadAsset) {
		this.uploadAsset = uploadAsset;
	}


	public Collection getAssetHabs() 
	{
	 
		return assetHabs;		
	}
	public void setAssetHabs(Collection assetHabs) 
	{
		this.assetHabs = assetHabs;
		 
	}
	
	public ArrayList getAssetSubComponents() 
	{
	 
		return assetSubComponents;		
	}
	public void setAssetSubComponents(ArrayList assetSubComponents) 
	{
		this.assetSubComponents = assetSubComponents;
	 
	}
	
	public ArrayList getAssetHeadWorks() 
	{
 
		return assetHeadWorks;		
	}
	public void setAssetHeadWorks(ArrayList assetHeadWorks) 
	{
		this.assetHeadWorks = assetHeadWorks;
 
	}
	public ArrayList getAssetPipeLine() 
	{
   //System.out.println("get in pipeline");
		return assetPipeLine;		
	}
	public void setAssetPipeLine(ArrayList assetPipeLine) 
	{
		this.assetPipeLine = assetPipeLine;
	 
	}
	public ArrayList getAssetReservior() 
	{
	 
		return assetReservior;		
	}
	public void setAssetReservior(ArrayList assetReservior) 
	{
		this.assetReservior = assetReservior;
	 
	}
		
	
	public ArrayList getAssetPumpSets() {
		//System.out.println("sadiq in pumpsets");
		return assetPumpSets;
	}
	public void setAssetPumpSets(ArrayList assetPumpSets) {
		this.assetPumpSets = assetPumpSets;
	}
	public PanchRaj getASSETHAB_LIST(int index)
	{
		while(index >= assetHabs.size())
		{
			assetHabs.add(new PanchRaj());
		}
		return (PanchRaj)((ArrayList) assetHabs).get(index);
	}
	public  Asset_SubComponent  getASSETSUBCOMPONENTS_LIST(int index)
	{
	 
		while(index >= assetSubComponents.size())
		{
			assetSubComponents.add(new Asset_SubComponent());
		}
	 
		return (Asset_SubComponent)assetSubComponents.get(index);
	}
	public Asset_HeadWorks getASSETHEADWORK_LIST(int index)
	{
		while(index >= assetHeadWorks.size())
		{
			assetHeadWorks.add(new Asset_HeadWorks());
		}
	return (Asset_HeadWorks)assetHeadWorks.get(index);
	}

	public Asset_PipeLine getASSETPIPELINE_LIST(int index)
	{
		
		while(index >= assetPipeLine.size())
		{
			assetPipeLine.add(new Asset_PipeLine());
		}
		
	return (Asset_PipeLine)assetPipeLine.get(index);
		
	}

	public Asset_Reservior getASSETRESERVIOR_LIST(int index)
	{
		while(index >= assetReservior.size())
		{
			assetReservior.add(new Asset_Reservior());
		}
	return (Asset_Reservior)assetReservior.get(index);
	}
	public  Asset_Pumpset  getASSETPUMPSET_LIST(int index)
	{
	 
		while(index >= assetPumpSets.size())
		{
			assetPumpSets.add(new Asset_Pumpset());
		}
	 
		return (Asset_Pumpset)assetPumpSets.get(index);
	}
	public  Asset_Ponds  getASSETPONDS_LIST(int index)
	{
	 
		while(index >= assetPonds.size())
		{
			assetPonds.add(new Asset_Ponds());
		}
	 
		return (Asset_Ponds)assetPonds.get(index);
	}
	public  Asset_OpenWells  getASSETOPENWELLS_LIST(int index)
	{
	 
		while(index >= assetOpenWells.size())
		{
			assetOpenWells.add(new Asset_OpenWells());
		}
	 
		return (Asset_OpenWells)assetOpenWells.get(index);
	}
	public  Asset_Others  getASSETOTHERS_LIST(int index)
	{
	 
		while(index >= assetOthers.size())
		{
			assetOthers.add(new Asset_Others());
		}
	 
		return (Asset_Others)assetOthers.get(index);
	}
	public  Asset_SHP  getASSETSHP_LIST(int index)
	{
	 
		while(index >= assetSHP.size())
		{
			assetSHP.add(new Asset_SHP());
		}
	 
		return (Asset_SHP)assetSHP.get(index);
	}
	public  Asset_PipeMat getASSETPIPEMAT_LIST(int index)
	{
	 
		while(index >= pipeMaterial.size())
		{
			pipeMaterial.add(new Asset_PipeMat());
		}
		
		return (Asset_PipeMat)pipeMaterial.get(index);
	}
	
	public HabSourceBean getSOURCEHAB_LIST(int index)
	{
		while(index >= sourceHabs.size())
		{
			//System.out.println("index in getSOURCEHAB_LIST= "+index);
			sourceHabs.add(new HabSourceBean());
			
		}
		return (HabSourceBean)sourceHabs.get(index);
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
	 * @return Returns the circleOfficeName.
	 */
	public String getCircleOfficeName() {
		return circleOfficeName;
	}
	/**
	 * @param circleOfficeName The circleOfficeName to set.
	 */
	public void setCircleOfficeName(String circleOfficeName) {
		this.circleOfficeName = circleOfficeName;
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
	 * @return Returns the divisionOfficeName.
	 */
	public String getDivisionOfficeName() {
		return divisionOfficeName;
	}
	/**
	 * @param divisionOfficeName The divisionOfficeName to set.
	 */
	public void setDivisionOfficeName(String divisionOfficeName) {
		this.divisionOfficeName = divisionOfficeName;
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
	 * @return Returns the headOfficeName.
	 */
	public String getHeadOfficeName() {
		return headOfficeName;
	}
	/**
	 * @param headOfficeName The headOfficeName to set.
	 */
	public void setHeadOfficeName(String headOfficeName) {
		this.headOfficeName = headOfficeName;
	}
	/**
	 * @return Returns the officeCode.
	 */
	public String getOfficeCode() {
		return officeCode;
	}
	/**
	 * @param officeCode The officeCode to set.
	 */
	public void setOfficeCode(String officeCode) {
		this.officeCode = officeCode;
	}
	/**
	 * @return Returns the officeName.
	 */
	public String getOfficeName() {
		return officeName;
	}
	/**
	 * @param officeName The officeName to set.
	 */
	public void setOfficeName(String officeName) {
		this.officeName = officeName;
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
	 * @return Returns the subdivisionOfficeName.
	 */
	public String getSubdivisionOfficeName() {
		return subdivisionOfficeName;
	}
	/**
	 * @param subdivisionOfficeName The subdivisionOfficeName to set.
	 */
	public void setSubdivisionOfficeName(String subdivisionOfficeName) {
		this.subdivisionOfficeName = subdivisionOfficeName;
	}
	/**
	 * @return Returns the dcode.
	 */
	public String getDcode() {
		return dcode;
	}
	/**
	 * @param dcode The dcode to set.
	 */
	public void setDcode(String dcode) {
		this.dcode = dcode;
	}
	
	public void setCoc(String coc)
	{
		this.coc=coc;
	}
	public String getCoc()
	{
		return coc;
	}
	public void setDoc(String doc)
	{
		this.doc=doc;
	}
	public String getDoc()
	{
		return doc;
	}
	public void setSdoc(String sdoc)
	{
		this.sdoc=sdoc;
	}
	public String getSdoc()
	{
		return sdoc;
	}
	public void setDistrict(String district)
	{
		this.district=district;
	}
	public String getDistrict()
	{
		return district;
	}
	public void setMandal(String mandal)
	{
		this.mandal=mandal;
	}
	public String getMandal()
	{
		return mandal;
	}
	
	 
	public String getMandalName() {
		return mandalName;
	}
	  
	public void setMandalName(String mandalName) {
		this.mandalName = mandalName;
	}
	public void setPcode(String pcode)
	{
		this.pcode=pcode;
	}
	public String getPcode()
	{
		return pcode;
	}
	public void setVcode(String vcode)
	{
		this.vcode=vcode;
	}
	public String getVcode()
	{
		return vcode;
	}

	public void setAssetCode(String assetCode)
	{
		this.assetCode=assetCode;
	}
	public String getAssetCode()
	{
		return assetCode;
	}
	public void setAssetName(String assetName)
	{
		this.assetName=assetName;
	}
	public String getAssetName()
	{
		return assetName;
	}
	
	public void setHabCode(String habCode)
	{
		this.habCode=habCode;
	}
	public String getHabCode()
	{
		return habCode;
	}
	public void setDateofCreation(String dateofCreation)
	{
		this.dateofCreation=dateofCreation;
	}
	public String getDateofCreation()
	{
		return dateofCreation;
	}
	public void setLocation(String location)
	{
		this.location=location;
	}
	public String getLocation()
	{
		return location;
	}
		public void setAssetStatus(String assetStatus)
	{
		this.assetStatus=assetStatus;
	}
	public String getAssetStatus()
	{
		return assetStatus;
	}
	
	 
	public String getAssetStatusName() {
		return assetStatusName;
	}
	 
	public void setAssetStatusName(String assetStatusName) {
		this.assetStatusName = assetStatusName;
	}
	public void setStartYear(String startYear)
	{
		this.startYear=startYear;
	}
	public String getStartYear()
	{
		return startYear;
	}
	public void setEndYear(String endYear)
	{
		this.endYear=endYear;
	}
	public String getEndYear()
	{
		return endYear;
	}

	/**
	 * @return Returns the totHabs.
	 */
	public int getTotHabs() {
		return totHabs;
	}
	/**
	 * @param totHabs The totHabs to set.
	 */
	public void setTotHabs(int totHabs) {
		this.totHabs = totHabs;
	}
	/**
	 * @return Returns the totPopBenfit.
	 */
	public int getTotPopBenfit() {
		return totPopBenfit;
	}
	/**
	 * @param totPopBenfit The totPopBenfit to set.
	 */
	public void setTotPopBenfit(int totPopBenfit) {
		this.totPopBenfit = totPopBenfit;
	}
	public void setAssetCost(String assetCost)
	{
		this.assetCost=assetCost;
	}
	public String getAssetCost()
	{
		return assetCost;
	}
	public void setAssetTypeCode(String assetTypeCode)
	{
		this.assetTypeCode=assetTypeCode;
	}
	public String getAssetTypeCode()
	{
		return assetTypeCode;
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
	 * @return Returns the pumpCode.
	 */
	public String getPumpCode() {
		return pumpCode;
	}
	/**
	 * @param pumpCode The pumpCode to set.
	 */
	public void setPumpCode(String pumpCode) {
		this.pumpCode = pumpCode;
	}
	
	
	
	/**
	 * @return Returns the con.
	 */
	public String getCon() {
		return con;
	}
	/**
	 * @param con The con to set.
	 */
	public void setCon(String con) {
		this.con = con;
	}
	/**
	 * @return Returns the don.
	 */
	public String getDon() {
		return don;
	}
	/**
	 * @param don The don to set.
	 */
	public void setDon(String don) {
		this.don = don;
	}
	/**
	 * @return Returns the habName.
	 */
	public String getHabName() {
		return habName;
	}
	/**
	 * @param habName The habName to set.
	 */
	public void setHabName(String habName) {
		this.habName = habName;
	}
	/**
	 * @return Returns the sdon.
	 */
	public String getSdon() {
		return sdon;
	}
	/**
	 * @param sdon The sdon to set.
	 */
	public void setSdon(String sdon) {
		this.sdon = sdon;
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
	 * @param assetSubCompTypeCode The assetSubCompTypeCode to set.
	 */
	public void setAssetSubCompTypeCode(String assetSubCompTypeCode) {
		this.assetSubCompTypeCode = assetSubCompTypeCode;
	}
	
	public String getOpType() {
		return opType;
	}
	public void setOpType(String opType) {
		this.opType = opType;
	}
	public void reset(ActionMapping mapping,HttpServletRequest request)
	{
		//this.coc="";
		//this.doc="";
		//this.sdoc="";
		//this.district="";
		//this.mandal="";
		//this.pcode="";
		//this.vcode="";
		//this.habCode="";
		this.assetTypeCode=""; 		
		this.dateofCreation="";
		this.location="";      
		this.assetCost="";        
		this.startYear="";     
		this.endYear="";       
		this.assetName="";
		this.pumpCode="";
		this.opType="";
		this.yield="";
	    this.assetStatus="";
		this.assetStatusName="";
		this.assetCompTypeCode="";
		this.assetSubCompTypeCode="";
		this.assetCode="";
		this.assetHabs.clear();
		this.assetSubComponents.clear();
		//this.assetPipeLine.clear();
		this.assetHeadWorks.clear();
		this.assetReservior.clear();
		this.assetPumpSets.clear();
		this.assetPonds.clear();
		this.assetSHP.clear();
		this.assetOpenWells.clear();
		this.assetOthers.clear();
		//added by swapna on 18-01-2012 nfor gis data entry
		this.latitude="";
		this.longitude="";
		this.elevation="";
		this.waypoint="";
		this.waterBeingSupplied="";
		this.lastRepairedDate="";
		
		//
		
		
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
	 * @return Returns the pipeMaterial.
	 */
	public ArrayList getPipeMaterial() {
		//System.out.println("it is in pipe material");
		return pipeMaterial;
	}
	/**
	 * @param pipeMaterial The pipeMaterial to set.
	 */
	public void setPipeMaterial(ArrayList pipeMaterial) {
		this.pipeMaterial = pipeMaterial;
	}
	
	/**
	 * @return Returns the pipeClass.
	 */
	public ArrayList getPipeClass() {
		return pipeClass;
	}
	/**
	 * @param pipeClass The pipeClass to set.
	 */
	public void setPipeClass(ArrayList pipeClass) {
		this.pipeClass = pipeClass;
	}
	
	/**
	 * @return Returns the pipeDiameter.
	 */
	public ArrayList getPipeDiameter() {
		return pipeDiameter;
	}
	/**
	 * @param pipeDiameter The pipeDiameter to set.
	 */
	public void setPipeDiameter(ArrayList pipeDiameter) {
		this.pipeDiameter = pipeDiameter;
	}
	public String getPclass() {
		return pclass;
	}
	public void setPclass(String pclass) {
		this.pclass = pclass;
	}
	public String getPDiameter() {
		return diameter;
	}
	public void setPDiameter(String diameter) {
		this.diameter = diameter;
	}
	public String getPLength() {
		return length;
	}
	public void setPLength(String length) {
		this.length = length;
	}
	public String getPMaterial() {
		return material;
	}
	public void setPMaterial(String material) {
		this.material = material;
	}
	public void setPipeMat1(String pipeMat1)
	{	this.pipeMat1 = pipeMat1;
	}
	public String getPipeMat1()
	{	return pipeMat1;
	}
	
	public void setPipeMat2(String pipeMat2)
	{	this.pipeMat2 = pipeMat2;
	}
	public String getPipeMat2()
	{	return pipeMat2;
	}

	public void setPipeMat3(String pipeMat3)
	{	this.pipeMat3 = pipeMat3;
	}
	public String getPipeMat3()
	{	return pipeMat3;
	}
	/**
	 * @return Returns the addHabsDistrict.
	 */
	public String getAddHabsDistrict() {
		return addHabsDistrict;
	}
	/**
	 * @param addHabsDistrict The addHabsDistrict to set.
	 */
	public void setAddHabsDistrict(String addHabsDistrict) {
		this.addHabsDistrict = addHabsDistrict;
	}
	/**
	 * @return Returns the addHabsHabitation.
	 */
	public String getAddHabsHabitation() {
		return addHabsHabitation;
	}
	/**
	 * @param addHabsHabitation The addHabsHabitation to set.
	 */
	public void setAddHabsHabitation(String addHabsHabitation) {
		this.addHabsHabitation = addHabsHabitation;
	}
	/**
	 * @return Returns the addHabsMandal.
	 */
	public String getAddHabsMandal() {
		return addHabsMandal;
	}
	/**
	 * @param addHabsMandal The addHabsMandal to set.
	 */
	public void setAddHabsMandal(String addHabsMandal) {
		this.addHabsMandal = addHabsMandal;
	}

	public String getDisCode() {
		return disCode;
	}
	public void setDisCode(String disCode) {
		this.disCode = disCode;
	}
	public ArrayList getAssetPonds() {
		return assetPonds;
	}
	public void setAssetPonds(ArrayList assetPonds) {
		this.assetPonds = assetPonds;
	}
	public ArrayList getAssetOpenWells() {
		return assetOpenWells;
	}
	public void setAssetOpenWells(ArrayList assetOpenWells) {
		this.assetOpenWells = assetOpenWells;
	}
	public ArrayList getAssetOthers() {
		return assetOthers;
	}
	public void setAssetOthers(ArrayList assetOthers) {
		this.assetOthers = assetOthers;
	}
	public ArrayList getAssetSHP() {
		return assetSHP;
	}
	public void setAssetSHP(ArrayList assetSHP) {
		this.assetSHP = assetSHP;
	}
	
	public String getToDo() {
		return toDo;
	}
	public void setToDo(String toDo) {
		this.toDo = toDo;
	}
	public ArrayList getSourceHabs() {
		//System.out.println("in getsourcehabs in assetForm");
		return sourceHabs;
	}
	public void setSourceHabs(ArrayList sourceHabs) {
		//System.out.println("in setsourcehabs in assetForm");
		this.sourceHabs = sourceHabs;
	}
	
	
	public String getAddHabsMandalName() {
		return addHabsMandalName;
	}
	public void setAddHabsMandalName(String addHabsMandalName) {
		this.addHabsMandalName = addHabsMandalName;
	}
	public String getAddHabsDistrictName() {
		return addHabsDistrictName;
	}
	public void setAddHabsDistrictName(String addHabsDistrictName) {
		this.addHabsDistrictName = addHabsDistrictName;
	}
	public String getDefunctReasons() {
		return defunctReasons;
	}
	public void setDefunctReasons(String defunctReasons) {
		this.defunctReasons = defunctReasons;
	}
	
	public ArrayList getRwsMaster() {
		return rwsMaster;
	}
	public void setRwsMaster(ArrayList rwsMaster) {
		this.rwsMaster = rwsMaster;
	}
	
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	public String getDpYield() {
		return dpYield;
	}
	public void setDpYield(String dpYield) {
		this.dpYield = dpYield;
	}
	
	/**
	 * @return Returns the program.
	 */
	public String getProgram() {
		return program;
	}
	/**
	 * @param program The program to set.
	 */
	public void setProgram(String program) {
		this.program = program;
	}
	/**
	 * @return Returns the subprogram.
	 */
	public String getSubprogram() {
		return subprogram;
	}
	/**
	 * @param subprogram The subprogram to set.
	 */
	public void setSubprogram(String subprogram) {
		this.subprogram = subprogram;
	}
	/**
	 * @return Returns the diameter.
	 */
	public String getDiameter() {
		return diameter;
	}
	/**
	 * @param diameter The diameter to set.
	 */
	public void setDiameter(String diameter) {
		this.diameter = diameter;
	}
	/**
	 * @return Returns the elevation.
	 */
	public String getElevation() {
		return elevation;
	}
	/**
	 * @param elevation The elevation to set.
	 */
	public void setElevation(String elevation) {
		this.elevation = elevation;
	}
	/**
	 * @return Returns the latitude.
	 */
	public String getLatitude() {
		return latitude;
	}
	/**
	 * @param latitude The latitude to set.
	 */
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	/**
	 * @return Returns the length.
	 */
	public String getLength() {
		return length;
	}
	/**
	 * @param length The length to set.
	 */
	public void setLength(String length) {
		this.length = length;
	}
	/**
	 * @return Returns the longitude.
	 */
	public String getLongitude() {
		return longitude;
	}
	/**
	 * @param longitude The longitude to set.
	 */
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	/**
	 * @return Returns the material.
	 */
	public String getMaterial() {
		return material;
	}
	/**
	 * @param material The material to set.
	 */
	public void setMaterial(String material) {
		this.material = material;
	}
	/**
	 * @return Returns the waypoint.
	 */
	public String getWaypoint() {
		return waypoint;
	}
	/**
	 * @param waypoint The waypoint to set.
	 */
	public void setWaypoint(String waypoint) {
		this.waypoint = waypoint;
	}
}