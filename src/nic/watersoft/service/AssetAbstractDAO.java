package nic.watersoft.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import nic.watersoft.util.DBUtil;

public class AssetAbstractDAO {

	public List<DistrictAsset> getAllAssets() throws Exception{
		   List<DistrictAsset> astAbsList = new ArrayList<DistrictAsset>();
		   
		   String astCodes = "'01','02','03','04','05','06','07','09'"; 
		   HashMap distAstMap = new HashMap();
		   HashMap distNameMap = new HashMap();
		   
		   Connection con = DBUtil.getDbConnection();
		   Statement stmt = DBUtil.getStatement(con);
		   String sql = "select substr(hab_code,1,2) as dcode,INITCAP(dname) as dname," +
		   				"decode(type_of_asset_code,'01','02','02','03','03','01','09','04','04','05','05','06','06','07','07','09') as type_of_asset_code," +
		   				"count(distinct asset_code),type_of_asset_name from rws_complete_asset_view where type_of_asset_code in (" + astCodes + ")" +
   						" group by dname,substr(hab_code,1,2),type_of_asset_code,type_of_asset_name order by dcode";
		   ResultSet astRs = DBUtil.getResultSet(stmt,sql);
		   while(astRs.next())
		   {
			   if(distAstMap.containsKey(astRs.getString(1)))
               {
                   long astValues[] = (long[]) distAstMap.get(astRs.getString(1));
                   astValues[astRs.getInt(3) - 1] = astRs.getLong(4);
                   distAstMap.put(astRs.getString(1),astValues);
               }
               else
               {
                   long astValues[] = new long[9];
                   astValues[astRs.getInt(3) - 1] = astRs.getLong(4);
                   distAstMap.put(astRs.getString(1),astValues);
                   distNameMap.put(astRs.getString(1), astRs.getString(2));
               }			   
		   }
		   
		   DBUtil.closeResultSet(astRs);
		   DBUtil.closeStatement(stmt);
		   DBUtil.closeConnection(con);
		   
		   Set keySet = distAstMap.keySet();
           ArrayList list = new ArrayList(keySet);
           Collections.sort(list);
		   
           for(Object key: list)
           {
        	   DistrictAsset astAbsBean = new DistrictAsset();
        	   String DistName = distNameMap.get(key).toString();
        	   
        	   long[] astValues = (long[]) distAstMap.get(key);
        	   
    		   Asset asset = new Asset();
    		   asset.setCpws(astValues[0]);
    		   asset.setPws(astValues[1]);
    		   asset.setMpws(astValues[2]);
    		   asset.setDp(astValues[3]);
    		   asset.setHp(astValues[4]);
    		   asset.setShp(astValues[5]);
    		   asset.setOw(astValues[6]);
    		   asset.setPond(astValues[8]);
    		   
    		   astAbsBean.setDcode(key.toString());
    		   astAbsBean.setDname(DistName);
    		   astAbsBean.setAssets(asset);
    		   
    		   astAbsList.add(astAbsBean);
           }
               
		   
		   return astAbsList;
	   }
	
	public DistrictAsset getAsset(String dcode) throws Exception{
	      List<DistrictAsset> allAssets = getAllAssets();

	      for(DistrictAsset distAsset: allAssets){
	         if(distAsset.getDcode().equals(dcode)){
	            return distAsset;
	         }
	      }
	      return null;
	   }
	
}
