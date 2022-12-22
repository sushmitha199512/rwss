<%@ page import="nic.watersoft.masters.RwsMasterData"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%StringBuffer requestUri=request.getRequestURL(); 
////System.out.println("uri is "+requestUri);
%>

<%
	////System.out.println("***********************REPORT BEGINING***********************");
	String rDistrict, rConstituency, rMandal, rPanchayat, rVillage,rHabitation, distvalue, distname, conname=null, convalue, manvalue, manname, panvalue, panname, vilvalue, vilname = null;
	rDistrict = request.getParameter("district");
	conname = request.getParameter("conname");
	//rPanchayat = request.getParameter("panchayat");
	//rVillage = request.getParameter("village");
	//rHabitation = request.getParameter("habitation");
	//String rProgramme = request.getParameter("programme");
	////System.out.println("habitation is "+rHabitation);
	rConstituency = request.getParameter("constituency");
	String districtName = (String)session.getAttribute("districtName");
	//String mandalName = (String)session.getAttribute("mandalName");
	//String panchayatName = (String)session.getAttribute("panchayatName");
	//String villageName = (String)session.getAttribute("villageName");
	String constituencyName = (String)session.getAttribute("constituencyName");	
	
	String habName="";
	if(session.getAttribute("habName")!=null)
	habName = (String)session.getAttribute("habName");	
	if(request.getParameter("habname")!=null)
	habName=request.getParameter("habname");
	////System.out.println("got all");	
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null;
	ResultSet rs2 = null,rs3=null;
	Statement stmt1 = null,stmt2=null;
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
<%if(constituencyName!=null && !constituencyName.equals("null") && conname==null) {%>
Constituency: &nbsp;&nbsp;<%=constituencyName%>&nbsp;&nbsp;&nbsp;
<%}
else if(constituencyName!=null && !constituencyName.equals("null") && conname!=null) {%>
Constituency: &nbsp;&nbsp;<%=conname%>&nbsp;&nbsp;&nbsp;
<%}%>

</div></font>
</td></tr>
<tr><td align="right" colspan="20"><a href="/pred/home.jsp?">Home &nbsp;|</a>&nbsp;<a href="javascript:history.go(-1)">Back</a></td></tr>
</table>



<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr>
<td class=rptLabel colspan="25" align="center">Work Details</td>
</tr>
<tr>
<td class=rptLabel colspan="25" align="center">Administrative Sanction Details</td>
</tr>
<tr>
<td class=rptLabel rowspan="1">S.No</td>
<td class=rptLabel colspan="5"  width="550" align="center">Name Of The Work</td>
<td class="rptLabel">Type Of Asset</td>
 <td class="rptLabel" width="80">Programme / SubProgramme</td>
 <td class="rptLabel" width="120">Estimate Cost<br>In Lakhs</td>
 <td class="rptLabel">Prepared By</td>
 <td class="rptLabel">Prepared On</td>
 <td class="rptLabel">Sanctioned At</td>
 <td class="rptLabel">Sanction Amount<br>In Lakhs</td>
 <td class="rptLabel">Prog Name(more than one prog)</td>
 <td class="rptLabel">Sanction Amt(more than one prog)</td>
 <td class="rptLabel">Admin No</td>
 <td class="rptLabel">Admin Date</td>
 <td class="rptLabel">Goms No</td>
 <td class="rptLabel">Remarks</td>


</tr>
<%

		query2="select DISTINCT A.*,DECODE (A.STATE_CENTRAL ,'D','DISTRICT','S','STATE','d','DISTRICT','s','STATE')AS SANC_AT,P.PROGRAMME_NAME,SP.SUBPROGRAMME_NAME,R.TYPE_OF_ASSET_NAME from RWS_WORK_ADMN_TBL A,RWS_PROGRAMME_TBL P,RWS_SUBPROGRAMME_TBL SP,RWS_ASSET_TYPE_TBL R where A.TYPE_OF_ASSET=R.TYPE_OF_ASSET_CODE AND A.PROGRAMME_CODE=P.PROGRAMME_CODE AND SP.PROGRAMME_CODE=A.PROGRAMME_CODE AND SP.SUBPROGRAMME_CODE(+)=A.SUBPROGRAMME_CODE and substr(A.office_code,2,2)='"+rDistrict+"' and substr(A.office_code,4,1)='"+rConstituency+"'";
		
		
       	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	 	stmt2 = conn.createStatement();
	rs2 = stmt1.executeQuery(query2);
	while(rs2.next())
	{
		
		++ slno;
		
			
%>		<tr>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue colspan=5><%=RwsMasterData.format(rs2.getString("WORK_NAME"))%><!-- <%=rs2.getString("WORK_ID")%>--></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("TYPE_OF_ASSET_NAME"))%></td>
		<td class=rptValue width="120"><%=RwsMasterData.format(rs2.getString("PROGRAMME_NAME"))+"-"%>
		<br><%=RwsMasterData.format(rs2.getString("SUBPROGRAMME_NAME"))%></td>
		<td class=rptValue><%=rs2.getFloat("ESTIMATE_COST")%></td>
		<td class=rptValue width="50"><%=RwsMasterData.format(rs2.getString("PREPARED_BY"))%></td>
		<td class=rptValue width="50"><%=rs2.getString("PREPARED_ON")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("SANC_AT"))%></td>
		<td class=rptValue><%=rs2.getFloat("SANCTION_AMOUNT")%></td>
		<%String ary="select programme_name,sanction_amount from rws_work_admn_prog_lnk_tbl  a,rws_programme_tbl p where a.programme_code=p.programme_code  and work_id='"+rs2.getString("work_id")+"' ";
         //System.out.println("ary:"+ary);
		 rs3=stmt2.executeQuery(ary);
		 if(rs3.next())
		{%>
		<td class=rptValue ><%=rs3.getString(1)%></td>
		<td class=rptValue ><%=rs3.getString(2)%></td>
		<%}
		else
		{%>
          <td class=rptValue >-</td>
		  <td class=rptValue >-</td>

		<%}	%>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("ADMIN_NO"))%></td>
		<td class=rptValue><%=rs2.getString("ADMIN_DATE")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("GOMS_NO"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("REMARKS"))%></td>
		</tr>
	<%}if(slno==0){%><tr><td class="rptValue" colspan="25" align="center" >--</td></tr><%} %>
	<tr><td colspan="17" >&nbsp;</td></tr>
	
	<!-- REVISED ADMIN SANCTION DETAILS -->
	<tr>
<td class=rptLabel colspan="18" align="center">Revised Administrative Sanction Details</td>
</tr>
<tr>
<% slno=0; %>
<td class=rptLabel rowspan="1">S.No</td>
<td class=rptLabel rowspan="1" colspan=6 width="550" align="center">Name Of The Work</td>
<td class="rptLabel">Type Of Asset</td>
 <td class="rptLabel" width="80">Programme / SubProgramme</td>
 <td class="rptLabel" width="120">Estimate Cost<br>In Lakhs</td>
 <td class="rptLabel">Prepared By</td>
 <td class="rptLabel">Prepared On</td>
 <td class="rptLabel">Sanctioned At</td>
 <td class="rptLabel">Sanction Amount<br>In Lakhs</td>
<td class="rptLabel">Admin No</td>
<td class="rptLabel">Admin Date</td>
<td class="rptLabel">Remarks</td>


</tr>

<%

		
		/*query2="select RA.*,DECODE(RA.STATE_CENTRAL,'D','DISTRICT','S','STATE','d','DISTRICT','s','STATE')AS SANC_AT,P.PROGRAMME_NAME,SP.SUBPROGRAMME_NAME from RWS_REVISED_ADM_SANC_TBL  RA,RWS_PROGRAMME_TBL P,RWS_SUBPROGRAMME_TBL SP where RA.work_id in(select work_id from RWS_REV_ADM_SANC_HAB_LNK_TBL  where hab_code = '"+rHabitation+"') AND RA.PROGRAMME_CODE=P.PROGRAMME_CODE AND SP.PROGRAMME_CODE=RA.PROGRAMME_CODE AND SP.SUBPROGRAMME_CODE(+)=RA.SUBPROGRAMME_CODE";*/
       
	    query2="select DISTINCT RA.*,DECODE(RA.STATE_CENTRAL,'D','DISTRICT','S','STATE','d','DISTRICT','s','STATE')AS SANC_AT,P.PROGRAMME_NAME,SP.SUBPROGRAMME_NAME,R.TYPE_OF_ASSET_NAME from RWS_REVISED_ADM_SANC_TBL  RA,RWS_PROGRAMME_TBL P,RWS_SUBPROGRAMME_TBL SP,RWS_ASSET_TYPE_TBL R,RWS_WORK_ADMN_TBL A  where A.WORK_ID=RA.WORK_ID AND RA.TYPE_OF_ASSET=R.TYPE_OF_ASSET_CODE AND RA.PROGRAMME_CODE=P.PROGRAMME_CODE AND SP.PROGRAMME_CODE=RA.PROGRAMME_CODE AND SP.SUBPROGRAMME_CODE(+)=RA.SUBPROGRAMME_CODE and substr(RA.office_code,2,2)='"+rDistrict+"' and substr(RA.office_code,4,1)='"+rConstituency+"'";

		
		
       	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	
	rs2 = stmt1.executeQuery(query2);
	while(rs2.next())
	{
		
		++ slno;
		
			
%>		<tr>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue colspan="6" ><%=RwsMasterData.format(rs2.getString("WORK_NAME"))%><!-- <%=rs2.getString("WORK_ID")%>--></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("TYPE_OF_ASSET_NAME"))%></td>
		<td class=rptValue width="120"><%=RwsMasterData.format(rs2.getString("PROGRAMME_NAME"))+"-"%>
		<br><%=RwsMasterData.format(rs2.getString("SUBPROGRAMME_NAME"))%></td>
		<td class=rptValue><%=rs2.getFloat("ESTIMATE_COST")%></td>
		<td class=rptValue width="50"><%=RwsMasterData.format(rs2.getString("PREPARED_BY"))%></td>
		<td class=rptValue width="50"><%=rs2.getDate("PREPARED_ON")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("SANC_AT"))%></td>
		<td class=rptValue><%=rs2.getFloat("REV_SANCTION_AMOUNT")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("REV_ADMIN_NO"))%></td>
		<td class=rptValue><%=rs2.getDate("REV_ADMIN_DATE")%></td>
		
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("REMARKS"))%></td>
		</tr>
	<%}if(slno==0){%><tr><td class="rptValue" colspan="17" align="center" >--</td></tr><%} %>
	
	<!-- END OF REVISED ADMIN SANCTION DETAILS -->
	
	<!-- ESTIMATE DETAILS -->
	<tr>
	<% slno=0; %>
<td class=rptLabel colspan="18" align="center">Estimate Details</td>
</tr>
<tr>
<td class=rptLabel rowspan="1">S.No</td>
<td class=rptLabel rowspan="1"  width="550" align="center">Name Of The Work</td>
<td class="rptLabel" width="120">Type Of Asset</td>
<td class="rptLabel" width="80">Source Code</td>
<td class="rptLabel">Financial Year</td>
<td class="rptLabel">Total Components</td>
 <td class="rptLabel">Estimate Amount<br>In Lakhs</td>
 <td class="rptLabel">Sanctioned Amount<br>In Lakhs</td>
 <td class="rptLabel">TS Office</td>
 <td class="rptLabel">TS Given By</td>
<td class="rptLabel">TS No</td>
<td class="rptLabel">TS Date</td>
<td class="rptLabel">TS Amount</td>
<td class="rptLabel">Prepared By</td>
<td class="rptLabel">Prepared On</td>
<td class="rptLabel">SSR Year</td>
<td class="rptLabel">Remarks</td>




</tr>

<%

		
		/*query2="select E.*,A.WORK_NAME from RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL A where E.work_id in(select work_id from RWS_EST_NEW_HAB_LNK_TBL where hab_code = '"+rHabitation+"') AND E.WORK_ID=A.WORK_ID(+)";*/

       query2="select DISTINCT E.*,A.WORK_NAME,R.TYPE_OF_ASSET_NAME from RWS_NEW_EST_TBL E,RWS_WORK_ADMN_TBL A,RWS_ASSET_TYPE_TBL R where  A.TYPE_OF_ASSET=E.TYPE_OF_ASSET_CODE AND A.TYPE_OF_ASSET=R.TYPE_OF_ASSET_CODE AND E.WORK_ID=A.WORK_ID and  substr(e.office_code,2,2)='"+rDistrict+"' and substr(e.office_code,4,1)='"+rConstituency+"'";
		
		////System.out.println("query is "+query2);
		
       	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	//}
	rs2 = stmt1.executeQuery(query2);
	while(rs2.next())
	{
		//out.println(rs2.getString("TYPE_OF_ASSET"));
		++ slno;
		
			
%>		<tr>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("WORK_NAME"))%></td>
		<td class=rptValue width="120"><%=RwsMasterData.format(rs2.getString("TYPE_OF_ASSET_NAME"))%></td>
		<td class=rptValue width="80"><%=rs2.getString("SOURCE_CODE")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("FINANCIAL_YEAR"))%></td>
		<td class=rptValue><%=rs2.getString("TOTAL_COMPONENTS")%></td>
		<td class=rptValue><%=rs2.getFloat("ESTIMATE_AMOUNT")%></td>
		<td class=rptValue><%=rs2.getFloat("SANCTIONED_AMOUNT")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("TS_OFFICE"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("TS_GIVEN_BY"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("TS_NO"))%></td>
		<td class=rptValue><%=rs2.getString("TS_DATE")%></td>
		<td class=rptValue><%=rs2.getFloat("TS_AMOUNT")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("PREPARED_BY"))%></td>
		<td class=rptValue><%=rs2.getString("PREPARED_ON")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("SSR_YEAR"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("REMARKS"))%></td>
		</tr>
	<%}if(slno==0){%><tr><td class="rptValue" colspan="17" align="center" >--</td></tr><%} %>
	
	<!-- END OF ESTIMATE DETAILS -->
	
	<!-- REVISED ESTIMATE DETAILS -->
	<tr>
	<% slno=0; %>
<td class=rptLabel colspan="18" align="center">Revised Estimate Details</td>
</tr>
<tr>
<td class=rptLabel rowspan="1">S.No</td>
<td class=rptLabel rowspan="1"  width="550" align="center">Name Of The Work</td>
<td class="rptLabel" width="120">Type Of Asset</td>
<td class="rptLabel" width="80">Source Code</td>
<td class="rptLabel">Financial Year</td>
<td class="rptLabel">GOMS No</td>
<td class="rptLabel">Estimate Amount<br>In Lakhs</td>
 <td class="rptLabel">Sanctioned Amount<br>In Lakhs</td>
 <td class="rptLabel">TS Office</td>
 <td class="rptLabel">TS Given By</td>
<td class="rptLabel">TS No</td>
<td class="rptLabel">TS Date</td>
<td class="rptLabel">TS Amount</td>
<td class="rptLabel">Prepared By</td>
<td class="rptLabel">Prepared On</td>
<td class="rptLabel">SSR Year</td>
<td class="rptLabel">Remarks</td>

</tr>

<%
	
/*query2="select RE.*,A.WORK_NAME,A.TYPE_OF_ASSET,A.GOMS_NO from RWS_NEW_REVISED_EST_TBL RE,RWS_WORK_ADMN_TBL A where RE.work_id in(select work_id from RWS_REV_ADM_SANC_HAB_LNK_TBL where hab_code = '"+rHabitation+"') AND RE.WORK_ID=A.WORK_ID(+)";*/

/*query2="select DISTINCT RE.*,A.WORK_NAME,R.TYPE_OF_ASSET_NAME,A.GOMS_NO from RWS_NEW_REVISED_EST_TBL RE,RWS_WORK_ADMN_TBL A,RWS_ASSET_TYPE_TBL R where A.TYPE_OF_ASSET=R.TYPE_OF_ASSET_CODE AND  RE.WORK_ID=A.WORK_ID(+) and substr(RE.office_code,2,2)='"+rDistrict+"' and substr(RE.office_code,4,1)='"+rConstituency+"'";*/

query2="select DISTINCT RE.*,A.WORK_NAME,R.TYPE_OF_ASSET_NAME,A.GOMS_NO from RWS_NEW_REVISED_EST_TBL RE,RWS_WORK_ADMN_TBL A,RWS_ASSET_TYPE_TBL R,rws_new_est_tbl e where A.TYPE_OF_ASSET=R.TYPE_OF_ASSET_CODE AND A.WORK_ID = e.WORK_ID and e.WORK_ID=re.work_id AND substr (RE.office_code,2,2) ='"+rDistrict+"' and substr(RE.office_code,4,1)='"+rConstituency+"'";


		
		
       	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	//}
	rs2 = stmt1.executeQuery(query2);
	while(rs2.next())
	{
		
		++ slno;
		
			
%>		<tr>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("WORK_NAME"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("TYPE_OF_ASSET_NAME"))%></td>
		<td class=rptValue ><%=rs2.getString("SOURCE_CODE")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("FINANCIAL_YEAR"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("GOMS_NO"))%></td>
		<td class=rptValue><%=rs2.getFloat("REV_ESTIMATE_AMOUNT")%></td>
		<td class=rptValue><%=rs2.getFloat("REV_SANCTIONED_AMOUNT")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("REV_TS_OFFICE"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("REV_TS_GIVEN_BY"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("REV_TS_NO"))%></td>
		<td class=rptValue><%=rs2.getString("REV_TS_DATE")%></td>
		<td class=rptValue><%=rs2.getFloat("TS_AMOUNT")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("PREPARED_BY"))%></td>
		<td class=rptValue><%=rs2.getString("PREPARED_ON")%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("SSR_YEAR"))%></td>
		<td class=rptValue><%=RwsMasterData.format(rs2.getString("REMARKS"))%></td>
		</tr>
	<%}if(slno==0){%><tr><td class="rptValue" colspan="18" align="center" >--</td></tr><%} %>
	
	<!-- END OF REVISED ESTIMATE DETAILS -->
	
<%}
	
catch(Exception e)
{
////System.out.println("Exception is "+e);
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
