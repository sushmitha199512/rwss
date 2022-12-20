<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@ include file="conn.jsp"%>

    <%
        HashMap assetTypeMap = new HashMap();
        assetTypeMap.put("01", "PWS");
        assetTypeMap.put("02", "MPWS");
        assetTypeMap.put("03", "CPWS");
        assetTypeMap.put("04", "HP");
        assetTypeMap.put("05", "SHP");
        assetTypeMap.put("06", "OW");
        assetTypeMap.put("07", "POND");
        assetTypeMap.put("09", "DP");
        HashMap distMap = new HashMap();
        HashMap distAssetMap = new HashMap();
        
        Set keySet = assetTypeMap.keySet();
        List keyList = new ArrayList(keySet);
        Collections.sort(keyList);
        
                    for(Object key: keyList)
                    {
                        String asstInputStr = "";
                        String astQuery = "select substr(hab_code,1,2) as dcode,dname,count(distinct asset_code) from rws_complete_asset_view where type_of_asset_code='"+key+"' group by dname,substr(hab_code,1,2) order by dcode";
                        Statement astStmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
                        ResultSet astRs=astStmt.executeQuery(astQuery);
                        while(astRs.next())
                        {
                            if(distAssetMap.containsKey(astRs.getString(1)))
                            {
                                String astAll = distAssetMap.get(astRs.getString(1))+","+astRs.getString(3);
                                distAssetMap.put(astRs.getString(1), astAll);
                            }
                            else
                            {
                                distAssetMap.put(astRs.getString(1), astRs.getString(3));
                            }
                        }
                    }
                    
                    System.out.println("%%%%%%%%%%%"+distAssetMap.get("01"));
    %>