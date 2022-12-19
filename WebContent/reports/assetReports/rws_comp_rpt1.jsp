<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="conn3.jsp" %>

<html>
<head>
<title>Graphs</title>
<script language="JavaScript">
</script>
<style>
.mystyle
{
	background-color:silver;
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:7pt;
}

.mytext
{
	height:19px;
	font-size:9px;
	
}
.mytbltext
{
	height:14px;
	font-size:9pt;
	border-width:0;
	width:90pt;
	font-family:verdana;
}
.mynobordertext
{
	height:14px;
	font-size:9pt;
	border-width:0;
	font-family:verdana;
	background-color:#DEE3E0
}

.btext
{
	border-width:1;
	border-color:#000000;
	background-color:#efefef;
	color:#660099;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}
.clrborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-weight:bold;
	font-size:8pt;
	color:#993366;
}
.bwborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	color:#000000;
}
.textborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	font-weight:bold;
	color:#000000;
}
.mycborder
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-weight:bold;
	font-size:5pt;
}
.mycborder1
{
	padding:0;
	height:15px;
	font-family:verdana;

	font-size:5pt;
	
}

.mycombo

{
	height:14px;
	border-width:0;
	font-size:9pt;
	font-family:verdana;
}
.mytext2
{
	height:14px;
	border-width:0;
	border-style:none;
	font:menu;
}
.myfontclr
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	color:#000000;
	font-weight:bold;
}
.thead
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-weight:bold;
	font-size:9pt;
	color:#ffffff;
}
.myfontclr1
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;
	color:#000000;
	
	
}
.loginStyle
{
font-family:verdana;
font-width:9pt;
border-width:0;
background-color:#DEE3E0;
color:#6600FF;
font-weight:bold
}
.head
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:10pt;
	color:#000000;
}

.rptHeading
{
	border-width:1;
	color:navy;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.rptLabel
{
	border-width:1;
	border-color:#000000;
	background-color:#efefef;
	color:navy;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt	
}
.rptValue
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;	
	color:#000000;	
}

.rptSubValue
{
	padding:0;
	height:15px;
	font-family:verdana;
	font-size:9pt;	
	color:brown;
	font-weight:bold;
}

.prptHeading
{
	border-width:1;
	color:black;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.prptLabel
{
	border-width:1;
	border-color:#000000;
	color:black;
	font-weight:bold;
	height:18px;
	font-family:verdana;
	font-size:9pt
}

.dateFont
{
	color:black;
	font-family:verdana;
	font-size:8pt;
}
A:link{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:visited{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:hover{font-family:verdana;font-size:8pt;text-decoration:underline;color:#316A95}



</style>



</head>
<body>
<form>

<%
String typeassetcode="";

int sno=1;
int psno=0;
int tot=0;
int total=0;
Statement stmt1=null;
ResultSet rs1=null;
String mandalname="";
String districtname="";

String pname="";
String vname="";
int count43=0;
int count44=0;
ResultSet rs51=null;
Statement stmt51=null;
int count51=0;


String panchname="";
String panchayatname="";
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet rs4=null;
ResultSet rs5=null;
ResultSet rs6=null;
ResultSet rs7=null;
ResultSet rs8=null;
ResultSet rs9=null;
ResultSet rs10=null;
ResultSet rs11=null;
ResultSet rs12=null;
ResultSet rs13=null;
ResultSet rs14=null;
ResultSet rs15=null;
ResultSet rs16=null;
ResultSet rs17=null;
ResultSet rs18=null;
ResultSet rs19=null;
ResultSet rs20=null;
ResultSet rs21=null;
ResultSet rs22=null;
ResultSet rs23=null;
ResultSet rs24=null;
ResultSet rs25=null;
ResultSet rs26=null;
Statement stmt3=null;
Statement stmt4=null;
Statement stmt5=null;
Statement stmt6=null;
Statement stmt7=null;
Statement stmt8=null;
Statement stmt9=null;
Statement stmt10=null;
Statement stmt11=null;
Statement stmt12=null;
Statement stmt13=null;
Statement stmt14=null;
Statement stmt15=null;
Statement stmt16=null;
Statement stmt17=null;
Statement stmt18=null;
Statement stmt19=null;
Statement stmt20=null;
Statement stmt21=null;
Statement stmt22=null;
Statement stmt23=null;
Statement stmt24=null;
Statement stmt25=null;
Statement stmt26=null;
Statement stmt27=null;
ResultSet rs27=null;
Statement stmt2=null;
Statement stmt43=null;
ResultSet rs43=null;
String villagename="";
String typeassetname="";
typeassetname=request.getParameter("typeassetname");
String assetcode="";
assetcode=request.getParameter("assetcode");


typeassetcode=request.getParameter("typeassetcode");

int count=0;
int count1=0;
int count2=0;
int count3=0;
int count4=0;
int count5=0;
int count6=0;
int count7=0;
int count8=0;
int count9=0;
int count10=0;
int count11=0;
int count12=0;
int count13=0;
int count14=0;
int count15=0;
int count16=0;
int count17=0;
int count18=0;
int count19=0;
int count20=0;
int count21=0;
int count22=0;
int count23=0;
int count24=0;
int count25=0;
int count26=0;
int count42=0;
Statement stmt42=null;
Statement stmt44=null;
ResultSet rs44=null;

ResultSet rs42=null;
String panchcode=request.getParameter("panchcode");


String districtcode="";
String mandalcode="";
String panchayatcode="";
String villagecode="";
districtcode=request.getParameter("districtcode");
mandalcode=request.getParameter("mandalcode");
panchayatcode=request.getParameter("panchayatcode");
villagecode=request.getParameter("villagecode");
String habcode="";
habcode=request.getParameter("habcode");
districtname=request.getParameter("districtname");
mandalname=request.getParameter("mandalname");
panchayatname=request.getParameter("panchayatname");
villagename=request.getParameter("villagename");
panchname=request.getParameter("panchname");
int count50=0;
%>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="rws_graph_frm1.jsp">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>
			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#edf2f8" align="center">
		<td class=rptValue colspan=3><font color="navy">Asset:<%=typeassetname%>&nbsp;District:<%=districtname%>&nbsp;Mandal:<%=mandalname%>&nbsp;Panchayat:<%=panchayatname%>&nbsp;Village:<%=villagename%>&nbsp;Habitation:<%=panchname%></td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Assets  </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sub Components</td>
			   <td class=btext>Total</td>
			   </tr>


<%

try
{
	 

	   if(typeassetcode.equals("03"))
	{
		   //Sources

		   stmt23=conn.createStatement();
	rs23=stmt23.executeQuery("select count(*),p.source_type_code,substr(p.source_code,17,3) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '8%%' and p.source_type_code=s.source_type_code and substr(p.source_code,1,2)='" + districtcode + "' and substr(p.source_code,6,2)='" + mandalcode + "' and substr(p.source_code,13,2)='" + panchayatcode + "' and substr(p.source_code,8,3)='" + villagecode + "' and asset_code='" + assetcode + "' and p.source_type_code='1' group by p.source_type_code,substr(p.source_code,17,3) ");
	while(rs23.next())
		{
		count23=rs23.getInt(1);
		%>
		<tr bgcolor="#ffffff">
		
				<td class=rptValue>Sub Surface Source</td>
				<td class=rptValue><a href="rws_source_tbl.jsp?assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetcode=<%=typeassetcode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&sourcetypecode=<%=rs23.getString(2)%>"><%=count23%></a></td>
				</tr>
			<%

		}
		stmt24=conn.createStatement();
	rs24=stmt24.executeQuery("select count(*),p.source_type_code,substr(p.source_code,17,3) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '8%%' and p.source_type_code=s.source_type_code and substr(p.source_code,1,2)='" + districtcode + "' and substr(p.source_code,6,2)='" + mandalcode + "' and substr(p.source_code,13,2)='" + panchayatcode + "' and substr(p.source_code,8,3)='" + villagecode + "' and asset_code='" + assetcode + "' and p.source_type_code='2'  group by p.source_type_code,substr(p.source_code,17,3) ");
	while(rs24.next())
		{
		count24=rs24.getInt(1);
		%>
		<tr bgcolor="#ffffff">
				<td class=rptValue>Surface Source</td>
				<td class=rptValue><a href="rws_source_tbl.jsp?assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetcode=<%=typeassetcode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&sourcetypecode=<%=rs24.getString(2)%>"><%=count24%></a></td>
				</tr>
			<%

		}
		//Headworks

		stmt17=conn.createStatement();
        rs17=stmt17.executeQuery("select count(*) from RWS_AST_RW_COLLWELL_PARAM_TBL    where asset_code= '"+assetcode+"'   and substr(rw_collwell_code,1,2)='"+districtcode+"' and substr(rw_collwell_code,6,2)='"+mandalcode+"' and substr(rw_collwell_code,13,2)='"+panchayatcode+"' and substr(rw_collwell_code,8,3)='"+villagecode+"' ");
			
				while(rs17.next())
				{
					count17=rs17.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Raw Water Collection Well</td>
				<td class=rptValue><a href="rws_rawwater_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count17%></a></td>
						
				</tr>
				
<%

}
stmt18=conn.createStatement();
rs18=stmt18.executeQuery("select count(*) from RWS_AST_SS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   and substr(sssc_code,1,2)='"+districtcode+"' and substr(sssc_code,6,2)='"+mandalcode+"' and substr(sssc_code,13,2)='"+panchayatcode+"' and substr(sssc_code,8,3)='"+villagecode+"'   ");
			
				while(rs18.next())
				{
					count18=rs18.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>SS Tank</td>
				<td class=rptValue><a href="rws_sstank_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count18%></a></td>
						
				
				</tr>
				
<%
	
					}

					stmt42=conn.createStatement();
rs42=stmt42.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_AST_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"'  and substr(wtpsc_code,20,2) like 'S%' group by substr(wtpsc_code,20,2) ");
			
				while(rs42.next())
				{
						count42=rs42.getInt(1);		
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>SS Filter</td>
				<td class=rptValue><a href="rws_wtp_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&rs=<%=rs42.getString(2)%>"><%=count42%></a></td>
				
				</tr>

						
<%

					
				}
				stmt22=conn.createStatement();
rs22=stmt22.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_AST_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"'  and substr(wtpsc_code,20,2) like 'R%' GROUP BY SUBSTR(WTPSC_CODE,20,2) ");
			
				while(rs22.next())
				{
						count22=rs22.getInt(1);	
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Rs Filter</td>
				<td class=rptValue><a href="rws_wtp_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&rs=<%=rs22.getString(2)%>"><%=count22%></a></td>
				</tr>
				
<%

					
				}
	

	stmt20=conn.createStatement();
rs20=stmt20.executeQuery("select count(*) from RWS_AST_SUMP_M_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(sumpcode,1,2)='"+districtcode+"' and substr(sumpcode,6,2)='"+mandalcode+"' and substr(sumpcode,13,2)='"+panchayatcode+"' and substr(sumpcode,8,3)='"+villagecode+"'  ");
			
				while(rs20.next())
				{
					count20=rs20.getInt(1);
					
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Sump</td>
				<td class=rptValue><a href="rws_sump_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>"><%=count20%></a></td>
				
				</tr>
				
<%
	
							}
							 stmt6=conn.createStatement();
				rs6=stmt6.executeQuery("select count(*) from RWS_AST_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"' and substr(bridge_code,1,2)='"+districtcode+"' and substr(bridge_code,6,2)='"+mandalcode+"' and substr(bridge_code,13,2)='"+panchayatcode+"' and substr(bridge_code,8,3)='"+villagecode+"' and substr(bridge_code,17,3)='800'");
				while(rs6.next())
				{
					count6=rs6.getInt(1);
					
					%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Foot Path Bridge</td>
				<td class=rptValue><a href="rws_footpathbridge_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count6%></td>
				</tr>
				
<%
			
				}

stmt21=conn.createStatement();
rs21=stmt21.executeQuery("select count(*) from RWS_AST_WATCHMAN_PARAM_TBL   where asset_code= '"+assetcode+"'  and substr(watchman_code,1,2)='"+districtcode+"' and substr(watchman_code,6,2)='"+mandalcode+"' and substr(watchman_code,13,2)='"+panchayatcode+"' and substr(watchman_code,8,3)='"+villagecode+"' ");
			
				while(rs21.next())
				{
					count21=rs21.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Watchman Quarter</td>
				<td class=rptValue><a href="rws_watchmanquarter_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>"><%=count21%></a></td>
				</tr>
				
<%
	
			
				}	

				stmt4=conn.createStatement();
				rs4=stmt4.executeQuery("select count(*) from RWS_AST_CW_COLLWELL_PARAM_TBL  where asset_code= '"+assetcode+"' and substr(cw_collwell_code,1,2)='"+districtcode+"' and substr(cw_collwell_code,6,2)='"+mandalcode+"' and substr(cw_collwell_code,13,2)='"+panchayatcode+"' and substr(cw_collwell_code,8,3)='"+villagecode+"' ");
			
				while(rs4.next())
				{
					count4=rs4.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Clear Water Collection Well</td>
				<td class=rptValue><a href="rws_clearwater_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count4%></td>
				</tr>
				
<%
			
				}

				stmt43=conn.createStatement();
rs43=stmt43.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_AST_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"'  and substr(wtpsc_code,20,2) like 'M%' group by substr(wtpsc_code,20,2) ");
			
				while(rs43.next())
				{
						count43=rs43.getInt(1);		
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Micro Filter</td>
				<td class=rptValue><a href="rws_wtp_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&rs=<%=rs43.getString(2)%>"><%=count43%></a></td>
				
				</tr>
				
<%

					
				}

				stmt44=conn.createStatement();
rs44=stmt44.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_AST_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"'  and substr(wtpsc_code,20,2) like '%P' group by substr(wtpsc_code,20,2) ");
			
				while(rs44.next())
				{
						count44=rs44.getInt(1);		
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>ROPLANTS</td>
				<td class=rptValue><a href="rws_wtp_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&rs=<%=rs44.getString(2)%>"><%=count44%></a></td>
				
				</tr>
				
<%

					
				}
				//PipeLine

				


	stmt15=conn.createStatement();
rs15=stmt15.executeQuery("select count(*) from RWS_AST_PUMPINGMAIN_TBl  where asset_code= '"+assetcode +"'  and substr(pumpingmain_code,1,2)='"+districtcode+"' and substr(pumpingmain_code,6,2)='"+mandalcode+"' and substr(pumpingmain_code,13,2)='"+panchayatcode+"' and substr(pumpingmain_code,8,3)='"+villagecode+"'   ");
			
				while(rs15.next())
				{
					count15=rs15.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Pumping Main</td>
				<td class=rptValue><a href="rws_pumpingmain_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count15%></a></td>
				
				</tr>
				
<%
			
				} 
		
stmt9=conn.createStatement();
				rs9=stmt9.executeQuery("select count(*) from RWS_AST_GRAVITYMAIN_TBL      where asset_code= '"+assetcode+"'  and substr(gravitymain_code,1,2)='"+districtcode+"' and substr(gravitymain_code,6,2)='"+mandalcode+"' and substr(gravitymain_code,13,2)='"+panchayatcode+"' and substr(gravitymain_code,8,3)='"+villagecode+"'    ");
			
				while(rs9.next())
				{
					count9=rs9.getInt(1);
					%>
					
				<tr bgcolor="#ffffff">
				<td class=rptValue>Gravity Main</td>
				<td class=rptValue><a href="rws_gravitymain_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count9%></a></td>
				
				</tr>
				
<%
						}

stmt5=conn.createStatement();
				rs5=stmt5.executeQuery("select count(*) from RWS_AST_DISTRI_SC_PARAM_TBL   where asset_code= '"+assetcode+"'  and substr(distrisc_code,1,2)='"+districtcode+"' and substr(distrisc_code,6,2)='"+mandalcode+"' and substr(distrisc_code,13,2)='"+panchayatcode+"' and substr(distrisc_code,8,3)='"+villagecode+"'    ");
			
				while(rs5.next())
				{
					count5=rs5.getInt(1);
				
				%>

                <tr bgcolor="#ffffff">
				<td class=rptValue>Distribution</td>
				<td class=rptValue><a href="rws_distribution_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count5%></td>
				</tr>
				
<%
			


				}
			//Sr.Reservoirs

			stmt11=conn.createStatement();
rs11=stmt11.executeQuery("select count(*) from RWS_AST_OHSR_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(ohsr_code,1,2)='"+districtcode+"' and substr(ohsr_code,6,2)='"+mandalcode+"' and substr(ohsr_code,13,2)='"+panchayatcode+"' and substr(ohsr_code,8,3)='"+villagecode+"'   ");
			
				while(rs11.next())
				{
					count11=rs11.getInt(1);
					
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Ohsr</td>
				<td class=rptValue><a href="rws_ohsr_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count11%></a></td>
				
				</tr>
				
<%
			
				}
				 stmt10=conn.createStatement();
				rs10=stmt10.executeQuery("select count(*) from RWS_AST_OHBR_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(ohbr_code,1,2)='"+districtcode+"' and substr(ohbr_code,6,2)='"+mandalcode+"' and substr(ohbr_code,13,2)='"+panchayatcode+"' and substr(ohbr_code,8,3)='"+villagecode+"'    ");
			
				while(rs10.next())
				{
					count10=rs10.getInt(1);
					%>
					<tr bgcolor="#ffffff">
					<td class=rptValue>Ohbr</td>
				<td class=rptValue><a href="rws_ohbr_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count10%></a></td>
				</tr>
				
<%
			
				}

				 stmt8=conn.createStatement();
				rs8=stmt8.executeQuery("select count(*) from RWS_AST_GLSR_SC_PARAM_TBL     where asset_code= '"+assetcode+"'  and substr(glsr_code,1,2)='"+districtcode+"' and substr(glsr_code,6,2)='"+mandalcode+"' and substr(glsr_code,13,2)='"+panchayatcode+"' and substr(glsr_code,8,3)='"+villagecode+"'   ");
			
				while(rs8.next())
				{
					count8=rs8.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Glsr</td>
				<td class=rptValue><a href="rws_glsr_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count8%></a></td>
				</tr>
				
<%
							}
 stmt7=conn.createStatement();
				rs7=stmt7.executeQuery("select count(*) from RWS_AST_GLBR_SC_PARAM_TBL     where asset_code= '"+assetcode+"' and substr(glbr_code,1,2)='"+districtcode+"' and substr(glbr_code,6,2)='"+mandalcode+"' and substr(glbr_code,13,2)='"+panchayatcode+"' and substr(glbr_code,8,3)='"+villagecode+"'    ");
			
				while(rs7.next())
				{
					count7=rs7.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Glbr</td>
				<td class=rptValue><a href="rws_glbr_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count7%></a></td>
				</tr>
				
<%
			
				}

				stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  count(*) from rws_ast_bpt_param_tbl where asset_code='" + assetcode + "' and substr(bpt_code,1,2)='" + districtcode + "' and substr(bpt_code,6,2)='" + mandalcode + "' and substr(bpt_code,13,2)='" + panchayatcode + "' and substr(bpt_code,8,3)='" + villagecode + "'  ");
		while(rs1.next())
    	{
			count1=rs1.getInt(1);
				%>
				
				<tr bgcolor="#ffffff">
				
				<td class=rptValue>Bpt</td>
				<td class=rptValue><a href="rws_bpt.jsp?assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&typeassetcode=<%=typeassetcode%>&panchname=<%=panchname%>"><%=count1%></a></td>
				</tr>
			




<%


			
			
			
		}
							
				stmt2=conn.createStatement();
				rs2=stmt2.executeQuery("select count(*) from RWS_AST_CIS_SC_PARAM_TBL where asset_code= '"+assetcode+"' and substr(cissc_code,1,2)='"+districtcode+"' and substr(cissc_code,6,2)='" +mandalcode+"' and substr(cissc_code,13,2)='"+panchayatcode+"' 	and substr(cissc_code,8,3)='" +villagecode+"'    ");
			
				while(rs2.next())
				{
					count2=rs2.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Cisterns</td>
				<td class=rptValue><a href="rws_cisterns_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count2%></td>				</tr>
				
<%
			
				}
				//Miscellaneous

				stmt12=conn.createStatement();
rs12=stmt12.executeQuery("select count(*) from RWS_AST_OTHERS_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(other_comp_code,1,2)='"+districtcode+"' and substr(other_comp_code,6,2)='"+mandalcode+"' and substr(other_comp_code,13,2)='"+panchayatcode+"' and substr(other_comp_code,8,3)='"+villagecode+"'   ");
			
				while(rs12.next())
				{
					count12=rs12.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Others(Miscellaneous)</td>
				<td class=rptValue><a href="rws_other_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count12%></a></td>
				
				</tr>
				
<%
			
				}

				
				 
				 
				 stmt51=conn.createStatement();
		rs51=stmt51.executeQuery("select  count(*) from RWS_AST_CHLORINATION_TBL where asset_code='" + assetcode + "' and substr(cl_code,1,2)='" + districtcode + "' and substr(cl_code,6,2)='" + mandalcode + "' and substr(cl_code,13,2)='" + panchayatcode + "' and substr(cl_code,8,3)='" + villagecode + "'   ");
		while(rs51.next())
    	{
			count51=rs51.getInt(1);
				%>
				
				<tr bgcolor="#ffffff">
				
				<td class=rptValue>CHLORINATION</td>
				<td class=rptValue><a href="rws_chlorination_rpt.jsp?assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&typeassetcode=<%=typeassetcode%>&panchname=<%=panchname%>"><%=count51%></a></td>
				</tr>
				<%
		}
				
		




	
	



					
		
		
	


		   stmt27=conn.createStatement();
		rs27=stmt27.executeQuery("select  count(*) from rws_ast_oandm_param_tbl where asset_code='" + assetcode + "' and substr(oandmcode,1,2)='" + districtcode + "' and substr(oandmcode,6,2)='" + mandalcode + "' and substr(oandmcode,13,2)='" + panchayatcode + "' and substr(oandmcode,8,3)='" + villagecode + "'   ");
		while(rs27.next())
    	{
			count50=rs27.getInt(1);
				%>
				
				<tr bgcolor="#ffffff">
				
				<td class=rptValue>OANDM</td>
				<td class=rptValue><a href="rws_oandm_rpt.jsp?assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&typeassetcode=<%=typeassetcode%>&panchname=<%=panchname%>"><%=count50%></a></td>
				</tr>
				<%
		}
				//
				//pumpsets
				stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select count(*) from RWS_AST_SUBCOMP_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(pump_code,1,2)='"+districtcode+"' and substr(pump_code,6,2)='"+mandalcode+"' and substr(pump_code,13,2)='"+panchayatcode+"' and substr(pump_code,8,3)='"+villagecode+"'   ");
			
				while(rs19.next())
				{
					
					count19=rs19.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Pumpsets</td>
				<td class=rptValue><a href="rws_pumpsets_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count19%></a></td>
				
				</tr>
				
<%
	
			}
				

		

	}
			

		}
	
catch(Exception e)
{
	out.println("Exception"+e);
}
finally
{
	try
	{
		if(rs2!=null)
		{
			rs2.close();
		}
		if(stmt2!=null)
		{
			stmt2.close();
		}
		if(rs3!=null)
		{
			rs3.close();
		}
		if(stmt3!=null)
		{
			stmt3.close();
		}
		if(rs4!=null)
		{
			rs4.close();
		}
		if(stmt4!=null)
		{
			stmt4.close();
		}
		if(rs5!=null)
		{
			rs5.close();
		}
		if(stmt5!=null)
		{
			stmt5.close();
		}
		if(rs6!=null)
		{
			rs6.close();
		}
		if(stmt6!=null)
		{
			stmt6.close();
		}
		if(rs7!=null)
		{
			rs7.close();
		}
		if(stmt7!=null)
		{
			stmt7.close();
		}
		if(rs8!=null)
		{
			rs8.close();
		}
		if(stmt8!=null)
		{
			stmt8.close();
		}
		if(rs9!=null)
		{
			rs9.close();
		}
		if(stmt9!=null)
		{
			stmt9.close();
		}
		if(rs10!=null)
		{
			rs10.close();
		}
		if(stmt10!=null)
		{
			stmt10.close();
		}
		if(rs11!=null)
		{
			rs11.close();
		}
		if(stmt11!=null)
		{
			stmt11.close();
		}
		if(rs12!=null)
		{
			rs12.close();
		}
		if(stmt12!=null)
		{
			stmt12.close();
		}
		if(rs13!=null)
		{
			rs13.close();
		}
		if(stmt13!=null)
		{
			stmt13.close();
		}
		if(rs14!=null)
		{
			rs14.close();
		}
		if(stmt14!=null)
		{
			stmt14.close();
		}
		if(rs15!=null)
		{
			rs15.close();
		}
		if(stmt15!=null)
		{
			stmt15.close();
		}
		if(rs16!=null)
		{
			rs16.close();
		}
		if(stmt16!=null)
		{
			stmt16.close();
		}
		if(rs17!=null)
		{
			rs17.close();
		}
		if(stmt17!=null)
		{
			stmt17.close();
		}
		if(rs18!=null)
		{
			rs18.close();
		}
		if(stmt18!=null)
		{
			stmt18.close();
		}
		if(rs19!=null)
		{
			rs19.close();
		}
		if(stmt19!=null)
		{
			stmt19.close();
		}
		if(rs20!=null)
		{
			rs20.close();
		}
		if(stmt20!=null)
		{
			stmt20.close();
		}
		if(rs21!=null)
		{
			rs21.close();
		}
		if(stmt21!=null)
		{
			stmt21.close();
		}
		if(rs22!=null)
		{
			rs22.close();
		}
		if(stmt22!=null)
		{
			stmt22.close();
		}
		if(rs23!=null)
		{
			rs23.close();
		}
		if(stmt23!=null)
		{
			stmt23.close();
		}
		if(rs24!=null)
		{
			rs24.close();
		}
		if(stmt24!=null)
		{
			stmt24.close();
		}
		if(rs25!=null)
		{
			rs25.close();
		}
		if(stmt25!=null)
		{
			stmt25.close();
		}
		if(rs26!=null)
		{
			rs26.close();
		}
		if(stmt26!=null)
		{
			stmt26.close();
		}
		if(rs27!=null)
		{
			rs27.close();
		}
		if(stmt27!=null)
		{
			stmt27.close();
		}
		if(rs43!=null)
		{
			rs43.close();
		}
		if(stmt43!=null)
		{
			stmt43.close();
		}
		if(rs44!=null)
		{
			rs44.close();
		}
		if(stmt44!=null)
		{
			stmt44.close();
		}
		
		conn.close();
	}

	catch(Exception o)
	{
		o.printStackTrace();
	}
}
%>
</table>
</form>

</body>

<%@ include file="/commons/rws_footer.jsp" %>
</p>
</html>
