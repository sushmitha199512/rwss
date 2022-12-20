/*
 * Created on Dec 16, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import nic.watersoft.commons.Debug;


/**
 * @author santosh
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class SubCompMetaData {
	private String tabPrifix="";
	private String schemeCodeField="";
	private String tableName="";
	private String typeOfAssetName="";
	private String typeOfAssetCode="";
	private String assetCompTypeCode;
	private String assetSubCompTypeCode;
	private String subCompRep;
	private String schemeCodeSeries;
	private String locationField;
	
	public SubCompMetaData()
	{
		
		
	}
	public void assignSchemeCodeSeries(String assetTypeCode)
	{
		
		if(assetTypeCode.equals("01"))
		{
			
			schemeCodeSeries="600";
			
		}
		else if(assetTypeCode.equals("02"))
		{
			
			schemeCodeSeries="400";
			
		}
		else if(assetTypeCode.equals("03"))
		{
			
			schemeCodeSeries="800";
			
		}
		else if(assetTypeCode.equals("04"))
		{
		
			schemeCodeSeries="001";
			
		}
		else if(assetTypeCode.equals("05"))
		{
		
			schemeCodeSeries="300";
			
		}
		else if(assetTypeCode.equals("06"))
		{
		
			schemeCodeSeries="500";
			
		}
		else if(assetTypeCode.equals("07"))
		{
		
			schemeCodeSeries="700";
			
		}
	}
	public String getTabPrifix(String assetTypeCode)
	{
		assignSchemeCodeSeries(assetTypeCode);
		if(assetTypeCode.equals("01"))
		{
			tabPrifix="RWS_AST_";
			schemeCodeSeries="600";
			
		}
		else if(assetTypeCode.equals("02"))
		{
			tabPrifix="RWS_AST_";
			schemeCodeSeries="400";
			
		}
		else if(assetTypeCode.equals("03"))
		{
			tabPrifix="RWS_AST_";
			schemeCodeSeries="800";
			
		}
		else if(assetTypeCode.equals("04"))
		{
			tabPrifix="RWS_AST_";
			schemeCodeSeries="001";
			
		}
		else if(assetTypeCode.equals("09"))
		{
			tabPrifix="RWS_AST_";
			schemeCodeSeries="451";
			
		}
		
		return tabPrifix;
	}
	public SubCompMetaData(String schemeCode)
	{
		setSubCompDetails(schemeCode);
	}
	
	//this function gets the subcomponent table names
	//subCompRep is the 2 digit sub component representation in schemecode.
	
	public void setSubCompDetails(String schemeCode)
	{

		
		try{
		if(schemeCode.length()==24)
		{
		if(schemeCode.charAt(16)=='6')
		{
			
			typeOfAssetName="PWS";
			typeOfAssetCode="01";
		}
		else if(schemeCode.charAt(16)=='4')
		{
			
			typeOfAssetName="MPWS";
			typeOfAssetCode="02";
		}
		else if(schemeCode.charAt(16)=='8')
		{
			
			typeOfAssetName="CPWS";
			typeOfAssetCode="03";
		}
		else if(schemeCode.charAt(16)=='3')
		{
			
			typeOfAssetName="SHP";
			typeOfAssetCode="05";
		}
		else if(schemeCode.charAt(16)=='5')
		{
			
			typeOfAssetName="OW";
			typeOfAssetCode="06";
		}
		else if(schemeCode.charAt(16)=='7')
		{
			
			typeOfAssetName="PD";
			typeOfAssetCode="07";
		}
		else if(schemeCode.charAt(16)=='0')
		{
			
			typeOfAssetName="HP";
			typeOfAssetCode="04";
		}
		//for others type not found
		/*else if(schemeCode.charAt(16)=='0')
		{
			
			typeOfAssetName="OT";
			typeOfAssetCode="04";
		}*/
		
		
		tabPrifix=getTabPrifix(typeOfAssetCode);
		//System.out.println("tab prifix in SubCompMetaData cons is "+tabPrifix);
		subCompRep=schemeCode.substring(19,21);
		this.getTableNames(subCompRep);
		if(subCompRep.equals("SO"))
		{
			assetSubCompTypeCode=RwsMasterData.getSourceSubCompTypeCode(schemeCode);
			//System.out.println("assetSubcomptypecode="+assetSubCompTypeCode);
		}
		
		}
		else
			
			Debug.println("Exception in SubCompMetaData: schemeCode should be 24 digits");
		}catch(Exception e){
			//System.out.println("Exception in subcompmetadata(schemeCode)"+e);}
		}
		
	}
	public void getTableNames(String subCompRep)
	{
		if(subCompRep.length()==2)
		{
			if(subCompRep.equals("PD"))
			{
				tableName="RWS_OPENWELL_POND_TBL";
				schemeCodeField="POND_CODE";
				locationField="POND_LOCATION";
				assetCompTypeCode="01";
				assetSubCompTypeCode="001";
				
			}
			if(subCompRep.equals("OW"))
			{
				tableName="RWS_OPEN_WELL_MAST_TBL";
				schemeCodeField="OPENWELL_CODE";
				locationField="LOCATION";
				assetCompTypeCode="01";
				assetSubCompTypeCode="001";
				
			}
			if(subCompRep.equals("PS"))
			{
				tableName=tabPrifix+"SUBCOMP_PARAM_TBL";
				schemeCodeField="PUMP_CODE";
				locationField="LOCATION";
				assetCompTypeCode="01";
				assetSubCompTypeCode="003";
				
			}
		
			if(subCompRep.equals("RW"))
			{
				tableName=tabPrifix+"RW_COLLWELL_PARAM_TBL";
				schemeCodeField="RW_COLLWELL_CODE";
				locationField="LOCATION";
				assetCompTypeCode="02";
				assetSubCompTypeCode="001";
				
			}
			if(subCompRep.equals("ST"))
			{
				tableName=tabPrifix+"SS_SC_PARAM_TBL";
				schemeCodeField="SSSC_CODE";
				locationField="LOCATION";
				assetCompTypeCode="01";
				assetSubCompTypeCode="002";
			}
			if(subCompRep.equals("SS")||subCompRep.equals("RS"))
			{
				tableName=tabPrifix+"WTP_SC_PARAM_TBL";
				schemeCodeField="WTPSC_CODE";
				locationField="LOCATION";
				assetCompTypeCode="02";
				assetSubCompTypeCode="003";
			}
			if(subCompRep.equals("SM"))
			{
				tableName=tabPrifix+"SUMP_M_SC_PARAM_TBL";
				schemeCodeField="SUMPCODE";
				locationField="LOCATION";
				assetCompTypeCode="02";
				assetSubCompTypeCode="004";
			}
			if(subCompRep.equals("FP"))
			{
				tableName=tabPrifix+"FP_BRIDGE_PARAM_TBL";
				schemeCodeField="BRIDGE_CODE";
				locationField="";
				assetCompTypeCode="02";
				assetSubCompTypeCode="005";
			}
			if(subCompRep.equals("PH"))
			{
				tableName=tabPrifix+"PUMPHOUSE_PARAM_TBL";
				schemeCodeField="PUMPHOUSE_CODE";
				locationField="LOCATION";
				assetCompTypeCode="02";
				assetSubCompTypeCode="006";
			}
			if(subCompRep.equals("WQ"))
			{
				tableName=tabPrifix+"WATCHMAN_PARAM_TBL";
				schemeCodeField="WATCHMAN_CODE";
				locationField="LOCATION";
				assetCompTypeCode="02";
				assetSubCompTypeCode="007";
			}
			if(subCompRep.equals("CW"))
			{
				tableName=tabPrifix+"CW_COLLWELL_PARAM_TBL";
				schemeCodeField="CW_COLLWELL_CODE";
				locationField="LOCATION";
				assetCompTypeCode="02";
				assetSubCompTypeCode="008";
			}
			if(subCompRep.equals("PM"))
			{
				tableName=tabPrifix+"PUMPINGMAIN_TBL";
				schemeCodeField="PUMPINGMAIN_CODE";
				locationField="LOCATION";
				assetCompTypeCode="03";
				assetSubCompTypeCode="001";
			}
			if(subCompRep.equals("GM"))
			{
				tableName=tabPrifix+"GRAVITYMAIN_TBL";
				schemeCodeField="GRAVITYMAIN_CODE";
				locationField="LOCATION";
				assetCompTypeCode="03";
				assetSubCompTypeCode="002";
			}
			if(subCompRep.equals("DT"))
			{
				tableName=tabPrifix+"DISTRI_SC_PARAM_TBL";
				schemeCodeField="DISTRISC_CODE";
				locationField="LOCATION";
				assetCompTypeCode="03";
				assetSubCompTypeCode="003";
			}
			if(subCompRep.equals("OS"))
			{
				tableName=tabPrifix+"OHSR_SC_PARAM_TBL";
				schemeCodeField="OHSR_CODE";
				locationField="OHSR_LOC";
				assetCompTypeCode="04";
				assetSubCompTypeCode="001";
			}
			if(subCompRep.equals("OB"))
			{
				tableName=tabPrifix+"OHBR_SC_PARAM_TBL";
				schemeCodeField="OHBR_CODE";
				locationField="OHBR_LOC";
				assetCompTypeCode="04";
				assetSubCompTypeCode="002";
			}
			if(subCompRep.equals("GL"))
			{
				tableName=tabPrifix+"GLSR_SC_PARAM_TBL";
				schemeCodeField="GLSR_CODE";
				locationField="GLSR_LOC";
				assetCompTypeCode="04";
				assetSubCompTypeCode="003";
			}
			if(subCompRep.equals("GB"))
			{
				tableName=tabPrifix+"GLBR_SC_PARAM_TBL";
				schemeCodeField="GLBR_CODE";
				locationField="GLBR_LOC";
				assetCompTypeCode="04";
				assetSubCompTypeCode="004";
			}
			if(subCompRep.equals("BT"))
			{
				tableName=tabPrifix+"BPT_PARAM_TBL";
				schemeCodeField="BPT_CODE";
				locationField="LOCATION";
				assetCompTypeCode="04";
				assetSubCompTypeCode="005";
			}
			if(subCompRep.equals("CT"))
			{
				tableName=tabPrifix+"CIS_SC_PARAM_TBL";
				schemeCodeField="CISSC_CODE ";
				locationField="CIS_LOC";
				assetCompTypeCode="04";
				assetSubCompTypeCode="006";
			}
			if(subCompRep.equals("OT"))
			{
				tableName=tabPrifix+"OTHERS_PARAM_TBL";
				schemeCodeField="OTHER_COMP_CODE";
				locationField="COMP_LOCATION";
				assetCompTypeCode="05";
				assetSubCompTypeCode="001";
			}
			if(subCompRep.equals("SO"))
			{
				tableName="RWS_SOURCE_TBL";
				schemeCodeField="SOURCE_CODE ";
				locationField="LOCATION";
				assetCompTypeCode="01";
				//assetSubCompTypeCode="";
			}
			if(subCompRep.equals("HP"))
			{
				tableName="RWS_HP_SUBCOMP_PARAM_TBL";
				schemeCodeField="HP_CODE";
				locationField="LOCATION";
				assetCompTypeCode="01";
				assetSubCompTypeCode="001";
			}
			if(subCompRep.equals("SH"))
			{
				tableName="RWS_SHALLOWHANDPUMPS_TBL";
				schemeCodeField="SHALLOWHP_CODE";
				locationField="LOCATION";
				assetCompTypeCode="01";
				assetSubCompTypeCode="001";
			}
			}
			else
				Debug.println("Exception in SubCompMetaData getTableNames : subCompRep should be of 2 digits");
	}
	//code added by sridhar for Direct pumping
	public SubCompMetaData(String assetTypeCode,String assetCompTypeCode,String assetSubCompTypeCode)
	{
		tabPrifix= getTabPrifix(assetTypeCode);
		if(assetTypeCode.equals("04"))
		{
			if(assetCompTypeCode.equals("01"))
			{
			if(assetSubCompTypeCode.equals("001"))
				{
					tableName="RWS_HP_SUBCOMP_PARAM_TBL";
					schemeCodeField="HP_CODE";
					locationField="LOCATION";
					subCompRep="HP";
				}
			}
		}
		if(assetTypeCode.equals("05"))
		{
			if(assetCompTypeCode.equals("01"))
			{
			if(assetSubCompTypeCode.equals("001"))
				{
					tableName="RWS_SHALLOWHANDPUMPS_TBL";
					schemeCodeField="SHALLOWHP_CODE";
					locationField="LOCATION";
					subCompRep="SH";
				}
			}
		}
		if(assetTypeCode.equals("06"))
		{
			if(assetCompTypeCode.equals("01"))
			{
				if(assetSubCompTypeCode.equals("001"))
				{
					tableName="RWS_OPEN_WELL_MAST_TBL";
					schemeCodeField="OPENWELL_CODE";
					locationField="LOCATION";
					subCompRep="OW";
				}
			}
		}
		if(assetTypeCode.equals("07"))
		{
			if(assetCompTypeCode.equals("01"))
			{
				if(assetSubCompTypeCode.equals("001"))
				{
					tableName="RWS_OPENWELL_POND_TBL";
					schemeCodeField="POND_CODE";
					locationField="POND_LOCATION";
					subCompRep="PD";
				}
			}
		}
		if(assetTypeCode.equals("08")) 
		{
			if(assetCompTypeCode.equals("01"))
			{
				if(assetSubCompTypeCode.equals("001"))
				{
					tableName="";
					schemeCodeField="";
					subCompRep="";
				}
			}
		}
		if(assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03")||assetTypeCode.equals("09"))
		{
			
			if(assetCompTypeCode.equals("01"))
			{
				if(assetSubCompTypeCode.equals("001"))
				{
					tableName="RWS_SOURCE_TBL";
					schemeCodeField="SOURCE_CODE";
					locationField="LOCATION";
					subCompRep="SO";
				}
			}
			if(assetCompTypeCode.equals("01"))
			{
				if(assetSubCompTypeCode.equals("002"))
				{
					tableName="RWS_SOURCE_TBL";
					schemeCodeField="SOURCE_CODE";
					locationField="LOCATION";
					subCompRep="SO";
				}
			}
			if(assetCompTypeCode.equals("01"))
			{
				if(assetSubCompTypeCode.equals("003"))
				{
					tableName=tabPrifix+"SUBCOMP_PARAM_TBL";
					schemeCodeField="PUMP_CODE";
					locationField="LOCATION";
					subCompRep="PS";
				}
			}
			if(assetCompTypeCode.equals("06"))
			{
				if(assetSubCompTypeCode.equals("001"))
				{
					tableName=tabPrifix+"SUBCOMP_PARAM_TBL";
					schemeCodeField="PUMP_CODE";
					locationField="LOCATION";
					subCompRep="PS";
				}
			}
			if(assetCompTypeCode.equals("02"))
			{
				if(assetSubCompTypeCode.equals("001"))
				{
					tableName=tabPrifix+"RW_COLLWELL_PARAM_TBL";
					schemeCodeField="RW_COLLWELL_CODE";
					locationField="LOCATION";
					subCompRep="RW";
				}
				if(assetSubCompTypeCode.equals("002"))
				{
					tableName=tabPrifix+"SS_SC_PARAM_TBL";
					schemeCodeField="SSSC_CODE";
					locationField="LOCATION";
					subCompRep="ST";
				}
				if(assetSubCompTypeCode.equals("003"))
				{
					tableName=tabPrifix+"WTP_SC_PARAM_TBL";
					schemeCodeField="WTPSC_CODE";
					locationField="LOCATION";
					subCompRep="SS";
				}
				if(assetSubCompTypeCode.equals("004"))
				{
					tableName=tabPrifix+"WTP_SC_PARAM_TBL";
					schemeCodeField="WTPSC_CODE";
					locationField="LOCATION";
					subCompRep="RS";
				}
				if(assetSubCompTypeCode.equals("010"))
				{
					tableName=tabPrifix+"WTP_SC_PARAM_TBL";
					schemeCodeField="WTPSC_CODE";
					locationField="LOCATION";
					subCompRep="MS";
				}
				if(assetSubCompTypeCode.equals("011"))
				{
					tableName=tabPrifix+"WTP_SC_PARAM_TBL";
					schemeCodeField="WTPSC_CODE";
					locationField="LOCATION";
					subCompRep="RP";
				}
				if(assetSubCompTypeCode.equals("005"))
				{
					tableName=tabPrifix+"SUMP_M_SC_PARAM_TBL";
					schemeCodeField="SUMPCODE";
					locationField="LOCATION";
					subCompRep="SM";
				}
				if(assetSubCompTypeCode.equals("006"))
				{
					tableName=tabPrifix+"FP_BRIDGE_PARAM_TBL";
					schemeCodeField="BRIDGE_CODE";
					locationField="";
					subCompRep="FP";
				}
				if(assetSubCompTypeCode.equals("007"))
				{
					tableName=tabPrifix+"PUMPHOUSE_PARAM_TBL";
					schemeCodeField="PUMPHOUSE_CODE";
					locationField="LOCATION";
					subCompRep="PH";
				}
				if(assetSubCompTypeCode.equals("008"))
				{
					tableName=tabPrifix+"WATCHMAN_PARAM_TBL";
					schemeCodeField="WATCHMAN_CODE";
					locationField="";
					subCompRep="WQ";
				}
				if(assetSubCompTypeCode.equals("009"))
				{
					tableName=tabPrifix+"CW_COLLWELL_PARAM_TBL";
					schemeCodeField="CW_COLLWELL_CODE";
					locationField="LOCATION";
					subCompRep="CW";
				}
			}
			if(assetCompTypeCode.equals("03"))
			{
				if(assetSubCompTypeCode.equals("001"))
				{
					tableName=tabPrifix+"PUMPINGMAIN_TBL";
					schemeCodeField="PUMPINGMAIN_CODE";
					locationField="LOCATION";
					subCompRep="PM";
				}
				if(assetSubCompTypeCode.equals("002"))
				{
					tableName=tabPrifix+"GRAVITYMAIN_TBL";
					schemeCodeField="GRAVITYMAIN_CODE";
					locationField="LOCATION";
					subCompRep="GM";
				}
				if(assetSubCompTypeCode.equals("003"))
				{
					tableName=tabPrifix+"DISTRI_SC_PARAM_TBL";
					schemeCodeField="DISTRISC_CODE";
					locationField="LOCATION";
					subCompRep="DT";
				}
			}
			if(assetCompTypeCode.equals("04"))
			{
				
				if(assetSubCompTypeCode.equals("001"))
				{
					tableName=tabPrifix+"OHSR_SC_PARAM_TBL";
					schemeCodeField="OHSR_CODE";
					locationField="OHSR_LOC";
					subCompRep="OS";
				}
				if(assetSubCompTypeCode.equals("002"))
				{
					tableName=tabPrifix+"OHBR_SC_PARAM_TBL";
					schemeCodeField="OHBR_CODE";
					locationField="OHBR_LOC";
					subCompRep="OB";
				}
				if(assetSubCompTypeCode.equals("003"))
				{
					tableName=tabPrifix+"GLSR_SC_PARAM_TBL";
					schemeCodeField="GLSR_CODE";
					locationField="GLSR_LOC";
					subCompRep="GL";
				}
				if(assetSubCompTypeCode.equals("004"))
				{
					tableName=tabPrifix+"GLBR_SC_PARAM_TBL";
					schemeCodeField="GLBR_CODE";
					locationField="GLBR_LOC";
					subCompRep="GB";
				}
				
				if(assetSubCompTypeCode.equals("005"))
				{
					tableName=tabPrifix+"BPT_PARAM_TBL";
					schemeCodeField="BPT_CODE";
					locationField="LOCATION";
					subCompRep="BT";
				}
				if(assetSubCompTypeCode.equals("006"))
				{
					tableName=tabPrifix+"CIS_SC_PARAM_TBL";
					schemeCodeField="CISSC_CODE ";
					locationField="CIS_LOC";
					subCompRep="CT";
				}
			}
			if(assetCompTypeCode.equals("05"))
			{
				if(assetSubCompTypeCode.equals("001"))
				{
					tableName=tabPrifix+"OTHERS_PARAM_TBL";
					schemeCodeField="OTHER_COMP_CODE";
					locationField="COMP_LOCATION";
					subCompRep="OT";
				}
			}
			if(assetCompTypeCode.equals("05"))
			{
				if(assetSubCompTypeCode.equals("002"))
				{
					tableName=tabPrifix+"CHLORINATION_TBL";
					schemeCodeField="CL_CODE";
					locationField="LOCATION";
					subCompRep="CL";
				}
			}
			if(assetCompTypeCode.equals("05"))
			{
				if(assetSubCompTypeCode.equals("003"))
				{
					tableName=tabPrifix+"OANDM_PARAM_TBL";
					schemeCodeField="OANDMCODE";
					locationField="";
					subCompRep="OM";
				}
			}
			
			
		}
	}
//	added by ramesh for source identification to get source codes
	
	public SubCompMetaData(String assetTypeCode,String sourceCode,String subSourceCode,String habCode)
	{
		tabPrifix= getTabPrifix(assetTypeCode);
		if(!assetTypeCode.equals("04"))
		{
			tableName="RWS_SOURCE_TBL";
			schemeCodeField="SOURCE_CODE";
			locationField="SOURCE_NAME";
			subCompRep="SO";
		}
		if(assetTypeCode.equals("04"))
		{
			tableName="RWS_SOURCE_TBL";
			schemeCodeField="SOURCE_CODE";
			locationField="SOURCE_NAME";
			subCompRep="HP";
		}
			
	}
	public String getNextSchemeCode(javax.sql.DataSource dataSource,String assetTypeCode,String assetCompTypeCode,String assetSubCompTypeCode,String shortSchemeCode,String habCode,String assetCode) 
	{
		
		String nextSchemeCode="";
		//System.out.println("assetCode in getNextSchemeCode is "+assetCode);
		//System.out.println("asset"+assetTypeCode+"comp"+assetCompTypeCode+"subcomp"+assetSubCompTypeCode);
		SubCompMetaData subCompMetaData=new SubCompMetaData(assetTypeCode,assetCompTypeCode,assetSubCompTypeCode);
		
		//System.out.println("schemeCodeField is "+subCompMetaData.getSchemeCodeField());
		String slNo=RwsMasterData.getNextNewSlNo(dataSource,subCompMetaData.getTableName(),subCompMetaData.getSchemeCodeField(),habCode,shortSchemeCode);
		Debug.println("sl no:"+slNo);
		
		//String query="select max(to_number(substr(22,3)))+1 from "+subCompMetaData.getTableName()+" where hab_code="+habCode+" and substr(13,3)="+shortSchemeCode; 
		nextSchemeCode=habCode+shortSchemeCode+subCompMetaData.getSubCompRep()+slNo;
		Debug.println("nextSchemeCode:"+nextSchemeCode);
		if(!( (assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03")) && assetCompTypeCode.equals("01")) )
		{
		
			//System.out.println("inserting**********************************");
			//RwsMasterData.insertNextSchemeCode(dataSource,subCompMetaData.getTableName(),subCompMetaData.getSchemeCodeField(),nextSchemeCode,assetCode);
		}
		return nextSchemeCode;
	}
	
	//getters and setters starts here
	public String getAssetCompTypeCode() {
		return assetCompTypeCode;
	}
	public void setAssetCompTypeCode(String assetCompTypeCode) {
		this.assetCompTypeCode = assetCompTypeCode;
	}
	public String getAssetSubCompTypeCode() {
		return assetSubCompTypeCode;
	}
	public void setAssetSubCompTypeCode(String assetSubCompTypeCode) {
		this.assetSubCompTypeCode = assetSubCompTypeCode;
	}
	public String getSchemeCodeField() {
		return schemeCodeField;
	}
	public void setSchemeCodeField(String schemeCodeField) {
		this.schemeCodeField = schemeCodeField;
	}
	public String getSubCompRep() {
		return subCompRep;
	}
	public void setSubCompRep(String subCompRep) {
		this.subCompRep = subCompRep;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTabPrifix() {
		return tabPrifix;
	}
	public void setTabPrifix(String tabPrifix) {
		this.tabPrifix = tabPrifix;
	}
	public String getTypeOfAssetCode() {
		return typeOfAssetCode;
	}
	public void setTypeOfAssetCode(String typeOfAssetCode) {
		this.typeOfAssetCode = typeOfAssetCode;
	}
	public String getTypeOfAssetName() {
		return typeOfAssetName;
	}
	public void setTypeOfAssetName(String typeOfAssetName) {
		this.typeOfAssetName = typeOfAssetName;
	}
	
	public String getSchemeCodeSeries() {
		return schemeCodeSeries;
	}
	public void setSchemeCodeSeries(String schemeCodeSeries) {
		this.schemeCodeSeries = schemeCodeSeries;
	}
	public String getLocationField() {
		return locationField;
	}
	public void setLocationField(String locationField) {
		this.locationField = locationField;
	}
}
