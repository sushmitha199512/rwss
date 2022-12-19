<%@page import="java.sql.*" %>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file = "conn.jsp" %>
<%@ include file = "header_rpt.jsp" %>
	<%
	try {
	Statement st1=null,st2 = null,st3=null,st4=null,st5=null,st6=null,st7,st8;
	ResultSet rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7,rs8=null;
	ResultSetMetaData rsm=null;
	int Count=0,Cnt,sno=0;
	//java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	RwsOffices rw=new RwsOffices(ds);
	String prgName,subprgName,aType,sentBy, sentTo,act_from,act_to,work_ID="",sentBy1, sentTo1;
	String query = null;
	String repCode=null;
	String pid=null;
	String wid=null;
	String atype = request.getParameter("assetType");
	if(atype!=null && !atype.equals("0"))
	{
		session.setAttribute("AType",atype);
	}
	else
		session.setAttribute("AType",null);


	repCode=request.getParameter("repname");
	if(repCode!=null && !repCode.equals("0"))
	{
		session.setAttribute("repCode",repCode);
	}
	else
		session.setAttribute("repCode",repCode);

	String fdate=request.getParameter("FDate");
	
	if(fdate!=null && !fdate.equals("0"))
	{
		session.setAttribute("fdate",fdate);
	}
	else
		session.setAttribute("repCode",repCode);

	String tdate=request.getParameter("TDate");
	
	if(tdate!=null && !tdate.equals("0"))
	{
		session.setAttribute("tdate",tdate);
	}
	else
		session.setAttribute("tdate",tdate);


	////System.out.println("pid  "+pid);
%>

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
<body bgcolor="#edf2f8"><%	//out.println(query);%>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr>
			<td align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
	
	
		<tr align="right">
			<td class="bwborder">
			
				<a href="./rws_proposal_pendency_rep_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home&nbsp;|&nbsp;</a>
		
			<a href="rws_proposal_pendency_rep_rpt_print.jsp"        target="_new">Print&nbsp;|&nbsp;</a>
			<a href="rws_proposal_pendency_rep_rpt_xsl.jsp"  target="_new">Excel</a>
				
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Pendency Status Details Report </font></td>
	</tr>
<tr><td valign=top>
<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	
</table>
<%	
	st1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	//SELECT distinct  at.TYPE_OF_ASSET_NAME,wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, rp.ENDORSED_BY, rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME  FROM RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e where wp.PROPOSAL_ID=rp.PROPOSAL_ID  and  wp.work_id is  null  and wp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE  order by wp.proposal_id ;
	if(repCode!=null && !repCode.equals("00") && !repCode.equals("0"))
	{
	query="SELECT distinct wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, rp.ENDORSED_BY, rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME,nvl(at.TYPE_OF_ASSET_NAME,'--'),pr.REP_NAME   FROM rws_publiC_rep_tbl pr, RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e WHERE  wp.PROPOSAL_ID=rp.PROPOSAL_ID and rp.rep_code='"+ repCode +"'  and at.TYPE_OF_ASSET_CODE=wp.TYPE_OF_ASSET   and rp.rep_code=pr.rep_code " ;
	}
	else
	{
		query="SELECT distinct wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, rp.ENDORSED_BY, rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME,nvl(at.TYPE_OF_ASSET_NAME,'--'), pr.REP_NAME  FROM rws_publiC_rep_tbl pr, RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e WHERE  wp.PROPOSAL_ID=rp.PROPOSAL_ID   and pr.rep_code=rp.rep_code  and at.TYPE_OF_ASSET_CODE=wp.TYPE_OF_ASSET and rp.rep_code=pr.rep_code " ;
	}
	String a1="  order by wp.proposal_id";
	if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0") )
	{
		query = query + " and to_char(rp.PREPARED_ON,'dd/mm/yyyy') >='" + fdate +"' and to_char(rp.PREPARED_ON,'dd/mm/yyyy') <= '"+ tdate +"' ";
		//query = query + " and rp.PREPARED_ON >= to_date('" + fdate +"','dd/mm/yyyy') and rp.PREPARED_ON <= to_date('" + tdate +"','dd/mm/yyyy') ";
		
	}

	if(request.getParameter("assetType")!=null)
	{
		query = query + " and  rp.TYPE_OF_ASSET = '"+ request.getParameter("assetType") + "'";
	}
	query = query + a1;
	
	//System.out.println("query    "+query);
	
	rs = st1.executeQuery(query);


	rs.last();
	 Count=rs.getRow();
	// //System.out.println("sadiq   "+Count);
	rs.beforeFirst();
	if(Count!=0){
	//rs.next();
	
	
	////System.out.println("atcode   "+atcode);
	////System.out.println("progcode   "+progcode);
	////System.out.println("subprgcode   "+subprogcode);

%>

<table border = 1 align=center cellspacing = 0 cellpadding = 0  width="100%" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	

<tr>
<% if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0"))
	{%>
	<tr >
		<td class="textborder" align="center" colspan="14">
			<font size=2>Proposals Between Dates: </font><font color=#F2A80D> <%=fdate %> </font>&nbsp;&nbsp; TO &nbsp;&nbsp;<font  color=#FE8C41> <%= tdate %></font></td>
	</tr>
	<%
	}
 String rCode=String.valueOf(session.getAttribute("repcode"));
	//System.out.println("rCode is  "+rCode);
	if(!rCode.equals("00") && rCode!=null)
		{
		%>
		
	<td align=center colspan=15 class="mystyle1">Represented By:&nbsp;&nbsp;<font color="red"><%=session.getAttribute("repname") %> </font></td></tr>
	<td class = btext >S.No</td>
	<% } else
		{	%><td class = btext >S.No</td>
			<td class = btext >Represented By</td>
		<%}%>

		
		
		<td class = btext >Representative Name</td>
		<td   class="btext">Asset Name</td>		
		<td   class="btext"> Proposal Id</td>
		<td   class="btext"> Work Name </td>
		<td   class="btext" > Proposal Date    </td>
		<td   class="btext"> Work Description </td>
		<td   class="btext">Pending Office At </td>
		<td   class="btext">Status</td>
		<td   nowrap class="btext">Endorsed By<br>/No <br>/Date </td>
		<!-- <td   class="btext">Endorsed No </td>
		<td   class="btext" >Endorsement Date</td> -->
		<td   class="btext" >Estimated Cost (Rs. in Lakhs)</td> 
		<!-- <td   class="btext">Recommenda- -tions</td> -->
		<td   class="btext">Prepared On <br>/By</td>
		<td   class="btext">Prepared At </td>
		
		<!--  <td   class="btext">No. of Habitations</td>  -->
		
	</tr>
	<tr>
	<%
	while(rs.next())
		{   sno++;
	if(!rCode.equals("00") && rCode!=null)
		{		%>
		
	 
	<td class = mystyle1 ><%= sno %></td>
	<% } else
		{	%><td class = mystyle1 ><%= sno %></td>
			<td  class="mystyle1"><%= rs.getString(29) %>  </td>
		<%}%>


	
		<!-- <td class = mystyle1 ><%= sno %></td>
		<td  class="mystyle1"><%= rs.getString(29) %>  </td> -->
		<td class="mystyle1"><%=rs.getString(27) %> </td>
		<td  class="mystyle1"><%= rs.getString(28) %>  </td>		
		<td class="mystyle1"><%=rs.getString(1) %>   </td>
		<td class="mystyle1"><%=rs.getString(2) %> </td>
		<td  class="mystyle1"><%=rs.getString(12) %> </td>
		<td  class="mystyle1"><%=rs.getString(16) %> </td>
		 <%
			 pid = rs.getString(1);
			 wid = rs.getString(19);
			 //System.out.println(" wid is   "+wid);
			 if(wid!=null)
			{
			st5=conn.createStatement();
			String q5="select et.TS_NO, et.TS_OFFICE from  RWS_NEW_EST_TBL et where et.work_id='"+wid+"'"  ;	 
			rs5=st5.executeQuery(q5);
			
			if(rs5.next())
				{%>
					<td  bgcolor=#FFFFFF> <font color=#CC00CC size=2> <%=rw.getOfficeName(rs5.getString(2),true) %> </td>
					<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3>Technical Sanction </td>

		<% }
				else
				{
					st6=conn.createStatement();
					String q6="select  ACTION_FROM, ACTION_TO from RWS_PROPOSAL_WORKFLOW_TBL pw where track_no=(sELECT max(track_no) from RWS_PROPOSAL_WORKFLOW_TBL pw where pw.proposal_id='"+ pid +"') and pw.proposal_id='"+pid+"'" ;
					rs6=st6.executeQuery(q6);
					rs6.next();
		%>
				<td  bgcolor=#FFFFFF> <font color=#CC00CC size=2> <%=rw.getOfficeName(rs6.getString(2),true) %> </td>
				<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3>Considered for Sanction</td>
				<% }
			}
			else
			{ %>
			<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3> <%=rw.getOfficeName(rs.getString(13),true) %>   </td>
			<td  bgcolor=#FFFFFF> <font color=#CC00CC size=3>Not Considered </td>

			<%}

			rs5.close();
			st5.close();
		%>

		<td  class="mystyle1"> <%=rs.getString(4) %> <br><%=rs.getString(5) %><br> <%= rs.getString(6)%>
		<!-- <td  class="mystyle1"> <%=rs.getString(5) %>  </td>
		<td  class="mystyle1" ><%= rs.getString(6)%> </td> -->
		<td  class="mystyle1" align=right><%=rs.getDouble(3)%> </td>
	<!-- 	<td  class="mystyle1"><%= rs.getString(7)%> </td> -->
		<td class="mystyle1"> <%=rs.getString(14)%> <br>  <%=rs.getString(15) %> </td>
		<td class="mystyle1"> <%=rw.getOfficeName(rs.getString(13),true) %>   </td>
		 <!-- <td  class="mystyle1"><%= rs.getString(9)%>  </td>  -->
		

	</tr>

	 
		
<%} 
		}
		
	%>
</table>
<%}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
try{			conn.close();}catch(Exception e){}
		}
		%>

</TD></TR>
</TABLE>
</body>
</html>
<%@ include file = "footer.jsp" %>