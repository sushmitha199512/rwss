/*
 * Created on 06-Oct-2010
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.reports;

import java.sql.*;

import nic.watersoft.commons.RwsOffices;
import java.util.ArrayList;
import java.util.HashSet;

import nic.watersoft.commons.Debug;

/**
 * @author Sridhar
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class rws_direct_puming_DAo {
	
	public static String formatData(float data)
	{
		int temp;
		float fraction;
		if(data==0)
		{
			return "--";
		}
		temp=(int)data;
		fraction=data-temp;
		if(fraction==0)
		{
			return temp+"";
		}
		
		return data+"";
	}
	public static String formatData(String data)
	{
	if(data==null)
	{
		return "--";
	}
	if(!(data==null))
	{
	if(data.equals("null"))
	{
	return "--";	
	}
	if(data.equals("0"))
		return "--";
	if(data.equals("Y"))
		return "YES";
	if(data.equals("N"))
		return "NO";
	if(data.equals("G"))
		return "GOOD";
	if(data.equals("B"))
		return "BAD";
	if(data.equals("E"))
		return "EXISTS";
	}
	
	return data;
	}
	public static String formatData(int data)
	{
	if(data==0)
		return "--";
	else return data+"";
	}
   public void closeAll()
   {
   	ResultSet rs=null;
   	Statement stmt=null;
   	Connection conn=null;
   	try{
   	if(rs!=null) rs.close();
   	if(stmt!=null) stmt.close();
   	if(conn!=null) conn.close();
   	}catch(Exception e)
	{
	}
	}
 
	public ArrayList getDistValues(String tabName,String cname,String scname,String assetType)
	{
		ArrayList cpwsReport=new ArrayList();
		
		try{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		conn=RwsOffices.getConn();
		String query="";
		String atype="";
		String headName="";
		Debug.println("assetType:"+assetType);
		if(assetType.equals("01")){headName="PWS";}else if(assetType.equals("02")){headName="MPWS";} else if(assetType.equals("03")){headName="CPWS";}else if(assetType.equals("09")){headName="DIRECT PUMPING";}
		else if(assetType.equals("04")){headName="HAND PUMPS";}else if(assetType.equals("05")){headName="SHALLOW HAND PUMPS";}else if(assetType.equals("06")){headName="OPEN WELLS";}else if(assetType.equals("07")){headName="PONDS";}
			
	 if(assetType.equals("01")||assetType.equals("02") ||assetType.equals("03") || assetType.equals("09")){
		if(cname.equals("01") && scname.equals("001"))
		{
		 atype="SOURCE-SUBSURFACE SOURCE";
		String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.dcode " +
     	" and a.type_of_asset_code=t.type_of_asset_code and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
     	" and a.type_of_asset_code='"+assetType+"' and subCompTbl.SOURCE_TYPE_CODE= '1' "+
     	" group by DNAME,DCODE order by Dname";
     	 query=q1+q2+q3;   
		          
		}else if(cname.equals("01") && scname.equals("002"))
		{
			atype="SOURCE-SURFACE SOURCE";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	     	" and substr(a.hab_code,1,2)=d.dcode " +
	     	" and a.type_of_asset_code=t.type_of_asset_code  and  a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	     	" a.type_of_asset_code='"+assetType+"'  and subCompTbl.SOURCE_TYPE_CODE= '2' "+
	     	" group by DNAME,DCODE order by Dname";
	     	 query=q1+q2+q3;
				  
		}else if(cname.equals("01") && scname.equals("003"))
		{
			atype="PUMPING-PUMPSETS";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and  a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		}
		else if(cname.equals("02") && scname.equals("001"))
		{
			atype="HEAD WORKS-RAW WATER COLLECTION WELL";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		}
		else if(cname.equals("02") && scname.equals("002"))
		{
			atype="HEAD WORKS-SS TANK";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and  a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		}
		else if(cname.equals("02") && scname.equals("003"))
		{
			atype="HEAD WORKS-SS FILTER";
			String q1="select count(*)COUNT,DNAME,Dcode  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	     	" and substr(a.hab_code,1,2)=d.dcode  and  a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
	     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='SS'"+
	     	"   and a.type_of_asset_code='"+assetType+"' group by DNAME,Dcode order by Dname";
	    	
	    	 query=q1+q2+q3;
		}
		else if(cname.equals("02") && scname.equals("004"))
		{
			atype="HEAD WORKS-RS FILTER";
			String q1="select count(*)COUNT,DNAME,Dcode  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	     	" and substr(a.hab_code,1,2)=d.dcode and  a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
	     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='RS'"+
	     	"   and a.type_of_asset_code='"+assetType+"' group by DNAME,Dcode order by Dname";
	     	 query=q1+q2+q3;
	    	 
		}
		else if(cname.equals("02") && scname.equals("005"))
		{
			atype="HEAD WORKS-SUMP";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and  a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	  	}
		else if(cname.equals("02") && scname.equals("006"))
		{
			atype="HEAD WORKS-FOOT PATH BRIDGE";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a, rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and  a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
		    	" and a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	 
	    	 query=q1+q2+q3;
	  	}
		else if(cname.equals("02") && scname.equals("007"))
		{
			atype="HEAD WORKS-PUMP HOUSE";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	  	}
		else if(cname.equals("02") && scname.equals("008"))
		{
			atype="HEAD WORKS-WATCHMAN QUARTER";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a, rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	  	}else if(cname.equals("02") && scname.equals("009"))
		{
	  		atype="HEAD WORKS-CLEAR WATER COLLECTION WELL ";
	  		String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	  	}
	  	else if(cname.equals("02") && scname.equals("010"))
		{
	  		atype="HEAD WORKS-MICRO FILTER";
	  		String q1="select count(*)COUNT,DNAME,Dcode  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	     	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
	     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='MS'"+
	     	"   and a.type_of_asset_code='"+assetType+"' group by DNAME,Dcode order by Dname";
	     	 query=q1+q2+q3;
	    	 
		}
	  	else if(cname.equals("02") && scname.equals("011"))
		{
	  		atype="HEAD WORKS-RO PLANTS ";
	  		String q1="select count(*)COUNT,DNAME,Dcode  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	     	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
	     	"and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='RP'"+
	     	"   and a.type_of_asset_code='"+assetType+"' group by DNAME,Dcode order by Dname";
	     	 query=q1+q2+q3;
	    	 
		}
		else if(cname.equals("03") && scname.equals("001"))
		{
			atype="PIPELINE-PUMPING MAIN";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	" a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	    	 
		}
		else if(cname.equals("03") && scname.equals("002"))
		{
			atype="PIPELINE-GRAVITY MAIN";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	    	 
		}
		else if(cname.equals("03") && scname.equals("003"))
		{
			atype="PIPELINE-DISTRIBUTION";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	" a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	    }
		
		else if(cname.equals("04") && scname.equals("001"))
		{
			atype="SR.RESERVOIRS-OHSR";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		}
		else if(cname.equals("04") && scname.equals("002"))
		{
			atype="SR.RESERVOIRS-OHBR";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		}
		else if(cname.equals("04") && scname.equals("003"))
		{
			atype="SR.RESERVOIRS-GLSR";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	"a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		}
		 else if(cname.equals("04") && scname.equals("004"))
		  {
		 	atype="SR.RESERVOIRS-GLBR";
		 	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	" a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		  }
		 else if(cname.equals("04") && scname.equals("005"))
		  {
		 	atype="SR.RESERVOIRS-BPT";
		 	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	" a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		  }
		 else if(cname.equals("04") && scname.equals("006"))
		  {
		 	atype="SR.RESERVOIRS-CISTERNS";
		 	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	" a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		  }
		else if(cname.equals("05") && scname.equals("001"))
		{
			atype="OTHERS-MISCELLANEOUS";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	" a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
		}
		else if(cname.equals("05") && scname.equals("002"))
		{
			atype="OTHERS-CHLORINATION";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	" a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	    	 
		}
		else if(cname.equals("05") && scname.equals("003"))
		{
			atype="OTHERS-O AND M";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	" a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	    	 
		}
		else if(cname.equals("06") && scname.equals("001"))
		{
			atype="PUMPING-PUMPSETS";
			String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.dcode and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code" +
		    	" and a.type_of_asset_code=t.type_of_asset_code  and " +
		    	" a.type_of_asset_code='"+assetType+"' group by DNAME,DCODE order by Dname";	
	    	
	    	 query=q1+q2+q3;
	    	 
		}
	 } 
	 else if(assetType.equals("04"))
	 { 
	 	if(cname.equals("01") && scname.equals("001"))
		{
	 		atype="SOURCE-BOREWELL";
	 		String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.dcode " +
	    	" and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='04' "+
	    	" group by DNAME,DCODE   order by Dname";
	    	 query=q1+q2+q3;	
		}
	 }
	 else if(assetType.equals("05"))
	 {
	 	if(cname.equals("01") && scname.equals("001"))
		{
	 		
	 	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
    	String q2=tabName;
    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.dcode " +
    	" and a.type_of_asset_code=t.type_of_asset_code and t.type_of_asset_code='05' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code "+
    	" group by DNAME,DCODE   order by Dname";
    	 query=q1+q2+q3;
        
		}
	 }
	 else if(assetType.equals("06"))
	 {
	 	if(cname.equals("01") && scname.equals("001"))
		{
	 		
	 	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
    	String q2=tabName;
    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.dcode " +
    	" and a.type_of_asset_code=t.type_of_asset_code  and t.type_of_asset_code='06' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code "+
    	" group by DNAME,DCODE   order by Dname";
    	 query=q1+q2+q3;
        
		}
	 }else if(assetType.equals("07"))
	 {
	 	if(cname.equals("01") && scname.equals("001"))
		{
	 		
	 	String q1="select count(*)COUNT,DNAME,DCODE  from rws_district_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
    	String q2=tabName;
    	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
    	" and substr(a.hab_code,1,2)=d.dcode " +
    	" and a.type_of_asset_code=t.type_of_asset_code and  a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='07' "+
    	" group by DNAME,DCODE  order by Dname";
    	 query=q1+q2+q3;
        
		}
	 }
		rws_asset_cpws_DrillDownBean cpwsGrill;
		cpwsGrill=new rws_asset_cpws_DrillDownBean();
		cpwsGrill.setAstName(headName+"-"+atype+" REPORT");
		cpwsReport.add(cpwsGrill);
	  	Debug.println("qry:"+query);
	  	stmt=conn.createStatement();
	  	rs=stmt.executeQuery(query);
	  	String sno="1";
	  	int tot=0; 
	  	while(rs.next())
	  	{
	  		cpwsGrill=new rws_asset_cpws_DrillDownBean();
	  		cpwsGrill.setSno(sno);
        	cpwsGrill.setDistCode(rs.getString("DCODE"));
        	cpwsGrill.setName(rs.getString("DNAME"));
        	cpwsGrill.setTotal(rs.getString("COUNT"));
        	cpwsGrill.setDCode(rs.getString("DCODE"));
        	tot=tot+Integer.parseInt(rs.getString("count"));
        	cpwsReport.add(cpwsGrill);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
        	
	  	}
	  	
	  	/*cpwsGrill=new rws_asset_cpws_DrillDownBean();
    	cpwsGrill.setSno("**");
    	cpwsGrill.setName("Total");
    	cpwsGrill.setTotal(Integer.toString(tot));
    	cpwsReport.add(cpwsGrill);*/
	 
	  }catch(Exception e)
		{
		 Debug.println("Exception Distvalues list:"+e);	
		}
	 
	  return  cpwsReport;	
	}

	public ArrayList getDivValues(String tabName,String cname,String scname,String assetType,String dcode,String dname)
	{
		ArrayList cpwsReport=new ArrayList();
		try{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		conn=RwsOffices.getConn();
		String query="";
		String headName="";
		String atype="";
		Debug.println("dname:"+dname);
	if(assetType.equals("01")){headName="PWS";}else if(assetType.equals("02")){headName="MPWS";} else if(assetType.equals("03")){headName="CPWS";}else if(assetType.equals("09")){headName="DIRECT PUMPING";}
	else if(assetType.equals("04")){headName="HAND PUMPS";}else if(assetType.equals("05")){headName="SHALLOW HAND PUMPS";}else if(assetType.equals("06")){headName="OPEN WELLS";}else if(assetType.equals("07")){headName="PONDS";}
	 if(assetType.equals("01")|| assetType.equals("02")|| assetType.equals("03") || assetType.equals("09"))
	 {		
		if(cname.equals("01") && scname.equals("001"))
		{
		atype="SOURCE-SUBSURFACE SOURCE";
		String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code  and d.division_office_code=a.division_office_code " +
     	"and a.type_of_asset_code=t.type_of_asset_code  and  a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
     	 "a.type_of_asset_code='"+assetType+"' and subCompTbl.SOURCE_TYPE_CODE= '1'"+
     	" and d.circle_office_code='"+dcode+"'group by d.division_office_code,d.division_office_name  order by d.division_office_name";
     	 query=q1+q2+q3;
		  
		}
		else if(cname.equals("01") && scname.equals("002"))
		{
			atype="SOURCE-SURFACE SOURCE";
			String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	     	" and substr(a.hab_code,1,2)=d.circle_office_code  and d.division_office_code=a.division_office_code " +
	     	"and a.type_of_asset_code=t.type_of_asset_code  and  a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	     	 "a.type_of_asset_code='"+assetType+"' and subCompTbl.SOURCE_TYPE_CODE= '2'"+
	     	" and d.circle_office_code='"+dcode+"'group by d.division_office_code,d.division_office_name  order by d.division_office_name";
	     	 query=q1+q2+q3;
		  
		}
		else if(cname.equals("01") && scname.equals("003"))
		{
			atype="PUMPING-PUMPSETS";
			String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
		    	" a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
		    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
	    	 query=q1+q2+q3;
		}
		else if(cname.equals("02") && scname.equals("001"))
		{
		atype="HEAD WORKS-RAW WATER COLLECTION WELL";
		String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("02") && scname.equals("002"))
	  {
	 	atype="HEAD WORKS-SS TANK";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("02") && scname.equals("003"))
	  {
	 	atype="HEAD WORKS-SS FILTER";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
     	" and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='SS'" +
     	"  and a.type_of_asset_code='"+assetType+"' and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
     	" group by d.division_office_name,d.division_office_code  order by d.division_office_name";
     	 query=q1+q2+q3;
	  }
	 else if(cname.equals("02") && scname.equals("004"))
	  {
	 	atype="HEAD WORKS-RS FILTER";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
     	" and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='RS'" +
     	"  and a.type_of_asset_code='"+assetType+"' and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
     	" group by d.division_office_name,d.division_office_code  order by d.division_office_name";
     	 query=q1+q2+q3;
	  
	  }
	 else if(cname.equals("02") && scname.equals("005"))
	  {
	 	atype="HEAD WORKS-SUMP";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("02") && scname.equals("006"))
	  {
	 	atype="HEAD WORKS-FOOT PATH BRIDGE";
	 	
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("02") && scname.equals("007"))
	  {
	 	atype="HEAD WORKS-PUMP HOUSE";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  
	  }
	 else if(cname.equals("02") && scname.equals("008"))
	  {
	 	atype="HEAD WORKS-WATCHMAN QUARTER";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("02") && scname.equals("009"))
	  {
	 	atype="HEAD WORKS-CLEAR WATER COLLECTION WELL";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("02") && scname.equals("010"))
	  {
	 	atype="HEAD WORKS-MICRO FILTER";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
     	" and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='MS'" +
     	"  and a.type_of_asset_code='"+assetType+"' and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
     	" group by d.division_office_name,d.division_office_code  order by d.division_office_name";
     	 query=q1+q2+q3;
	  }
	 else if(cname.equals("02") && scname.equals("011"))
	  {
	 	atype="HEAD WORKS-RO PLANTS";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
     	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
     	" and a.type_of_asset_code=t.type_of_asset_code and substr(subCompTbl.WTPSC_CODE,20,2)='RP'" +
     	"  and a.type_of_asset_code='"+assetType+"' and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code " +
     	" group by d.division_office_name,d.division_office_code  order by d.division_office_name";
     	 query=q1+q2+q3;
	  }
	 else if(cname.equals("03") && scname.equals("001"))
	  {
	 	atype="PIPELINE-PUMPING MAIN";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  
	  }
	 else if(cname.equals("03") && scname.equals("002"))
	  {
	 	atype="PIPELINE-GRAVITY MAIN";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("03") && scname.equals("003"))
	  {
	 	atype="PIPELINE-DISTRIBUTION";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  
	  }
	 else if(cname.equals("04") && scname.equals("001"))
		{
	 	atype="SR.RESERVOIRS-OHSR";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
		}
		else if(cname.equals("04") && scname.equals("002"))
		{
			atype="SR.RESERVOIRS-OHBR";
			String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
		    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
		    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
	    	 query=q1+q2+q3;
		}
		else if(cname.equals("04") && scname.equals("003"))
		{
			atype="SR.RESERVOIRS-GLSR";
			String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
		    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
		    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
	    	 query=q1+q2+q3;
		}
		 else if(cname.equals("04") && scname.equals("004"))
		  {
		 	atype="SR.RESERVOIRS-GLBR";
		 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
		    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
		    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
	    	 query=q1+q2+q3;
		  }
		 else if(cname.equals("04") && scname.equals("005"))
		  {
		 	atype="SR.RESERVOIRS-BPT";
		 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
		    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
		    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
	    	 query=q1+q2+q3;
		  }
		 else if(cname.equals("04") && scname.equals("006"))
		  {
		 	atype="SR.RESERVOIRS-CISTERNS";
		 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	     	String q2=tabName;
	     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
		    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
		    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
		    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
		    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
	    	 query=q1+q2+q3;
		  }
	 else if(cname.equals("05") && scname.equals("001"))
	  {
	 	atype="OTHERS-MISCLLANEOUS";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("05") && scname.equals("002"))
	  {
	 	atype="OTHERS-CHLORINATION";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("05") && scname.equals("003"))
	  {
	 	atype="OTHERS-O AND M";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 else if(cname.equals("06") && scname.equals("001"))
	  {
	 	atype="PUMPING-PUMPSETS";
	 	String q1="select count(*)COUNT,d.division_office_name,d.division_office_code  from rws_division_office_tbl d,rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
     	String q2=tabName;
     	String q3=" subCompTbl,rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code   " +
	    	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code  " +
	    	"and a.type_of_asset_code=t.type_of_asset_code  and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code and " +
	    	"a.type_of_asset_code='"+assetType+"'  and d.circle_office_code='"+dcode+"' "+
	    	" group by d.division_office_name,d.division_office_code order by d.division_office_name";	
    	 query=q1+q2+q3;
	  }
	 }else if(assetType.equals("04"))
	 {
	 	atype="SOURCE-BOREWELL";
	 	String q1=" select count(*)COUNT,d.division_office_code,d.division_office_name from rws_division_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
    	String q2=tabName;
    	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		" and  a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='04'"+
		" group by d.division_office_name,d.division_office_code order by d.division_office_name";
        query=q1+q2+q3;
	 }
	 else if(assetType.equals("05"))
	 {
	 	String q1=" select count(*)COUNT,d.division_office_code,d.division_office_name from rws_division_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	 	String q2=tabName;
	 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		" and  a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='05'"+
		" group by d.division_office_name,d.division_office_code order by d.division_office_name";
	     query=q1+q2+q3;
	 }else if(assetType.equals("06"))
	 {
	 	String q1=" select count(*)COUNT,d.division_office_code,d.division_office_name from rws_division_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	 	String q2=tabName;
	 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		" and  a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='06'"+
		" group by d.division_office_name,d.division_office_code order by d.division_office_name";
	    query=q1+q2+q3;
	 }
	 else if(assetType.equals("07"))
	 {
	 	String q1=" select count(*)COUNT,d.division_office_code,d.division_office_name from rws_division_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	 	String q2=tabName;
	 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		" and  a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='07' "+
		" group by d.division_office_name,d.division_office_code order by d.division_office_name";
	    query=q1+q2+q3;
	 }
	  Debug.println("Divquery:"+query);
	   rws_asset_cpws_DrillDownBean cpwsGrill;
	   cpwsGrill=new rws_asset_cpws_DrillDownBean();
	   cpwsGrill.setAstName(headName+"-"+atype+" REPORT");
	   cpwsGrill.setDistCode(dname);
	   cpwsReport.add(cpwsGrill);
	  	//Debug.println("qry:"+query);
	  	stmt=conn.createStatement();
	  	rs=stmt.executeQuery(query);
	  	String sno="1";
	  	int tot=0;
	  	while(rs.next())
	  	{
	  		cpwsGrill=new rws_asset_cpws_DrillDownBean();
        	cpwsGrill.setSno(sno);
        	cpwsGrill.setName(rs.getString("division_office_name"));
        	cpwsGrill.setTotal(rs.getString("COUNT"));
        	cpwsGrill.setDivCode(rs.getString("division_office_code"));
        	tot=tot+Integer.parseInt(rs.getString("count"));
            cpwsReport.add(cpwsGrill);
        	int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
      	
	  	}
	  	
	  	/*cpwsGrill=new rws_asset_cpws_DrillDownBean();
    	cpwsGrill.setSno("**");
    	cpwsGrill.setName("Total");
    	cpwsGrill.setTotal(Integer.toString(tot));
    	cpwsReport.add(cpwsGrill);*/
  	   
	}catch(Exception e)
	{
		Debug.println("Exception in Division Values:"+e);
	}
	
	
	return cpwsReport;
	}
	
	public ArrayList getSubdivValues(String tabName,String cname,String scname,String assetType,String dcode,String divcode,String divname)
	{
		ArrayList cpwsReport=new ArrayList();
		try{
		Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		conn=RwsOffices.getConn();
		String query="";
		String atype="";
		String headName="";
		if(assetType.equals("01")){headName="PWS";}else if(assetType.equals("02")){headName="MPWS";} else if(assetType.equals("03")){headName="CPWS";}else if(assetType.equals("09")){headName="DIRECT PUMPING";}
		else if(assetType.equals("04")){headName="HAND PUMPS";}else if(assetType.equals("05")){headName="SHALLOW HAND PUMPS";}else if(assetType.equals("06")){headName="OPEN WELLS";}else if(assetType.equals("07")){headName="PONDS";}
	    if(assetType.equals("01") || assetType.equals("02")||assetType.equals("03")|| assetType.equals("09"))
	    {
		if(cname.equals("01") && scname.equals("001"))
		  {
			atype="SOURCE-SUBSURFACE SOURCE";
			String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' and subCompTbl.SOURCE_TYPE_CODE= '1' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		    
		 	 query=q1+q2+q3;
		 	
		  }
		 else if(cname.equals("01") && scname.equals("002"))
		 {
		 	atype="SOURCE-SURFACE SOURCE";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' and subCompTbl.SOURCE_TYPE_CODE= '2' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		    
		 	 query=q1+q2+q3;
		 }
		 else if(cname.equals("01") && scname.equals("003"))
		 {
		 	atype="PUMPING-PUMPSETS";
		 	
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		 }
		 else if(cname.equals("02") && scname.equals("001"))
		  {
		 	atype="HEAD WORKS-RAW WATER COLLECTION WELL";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("02") && scname.equals("002"))
		  {
		 	atype="HEAD WORKS-SS TANK";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("02") && scname.equals("003"))
		  {
		 	atype="HEAD WORKS-SS FILTER";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' and substr(subCompTbl.WTPSC_CODE,20,2)='SS' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("02") && scname.equals("004"))
		  {
		 	atype="HEAD WORKS-RS FILTER";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' and substr(subCompTbl.WTPSC_CODE,20,2)='RS' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("02") && scname.equals("005"))
		  {
		 	atype="HEAD WORKS-SUMP";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("02") && scname.equals("006"))
		  {
		 	atype="HEAD WORKS-FOOT PATH BRIDGE";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("02") && scname.equals("007"))
		  {
		 	atype="HEAD WORKS-PUMP HOUSE";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("02") && scname.equals("008"))
		  {
		 	atype="HEAD WORKS-WATCHAMN QUARTER"; 
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		 	
		  }
		 else if(cname.equals("02") && scname.equals("009"))
		  {
		 	atype="HEAD WORKS-CLEAR WATER COLLECTION WELL";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("02") && scname.equals("010"))
		  {
		 	atype="HEAD WORKS-MICRO FILTER";
		 	
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' and substr(subCompTbl.WTPSC_CODE,20,2)='MS' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("02") && scname.equals("011"))
		  {
		 	atype="HEAD WORKS-RO PLANTS";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' and substr(subCompTbl.WTPSC_CODE,20,2)='RP' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("03") && scname.equals("001"))
		  {
		 	atype="PIPELINE-PUMPING MAIN";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("03") && scname.equals("002"))
		  {
		 	atype="PIPELINE-GRAVITY MAIN";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("03") && scname.equals("003"))
		  {
		 	atype="PIPELINE-DISTRIBUTION";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("04") && scname.equals("001"))
			{
		 	atype="SR.RESERVOIRS-OHSR";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
			}
			else if(cname.equals("04") && scname.equals("002"))
			{
				atype="SR.RESERVOIRS-OHBR";
				String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
			 	String q2=tabName;
			 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
			 	" and a.type_of_asset_code='"+assetType+"' "+
			 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
			 	query=q1+q2+q3;
			}
			else if(cname.equals("04") && scname.equals("003"))
			{
				atype="SR.RESERVOIRS-GLSR";
				String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
			 	String q2=tabName;
			 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
			 	" and a.type_of_asset_code='"+assetType+"' "+
			 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
			 	query=q1+q2+q3;
			}
			else if(cname.equals("04") && scname.equals("004"))
			 {
				atype="SR.RESERVOIRS-GLBR";
				String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
			 	String q2=tabName;
			 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
			 	" and a.type_of_asset_code='"+assetType+"' "+
			 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
			 	query=q1+q2+q3;
			}
		else if(cname.equals("04") && scname.equals("005"))
		  {
			atype="SR.RESERVOIRS-BPT";
			String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;  
		  }
		else if(cname.equals("04") && scname.equals("006"))
		 {
			atype="SR.RESERVOIRS-CISTERNS";
			String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("05") && scname.equals("001"))
		  {
		 	atype="OTHERS-MISCLLANEOUS";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("05") && scname.equals("002"))
		  {
		 	atype="OTHERS-CHLORINATION";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("05") && scname.equals("003"))
		  {
		 	atype="OTHERS-O AND M";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
		 else if(cname.equals("06") && scname.equals("001"))
		  {
		 	atype="PUMPING-PUMPSETS";
		 	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
		 	String q2=tabName;
		 	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
		 	" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
		 	" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' "+
		 	" and a.type_of_asset_code='"+assetType+"' "+
		 	" and d.division_office_code='"+divcode+"' and a.asset_code=s.asset_code and s.asset_code=subCompTbl.asset_code  group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
		 	query=q1+q2+q3;
		  }
	    }
	    else if(assetType.equals("04"))
	    {
	    	atype="BOREWELL";
	        String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='04' "+
			" and d.division_office_code='"+divcode+"' group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
	        query=q1+q2+q3;	
	    }
	    else if(assetType.equals("05"))
	    {
	    	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='05' "+
			" and d.division_office_code='"+divcode+"' group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
	        query=q1+q2+q3;	
	    }
	    else if(assetType.equals("06"))
	    {
	    	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='06' "+
			" and d.division_office_code='"+divcode+"' group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
	        query=q1+q2+q3;	
	    }
	    else if(assetType.equals("07"))
	    {
	    	String q1=" select count(*)COUNT,d.subdivision_office_code,d.subdivision_office_name from rws_subdivision_office_tbl d, rws_asset_mast_tbl a,rws_asset_scheme_tbl s,";
	    	String q2=tabName;
	    	String q3=" subCompTbl, rws_asset_type_tbl t where a.asset_code=subCompTbl.asset_code  " +
			" and substr(a.hab_code,1,2)=d.circle_office_code and d.division_office_code=a.division_office_code "+
			" and d.subdivision_office_code=a.subdivision_office_code and a.type_of_asset_code=t.type_of_asset_code and d.circle_office_code='"+dcode+"' and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='07'"+
			" and d.division_office_code='"+divcode+"' group by d.subdivision_office_name,d.subdivision_office_code order by d.subdivision_office_name";
	        query=q1+q2+q3;	
	    }
		 Debug.println("subDivquery:"+query);
		// Debug.println("divname:"+divname);
		    rws_asset_cpws_DrillDownBean cpwsGrill;
		    cpwsGrill=new rws_asset_cpws_DrillDownBean();
		    cpwsGrill.setAstName(headName+"-"+atype+" REPORT");
		    cpwsGrill.setDivName(divname);
		    cpwsReport.add(cpwsGrill);	
		  	Debug.println("qry:"+query);
		  	stmt=conn.createStatement();
		  	rs=stmt.executeQuery(query);
		  	String sno="1";
		  	int tot=0;
		  	while(rs.next())
		  	{
		  		cpwsGrill=new rws_asset_cpws_DrillDownBean();
	        	cpwsGrill.setSno(sno);
	        	cpwsGrill.setName(rs.getString("subdivision_office_name"));
	        	cpwsGrill.setTotal(rs.getString("COUNT"));
	        	cpwsGrill.setSubdivCode(rs.getString("subdivision_office_code"));
	        	tot=tot+Integer.parseInt(rs.getString("count"));
	            cpwsReport.add( cpwsGrill);
	        	int no=Integer.parseInt(sno);  
	        	no++;
	            sno=""+no;
	      	
		  	}
		  	
		  	/*cpwsGrill=new rws_asset_cpws_DrillDownBean();
	    	cpwsGrill.setSno("**");
	    	cpwsGrill.setName("Total");
	    	cpwsGrill.setTotal(Integer.toString(tot));
	    	cpwsReport.add(cpwsGrill);*/
	  	   
		 
		 
		}catch(Exception e)
		{
			Debug.println("Exception in SubDivision Values:"+e);	
		}
		return cpwsReport;
		}
	public ArrayList getMandalValues(String tabName,String cname,String scname,String assetType,String dcode,String divcode,String subcode)
	{
	   ArrayList cpwsReport=new ArrayList();
	   try{
	   	Connection conn=null;
		Statement stmt=null;
		ResultSet rs=null;
		conn=RwsOffices.getConn(); 
	   	String query="";
	   	String atype="";
	   	String headName="";
		if(assetType.equals("01")){headName="PWS";}else if(assetType.equals("02")){headName="MPWS";} else if(assetType.equals("03")){headName="CPWS";}else if(assetType.equals("09")){headName="DIRECT PUMPING";}
		else if(assetType.equals("04")){headName="HAND PUMPS";}else if(assetType.equals("05")){headName="SHALLOW HAND PUMPS";}else if(assetType.equals("06")){headName="OPEN WELLS";}else if(assetType.equals("07")){headName="PONDS";}
		
		if(assetType.equals("01")||assetType.equals("02")||assetType.equals("03")||assetType.equals("09")){
		if(cname.equals("01") && scname.equals("001"))
		{
		 atype="SOURCE-SUBSURFACE SOURCE";
		 query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' and subCompTbl.SOURCE_TYPE_CODE='1' group by man.MNAME,man.mcode order by man.MNAME";
		 }
		else if(cname.equals("01") && scname.equals("002"))
		{
		  atype="SOURCE-SURFACE SOURCE";
		  query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' and subCompTbl.SOURCE_TYPE_CODE='2' group by man.MNAME,man.mcode order by man.MNAME";
		}
		else if(cname.equals("01") && scname.equals("003"))
		{
			atype="PUMPING-PUMPSETS";
			query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"'  group by man.MNAME,man.mcode order by man.MNAME";
		}
		else if(cname.equals("02") && scname.equals("001"))
		{
		  atype="HEAD WORKS-RAW WATER COLLECTION WELL";
		  query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"'  group by man.MNAME,man.mcode order by man.MNAME";
		}
		else if(cname.equals("02") && scname.equals("002"))
		{
		 atype="HEAD WORKS-SS TANK";
		 query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"'  group by man.MNAME,man.mcode order by man.MNAME";
		}
		else if(cname.equals("02") && scname.equals("003"))
		{
			atype="HEAD WORKS-SS FILTER";
			query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' and  substr(subCompTbl.WTPSC_CODE,20,2)='SS'  group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("02") && scname.equals("004"))
		  {
		 	atype="HEAD WORKS-RS FILTER";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' and  substr(subCompTbl.WTPSC_CODE,20,2)='RS'  group by man.MNAME,man.mcode order by man.MNAME";
		  }

		 else if(cname.equals("02") && scname.equals("005"))
		  {
		 	atype="HEAD WORKS-SUMP";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("02") && scname.equals("006"))
		  { 
		 	atype="HEAD WORKS-FOOT PATH BRIDGE";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";

		  }
		 else if(cname.equals("02") && scname.equals("007"))
		  {
		 	atype="HEAD WORKS-PUMP HOUSE";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("02") && scname.equals("008"))
		  {
		 	atype="HEAD WORKS-WATCHMAN QUARTER";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("02") && scname.equals("009"))
		  {
		 	atype="HEAD WORKS-CLEAR WATER COLLECTION WELL";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  	}
		 else if(cname.equals("02") && scname.equals("010"))
		  {
		 	atype="HEAD WORKS-MICRO FILTER";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' and  substr(subCompTbl.WTPSC_CODE,20,2)='MS' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("02") && scname.equals("011"))
		  {
		 	atype="HEAD WORKS-RO PLANTS";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' and  substr(subCompTbl.WTPSC_CODE,20,2)='RP' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("03") && scname.equals("001"))
		  {
		 	atype="PIPELINE-PUMPING MAIN";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("03") && scname.equals("002"))
		  {
		 	atype="PIPELINE-GRAVITY MAIN";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  } 
		 else if(cname.equals("03") && scname.equals("003"))
		  {
		 	atype="PIPELINE-DISTRIBUTION";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("04") && scname.equals("001"))
		 {
		   atype="SR.RESERVOIRS-OHSR";
		   query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		 }
		 else if(cname.equals("04") && scname.equals("002"))
		  {
			atype="SR.RESERVOIRS-OHBR";
			query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";	
		  }
		 else if(cname.equals("04") && scname.equals("003"))
		  {
			atype="SR.RESERVOIRS-GLSR";
			query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("04") && scname.equals("004"))
		   {
			atype="SR.RESERVOIRS-GLBR";
			query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		   }
		 else if(cname.equals("04") && scname.equals("005"))
		   {
			atype="SR.RESERVOIRS-BPT";
			query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		    }
			else if(cname.equals("04") && scname.equals("006"))
			  {
				atype="SR.RESERVOIRS-CISTERNS";
				query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
			  }
		 else if(cname.equals("05") && scname.equals("001"))
		  {
		 	atype="OTHERS-MISCLLANEOUS";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("05") && scname.equals("002"))
		  {
		 	atype="OTHERS-CHLORINATION";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		 	}
		 
		 else if(cname.equals("05") && scname.equals("003"))
		  {
		 	atype="OTHERS-O AND M";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  }
		 else if(cname.equals("06") && scname.equals("001"))
		  {
		 	atype="PUMPING-PUMPSETS";
		 	query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man,rws_asset_mast_tbl a,"+tabName+" subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode  and a.type_of_asset_code='"+assetType+"' and man.dcode='"+dcode+"' and a.circle_office_code='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by man.MNAME,man.mcode order by man.MNAME";
		  } 
	   }else if(assetType.equals("04"))
		 {
	   		atype="BOREWELL";
		   /*query="select count(*)COUNT,dname,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man," +
			" rws_asset_mast_tbl a,rws_asset_scheme_tbl s,"+tabName+" subCompTbl ,rws_asset_type_tbl t,rws_mandal_subdivision_tbl sub where " +
			" a.asset_code=subCompTbl.asset_code and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and " +
			" a.type_of_asset_code=t.type_of_asset_code and d.dcode=man.dcode and  " +
			" a.type_of_asset_code='"+assetType+"' and d.dcode=sub.dcode  and a.asset_code=s.asset_code and  subCompTbl.asset_code=s.asset_code and t.type_of_asset_code='04' " +
			" and man.dcode=sub.dcode and man.mcode=sub.mcode and a.division_office_code=sub.division_office_code and a.subdivision_office_code=sub.subdivision_office_code " +
			" and man.dcode='"+dcode+"' and a.division_office_code='"+divcode+"' and a.subdivision_office_code='"+subcode+"' group by dname,man.MNAME,man.mcode order by man.MNAME";*/
		 
		 query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man, rws_asset_mast_tbl a,"+tabName+"  subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code  and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode   and man.dcode='"+dcode+"'  and a.circle_office_Code='"+dcode+"' and a.DIVISION_OFFICE_CODE='"+divcode+"'  and a.subdivision_office_code='"+subcode+"' and a.type_of_asset_code='"+assetType+"' group by man.mcode,trim(man.MNAME)";
		 
		 }
	   else if(assetType.equals("05")) 
		 {
	    query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man, rws_asset_mast_tbl a,"+tabName+"  subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code  and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode   and man.dcode='"+dcode+"'  and a.circle_office_Code='"+dcode+"' and a.DIVISION_OFFICE_CODE='"+divcode+"'  and a.subdivision_office_code='"+subcode+"' and a.type_of_asset_code='"+assetType+"' group by man.mcode,trim(man.MNAME)";
		 }
	   else if(assetType.equals("06")) 
		 {
	    query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man, rws_asset_mast_tbl a,"+tabName+"  subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code  and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode   and man.dcode='"+dcode+"'  and a.circle_office_Code='"+dcode+"' and a.DIVISION_OFFICE_CODE='"+divcode+"'  and a.subdivision_office_code='"+subcode+"' and a.type_of_asset_code='"+assetType+"' group by man.mcode,trim(man.MNAME)";
		 }
	   else if(assetType.equals("07"))
		{
	    query="select count(*)COUNT,man.mcode,trim(man.MNAME)as Mandal from rws_district_tbl d,rws_mandal_tbl man, rws_asset_mast_tbl a,"+tabName+"  subCompTbl ,rws_asset_type_tbl t  where  a.asset_code=subCompTbl.asset_code  and substr(a.hab_code,1,2) = man.dcode and substr(a.hab_code,6,2) = man.mcode and a.type_of_asset_code=t.type_of_asset_code  and d.dcode=man.dcode   and man.dcode='"+dcode+"'  and a.circle_office_Code='"+dcode+"' and a.DIVISION_OFFICE_CODE='"+divcode+"'  and a.subdivision_office_code='"+subcode+"' and a.type_of_asset_code='"+assetType+"' group by man.mcode,trim(man.MNAME)";
	   	}
		 Debug.println("Mandal Qry:"+query);
		 rws_asset_cpws_DrillDownBean cpwsGrill;
		 cpwsGrill=new rws_asset_cpws_DrillDownBean();
		 cpwsGrill.setAstName(headName+"-"+atype+" REPORT");
		 cpwsReport.add(cpwsGrill);	
		 String sno="1";
		 int tot=0;  
		 stmt=conn.createStatement();
		 rs=stmt.executeQuery(query);    
		 while(rs.next())
         {     
        	cpwsGrill=new rws_asset_cpws_DrillDownBean();   
        	cpwsGrill.setSno(sno);
        	cpwsGrill.setName(rs.getString("Mandal"));
        	cpwsGrill.setSno(rs.getString("mcode"));
        	cpwsGrill.setTotal(rs.getString("COUNT"));
            tot=tot+Integer.parseInt(rs.getString("count"));
            cpwsReport.add(cpwsGrill);
            int no=Integer.parseInt(sno);
        	no++;
            sno=""+no;
            }
		    /*cpwsGrill=new rws_asset_cpws_DrillDownBean();
	    	cpwsGrill.setSno("**");
	    	cpwsGrill.setName("Total");
	    	cpwsGrill.setTotal(Integer.toString(tot));
	    	cpwsReport.add(cpwsGrill);*/
	   }catch(Exception e)
	   {
	   	Debug.println("Exception in Mandal Values :"+e);
	   }
	   return cpwsReport;
	
	}
	public ArrayList getViewValues(String tabName,String cname,String scname,String assetType,String dcode,String divcode,String subcode,String mcode)
	{
	 ArrayList vlist=new ArrayList();
	 Connection conn=null;
	 Statement stmt=null;
	 ResultSet rs=null;
	 conn=RwsOffices.getConn();
	 ArrayList columns=null;
	 String qry="";
	 String atype=null;
	 if(assetType.equals("01")){  
	 	atype="PWS"; 
	 }else if(assetType.equals("02")){
	 	atype="MPWS"; 
	 }
	 else if(assetType.equals("03")){
	 	atype="CPWS"; 
	 }else if(assetType.equals("09")){
	 	atype="DIRECT PUMPING"; 
	 }else if(assetType.equals("04")){
	 	atype="HAND PUMPS"; 
	 }  
	 else if(assetType.equals("05")){
	 	atype="SHALLOW HAND PUMPS"; 
	 }
	 else if(assetType.equals("06")){
	 	atype="OPEN WELLS"; 
	 }else if(assetType.equals("07")){
	 	atype="PONDS"; 
	 }
	 if(assetType.equals("01")||assetType.equals("02")||assetType.equals("03")||assetType.equals("09")){
		if(cname.equals("01") && scname.equals("001"))
		{
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Panchayat");
			columns.add("Village");
			columns.add("Habitation");
			columns.add("Asset Name");
			columns.add("Asset Code");
			columns.add("Source Code");
			columns.add("Source Type");
			columns.add("Sub Source Type");
			columns.add("Location");
			columns.add("Source Condition");
			columns.add("Static Water Level From Ground(Avg)(in Mts)");
			columns.add("Yield");
			columns.add("Source Depth(mts)");
			columns.add("Alternative Water Source");
			columns.add("Water Quality");
			vlist.add(columns);
		 try{
		 int sno=0;
		 stmt=conn.createStatement();
		 qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_SOURCE_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE" +
		  "  and v.panch_code=substr(source_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  and  subCompTbl.SOURCE_TYPE_CODE='1'";
		  if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		 ArrayList cpwsOhsr=null; 
		 ArrayList datavalue=null;
		 Debug.println("qry1:"+qry);
		 rs=stmt.executeQuery(qry);
		 while(rs.next())
		 { 
		 	++sno;
		 	cpwsOhsr=new ArrayList();  
		 	datavalue=new ArrayList();
		 	datavalue.add(formatData(atype)+"-"+formatData("SOURCE-SUBSURFACE REPORT"));
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
		 	
		 	cpwsOhsr.add(formatData(sno));
		 	cpwsOhsr.add(rs.getString("pname"));
		 	cpwsOhsr.add(rs.getString("vname"));
		 	cpwsOhsr.add(rs.getString("panch_name"));
		 	cpwsOhsr.add(rs.getString("asset_name"));
		 	cpwsOhsr.add(rs.getString("asset_code"));
		 	cpwsOhsr.add(rs.getString("source_code"));
		 	if(rs.getString("SOURCE_TYPE_CODE")!=null && rs.getString("SOURCE_TYPE_CODE").equals("1"))
	          {
	          cpwsOhsr.add("Subsurface Source");	
	          }
	        if(rs.getString("SOURCE_TYPE_CODE").equals("1")&& rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("1"))
	          {
	           cpwsOhsr.add("BOREWELL");
	           }
	         else if(rs.getString("SOURCE_TYPE_CODE").equals("1") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("2"))
	          {
	          	cpwsOhsr.add("FILTER POINT");
	           }
	         else if(rs.getString("SOURCE_TYPE_CODE").equals("1") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("3"))
	           {
	            cpwsOhsr.add("INFILTARATION WELL");
	           }
	           else if(rs.getString("SOURCE_TYPE_CODE").equals("1") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("4"))
	           {
	            cpwsOhsr.add("OPEN WELL");
	           }
	           cpwsOhsr.add(formatData(rs.getString("LOCATION"))+"");
	           cpwsOhsr.add(formatData(rs.getString("SOURCE_CONDITION")));
	           cpwsOhsr.add(formatData(rs.getInt("STATIC_WATER_LEVEL")));
	           cpwsOhsr.add(formatData(rs.getString("YIELD")));
	           cpwsOhsr.add(formatData(rs.getFloat("DEPTH")));
	           cpwsOhsr.add(formatData(rs.getInt("DIST_NEAR_PRIVATE_SOURCE")));
	           if(rs.getString("WATER_QUALITY")!=null && rs.getString("WATER_QUALITY").equals("SS"))
	        	 {
	        	 cpwsOhsr.add(formatData("Safe Source"));
	        	 }
	         else{
	        	 	cpwsOhsr.add(formatData("Not Safe Source"));
	        	 }
	          
	           vlist.add(datavalue);
	           vlist.add(cpwsOhsr);	 
		 }
		 	
		 }catch(Exception e)
		 {
		 	Debug.println("Exception in subsurface source:"+e);
		 }
		 finally{
		 	closeAll();
		 } 
		}
		else if(cname.equals("01") && scname.equals("002"))
		{
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Panchayat");
			columns.add("Village");
			columns.add("Habitation");
			columns.add("Asset Name");
			columns.add("Asset Code");
			columns.add("Source Code");
			columns.add("Source Type");
			columns.add("Sub Source Type");
			columns.add("Source Name");
			columns.add("Tapping point Location");
			columns.add("Source Condition");
			columns.add("Static Water Level From Ground(Avg) (in Mts)");
			columns.add("Summer Water Level");
			columns.add("Yield");
			columns.add("Alternative Water Source");
			columns.add("Water Quality");
			vlist.add(columns);
			qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_SOURCE_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE" +
			" and v.panch_code=substr(source_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"' and  subCompTbl.SOURCE_TYPE_CODE='2'";
			if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			try{int sno=0;
		 	ArrayList cpwsOhsr=null; 
		 	ArrayList datavalue=null; 
		 	stmt=conn.createStatement();
		 	rs=stmt.executeQuery(qry);
		 	while(rs.next()) 
		 	{++sno;
		 		cpwsOhsr=new ArrayList();
		 		datavalue=new ArrayList();
		 		datavalue.add(formatData(atype)+"-"+formatData("SOURCE-SURFACE REPORT"));
			 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
		 		cpwsOhsr.add(formatData(sno));
			 	cpwsOhsr.add(rs.getString("pname"));
			 	cpwsOhsr.add(rs.getString("vname"));
			 	cpwsOhsr.add(rs.getString("panch_name"));
		 		cpwsOhsr.add(formatData(rs.getString("ASSET_NAME")));
		 		cpwsOhsr.add(rs.getString("asset_code"));
	            cpwsOhsr.add(formatData(rs.getString("SOURCE_CODE")));
	        	if(rs.getString("SOURCE_TYPE_CODE")!=null && rs.getString("SOURCE_TYPE_CODE").equals("2"))
	            {
	            	cpwsOhsr.add("Surface Source");
	            }
	            if(rs.getString("SOURCE_TYPE_CODE").equals("2")&& rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("1"))
	            {
	            	 cpwsOhsr.add("CANAL");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("2"))
	            {
	            	cpwsOhsr.add("RIVER");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("3"))
	            {
	            	cpwsOhsr.add("INTAKE WELL");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("4"))
	            {
	            	cpwsOhsr.add("SPRINGS");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("5"))
	            {
	            	cpwsOhsr.add("RESERVOIR");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null)
	            {
	            	cpwsOhsr.add("-");
	            }
	            cpwsOhsr.add(formatData(rs.getString("SOURCE_NAME")));
	            cpwsOhsr.add(formatData(rs.getString("LOCATION"))+"");
	            cpwsOhsr.add(formatData(rs.getString("SOURCE_CONDITION")));
	        	cpwsOhsr.add(formatData(rs.getInt("STATIC_WATER_LEVEL")));
	        	cpwsOhsr.add(formatData(rs.getInt("SUMMER_WATER_LEVEL")));
	        	cpwsOhsr.add(formatData(rs.getString("YIELD")));
	        	cpwsOhsr.add(formatData(rs.getInt("DIST_NEAR_PRIVATE_SOURCE")));
	        	if(rs.getString("WATER_QUALITY")!=null && rs.getString("WATER_QUALITY").equals("SS"))
	        	{
	        	cpwsOhsr.add(formatData("Safe Source"));
	        	}
	        	else{
	        		cpwsOhsr.add(formatData("Not Safe Source"));
	        	}
	        	vlist.add(datavalue);
	        	vlist.add(cpwsOhsr);
		 	}
		 	
		 	}catch(Exception e)
			{
		 	 Debug.println("Exception in Surface source:"+e);
			}finally{
			closeAll();	
			}
		 	
		 
		}
		else if(cname.equals("01") && scname.equals("003"))
		{

		 	ArrayList pwsCistern=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Pump Code");
		 	columns.add("Location");
		 	columns.add("Pump Make");
		 	columns.add("Pump Type");
		 	columns.add("Pump Capacity");
		 	columns.add("Year Of Commissioning");
		 	columns.add("Hours Running Per Day");
		 	columns.add("Usage");
		 	columns.add("Designed Head");
		 	columns.add("Designed LPM");
		 	columns.add("Hours Of Power Availability");
		 	columns.add("Low Voltage Problems");
		 	columns.add("Remarks");
		 	columns.add("Feeder");
		 	columns.add("Generator Existing");
		 	vlist.add(columns);
		 	qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and substr(pump_code,1,16)=v.panch_code and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	Debug.println("pumpsetqry:"+qry);
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		pwsCistern = new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PUMPING-PUMPSETS REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		pwsCistern.add(formatData(++sno));
			 		pwsCistern.add(rs.getString("PNAME"));
			 		pwsCistern.add(rs.getString("VNAME"));
			 		pwsCistern.add(rs.getString("PANCH_NAME"));
			 		pwsCistern.add(formatData(rs.getString("ASSET_NAME")));
			 		pwsCistern.add(formatData(rs.getString("ASSET_CODE")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_CODE")));
		        	pwsCistern.add(formatData(rs.getString("LOCATION")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_MAKE")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_TYPE"))); 
		         	pwsCistern.add(formatData(rs.getFloat("PUMP_CPTY")));
		        	pwsCistern.add(formatData(rs.getString("YEAR_COMM")));
		        	pwsCistern.add(formatData(rs.getInt("HR_RUN")));
		        	pwsCistern.add(formatData(rs.getString("USAGE")));
		        	pwsCistern.add(formatData(rs.getFloat("DESIGNED_HEAD")));
		        	pwsCistern.add(formatData(rs.getFloat("DESIGNED_LPM")));
		        	pwsCistern.add(formatData(rs.getFloat("POWER_AVAIL_PER_DAY"))); 
		        	pwsCistern.add(formatData(rs.getString("LOW_VOLT_PROB")));
		        	pwsCistern.add(formatData(rs.getString("SUGGESTIONS")));
		        	pwsCistern.add(formatData(rs.getString("FEEDER")));
		        	pwsCistern.add(formatData(rs.getString("GENERATOR_EXISTING")));	
		        	vlist.add(datavalue);
		        	vlist.add(pwsCistern);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Pump sets:"+e);
				}finally{
				closeAll();	
				}
		  
		}
		else if(cname.equals("02") && scname.equals("001"))
		{
			ArrayList cpwsRwcWell=null;
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Panchayat");
			columns.add("Village");
			columns.add("Habitation");
			columns.add("Asset Name");
			columns.add("Asset Code");
			columns.add("Raw Water Collection Well Code");
			columns.add("Location");
			columns.add("Capacity");
			vlist.add(columns);
			qry="select v.*,subCompTbl.RW_COLLWELL_CODE,subCompTbl.Location,subCompTbl.Capacity,subCompTbl.TYPE_OF_FLOORING,ASSET_NAME,subCompTbl.asset_code " +
		 	" FROM RWS_ASSET_MAST_TBL M, RWS_AST_RW_COLLWELL_PARAM_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  " +
		 	" and v.panch_code=substr(RW_COLLWELL_CODE ,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and " +
		 	" M.type_of_asset_code='"+assetType+"'  ";
			if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			try{int sno=0;
				ArrayList datavalue=null;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	while(rs.next())
			 	{++sno;
			 		cpwsRwcWell=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-RAW WATER COLLECTION WELL REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		cpwsRwcWell.add(formatData(sno));
			 		cpwsRwcWell.add(rs.getString("pname"));
			 		cpwsRwcWell.add(rs.getString("vname"));
			 		cpwsRwcWell.add(rs.getString("panch_name"));
			 		cpwsRwcWell.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsRwcWell.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsRwcWell.add(formatData(rs.getString("RW_COLLWELL_CODE")));
		        	cpwsRwcWell.add(formatData(rs.getString("LOCATION")));
		        	cpwsRwcWell.add(formatData(rs.getFloat("CAPACITY")));	
		        	vlist.add(datavalue);
		        	vlist.add(cpwsRwcWell);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in RWC:"+e);
				}finally{
				closeAll();	
				}
		 
		}
		else if(cname.equals("02") && scname.equals("002"))
		{
			ArrayList cpwsSsTank=null;
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Panchayat");
			columns.add("Village");
			columns.add("Habitation");
			columns.add("Asset Name");
			columns.add("Asset Code");
            columns.add("SS Tank Code");
            columns.add("SS Tank Size(LBD)");
            columns.add(" Depth(mts) ");
            columns.add("No Of Days Storage");
            columns.add(" No Of Mcum");
            columns.add("Fed By");
            columns.add("Location");
            vlist.add(columns);
            qry="select  subCompTbl.asset_code,subCompTbl.SSSC_CODE,subCompTbl.SS_SIZE,subCompTbl.CAPACITY_DAYS,subCompTbl.CAPACITY_MCUM,"+
			" subCompTbl.TANK_ADEQACY,subCompTbl.LOCATION,subCompTbl.POWER_CON,subCompTbl.POWER_HRS,"+
			" subCompTbl.DEPTH,subCompTbl.OTHERS,ASSET_NAME,subCompTbl.ASSET_CODE,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_SS_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(subCompTbl.SSSC_CODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"' ";	
            if(divcode!=null && !divcode.equals(""))
  		  {
  		  	qry+=" and m.division_office_code='"+divcode+"' ";
  		  }
  		  if(subcode!=null && !subcode.equals(""))
  		  {
  		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
  		  }
            try{ int sno=0;
		 	stmt=conn.createStatement();
		 	rs=stmt.executeQuery(qry);
		 	ArrayList datavalue=null;
		 	while(rs.next())
		 	{++sno;
		 		cpwsSsTank=new ArrayList();
		 		datavalue=new ArrayList();
		 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-SS TANK REPORT"));
			 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
		 		cpwsSsTank.add(formatData(sno));
		 		cpwsSsTank.add(rs.getString("pname"));
		 		cpwsSsTank.add(rs.getString("vname"));
		 		cpwsSsTank.add(rs.getString("panch_name"));
		 		cpwsSsTank.add(formatData(rs.getString("ASSET_NAME")));
		 		cpwsSsTank.add(formatData(rs.getString("ASSET_CODE")));
	        	cpwsSsTank.add(formatData(rs.getString("SSSC_CODE")));
	        	cpwsSsTank.add(formatData(rs.getString("SS_SIZE")));
	        	cpwsSsTank.add(formatData(rs.getFloat("DEPTH")));
	        	cpwsSsTank.add(formatData(rs.getString("CAPACITY_DAYS")));
	        	cpwsSsTank.add(formatData(rs.getString("CAPACITY_MCUM")));
	        	if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Urban"))
	        	{
	        		cpwsSsTank.add("Canal");
	        	}
	        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Rural"))
	        	{
	        		cpwsSsTank.add("River");
	        	}
	        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Dedicated"))
	        	{
	        		cpwsSsTank.add("Reserviors");
	        	}
	        	
	        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Others"))
	        	{
	        		if(rs.getString("OTHERS")!=null)
	        		cpwsSsTank.add(formatData(rs.getString("OTHERS")));
	        	}
	        	cpwsSsTank.add(formatData(rs.getString("LOCATION")));
	        	vlist.add(datavalue);
	        	vlist.add(cpwsSsTank);
		 	}
		 	
		 	}catch(Exception e)
			{
		 	 Debug.println("Exception in SS Tank:"+e);
			}finally{
			closeAll();	
			}
		}
		else if(cname.equals("02") && scname.equals("003"))
		{
			ArrayList cpwsSsFilter=null;
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Panchayat");
			columns.add("Village");
            columns.add("Habitation");
            columns.add("Asset Name");
            columns.add("Asset Code");
            columns.add("WTP Code ");
            columns.add("Location ");
            columns.add("Capacity In MLD ");
            columns.add("No of Units ");
            columns.add("No of Hours Usage");
            columns.add("Size of Units(LBH in M)");
            columns.add("No of Stand By Units ");
            columns.add("Frequency Of Sand Scrapping ");
            columns.add("General Performance");
            columns.add("Extension Scope");
            columns.add("Sedmentation Tank");
            columns.add("Horizontal Roughing Filter");
            columns.add("Vertical Roughing Filter");
            vlist.add(columns);
			qry="select subCompTbl.ASSET_CODE,subCompTbl.WTPSC_CODE ,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ,subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.RATE_OF_FILTRATION, subCompTbl.FREQ_SAND_SCRAP,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,subCompTbl.Location,subCompTbl.CHK_FILTER,ASSET_NAME,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_WTP_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(subCompTbl.WTPSC_CODE,1,16) AND SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='SS' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"' ";
			if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			try{
				int sno=0;
			 	stmt=conn.createStatement();
			 	ArrayList datavalue=null;
			 	rs=stmt.executeQuery(qry);
			 	while(rs.next())
			 	{++sno;
			 		cpwsSsFilter=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-SS FILTER REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		cpwsSsFilter.add(formatData(sno));
			 		cpwsSsFilter.add(rs.getString("PNAME"));
			 		cpwsSsFilter.add(rs.getString("VNAME"));
			 		cpwsSsFilter.add(rs.getString("PANCH_NAME"));
			 		cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsSsFilter.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
		        	cpwsSsFilter.add(formatData(rs.getString("LOCATION")));
		        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
		        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
		        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
		        	cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
		        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
		        	cpwsSsFilter.add(formatData(rs.getFloat("FREQ_SAND_SCRAP")));
		        	cpwsSsFilter.add(formatData(rs.getString("PERFORMANCE")));
		        	cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
		        	String chkfilter=rs.getString("CHK_FILTER");
		        	if( chkfilter!=null && chkfilter.substring(0,2).equals("01"))
					{
		        		cpwsSsFilter.add("YES");
					}
		        	else
		        	{
		        		cpwsSsFilter.add("NO");
		        	}
		        	if( chkfilter!=null && chkfilter.substring(2,4).equals("02"))
					{
		        		cpwsSsFilter.add("YES");
					}
		        	else
		        	{
		        		cpwsSsFilter.add("NO");
		        	}
		        	if( chkfilter!=null && chkfilter.substring(4,6).equals("03"))
					{
		        		cpwsSsFilter.add("YES");
					}
		        	else
		        	{
		        		cpwsSsFilter.add("NO");
		        	}
		        	vlist.add(datavalue);
		        	vlist.add(cpwsSsFilter);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in RS Filter:"+e);
				}finally{
				closeAll();	
				}
		}
		 else if(cname.equals("02") && scname.equals("004"))
		  {
		 	 ArrayList cpwsRsFilter=null;
		 	 columns=new ArrayList(); 
		 	 columns.add("Sl.No");
		 	 columns.add("Panchayat");
		 	 columns.add("Village");
             columns.add("Habitation");
             columns.add("Asset Name");
             columns.add("Asset Code");
             columns.add(" WTP Code ");
             columns.add("Location ");
             columns.add("Capacity In MLD ");
             columns.add(" No of Units ");
             columns.add(" No of Hours Usage ");
             columns.add("Size of Units(LBH in M)  ");
             columns.add("No of Stand By Units ");
             columns.add("Frequency Of Back Wash ");
             columns.add("Clarifloculator");
             vlist.add(columns);
		     qry="select subCompTbl.*,ASSET_NAME,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_WTP_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=SUBSTR(SUBCOMPTBL.WTPSC_CODE,1,16) AND SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='RS' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"' ";
		     if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		     try{int sno=0;
			 	stmt=conn.createStatement();
			 	ArrayList datavalue=null;
			 	rs=stmt.executeQuery(qry);
			    while(rs.next())  
			    {++sno;
			    	cpwsRsFilter=new ArrayList();
			    	datavalue=new ArrayList();
			    	datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-RS FILTER REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			    	cpwsRsFilter.add(formatData(sno));
			    	cpwsRsFilter.add(rs.getString("PNAME"));
			    	cpwsRsFilter.add(rs.getString("VNAME"));
			    	cpwsRsFilter.add(rs.getString("PANCH_NAME"));
			    	cpwsRsFilter.add(formatData(rs.getString("ASSET_NAME")));
			    	cpwsRsFilter.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsRsFilter.add(formatData(rs.getString("WTPSC_CODE")));
		        	cpwsRsFilter.add(formatData(rs.getString("Location")));
		        	cpwsRsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
		        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
		        	cpwsRsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
		        	cpwsRsFilter.add(formatData(rs.getString("WTP_SIZE")));
		        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
		         	cpwsRsFilter.add(formatData(rs.getFloat("FREQ_SAND_SCRAP")));
		        	if((rs.getString("CHK_FILTER")!=null) && (rs.getString("CHK_FILTER").substring(0,2)).equals("01"))
		        	{
		        		cpwsRsFilter.add("YES");
		        	}
		        	 else
		        	{
		        		cpwsRsFilter.add("NO");
		        	}	
		        	vlist.add(datavalue);
		        	vlist.add(cpwsRsFilter);
			    }
		     
		     }catch(Exception e)
				{
			 	 Debug.println("Exception in RS Filter:"+e);
				}finally{
				closeAll();	
				}	  
		  }
		 else if(cname.equals("02") && scname.equals("005"))
		  {
		 	ArrayList cpwsSump=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add(" Sump Code");
		 	columns.add(" Location");
		 	columns.add(" Diameter/Length ");
		 	columns.add(" Sump Depth");
		 	columns.add("Capacity of Sump(ltrs)");
		 	columns.add("Sump Condition");
		 	vlist.add(columns);
		 	qry="select subCompTbl.ASSET_CODE,subCompTbl.SUMPCODE,subCompTbl.Location ,subCompTbl.SUMP_CAPACITY,subCompTbl.SUMP_DEPTH,subCompTbl.SUMP_DIAMETER, DECODE(subCompTbl.SUMP_CONDITION,'G','GOOD','B','BAD')SUMP_CONDITION,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_SUMP_M_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(SUMPCODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{++sno;
			 		cpwsSump=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-SUMP REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		cpwsSump.add(formatData(sno));
			 		cpwsSump.add(rs.getString("PNAME"));
			 		cpwsSump.add(rs.getString("VNAME"));
			 		cpwsSump.add(rs.getString("PANCH_NAME"));
			 		cpwsSump.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsSump.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsSump.add(formatData(rs.getString("SUMPCODE")));
		        	cpwsSump.add(formatData(rs.getString("LOCATION")));
		        	cpwsSump.add(formatData(rs.getFloat("SUMP_DIAMETER")));
		        	cpwsSump.add(formatData(rs.getFloat("SUMP_DEPTH")));
		        	cpwsSump.add(formatData(rs.getInt("SUMP_CAPACITY"))+"");
		        	cpwsSump.add(formatData(rs.getString("SUMP_CONDITION")));
		        	vlist.add(datavalue);
		        	vlist.add(cpwsSump);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Surface source");
				}finally{
				closeAll();	
				}  
		  }
		 else if(cname.equals("02") && scname.equals("006"))
		  {
		 	ArrayList cpwsSump=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Bridge Code");
		 	columns.add("Location");
		 	vlist.add(columns);
		 	qry="select subCompTbl.ASSET_CODE,subCompTbl.BRIDGE_CODE,subCompTbl.BRIDGE_TYPE,subCompTbl.BRIDGE_LENGTH ,subCompTbl.BRIDGE_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH,subCompTbl.LENGTH_OF_THE_BRIDGE,subCompTbl.BRIDGE_SPAN_LENGTH,subCompTbl.Location,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_FP_BRIDGE_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(BRIDGE_CODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{++sno;
			 		cpwsSump=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-FOOT PATH BRIDGE REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		cpwsSump.add(formatData(sno));
			 		cpwsSump.add(rs.getString("PNAME"));
			 		cpwsSump.add(rs.getString("VNAME"));
			 		cpwsSump.add(rs.getString("PANCH_NAME"));
			 		cpwsSump.add(formatData(rs.getString("ASSET_NAME")+""));
			 		cpwsSump.add(formatData(rs.getString("ASSET_CODE")+""));
		        	cpwsSump.add(formatData(rs.getString("BRIDGE_CODE")+""));
		        	cpwsSump.add(formatData(rs.getString("LOCATION")));	
		        	vlist.add(datavalue);
		        	vlist.add(cpwsSump);	
			 	}
			 	
		 		}catch(Exception e)
				{
			 	 Debug.println("Exception in FPB "+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("02") && scname.equals("007"))
		  {
		 	ArrayList cpwspumpHouse=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Pump House Code");
		 	columns.add("Location");
		 	columns.add("Pump House Area(Sq.Mts)");
		 	vlist.add(columns);
		 	qry="select subCompTbl.ASSET_CODE,subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.HEIGHT ,subCompTbl.PUMPHOUSE_CODE,subCompTbl.Location,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_PUMPHOUSE_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(PUMPHOUSE_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{++sno;
			 	cpwspumpHouse=new ArrayList();
			 	datavalue=new ArrayList();
			 	datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-PUMP HOUSE REPORT"));
			 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 	cpwspumpHouse.add(formatData(sno));
			 	cpwspumpHouse.add(rs.getString("PNAME"));
			 	cpwspumpHouse.add(rs.getString("VNAME"));
			 	cpwspumpHouse.add(rs.getString("PANCH_NAME"));
			 	cpwspumpHouse.add(formatData(rs.getString("ASSET_NAME")));
			 	cpwspumpHouse.add(formatData(rs.getString("ASSET_CODE")));
			 	cpwspumpHouse.add(formatData(rs.getString("PUMPHOUSE_CODE")));
	        	cpwspumpHouse.add(formatData(rs.getString("Location")));
	        	cpwspumpHouse.add(formatData(rs.getString("AREA")));
	        	vlist.add(datavalue);
	        	vlist.add(cpwspumpHouse);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in PUMP HOUSE:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("02") && scname.equals("008"))
		  {
		 	ArrayList cpwswatch=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation"); 
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("WatchMan Quarter Code");
		 	columns.add(" Location");
		 	vlist.add(columns);
		    qry="select subCompTbl.ASSET_CODE,subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.NO_OF_QTRS ,subCompTbl.WATCHMAN_CODE,subCompTbl.Location,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_WATCHMAN_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(WATCHMAN_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"' ";
		    if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		    try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{++sno;
			 		cpwswatch=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-WATCHMAN QUATRER REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		cpwswatch.add(formatData(sno));
			 		cpwswatch.add(rs.getString("PNAME"));
			 		cpwswatch.add(rs.getString("VNAME"));
			 		cpwswatch.add(rs.getString("PANCH_NAME"));
			 		cpwswatch.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwswatch.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwswatch.add(formatData(rs.getString("WATCHMAN_CODE")));
		        	cpwswatch.add(formatData(rs.getString("Location")));
		        	vlist.add(datavalue);
		        	vlist.add(cpwswatch);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Watchman:"+e);
				}finally{
				closeAll();	
				} 
		  }
		 else if(cname.equals("02") && scname.equals("009"))
		  {
		 	ArrayList cpwsCwcWell=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Clear Water Collection Well Code");
		 	columns.add(" Location");
		 	columns.add(" Capacity");
		 	vlist.add(columns);
		    qry="select subCompTbl.ASSET_CODE,subCompTbl.CW_COLLWELL_CODE ,subCompTbl.DIAMETER,subCompTbl.DEPTH , subCompTbl.LOCATION,subCompTbl.CAPACITY,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_CW_COLLWELL_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(CW_COLLWELL_CODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"' ";
		    if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		    try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{++sno;
			 		cpwsCwcWell=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-CLEAR WATER COLLECTION WELL REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		cpwsCwcWell.add(formatData(sno));
			 		cpwsCwcWell.add(rs.getString("PNAME"));
			 		cpwsCwcWell.add(rs.getString("VNAME"));
			 		cpwsCwcWell.add(rs.getString("PANCH_NAME"));
			 		cpwsCwcWell.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsCwcWell.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsCwcWell.add(formatData(rs.getString("CW_COLLWELL_CODE")));
		        	cpwsCwcWell.add(formatData(rs.getString("LOCATION")));
		        	cpwsCwcWell.add(formatData(rs.getFloat("CAPACITY")));
		        	vlist.add(datavalue);
		        	vlist.add(cpwsCwcWell);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in CWC:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("02") && scname.equals("010"))
		  {
		 	ArrayList cpwsSsFilter=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		    columns.add("Habitation");
		    columns.add("Asset Name");
		    columns.add("Asset Code");
		    columns.add("WTP Code ");
            columns.add("Location");
            columns.add("Capacity In MLD ");
            columns.add("No of Units");
            columns.add("No Of Hours Usage");
            columns.add("Size of Units(LBH in M)");
            columns.add("No of Stand By Units");                 
            columns.add("Shelter Existance");
            columns.add("General Performance ");
            columns.add("Extension Scope");
            columns.add("Sedimentation Tank ");
            columns.add("Horizontal Roughing Filter");
            columns.add("Vertical Roughing Filter ");                   
            vlist.add(columns);               
            qry="select subCompTbl.ASSET_CODE,subCompTbl.WTPSC_CODE,subCompTbl.Location,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ,subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.RATE_OF_FILTRATION, subCompTbl.SHELTER_EXISTING,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,subCompTbl.CHK_FILTER,ASSET_NAME,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_WTP_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND substr(WTPSC_CODE,1,16)=v.panch_code and SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='MS' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"' ";
            if(divcode!=null && !divcode.equals(""))
  		  	{
  		  		qry+=" and m.division_office_code='"+divcode+"' ";
  		  	}
  		  	if(subcode!=null && !subcode.equals(""))
  		  	{
  		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
  		  	}
            try{int sno=0;
    		 	stmt=conn.createStatement();
    		 	rs=stmt.executeQuery(qry);
    		 	ArrayList datavalue=null;
    		 	while(rs.next())
    		 	{++sno;
    		 		cpwsSsFilter=new ArrayList();
    		 		datavalue=new ArrayList();
    		 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-MICRO FILTER REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
    		 		cpwsSsFilter.add(formatData(sno));
    		 		cpwsSsFilter.add(rs.getString("PNAME"));
    		 		cpwsSsFilter.add(rs.getString("VNAME"));
    		 		cpwsSsFilter.add(rs.getString("PANCH_NAME"));
    		 		cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
    		 		cpwsSsFilter.add(formatData(rs.getString("ASSET_CODE")));
    	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
    	        	cpwsSsFilter.add(formatData(rs.getString("Location")));
    	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
    	        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
    	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
    	        	cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
    	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
    	        	 if(rs.getString("SHELTER_EXISTING")!=null && rs.getInt("SHELTER_EXISTING")==1)
    	         	 {
    	         	 	cpwsSsFilter.add("YES");
    	         	 } 
    	         	 else
    	         	 {
    	         	 	cpwsSsFilter.add("NO");
    	         	 }
    	        	
    	        	cpwsSsFilter.add(formatData(rs.getString("PERFORMANCE")));
    	        	cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
    	        	String chkfilter=rs.getString("CHK_FILTER");
    	        	
    	        	if( chkfilter!=null && chkfilter.substring(0,2).equals("01"))
    				{
    	        		//Debug.println("22222222"+rs.getString("CHK_FILTER"));
    	        		cpwsSsFilter.add("YES");
    				}
    	        	else
    	        	{
    	        		cpwsSsFilter.add("NO");
    	        	}
    	        	if( chkfilter!=null && chkfilter.substring(2,4).equals("02"))
    				{
    	        		//Debug.println("3333"+rs.getString("CHK_FILTER"));
    	        		cpwsSsFilter.add("YES");
    				}
    	        	else
    	        	{
    	        		cpwsSsFilter.add("NO");
    	        	}
    	        	if( chkfilter!=null && chkfilter.substring(4,6).equals("03"))
    				{
    	        		//Debug.println("4444"+ rs.getString("CHK_FILTER"));
    	        		cpwsSsFilter.add("YES");
    				}
    	        	else
    	        	{
    	        		cpwsSsFilter.add("NO");
    	        	} 
    	        	vlist.add(datavalue);
    	        	vlist.add(cpwsSsFilter);
    		 	}
    		 	
    		 	}catch(Exception e)
    			{
    		 	 Debug.println("Exception in MF:"+e);
    			}finally{
    			closeAll();	
    			} 	  
		  }
		 else if(cname.equals("02") && scname.equals("011"))
		  {
		 	ArrayList cpwsSsFilter=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
            columns.add("Habitation");
            columns.add("Asset Name");
            columns.add("Asset Code");
            columns.add(" WTP Code ");
            columns.add("Location ");
            columns.add("Capacity  ");
            columns.add("No of Units ");
            columns.add("No of Hours of Usage ");
            columns.add("No of Stand By Units ");
            columns.add("Raw Water Storage Tank Existing  ");
            columns.add(" Product Water Storage Tank Existing  ");
            columns.add("Shelter Existing ");
            vlist.add(columns);
		    qry="select subCompTbl.*,ASSET_NAME,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_WTP_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=SUBSTR(SUBCOMPTBL.WTPSC_CODE,1,16) AND SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='RP' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"' ";
		    if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		    Debug.println(qry);
		    try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next()) 
			 	{++sno;
			 		cpwsSsFilter=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-RO PLANTS REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
    		 		cpwsSsFilter.add(formatData(sno));
    		 		cpwsSsFilter.add(rs.getString("PNAME"));
    		 		cpwsSsFilter.add(rs.getString("VNAME"));
    		 		cpwsSsFilter.add(rs.getString("PANCH_NAME"));
    		 		cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
    		 		cpwsSsFilter.add(formatData(rs.getString("ASSET_CODE")));
    	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
    	        	cpwsSsFilter.add(formatData(rs.getString("Location")));
    	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
    	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
    	        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
    	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
    	        	if(rs.getString("RWS_TANK_EXISTING")!=null && rs.getInt("RWS_TANK_EXISTING")==1)
    	        	{
    	        		cpwsSsFilter.add("YES");	
    	        	}else
    	        	{
    	        		cpwsSsFilter.add("NO");	
    	        	}
    	        	if(rs.getString("PWS_TANK_EXISTING")!=null && rs.getInt("PWS_TANK_EXISTING")==1)
    	        	{
    	        		cpwsSsFilter.add("YES");	
    	        	}else
    	        	{
    	        		cpwsSsFilter.add("NO");	
    	        	}
    	        	if(rs.getString("SHELTER_EXISTING")!=null && rs.getInt("SHELTER_EXISTING")==1)
    	        	{
    	        		cpwsSsFilter.add("YES");	
    	        	}else
    	        	{
    	        		cpwsSsFilter.add("NO");	
    	        	}
    	        	vlist.add(datavalue);
		        	vlist.add(cpwsSsFilter);	
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in RP:"+e);
				}finally{
				closeAll();	
				} 
		  }
		 else if(cname.equals("03") && scname.equals("001"))
		  {
		 	ArrayList cpwsPm=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Pumping Main Code");
		 	columns.add("No Of Air Valves");
		 	columns.add("No Of Scour Valves");
		 	columns.add("No Of Reflux Valves");
		 	columns.add("No Of Sluice Valves");
		 	columns.add("Number of Pipes");
		 	columns.add("Zero Velocity Valve");
		 	columns.add("Air Cushion Valve");
		 	columns.add("Non Return Valve");
		 	vlist.add(columns);
		 	qry="select subCompTbl.ASSET_CODE,subCompTbl.PUMPINGMAIN_CODE ,subCompTbl.AIRVALVE_NO, subCompTbl.SCOUREVALVE ,subCompTbl.REFLEXVALVE,subCompTbl.SLUICEVALVE ,subCompTbl.NO_OF_PIPES, subCompTbl.ZERO_VELOCITY_VALVE ,subCompTbl.AIR_CUSHION_VALVE ,subCompTbl.LOCATION,subCompTbl.NON_RETURN_VALVE,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_PUMPINGMAIN_TBL  subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(PUMPINGMAIN_CODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		 cpwsPm=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PIPELINE-PUMPING MAIN REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		 cpwsPm.add(formatData(++sno));
			 		 cpwsPm.add(rs.getString("PNAME"));
			 		 cpwsPm.add(rs.getString("VNAME"));
			 		 cpwsPm.add(rs.getString("PANCH_NAME"));
			 		 cpwsPm.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsPm.add(formatData(rs.getString("ASSET_CODE")));
			         cpwsPm.add(formatData(rs.getString("PUMPINGMAIN_CODE")));
			         cpwsPm.add(formatData(rs.getInt("AIRVALVE_NO")));
			         cpwsPm.add(formatData(rs.getInt("SCOUREVALVE")));
			         cpwsPm.add(formatData(rs.getInt("REFLEXVALVE")));
			         cpwsPm.add(formatData(rs.getInt("SLUICEVALVE")));
			         cpwsPm.add(formatData(rs.getInt("NO_OF_PIPES")));
			         cpwsPm.add(formatData(rs.getInt("ZERO_VELOCITY_VALVE")));
			         cpwsPm.add(formatData(rs.getInt("AIR_CUSHION_VALVE")));
			         cpwsPm.add(formatData(rs.getInt("NON_RETURN_VALVE")));	
			         vlist.add(datavalue);
			         vlist.add(cpwsPm);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in PM:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("03") && scname.equals("002"))
		  {
		 	ArrayList cpwsGm=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Gravity Main Code");
		 	columns.add("Length(mts)");
		 	columns.add("No Of Air Valves");
		 	columns.add("No Of Scour Valves");
		 	columns.add("No Of Reflux Valves");
		 	columns.add("No Of Sluice Valves");
		 	columns.add(" No of Pipes ");
		 	columns.add("No of Zero Velocity Valves ");
		 	columns.add("No of Air Cushion Valves ");
		 	columns.add("Non Return Valve");
		 	vlist.add(columns);
		 	qry="select  subCompTbl.*,M.ASSET_NAME ,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_GRAVITYMAIN_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(GRAVITYMAIN_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"'  ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		cpwsGm=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PIPELINE-GRAVITY MAIN REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		cpwsGm.add(formatData(++sno));
			 		cpwsGm.add(rs.getString("PNAME"));
			 		cpwsGm.add(rs.getString("VNAME"));
			 		cpwsGm.add(rs.getString("PANCH_NAME"));
			 		cpwsGm.add(formatData(rs.getString("ASSET_Name")));
			 		cpwsGm.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsGm.add(formatData(rs.getString("GRAVITYMAIN_CODE")));
		        	cpwsGm.add(formatData(rs.getString("LENGTH")));
		        	cpwsGm.add(formatData(rs.getString("AIRVALVE_NO")));
		        	cpwsGm.add(formatData(rs.getString("SCOUREVALVE")));
		            cpwsGm.add(formatData(rs.getString("REFLEXVALVE")));
		        	cpwsGm.add(formatData(rs.getString("SLUICEVALVE")));
		        	cpwsGm.add(formatData(rs.getString("NO_OF_PIPES")));
		        	cpwsGm.add(formatData(rs.getString("ZERO_VELOCITY_VALVE")));
		        	cpwsGm.add(formatData(rs.getString("NON_RETURN_VALVE")));
		        	cpwsGm.add(formatData(rs.getString("AIR_CUSHION_VALVE")));
		        	vlist.add(datavalue);
		        	vlist.add(cpwsGm);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in GM:"+e);
				}finally{
				closeAll();	
				} 
		  }
		 else if(cname.equals("03") && scname.equals("003"))
		  {
		 	ArrayList cpwsGm=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Distribution Code ");  
		 	columns.add("No of Pipes Required");
		 	columns.add("No. Of Air Valves");
		 	columns.add("Total Length Needed");
		 	columns.add("No. Of Sluice Valves");
		 	columns.add("Total Length Provided");
		 	columns.add("No. Of Scour Valves");
		 	columns.add("Full Villages Covered ");
		 	columns.add("No. Of Private House Connections");
		 	columns.add("Balance Needed in Mts");
		 	columns.add("No.Of Stand Posts");
		 	vlist.add(columns);
		 	qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_DISTRI_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(DISTRISC_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'   ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		cpwsGm=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PIPELINE-DISTRIBUTION REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		cpwsGm.add(formatData(++sno));
			 		cpwsGm.add(rs.getString("PNAME"));
			 		cpwsGm.add(rs.getString("VNAME"));
			 		cpwsGm.add(rs.getString("PANCH_NAME"));
			 		cpwsGm.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsGm.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsGm.add(formatData(rs.getString("DISTRISC_CODE")));
		        	cpwsGm.add(formatData(rs.getInt("NO_OF_PIPES")));
		        	cpwsGm.add(formatData(rs.getInt("NO_AIRVALVES"))+"");
		        	cpwsGm.add(formatData(rs.getInt("DIS_LN"))+"");
		        	cpwsGm.add(formatData(rs.getInt("NO_SLUICEVALVES"))+"");
		        	cpwsGm.add(formatData(rs.getFloat("DIS_TLC"))+"");
		        	cpwsGm.add(formatData(rs.getInt("NO_SCOURVALVES"))+"");
		        	cpwsGm.add(formatData(rs.getString("DIS_COVE"))+"");
		        	cpwsGm.add(formatData(rs.getInt("NO_PR_HC"))+"");
		        	cpwsGm.add(formatData(rs.getFloat("DIS_BN"))+"");
		        	cpwsGm.add(formatData(rs.getInt("NO_STANDPOSTS"))+"");
		        	vlist.add(datavalue);
		        	vlist.add(cpwsGm);
			 	}
		 	
		 		}catch(Exception e)
				{
			 	 Debug.println("Exception in Dist:"+e);
				}finally{
				closeAll();	
				}
		  }
		 	else if(cname.equals("04") && scname.equals("001"))
			{
		 		Statement stmt1=null;
		 		ResultSet rs1=null;
		 		ArrayList cpwsOhsr=null;
		 		columns=new ArrayList();
		 		columns.add("S.No");
		 		columns.add("Panchayat");
		 		columns.add("Village");
		 		columns.add("Habitation");
		 		columns.add("Asset Name");
		 		columns.add("Asset Code");
		 		columns.add("OHSR Code");
		 		columns.add(" Habitation Linkage");
		 		columns.add("OHSR Location");
		 		columns.add("OHSR Capacity In Lts");
		 		columns.add("No.Of Fillings");
		 		columns.add("OHSR Staging(Mts)");
		 		columns.add(" Water Quality ");
		 		vlist.add(columns);
		 		qry="select subCompTbl.ASSET_CODE,subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC,subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES,subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(ohsr_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.type_of_asset_code='"+assetType+"' ";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
		 		Debug.println("qry:"+qry);
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	stmt1=conn.createStatement();
			 	
			 	ArrayList datavalue=null;
			 	String qry1=null;
			 	while(rs.next())
			 	{
			 		cpwsOhsr=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-OHSR REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
				 	cpwsOhsr.add(formatData(++sno));
				 	cpwsOhsr.add(rs.getString("PNAME"));
				 	cpwsOhsr.add(rs.getString("VNAME"));
				 	cpwsOhsr.add(rs.getString("PANCH_NAME"));
			 		cpwsOhsr.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsOhsr.add(formatData(rs.getString("ASSET_CODE")));
		            cpwsOhsr.add(formatData(rs.getString("OHSR_CODE")));
		            qry1="select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+rs.getString("OHSR_CODE")+"'";
		            rs1=stmt1.executeQuery(qry1);
		            if(rs1.next())
		            {
		            	cpwsOhsr.add(formatData(rs1.getString("NO_OF_HABS")));	
		            }
		            cpwsOhsr.add(formatData(rs.getString("OHSR_LOC")));
		        	cpwsOhsr.add(formatData(rs.getInt("OHSR_CAP_LTS"))+"");
		            cpwsOhsr.add(formatData(rs.getInt("OHSR_NO_OF_FILLING"))+"");
		            cpwsOhsr.add(formatData(rs.getFloat("OHSR_SATGES")));
		            if(rs.getString("WATER_QTY")!=null && rs.getString("WATER_QTY").equals("N"))
		            {
		            	 cpwsOhsr.add("Safe Source");
		            }
		            else if(rs.getString("WATER_QTY")!=null && rs.getString("WATER_QTY").equals("Y"))
		            {
		            	 cpwsOhsr.add("Not Safe Source");
		            }
		            else
		            {
		            	 cpwsOhsr.add("Safe Source");	
		            }
		            vlist.add(datavalue);
		        	vlist.add(cpwsOhsr);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in OHSR:"+e);	
				}
		 		finally{
					closeAll();	
					}
			}
			else if(cname.equals("04") && scname.equals("002"))
			{   ArrayList cpwsOhbr=null;
				columns=new ArrayList();
				columns.add("S.No");
				columns.add("Panchayat");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add("OHBR Code ");
				columns.add("OHBR Location ");
				columns.add("OHBR Capacity In Lts  ");
				columns.add("OHBR Staging(Mts)");
				vlist.add(columns);
		 		qry=" select subCompTbl.asset_code,subCompTbl.OHBR_CODE,subCompTbl.OHBR_LOC,subCompTbl.OHBR_CAP_LTS,subCompTbl.OHBR_SATGES,subCompTbl.OHBR_LWL,subCompTbl.OHBR_MWL,subCompTbl.OHBR_FILL_HR,subCompTbl.OHBR_EMPTY_HR,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_OHBR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(ohbr_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.type_of_asset_code='"+assetType+"'";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{ 
			 		cpwsOhbr=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-OHBR REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
				 	cpwsOhbr.add(formatData(++sno));
				 	cpwsOhbr.add(rs.getString("PNAME"));
				 	cpwsOhbr.add(rs.getString("VNAME"));
				 	cpwsOhbr.add(rs.getString("PANCH_NAME"));
				 	cpwsOhbr.add(formatData(rs.getString("ASSET_NAME")));
				 	cpwsOhbr.add(formatData(rs.getString("ASSET_CODE")));
				 	cpwsOhbr.add(formatData(rs.getString("OHBR_CODE")));
		            cpwsOhbr.add(formatData(rs.getString("OHBR_LOC")));
		        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_CAP_LTS")));
		        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_SATGES")));
		        	vlist.add(datavalue);
			        vlist.add(cpwsOhbr);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in OHBR1:"+e);	
				}finally{
					closeAll();	
				}
			}
			else if(cname.equals("04") && scname.equals("003"))
			{   
				ArrayList cpwsGlsr=null;
				Statement stmt1=null;
				ResultSet rs1=null;
				columns=new ArrayList();
				columns.add("S.No");
				columns.add("Panchayat");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add("GLSR Code ");
				columns.add("Habitation Linkage"); 
				columns.add("GLSR Location"); 
				columns.add("GLSR Capacity In Lts  ");
				columns.add("No.Of Fillings");
				columns.add("Glsr Staging(Mts)");
				columns.add("Water Quality ");
				vlist.add(columns);
		 		qry=" select subCompTbl.asset_code,subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR,subCompTbl.GLSR_EMPTY_HR,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.water_qty,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and substr(glsr_code,1,16)=v.panch_code  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  m.type_of_asset_code='"+assetType+"'";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	stmt1=conn.createStatement();
			 	Debug.println("qry:"+qry);
			 	rs=stmt.executeQuery(qry); 
			 	ArrayList datavalue=null;
			 	String qry1=null;
			 	while(rs.next())
			 	{
			 	cpwsGlsr=new ArrayList();
		 		datavalue=new ArrayList();
		 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-GLSR REPORT"));
			 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 	cpwsGlsr.add(formatData(++sno));
			 	cpwsGlsr.add(rs.getString("PNAME"));
			 	cpwsGlsr.add(rs.getString("VNAME"));
			 	cpwsGlsr.add(rs.getString("PANCH_NAME"));
			 	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
			 	cpwsGlsr.add(formatData(rs.getString("ASSET_CODE")));
		        cpwsGlsr.add(formatData(rs.getString("GLSR_CODE")));
		        qry1="select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+rs.getString("GLSR_CODE")+"'";
	            Debug.println("qry1:"+qry1);
		        rs1=stmt1.executeQuery(qry1);
		        Debug.println("after qry execution:"+qry1);
		        if(rs1.next())
	            {
	            	//Debug.println("sss:"+rs1.getString("NO_OF_HABS"));
	            	cpwsGlsr.add(formatData(rs1.getString("NO_OF_HABS")));	
	            }else{
	            	//Debug.println("3433333333333");
	            	cpwsGlsr.add("--");
	            }
	            
	           // Debug.println("after counting no of habs");
	            cpwsGlsr.add(formatData(rs.getString("GLSR_LOC")));                                                                                                        
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_CAP_LTS")));
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_NO_OF_FILLING")));
	            cpwsGlsr.add(formatData(rs.getFloat("GLSR_SATGES")));
	            if(rs.getString("water_qty")!=null && !rs.getString("water_qty").equals("") && rs.getString("water_qty").equals("N"))
        		{
        		cpwsGlsr.add("Safe Source");
        	    }else{
        		cpwsGlsr.add("Not Safe Source");
        		}
	            vlist.add(datavalue);
		        vlist.add(cpwsGlsr);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in GLSR:"+e);	
				}finally{
					closeAll();	
				}
			}
			else if(cname.equals("04") && scname.equals("004"))
			  {
				ArrayList cpwsGlbr=null;
				columns=new ArrayList();
				columns.add("S.No");
				columns.add("Panchayat");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add("GLBR Code ");
				columns.add("GLBR Location");
				columns.add("GLBR Capacity In Lts  ");
				columns.add("Lowest Water Level(LWL)  ");
				columns.add("Maximum Water Level(MWL) "); 
				columns.add("GLBR Fill In Hrs");
				columns.add("GLBR Empty In Hrs");
				vlist.add(columns);
		 		try{int sno=0;
		 		qry="select subCompTbl.asset_code,subCompTbl.GLBR_CODE,subCompTbl.GLBR_LOC,subCompTbl.GLBR_CAP_LTS,subCompTbl.GLBR_LWL,subCompTbl.GLBR_MWL,subCompTbl.GLBR_FILL_HR,subCompTbl.GLBR_EMPTY_HR,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_GLBR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(glbr_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
		 		stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{ 
			 		cpwsGlbr=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-GLBR REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
				 	cpwsGlbr.add(formatData(++sno));
				 	cpwsGlbr.add(rs.getString("PNAME"));
				 	cpwsGlbr.add(rs.getString("VNAME"));
				 	cpwsGlbr.add(rs.getString("PANCH_NAME"));
				 	cpwsGlbr.add(formatData(rs.getString("ASSET_NAME")));
				 	cpwsGlbr.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsGlbr.add(formatData(rs.getString("GLBR_CODE")));
		        	cpwsGlbr.add(formatData(rs.getString("GLBR_LOC")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_CAP_LTS")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_LWL")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_MWL")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_FILL_HR")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_EMPTY_HR")));
		        	vlist.add(datavalue);
			        vlist.add(cpwsGlbr);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in GLBR:"+e);	
				}finally{
					closeAll();	
				}
			  }
			else if(cname.equals("04") && scname.equals("005"))
			 {  
				ArrayList cpwsBpt=null;
				columns=new ArrayList(); 
				columns.add("S.No");
				columns.add("Panchayat");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add("BPT Code");
				columns.add(" Location ");
				columns.add("BPT Capacity in Lts");
				columns.add("BPT Staging(Mts)");
				vlist.add(columns);
		 		qry="select subCompTbl.asset_code,subCompTbl.BPT_CODE,subCompTbl.Location,subCompTbl.CAPACITY,subCompTbl.STAGING,subCompTbl.BPT_MWL,subCompTbl.BPT_LWL,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_BPT_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and substr(bpt_code,1,16)=v.panch_code and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"'";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next()) 
			 	{
			 	 cpwsBpt=new ArrayList();
		 		 datavalue=new ArrayList();
		 		 datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-BPT REPORT"));
			 	 datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 	 cpwsBpt.add(formatData(++sno));
			 	 cpwsBpt.add(rs.getString("PNAME"));
			 	 cpwsBpt.add(rs.getString("VNAME"));
			 	 cpwsBpt.add(rs.getString("PANCH_NAME"));
		 		 cpwsBpt.add(formatData(rs.getString("ASSET_NAME")));
		 		cpwsBpt.add(formatData(rs.getString("ASSET_CODE")));
	        	 cpwsBpt.add(formatData(rs.getString("BPT_CODE")));
	        	 cpwsBpt.add(formatData(rs.getString("Location")));
	        	 cpwsBpt.add(formatData(rs.getFloat("CAPACITY")));
	        	 cpwsBpt.add(formatData(rs.getFloat("STAGING")));
	        	 vlist.add(datavalue);
			     vlist.add(cpwsBpt);
	        	 
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in BPT:"+e);	
				}finally{
					closeAll();	
				}
			 }
			else if(cname.equals("04") && scname.equals("006"))
			 {
				ArrayList pwsCistern=null;
				columns=new ArrayList();
				columns.add("S.No");
				columns.add("Panchayat");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add(" Cistern Code ");
				columns.add("Location ");
				columns.add("Capacity in Lts");
				columns.add("No Of Fillings/Day");
				columns.add(" PlatForm Existing");
				columns.add(" Platform Condition");
				columns.add("Drain Provided  ");
				columns.add(" Water Quality ");
				vlist.add(columns);
		 		qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_CIS_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE   and substr(CISSC_CODE,1,16)=v.panch_code and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"'";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
		 		Debug.println("qry:"+qry);
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		pwsCistern=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-CISTERNS REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
				 	pwsCistern.add(formatData(++sno));
				 	pwsCistern.add(rs.getString("PNAME"));
				 	pwsCistern.add(rs.getString("VNAME"));
				 	pwsCistern.add(rs.getString("PANCH_NAME"));
			 		pwsCistern.add(formatData(rs.getString("ASSET_NAME")));
			 		pwsCistern.add(formatData(rs.getString("ASSET_CODE")));
	        		pwsCistern.add(formatData(rs.getString("CISSC_CODE"))); 
		        	pwsCistern.add(formatData(rs.getString("CIS_LOC")));
		        	pwsCistern.add(formatData(rs.getFloat("CIS_CAP_LTS"))+"");
		        	pwsCistern.add(formatData(rs.getString("CIS_HR"))+"");
		        	pwsCistern.add(formatData(rs.getString("CIS_PF")));
		        	pwsCistern.add(formatData(rs.getString("CIS_PF_CON")));
		        	pwsCistern.add(formatData(rs.getString("CIS_DRAIN")));
		        	if(rs.getString("Water_qty")!=null && rs.getString("Water_qty").equals("Y"))
		        	{
		        		pwsCistern.add("Safe Source");
		        	} 
		        	else
		        	{
		        		pwsCistern.add("Not Safe Source");
		        	}
		        	vlist.add(datavalue);
				    vlist.add(pwsCistern);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in Cisterns:"+e);	
				}finally{
					closeAll();	
				}
			 }
		 else if(cname.equals("05") && scname.equals("001"))
		  {
		 	ArrayList CpwsMisLan=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Component Name");
		 	columns.add("Component Code");
		 	columns.add("Component Location");
		 	columns.add("Remarks");
		 	vlist.add(columns);
		 	qry="select subCompTbl.* ,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_OTHERS_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE substr(OTHER_COMP_CODE,1,16)=v.panch_code and  M.ASSET_CODE=subCompTbl.ASSET_CODE  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"'  ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		CpwsMisLan=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("OTHERS-MISSCELLANEOUS REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		CpwsMisLan.add(formatData(++sno));
			 		CpwsMisLan.add(rs.getString("PNAME"));
			 		CpwsMisLan.add(rs.getString("PANCH_NAME"));
			 		CpwsMisLan.add(formatData(rs.getString("ASSET_NAME"))+"");
			 		CpwsMisLan.add(formatData(rs.getString("ASSET_CODE"))+""); 
		        	CpwsMisLan.add(formatData(rs.getString("COMP_NAME"))+""); 
		        	CpwsMisLan.add(formatData(rs.getString("OTHER_COMP_CODE"))+""); 
		        	CpwsMisLan.add(formatData(rs.getString("COMP_LOCATION"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("REMARKS"))+"");	
		        	vlist.add(datavalue);
		        	vlist.add(CpwsMisLan);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Missl:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("05") && scname.equals("002"))
		  {
		 	ArrayList CpwsMisLan=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Chlorination Code");
		 	columns.add("Chlorination Location");
		 	columns.add("Working Or Not");
		 	columns.add("Bleaching Powder");
		 	columns.add("Liquid Chlorine");
		 	columns.add("Gas Chlorine");
		 	columns.add("Online Dosage");
		 	columns.add("Remarks");
		 	vlist.add(columns);
		 	qry="select subCompTbl.* ,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_CHLORINATION_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(CL_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		CpwsMisLan=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("OTHERS-CHLORINATION REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		CpwsMisLan.add(formatData(++sno));
			 		CpwsMisLan.add(rs.getString("PNAME"));
			 		CpwsMisLan.add(rs.getString("VNAME"));
			 		CpwsMisLan.add(rs.getString("PANCH_NAME"));
			 		CpwsMisLan.add(formatData(rs.getString("ASSET_NAME"))+"");
			 		CpwsMisLan.add(formatData(rs.getString("ASSET_CODE"))+""); 
		        	CpwsMisLan.add(formatData(rs.getString("CL_CODE"))+""); 
		        	CpwsMisLan.add(formatData(rs.getString("LOCATION"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("BLEACHING_WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("LIQUID_CHILORINE_WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("GAS_CHILORINE_WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("ONLINE_DOSE_WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("REMARKS"))+"");	
		        	vlist.add(datavalue);
		        	vlist.add(CpwsMisLan);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Chlorination:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("05") && scname.equals("003"))
		  {
		 	ArrayList CpwsMisLan=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Agency ");
		 	columns.add("Power Cost");
		 	columns.add("Consumables");
		 	columns.add("Wages & Others");
		 	columns.add(" Total Cost of MTC");
		 	columns.add(" Source of Finding ");
		 	columns.add(" No of House Connections ");
		 	columns.add("Traiff/Month");
		 	columns.add("Total Collection/Anum ");
		 	vlist.add(columns);
		 	qry="select subCompTbl.* ,ASSET_NAME,M.HAB_CODE,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_OANDM_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	Debug.println("qry OANDM:"+qry);
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		CpwsMisLan=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("OTHERS-O AND M REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		CpwsMisLan.add(formatData(++sno));
			 		CpwsMisLan.add(rs.getString("PNAME"));
			 		CpwsMisLan.add(rs.getString("VNAME"));
			 		CpwsMisLan.add(rs.getString("PANCH_NAME"));
			       	CpwsMisLan.add(formatData(rs.getString("ASSET_NAME"))+"");
			       	CpwsMisLan.add(formatData(rs.getString("ASSET_CODE"))+""); 
		        	if(rs.getString("AGENCY_CODE")!=null && rs.getString("AGENCY_CODE").equals("1"))
		        	{
		        		CpwsMisLan.add("ZP");	
		        	}
		        	 else if(rs.getString("AGENCY_CODE")!=null && rs.getString("AGENCY_CODE").equals("2"))
		        	{
		        		CpwsMisLan.add("MANDAL");	
		        	}
		        	else if(rs.getString("AGENCY_CODE")!=null && rs.getString("AGENCY_CODE").equals("3"))
		        	{
		        		CpwsMisLan.add("GP");	
		        	}
		        	CpwsMisLan.add(formatData(rs.getInt("POWER_COST")));
		        	CpwsMisLan.add(formatData(rs.getInt("CONSUM_ANNUM")));
		        	CpwsMisLan.add(formatData(rs.getInt("WAGES_ANNUM")));
		        	CpwsMisLan.add(formatData(rs.getInt("POWER_COST")+rs.getInt("CONSUM_ANNUM")+rs.getInt("WAGES_ANNUM")));
		        	if(rs.getString("SOURCES_FUND")!=null && rs.getString("SOURCES_FUND").equals("1"))
		        	{
		        		CpwsMisLan.add("RWS");	
		        	}
		        	CpwsMisLan.add(formatData(rs.getInt("HOUSE_CONN")));
		        	CpwsMisLan.add(formatData(rs.getInt("TARIFF_MONTH")));
		        	CpwsMisLan.add(formatData(rs.getInt("TARIFF_MONTH")*rs.getInt("HOUSE_CONN")*12));
		        	vlist.add(datavalue);
		        	vlist.add(CpwsMisLan);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in OandM:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("06") && scname.equals("001"))
		  {
		 	ArrayList pwsCistern=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Panchayat");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Pump Code");
		 	columns.add("Location");
		 	columns.add("Pump Make");
		 	columns.add("Pump Type");
		 	columns.add("Pump Capacity");
		 	columns.add("Year Of Commissioning");
		 	columns.add("Hours Running Per Day");
		 	columns.add("Usage");
		 	columns.add("Designed Head");
		 	columns.add("Designed LPM");
		 	columns.add("Hours Of Power Availability");
		 	columns.add("Low Voltage Problems");
		 	columns.add("Remarks");
		 	columns.add("Feeder");
		 	columns.add("Generator Existing");
		 	vlist.add(columns);
		 	qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and substr(pump_code,1,16)=v.panch_code and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	Debug.println("pumpsetqry:"+qry);
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		pwsCistern = new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PUMPING-PUMPSETS REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
			 		pwsCistern.add(formatData(++sno));
			 		pwsCistern.add(rs.getString("PNAME"));
			 		pwsCistern.add(rs.getString("VNAME"));
			 		pwsCistern.add(rs.getString("PANCH_NAME"));
			 		pwsCistern.add(formatData(rs.getString("ASSET_NAME")));
			 		pwsCistern.add(formatData(rs.getString("ASSET_CODE")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_CODE")));
		        	pwsCistern.add(formatData(rs.getString("LOCATION")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_MAKE")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_TYPE"))); 
		         	pwsCistern.add(formatData(rs.getFloat("PUMP_CPTY")));
		        	pwsCistern.add(formatData(rs.getString("YEAR_COMM")));
		        	pwsCistern.add(formatData(rs.getInt("HR_RUN")));
		        	pwsCistern.add(formatData(rs.getString("USAGE")));
		        	pwsCistern.add(formatData(rs.getFloat("DESIGNED_HEAD")));
		        	pwsCistern.add(formatData(rs.getFloat("DESIGNED_LPM")));
		        	pwsCistern.add(formatData(rs.getFloat("POWER_AVAIL_PER_DAY"))); 
		        	pwsCistern.add(formatData(rs.getString("LOW_VOLT_PROB")));
		        	pwsCistern.add(formatData(rs.getString("SUGGESTIONS")));
		        	pwsCistern.add(formatData(rs.getString("FEEDER")));
		        	pwsCistern.add(formatData(rs.getString("GENERATOR_EXISTING")));	
		        	vlist.add(datavalue);
		        	vlist.add(pwsCistern);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Pump sets:"+e);
				}finally{
				closeAll();	
				}
		  }
	 }else if(assetType.equals("04")){
	 	ArrayList hpReport1=null;
	 	columns=new ArrayList();
	 	columns.add("S.No");
	 	columns.add("Panchayat");
	 	columns.add("Village");
	 	columns.add("Habitation");
	 	columns.add("Asset Name");
	 	columns.add("Asset Code");
	 	columns.add("Pump Code ");
	 	columns.add("Location");
	 	columns.add("Diameter(mm)");
	 	columns.add("Depth(Mts) ");
	 	columns.add("Casing(Type) ");
	 	columns.add("No of GI Pipes ");
	 	columns.add(" Total Pipe Length");
	 	columns.add("General Condition ");
	 	columns.add("Static Water Level(Mts) ");
	 	columns.add("Summer Water Level(Mts)(From Ground)");
	 	columns.add("No Of Hours Serving per day ");
	 	columns.add("No Of Households Served ");
	 	columns.add("HP No Painted ");
	 	columns.add("Repairs Per Year");
	 	columns.add("Platform Existing");
	 	columns.add("Platform Condition");
	 	columns.add("Drain");
	 	columns.add("Drain Condition");
	 	columns.add("Drain Connected to Side Drains");
	 	columns.add("Leach pit");
	 	columns.add("Hygiene ");
	 	columns.add("Present Yield (as per Local Enquiry)");
	 	columns.add("Yield(l.p.m)");
	 	columns.add("Quality Affected[NSS(Y)/Safe Source(N)]");
	 	vlist.add(columns);
	 	qry="select * from (select a.*,rownum r from(select subCompTbl.*,decode(subCompTbl.PAINTED ,'Y','YES','N','NO')paint,decode(subCompTbl.PLATFORM_CONDITION ,'G','GOOD','B','BAD','','-')pcond, ASSET_NAME ,v.* FROM RWS_ASSET_MAST_TBL M, RWS_HP_SUBCOMP_PARAM_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(hp_code,1,16) and substr(m.hab_code,1,2)= '"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'";
	 	if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		  qry+=" )a)";
	 	try{int sno=0;
	 	stmt=conn.createStatement();
	 	Debug.println("HP Qry:"+qry);
	 	rs=stmt.executeQuery(qry);
	 	ArrayList datavalue=null;
	 	while(rs.next()) 
	 	{
	 		//Debug.println("in while");
	 		hpReport1=new ArrayList();
	 		datavalue=new ArrayList();
	 		datavalue.add(formatData(atype)+"-"+formatData("-SOURCE-BOREWELL-REPORT "));
	 		//Debug.println("1111111");
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
		 	//Debug.println("22222222222");
		 	hpReport1.add(formatData(++sno));
		 	//Debug.println("in while 1");
		 	hpReport1.add(rs.getString("PNAME"));
		 	hpReport1.add(rs.getString("VNAME"));
		 	hpReport1.add(rs.getString("PANCH_NAME"));
	 		hpReport1.add(formatData(rs.getString("ASSET_NAME")));
	 		hpReport1.add(formatData(rs.getString("ASSET_CODE")));
    	    hpReport1.add(formatData(rs.getString("HP_CODE")));
    	    hpReport1.add(formatData(rs.getString("LOCATION")));
    	    hpReport1.add(formatData(rs.getFloat("DIAMETER")));
    	    hpReport1.add(formatData(rs.getFloat("DEPTH")));
    	    hpReport1.add(formatData(rs.getString("CASING"))); 
    	    hpReport1.add(formatData(rs.getInt("GI_NO")));
    	    hpReport1.add(formatData(rs.getInt("PIPE_LENGTH")));
    	    hpReport1.add(formatData(rs.getString("GEN_CONDITION"))); 
    	    hpReport1.add(formatData(rs.getFloat("STATIC_WL"))); 
    	    hpReport1.add(formatData(rs.getFloat("SUMMER_WL"))); 
    	    hpReport1.add(formatData(rs.getFloat("SER_HRS"))); 
    	    hpReport1.add(formatData(rs.getInt("SER_NO"))); 
        	hpReport1.add(formatData(rs.getString("PAINTED"))); 
        	hpReport1.add(formatData(rs.getString("REPAIRS")));
        	hpReport1.add(formatData(rs.getString("PLATFORM_EXISTING")));
        	hpReport1.add(formatData(rs.getString("PLATFORM_CONDITION"))); 
        	hpReport1.add(formatData(rs.getString("DRAIN"))); 
        	hpReport1.add(formatData(rs.getString("DRAIN_CONDITION"))); 
        	hpReport1.add(formatData(rs.getString("DRAIN_SD"))); 
        	hpReport1.add(formatData(rs.getString("DRAIN_LP"))); 
        	hpReport1.add(formatData(rs.getString("HYGIENE"))); 
        	hpReport1.add(formatData(rs.getString("PYEILD_LOCAL"))); 
        	hpReport1.add(formatData(rs.getInt("P_YEILD"))); 
        	hpReport1.add(formatData(rs.getString("QUALITY_AFFECTED")));
        	
        	vlist.add(datavalue);
        	vlist.add(hpReport1);
	 	}
	 	}catch(Exception e){
	 		Debug.println("Exception in HP:"+e);
	 	}
	 }
	 else if(assetType.equals("05"))
	 {
	 	//Debug.println("In SHP ddddddddddddddddddddddddddddddddd");
	 	ArrayList hpReport=null;
	 	columns=new ArrayList();
	 	columns.add("S.No");
	 	columns.add("Panchayat");
	 	columns.add("Village");
	 	columns.add("Habitation");
	 	columns.add("Asset Name");
	 	columns.add("Asset Code");
	 	columns.add("Shallow HandPump Code ");
	 	columns.add("Location");
	 	columns.add("Diameter");
	 	columns.add("Depth(Mts) ");
	 	columns.add("Hygiene");
	 	columns.add("Avg No. Of Hours Working Per Day");
	 	columns.add("Yeild");
	 	columns.add("Water Quality ");
	 	vlist.add(columns);
	 	qry="select * from (select a.*,rownum r from(select subCompTbl.*, ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and substr(SHALLOWHP_CODE,1,16)=v.panch_code  and substr(m.hab_code,1,2)= '"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'";
	 	if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		  qry+=" )a)";
	 	try{int sno=0;
	 	stmt=conn.createStatement();
	 	Debug.println("SHP Qry:"+qry);
	 	rs=stmt.executeQuery(qry);
	 	ArrayList datavalue=null;
	 	while(rs.next()) 
	 	{
	 		hpReport=new ArrayList();
	 		datavalue=new ArrayList();
	 		datavalue.add(formatData(atype)+"-"+formatData(" REPORT"));
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
		 	hpReport.add(formatData(++sno));
		 	hpReport.add(rs.getString("PNAME"));
		 	hpReport.add(rs.getString("VNAME"));
		 	hpReport.add(rs.getString("PANCH_NAME"));
	 		hpReport.add(formatData(rs.getString("ASSET_NAME")));
	 		hpReport.add(formatData(rs.getString("ASSET_CODE")));
    	    hpReport.add(formatData(rs.getString("SHALLOWHP_CODE")));
    	    hpReport.add(formatData(rs.getString("LOCATION")));
    	    hpReport.add(formatData(rs.getFloat("DIAMETER")));
    	    hpReport.add(formatData(rs.getFloat("DEPTH")));
    	    hpReport.add(formatData(rs.getString("HYGIENE"))); 
    	    hpReport.add(formatData(rs.getFloat("AVERAGE_HOURS"))); 
    	    hpReport.add(formatData(rs.getFloat("YIELD"))); 
    	    hpReport.add(formatData(rs.getString("WATER_QUALITY"))); 
    	    vlist.add(datavalue);
    	    vlist.add(hpReport);
	 	}
	 	}catch(Exception e){
	 		Debug.println("Exception in SHP:"+e);
	 	}
	 }
	 else if(assetType.equals("06"))
	 {
	 	ArrayList hpReport=null;
	 	columns=new ArrayList();
	 	columns.add("S.No");
	 	columns.add("Panchayat");
	 	columns.add("Village");
	 	columns.add("Habitation");
	 	columns.add("Asset Name");
	 	columns.add("Asset Code");
	 	columns.add("OpenWell Code ");
	 	columns.add("Location");
	 	columns.add("Diameter");
	 	columns.add("Depth(Mts) ");
	 	columns.add("Normal Water Level (mts)");
	 	columns.add("Minimum Water Level (mts)");
	 	columns.add("Maximum Water Level (mts)");
	 	columns.add("Platform Exists");
	 	columns.add("Purpose");
	 	columns.add("Quality");
	 	vlist.add(columns);
	 	qry="select * from (select a.*,rownum r from(select subCompTbl.*, ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and  substr(openwell_code,1,16)=v.panch_code and substr(m.hab_code,1,2)= '"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' ";
	 	if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		  qry+=" )a)";
	 	try{int sno=0;
	 	stmt=conn.createStatement();
	 	Debug.println("Open Well Qry:"+qry);
	 	rs=stmt.executeQuery(qry);
	 	ArrayList datavalue=null;
	 	while(rs.next()) 
	 	{
	 		hpReport=new ArrayList();
	 		datavalue=new ArrayList();
	 		datavalue.add(formatData(atype)+"-"+formatData("REPORT"));
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
		 	hpReport.add(formatData(++sno));
		 	hpReport.add(rs.getString("PNAME"));
		 	hpReport.add(rs.getString("VNAME"));
		 	hpReport.add(rs.getString("PANCH_NAME"));
		 	hpReport.add(formatData(rs.getString("ASSET_NAME")));
		 	hpReport.add(formatData(rs.getString("ASSET_CODE")));
    	    hpReport.add(formatData(rs.getString("OPENWELL_CODE")));
    	    hpReport.add(formatData(rs.getString("LOCATION")));
    	    hpReport.add(formatData(rs.getFloat("DIAMETER")));
    	    hpReport.add(formatData(rs.getFloat("DEPTH")));
    	    hpReport.add(formatData(rs.getFloat("NORMAL_WATER_LEVEL"))); 
    	    hpReport.add(formatData(rs.getFloat("MIN_WATER_LEVEL"))); 
    	    hpReport.add(formatData(rs.getFloat("MAX_WATER_LEVEL"))); 
    	    hpReport.add(formatData(rs.getString("PLATFORM_EXISTS"))); 
    	    hpReport.add(formatData(rs.getString("PURPOSE")));
    	    hpReport.add(formatData(rs.getString("QUALITY")));
    	    vlist.add(datavalue);
    	    vlist.add(hpReport);
	 	}
	 	}catch(Exception e)
		{
	 	Debug.println("Exceptipon In Open well");	
		}
	 }else if(assetType.equals("07"))
	 {
	 	ArrayList hpReport=null;
	 	columns=new ArrayList();
	 	columns.add("S.No");
	 	columns.add("Panchayat");
	 	columns.add("Village");
	 	columns.add("Habitation");
	 	columns.add("Asset Name");
	 	columns.add("Asset Code");
	 	columns.add("Pond Code ");
	 	columns.add("Fed By");
	 	columns.add("Hygeinity  ");
	 	columns.add("Volume Of Storage (cum)");
	 	columns.add("Pond Name");
	 	columns.add("Purpose");
	 	columns.add("Location");
	 	columns.add("Area Size");
	 	columns.add("Water Quality");
	 	vlist.add(columns);
	 	qry="select * from (select a.*,rownum r from(select subCompTbl.*, ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and  substr(pond_code,1,16) =v.panch_code and substr(m.hab_code,1,2)= '"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'";
	 	if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		  qry+=" )a)";
	 	
	 	try{int sno=0;
	 	stmt=conn.createStatement();
	 	Debug.println("Pond Qry:"+qry);
	 	rs=stmt.executeQuery(qry);
	 	ArrayList datavalue=null;
	 	while(rs.next()) 
	 	{
	 		hpReport=new ArrayList();
	 		datavalue=new ArrayList();
	 		datavalue.add(formatData(atype)+"-"+formatData("REPORT"));
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname"));
		 	hpReport.add(formatData(++sno));
		 	hpReport.add(rs.getString("PNAME"));
		 	hpReport.add(rs.getString("VNAME"));
		 	hpReport.add(rs.getString("PANCH_NAME"));
		 	hpReport.add(formatData(rs.getString("ASSET_NAME")));
		 	hpReport.add(formatData(rs.getString("ASSET_CODE")));
     	    hpReport.add(formatData(rs.getString("POND_CODE")));
     	    hpReport.add(formatData(rs.getString("FED_BY")));
     	    hpReport.add(formatData(rs.getString("HYGENITY")));
     	    hpReport.add(formatData(rs.getFloat("STORAGE_VOL")));
     	    hpReport.add(formatData(rs.getString("POND_NAME"))); 
     	    hpReport.add(formatData(rs.getString("USAGE_PURPOSE"))); 
     	    hpReport.add(formatData(rs.getString("POND_LOCATION"))); 
      	    hpReport.add(formatData(rs.getFloat("SIZE_AREA")));
     	    hpReport.add(formatData(rs.getString("WATER_QUALITY"))); 
     	    vlist.add(datavalue);
     	   vlist.add(hpReport);
	 	}
	 	}catch(Exception e)
		{
	 		Debug.println("Exception in Ponds:"+e);
		}
	 }
	return vlist;   
	}
	
	public ArrayList getPanchValues(String tabName,String cname,String scname,String assetType,String dcode,String divcode,String subcode,String mcode,String pcode,String vcode,String habcode)
	{

	 ArrayList vlist=new ArrayList();
	 Connection conn=null;
	 Statement stmt=null;
	 ResultSet rs=null;
	 conn=RwsOffices.getConn();
	 ArrayList columns=null;
	 String qry="";
	 String atype=null;
	 if(assetType.equals("01")){  
	 	atype="PWS"; 
	 }else if(assetType.equals("02")){
	 	atype="MPWS"; 
	 }
	 else if(assetType.equals("03")){
	 	atype="CPWS"; 
	 }else if(assetType.equals("09")){
	 	atype="DIRECT PUMPING"; 
	 }else if(assetType.equals("04")){
	 	atype="HAND PUMPS"; 
	 }
	 else if(assetType.equals("05")){
	 	atype="SHALLOW HAND PUMPS"; 
	 }
	 else if(assetType.equals("06")){
	 	atype="OPEN WELLS"; 
	 }else if(assetType.equals("07")){
	 	atype="PONDS"; 
	 }
	 if(assetType.equals("01")||assetType.equals("02")||assetType.equals("03")||assetType.equals("09")){
		if(cname.equals("01") && scname.equals("001"))
		{
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Village");
			columns.add("Habitation");
			columns.add("Asset Name");
			columns.add("Asset Code");
			columns.add("Source Code");
			columns.add("Source Type");
			columns.add("Sub Source Type");
			columns.add("Location");
			columns.add("Source Condition");
			columns.add("Static Water Level From Ground(Avg)(in Mts)");
			columns.add("Yield");
			columns.add("Source Depth(mts)");
			columns.add("Alternative Water Source");
			columns.add("Water Quality");
			vlist.add(columns);
		 try{
		 int sno=0;
		 stmt=conn.createStatement();
		 qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_SOURCE_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE" +
		  "  and v.panch_code=substr(source_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  and  subCompTbl.SOURCE_TYPE_CODE='1'  and pcode='"+pcode+"' ";
		 if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		  if(vcode!=null && !vcode.equals(""))
		  {
		  	qry+=" and v.vcode='"+vcode+"' ";
		  }
		  if(habcode!=null && !habcode.equals(""))
		  {
		  	qry+=" and m.hab_code='"+habcode+"' ";
		  }
		 ArrayList cpwsOhsr=null; 
		 ArrayList datavalue=null;
		 Debug.println("qry1:"+qry);
		 rs=stmt.executeQuery(qry);
		 while(rs.next())
		 { 
		 	++sno;
		 	cpwsOhsr=new ArrayList();  
		 	datavalue=new ArrayList();
		 	datavalue.add(formatData(atype)+"-"+formatData("SOURCE-SUBSURFACE REPORT"));
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
		 	
		 	cpwsOhsr.add(formatData(sno));
		 	cpwsOhsr.add(rs.getString("vname"));
		 	cpwsOhsr.add(rs.getString("panch_name"));
		 	cpwsOhsr.add(rs.getString("asset_name"));
		 	cpwsOhsr.add(rs.getString("asset_code"));
		 	cpwsOhsr.add(rs.getString("source_code"));
		 	if(rs.getString("SOURCE_TYPE_CODE")!=null && rs.getString("SOURCE_TYPE_CODE").equals("1"))
	          {
	          cpwsOhsr.add("Subsurface Source");	
	          }
	        if(rs.getString("SOURCE_TYPE_CODE").equals("1")&& rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("1"))
	          {
	           cpwsOhsr.add("BOREWELL");
	           }
	         else if(rs.getString("SOURCE_TYPE_CODE").equals("1") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("2"))
	          {
	          	cpwsOhsr.add("FILTER POINT");
	           }
	         else if(rs.getString("SOURCE_TYPE_CODE").equals("1") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("3"))
	           {
	            cpwsOhsr.add("INFILTARATION WELL");
	           }
	           else if(rs.getString("SOURCE_TYPE_CODE").equals("1") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("4"))
	           {
	            cpwsOhsr.add("OPEN WELL");
	           }
	           cpwsOhsr.add(formatData(rs.getString("LOCATION"))+"");
	           cpwsOhsr.add(formatData(rs.getString("SOURCE_CONDITION")));
	           cpwsOhsr.add(formatData(rs.getInt("STATIC_WATER_LEVEL")));
	           cpwsOhsr.add(formatData(rs.getString("YIELD")));
	           cpwsOhsr.add(formatData(rs.getFloat("DEPTH")));
	           cpwsOhsr.add(formatData(rs.getInt("DIST_NEAR_PRIVATE_SOURCE")));
	           if(rs.getString("WATER_QUALITY")!=null && rs.getString("WATER_QUALITY").equals("SS"))
	        	 {
	        	 cpwsOhsr.add(formatData("Safe Source"));
	        	 }
	         else{
	        	 	cpwsOhsr.add(formatData("Not Safe Source"));
	        	 }
	          
	           vlist.add(datavalue);
	           vlist.add(cpwsOhsr);	 
		 }
		 	
		 }catch(Exception e)
		 {
		 	Debug.println("Exception in subsurface source:"+e);
		 }
		 finally{
		 	closeAll();
		 } 
		}
		else if(cname.equals("01") && scname.equals("002"))
		{
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Village");
			columns.add("Habitation");
			columns.add("Asset Name");
			columns.add("Asset Code");
			columns.add("Source Code");
			columns.add("Source Type");
			columns.add("Sub Source Type");
			columns.add("Source Name");
			columns.add("Tapping point Location");
			columns.add("Source Condition");
			columns.add("Static Water Level From Ground(Avg) (in Mts)");
			columns.add("Summer Water Level");
			columns.add("Yield");
			columns.add("Alternative Water Source");
			columns.add("Water Quality");
			vlist.add(columns);
			qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_SOURCE_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE" +
			" and v.panch_code=substr(source_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"' and  subCompTbl.SOURCE_TYPE_CODE='2' and pcode='"+pcode+"'";
			if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
			try{int sno=0;
		 	ArrayList cpwsOhsr=null; 
		 	ArrayList datavalue=null; 
		 	stmt=conn.createStatement();
		 	rs=stmt.executeQuery(qry);
		 	while(rs.next()) 
		 	{++sno;
		 		cpwsOhsr=new ArrayList();
		 		datavalue=new ArrayList();
		 		datavalue.add(formatData(atype)+"-"+formatData("SOURCE-SURFACE REPORT"));
			 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
		 		cpwsOhsr.add(formatData(sno));
			 	cpwsOhsr.add(rs.getString("vname"));
			 	cpwsOhsr.add(rs.getString("panch_name"));
		 		cpwsOhsr.add(formatData(rs.getString("ASSET_NAME")));
		 		cpwsOhsr.add(formatData(rs.getString("ASSET_CODE")));
	            cpwsOhsr.add(formatData(rs.getString("SOURCE_CODE")));
	        	if(rs.getString("SOURCE_TYPE_CODE")!=null && rs.getString("SOURCE_TYPE_CODE").equals("2"))
	            {
	            	cpwsOhsr.add("Surface Source");
	            }
	            if(rs.getString("SOURCE_TYPE_CODE").equals("2")&& rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("1"))
	            {
	            	 cpwsOhsr.add("CANAL");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("2"))
	            {
	            	cpwsOhsr.add("RIVER");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("3"))
	            {
	            	cpwsOhsr.add("INTAKE WELL");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("4"))
	            {
	            	cpwsOhsr.add("SPRINGS");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null && rs.getString("SUBSOURCE_TYPE_CODE").equals("5"))
	            {
	            	cpwsOhsr.add("RESERVOIR");
	            }
	            else if(rs.getString("SOURCE_TYPE_CODE").equals("2") && rs.getString("SUBSOURCE_TYPE_CODE")!=null)
	            {
	            	cpwsOhsr.add("-");
	            }
	            cpwsOhsr.add(formatData(rs.getString("SOURCE_NAME")));
	            cpwsOhsr.add(formatData(rs.getString("LOCATION"))+"");
	            cpwsOhsr.add(formatData(rs.getString("SOURCE_CONDITION")));
	        	cpwsOhsr.add(formatData(rs.getInt("STATIC_WATER_LEVEL")));
	        	cpwsOhsr.add(formatData(rs.getInt("SUMMER_WATER_LEVEL")));
	        	cpwsOhsr.add(formatData(rs.getString("YIELD")));
	        	cpwsOhsr.add(formatData(rs.getInt("DIST_NEAR_PRIVATE_SOURCE")));
	        	if(rs.getString("WATER_QUALITY")!=null && rs.getString("WATER_QUALITY").equals("SS"))
	        	{
	        	cpwsOhsr.add(formatData("Safe Source"));
	        	}
	        	else{
	        		cpwsOhsr.add(formatData("Not Safe Source"));
	        	}
	        	vlist.add(datavalue);
	        	vlist.add(cpwsOhsr);
		 	}
		 	
		 	}catch(Exception e)
			{
		 	 Debug.println("Exception in Surface source:"+e);
			}finally{
			closeAll();	
			}
		 	
		 
		}
		else if(cname.equals("01") && scname.equals("003"))
		{

		 	ArrayList pwsCistern=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Pump Code");
		 	columns.add("Location");
		 	columns.add("Pump Make");
		 	columns.add("Pump Type");
		 	columns.add("Pump Capacity");
		 	columns.add("Year Of Commissioning");
		 	columns.add("Hours Running Per Day");
		 	columns.add("Usage");
		 	columns.add("Designed Head");
		 	columns.add("Designed LPM");
		 	columns.add("Hours Of Power Availability");
		 	columns.add("Low Voltage Problems");
		 	columns.add("Remarks");
		 	columns.add("Feeder");
		 	columns.add("Generator Existing");
		 	vlist.add(columns);
		 	qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and substr(pump_code,1,16)=v.panch_code and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"' and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	Debug.println("pumpsetqry:"+qry);
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		pwsCistern = new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PUMPING-PUMPSETS REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		pwsCistern.add(formatData(++sno));
			 		pwsCistern.add(rs.getString("VNAME"));
			 		pwsCistern.add(rs.getString("PANCH_NAME"));
			 		pwsCistern.add(formatData(rs.getString("ASSET_NAME")));
			 		pwsCistern.add(formatData(rs.getString("ASSET_CODE")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_CODE")));
		        	pwsCistern.add(formatData(rs.getString("LOCATION")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_MAKE")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_TYPE"))); 
		         	pwsCistern.add(formatData(rs.getFloat("PUMP_CPTY")));
		        	pwsCistern.add(formatData(rs.getString("YEAR_COMM")));
		        	pwsCistern.add(formatData(rs.getInt("HR_RUN")));
		        	pwsCistern.add(formatData(rs.getString("USAGE")));
		        	pwsCistern.add(formatData(rs.getFloat("DESIGNED_HEAD")));
		        	pwsCistern.add(formatData(rs.getFloat("DESIGNED_LPM")));
		        	pwsCistern.add(formatData(rs.getFloat("POWER_AVAIL_PER_DAY"))); 
		        	pwsCistern.add(formatData(rs.getString("LOW_VOLT_PROB")));
		        	pwsCistern.add(formatData(rs.getString("SUGGESTIONS")));
		        	pwsCistern.add(formatData(rs.getString("FEEDER")));
		        	pwsCistern.add(formatData(rs.getString("GENERATOR_EXISTING")));	
		        	vlist.add(datavalue);
		        	vlist.add(pwsCistern);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Pump sets:"+e);
				}finally{
				closeAll();	
				}
		  
		}
		else if(cname.equals("02") && scname.equals("001"))
		{
			ArrayList cpwsRwcWell=null;
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Village");
			columns.add("Habitation");
			columns.add("Asset Name");
			columns.add("Asset Code");
			columns.add("Raw Water Collection Well Code");
			columns.add("Location");
			columns.add("Capacity");
			vlist.add(columns);
			qry="select v.*,subCompTbl.asset_code,subCompTbl.RW_COLLWELL_CODE,subCompTbl.Location,subCompTbl.Capacity,subCompTbl.TYPE_OF_FLOORING,ASSET_NAME " +
		 	" FROM RWS_ASSET_MAST_TBL M, RWS_AST_RW_COLLWELL_PARAM_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  " +
		 	" and v.panch_code=substr(RW_COLLWELL_CODE ,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and " +
		 	" M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
			if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
			try{int sno=0;
				ArrayList datavalue=null;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	while(rs.next())
			 	{++sno;
			 		cpwsRwcWell=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-RAW WATER COLLECTION WELL REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		cpwsRwcWell.add(formatData(sno));
			 		cpwsRwcWell.add(rs.getString("vname"));
			 		cpwsRwcWell.add(rs.getString("panch_name"));
			 		cpwsRwcWell.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsRwcWell.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsRwcWell.add(formatData(rs.getString("RW_COLLWELL_CODE")));
		        	cpwsRwcWell.add(formatData(rs.getString("LOCATION")));
		        	cpwsRwcWell.add(formatData(rs.getFloat("CAPACITY")));	
		        	vlist.add(datavalue);
		        	vlist.add(cpwsRwcWell);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in RWC:"+e);
				}finally{
				closeAll();	
				}
		 
		}
		else if(cname.equals("02") && scname.equals("002"))
		{
			ArrayList cpwsSsTank=null;
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Village");
			columns.add("Habitation");
			columns.add("Asset Name");
			columns.add("Asset Code");
           columns.add("SS Tank Code");
           columns.add("SS Tank Size(LBD)");
           columns.add(" Depth(mts) ");
           columns.add("No Of Days Storage");
           columns.add(" No Of Mcum");
           columns.add("Fed By");
           columns.add("Location");
           vlist.add(columns);
           qry="select  subCompTbl.asset_code,subCompTbl.SSSC_CODE,subCompTbl.SS_SIZE,subCompTbl.CAPACITY_DAYS,subCompTbl.CAPACITY_MCUM,"+
			" subCompTbl.TANK_ADEQACY,subCompTbl.LOCATION,subCompTbl.POWER_CON,subCompTbl.POWER_HRS,"+
			" subCompTbl.DEPTH,subCompTbl.OTHERS,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_SS_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(subCompTbl.SSSC_CODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";	
           if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
           try{ int sno=0;
		 	stmt=conn.createStatement();
		 	rs=stmt.executeQuery(qry);
		 	ArrayList datavalue=null;
		 	while(rs.next())
		 	{++sno;
		 		cpwsSsTank=new ArrayList();
		 		datavalue=new ArrayList();
		 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-SS TANK REPORT"));
			 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
		 		cpwsSsTank.add(formatData(sno));
		 		cpwsSsTank.add(rs.getString("vname"));
		 		cpwsSsTank.add(rs.getString("panch_name"));
		 		cpwsSsTank.add(formatData(rs.getString("ASSET_NAME")));
		 		cpwsSsTank.add(formatData(rs.getString("ASSET_CODE")));
	        	cpwsSsTank.add(formatData(rs.getString("SSSC_CODE")));
	        	cpwsSsTank.add(formatData(rs.getString("SS_SIZE")));
	        	cpwsSsTank.add(formatData(rs.getFloat("DEPTH")));
	        	cpwsSsTank.add(formatData(rs.getString("CAPACITY_DAYS")));
	        	cpwsSsTank.add(formatData(rs.getString("CAPACITY_MCUM")));
	        	if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Urban"))
	        	{
	        		cpwsSsTank.add("Canal");
	        	}
	        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Rural"))
	        	{
	        		cpwsSsTank.add("River");
	        	}
	        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Dedicated"))
	        	{
	        		cpwsSsTank.add("Reserviors");
	        	}
	        	
	        	else if(rs.getString("TANK_ADEQACY")!=null && rs.getString("TANK_ADEQACY").equals("Others"))
	        	{
	        		if(rs.getString("OTHERS")!=null)
	        		cpwsSsTank.add(formatData(rs.getString("OTHERS")));
	        	}
	        	cpwsSsTank.add(formatData(rs.getString("LOCATION")));
	        	vlist.add(datavalue);
	        	vlist.add(cpwsSsTank);
		 	}
		 	
		 	}catch(Exception e)
			{
		 	 Debug.println("Exception in SS Tank:"+e);
			}finally{
			closeAll();	
			}
		}
		else if(cname.equals("02") && scname.equals("003"))
		{
			ArrayList cpwsSsFilter=null;
			columns=new ArrayList();
			columns.add("Sl.No");
			columns.add("Village");
           columns.add("Habitation");
           columns.add("Asset Name");
           columns.add("Asset Code");
           columns.add("WTP Code ");
           columns.add("Location ");
           columns.add("Capacity In MLD ");
           columns.add("No of Units ");
           columns.add("No of Hours Usage");
           columns.add("Size of Units(LBH in M)");
           columns.add("No of Stand By Units ");
           columns.add("Frequency Of Sand Scrapping ");
           columns.add("General Performance");
           columns.add("Extension Scope");
           columns.add("Sedmentation Tank");
           columns.add("Horizontal Roughing Filter");
           columns.add("Vertical Roughing Filter");
           vlist.add(columns);
			qry="select subCompTbl.asset_code,subCompTbl.WTPSC_CODE ,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ,subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.RATE_OF_FILTRATION, subCompTbl.FREQ_SAND_SCRAP,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,subCompTbl.Location,subCompTbl.CHK_FILTER,ASSET_NAME,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_WTP_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(subCompTbl.WTPSC_CODE,1,16) AND SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='SS' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
			if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
			try{
				int sno=0;
			 	stmt=conn.createStatement();
			 	ArrayList datavalue=null;
			 	rs=stmt.executeQuery(qry);
			 	while(rs.next())
			 	{++sno;
			 		cpwsSsFilter=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-SS FILTER REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		cpwsSsFilter.add(formatData(sno));
			 		cpwsSsFilter.add(rs.getString("VNAME"));
			 		cpwsSsFilter.add(rs.getString("PANCH_NAME"));
			 		cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsSsFilter.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
		        	cpwsSsFilter.add(formatData(rs.getString("LOCATION")));
		        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
		        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
		        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
		        	cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
		        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
		        	cpwsSsFilter.add(formatData(rs.getFloat("FREQ_SAND_SCRAP")));
		        	cpwsSsFilter.add(formatData(rs.getString("PERFORMANCE")));
		        	cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
		        	String chkfilter=rs.getString("CHK_FILTER");
		        	if( chkfilter!=null && chkfilter.substring(0,2).equals("01"))
					{
		        		cpwsSsFilter.add("YES");
					}
		        	else
		        	{
		        		cpwsSsFilter.add("NO");
		        	}
		        	if( chkfilter!=null && chkfilter.substring(2,4).equals("02"))
					{
		        		cpwsSsFilter.add("YES");
					}
		        	else
		        	{
		        		cpwsSsFilter.add("NO");
		        	}
		        	if( chkfilter!=null && chkfilter.substring(4,6).equals("03"))
					{
		        		cpwsSsFilter.add("YES");
					}
		        	else
		        	{
		        		cpwsSsFilter.add("NO");
		        	}
		        	vlist.add(datavalue);
		        	vlist.add(cpwsSsFilter);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in RS Filter:"+e);
				}finally{
				closeAll();	
				}
		}
		 else if(cname.equals("02") && scname.equals("004"))
		  {
		 	 ArrayList cpwsRsFilter=null;
		 	 columns=new ArrayList(); 
		 	 columns.add("Sl.No");
		 	 columns.add("Village");
            columns.add("Habitation");
            columns.add("Asset Name");
            columns.add("Asset Code");
            columns.add(" WTP Code ");
            columns.add("Location ");
            columns.add("Capacity In MLD ");
            columns.add("  No of Units ");
            columns.add("  No of Hours Usage ");
            columns.add(" Size of Units(LBH in M)  ");
            columns.add("No of Stand By Units ");
            columns.add("Frequency Of Back Wash ");
            columns.add("Clarifloculator");
            vlist.add(columns);
		     qry="select subCompTbl.*,ASSET_NAME,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_WTP_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=SUBSTR(SUBCOMPTBL.WTPSC_CODE,1,16) AND SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='RS' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		     if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		     try{int sno=0;
			 	stmt=conn.createStatement();
			 	ArrayList datavalue=null;
			 	rs=stmt.executeQuery(qry);
			    while(rs.next())  
			    {++sno;
			    	cpwsRsFilter=new ArrayList();
			    	datavalue=new ArrayList();
			    	datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-RS FILTER REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			    	cpwsRsFilter.add(formatData(sno));
			    	cpwsRsFilter.add(rs.getString("VNAME"));
			    	cpwsRsFilter.add(rs.getString("PANCH_NAME"));
			    	cpwsRsFilter.add(formatData(rs.getString("ASSET_NAME")));
			    	cpwsRsFilter.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsRsFilter.add(formatData(rs.getString("WTPSC_CODE")));
		        	cpwsRsFilter.add(formatData(rs.getString("Location")));
		        	cpwsRsFilter.add(formatData(rs.getFloat("USE_CAPACITYMLD")));
		        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
		        	cpwsRsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
		        	cpwsRsFilter.add(formatData(rs.getString("WTP_SIZE")));
		        	cpwsRsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
		         	cpwsRsFilter.add(formatData(rs.getFloat("FREQ_SAND_SCRAP")));
		        	if((rs.getString("CHK_FILTER")!=null) && (rs.getString("CHK_FILTER").substring(0,2)).equals("01"))
		        	{
		        		cpwsRsFilter.add("YES");
		        	}
		        	 else
		        	{
		        		cpwsRsFilter.add("NO");
		        	}	
		        	vlist.add(datavalue);
		        	vlist.add(cpwsRsFilter);
			    }
		     
		     }catch(Exception e)
				{
			 	 Debug.println("Exception in RS Filter:"+e);
				}finally{
				closeAll();	
				}	  
		  }
		 else if(cname.equals("02") && scname.equals("005"))
		  {
		 	ArrayList cpwsSump=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add(" Sump Code");
		 	columns.add(" Location");
		 	columns.add(" Diameter/Length ");
		 	columns.add(" Sump Depth");
		 	columns.add("Capacity of Sump(ltrs)");
		 	columns.add("Sump Condition");
		 	vlist.add(columns);
		 	qry="select subCompTbl.asset_code,subCompTbl.SUMPCODE,subCompTbl.Location ,subCompTbl.SUMP_CAPACITY , subCompTbl.SUMP_DEPTH,subCompTbl.SUMP_DIAMETER, DECODE(subCompTbl.SUMP_CONDITION,'G','GOOD','B','BAD')SUMP_CONDITION,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_SUMP_M_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(SUMPCODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{++sno;
			 		cpwsSump=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-SUMP REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		cpwsSump.add(formatData(sno));
			 		cpwsSump.add(rs.getString("VNAME"));
			 		cpwsSump.add(rs.getString("PANCH_NAME"));
			 		cpwsSump.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsSump.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsSump.add(formatData(rs.getString("SUMPCODE")));
		        	cpwsSump.add(formatData(rs.getString("LOCATION")));
		        	cpwsSump.add(formatData(rs.getFloat("SUMP_DIAMETER")));
		        	cpwsSump.add(formatData(rs.getFloat("SUMP_DEPTH")));
		        	cpwsSump.add(formatData(rs.getInt("SUMP_CAPACITY"))+"");
		        	cpwsSump.add(formatData(rs.getString("SUMP_CONDITION")));
		        	vlist.add(datavalue);
		        	vlist.add(cpwsSump);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Surface source");
				}finally{
				closeAll();	
				}  
		  }
		 else if(cname.equals("02") && scname.equals("006"))
		  {
		 	ArrayList cpwsSump=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Bridge Code");
		 	columns.add("Location");
		 	vlist.add(columns);
		 	qry="select subCompTbl.asset_code,subCompTbl.BRIDGE_CODE,subCompTbl.BRIDGE_TYPE,subCompTbl.BRIDGE_LENGTH ,subCompTbl.BRIDGE_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH ,subCompTbl.BRIDGE_WALK_WAY_WIDTH,subCompTbl.LENGTH_OF_THE_BRIDGE,subCompTbl.BRIDGE_SPAN_LENGTH,subCompTbl.Location,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_FP_BRIDGE_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(BRIDGE_CODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{++sno;
			 		cpwsSump=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-FOOT PATH BRIDGE REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		cpwsSump.add(formatData(sno));
			 		cpwsSump.add(rs.getString("VNAME"));
			 		cpwsSump.add(rs.getString("PANCH_NAME"));
			 		cpwsSump.add(formatData(rs.getString("ASSET_NAME")+""));
			 		cpwsSump.add(formatData(rs.getString("ASSET_CODE")+""));
		        	cpwsSump.add(formatData(rs.getString("BRIDGE_CODE")+""));
		        	cpwsSump.add(formatData(rs.getString("LOCATION")));	
		        	vlist.add(datavalue);
		        	vlist.add(cpwsSump);	
			 	}
			 	
		 		}catch(Exception e)
				{
			 	 Debug.println("Exception in FPB "+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("02") && scname.equals("007"))
		  {
		 	ArrayList cpwspumpHouse=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Pump House Code");
		 	columns.add("Location");
		 	columns.add("Pump House Area(Sq.Mts)");
		 	vlist.add(columns);
		 	qry="select subCompTbl.asset_code,subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.HEIGHT ,subCompTbl.PUMPHOUSE_CODE,subCompTbl.Location,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_PUMPHOUSE_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(PUMPHOUSE_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{++sno;
			 	cpwspumpHouse=new ArrayList();
			 	datavalue=new ArrayList();
			 	datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-PUMP HOUSE REPORT"));
			 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 	cpwspumpHouse.add(formatData(sno));
			 	cpwspumpHouse.add(rs.getString("VNAME"));
			 	cpwspumpHouse.add(rs.getString("PANCH_NAME"));
			 	cpwspumpHouse.add(formatData(rs.getString("ASSET_NAME")));
			 	cpwspumpHouse.add(formatData(rs.getString("ASSET_CODE")));
			 	cpwspumpHouse.add(formatData(rs.getString("PUMPHOUSE_CODE")));
	        	cpwspumpHouse.add(formatData(rs.getString("Location")));
	        	cpwspumpHouse.add(formatData(rs.getString("AREA")));
	        	vlist.add(datavalue);
	        	vlist.add(cpwspumpHouse);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in PUMP HOUSE:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("02") && scname.equals("008"))
		  {
		 	ArrayList cpwswatch=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation"); 
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("WatchMan Quarter Code");
		 	columns.add(" Location");
		 	vlist.add(columns);
		    qry="select subCompTbl.asset_code,subCompTbl.TYPE ,subCompTbl.AREA,subCompTbl.NO_OF_QTRS ,subCompTbl.WATCHMAN_CODE,subCompTbl.Location,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_WATCHMAN_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(WATCHMAN_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		    if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		    try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		cpwswatch=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-WATCHMAN QUATRER REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		cpwswatch.add(formatData(sno));
			 		cpwswatch.add(rs.getString("VNAME"));
			 		cpwswatch.add(rs.getString("PANCH_NAME"));
			 		cpwswatch.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwswatch.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwswatch.add(formatData(rs.getString("WATCHMAN_CODE")));
		        	cpwswatch.add(formatData(rs.getString("Location")));
		        	vlist.add(datavalue);
		        	vlist.add(cpwswatch);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Watchman:"+e);
				}finally{
				closeAll();	
				} 
		  }
		 else if(cname.equals("02") && scname.equals("009"))
		  {
		 	ArrayList cpwsCwcWell=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Clear Water Collection Well Code");
		 	columns.add(" Location");
		 	columns.add(" Capacity");
		 	vlist.add(columns);
		    qry="select subCompTbl.asset_code,subCompTbl.CW_COLLWELL_CODE ,subCompTbl.DIAMETER,subCompTbl.DEPTH , subCompTbl.LOCATION,subCompTbl.CAPACITY,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_CW_COLLWELL_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(CW_COLLWELL_CODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		    if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		    try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{++sno;
			 		cpwsCwcWell=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-CLEAR WATER COLLECTION WELL REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		cpwsCwcWell.add(formatData(sno));
			 		cpwsCwcWell.add(rs.getString("VNAME"));
			 		cpwsCwcWell.add(rs.getString("PANCH_NAME"));
			 		cpwsCwcWell.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsCwcWell.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsCwcWell.add(formatData(rs.getString("CW_COLLWELL_CODE")));
		        	cpwsCwcWell.add(formatData(rs.getString("LOCATION")));
		        	cpwsCwcWell.add(formatData(rs.getFloat("CAPACITY")));
		        	vlist.add(datavalue);
		        	vlist.add(cpwsCwcWell);
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in CWC:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("02") && scname.equals("010"))
		  {
		 	   ArrayList cpwsSsFilter=null;
			   columns=new ArrayList();
			   columns.add("Sl.No");
			   columns.add("Village");
			   columns.add("Habitation");
			   columns.add("Asset Name");
			   columns.add("Asset Code");
			   columns.add("WTP Code ");
	           columns.add("Location");
	           columns.add("Capacity In MLD ");
	           columns.add("No of Units");
	           columns.add("No Of Hours Usage");
	           columns.add("Size of Units(LBH in M)");
	           columns.add("No of Stand By Units");                 
	           columns.add("Shelter Existance");
	           columns.add("General Performance ");
	           columns.add("Extension Scope");
	           columns.add("Sedimentation Tank ");
	           columns.add("Horizontal Roughing Filter");
	           columns.add("Vertical Roughing Filter ");                   
	           vlist.add(columns);               
           qry="select subCompTbl.asset_code,subCompTbl.WTPSC_CODE,subCompTbl.Location,subCompTbl.WTP_TYPW ,subCompTbl.WTP_MLD ,subCompTbl.UNITS_NO,subCompTbl.WTP_SIZE ,subCompTbl.UNITS_STANDBY ,subCompTbl.RATE_OF_FILTRATION, subCompTbl.SHELTER_EXISTING,DECODE(subCompTbl.PERFORMANCE,'G','GOOD','B','BAD')PERFORMANCE ,subCompTbl.USE_CAPACITYMLD ,DECODE(subCompTbl.EXTENTION_SCOPE,'Y','YES','N','NO')EXTENTION_SCOPE,subCompTbl.CHK_FILTER,ASSET_NAME,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_WTP_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND substr(WTPSC_CODE,1,16)=v.panch_code and SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='MS' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
           	 if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
           try{int sno=0;
   		 	stmt=conn.createStatement();
   		 	rs=stmt.executeQuery(qry);
   		 	ArrayList datavalue=null;
   		 	while(rs.next())
   		 	{++sno;
   		 		cpwsSsFilter=new ArrayList();
   		 		datavalue=new ArrayList();
   		 		datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-MICRO FILTER REPORT"));
				datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
   		 		cpwsSsFilter.add(formatData(sno));
   		 		cpwsSsFilter.add(rs.getString("VNAME"));
   		 		cpwsSsFilter.add(rs.getString("PANCH_NAME"));
   		 		cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
   		 		cpwsSsFilter.add(formatData(rs.getString("ASSET_CODE")));
   	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
   	        	cpwsSsFilter.add(formatData(rs.getString("Location")));
   	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
   	        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
   	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
   	        	cpwsSsFilter.add(formatData(rs.getString("WTP_SIZE")));
   	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
   	        	 if(rs.getString("SHELTER_EXISTING")!=null && rs.getInt("SHELTER_EXISTING")==1)
   	         	 {
   	         	 	cpwsSsFilter.add("YES");
   	         	 } 
   	         	 else
   	         	 {
   	         	 	cpwsSsFilter.add("NO");
   	         	 }
   	        	
   	        	cpwsSsFilter.add(formatData(rs.getString("PERFORMANCE")));
   	        	cpwsSsFilter.add(formatData(rs.getString("EXTENTION_SCOPE")));
   	        	String chkfilter=rs.getString("CHK_FILTER");
   	        	
   	        	if( chkfilter!=null && chkfilter.substring(0,2).equals("01"))
   				{
   	        		//Debug.println("22222222"+rs.getString("CHK_FILTER"));
   	        		cpwsSsFilter.add("YES");
   				}
   	        	else
   	        	{
   	        		cpwsSsFilter.add("NO");
   	        	}
   	        	if( chkfilter!=null && chkfilter.substring(2,4).equals("02"))
   				{
   	        		//Debug.println("3333"+rs.getString("CHK_FILTER"));
   	        		cpwsSsFilter.add("YES");
   				}
   	        	else
   	        	{
   	        		cpwsSsFilter.add("NO");
   	        	}
   	        	if( chkfilter!=null && chkfilter.substring(4,6).equals("03"))
   				{
   	        		//Debug.println("4444"+ rs.getString("CHK_FILTER"));
   	        		cpwsSsFilter.add("YES");
   				}
   	        	else
   	        	{
   	        		cpwsSsFilter.add("NO");
   	        	} 
   	        	vlist.add(datavalue);
   	        	vlist.add(cpwsSsFilter);
   		 	}
   		 	
   		 	}catch(Exception e)
   			{
   		 	 Debug.println("Exception in MF:"+e);
   			}finally{
   			closeAll();	
   			} 	  
		  }
		 else if(cname.equals("02") && scname.equals("011"))
		  {
		   ArrayList cpwsSsFilter=null;
		   columns=new ArrayList();
		   columns.add("Sl.No");
		   columns.add("Village");
           columns.add("Habitation");
           columns.add("Asset Name");
           columns.add("Asset Code");
           columns.add(" WTP Code ");
           columns.add("Location ");
           columns.add("Capacity  ");
           columns.add("No of Units ");
           columns.add("No of Hours of Usage ");
           columns.add("No of Stand By Units ");
           columns.add("Raw Water Storage Tank Existing  ");
           columns.add(" Product Water Storage Tank Existing  ");
           columns.add("Shelter Existing ");
           vlist.add(columns);
		    qry="select subCompTbl.*,ASSET_NAME,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_WTP_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=SUBSTR(SUBCOMPTBL.WTPSC_CODE,1,16) AND SUBSTR(SUBCOMPTBL.WTPSC_CODE,20,2)='RP' and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"'";
		    if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		    Debug.println(qry);
		    try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next()) 
			 	{++sno;
			 	cpwsSsFilter=new ArrayList();
			 	datavalue=new ArrayList();
			 	datavalue.add(formatData(atype)+"-"+formatData("HEAD WORKS-RO PLANTS REPORT"));
				datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
   		 		cpwsSsFilter.add(formatData(sno));
   		 		cpwsSsFilter.add(rs.getString("VNAME"));
   		 		cpwsSsFilter.add(rs.getString("PANCH_NAME"));
   		 		cpwsSsFilter.add(formatData(rs.getString("ASSET_NAME")));
   		 		cpwsSsFilter.add(formatData(rs.getString("ASSET_CODE")));
   	        	cpwsSsFilter.add(formatData(rs.getString("WTPSC_CODE")));
   	        	cpwsSsFilter.add(formatData(rs.getString("Location")));
   	        	cpwsSsFilter.add(formatData(rs.getFloat("WTP_MLD")));
   	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_NO"))+"");
   	        	cpwsSsFilter.add(formatData(rs.getFloat("RATE_OF_FILTRATION")));
   	        	cpwsSsFilter.add(formatData(rs.getInt("UNITS_STANDBY"))+"");
   	        	if(rs.getString("RWS_TANK_EXISTING")!=null && rs.getInt("RWS_TANK_EXISTING")==1)
   	        	{
   	        		cpwsSsFilter.add("YES");	
   	        	}else
   	        	{
   	        		cpwsSsFilter.add("NO");	
   	        	}
   	        	if(rs.getString("PWS_TANK_EXISTING")!=null && rs.getInt("PWS_TANK_EXISTING")==1)
   	        	{
   	        		cpwsSsFilter.add("YES");	
   	        	}else
   	        	{
   	        		cpwsSsFilter.add("NO");	
   	        	}
   	        	if(rs.getString("SHELTER_EXISTING")!=null && rs.getInt("SHELTER_EXISTING")==1)
   	        	{
   	        		cpwsSsFilter.add("YES");	
   	        	}else
   	        	{
   	        		cpwsSsFilter.add("NO");	
   	        	}
   	        	vlist.add(datavalue);
		        	vlist.add(cpwsSsFilter);	
			 	}
			 	
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in RP:"+e);
				}finally{
				closeAll();	
				} 
		  }
		 else if(cname.equals("03") && scname.equals("001"))
		  {
		 	ArrayList cpwsPm=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Pumping Main Code");
		 	columns.add("No Of Air Valves");
		 	columns.add("No Of Scour Valves");
		 	columns.add("No Of Reflux Valves");
		 	columns.add("No Of Sluice Valves");
		 	columns.add("Number of Pipes");
		 	columns.add("Zero Velocity Valve");
		 	columns.add("Air Cushion Valve");
		 	columns.add("Non Return Valve");
		 	vlist.add(columns);
		 	qry="select subCompTbl.asset_code,subCompTbl.PUMPINGMAIN_CODE ,subCompTbl.AIRVALVE_NO, subCompTbl.SCOUREVALVE ,subCompTbl.REFLEXVALVE,subCompTbl.SLUICEVALVE ,subCompTbl.NO_OF_PIPES, subCompTbl.ZERO_VELOCITY_VALVE ,subCompTbl.AIR_CUSHION_VALVE ,subCompTbl.LOCATION,subCompTbl.NON_RETURN_VALVE,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_PUMPINGMAIN_TBL  subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(PUMPINGMAIN_CODE,1,16)  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		 cpwsPm=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PIPELINE-PUMPING MAIN REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		 cpwsPm.add(formatData(++sno));
			 		 cpwsPm.add(rs.getString("VNAME"));
			 		 cpwsPm.add(rs.getString("PANCH_NAME"));
			 		 cpwsPm.add(formatData(rs.getString("ASSET_NAME")));	
			 		cpwsPm.add(formatData(rs.getString("ASSET_CODE")));
			         cpwsPm.add(formatData(rs.getString("PUMPINGMAIN_CODE")));
			         cpwsPm.add(formatData(rs.getInt("AIRVALVE_NO")));
			         cpwsPm.add(formatData(rs.getInt("SCOUREVALVE")));
			         cpwsPm.add(formatData(rs.getInt("REFLEXVALVE")));
			         cpwsPm.add(formatData(rs.getInt("SLUICEVALVE")));
			         cpwsPm.add(formatData(rs.getInt("NO_OF_PIPES")));
			         cpwsPm.add(formatData(rs.getInt("ZERO_VELOCITY_VALVE")));
			         cpwsPm.add(formatData(rs.getInt("AIR_CUSHION_VALVE")));
			         cpwsPm.add(formatData(rs.getInt("NON_RETURN_VALVE")));	
			         vlist.add(datavalue);
			         vlist.add(cpwsPm);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in PM:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("03") && scname.equals("002"))
		  {
		 	ArrayList cpwsGm=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Gravity Main Code");
		 	columns.add("Length(mts)");
		 	columns.add("No Of Air Valves");
		 	columns.add("No Of Scour Valves");
		 	columns.add("No Of Reflux Valves");
		 	columns.add("No Of Sluice Valves");
		 	columns.add(" No of Pipes ");
		 	columns.add("No of Zero Velocity Valves ");
		 	columns.add("No of Air Cushion Valves ");
		 	columns.add("Non Return Valve");
		 	vlist.add(columns);
		 	qry="select  subCompTbl.*,M.ASSET_NAME ,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_GRAVITYMAIN_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(GRAVITYMAIN_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		cpwsGm=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PIPELINE-GRAVITY MAIN REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		cpwsGm.add(formatData(++sno));
			 		cpwsGm.add(rs.getString("VNAME"));
			 		cpwsGm.add(rs.getString("PANCH_NAME"));
			 		cpwsGm.add(formatData(rs.getString("ASSET_Name")));
			 		cpwsGm.add(formatData(rs.getString("ASSET_code")));
		        	cpwsGm.add(formatData(rs.getString("GRAVITYMAIN_CODE")));
		        	cpwsGm.add(formatData(rs.getString("LENGTH")));
		        	cpwsGm.add(formatData(rs.getString("AIRVALVE_NO")));
		        	cpwsGm.add(formatData(rs.getString("SCOUREVALVE")));
		            cpwsGm.add(formatData(rs.getString("REFLEXVALVE")));
		        	cpwsGm.add(formatData(rs.getString("SLUICEVALVE")));
		        	cpwsGm.add(formatData(rs.getString("NO_OF_PIPES")));
		        	cpwsGm.add(formatData(rs.getString("ZERO_VELOCITY_VALVE")));
		        	cpwsGm.add(formatData(rs.getString("NON_RETURN_VALVE")));
		        	cpwsGm.add(formatData(rs.getString("AIR_CUSHION_VALVE")));
		        	vlist.add(datavalue);
		        	vlist.add(cpwsGm);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in GM:"+e);
				}finally{
				closeAll();	
				} 
		  }
		 else if(cname.equals("03") && scname.equals("003"))
		  {
		 	ArrayList cpwsGm=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Distribution Code ");  
		 	columns.add("No of Pipes Required");
		 	columns.add("No. Of Air Valves");
		 	columns.add("Total Length Needed");
		 	columns.add("No. Of Sluice Valves");
		 	columns.add("Total Length Provided");
		 	columns.add("No. Of Scour Valves");
		 	columns.add("Full Villages Covered ");
		 	columns.add("No. Of Private House Connections");
		 	columns.add("Balance Needed in Mts");
		 	columns.add("No.Of Stand Posts");
		 	vlist.add(columns);
		 	qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_DISTRI_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(DISTRISC_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'   and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		cpwsGm=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PIPELINE-DISTRIBUTION REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		cpwsGm.add(formatData(++sno));
			 		cpwsGm.add(rs.getString("VNAME"));
			 		cpwsGm.add(rs.getString("PANCH_NAME"));
			 		cpwsGm.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsGm.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsGm.add(formatData(rs.getString("DISTRISC_CODE")));
		        	cpwsGm.add(formatData(rs.getInt("NO_OF_PIPES")));
		        	cpwsGm.add(formatData(rs.getInt("NO_AIRVALVES"))+"");
		        	cpwsGm.add(formatData(rs.getInt("DIS_LN"))+"");
		        	cpwsGm.add(formatData(rs.getInt("NO_SLUICEVALVES"))+"");
		        	cpwsGm.add(formatData(rs.getFloat("DIS_TLC"))+"");
		        	cpwsGm.add(formatData(rs.getInt("NO_SCOURVALVES"))+"");
		        	cpwsGm.add(formatData(rs.getString("DIS_COVE"))+"");
		        	cpwsGm.add(formatData(rs.getInt("NO_PR_HC"))+"");
		        	cpwsGm.add(formatData(rs.getFloat("DIS_BN"))+"");
		        	cpwsGm.add(formatData(rs.getInt("NO_STANDPOSTS"))+"");
		        	vlist.add(datavalue);
		        	vlist.add(cpwsGm);
			 	}
		 	
		 		}catch(Exception e)
				{
			 	 Debug.println("Exception in Dist:"+e);
				}finally{
				closeAll();	
				}
		  }
		 	else if(cname.equals("04") && scname.equals("001"))
			{
		 		Statement stmt1=null;
		 		ResultSet rs1=null;
		 		ArrayList cpwsOhsr=null;
		 		columns=new ArrayList();
		 		columns.add("S.No");
		 		columns.add("Village");
		 		columns.add("Habitation");
		 		columns.add("Asset Name");
		 		columns.add("Asset Code");
		 		columns.add("OHSR Code");
		 		columns.add(" Habitation Linkage");
		 		columns.add("OHSR Location");
		 		columns.add("OHSR Capacity In Lts");
		 		columns.add("No.Of Fillings");
		 		columns.add("OHSR Staging(Mts)");
		 		columns.add(" Water Quality ");
		 		vlist.add(columns);
		 		qry="select subCompTbl.asset_code,subCompTbl.OHSR_CODE,subCompTbl.OHSR_LOC,subCompTbl.OHSR_CAP_LTS,subCompTbl.OHSR_NO_OF_FILLING,subCompTbl.OHSR_SATGES,subCompTbl.OHSR_LWL,subCompTbl.OHSR_MWL,subCompTbl.OHSR_FILL_HR,subCompTbl.OHSR_EMPTY_HR,subCompTbl.hab_code,subCompTbl.WATER_QTY,ASSET_NAME,v.* from RWS_ASSET_MAST_TBL M, RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(ohsr_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"'";
		 		 if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
				  if(vcode!=null && !vcode.equals(""))
				  {
				  	qry+=" and v.vcode='"+vcode+"' ";
				  }
				  if(habcode!=null && !habcode.equals(""))
				  {
				  	qry+=" and m.hab_code='"+habcode+"' ";
				  }
		 		Debug.println("qry:"+qry);
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	stmt1=conn.createStatement();
			 	
			 	ArrayList datavalue=null;
			 	String qry1=null;
			 	while(rs.next())
			 	{
			 		cpwsOhsr=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-OHSR REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
				 	cpwsOhsr.add(formatData(++sno));
				 	cpwsOhsr.add(rs.getString("VNAME"));
				 	cpwsOhsr.add(rs.getString("PANCH_NAME"));
			 		cpwsOhsr.add(formatData(rs.getString("ASSET_NAME")));
			 		cpwsOhsr.add(formatData(rs.getString("ASSET_CODE")));
		            cpwsOhsr.add(formatData(rs.getString("OHSR_CODE")));
		            qry1="select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+rs.getString("OHSR_CODE")+"'";
		            rs1=stmt1.executeQuery(qry1);
		            if(rs1.next())
		            {
		            	cpwsOhsr.add(formatData(rs1.getString("NO_OF_HABS")));	
		            }
		            cpwsOhsr.add(formatData(rs.getString("OHSR_LOC")));
		        	cpwsOhsr.add(formatData(rs.getInt("OHSR_CAP_LTS"))+"");
		            cpwsOhsr.add(formatData(rs.getInt("OHSR_NO_OF_FILLING"))+"");
		            cpwsOhsr.add(formatData(rs.getFloat("OHSR_SATGES")));
		            if(rs.getString("WATER_QTY")!=null && rs.getString("WATER_QTY").equals("N"))
		            {
		            	 cpwsOhsr.add("Safe Source");
		            }
		            else if(rs.getString("WATER_QTY")!=null && rs.getString("WATER_QTY").equals("Y"))
		            {
		            	 cpwsOhsr.add("Not Safe Source");
		            }
		            else
		            {
		            	 cpwsOhsr.add("Safe Source");	
		            }
		            vlist.add(datavalue);
		        	vlist.add(cpwsOhsr);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in OHSR:"+e);	
				}
		 		finally{
					closeAll();	
					}
			}
			else if(cname.equals("04") && scname.equals("002"))
			{   ArrayList cpwsOhbr=null;
				columns=new ArrayList();
				columns.add("S.No");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add("OHBR Code ");
				columns.add("OHBR Location ");
				columns.add("OHBR Capacity In Lts  ");
				columns.add("OHBR Staging(Mts)");
				vlist.add(columns);
		 		qry=" select subCompTbl.asset_code,subCompTbl.OHBR_CODE,subCompTbl.OHBR_LOC,subCompTbl.OHBR_CAP_LTS,subCompTbl.OHBR_SATGES,subCompTbl.OHBR_LWL,subCompTbl.OHBR_MWL,subCompTbl.OHBR_FILL_HR,subCompTbl.OHBR_EMPTY_HR,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_OHBR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(ohbr_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and m.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
				  if(vcode!=null && !vcode.equals(""))
				  {
				  	qry+=" and v.vcode='"+vcode+"' ";
				  }
				  if(habcode!=null && !habcode.equals(""))
				  {
				  	qry+=" and m.hab_code='"+habcode+"' ";
				  }
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{ 
			 		cpwsOhbr=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-OHBR REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
				 	cpwsOhbr.add(formatData(++sno));
				 	cpwsOhbr.add(rs.getString("VNAME"));
				 	cpwsOhbr.add(rs.getString("PANCH_NAME"));
				 	cpwsOhbr.add(formatData(rs.getString("ASSET_NAME")));
				 	cpwsOhbr.add(formatData(rs.getString("ASSET_CODE")));
				 	cpwsOhbr.add(formatData(rs.getString("OHBR_CODE")));
		            cpwsOhbr.add(formatData(rs.getString("OHBR_LOC")));
		        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_CAP_LTS")));
		        	cpwsOhbr.add(formatData(rs.getFloat("OHBR_SATGES")));
		        	vlist.add(datavalue);
			        vlist.add(cpwsOhbr);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in OHBR1:"+e);	
				}finally{
					closeAll();	
				}
			}
			else if(cname.equals("04") && scname.equals("003"))
			{   
				ArrayList cpwsGlsr=null;
				Statement stmt1=null;
				ResultSet rs1=null;
				columns=new ArrayList();
				columns.add("S.No");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add("GLSR Code ");
				columns.add("Habitation Linkage"); 
				columns.add("GLSR Location"); 
				columns.add("GLSR Capacity In Lts  ");
				columns.add("No.Of Fillings");
				columns.add("Glsr Staging(Mts)");
				columns.add("Water Quality ");
				vlist.add(columns);
		 		qry=" select subCompTbl.asset_code,subCompTbl.GLSR_CODE,subCompTbl.GLSR_LOC,subCompTbl.GLSR_CAP_LTS,subCompTbl.GLSR_SATGES,subCompTbl.GLSR_LWL,subCompTbl.GLSR_MWL,subCompTbl.GLSR_FILL_HR,subCompTbl.GLSR_EMPTY_HR,subCompTbl.GLSR_NO_OF_FILLING,subCompTbl.water_qty,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_GLSR_SC_PARAM_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and substr(glsr_code,1,16)=v.panch_code  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  m.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"'";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
				  if(vcode!=null && !vcode.equals(""))
				  {
				  	qry+=" and v.vcode='"+vcode+"' ";
				  }
				  if(habcode!=null && !habcode.equals(""))
				  {
				  	qry+=" and m.hab_code='"+habcode+"' ";
				  }
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	stmt1=conn.createStatement();
			 	Debug.println("qry:"+qry);
			 	rs=stmt.executeQuery(qry); 
			 	ArrayList datavalue=null;
			 	String qry1=null;
			 	while(rs.next())
			 	{
			 	cpwsGlsr=new ArrayList();
		 		datavalue=new ArrayList();
		 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-GLSR REPORT"));
			 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 	cpwsGlsr.add(formatData(++sno));
			 	cpwsGlsr.add(rs.getString("VNAME"));
			 	cpwsGlsr.add(rs.getString("PANCH_NAME"));
			 	cpwsGlsr.add(formatData(rs.getString("ASSET_NAME")));
			 	cpwsGlsr.add(formatData(rs.getString("ASSET_CODE")));
		        cpwsGlsr.add(formatData(rs.getString("GLSR_CODE")));
		        qry1="select count(*) as NO_OF_HABS from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+rs.getString("GLSR_CODE")+"'";
		        if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
				  if(vcode!=null && !vcode.equals(""))
				  {
				  	qry+=" and v.vcode='"+vcode+"' ";
				  }
				  if(habcode!=null && !habcode.equals(""))
				  {
				  	qry+=" and m.hab_code='"+habcode+"' ";
				  }
		        Debug.println("qry1:"+qry1);
		        rs1=stmt1.executeQuery(qry1);
		        Debug.println("after qry execution:"+qry1);
		        if(rs1.next())
	            {
	            	//Debug.println("sss:"+rs1.getString("NO_OF_HABS"));
	            	cpwsGlsr.add(formatData(rs1.getString("NO_OF_HABS")));	
	            }else{
	            	//Debug.println("3433333333333");
	            	cpwsGlsr.add("--");
	            }
	            
	           // Debug.println("after counting no of habs");
	            cpwsGlsr.add(formatData(rs.getString("GLSR_LOC")));                                                                                                        
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_CAP_LTS")));
	        	cpwsGlsr.add(formatData(rs.getFloat("GLSR_NO_OF_FILLING")));
	            cpwsGlsr.add(formatData(rs.getFloat("GLSR_SATGES")));
	            if(rs.getString("water_qty")!=null && !rs.getString("water_qty").equals("") && rs.getString("water_qty").equals("N"))
       		{
       		cpwsGlsr.add("Safe Source");
       	    }else{
       		cpwsGlsr.add("Not Safe Source");
       		}
	            vlist.add(datavalue);
		        vlist.add(cpwsGlsr);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in GLSR:"+e);	
				}finally{
					closeAll();	
				}
			}
			else if(cname.equals("04") && scname.equals("004"))
			  {
				ArrayList cpwsGlbr=null;
				columns=new ArrayList();
				columns.add("S.No");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add("GLBR Code ");
				columns.add("GLBR Location");
				columns.add("GLBR Capacity In Lts  ");
				columns.add("Lowest Water Level(LWL)  ");
				columns.add("Maximum Water Level(MWL) "); 
				columns.add("GLBR Fill In Hrs");
				columns.add("GLBR Empty In Hrs");
				vlist.add(columns);
		 		try{int sno=0;
		 		qry="select subCompTbl.asset_code,subCompTbl.GLBR_CODE,subCompTbl.GLBR_LOC,subCompTbl.GLBR_CAP_LTS,subCompTbl.GLBR_LWL,subCompTbl.GLBR_MWL,subCompTbl.GLBR_FILL_HR,subCompTbl.GLBR_EMPTY_HR,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_GLBR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(glbr_code,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"'";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
				  if(vcode!=null && !vcode.equals(""))
				  {
				  	qry+=" and v.vcode='"+vcode+"' ";
				  }
				  if(habcode!=null && !habcode.equals(""))
				  {
				  	qry+=" and m.hab_code='"+habcode+"' ";
				  }
		 		stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{ 
			 		cpwsGlbr=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-GLBR REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
				 	cpwsGlbr.add(formatData(++sno));
				 	cpwsGlbr.add(rs.getString("VNAME"));
				 	cpwsGlbr.add(rs.getString("PANCH_NAME"));
				 	cpwsGlbr.add(formatData(rs.getString("ASSET_NAME")));
				 	cpwsGlbr.add(formatData(rs.getString("ASSET_CODE")));
		        	cpwsGlbr.add(formatData(rs.getString("GLBR_CODE")));
		        	cpwsGlbr.add(formatData(rs.getString("GLBR_LOC")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_CAP_LTS")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_LWL")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_MWL")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_FILL_HR")));
		        	cpwsGlbr.add(formatData(rs.getFloat("GLBR_EMPTY_HR")));
		        	vlist.add(datavalue);
			        vlist.add(cpwsGlbr);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in GLBR:"+e);	
				}finally{
					closeAll();	
				}
			  }
			else if(cname.equals("04") && scname.equals("005"))
			 {  
				ArrayList cpwsBpt=null;
				columns=new ArrayList(); 
				columns.add("S.No");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add("BPT Code");
				columns.add(" Location ");
				columns.add("BPT Capacity in Lts");
				columns.add("BPT Staging(Mts)");
				vlist.add(columns);
		 		qry="select subCompTbl.asset_code,subCompTbl.BPT_CODE,subCompTbl.Location,subCompTbl.CAPACITY,subCompTbl.STAGING,subCompTbl.BPT_MWL,subCompTbl.BPT_LWL,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_BPT_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and substr(bpt_code,1,16)=v.panch_code and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"'";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
				  if(vcode!=null && !vcode.equals(""))
				  {
				  	qry+=" and v.vcode='"+vcode+"' ";
				  }
				  if(habcode!=null && !habcode.equals(""))
				  {
				  	qry+=" and m.hab_code='"+habcode+"' ";
				  }
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next()) 
			 	{
			 	 cpwsBpt=new ArrayList();
		 		 datavalue=new ArrayList();
		 		 datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-BPT REPORT"));
			 	 datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 	 cpwsBpt.add(formatData(++sno));
			 	 cpwsBpt.add(rs.getString("VNAME"));
			 	 cpwsBpt.add(rs.getString("PANCH_NAME"));
		 		 cpwsBpt.add(formatData(rs.getString("ASSET_NAME")));
		 		cpwsBpt.add(formatData(rs.getString("ASSET_CODE")));
	        	 cpwsBpt.add(formatData(rs.getString("BPT_CODE")));
	        	 cpwsBpt.add(formatData(rs.getString("Location")));
	        	 cpwsBpt.add(formatData(rs.getFloat("CAPACITY")));
	        	 cpwsBpt.add(formatData(rs.getFloat("STAGING")));
	        	 vlist.add(datavalue);
			     vlist.add(cpwsBpt);
	        	 
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in BPT:"+e);	
				}finally{
					closeAll();	
				}
			 }
			else if(cname.equals("04") && scname.equals("006"))
			 {
				ArrayList pwsCistern=null;
				columns=new ArrayList();
				columns.add("S.No");
				columns.add("Village");
				columns.add("Habitation");
				columns.add("Asset Name");
				columns.add("Asset Code");
				columns.add(" Cistern Code ");
				columns.add("Location ");
				columns.add("Capacity in Lts");
				columns.add("No Of Fillings/Day");
				columns.add(" PlatForm Existing");
				columns.add(" Platform Condition");
				columns.add("Drain Provided  ");
				columns.add(" Water Quality ");
				vlist.add(columns);
		 		qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_CIS_SC_PARAM_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE   and substr(CISSC_CODE,1,16)=v.panch_code and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"'";
		 		if(divcode!=null && !divcode.equals(""))
				  {
				  	qry+=" and m.division_office_code='"+divcode+"' ";
				  }
				  if(subcode!=null && !subcode.equals(""))
				  {
				  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
				  }
				  if(vcode!=null && !vcode.equals(""))
				  {
				  	qry+=" and v.vcode='"+vcode+"' ";
				  }
				  if(habcode!=null && !habcode.equals(""))
				  {
				  	qry+=" and m.hab_code='"+habcode+"' ";
				  }
		 		Debug.println("qry:"+qry);
		 		try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		pwsCistern=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("RESERVOIRS-CISTERNS REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
				 	pwsCistern.add(formatData(++sno));
				 	pwsCistern.add(rs.getString("VNAME"));
				 	pwsCistern.add(rs.getString("PANCH_NAME"));
			 		pwsCistern.add(formatData(rs.getString("ASSET_NAME")));
			 		pwsCistern.add(formatData(rs.getString("ASSET_CODE")));
	        		pwsCistern.add(formatData(rs.getString("CISSC_CODE"))); 
		        	pwsCistern.add(formatData(rs.getString("CIS_LOC")));
		        	pwsCistern.add(formatData(rs.getFloat("CIS_CAP_LTS"))+"");
		        	pwsCistern.add(formatData(rs.getString("CIS_HR"))+"");
		        	pwsCistern.add(formatData(rs.getString("CIS_PF")));
		        	pwsCistern.add(formatData(rs.getString("CIS_PF_CON")));
		        	pwsCistern.add(formatData(rs.getString("CIS_DRAIN")));
		        	if(rs.getString("Water_qty")!=null && rs.getString("Water_qty").equals("Y"))
		        	{
		        		pwsCistern.add("Safe Source");
		        	} 
		        	else
		        	{
		        		pwsCistern.add("Not Safe Source");
		        	}
		        	vlist.add(datavalue);
				    vlist.add(pwsCistern);
			 	}
		 		}catch(Exception e)
				{
		 		 Debug.println("Exception in Cisterns:"+e);	
				}finally{
					closeAll();	
				}
			 }
		 else if(cname.equals("05") && scname.equals("001"))
		  {
		 	ArrayList CpwsMisLan=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Component Name");
		 	columns.add("Component Code");
		 	columns.add("Component Location");
		 	columns.add("Remarks");
		 	vlist.add(columns);
		 	qry="select subCompTbl.* ,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_OTHERS_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE substr(OTHER_COMP_CODE,1,16)=v.panch_code and  M.ASSET_CODE=subCompTbl.ASSET_CODE  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and  M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		CpwsMisLan=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("OTHERS-MISSCELLANEOUS REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		CpwsMisLan.add(formatData(++sno));
			 		CpwsMisLan.add(rs.getString("VNAME"));
			 		CpwsMisLan.add(rs.getString("PANCH_NAME"));
			 		CpwsMisLan.add(formatData(rs.getString("ASSET_NAME"))+"");
			 		CpwsMisLan.add(formatData(rs.getString("ASSET_CODE"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("COMP_NAME"))+""); 
		        	CpwsMisLan.add(formatData(rs.getString("OTHER_COMP_CODE"))+""); 
		        	CpwsMisLan.add(formatData(rs.getString("COMP_LOCATION"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("REMARKS"))+"");	
		        	vlist.add(datavalue);
		        	vlist.add(CpwsMisLan);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Missl:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("05") && scname.equals("002"))
		  {
		 	ArrayList CpwsMisLan=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Chlorination Code");
		 	columns.add("Chlorination Location");
		 	columns.add("Working Or Not");
		 	columns.add("Bleaching Powder");
		 	columns.add("Liquid Chlorine");
		 	columns.add("Gas Chlorine");
		 	columns.add("Online Dosage");
		 	columns.add("Remarks");
		 	vlist.add(columns);
		 	qry="select subCompTbl.* ,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_CHLORINATION_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and v.panch_code=substr(CL_CODE,1,16) and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		CpwsMisLan=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("OTHERS-CHLORINATION REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		CpwsMisLan.add(formatData(++sno));
			 		CpwsMisLan.add(rs.getString("VNAME"));
			 		CpwsMisLan.add(rs.getString("PANCH_NAME"));
			 		CpwsMisLan.add(formatData(rs.getString("ASSET_NAME"))+"");
			 		CpwsMisLan.add(formatData(rs.getString("ASSET_CODE"))+""); 
		        	CpwsMisLan.add(formatData(rs.getString("CL_CODE"))+""); 
		        	CpwsMisLan.add(formatData(rs.getString("LOCATION"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("BLEACHING_WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("LIQUID_CHILORINE_WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("GAS_CHILORINE_WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("ONLINE_DOSE_WORKING"))+"");
		        	CpwsMisLan.add(formatData(rs.getString("REMARKS"))+"");	
		        	vlist.add(datavalue);
		        	vlist.add(CpwsMisLan);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Chlorination:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("05") && scname.equals("003"))
		  {
		 	ArrayList CpwsMisLan=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Agency ");
		 	columns.add("Power Cost");
		 	columns.add("Consumables");
		 	columns.add("Wages & Others");
		 	columns.add(" Total Cost of MTC");
		 	columns.add(" Source of Finding ");
		 	columns.add(" No of House Connections ");
		 	columns.add("Traiff/Month");
		 	columns.add("Total Collection/Anum ");
		 	vlist.add(columns);
		 	
		 	qry="select subCompTbl.* ,ASSET_NAME,M.HAB_CODE,v.*  FROM RWS_ASSET_MAST_TBL M, RWS_AST_OANDM_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE  and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
			  Debug.println("qry oandm:"+qry);
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		CpwsMisLan=new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("OTHERS-O AND M REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		CpwsMisLan.add(formatData(++sno));
			 		CpwsMisLan.add(rs.getString("VNAME"));
			 		CpwsMisLan.add(rs.getString("PANCH_NAME"));
			       	CpwsMisLan.add(formatData(rs.getString("ASSET_NAME"))+"");
			       	CpwsMisLan.add(formatData(rs.getString("ASSET_CODE"))+""); 
		        	if(rs.getString("AGENCY_CODE")!=null && rs.getString("AGENCY_CODE").equals("1"))
		        	{
		        		CpwsMisLan.add("ZP");	
		        	}
		        	 else if(rs.getString("AGENCY_CODE")!=null && rs.getString("AGENCY_CODE").equals("2"))
		        	{
		        		CpwsMisLan.add("MANDAL");	
		        	}
		        	else if(rs.getString("AGENCY_CODE")!=null && rs.getString("AGENCY_CODE").equals("3"))
		        	{
		        		CpwsMisLan.add("GP");	
		        	}
		        	CpwsMisLan.add(formatData(rs.getInt("POWER_COST")));
		        	CpwsMisLan.add(formatData(rs.getInt("CONSUM_ANNUM")));
		        	CpwsMisLan.add(formatData(rs.getInt("WAGES_ANNUM")));
		        	CpwsMisLan.add(formatData(rs.getInt("POWER_COST")+rs.getInt("CONSUM_ANNUM")+rs.getInt("WAGES_ANNUM")));
		        	if(rs.getString("SOURCES_FUND")!=null && rs.getString("SOURCES_FUND").equals("1"))
		        	{
		        		CpwsMisLan.add("RWS");	
		        	}
		        	CpwsMisLan.add(formatData(rs.getInt("HOUSE_CONN")));
		        	CpwsMisLan.add(formatData(rs.getInt("TARIFF_MONTH")));
		        	CpwsMisLan.add(formatData(rs.getInt("TARIFF_MONTH")*rs.getInt("HOUSE_CONN")*12));
		        	vlist.add(datavalue);
		        	vlist.add(CpwsMisLan);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in OandM:"+e);
				}finally{
				closeAll();	
				}
		  }
		 else if(cname.equals("06") && scname.equals("001"))
		  {
		 	ArrayList pwsCistern=null;
		 	columns=new ArrayList();
		 	columns.add("Sl.No");
		 	columns.add("Village");
		 	columns.add("Habitation");
		 	columns.add("Asset Name");
		 	columns.add("Asset Code");
		 	columns.add("Pump Code");
		 	columns.add("Location");
		 	columns.add("Pump Make");
		 	columns.add("Pump Type");
		 	columns.add("Pump Capacity");
		 	columns.add("Year Of Commissioning");
		 	columns.add("Hours Running Per Day");
		 	columns.add("Usage");
		 	columns.add("Designed Head");
		 	columns.add("Designed LPM");
		 	columns.add("Hours Of Power Availability");
		 	columns.add("Low Voltage Problems");
		 	columns.add("Remarks");
		 	columns.add("Feeder");
		 	columns.add("Generator Existing");
		 	vlist.add(columns);
		 	qry="select subCompTbl.*,ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_AST_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and substr(pump_code,1,16)=v.panch_code and substr(m.hab_code,1,2)='"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and M.type_of_asset_code='"+assetType+"'  and pcode='"+pcode+"' ";
		 	if(divcode!=null && !divcode.equals(""))
			  {
			  	qry+=" and m.division_office_code='"+divcode+"' ";
			  }
			  if(subcode!=null && !subcode.equals(""))
			  {
			  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
			  }
			  if(vcode!=null && !vcode.equals(""))
			  {
			  	qry+=" and v.vcode='"+vcode+"' ";
			  }
			  if(habcode!=null && !habcode.equals(""))
			  {
			  	qry+=" and m.hab_code='"+habcode+"' ";
			  }
		 	try{int sno=0;
			 	stmt=conn.createStatement();
			 	Debug.println("pumpsetqry:"+qry);
			 	rs=stmt.executeQuery(qry);
			 	ArrayList datavalue=null;
			 	while(rs.next())
			 	{
			 		pwsCistern = new ArrayList();
			 		datavalue=new ArrayList();
			 		datavalue.add(formatData(atype)+"-"+formatData("PUMPING-PUMPSETS REPORT"));
				 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
			 		pwsCistern.add(formatData(++sno));
			 		pwsCistern.add(rs.getString("VNAME"));
			 		pwsCistern.add(rs.getString("PANCH_NAME"));
			 		pwsCistern.add(formatData(rs.getString("ASSET_NAME")));
			 		pwsCistern.add(formatData(rs.getString("ASSET_CODE")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_CODE")));
		        	pwsCistern.add(formatData(rs.getString("LOCATION")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_MAKE")));
		        	pwsCistern.add(formatData(rs.getString("PUMP_TYPE"))); 
		         	pwsCistern.add(formatData(rs.getFloat("PUMP_CPTY")));
		        	pwsCistern.add(formatData(rs.getString("YEAR_COMM")));
		        	pwsCistern.add(formatData(rs.getInt("HR_RUN")));
		        	pwsCistern.add(formatData(rs.getString("USAGE")));
		        	pwsCistern.add(formatData(rs.getFloat("DESIGNED_HEAD")));
		        	pwsCistern.add(formatData(rs.getFloat("DESIGNED_LPM")));
		        	pwsCistern.add(formatData(rs.getFloat("POWER_AVAIL_PER_DAY"))); 
		        	pwsCistern.add(formatData(rs.getString("LOW_VOLT_PROB")));
		        	pwsCistern.add(formatData(rs.getString("SUGGESTIONS")));
		        	pwsCistern.add(formatData(rs.getString("FEEDER")));
		        	pwsCistern.add(formatData(rs.getString("GENERATOR_EXISTING")));	
		        	vlist.add(datavalue);
		        	vlist.add(pwsCistern);
			 	}
			 	}catch(Exception e)
				{
			 	 Debug.println("Exception in Pump sets:"+e);
				}finally{
				closeAll();	
				}
		  }
	 }else if(assetType.equals("04")){
	 	ArrayList hpReport1=null;
	 	columns=new ArrayList();
	 	columns.add("S.No");
	 	columns.add("Village");
	 	columns.add("Habitation");
	 	columns.add("Asset Name"); 
	 	columns.add("Asset Code");
	 	columns.add("Pump Code ");
	 	columns.add("Location");
	 	columns.add("Diameter(mm)");
	 	columns.add("Depth(Mts) ");
	 	columns.add("Casing(Type) ");
	 	columns.add("No of GI Pipes ");
	 	columns.add(" Total Pipe Length");
	 	columns.add("General Condition ");
	 	columns.add("Static Water Level(Mts) ");
	 	columns.add("Summer Water Level(Mts)(From Ground)");
	 	columns.add("No Of Hours Serving per day ");
	 	columns.add("No Of Households Served ");
	 	columns.add("HP No Painted ");
	 	columns.add("Repairs Per Year");
	 	columns.add("Platform Existing");
	 	columns.add("Platform Condition");
	 	columns.add("Drain");
	 	columns.add("Drain Condition");
	 	columns.add("Drain Connected to Side Drains");
	 	columns.add("Leach pit");
	 	columns.add("Hygiene ");
	 	columns.add("Present Yield (as per Local Enquiry)");
	 	columns.add("Yield(l.p.m)");
	 	columns.add("Quality Affected[NSS(Y)/Safe Source(N)]");
	 	vlist.add(columns);
	 	qry="select * from (select a.*,rownum r from(select subCompTbl.*,decode(subCompTbl.PAINTED ,'Y','YES','N','NO')paint,decode(subCompTbl.PLATFORM_CONDITION ,'G','GOOD','B','BAD','','-')pcond, ASSET_NAME ,v.* FROM RWS_ASSET_MAST_TBL M, RWS_HP_SUBCOMP_PARAM_TBL subCompTbl ,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and v.panch_code=substr(hp_code,1,16) and substr(m.hab_code,1,2)= '"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and pcode='"+pcode+"'";
	 	if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		  if(vcode!=null && !vcode.equals(""))
		  {
		  	qry+=" and v.vcode='"+vcode+"' ";
		  }
		  if(habcode!=null && !habcode.equals(""))
		  {
		  	qry+=" and m.hab_code='"+habcode+"' ";
		  }
		  qry+=" )a)";
	 	try{int sno=0;
	 	stmt=conn.createStatement();
	 	Debug.println("HP Qry:"+qry);
	 	rs=stmt.executeQuery(qry);
	 	ArrayList datavalue=null;
	 	while(rs.next()) 
	 	{
	 		//Debug.println("in while");
	 		hpReport1=new ArrayList();
	 		datavalue=new ArrayList();
	 		datavalue.add(formatData(atype)+"-"+formatData("-SOURCE-BOREWELL-REPORT "));
	 		//Debug.println("1111111");
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
		 	//Debug.println("22222222222");
		 	hpReport1.add(formatData(++sno));
		 	//Debug.println("in while 1");
		 	hpReport1.add(rs.getString("VNAME"));
		 	hpReport1.add(rs.getString("PANCH_NAME"));
	 		hpReport1.add(formatData(rs.getString("ASSET_NAME")));
	 		hpReport1.add(formatData(rs.getString("ASSET_CODE")));
   	    hpReport1.add(formatData(rs.getString("HP_CODE")));
   	    hpReport1.add(formatData(rs.getString("LOCATION")));
   	    hpReport1.add(formatData(rs.getFloat("DIAMETER")));
   	    hpReport1.add(formatData(rs.getFloat("DEPTH")));
   	    hpReport1.add(formatData(rs.getString("CASING"))); 
   	    hpReport1.add(formatData(rs.getInt("GI_NO")));
   	    hpReport1.add(formatData(rs.getInt("PIPE_LENGTH")));
   	    hpReport1.add(formatData(rs.getString("GEN_CONDITION"))); 
   	    hpReport1.add(formatData(rs.getFloat("STATIC_WL"))); 
   	    hpReport1.add(formatData(rs.getFloat("SUMMER_WL"))); 
   	    hpReport1.add(formatData(rs.getFloat("SER_HRS"))); 
   	    hpReport1.add(formatData(rs.getInt("SER_NO"))); 
       	hpReport1.add(formatData(rs.getString("PAINTED"))); 
       	hpReport1.add(formatData(rs.getString("REPAIRS")));
       	hpReport1.add(formatData(rs.getString("PLATFORM_EXISTING")));
       	hpReport1.add(formatData(rs.getString("PLATFORM_CONDITION"))); 
       	hpReport1.add(formatData(rs.getString("DRAIN"))); 
       	hpReport1.add(formatData(rs.getString("DRAIN_CONDITION"))); 
       	hpReport1.add(formatData(rs.getString("DRAIN_SD"))); 
       	hpReport1.add(formatData(rs.getString("DRAIN_LP"))); 
       	hpReport1.add(formatData(rs.getString("HYGIENE"))); 
       	hpReport1.add(formatData(rs.getString("PYEILD_LOCAL"))); 
       	hpReport1.add(formatData(rs.getInt("P_YEILD"))); 
       	hpReport1.add(formatData(rs.getString("QUALITY_AFFECTED")));
       	
       	vlist.add(datavalue);
       	vlist.add(hpReport1);
	 	}
	 	}catch(Exception e){
	 		Debug.println("Exception in HP:"+e);
	 	}
	 }
	 else if(assetType.equals("05"))
	 {
	 	//Debug.println("In SHP ddddddddddddddddddddddddddddddddd");
	 	ArrayList hpReport=null;
	 	columns=new ArrayList();
	 	columns.add("S.No");
	 	columns.add("Village");
	 	columns.add("Habitation");
	 	columns.add("Asset Name");
	 	columns.add("Asset Code");
	 	columns.add("Shallow HandPump Code ");
	 	columns.add("Location");
	 	columns.add("Diameter");
	 	columns.add("Depth(Mts) ");
	 	columns.add("Hygiene");
	 	columns.add("Avg No. Of Hours Working Per Day");
	 	columns.add("Yeild");
	 	columns.add("Water Quality ");
	 	vlist.add(columns);
	 	qry="select * from (select a.*,rownum r from(select subCompTbl.*, ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE and substr(SHALLOWHP_CODE,1,16)=v.panch_code  and substr(m.hab_code,1,2)= '"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"' and pcode='"+pcode+"'";
	 	if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		  if(vcode!=null && !vcode.equals(""))
		  {
		  	qry+=" and v.vcode='"+vcode+"' ";
		  }
		  if(habcode!=null && !habcode.equals(""))
		  {
		  	qry+=" and m.hab_code='"+habcode+"' ";
		  }
		  qry+=" )a)";
	 	try{int sno=0;
	 	stmt=conn.createStatement();
	 	Debug.println("SHP Qry:"+qry);
	 	rs=stmt.executeQuery(qry);
	 	ArrayList datavalue=null;
	 	while(rs.next()) 
	 	{
	 		hpReport=new ArrayList();
	 		datavalue=new ArrayList();
	 		datavalue.add(formatData(atype)+"-"+formatData(" REPORT"));
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
		 	hpReport.add(formatData(++sno));
		 	hpReport.add(rs.getString("VNAME"));
		 	hpReport.add(rs.getString("PANCH_NAME"));
	 		hpReport.add(formatData(rs.getString("ASSET_NAME")));
	 		hpReport.add(formatData(rs.getString("ASSET_CODE")));
   	    hpReport.add(formatData(rs.getString("SHALLOWHP_CODE")));
   	    hpReport.add(formatData(rs.getString("LOCATION")));
   	    hpReport.add(formatData(rs.getFloat("DIAMETER")));
   	    hpReport.add(formatData(rs.getFloat("DEPTH")));
   	    hpReport.add(formatData(rs.getString("HYGIENE"))); 
   	    hpReport.add(formatData(rs.getFloat("AVERAGE_HOURS"))); 
   	    hpReport.add(formatData(rs.getFloat("YIELD"))); 
   	    hpReport.add(formatData(rs.getString("WATER_QUALITY"))); 
   	    vlist.add(datavalue);
   	    vlist.add(hpReport);
	 	}
	 	}catch(Exception e){
	 		Debug.println("Exception in SHP:"+e);
	 	}
	 }
	 else if(assetType.equals("06"))
	 {
	 	ArrayList hpReport=null;
	 	columns=new ArrayList();
	 	columns.add("S.No");
	 	columns.add("Village");
	 	columns.add("Habitation");
	 	columns.add("Asset Name");
	 	columns.add("Asset Code");
	 	columns.add("OpenWell Code ");
	 	columns.add("Location");
	 	columns.add("Diameter");
	 	columns.add("Depth(Mts) ");
	 	columns.add("Normal Water Level (mts)");
	 	columns.add("Minimum Water Level (mts)");
	 	columns.add("Maximum Water Level (mts)");
	 	columns.add("Platform Exists");
	 	columns.add("Purpose");
	 	columns.add("Quality");
	 	vlist.add(columns);
	 	qry="select * from (select a.*,rownum r from(select subCompTbl.*, ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view v WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and  substr(openwell_code,1,16)=v.panch_code and substr(m.hab_code,1,2)= '"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and pcode='"+pcode+"' ";
	 	if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		  if(vcode!=null && !vcode.equals(""))
		  {
		  	qry+=" and v.vcode='"+vcode+"' ";
		  }
		  if(habcode!=null && !habcode.equals(""))
		  {
		  	qry+=" and m.hab_code='"+habcode+"' ";
		  }
		  qry+=" )a)";
	 	try{int sno=0;
	 	stmt=conn.createStatement();
	 	Debug.println("Open Well Qry:"+qry);
	 	rs=stmt.executeQuery(qry);
	 	ArrayList datavalue=null;
	 	while(rs.next()) 
	 	{
	 		hpReport=new ArrayList();
	 		datavalue=new ArrayList();
	 		datavalue.add(formatData(atype)+"-"+formatData("REPORT"));
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
		 	hpReport.add(formatData(++sno));
		 	hpReport.add(rs.getString("VNAME"));
		 	hpReport.add(rs.getString("PANCH_NAME"));
		 	hpReport.add(formatData(rs.getString("ASSET_NAME")));
		 	hpReport.add(formatData(rs.getString("ASSET_CODE")));
   	    hpReport.add(formatData(rs.getString("OPENWELL_CODE")));
   	    hpReport.add(formatData(rs.getString("LOCATION")));
   	    hpReport.add(formatData(rs.getFloat("DIAMETER")));
   	    hpReport.add(formatData(rs.getFloat("DEPTH")));
   	    hpReport.add(formatData(rs.getFloat("NORMAL_WATER_LEVEL"))); 
   	    hpReport.add(formatData(rs.getFloat("MIN_WATER_LEVEL"))); 
   	    hpReport.add(formatData(rs.getFloat("MAX_WATER_LEVEL"))); 
   	    hpReport.add(formatData(rs.getString("PLATFORM_EXISTS"))); 
   	    hpReport.add(formatData(rs.getString("PURPOSE")));
   	    hpReport.add(formatData(rs.getString("QUALITY")));
   	    vlist.add(datavalue);
   	    vlist.add(hpReport);
	 	}
	 	}catch(Exception e)
		{
	 	Debug.println("Exceptipon In Open well");	
		}
	 }else if(assetType.equals("07"))
	 {
	 	ArrayList hpReport=null;
	 	columns=new ArrayList();
	 	columns.add("S.No");
	 	columns.add("Village");
	 	columns.add("Habitation");
	 	columns.add("Asset Name");
	 	columns.add("Asset Code");
	 	columns.add("Pond Code ");
	 	columns.add("Fed By");
	 	columns.add("Hygeinity  ");
	 	columns.add("Volume Of Storage (cum)");
	 	columns.add("Pond Name");
	 	columns.add("Purpose");
	 	columns.add("Location");
	 	columns.add("Area Size");
	 	columns.add("Water Quality");
	 	vlist.add(columns);
	 	qry="select * from (select a.*,rownum r from(select subCompTbl.*, ASSET_NAME,v.* FROM RWS_ASSET_MAST_TBL M, RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view v  WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE  and  substr(pond_code,1,16) =v.panch_code and substr(m.hab_code,1,2)= '"+dcode+"' and substr(m.hab_code,6,2)='"+mcode+"'  and pcode='"+pcode+"' ";
	 	if(divcode!=null && !divcode.equals(""))
		  {
		  	qry+=" and m.division_office_code='"+divcode+"' ";
		  }
		  if(subcode!=null && !subcode.equals(""))
		  {
		  	qry+=" and m.subdivision_office_code='"+subcode+"' ";
		  }
		  if(vcode!=null && !vcode.equals(""))
		  {
		  	qry+=" and v.vcode='"+vcode+"' ";
		  }
		  if(habcode!=null && !habcode.equals(""))
		  {
		  	qry+=" and m.hab_code='"+habcode+"' ";
		  }
		  qry+=" )a)";
	 	try{int sno=0;
	 	stmt=conn.createStatement();
	 	Debug.println("Pond Qry:"+qry);
	 	rs=stmt.executeQuery(qry);
	 	ArrayList datavalue=null;
	 	while(rs.next()) 
	 	{
	 		hpReport=new ArrayList();
	 		datavalue=new ArrayList();
	 		datavalue.add(formatData(atype)+"-"+formatData("REPORT"));
		 	datavalue.add(formatData("DISTRICT:")+rs.getString("dname")+"    " +formatData("MANDAL:")+rs.getString("mname")+" "+formatData("PANCHAYAT:")+rs.getString("pname"));
		 	hpReport.add(formatData(++sno));
		 	hpReport.add(rs.getString("VNAME"));
		 	hpReport.add(rs.getString("PANCH_NAME"));
		 	hpReport.add(formatData(rs.getString("ASSET_NAME")));
		 	hpReport.add(formatData(rs.getString("ASSET_CODE")));
    	    hpReport.add(formatData(rs.getString("POND_CODE")));
    	    hpReport.add(formatData(rs.getString("FED_BY")));
    	    hpReport.add(formatData(rs.getString("HYGENITY")));
    	    hpReport.add(formatData(rs.getFloat("STORAGE_VOL")));
    	    hpReport.add(formatData(rs.getString("POND_NAME"))); 
    	    hpReport.add(formatData(rs.getString("USAGE_PURPOSE"))); 
    	    hpReport.add(formatData(rs.getString("POND_LOCATION"))); 
     	    hpReport.add(formatData(rs.getFloat("SIZE_AREA")));
    	    hpReport.add(formatData(rs.getString("WATER_QUALITY"))); 
    	    vlist.add(datavalue); 
    	   vlist.add(hpReport);
	 	}
	 	}catch(Exception e)
		{
	 		Debug.println("Exception in Ponds:"+e);
		}
	 }
	return vlist;   
	
	
}
}