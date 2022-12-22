<%@ page import="nic.watersoft.masters.RwsMasterData"%>
<%@ include file="/commons/rws_prajapatham_header1.jsp"%>
<%@ include file="/commons/rws_prajapatham_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%StringBuffer requestUri=request.getRequestURL(); 
System.out.println("uri is "+requestUri);
%>

<%
	//System.out.println("***********************REPORT BEGINING***********************");
	String rDistrict, rConstituency, rMandal, rPanchayat, rVillage,rHabitation, distvalue, distname, conname, convalue, manvalue, manname, panvalue, panname, vilvalue, vilname = null;
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rVillage = request.getParameter("village");
	rHabitation = request.getParameter("habitation");
	String rProgramme = request.getParameter("programme");
	//System.out.println("habitation is "+rHabitation);
	rConstituency = request.getParameter("constituency");
	String districtName = (String)session.getAttribute("districtName");
	String mandalName = (String)session.getAttribute("mandalName");
	String panchayatName = (String)session.getAttribute("panchayatName");
	String villageName = (String)session.getAttribute("villageName");
	String constituencyName = (String)session.getAttribute("constituencyName");	
	
	String habName="";
	if(session.getAttribute("habName")!=null)
	habName = (String)session.getAttribute("habName");	
	if(request.getParameter("habname")!=null)
	habName=request.getParameter("habname");
	//System.out.println("got all");	
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	Statement stmt1 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	//int[] gcount = new int[8];
	//int[] gcount1= new int[8];
	//String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4","UI"};
try
{
%>
<html>
<body bgcolor="white" class="mystyle">
<form>
<table width="100%">
<tr><td>
<font size="1px"  color="blue">
<div align="left" >
<%if(districtName!=null && !districtName.equals("null")){ %>
District: &nbsp;&nbsp;<%= districtName %>&nbsp;&nbsp;&nbsp;
<%} %>
<%if(constituencyName!=null && !constituencyName.equals("null")) {%>
Constituency: &nbsp;&nbsp;<%= constituencyName %>&nbsp;&nbsp;&nbsp;
<%} %>
<%if(mandalName!=null && !mandalName.equals("null")) {%>
Mandal: &nbsp;&nbsp;<%= mandalName %>&nbsp;&nbsp;&nbsp;
<%} %>
<%if(panchayatName!=null && !panchayatName.equals("null")){ %>
Panchayat: &nbsp;&nbsp;<%= panchayatName %>&nbsp;&nbsp;&nbsp;
<%} %>
<%if(villageName!=null && !villageName.equals("null")){ %>
Village: &nbsp;&nbsp;<%= villageName %>&nbsp;&nbsp;&nbsp;
<%} %>
<%if(habName!=null && !habName.equals("null")){ %>
Habitation: &nbsp;&nbsp;<%= habName %>&nbsp;&nbsp;&nbsp;
<%} %>
</div></font>
</td></tr>
<tr><td align="right" colspan="20"><a href="/pred/home.jsp?loginMode=prajapatham">Home &nbsp;|</a>&nbsp;<a href="javascript:history.go(-1)">Back</a></td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "left">
<tr ><td colspan="50" align="center" class="rptLabel"> Habitation Details</td></tr>
<tr>
	<td class=rptLabel>CPWS</td>
	<td class="rptLabel">PWS</td>
	<td class="rptLabel" width="110">Direct Pumping</td>
	<td class="rptLabel" width="90">Bore Wells</td>
	<td class="rptLabel">Others</td>
	<td class="rptLabel" width="100">Any Other Schemes</td>
	<td class="rptLabel" width="100">Coverage Status</td>
</tr>

<%
	query2="SELECT  P.HAB_CODE, DECODE(PE.EXIST_CPWS ,'Y','Yes','N','')EXIST_CPWS,"+
		" DECODE(PE.EXIST_PWS ,'Y','Yes','N','')EXIST_PWS,"+  
		" DECODE(PE.EXIST_DIRECT_PUMPING ,'Y','Yes','N','')EXIST_DIRECT_PUMPING,"+
		" DECODE(PE.EXIST_BOREWELLS ,'Y','Yes','N','')EXIST_BOREWELLS,"+
		" DECODE(PE.EXIST_OTHERS ,'Y','Yes','N','')EXIST_OTHERS,"+
		" PE.OTHER_DETAILS,HD.COVERAGE_STATUS  FROM rws_habitation_directory_tbl HD,rws_prajapadam_tbl P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE WHERE P.HAB_CODE=PE.HAB_CODE "+
		" AND SUBSTR(P.HAB_CODE,1,2)='"+rDistrict+"'  and SUBSTR(P.HAB_CODE,6,2)='"+rMandal+"'  "+
		" and SUBSTR(P.HAB_CODE,1,16)='"+rHabitation+"' AND HD.HAB_CODE=P.HAB_CODE";
		System.out.println("query is "+query2);
		///
		//query2="SELECT DISTINCT d.Dcode,d.DNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI,count(*) from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2) group by d.dcode,d.dname"; 
       	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	//}
	rs2 = stmt1.executeQuery(query2);
	if(rs2.next())
	{%>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("EXIST_CPWS"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("EXIST_PWS"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("EXIST_DIRECT_PUMPING"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("EXIST_BOREWELLS"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("EXIST_OTHERS"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("OTHER_DETAILS"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("COVERAGE_STATUS"))%></td>
	
	<%} %>
		
	
</tr>
<tr><td colspan="50">&nbsp;</td></tr>
<tr>
<td colspan="50">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr>
<td class=rptLabel colspan="15" align="center">Work Details</td>
</tr>
<tr>
<td class=rptLabel rowspan="1">S.No</td>
<td class=rptLabel rowspan="1"  width="550" align="center">Name Of The Work</td>


 
 <td class="rptLabel" width="80">Estimated Cost (Rs.In Lakhs)</td>
 <td class="rptLabel">Programme</td>
 <td class="rptLabel" width="120">Admin Sanction Ref.No</td>
 <td class="rptLabel">Admin Sanction Date</td>
 <td class="rptLabel">Sanctioned At</td>
 <td class="rptLabel">Date Of Grounding</td>
 <td class="rptLabel">Date Of Completion</td>
 <td class="rptLabel">Exp. Incurred Upto The Prev.Month(Rs.in Lakhs)</td>
 <td class="rptLabel">Exp. Incurred During The Month(Rs.in Lakhs)</td>
 <td class="rptLabel">Total Expenditure(Rs.in Lakhs)</td>
 <td class="rptLabel">Value Of Workdone by But Not Paid (Rs.in Lakhs)</td>
 <td class="rptLabel">Physical Stage Of Work</td>
 <td class="rptLabel">Remarks</td>
</tr>
<% //System.out.println("printed labels");%>
<%
//if(rDistrict != null && rDistrict.equals("00"))
	//{
			
		////
		if(rProgramme==null || rProgramme.equals("ALL"))
		{
		query2="SELECT P.WORK_ID ,UPPER(P.WORK_NAME)WORK_NAME ,P.DCODE,P.MCODE,P.HAB_CODE  ,P.WORK_NAME  ,P.ESTIMATE_COST ,"+  
		" P.PROGRAMME_CODE   ,PR.PROGRAMME_NAME,P.SUBPROGRAMME_CODE    ,SPR.SUBPROGRAMME_NAME,P.ADMN_SANC_NO,"+    
		" to_char(P.ADMN_SANC_DATE,'DD-MON-YY')ADMN_SANC_DATE ,decode(SANCTIONED_AT,'d','District','D','District','S','State','s','state')SANCTIONED_AT,to_char(P.GROUND_DATE,'DD-MON-YY')GROUND_DATE     ,to_char(P.COMPLETION_DATE,'DD-MON-YY')COMPLETION_DATE   ,P.EXP_UPTO_THE_PRE_MONTH , EXP_DUR_THE_MONTH  ,EXP_TO_BE_INCURRED, "+    
		" UPPER(PHY_STAGE_OF_WORK)PHY_STAGE_OF_WORK,UPPER(P.REMARKS)REMARKS,"+
		
		" V.VCODE,V.VNAME, "+
		
		" DECODE(PE.EXIST_CPWS ,'Y','Yes','N','Not Exists')EXIST_CPWS,"+
		" DECODE(PE.EXIST_PWS ,'Y','Yes','N','Not Exists')EXIST_PWS,"+  
		" DECODE(PE.EXIST_DIRECT_PUMPING ,'Y','Yes','N','')EXIST_DIRECT_PUMPING,"+
		" DECODE(PE.EXIST_BOREWELLS ,'Y','Yes','N','')EXIST_BOREWELLS,"+
		" DECODE(PE.EXIST_OTHERS ,'Y','Yes','N','')EXIST_OTHERS,"+
		" PE.OTHER_DETAILS  FROM rws_prajapadam_tbl P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,RWS_PROGRAMME_TBL PR,RWS_SUBPROGRAMME_TBL SPR,RWS_VILLAGE_TBL V WHERE P.HAB_CODE=PE.HAB_CODE AND PR.PROGRAMME_CODE=P.PROGRAMME_CODE AND P.PROGRAMME_CODE=SPR.PROGRAMME_CODE(+) AND P.SUBPROGRAMME_CODE=SPR.SUBPROGRAMME_CODE(+)"+
		" AND SUBSTR(P.HAB_CODE,1,2)='"+rDistrict+"'  and SUBSTR(P.HAB_CODE,6,2)='"+rMandal+"' "+
		" AND SUBSTR(P.HAB_CODE,1,2)=V.DCODE AND  SUBSTR(P.HAB_CODE,6,2)=V.MCODE AND SUBSTR(P.HAB_CODE,13,2)=V.PCODE AND SUBSTR(P.HAB_CODE,8,3)=V.VCODE"+
		" and SUBSTR(P.HAB_CODE,1,16)='"+rHabitation+"' order by P.WORK_ID";
		}else
		{
		query2="SELECT P.WORK_ID ,UPPER(P.WORK_NAME)WORK_NAME ,P.DCODE,P.MCODE,P.HAB_CODE  ,P.WORK_NAME  ,P.ESTIMATE_COST ,"+  
		" P.PROGRAMME_CODE   ,PR.PROGRAMME_NAME,P.SUBPROGRAMME_CODE    ,SPR.SUBPROGRAMME_NAME,P.ADMN_SANC_NO,"+    
		" to_char(P.ADMN_SANC_DATE,'DD-MON-YY')ADMN_SANC_DATE ,decode(SANCTIONED_AT,'d','District','D','District','S','State','s','state')SANCTIONED_AT,to_char(P.GROUND_DATE,'DD-MON-YY')GROUND_DATE     ,to_char(P.COMPLETION_DATE,'DD-MON-YY')COMPLETION_DATE   ,P.EXP_UPTO_THE_PRE_MONTH , EXP_DUR_THE_MONTH  ,EXP_TO_BE_INCURRED, "+    
		" UPPER(PHY_STAGE_OF_WORK)PHY_STAGE_OF_WORK,UPPER(P.REMARKS)REMARKS,"+
		
		" V.VCODE,V.VNAME, "+
		
		" DECODE(PE.EXIST_CPWS ,'Y','Yes','N','Not Exists')EXIST_CPWS,"+
		" DECODE(PE.EXIST_PWS ,'Y','Yes','N','Not Exists')EXIST_PWS,"+  
		" DECODE(PE.EXIST_DIRECT_PUMPING ,'Y','Yes','N','')EXIST_DIRECT_PUMPING,"+
		" DECODE(PE.EXIST_BOREWELLS ,'Y','Yes','N','')EXIST_BOREWELLS,"+
		" DECODE(PE.EXIST_OTHERS ,'Y','Yes','N','')EXIST_OTHERS,"+
		" PE.OTHER_DETAILS  FROM rws_prajapadam_tbl P,RWS_PRAJAPADAM_EXIST_SCH_TBL PE,RWS_PROGRAMME_TBL PR,RWS_SUBPROGRAMME_TBL SPR,RWS_VILLAGE_TBL V WHERE P.HAB_CODE=PE.HAB_CODE AND PR.PROGRAMME_CODE=P.PROGRAMME_CODE AND P.PROGRAMME_CODE=SPR.PROGRAMME_CODE(+) AND P.SUBPROGRAMME_CODE=SPR.SUBPROGRAMME_CODE(+)"+
		" AND SUBSTR(P.HAB_CODE,1,2)='"+rDistrict+"'  and SUBSTR(P.HAB_CODE,6,2)='"+rMandal+"' "+
		" AND SUBSTR(P.HAB_CODE,1,2)=V.DCODE AND  SUBSTR(P.HAB_CODE,6,2)=V.MCODE AND SUBSTR(P.HAB_CODE,13,2)=V.PCODE AND SUBSTR(P.HAB_CODE,8,3)=V.VCODE"+
		" and SUBSTR(P.HAB_CODE,1,16)='"+rHabitation+"' and p.programme_code='"+rProgramme+"' order by P.WORK_ID";
		}
		
		//System.out.println("query is "+query2);
		///
		//query2="SELECT DISTINCT d.Dcode,d.DNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI,count(*) from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2) group by d.dcode,d.dname"; 
       	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	//}
	rs2 = stmt1.executeQuery(query2);
	while(rs2.next())
	{
		
		++ slno;
		
			
%>		<tr>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue ><%=rs2.getString("WORK_NAME")%><!-- <%=rs2.getString("WORK_ID")%>--></td>
		
		
		
		<td class=rptValue><%=rs2.getFloat("ESTIMATE_COST")%></td>
		<td class=rptValue width="120"><%=rs2.getString("PROGRAMME_NAME")+"-"%>
		<br><%=RwsMasterData.format(rs2.getString("SUBPROGRAMME_NAME"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("ADMN_SANC_NO"))%></td>
		<td class=rptValue width="50"><%=RwsMasterData.format(rs2.getString("ADMN_SANC_DATE"))%></td>
		<td class=rptValue width="50"><%=RwsMasterData.format(rs2.getString("SANCTIONED_AT"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("GROUND_DATE"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("COMPLETION_DATE"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("EXP_UPTO_THE_PRE_MONTH"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("EXP_DUR_THE_MONTH"))%></td>
		<td class=rptValue><%=rs2.getFloat("EXP_DUR_THE_MONTH")+rs2.getFloat("EXP_UPTO_THE_PRE_MONTH")+""%></td>
		
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("EXP_TO_BE_INCURRED"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("PHY_STAGE_OF_WORK"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("REMARKS"))%></td>
		</tr>





	<%}if(slno==0){%><tr><td class="rptValue" colspan="16" align="center" >No Records</td></tr><%} %>
	
<%}
	
catch(Exception e)
{
//System.out.println("Exception is "+e);
	e.printStackTrace();
}
finally
{
	
	if(conn!=null)
	conn.close();
}
%>
</table>
</table>



</form>
</body>
</html>
