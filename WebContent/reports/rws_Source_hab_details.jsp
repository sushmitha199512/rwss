<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file = "conn.jsp" %>
<%
String habcode=request.getParameter("habcode");
String stype=request.getParameter("stype");
String mode=request.getParameter("mode");
String qry1="";

%>
<form><%
if (stype!=null && stype.equals("04"))
{%>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" >
<tr align="center">
<td class=btext ><b>S.No</b></font></td>
 	<td class=btext><b>Habitation Code</b></font></td>
	<td class=btext><b>Asset Code </b></font></td>
	<td class=btext><b>Asset Name</b></font></td>
	<td class=btext><b>Asset Cost </b></font></td>
	<td class=btext><b>Asset Status </b></font></td>
	<td class=btext><b>HP Code</b></font></td>
	<td class=btext><b>Location</b></font></td>
	<td class=btext><b>Population Benefited</b></font></td>
	<td class=btext><b>Yield</b></font></td>
	<td class=btext><b>Service No</b></font></td>
	<td class=btext><b>Service HRS</b></font></td>
	<td class=btext><b>Quality Affected</b></font></td>
	<%if(mode!=null && mode.equals("3")){%>
	<td class=btext><b>Parameter Name</b></font></td>
	<td class=btext><b>Min. Value</b></font></td>
	<td class=btext><b>Max. Value</b></font></td>
	<td class=btext><b>Actual Value</b></font></td>
	
	<%}%>
</tr>
<% Statement stmt1=conn.createStatement();
Statement stmt2=conn.createStatement();
String tabName = "",colName="",tabName1 = "";

if (mode!=null && mode.equals("1"))
{
 qry1 = "select  a.ASSET_CODE,a.ASSET_NAME,a.ASSET_COST, h.HP_CODE,h.LOCATION,a.POPU_BENEFITED, h.P_YEILD, h.SER_NO,h.SER_HRS,decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') as Status,NVL(h.QUALITY_AFFECTED,'-')  from rws_asset_mast_tbl a,RWS_HP_SUBCOMP_PARAM_TBL h where a.asset_code=h.asset_code and TYPE_OF_ASSET_CODE ='"+stype+"' and A.hab_code='"+habcode+"'";
	 }
else if(mode!=null && mode.equals("2"))
{
	
qry1 = "select DISTINCT  a.ASSET_CODE,a.ASSET_NAME,a.ASSET_COST, h.HP_CODE,h.LOCATION,a.POPU_BENEFITED, h.P_YEILD, h.SER_NO,h.SER_HRS,decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') as Status,NVL(h.QUALITY_AFFECTED,'-')  from rws_water_sample_collect_tbl s,RWS_WQ_TEST_RESULTS_TBL WQ ,RWS_HP_SUBCOMP_PARAM_TBL h,RWS_ASSET_MAST_TBL A where A.ASSET_CODE=H.ASSET_CODE AND s.source_code=h.HP_CODE and A.hab_code='"+habcode+"' and TYPE_OF_ASSET_CODE ='"+stype+"' AND S.TEST_ID=WQ.TEST_ID";
	}
	else if(mode!=null && mode.equals("3"))
{
qry1="select  distinct A.ASSET_CODE,a.ASSET_NAME,a.ASSET_COST, h.HP_CODE,h.LOCATION,a.POPU_BENEFITED, h.P_YEILD, h.SER_NO,h.SER_HRS,decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') as Status,NVL(h.QUALITY_AFFECTED,'-'),TESTING_PARAMETER_NAME,NVL(MIN_PERMISSIBLE_VALUE,'-'),NVL(MAX_PERMISSIBLE_VALUE,'-'),TESTING_PARAMETER_VALUE  from rws_water_sample_collect_tbl s ,RWS_HP_SUBCOMP_PARAM_TBL h,RWS_ASSET_MAST_TBL A,RWS_WQ_TEST_RESULTS_LNK_TBL av, RWS_WQ_PARA_TEST_TBL mv,RWS_WQ_TEST_RESULTS_TBL WQ where A.ASSET_CODE=H.ASSET_CODE AND s.source_code=h.HP_CODE and A.hab_code='"+habcode+"' AND AV.TEST_ID=S.TEST_ID AND AV.TEST_ID=wq.TEST_ID AND wq.TEST_ID=S.TEST_ID AND av.TESTING_PARAMETER_CODE=mv.TESTING_PARAMETER_code and TYPE_OF_ASSET_CODE ='"+stype+"'  and av.TESTING_PARAMETER_code in('01','02','04','13','15','16','11','18') and case when s.test_code=1 and av.TESTING_PARAMETER_code=01 then 1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=02 then 1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=04 and av.TESTING_PARAMETER_VALUE>=6 and av.TESTING_PARAMETER_VALUE<=9 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=13 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=1.5 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=15 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=999 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=16 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=10 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=11 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=99 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=18 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=9 then  1 else 0 end in (0) and case when s.test_code=2 and av.TESTING_PARAMETER_code=01 and av.TESTING_PARAMETER_VALUE>0 and av.TESTING_PARAMETER_VALUE<=1609 then  1 else 0 end in (0) and case when s.test_code=2 and av.TESTING_PARAMETER_code=02 and av.TESTING_PARAMETER_VALUE>0 and av.TESTING_PARAMETER_VALUE<=24 then  1 else 0 end in (0) order by  h.HP_CODE ";
	}
//System.out.println("handpumps"+qry1);
	int count=1;
	ResultSet rs1=stmt1.executeQuery(qry1);
	while(rs1.next())
	{
	%>
<tr>
	<td class=rptvalue ><%=count++%></td>
	<td class=rptvalue  nowrap><%=habcode%></td>
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(1)%></td>
	<td class=rptvalue  ><%=rs1.getString(2)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(3)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString("Status")%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(4)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(5)%></td>
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(6)%></td>
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(7)%></td>
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(8)%></td> 
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(9)%></td> 
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(11)%></td> 
	<%if(mode!=null && mode.equals("3")){%>
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(12)%></td> 
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(13)%></td> 
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(14)%></td> 
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(15)%></td> 
	
	<%}%>
 </tr>

<%}}else{%>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" >
<tr align="center">
<td class=btext ><b>S.No</b></font></td>
 	<td class=btext><b>Habitation Code</b></font></td>
	<td class=btext><b>Asset Code </b></font></td>
	<td class=btext><b>Asset Name</b></font></td>
	<td class=btext><b>Asset Cost </b></font></td>
	<td class=btext><b>Source Code</b></font></td>
	<td class=btext><b>Location</b></font></td>
	<td class=btext><b>Population <BR>Benefited </b></font></td>
	<td class=btext><b>Asset Status </b></font></td>
	<td class=btext><b>Yield</b></font></td>
	<%if(mode!=null && mode.equals("3")){%>
	<td class=btext><b>Parameter Name</b></font></td>
	<td class=btext><b>Min. Value</b></font></td>
	<td class=btext><b>Max. Value</b></font></td>
	<td class=btext><b>Actual Value</b></font></td>
	<%}%>
	
</tr>
<% Statement stmt1=conn.createStatement();
Statement stmt2=conn.createStatement();
String tabName = "",colName="",tabName1 = "";

if (mode!=null && mode.equals("1"))
{
 qry1 = "select  a.ASSET_CODE,a.ASSET_NAME,a.ASSET_COST, h.source_code,h.LOCATION,a.POPU_BENEFITED, decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') as Status,h.yield  from rws_asset_mast_tbl a,RWS_SOURCE_TBL h where a.asset_code=h.asset_code and TYPE_OF_ASSET_CODE ='"+stype+"' and A.hab_code='"+habcode+"'";
	 }
else if(mode!=null && mode.equals("2"))
{
	
qry1 = "select  DISTINCT  a.ASSET_CODE,a.ASSET_NAME,a.ASSET_COST, h.source_code,h.LOCATION,a.POPU_BENEFITED, decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') as Status,h.yield   from rws_water_sample_collect_tbl s,RWS_WQ_TEST_RESULTS_TBL WQ ,RWS_SOURCE_TBL h,RWS_ASSET_MAST_TBL A where A.ASSET_CODE=H.ASSET_CODE AND s.source_code=h.SOURCE_CODE and A.hab_code='"+habcode+"' and TYPE_OF_ASSET_CODE ='"+stype+"' AND S.TEST_ID=WQ.TEST_ID";
	}
	else if(mode!=null && mode.equals("3"))
{
qry1="select distinct  A.ASSET_CODE,a.ASSET_NAME,a.ASSET_COST, h.source_code,h.LOCATION,a.POPU_BENEFITED,decode (Asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') as Status,h.yield,TESTING_PARAMETER_NAME,NVL(MIN_PERMISSIBLE_VALUE,'-'),NVL(MAX_PERMISSIBLE_VALUE,'-'),TESTING_PARAMETER_VALUE  from rws_water_sample_collect_tbl s ,rws_source_tbl h,RWS_ASSET_MAST_TBL A,RWS_WQ_TEST_RESULTS_LNK_TBL av, RWS_WQ_PARA_TEST_TBL mv,RWS_WQ_TEST_RESULTS_TBL WQ where A.ASSET_CODE=H.ASSET_CODE AND s.source_code=h.source_code and A.hab_code='"+habcode+"'AND AV.TEST_ID=S.TEST_ID AND AV.TEST_ID=wq.TEST_ID AND wq.TEST_ID=S.TEST_ID AND av.TESTING_PARAMETER_CODE=mv.TESTING_PARAMETER_code and TYPE_OF_ASSET_CODE ='"+stype+"'  and av.TESTING_PARAMETER_code in('01','02','04','13','15','16','11','18') and case when s.test_code=1 and av.TESTING_PARAMETER_code=01 then 1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=02 then 1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=04 and av.TESTING_PARAMETER_VALUE>=6 and av.TESTING_PARAMETER_VALUE<=9 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=13 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=1.5 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=15 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=999 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=16 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=10 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=11 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=99 then  1 else 0 end in (0) and case when s.test_code=1 and av.TESTING_PARAMETER_code=18 and av.TESTING_PARAMETER_VALUE>=0 and av.TESTING_PARAMETER_VALUE<=9 then  1 else 0 end in (0) and case when s.test_code=2 and av.TESTING_PARAMETER_code=01 and av.TESTING_PARAMETER_VALUE>0 and av.TESTING_PARAMETER_VALUE<=1609 then  1 else 0 end in (0) and case when s.test_code=2 and av.TESTING_PARAMETER_code=02 and av.TESTING_PARAMETER_VALUE>0 and av.TESTING_PARAMETER_VALUE<=24 then  1 else 0 end in (0) order by h.source_code ";
	}
//System.out.println("other"+qry1);
	int count=1;
	ResultSet rs1=stmt1.executeQuery(qry1);
	while(rs1.next())
	{
	%>
<tr>
	<td class=rptvalue ><%=count++%></td>
	<td class=rptvalue  nowrap><%=habcode%></td>
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(1)%></td>
	<td class=rptvalue  ><%=rs1.getString(2)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(3)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(4)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString(5)%></td>
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(6)%></td>
	<td class=rptvalue  nowrap><%=rs1.getString("Status")%></td>
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(8)%></td> 
	<%if(mode!=null && mode.equals("3")){%>
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(9)%></td> 
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(10)%></td> 
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(11)%></td> 
	<td class=rptvalue  nowrap align="center"><%=rs1.getString(12)%></td> 
	<%}%>
 </tr>
<%}
}
%>
</form>
</table>
