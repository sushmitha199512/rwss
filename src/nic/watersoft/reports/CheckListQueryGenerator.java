package nic.watersoft.reports;

import org.apache.struts.action.ActionForm;
import nic.watersoft.commons.Debug;
public class CheckListQueryGenerator
{
String query;

public String getDynamicQueryForAllSources(ActionForm form,String subCompTbl,String subcompCode,String assettypcode,
		String Scheme,String sourceTyp)
{
          String tempQuery=" FROM RWS_ASSET_MAST_TBL M, " +
		                   subCompTbl+" subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE ";
		  query=tempQuery;
          rws_asset_CheckList_FormBean formBean=(rws_asset_CheckList_FormBean )form;
           
        if(!formBean.get("circleCode").equals("")||!formBean.get("divisionCode").equals("")
        ||!formBean.get("subdivisionCode").equals("")||!formBean.get("districtCode").equals("")
		||!formBean.get("mandalCode").equals("")||!formBean.get("panchayatCode").equals("")
		||!formBean.get("villageCode").equals(""))
	    {
		if(!formBean.get("districtCode").equals(""))
		{
			query=query+" and substr(m.hab_code,1,2)='"+formBean.get("circleCode")+"'";
			if(!formBean.get("mandalCode").equals(""))
			{
			 query=query+" and substr(m.hab_code,6,2)='"+formBean.get("mandalCode")+"'";
				if(!formBean.get("panchayatCode").equals(""))
				{
					query=query+" and substr(m.hab_code,13,2)='"+formBean.get("panchayatCode")+"'";
					if(!formBean.get("villageCode").equals(""))
					{
						query=query+" and substr(m.hab_code,8,3)='"+formBean.get("villageCode")+"'";
						
					}
				
				}
			}
		}
	}
	if(!formBean.get("circleCode").equals(""))
	{
		query=query+" and substr(M.hab_code,1,2)='"+formBean.get("circleCode")+"'";
		if(!formBean.get("divisionCode").equals(""))
		{
			query=query+" and M.division_office_code='"+formBean.get("divisionCode")+"'";
			if(!formBean.get("subdivisionCode").equals(""))
			{
				query=query+" and M.subdivision_office_code='"+formBean.get("subdivisionCode")+"'";
			}
		}
	}
	
 	if(!formBean.get("habitationCode").equals(""))
	{
		query=query+" and substr(m.hab_code,11,2)=subStr('"+formBean.get("habitationCode")+"',11,2)";
	}
 	query=query+" and M.type_of_asset_code='"+assettypcode+"' and substr(subCompTbl."+subcompCode+",17,3) like '"+Scheme+"'" +
 			"and   subCompTbl.SOURCE_TYPE_CODE='"+sourceTyp+"'";
   	return query;
}
public String getDynamicQueryForCpws(ActionForm form,String subCompTbl,String subcompCode)
{
	String tempQuery=" FROM RWS_ASSET_MAST_TBL M, " +
		                   subCompTbl+" subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE ";
		  query=tempQuery;
          rws_asset_CheckList_FormBean formBean=(rws_asset_CheckList_FormBean )form;
           
        if(!formBean.get("circleCode").equals("")||!formBean.get("divisionCode").equals("")
        ||!formBean.get("subdivisionCode").equals("")||!formBean.get("districtCode").equals("")
		||!formBean.get("mandalCode").equals("")||!formBean.get("panchayatCode").equals("")
		||!formBean.get("villageCode").equals(""))
	    {
		if(!formBean.get("districtCode").equals(""))
		{
			query=query+" and substr(m.hab_code,1,2)='"+formBean.get("circleCode")+"'";
			if(!formBean.get("mandalCode").equals(""))
			{
			 query=query+" and substr(m.hab_code,6,2)='"+formBean.get("mandalCode")+"'";
				if(!formBean.get("panchayatCode").equals(""))
				{
					query=query+" and substr(m.hab_code,13,2)='"+formBean.get("panchayatCode")+"'";
					if(!formBean.get("villageCode").equals(""))
					{
						query=query+" and substr(m.hab_code,8,3)='"+formBean.get("villageCode")+"'";
						
					}
				
				}
			}
		}
	}
	if(!formBean.get("circleCode").equals(""))
	{
		query=query+" and substr(M.hab_code,1,2)='"+formBean.get("circleCode")+"'";
		if(!formBean.get("divisionCode").equals(""))
		{
			query=query+" and M.division_office_code='"+formBean.get("divisionCode")+"'";
			if(!formBean.get("subdivisionCode").equals(""))
			{
				query=query+" and M.subdivision_office_code='"+formBean.get("subdivisionCode")+"'";
			}
		}
	}
	
 	if(!formBean.get("habitationCode").equals(""))
	{
		query=query+" and substr(m.hab_code,11,2)=subStr('"+formBean.get("habitationCode")+"',11,2)";
	}
 	if(subcompCode.equals("OANDMCODE"))
 	{
 	query=query+" and M.type_of_asset_code='03' ";
 	}
 	else
 	{
 	 query=query+" and M.type_of_asset_code='03' and substr(subCompTbl."+subcompCode+",17,3) like '8%' ";
 	}
   	return query;
}
public String getDynamicQueryForPws(ActionForm form,String subCompTbl,String subcompCode)
{
          String tempQuery=" FROM RWS_ASSET_MAST_TBL M, " +
		                   subCompTbl+" subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE ";
		  query=tempQuery;
          rws_asset_CheckList_FormBean formBean=(rws_asset_CheckList_FormBean )form;
           
        if(!formBean.get("circleCode").equals("")||!formBean.get("divisionCode").equals("")
        ||!formBean.get("subdivisionCode").equals("")||!formBean.get("districtCode").equals("")
		||!formBean.get("mandalCode").equals("")||!formBean.get("panchayatCode").equals("")
		||!formBean.get("villageCode").equals(""))
	    {
		if(!formBean.get("districtCode").equals(""))
		{
			query=query+" and substr(m.hab_code,1,2)='"+formBean.get("circleCode")+"'";
			if(!formBean.get("mandalCode").equals(""))
			{
			 query=query+" and substr(m.hab_code,6,2)='"+formBean.get("mandalCode")+"'";
				if(!formBean.get("panchayatCode").equals(""))
				{
					query=query+" and substr(m.hab_code,13,2)='"+formBean.get("panchayatCode")+"'";
					if(!formBean.get("villageCode").equals(""))
					{
						query=query+" and substr(m.hab_code,8,3)='"+formBean.get("villageCode")+"'";
						
					}
				
				}
			}
		}
	}
	if(!formBean.get("circleCode").equals(""))
	{
		query=query+" and substr(M.hab_code,1,2)='"+formBean.get("circleCode")+"'";
		if(!formBean.get("divisionCode").equals(""))
		{
			query=query+" and M.division_office_code='"+formBean.get("divisionCode")+"'";
			if(!formBean.get("subdivisionCode").equals(""))
			{
				query=query+" and M.subdivision_office_code='"+formBean.get("subdivisionCode")+"'";
			}
		}
	}
	
 	if(!formBean.get("habitationCode").equals(""))
	{
		query=query+" and substr(m.hab_code,11,2)=subStr('"+formBean.get("habitationCode")+"',11,2)";
	}
 	if(subcompCode.equals("OANDMCODE"))
 	{
 	query=query+" and M.type_of_asset_code='01'";
 	}
 	else
 	{
 	 query=query+" and M.type_of_asset_code='01' and substr(subCompTbl."+subcompCode+",17,3) like '6%' ";	
 	}
   	return query;
}
public String getDynamicQueryForMpws(ActionForm form,String subCompTbl,String subcompCode)
{
          String tempQuery=" FROM RWS_ASSET_MAST_TBL M, " +
		                   subCompTbl+" subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE ";
		  query=tempQuery;
          rws_asset_CheckList_FormBean formBean=(rws_asset_CheckList_FormBean )form;
           
        if(!formBean.get("circleCode").equals("")||!formBean.get("divisionCode").equals("")
        ||!formBean.get("subdivisionCode").equals("")||!formBean.get("districtCode").equals("")
		||!formBean.get("mandalCode").equals("")||!formBean.get("panchayatCode").equals("")
		||!formBean.get("villageCode").equals(""))
	    {
		if(!formBean.get("districtCode").equals(""))
		{
			query=query+" and substr(m.hab_code,1,2)='"+formBean.get("circleCode")+"'";
			if(!formBean.get("mandalCode").equals(""))
			{
			 query=query+" and substr(m.hab_code,6,2)='"+formBean.get("mandalCode")+"'";
				if(!formBean.get("panchayatCode").equals(""))
				{
					query=query+" and substr(m.hab_code,13,2)='"+formBean.get("panchayatCode")+"'";
					if(!formBean.get("villageCode").equals(""))
					{
						query=query+" and substr(m.hab_code,8,3)='"+formBean.get("villageCode")+"'";
						
					}
				
				}
			}
		}
	}
	if(!formBean.get("circleCode").equals(""))
	{
		query=query+" and substr(M.hab_code,1,2)='"+formBean.get("circleCode")+"'";
		if(!formBean.get("divisionCode").equals(""))
		{
			query=query+" and M.division_office_code='"+formBean.get("divisionCode")+"'";
			if(!formBean.get("subdivisionCode").equals(""))
			{
				query=query+" and M.subdivision_office_code='"+formBean.get("subdivisionCode")+"'";
			}
		}
	}
	
 	if(!formBean.get("habitationCode").equals(""))
	{
		query=query+" and substr(m.hab_code,11,2)=subStr('"+formBean.get("habitationCode")+"',11,2)";
	}
 	if(subcompCode.equals("OANDMCODE"))
 	{
 	query=query+" and M.type_of_asset_code='02'";
 	}
 	else
 	{
 	 query=query+" and M.type_of_asset_code='02' and substr(subCompTbl."+subcompCode+",17,3) like '4%' ";	
 	}
   	return query;
}

public String getDynamicQueryForHandpumps(ActionForm form,String subCompTbl,String subcompCode)
{
          String tempQuery=" FROM RWS_ASSET_MAST_TBL M, " +
		                   subCompTbl+" subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE ";
		  query=tempQuery;
          rws_asset_CheckList_FormBean formBean=(rws_asset_CheckList_FormBean )form;
           
        if(!formBean.get("circleCode").equals("")||!formBean.get("divisionCode").equals("")
        ||!formBean.get("subdivisionCode").equals("")||!formBean.get("districtCode").equals("")
		||!formBean.get("mandalCode").equals("")||!formBean.get("panchayatCode").equals("")
		||!formBean.get("villageCode").equals(""))
	    {
		if(!formBean.get("districtCode").equals(""))
		{
			query=query+" and substr(m.hab_code,1,2)= '"+formBean.get("circleCode")+"'";
			if(!formBean.get("mandalCode").equals(""))
			{
			 query=query+" and substr(m.hab_code,6,2)='"+formBean.get("mandalCode")+"'";
				if(!formBean.get("panchayatCode").equals(""))
				{
					query=query+" and substr(m.hab_code,13,2)='"+formBean.get("panchayatCode")+"'";
					if(!formBean.get("villageCode").equals(""))
					{
						query=query+" and substr(m.hab_code,8,3)='"+formBean.get("villageCode")+"'";
						
					}
				
				}
			}
		}
	}
	if(!formBean.get("circleCode").equals(""))
	{
		query=query+" and substr(M.hab_code,1,2)='"+formBean.get("circleCode")+"'";
		if(!formBean.get("divisionCode").equals(""))
		{
			query=query+" and M.division_office_code='"+formBean.get("divisionCode")+"'";
			if(!formBean.get("subdivisionCode").equals(""))
			{
				query=query+" and M.subdivision_office_code='"+formBean.get("subdivisionCode")+"'";
			}
		}
	}
	
 	if(!formBean.get("habitationCode").equals(""))
	{
		query=query+" and substr(m.hab_code,11,2)=subStr('"+formBean.get("habitationCode")+"',11,2)";
	}
 	query=query+" and M.type_of_asset_code='04' and (substr(subCompTbl."+subcompCode+",17,3) like '0%' or substr(subCompTbl."+subcompCode+",17,3) like '1%' or substr(subCompTbl."+subcompCode+",17,3) like '2%') ";
   	return query;
}
public String getDynamicQueryFor_Shallow_Openwels_ponds(ActionForm form,String subCompTbl,String subcompCode,String asetyp,String scheme)
{
          String tempQuery=" FROM RWS_ASSET_MAST_TBL M, " +
		                   subCompTbl+" subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE ";
		  query=tempQuery;
          rws_asset_CheckList_FormBean formBean=(rws_asset_CheckList_FormBean )form;
           
        if(!formBean.get("circleCode").equals("")||!formBean.get("divisionCode").equals("")
        ||!formBean.get("subdivisionCode").equals("")||!formBean.get("districtCode").equals("")
		||!formBean.get("mandalCode").equals("")||!formBean.get("panchayatCode").equals("")
		||!formBean.get("villageCode").equals(""))
	    {
		if(!formBean.get("districtCode").equals(""))
		{
			query=query+" and substr(m.hab_code,1,2)= '"+formBean.get("circleCode")+"'";
			if(!formBean.get("mandalCode").equals(""))
			{
			 query=query+" and substr(m.hab_code,6,2)='"+formBean.get("mandalCode")+"'";
				if(!formBean.get("panchayatCode").equals(""))
				{
					query=query+" and substr(m.hab_code,13,2)='"+formBean.get("panchayatCode")+"'";
					if(!formBean.get("villageCode").equals(""))
					{
						query=query+" and substr(m.hab_code,8,3)='"+formBean.get("villageCode")+"'";
						
					}
				
				}
			}
		}
	}
	if(!formBean.get("circleCode").equals(""))
	{
		query=query+" and substr(M.hab_code,1,2)='"+formBean.get("circleCode")+"'";
		if(!formBean.get("divisionCode").equals(""))
		{
			query=query+" and M.division_office_code='"+formBean.get("divisionCode")+"'";
			if(!formBean.get("subdivisionCode").equals(""))
			{
				query=query+" and M.subdivision_office_code='"+formBean.get("subdivisionCode")+"'";
			}
		}
	}
	
 	if(!formBean.get("habitationCode").equals(""))
	{
		query=query+" and substr(m.hab_code,11,2)=subStr('"+formBean.get("habitationCode")+"',11,2)";
	}
 	query=query+" and M.type_of_asset_code='"+asetyp+"' and substr(subCompTbl."+subcompCode+",17,3) like '"+scheme+"' ";
   	return query;
}
    public String getDistrictGrillQuery(String tabName,String subcompCode)
   {  
    	//System.out.println("getting qury from dynamic query class");
    	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,";
    	String q2=tabName;
    	String q3="";
    	if(subcompCode.equals("OANDMCODE"))
    	{
    		 q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
		    	"and a.type_of_asset_code=t.type_of_asset_code and a.type_of_asset_code='03' "+
		    	" group by DNAME,DCODE order by Dname";	
    	}
    	else
    	{
    		 q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
		    	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '8%' and a.type_of_asset_code='03' "+
		    	" group by DNAME,DCODE   order by Dname";
    	}
    	
    	String query=q1+q2+q3;
        //System.out.println("query of coutn *"+query);
    return query;

   }
    
    public String getDistrictSURFACEGrillQuery(String tabName,String subcompCode,String assetCode,String Scheme,String sourceTyp)
    {  
     	//System.out.println("getting qury from dynamic query class");
     	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '"+Scheme+"' and " +
     	 "a.type_of_asset_code='"+assetCode+"' and subCompTbl.SOURCE_TYPE_CODE= '"+sourceTyp+"'"+
     	" group by DNAME,DCODE   order by Dname";
     	 String query=q1+q2+q3;
         //System.out.println("query of coutn *"+query);
     return query;

    }
    
    // code added by sridhar for division wise report for sources 
    
    public String getDivisionSURFACEGrillQuery(String tabName,String subcompCode,String assetCode,String Scheme,String sourceTyp,String dcode)
    {  
     	
     	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code  and d.division_office_code=a.division_office_code " +
     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '"+Scheme+"' and " +
     	 "a.type_of_asset_code='"+assetCode+"' and subCompTbl.SOURCE_TYPE_CODE= '"+sourceTyp+"'"+
     	" and d.circle_office_code='"+dcode+"'group by d.division_office_code,d.division_office_name  order by d.division_office_name";
     	 String query=q1+q2+q3;
       
     	 Debug.println("Query:"+query);
    
        return query;

    }
   
    // code added by sridhar for sub division report for sources
    
    public String getSubdiivisonSourceQuery(String tabName,String subcompCode,String assetCode,String Scheme,String sourceTyp,String dcode,String div)
    {
    String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,";
	String q2=tabName;
	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"'and substr(subCompTbl."+subcompCode+",17,3) like '"+Scheme+"' "+
	" and a.type_of_asset_code='"+assetCode+"' and subCompTbl.SOURCE_TYPE_CODE= '"+sourceTyp+"' "+
	" and d.division_office_code='"+div+"' group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
   
	String query=q1+q2+q3;
	
	Debug.println(" sub div query for sources:"+query);
	
	return query;
    
    }
    
    
    // code end 
    
    public String getDistrictGrillQueryForPws(String tabName,String subcompCode)
    {  
     	//System.out.println("getting qury from dynamic query class");
     	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	String q3 = "";
     	if(subcompCode.equals("OANDMCODE"))
     	{
     		q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	     	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
	     	"and a.type_of_asset_code=t.type_of_asset_code and a.type_of_asset_code='01' "+
	     	" group by DNAME,DCODE   order by Dname";
     	}
     	else
     	{
     		q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	     	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
	     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '6%'and  a.type_of_asset_code='01' "+
	     	" group by DNAME,DCODE   order by Dname";
     	}
     	String query=q1+q2+q3;
         //System.out.println("query of coutn *"+query);
     return query;

    }
    // code added by sridhar for Division for MPWS 
    public String getDivisionQueryForMpws(String tabName,String subcompCode,String dcode)
    {  

    	//System.out.println("getting qury from dynamic query class");
    	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a, ";
    	String q2=tabName;
    	String q3="";
    	if(subcompCode.equals("OANDMCODE"))
    	{
    	q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
    	"and a.type_of_asset_code=t.type_of_asset_code and " +
    	"a.type_of_asset_code='02'  and d.circle_office_code='"+dcode+"' "+
    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";
    	}
    	else
    	{
    		q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '4%' and " +
	    	"a.type_of_asset_code='02'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	}
    	String query=q1+q2+q3;
        Debug.println("query of coutn *"+query);
      return query;

    }
    
    // code added by sridhar for division wise report for CPWS
    
    public String getDivisionQueryForCpws(String tabName,String subcompCode,String dcode,String Scheme,String assetcode)
    {  

    	//System.out.println("getting qury from dynamic query class");
    	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a, ";
    	String q2=tabName;
    	String q3="";
    	if(subcompCode.equals("OANDMCODE"))
    	{
    	q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
    	"and a.type_of_asset_code=t.type_of_asset_code  and " +
    	"a.type_of_asset_code='"+assetcode+"'  and d.circle_office_code='"+dcode+"' "+
    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";
    	}
    	else
    	{
    		q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '"+Scheme+"' and " +
	    	"a.type_of_asset_code='"+assetcode+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	}
    	String query=q1+q2+q3;
        Debug.println("query of coutn *"+query);
      return query;

    }
    
    
    // code added by sridhar for subdivision for MPWS
    
    public String getSubdivisionQueryForMpws(String tabName,String subcompCode,String dcode,String div)
    {  

    	//System.out.println("getting qury from dynamic query class");
    	String q1="select count(*)COUNT,d.subdivision_office_name,d.subdivision_office_code  from rws_subdivision_office_tbl d,rws_asset_mast_tbl a, ";
    	String q2=tabName;
    	String q3="";
    	if(subcompCode.equals("OANDMCODE"))
    	{
    	q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
		" and d.subdivision_office_code=a.subdivision_office_code  "+
    	"and a.type_of_asset_code=t.type_of_asset_code and " +
    	"a.type_of_asset_code='02'  and d.circle_office_code='"+dcode+"' and d.division_office_code='"+div+"'"+
    	" group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
    	}
    	else
    	{
    		q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
			" and d.subdivision_office_code=a.subdivision_office_code  "+
	    	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '4%' and " +
	    	"a.type_of_asset_code='02'  and d.circle_office_code='"+dcode+"' and d.division_office_code='"+div+"'"+
	    	" group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";	
    	}
    	String query=q1+q2+q3;
        Debug.println("query of subdiv coutn *"+query);
      return query;

    }
    // String query=dquery.getSubdivisionQueryForCpws("RWS_AST_SUMP_M_SC_PARAM_TBL","SUMPCODE",dcode,"8%","03",divcode);
   // code added by sridhar for sub div report for CPWS
    public String getSubdivisionQueryForCpws(String tabName,String subcompCode, String dcode,String Scheme,String assetcode,String div)
    {  

    	//System.out.println("getting qury from dynamic query class");
    	String q1="select count(*)COUNT,d.subdivision_office_name,d.subdivision_office_code  from rws_subdivision_office_tbl d,rws_asset_mast_tbl a, ";
    	String q2=tabName;
    	String q3="";
    	if(subcompCode.equals("OANDMCODE"))
    	{
    	 q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
		" and d.subdivision_office_code=a.subdivision_office_code  "+
    	"and a.type_of_asset_code=t.type_of_asset_code and " +
    	"a.type_of_asset_code='"+assetcode+"'  and d.circle_office_code='"+dcode+"' and d.division_office_code='"+div+"'"+
    	" group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
    	}
    	else
    	{
    	 q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
				" and d.subdivision_office_code=a.subdivision_office_code  "+
		    	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '"+Scheme+"' and " +
		    	"a.type_of_asset_code='"+assetcode+"'  and d.circle_office_code='"+dcode+"' and d.division_office_code='"+div+"'"+
		    	" group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";	
    	}
    	
    	String query=q1+q2+q3;
        Debug.println("query of subdiv coutn *"+query);
      return query;

    }
    
    
    
   
    public String getDistrictGrillQueryForMpws(String tabName,String subcompCode)
    {  

    	//System.out.println("getting qury from dynamic query class");
    	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,";
    	String q2=tabName;
    	String q3="";
    	if(subcompCode.equals("OANDMCODE"))
    	{
		q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
    	"and a.type_of_asset_code=t.type_of_asset_code and " +
    	"a.type_of_asset_code='02' "+
    	" group by DNAME,DCODE   order by Dname";
    	}
    	else
    	{
    		q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
	    	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '4%' and " +
	    	"a.type_of_asset_code='02' "+
	    	" group by DNAME,DCODE order by Dname";	
    	}
    	String query=q1+q2+q3;
        //System.out.println("query of coutn *"+query);
    return query;

    }
    public String  getDistrictGrillQueryForHp(String tabName,String subcompCode)
    {  

    	//System.out.println("getting qury from dynamic query class");
    	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,";
    	String q2=tabName;
    	
    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
    	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '0%'"+
    	" group by DNAME,DCODE   order by Dname";
    	String query=q1+q2+q3;
        //System.out.println("query of coutn *"+query);
    return query;

    }
    // code added by sridhar for div report of HP 
    public String getDivisionQueryForHp(String tabName,String subcompCode)
    {
    	String q1=" select count(*)COUNT,division_office_code,division_office_name from rws_division_office_tbl d, rws_asset_mast_tbl a,";
    	String q2=tabName;
    	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		" and  a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '0%'"+
		" group by division_office_name,division_office_code order by division_office_name";
    	String query=q1+q2+q3;
    	return query;
    }
    public String  getDistrictGrillQueryForShallow_openwels_Ponds(String tabName,String subcompCode,String scheme)
    {  

    	//System.out.println("getting qury from dynamic query class");
    	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,";
    	String q2=tabName;
    	
    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
    	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl."+subcompCode+",17,3) like '"+scheme+"'"+
    	" group by DNAME,DCODE   order by Dname";
    	String query=q1+q2+q3;
        Debug.println("query of coutn *"+query);
        return query;

    }
    public String getDistrictGrillQueryforFilters(String tabName,String subcompCode,String Filtertype)
    {  
      	//System.out.println("getting qury from dynamic query class");
     	String q1="select count(*)COUNT,DNAME,Dcode  from rws_district_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='"+Filtertype+"'"+
     	"  and SUBSTR("+subcompCode+",17,3) LIKE '8%' group by DNAME,Dcode    order by Dname";
     	String query=q1+q2+q3;
         Debug.println("query of coutn *"+query);
     return query;

    }
    public String getDistrictGrillQueryforMpwsFilters(String tabName,String subcompCode,String Filtertype)
    {  
      	//System.out.println("getting qury from dynamic query class");
     	String q1="select count(*)COUNT,DNAME,Dcode  from rws_district_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='"+Filtertype+"'"+
     	"  and SUBSTR("+subcompCode+",17,3) LIKE '4%'and a.type_of_asset_code='02' group by DNAME,Dcode    order by Dname";
     	String query=q1+q2+q3;
         //System.out.println("query of coutn *"+query);
     return query;

    }
    // code added by sridhar for MPWS Filters div report 
    public String getDivisionQueryforMpwsFilters(String tabName,String subcompCode,String Filtertype,String dcode)
    {  
      
     	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='"+Filtertype+"'"+
     	"  and SUBSTR("+subcompCode+",17,3) LIKE '4%'and a.type_of_asset_code='02' and d.circle_office_code='"+dcode+"' " +
     	"group by d.division_office_name,d.division_office_code  order by d.division_office_name";
     	String query=q1+q2+q3;
        Debug.println("query of Filters Mpws *:"+query);
     return query;

    }
    // code added by sridhar for CPWS division wise report for all Filter types 
    
    
    public String getDivisionQueryforCpwsFilters(String tabName,String subcompCode,String Filtertype,String dcode,String Scheme, String assetcode)
    {  
      
     	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='"+Filtertype+"'"+
     	"  and SUBSTR("+subcompCode+",17,3) LIKE '"+Scheme+"' and a.type_of_asset_code='"+assetcode+"' and d.circle_office_code='"+dcode+"' " +
     	"group by d.division_office_name,d.division_office_code  order by d.division_office_name";
     	String query=q1+q2+q3;
        Debug.println("query of Filters Mpws *:"+query);
     return query;

    }
   
    // code added by sridhar for sub division report for MPWS
    
    public String getSubdivisionQueryforMpwsFilters(String tabName,String subcompCode,String Filtertype,String dcode,String div)
    {  
      
     	String q1="select count(*)COUNT,d.subdivision_office_name,d.subdivision_office_code  from rws_subdivision_office_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
     	"and d.subdivision_office_code=a.subdivision_office_code" +
     	" and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='"+Filtertype+"'"+
     	"  and SUBSTR("+subcompCode+",17,3) LIKE '4%'and a.type_of_asset_code='02' and d.circle_office_code='"+dcode+"' " +
     	"  and d.division_office_code='"+div +"' group by d.subdivision_office_name,d.subdivision_office_code  order by d.subdivision_office_name";
     	String query=q1+q2+q3;
        Debug.println("query of Filters Mpws *:"+query);
     return query;

    }
    
    // code added by sridhar for sub division report all filters of cpws and pws
    
    public String getSubdivisionQueryforCpwsFilters(String tabName,String subcompCode,String Filtertype,String dcode,String Scheme,String div,String assetcode)
    {  
      
     	String q1="select count(*)COUNT,d.subdivision_office_name,d.subdivision_office_code  from rws_subdivision_office_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
     	"and d.subdivision_office_code=a.subdivision_office_code" +
     	" and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='"+Filtertype+"'"+
     	"  and SUBSTR("+subcompCode+",17,3) LIKE '"+Scheme+"'and a.type_of_asset_code='"+assetcode+"' and d.circle_office_code='"+dcode+"' " +
     	"  and d.division_office_code='"+div +"' group by d.subdivision_office_name,d.subdivision_office_code  order by d.subdivision_office_name";
     	String query=q1+q2+q3;
        Debug.println("query of Filters Mpws *:"+query);
     return query;

    }
    
    
    // code end 
    public String getDistrictGrillQueryforPWSFilters(String tabName,String subcompCode,String Filtertype)
    {  
      	//System.out.println("getting qury from dynamic query class");
     	String q1="select count(*)COUNT,DNAME,Dcode  from rws_district_tbl d,rws_asset_mast_tbl a,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='"+Filtertype+"'"+
     	" and SUBSTR("+subcompCode+",17,3) LIKE '6%' group by DNAME,Dcode    order by Dname";
     	String query=q1+q2+q3;
         //System.out.println("query of coutn *"+query);
     return query;

    }
   
  
    public String getDistrictsForPwsSource(String sourceType,String subType)
    {
        	//System.out.println("getting qury from dynamic query class");
        	String q1="select count(*)COUNT,DNAME  from rws_district_tbl d,";
        	String q2="rws_source_tbl";
        	
        	String q3=" subCompTbl where   " +
        	"  substr(subCompTbl.hab_code,1,2)=d.dcode and d.dcode=d.dcode " +
        	"and subCompTbl.source_type_code='"+sourceType+"' and subCompTbl.subsource_Type_code='"+subType+"'"+
        	" group by DNAME    order by Dname";
        	String query=q1+q2+q3;
            //System.out.println("query of coutn *"+query);
          return query;
    }
    
    
    public String getDynamicQueryForCpwsFilters(ActionForm form,String subCompTbl,String subcompCode,String filter)
    {
               
              String tempQuery=" FROM RWS_ASSET_MAST_TBL M, " +
    		  subCompTbl+" subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='"+filter+"'";
    		  query=tempQuery;
    		  rws_asset_CheckList_FormBean formBean=(rws_asset_CheckList_FormBean )form;
    		    if(!formBean.get("circleCode").equals("")||!formBean.get("divisionCode").equals("")
                    ||!formBean.get("subdivisionCode").equals("")||!formBean.get("districtCode").equals("")
            		||!formBean.get("mandalCode").equals("")||!formBean.get("panchayatCode").equals("")
            		||!formBean.get("villageCode").equals(""))
            	    {
              	if(!formBean.get("districtCode").equals(""))
        		{
              		query=query+" and substr(m.hab_code,1,2)=(select dcode from rws_district_tbl where dcode='"+formBean.get("circleCode")+"')";
    			if(!formBean.get("mandalCode").equals(""))
    			{
    			query=query+" and substr(m.hab_code,6,2)='"+formBean.get("mandalCode")+"'";
    				if(!formBean.get("panchayatCode").equals(""))
    				{
    					query=query+" and substr(m.hab_code,13,2)='"+formBean.get("panchayatCode")+"'";
    					if(!formBean.get("villageCode").equals(""))
    					{
    						query=query+" and substr(m.hab_code,8,3)='"+formBean.get("villageCode")+"'";
    						
    					}
    				
    				}
    			}
    		}
    	}
              if(!formBean.get("circleCode").equals(""))
              {
    		   query=query+" and substr(M.hab_code,1,2)='"+formBean.get("circleCode") +"'";
    		    if(!formBean.get("divisionCode").equals(""))
    		    {
    			 query=query+" and M.division_office_code='"+formBean.get("divisionCode") +"'";
    			 if(!formBean.get("subdivisionCode").equals(""))
    			  {
    				query=query+" and M.subdivision_office_code='"+formBean.get("subdivisionCode") +"'";
    			 }
    		  }
    	  }
    	if(!formBean.get("assetCode").equals(""))
    	{
    	  query=query+" and M.type_of_asset_code='"+formBean.get("assetCode")+"'";
    	}
    
    	if(!formBean.get("habitationCode").equals(""))
    	{
    		query=query+" and substr(m.hab_code,11,2)=subStr("+formBean.get("habitationCode")+",11,2)";
    	}
    	query=query+" and M.type_of_asset_code='03' and substr(subCompTbl."+subcompCode+",17,3) like '8%' ";
       	return query;
    }
    public String getDynamicQueryForMpwsFilters(ActionForm form,String subCompTbl,String subcompCode,String filter)
    {
               
              String tempQuery=" FROM RWS_ASSET_MAST_TBL M, " +
    		  subCompTbl+" subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='"+filter+"'";
    		  query=tempQuery;
    		  rws_asset_CheckList_FormBean formBean=(rws_asset_CheckList_FormBean )form;
    		    if(!formBean.get("circleCode").equals("")||!formBean.get("divisionCode").equals("")
                    ||!formBean.get("subdivisionCode").equals("")||!formBean.get("districtCode").equals("")
            		||!formBean.get("mandalCode").equals("")||!formBean.get("panchayatCode").equals("")
            		||!formBean.get("villageCode").equals(""))
            	    {
              	if(!formBean.get("districtCode").equals(""))
        		{
              		query=query+" and substr(m.hab_code,1,2)=(select dcode from rws_district_tbl where dcode='"+formBean.get("circleCode")+"')";
    			if(!formBean.get("mandalCode").equals(""))
    			{
    			query=query+" and substr(m.hab_code,6,2)='"+formBean.get("mandalCode")+"'";
    				if(!formBean.get("panchayatCode").equals(""))
    				{
    					query=query+" and substr(m.hab_code,13,2)='"+formBean.get("panchayatCode")+"'";
    					if(!formBean.get("villageCode").equals(""))
    					{
    						query=query+" and substr(m.hab_code,8,3)='"+formBean.get("villageCode")+"'";
    						
    					}
    				
    				}
    			}
    		}
    	}
              if(!formBean.get("circleCode").equals(""))
              {
    		   query=query+" and substr(M.hab_code,1,2)='"+formBean.get("circleCode") +"'";
    		    if(!formBean.get("divisionCode").equals(""))
    		    {
    			 query=query+" and M.division_office_code='"+formBean.get("divisionCode") +"'";
    			 if(!formBean.get("subdivisionCode").equals(""))
    			  {
    				query=query+" and M.subdivision_office_code='"+formBean.get("subdivisionCode") +"'";
    			 }
    		  }
    	  }
    	if(!formBean.get("assetCode").equals(""))
    	{
    	  query=query+" and M.type_of_asset_code='"+formBean.get("assetCode")+"'";
    	}
    
    	if(!formBean.get("habitationCode").equals(""))
    	{
    		query=query+" and substr(m.hab_code,11,2)=subStr("+formBean.get("habitationCode")+",11,2)";
    	}
    	query=query+" and M.type_of_asset_code='02' and substr(subCompTbl."+subcompCode+",17,3) like '4%' ";
       	
    	return query;
    }
    public String getDynamicQueryForPwsFilters(ActionForm form,String subCompTbl,String subcompCode,String filter)
    {
               
              String tempQuery=" FROM RWS_ASSET_MAST_TBL M, " +
    		  subCompTbl+" subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='"+filter+"'";
    		  query=tempQuery;
    		  rws_asset_CheckList_FormBean formBean=(rws_asset_CheckList_FormBean )form;
    		    if(!formBean.get("circleCode").equals("")||!formBean.get("divisionCode").equals("")
                    ||!formBean.get("subdivisionCode").equals("")||!formBean.get("districtCode").equals("")
            		||!formBean.get("mandalCode").equals("")||!formBean.get("panchayatCode").equals("")
            		||!formBean.get("villageCode").equals(""))
            	    {
              	if(!formBean.get("districtCode").equals(""))
        		{
              		query=query+" and substr(m.hab_code,1,2)=(select dcode from rws_district_tbl where dcode='"+formBean.get("circleCode")+"')";
    			if(!formBean.get("mandalCode").equals(""))
    			{
    			query=query+" and substr(m.hab_code,6,2)='"+formBean.get("mandalCode")+"'";
    				if(!formBean.get("panchayatCode").equals(""))
    				{
    					query=query+" and substr(m.hab_code,13,2)='"+formBean.get("panchayatCode")+"'";
    					if(!formBean.get("villageCode").equals(""))
    					{
    						query=query+" and substr(m.hab_code,8,3)='"+formBean.get("villageCode")+"'";
    						
    					}
    				
    				}
    			}
    		}
    	}
              if(!formBean.get("circleCode").equals(""))
              {
    		   query=query+" and substr(M.hab_code,1,2)='"+formBean.get("circleCode") +"'";
    		    if(!formBean.get("divisionCode").equals(""))
    		    {
    			 query=query+" and M.division_office_code='"+formBean.get("divisionCode") +"'";
    			 if(!formBean.get("subdivisionCode").equals(""))
    			  {
    				query=query+" and M.subdivision_office_code='"+formBean.get("subdivisionCode") +"'";
    			 }
    		  }
    	  }
    	if(!formBean.get("assetCode").equals(""))
    	{
    	  query=query+" and M.type_of_asset_code='"+formBean.get("assetCode")+"'";
    	}
    
    	if(!formBean.get("habitationCode").equals(""))
    	{
    		query=query+" and substr(m.hab_code,11,2)=subStr("+formBean.get("habitationCode")+",11,2)";
    	}
    	query=query+" and M.type_of_asset_code='01' and substr(subCompTbl."+subcompCode+",17,3) like '6%' ";
       	
    	return query;
    }
  
    
}
