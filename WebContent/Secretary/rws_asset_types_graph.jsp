<%@ page import="java.sql.*" %>



<%
 int i=0;
     String assetNames[]=new String[11];
	 String assetCount[]=new String[11];

	try{
      Statement st=conn.createStatement();
   String qry="select count(*),type_of_asset_name,b.type_of_asset_code from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s where a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code and a.type_of_asset_code not in('08','11','12') group by b.type_of_asset_code,type_of_asset_name  order by b.type_of_asset_code";
   ResultSet rst=st.executeQuery(qry);
  while(rst.next())
{	
       assetCount[i]=rst.getString(1);
       if(rst.getString(2).equals("HANDPUMPS"))
{
		assetNames[i]="HP";
}else if(rst.getString(2).equals("SHALLOW HAND PUMPS"))
{
assetNames[i]="SHP";
}
else if(rst.getString(2).equals("DIRECT PUMPING"))
{
assetNames[i]="DP";
}
else if(rst.getString(2).equals("OPEN WELLS"))
{
assetNames[i]="OW";
}else{
       assetNames[i]=rst.getString(2);
}
	i++;		 
}
 }catch(Exception e){
  e.printStackTrace();
}
        

%>