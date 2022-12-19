<%@page import="java.sql.*" %>
<%@ page import ="nic.watersoft.commons.*,java.util.*"%>
<%@ include file = "conn.jsp" %>


	<%
	try {
	Statement st1=null,st2 = null,st3=null,st4=null,st5=null,st6=null,st7,st8;
	ResultSet rs1 = null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7,rs8=null;
	ResultSetMetaData rsm=null;
	int Count=0,Cnt,sno=0;
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	RwsOffices rw=new RwsOffices(ds);
	String prgName,subprgName,aType,sentBy, sentTo,act_from,act_to,work_ID="",sentBy1, sentTo1;
	String query = null;
	String repCode=null;
	String pid=null;
	String wid=null;
	//repCode=request.getParameter("repname");
	 repCode=String.valueOf(session.getAttribute("repcode"));
	 //System.out.println("pid  "+repCode);
	 String fdate=String.valueOf(session.getAttribute("fdate"));
	  //System.out.println("fdate  "+fdate);
	String tdate=String.valueOf(session.getAttribute("tdate"));
	 //System.out.println("tdate   "+tdate);
	
%>

<html>
<head>
<title>WaterSoft</title>

<!-- <link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css"> -->
</head>
<body topmargin="0">

<p width="100%" align="center"><b><font face="Verdana" size="2">WaterSoft<br>
Department Of Panchayat Raj and Engineering <br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</font><br>
<br>
<table align="center" width="100%">
	<tr>
		<td align="center" class="mystyle1"><font color="navy"><h5>Pendency Status Details Report</h3></font></td>
	</tr>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>

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
.btest1
{
	border-width:1;
	color:black;
	font-weight:bold;
	font-family:verdana;
	font-size:7pt;
}

</style>

</head>
<body>
<%	
	st1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	//SELECT distinct  at.TYPE_OF_ASSET_NAME,wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, rp.ENDORSED_BY, rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME  FROM RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e where wp.PROPOSAL_ID=rp.PROPOSAL_ID  and  wp.work_id is  null  and wp.TYPE_OF_ASSET=at.TYPE_OF_ASSET_CODE  order by wp.proposal_id ;
	if(repCode!=null && !repCode.equals("00") && !repCode.equals("0"))
	{
	query="SELECT distinct wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, rp.ENDORSED_BY, rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME,nvl(at.TYPE_OF_ASSET_NAME,'--'),pr.REP_NAME   FROM rws_publiC_rep_tbl pr, RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e WHERE  wp.PROPOSAL_ID=rp.PROPOSAL_ID and rp.rep_code='"+ repCode +"'  and at.TYPE_OF_ASSET_CODE=wp.TYPE_OF_ASSET   and rp.rep_code=pr.rep_code " ;
	}
	else
	{
		query="SELECT distinct wp.PROPOSAL_ID, wp.PROPOSAL_NAME, wp.ESTIMATE_COST, rp.ENDORSED_BY, rp.ENDORSEMENT_NO, to_char(rp.ENDORSEMENT_DATE,'dd/mm/yyyy'), nvl(rp.RECOMMENDATIONS,'---'), wp.TYPE_OF_ASSET, wp.NO_OF_HABS, wp.PROGRAMME_CODE, wp.SUBPROGRAMME_CODE , to_char(rp.REP_DATE,'dd/mm/yyyy'), wp.office_code, to_char(wp.PREPARED_ON,'dd/mm/yyyy'), rp.prepared_by,  nvl(rp.description,'--'), rp.MINISTER_FOR, rp.OTHERS, wp.WORK_ID, wp.ADMIN_NO, to_char(wp.ADMIN_DATE,'dd/mm/yyyy'), wp.SANCTION_AMOUNT, wp.GOMS_NO, decode(wp.STATE_CENTRAL,'C','Center','S','State',null,'--'), wp.ADMIN_SANC_AUTH, rp.REP_CODE, rp.REP_NAME,nvl(at.TYPE_OF_ASSET_NAME,'--'), pr.REP_NAME  FROM rws_publiC_rep_tbl pr, RWS_ASSET_TYPE_TBL at, rws_work_proposal_tbl wp, rws_rep_proposal_tbl rp,RWS_OFFICE_TBL o,rws_employee_tbl e WHERE  wp.PROPOSAL_ID=rp.PROPOSAL_ID   and pr.rep_code=rp.rep_code  and at.TYPE_OF_ASSET_CODE=wp.TYPE_OF_ASSET   and rp.rep_code=pr.rep_code " ;
	}
	String a1="  order by wp.proposal_id";
	if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0") )
	{
		query = query + " and to_char(rp.PREPARED_ON,'dd/mm/yyyy') >='" + fdate +"' and to_char(rp.PREPARED_ON,'dd/mm/yyyy') <= '"+ tdate +"' ";
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

<% if(fdate!=null && !fdate.equals("0") && tdate!=null && !tdate.equals("0") )
	{%>
	<tr >
		<td class="textborder" align="center" colspan="14">
			<b>Proposals Between Dates:  <%=fdate %> </font>&nbsp;&nbsp; TO &nbsp;&nbsp; <%= tdate %></b></td>
	</tr>
	<%
	}%>
<tr>	
 <% String rCode=String.valueOf(session.getAttribute("repcode"));
	//System.out.println("rCode is  "+rCode);
	if(!rCode.equals("00") && rCode!=null)
		{
		%>
	
	<td align=center colspan=14 class="mystyle1"><B>Represented By:&nbsp;&nbsp;<font color="red"><%=session.getAttribute("repname") %> </font></td></tr>
	<td ><B>S.No</td>
	<% } else
		{	%><td class = btext ><B>S.No</td>
			<td class = btext ><B>Represented By</td>
		<%}%>

		
		
		<td class = btext ><B>Representative Name</td>
		<td   class="btext"><B>Asset Name</td>		
		<td   class="btext"><B> Proposal Id</td>
		<td   class="btext"> <B>Work Name </td>
		<td   class="btext" ><B> Proposal Date    </td>
		<td   class="btext"><B> Work Description </td>
		<td   class="btext"><B>Pending Office At </td>
		<td   class="btext"><B>Status</td>
		<td   nowrap class="btext"><B>Endorsed By<br>/No <br>/Date </td>
		<!-- <td   class="btext">Endorsed No </td>
		<td   class="btext" >Endorsement Date</td> -->
		<td   class="btext" ><B>Estimated Cost (Rs. in Lakhs)</td> 
		<!-- <td   class="btext">Recommenda- -tions</td> -->
		<td   class="btext"><B>Prepared On <br>/By</td>
		<td   class="btext"><B>Prepared At </td>
		
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
					<td class="mystyle1"><B> <%=rw.getOfficeName(rs5.getString(2),true) %> </td>
					<td class="mystyle1"><B>Technical Sanction </td>

		<% }
				else
				{
					st6=conn.createStatement();
					String q6="select  ACTION_FROM, ACTION_TO from RWS_PROPOSAL_WORKFLOW_TBL pw where track_no=(sELECT max(track_no) from RWS_PROPOSAL_WORKFLOW_TBL pw where pw.proposal_id='"+ pid +"') and pw.proposal_id='"+pid+"'" ;
					rs6=st6.executeQuery(q6);
					rs6.next();
		%>
				<td class="mystyle1"><B> <%=rw.getOfficeName(rs6.getString(2),true) %> </td>
				<td class="mystyle1"><B>Considered for Sanction</td>
				<% }
			}
			else
			{ %>
			<td class="mystyle1"><B> <%=rw.getOfficeName(rs.getString(13),true) %>   </td>
			<td class="mystyle1"><B>Not Considered </td>

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

<table align=center>
<tr>
<td align="center"  style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;">
Designed & Developed by National Informatics Centre, AP State Centre
</td>
</tr>
</table>
</TABLE>
</P>
</body>
</html>
