<%@page import="java.sql.*" %>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<html>
<head>
<title> WaterSoft </title>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
</head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		
		</table>
		</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" >
			<font color="ffffff">Asset Status  Report </font></td>
	</tr>
<tr><td valign=top>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">	


<%
try
 {
	
	int totalHab = 0, totalAssets = 0, repNo = 0, propNo = 0, newEstNo =0, omEstNo = 0;
	PreparedStatement ps1 = null, ps2 = null, ps3=null, ps4 = null, ps5 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null;
	
	String query = null, query1 = null, query2=null, query3=null, query4 = null, query5=null;
	String[] cstatus = {"FC","PC1", "PC2", "PC3", "PC4", "NC","NSS","UI"};
	String[] assetType = {"01","02","03","04"};
	////System.out.println("dddddd");
		
		//query1 = " SELECT count(*) as cnt, decode(TYPE_OF_ASSET_CODE,'01','PWS', '03', 'CPWS', '02','MPWS', '04', 'Hand Pumps') as TYPE_OF_ASSET_CODE FROM rws_asset_mast_tbl WHERE TYPE_OF_ASSET_CODE = ? GROUP BY TYPE_OF_ASSET_CODE";
		
		
		
		//query2 = "select count(*) from RWS_REP_PROPOSAL_TBL";
		//query3 = "select count(*) from RWS_WORK_PROPOSAL_TBL ";
		//query4 = "SELECT count(*) FROM RWS_NEW_EST_TBL";
		//query5 = "SELECT count(*) FROM RWS_OM_EST_TBL  ";


		
		//ps2 = conn.prepareStatement(query2);
		//ps3 = conn.prepareStatement(query3);
		//ps4 = conn.prepareStatement(query4);
		//ps5 = conn.prepareStatement(query5);
										
	
	
%>
<%
		//rs2 = ps2.executeQuery();
		//if (rs2.next())
		//{
		//	repNo = rs2.getInt(1);
		//}
	//	rs2.close();

	//	rs3 = ps3.executeQuery();
		//if (rs3.next())
		//{
			//propNo = rs3.getInt(1);
		//}
		//rs3.close();
		//rs4 = ps4.executeQuery();
		//if (rs4.next())
		//{
		//	newEstNo = rs4.getInt(1);
		//}
		//rs4.close();
		//rs5 = ps5.executeQuery();
		//if (rs5.next())
	//	{
	//		omEstNo = rs5.getInt(1);
		//}
		//rs5.close();


%>
		


	<tr>
	<td class="btext">Asset Type</td>
	<td align="center" class="btext">No. of Assets</td>	
	</tr>		<%
	try{
	for (int i =0; i <assetType.length; i++)
	{	
		if(assetType[i].equals("01"))
		{
		query1="SELECT COUNT(*) as cnt, decode(m.TYPE_OF_ASSET_CODE,'01','PWS', '03', 'CPWS', '02','MPWS', '04', 'Hand Pumps') as TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' AND M.TYPE_OF_ASSET_CODE=? group by m.type_of_asset_code";
		}
		else if(assetType[i].equals("04"))
		{
		query1="select count(*) as cnt, decode(m.TYPE_OF_ASSET_CODE,'01','PWS', '03', 'CPWS', '02','MPWS', '04', 'Hand Pumps') as TYPE_OF_ASSET_CODE FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE=? and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' group by m.type_of_asset_code";
		}
		else
		{
		query1=" SELECT count(*) as cnt, decode(TYPE_OF_ASSET_CODE,'01','PWS', '03', 'CPWS', '02','MPWS', '04', 'Hand Pumps') as TYPE_OF_ASSET_CODE FROM rws_asset_mast_tbl WHERE TYPE_OF_ASSET_CODE = ? GROUP BY TYPE_OF_ASSET_CODE";
		}
		ps1 = conn.prepareStatement(query1);
		ps1.setString(1,assetType[i]);	
		rs1 = ps1.executeQuery();
		
		//System.out.println(query1);
		//System.out.println(assetType[i]);
		if (rs1.next())
		{
%>		
		 <tr>
		
		<td class="mystyle1"><%=rs1.getString("TYPE_OF_ASSET_CODE")%></td>
		<td class="mystyle1" align=right><%=rs1.getInt(1)%></td>
		</tr>
<%
		totalAssets = totalAssets + rs1.getInt(1);
		}
		rs1.close();
		ps1.close();

	}
	}catch(Exception e){}

%>
	<tr><td class="mystyle">Total Assets</td>
	<td class="mystyle" align=right><%=totalAssets%></td>
	</tr>
</tr> 
</table>
</td>
</tr>
</table>
<%

}
catch(Exception e)
{
	//System.out.println(e);
}
finally{
	
	conn.close();
}


%>
<%@ include file = "footer.jsp" %>
<%
try
{

     session.getAttributeNames();
     session.invalidate();
}
catch (java.lang.Exception isse)
{
    System.out.println("session already invalidated");
}

 %>
