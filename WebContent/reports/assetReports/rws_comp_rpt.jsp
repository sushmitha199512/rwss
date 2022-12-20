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
Statement stmt2=null;
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
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  count(*) from rws_cpws_bpt_param_tbl where asset_code='" + assetcode + "' and substr(bpt_code,1,2)='" + districtcode + "' and substr(bpt_code,6,2)='" + mandalcode + "' and substr(bpt_code,13,2)='" + panchayatcode + "' and substr(bpt_code,8,3)='" + villagecode + "'  ");
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
				rs2=stmt2.executeQuery("select count(*) from RWS_CPWS_CIS_SC_PARAM_TBL where asset_code= '"+assetcode+"' and substr(cissc_code,1,2)='"+districtcode+"' and substr(cissc_code,6,2)='" +mandalcode+"' and substr(cissc_code,13,2)='"+panchayatcode+"' 	and substr(cissc_code,8,3)='" +villagecode+"'    ");
			
				while(rs2.next())
				{
					count2=rs2.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Cisterns</td>
				<td class=rptValue><a href="rws_cisterns_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count2%></td>				</tr>
				
<%
			
				}
				stmt5=conn.createStatement();
				rs5=stmt5.executeQuery("select count(*) from RWS_CPWS_DISTRI_SC_PARAM_TBL   where asset_code= '"+assetcode+"'  and substr(distrisc_code,1,2)='"+districtcode+"' and substr(distrisc_code,6,2)='"+mandalcode+"' and substr(distrisc_code,13,2)='"+panchayatcode+"' and substr(distrisc_code,8,3)='"+villagecode+"'    ");
			
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
				stmt4=conn.createStatement();
				rs4=stmt4.executeQuery("select count(*) from RWS_CPWS_CW_COLLWELL_PARAM_TBL  where asset_code= '"+assetcode+"' and substr(cw_collwell_code,1,2)='"+districtcode+"' and substr(cw_collwell_code,6,2)='"+mandalcode+"' and substr(cw_collwell_code,13,2)='"+panchayatcode+"' and substr(cw_collwell_code,8,3)='"+villagecode+"'");
			
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

                


                stmt6=conn.createStatement();
				rs6=stmt6.executeQuery("select count(*) from RWS_CPWS_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"' and substr(bridge_code,1,2)='"+districtcode+"' and substr(bridge_code,6,2)='"+mandalcode+"' and substr(bridge_code,13,2)='"+panchayatcode+"' and substr(bridge_code,8,3)='"+villagecode+"'");
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


	            stmt7=conn.createStatement();
				rs7=stmt7.executeQuery("select count(*) from RWS_CPWS_GLBR_SC_PARAM_TBL     where asset_code= '"+assetcode+"' and substr(glbr_code,1,2)='"+districtcode+"' and substr(glbr_code,6,2)='"+mandalcode+"' and substr(glbr_code,13,2)='"+panchayatcode+"' and substr(glbr_code,8,3)='"+villagecode+"'   ");
			
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

	            stmt8=conn.createStatement();
				rs8=stmt8.executeQuery("select count(*) from RWS_CPWS_GLSR_SC_PARAM_TBL     where asset_code= '"+assetcode+"'  and substr(glsr_code,1,2)='"+districtcode+"' and substr(glsr_code,6,2)='"+mandalcode+"' and substr(glsr_code,13,2)='"+panchayatcode+"' and substr(glsr_code,8,3)='"+villagecode+"'   ");
			
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

//RWS_CPWS_GRAVITYMAIN_TBL 
stmt9=conn.createStatement();
				rs9=stmt9.executeQuery("select count(*) from RWS_CPWS_GRAVITYMAIN_TBL      where asset_code= '"+assetcode+"'  and substr(gravitymain_code,1,2)='"+districtcode+"' and substr(gravitymain_code,6,2)='"+mandalcode+"' and substr(gravitymain_code,13,2)='"+panchayatcode+"' and substr(gravitymain_code,8,3)='"+villagecode+"'   ");
			
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
				//RWS_CPWS_OHBR_SC_PARAM_TBL 
                stmt10=conn.createStatement();
				rs10=stmt10.executeQuery("select count(*) from RWS_CPWS_OHBR_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(ohbr_code,1,2)='"+districtcode+"' and substr(ohbr_code,6,2)='"+mandalcode+"' and substr(ohbr_code,13,2)='"+panchayatcode+"' and substr(ohbr_code,8,3)='"+villagecode+"'    ");
			
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
//RWS_CPWS_OHSR_SC_PARAM_TBL 
stmt11=conn.createStatement();
rs11=stmt11.executeQuery("select count(*) from RWS_CPWS_OHSR_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(ohsr_code,1,2)='"+districtcode+"' and substr(ohsr_code,6,2)='"+mandalcode+"' and substr(ohsr_code,13,2)='"+panchayatcode+"' and substr(ohsr_code,8,3)='"+villagecode+"'   ");
			
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
	
//RWS_CPWS_OTHERS_PARAM_TBL 
stmt12=conn.createStatement();
rs12=stmt12.executeQuery("select count(*) from RWS_CPWS_OTHERS_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(other_comp_code,1,2)='"+districtcode+"' and substr(other_comp_code,6,2)='"+mandalcode+"' and substr(other_comp_code,13,2)='"+panchayatcode+"' and substr(other_comp_code,8,3)='"+villagecode+"'   ");
			
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

//RWS_CPWS_PUMPHOUSE_PARAM_TBL
stmt14=conn.createStatement();
rs14=stmt14.executeQuery("select count(*) from RWS_CPWS_PUMPHOUSE_PARAM_TBL  where asset_code= '"+ assetcode+"'  and substr(pumphouse_code,1,2)='"+districtcode+"' and substr(pumphouse_code,6,2)='"+mandalcode+"' and substr(pumphouse_code,13,2)='"+panchayatcode+"' and substr(pumphouse_code,8,3)='"+villagecode+"'    ");
			
				while(rs14.next())
				{
					count14=rs14.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Pump House</td>
				<td class=rptValue><a href="rws_pumphouse_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count14%></a></td>
				</tr>
				
<%
	
							}
     
//RWS_CPWS_PUMPINGMAIN_TB
			stmt15=conn.createStatement();
rs15=stmt15.executeQuery("select count(*) from RWS_CPWS_PUMPINGMAIN_TBl  where asset_code= '"+assetcode +"'  and substr(pumpingmain_code,1,2)='"+districtcode+"' and substr(pumpingmain_code,6,2)='"+mandalcode+"' and substr(pumpingmain_code,13,2)='"+panchayatcode+"' and substr(pumpingmain_code,8,3)='"+villagecode+"'   ");
			
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
			
//RWS_CPWS_PUMP_DET_SC_PARAM_TBL 
	 //RWS_CPWS_RW_COLLWELL_PARAM_TBL 
		stmt17=conn.createStatement();
        rs17=stmt17.executeQuery("select count(*) from RWS_CPWS_RW_COLLWELL_PARAM_TBL    where asset_code= '"+assetcode+"'   and substr(rw_collwell_code,1,2)='"+districtcode+"' and substr(rw_collwell_code,6,2)='"+mandalcode+"' and substr(rw_collwell_code,13,2)='"+panchayatcode+"' and substr(rw_collwell_code,8,3)='"+villagecode+"'");
			
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
				
//RWS_CPWS_SS_SC_PARAM_TBL 
		stmt18=conn.createStatement();
rs18=stmt18.executeQuery("select count(*) from RWS_CPWS_SS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   and substr(sssc_code,1,2)='"+districtcode+"' and substr(sssc_code,6,2)='"+mandalcode+"' and substr(sssc_code,13,2)='"+panchayatcode+"' and substr(sssc_code,8,3)='"+villagecode+"'   ");
			
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
		
//RWS_CPWS_SUBCOMP_PARAM_TBL 
	stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select count(*) from RWS_CPWS_SUBCOMP_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(pump_code,1,2)='"+districtcode+"' and substr(pump_code,6,2)='"+mandalcode+"' and substr(pump_code,13,2)='"+panchayatcode+"' and substr(pump_code,8,3)='"+villagecode+"'    ");
			
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
				


	
//RWS_CPWS_SUMP_M_SC_PARAM_TBL 
	stmt20=conn.createStatement();
rs20=stmt20.executeQuery("select count(*) from RWS_CPWS_SUMP_M_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(sumpcode,1,2)='"+districtcode+"' and substr(sumpcode,6,2)='"+mandalcode+"' and substr(sumpcode,13,2)='"+panchayatcode+"' and substr(sumpcode,8,3)='"+villagecode+"'  ");
			
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
				//RWS_CPWS_WATCHMAN_PARAM_TBL 
					stmt21=conn.createStatement();
rs21=stmt21.executeQuery("select count(*) from RWS_CPWS_WATCHMAN_PARAM_TBL   where asset_code= '"+assetcode+"'  and substr(watchman_code,1,2)='"+districtcode+"' and substr(watchman_code,6,2)='"+mandalcode+"' and substr(watchman_code,13,2)='"+panchayatcode+"' and substr(watchman_code,8,3)='"+villagecode+"'");
			
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
	rs24=stmt24.executeQuery("select count(*),p.source_type_code,substr(p.source_code,17,3) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '8%%' and p.source_type_code=s.source_type_code and substr(p.source_code,1,2)='" + districtcode + "' and substr(p.source_code,6,2)='" + mandalcode + "' and substr(p.source_code,13,2)='" + panchayatcode + "' and substr(p.source_code,8,3)='" + villagecode + "' and asset_code='" + assetcode + "' and p.source_type_code='2' group by p.source_type_code,substr(p.source_code,17,3) ");
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
		
		//RWS_CPWS_WTP_SC_PARAM_TBL 
	stmt22=conn.createStatement();
rs22=stmt22.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_CPWS_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"' and substr(wtpsc_code,20,2) like 'R%' GROUP BY SUBSTR(WTPSC_CODE,20,2) ");
			
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
	//ss filter
stmt42=conn.createStatement();
rs42=stmt42.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_CPWS_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"' and substr(wtpsc_code,20,2) like 'S%' group by substr(wtpsc_code,20,2) ");
			
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
	

	}
		
			
 if(typeassetcode.equals("01"))
	{
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  count(*) from rws_pws_bpt_param_tbl where asset_code='" + assetcode + "' and substr(bpt_code,1,2)='" + districtcode + "' and substr(bpt_code,6,2)='" + mandalcode + "' and substr(bpt_code,13,2)='" + panchayatcode + "' and substr(bpt_code,8,3)='" + villagecode + "'  ");
		while(rs1.next())
    	{
			count1=rs1.getInt(1);
				%>
				
				<tr bgcolor="#ffffff">
				
				<td class=rptValue>Bpt</td>
				<td class=rptValue><a href="rws_bpt.jsp?assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&typeassetcode=<%=typeassetcode%>"><%=count1%></a></td>
				</tr>
			




<%


			
			
			
		}
							
				stmt2=conn.createStatement();
				rs2=stmt2.executeQuery("select count(*) from RWS_PWS_CIS_SC_PARAM_TBL where asset_code= '"+assetcode+"' and substr(cissc_code,1,2)='"+districtcode+"' and substr(cissc_code,6,2)='" +mandalcode+"' and substr(cissc_code,13,2)='"+panchayatcode+"' 	and substr(cissc_code,8,3)='" +villagecode+"'    ");
			
				while(rs2.next())
				{
					count2=rs2.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Cisterns</td>
				<td class=rptValue><a href="rws_cisterns_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count2%></td>				</tr>
				
<%
			
				}
				stmt5=conn.createStatement();
				rs5=stmt5.executeQuery("select count(*) from RWS_PWS_DISTRI_SC_PARAM_TBL   where asset_code= '"+assetcode+"'  and substr(distrisc_code,1,2)='"+districtcode+"' and substr(distrisc_code,6,2)='"+mandalcode+"' and substr(distrisc_code,13,2)='"+panchayatcode+"' and substr(distrisc_code,8,3)='"+villagecode+"'    ");
			
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
				stmt4=conn.createStatement();
				rs4=stmt4.executeQuery("select count(*) from RWS_PWS_CW_COLLWELL_PARAM_TBL  where asset_code= '"+assetcode+"' and substr(cw_collwell_code,1,2)='"+districtcode+"' and substr(cw_collwell_code,6,2)='"+mandalcode+"' and substr(cw_collwell_code,13,2)='"+panchayatcode+"' and substr(cw_collwell_code,8,3)='"+villagecode+"'");
			
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

                


                stmt6=conn.createStatement();
				rs6=stmt6.executeQuery("select count(*) from RWS_PWS_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"' and substr(bridge_code,1,2)='"+districtcode+"' and substr(bridge_code,6,2)='"+mandalcode+"' and substr(bridge_code,13,2)='"+panchayatcode+"' and substr(bridge_code,8,3)='"+villagecode+"'");
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


	            stmt7=conn.createStatement();
				rs7=stmt7.executeQuery("select count(*) from RWS_PWS_GLBR_SC_PARAM_TBL     where asset_code= '"+assetcode+"' and substr(glbr_code,1,2)='"+districtcode+"' and substr(glbr_code,6,2)='"+mandalcode+"' and substr(glbr_code,13,2)='"+panchayatcode+"' and substr(glbr_code,8,3)='"+villagecode+"'   ");
			
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

	            stmt8=conn.createStatement();
				rs8=stmt8.executeQuery("select count(*) from RWS_PWS_GLSR_SC_PARAM_TBL     where asset_code= '"+assetcode+"'  and substr(glsr_code,1,2)='"+districtcode+"' and substr(glsr_code,6,2)='"+mandalcode+"' and substr(glsr_code,13,2)='"+panchayatcode+"' and substr(glsr_code,8,3)='"+villagecode+"'   ");
			
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

//RWS_CPWS_GRAVITYMAIN_TBL 
stmt9=conn.createStatement();
				rs9=stmt9.executeQuery("select count(*) from RWS_PWS_GRAVITYMAIN_TBL      where asset_code= '"+assetcode+"'  and substr(gravitymain_code,1,2)='"+districtcode+"' and substr(gravitymain_code,6,2)='"+mandalcode+"' and substr(gravitymain_code,13,2)='"+panchayatcode+"' and substr(gravitymain_code,8,3)='"+villagecode+"'   ");
			
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
				//RWS_CPWS_OHBR_SC_PARAM_TBL 
                stmt10=conn.createStatement();
				rs10=stmt10.executeQuery("select count(*) from RWS_PWS_OHBR_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(ohbr_code,1,2)='"+districtcode+"' and substr(ohbr_code,6,2)='"+mandalcode+"' and substr(ohbr_code,13,2)='"+panchayatcode+"' and substr(ohbr_code,8,3)='"+villagecode+"'    ");
			
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
//RWS_CPWS_OHSR_SC_PARAM_TBL 
stmt11=conn.createStatement();
rs11=stmt11.executeQuery("select count(*) from RWS_PWS_OHSR_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(ohsr_code,1,2)='"+districtcode+"' and substr(ohsr_code,6,2)='"+mandalcode+"' and substr(ohsr_code,13,2)='"+panchayatcode+"' and substr(ohsr_code,8,3)='"+villagecode+"'   ");
			
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
	
//RWS_CPWS_OTHERS_PARAM_TBL 
stmt12=conn.createStatement();
rs12=stmt12.executeQuery("select count(*) from RWS_PWS_OTHERS_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(other_comp_code,1,2)='"+districtcode+"' and substr(other_comp_code,6,2)='"+mandalcode+"' and substr(other_comp_code,13,2)='"+panchayatcode+"' and substr(other_comp_code,8,3)='"+villagecode+"'   ");
			
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

//RWS_CPWS_PUMPHOUSE_PARAM_TBL
stmt14=conn.createStatement();
rs14=stmt14.executeQuery("select count(*) from RWS_PWS_PUMPHOUSE_PARAM_TBL  where asset_code= '"+ assetcode+"'  and substr(pumphouse_code,1,2)='"+districtcode+"' and substr(pumphouse_code,6,2)='"+mandalcode+"' and substr(pumphouse_code,13,2)='"+panchayatcode+"' and substr(pumphouse_code,8,3)='"+villagecode+"'    ");
			
				while(rs14.next())
				{
					count14=rs14.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Pump House</td>
				<td class=rptValue><a href="rws_pumphouse_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count14%></a></td>
				</tr>
				
<%
	
							}
     
//RWS_CPWS_PUMPINGMAIN_TB
			stmt15=conn.createStatement();
rs15=stmt15.executeQuery("select count(*) from RWS_PWS_PUMPINGMAIN_TBl  where asset_code= '"+assetcode +"'  and substr(pumpingmain_code,1,2)='"+districtcode+"' and substr(pumpingmain_code,6,2)='"+mandalcode+"' and substr(pumpingmain_code,13,2)='"+panchayatcode+"' and substr(pumpingmain_code,8,3)='"+villagecode+"'   ");
			
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
			
//RWS_CPWS_PUMP_DET_SC_PARAM_TBL 
	 //RWS_CPWS_RW_COLLWELL_PARAM_TBL 
		stmt17=conn.createStatement();
        rs17=stmt17.executeQuery("select count(*) from RWS_PWS_RW_COLLWELL_PARAM_TBL    where asset_code= '"+assetcode+"'   and substr(rw_collwell_code,1,2)='"+districtcode+"' and substr(rw_collwell_code,6,2)='"+mandalcode+"' and substr(rw_collwell_code,13,2)='"+panchayatcode+"' and substr(rw_collwell_code,8,3)='"+villagecode+"'");
			
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
				
//RWS_CPWS_SS_SC_PARAM_TBL 
		stmt18=conn.createStatement();
rs18=stmt18.executeQuery("select count(*) from RWS_PWS_SS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   and substr(sssc_code,1,2)='"+districtcode+"' and substr(sssc_code,6,2)='"+mandalcode+"' and substr(sssc_code,13,2)='"+panchayatcode+"' and substr(sssc_code,8,3)='"+villagecode+"'   ");
			
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
		
//RWS_CPWS_SUBCOMP_PARAM_TBL 
	stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select count(*) from RWS_PWS_SUBCOMP_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(pump_code,1,2)='"+districtcode+"' and substr(pump_code,6,2)='"+mandalcode+"' and substr(pump_code,13,2)='"+panchayatcode+"' and substr(pump_code,8,3)='"+villagecode+"'    ");
			
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
				


	
//RWS_CPWS_SUMP_M_SC_PARAM_TBL 
	stmt20=conn.createStatement();
rs20=stmt20.executeQuery("select count(*) from RWS_PWS_SUMP_M_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(sumpcode,1,2)='"+districtcode+"' and substr(sumpcode,6,2)='"+mandalcode+"' and substr(sumpcode,13,2)='"+panchayatcode+"' and substr(sumpcode,8,3)='"+villagecode+"'  ");
			
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
				//RWS_CPWS_WATCHMAN_PARAM_TBL 
					stmt21=conn.createStatement();
rs21=stmt21.executeQuery("select count(*) from RWS_PWS_WATCHMAN_PARAM_TBL   where asset_code= '"+assetcode+"'  and substr(watchman_code,1,2)='"+districtcode+"' and substr(watchman_code,6,2)='"+mandalcode+"' and substr(watchman_code,13,2)='"+panchayatcode+"' and substr(watchman_code,8,3)='"+villagecode+"'");
			
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

	stmt23=conn.createStatement();
	rs23=stmt23.executeQuery("select count(*),p.source_type_code,substr(p.source_code,17,3) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '6%%' and p.source_type_code=s.source_type_code and substr(p.source_code,1,2)='" + districtcode + "' and substr(p.source_code,6,2)='" + mandalcode + "' and substr(p.source_code,13,2)='" + panchayatcode + "' and substr(p.source_code,8,3)='" + villagecode + "' and asset_code='" + assetcode + "' and p.source_type_code='1' group by p.source_type_code,substr(p.source_code,17,3) ");
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
	rs24=stmt24.executeQuery("select count(*),p.source_type_code,substr(p.source_code,17,3) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '6%%' and p.source_type_code=s.source_type_code and substr(p.source_code,1,2)='" + districtcode + "' and substr(p.source_code,6,2)='" + mandalcode + "' and substr(p.source_code,13,2)='" + panchayatcode + "' and substr(p.source_code,8,3)='" + villagecode + "' and asset_code='" + assetcode + "' and p.source_type_code='2' group by p.source_type_code,substr(p.source_code,17,3) ");
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
		
		//RWS_CPWS_WTP_SC_PARAM_TBL 
	stmt22=conn.createStatement();
rs22=stmt22.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_PWS_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"' and substr(wtpsc_code,20,2) like 'R%' GROUP BY SUBSTR(WTPSC_CODE,20,2) ");
			
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
	//ss filter
stmt42=conn.createStatement();
rs42=stmt42.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_PWS_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"' and substr(wtpsc_code,20,2) like 'S%' group by substr(wtpsc_code,20,2) ");
			
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
	

	}

if(typeassetcode.equals("07"))
	{

	
	stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select count(*) from rws_openwell_pond_tbl     where asset_code='"+assetcode+"'  and substr(hab_code,1,2)='"+districtcode+"' and substr(hab_code,6,2)='"+mandalcode+"' and substr(hab_code,13,2)='"+panchayatcode+"' and substr(hab_code,8,3)='"+villagecode+"'   ");
			
				while(rs19.next())
				{
					
					count19=rs19.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Ponds</td>
				<td class=rptValue><a href="rws_ponds_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count19%></a></td>
				
				</tr>
				
<%
	
			}
	


//end of if
	}


		
		if(typeassetcode.equals("05"))
	{

	
	stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select count(*),substr(pond_code,17,3) from RWS_SHALLOWHANDPUMPS_TBL     where asset_code= '"+ assetcode+"'  and substr(hab_code,1,2)='"+districtcode+"' and substr(hab_code,6,2)='"+mandalcode+"' and substr(hab_code,13,2)='"+panchayatcode+"' and substr(hab_code,8,3)='"+villagecode+"'  and substr(pond_code,17,3) like '7%%' group by substr(pond_code,17,3)  ");
			
				while(rs19.next())
				{
					
					count19=rs19.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>ShallowHandPumps</td>
				<td class=rptValue><a href="rws_shallow_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count19%></a></td>
				
				</tr>
				
<%
	
			}
	


//end of if
	}


							if(typeassetcode.equals("04"))
	{

	
	stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select count(*) from rws_hp_subcomp_param_tbl     where asset_code= '"+ assetcode+"'  and substr(hp_code,1,2)='"+districtcode+"' and substr(hp_code,6,2)='"+mandalcode+"' and substr(hp_code,13,2)='"+panchayatcode+"' and substr(hp_code,8,3)='"+villagecode+"'      ");
			
				while(rs19.next())
				{
					
					count19=rs19.getInt(1);

						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>HandPumps</td>
				<td class=rptValue><a href="rws_handpumps_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>
				&assetcode=<%=assetcode%>&panchname=<%=panchname%>"><%=count19%></a></td>
				
				</tr>
				
<%
	
			}
	


//end of if
	}

	if(typeassetcode.equals("06"))
	{

	
	stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select count(*) from rws_open_well_mast_tbl     where asset_code='"+assetcode+"'  and substr(habitation_code,1,2)='"+districtcode+"' and substr(habitation_code,6,2)='"+mandalcode+"' and substr(habitation_code,13,2)='"+panchayatcode+"' and substr(habitation_code,8,3)='"+villagecode+"'   ");
			
				while(rs19.next())
				{
					
					count19=rs19.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Openwells</td>
				<td class=rptValue><a href="rws_openwell_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count19%></a></td>
				
				</tr>
				
<%
	
			}
	


//end of if
	}


	//mpws
	if(typeassetcode.equals("02"))
	{
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery("select  count(*) from rws_mpws_bpt_param_tbl where asset_code='" + assetcode + "' and substr(bpt_code,1,2)='" + districtcode + "' and substr(bpt_code,6,2)='" + mandalcode + "' and substr(bpt_code,13,2)='" + panchayatcode + "' and substr(bpt_code,8,3)='" + villagecode + "'  ");
		while(rs1.next())
    	{
			count1=rs1.getInt(1);
				%>
				
				<tr bgcolor="#ffffff">
				
				<td class=rptValue>Bpt</td>
				<td class=rptValue><a href="rws_bpt.jsp?assetcode=<%=assetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&typeassetcode=<%=typeassetcode%>"><%=count1%></a></td>
				</tr>
			




<%


			
			
			
		}
							
				stmt2=conn.createStatement();
				rs2=stmt2.executeQuery("select count(*) from RWS_MPWS_CIS_SC_PARAM_TBL where asset_code= '"+assetcode+"' and substr(cissc_code,1,2)='"+districtcode+"' and substr(cissc_code,6,2)='" +mandalcode+"' and substr(cissc_code,13,2)='"+panchayatcode+"' 	and substr(cissc_code,8,3)='" +villagecode+"'    ");
			
				while(rs2.next())
				{
					count2=rs2.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Cisterns</td>
				<td class=rptValue><a href="rws_cisterns_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count2%></td>				</tr>
				
<%
			
				}
				stmt5=conn.createStatement();
				rs5=stmt5.executeQuery("select count(*) from RWS_MPWS_DISTRI_SC_PARAM_TBL   where asset_code= '"+assetcode+"'  and substr(distrisc_code,1,2)='"+districtcode+"' and substr(distrisc_code,6,2)='"+mandalcode+"' and substr(distrisc_code,13,2)='"+panchayatcode+"' and substr(distrisc_code,8,3)='"+villagecode+"'    ");
			
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
				stmt4=conn.createStatement();
				rs4=stmt4.executeQuery("select count(*) from RWS_MPWS_CW_COLLWELL_PARAM_TBL  where asset_code= '"+assetcode+"' and substr(cw_collwell_code,1,2)='"+districtcode+"' and substr(cw_collwell_code,6,2)='"+mandalcode+"' and substr(cw_collwell_code,13,2)='"+panchayatcode+"' and substr(cw_collwell_code,8,3)='"+villagecode+"'");
			
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

                


                stmt6=conn.createStatement();
				rs6=stmt6.executeQuery("select count(*) from RWS_MPWS_FP_BRIDGE_PARAM_TBL    where asset_code= '"+assetcode+"' and substr(bridge_code,1,2)='"+districtcode+"' and substr(bridge_code,6,2)='"+mandalcode+"' and substr(bridge_code,13,2)='"+panchayatcode+"' and substr(bridge_code,8,3)='"+villagecode+"'");
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


	            stmt7=conn.createStatement();
				rs7=stmt7.executeQuery("select count(*) from RWS_MPWS_GLBR_SC_PARAM_TBL     where asset_code= '"+assetcode+"' and substr(glbr_code,1,2)='"+districtcode+"' and substr(glbr_code,6,2)='"+mandalcode+"' and substr(glbr_code,13,2)='"+panchayatcode+"' and substr(glbr_code,8,3)='"+villagecode+"'   ");
			
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

	            stmt8=conn.createStatement();
				rs8=stmt8.executeQuery("select count(*) from RWS_MPWS_GLSR_SC_PARAM_TBL     where asset_code= '"+assetcode+"'  and substr(glsr_code,1,2)='"+districtcode+"' and substr(glsr_code,6,2)='"+mandalcode+"' and substr(glsr_code,13,2)='"+panchayatcode+"' and substr(glsr_code,8,3)='"+villagecode+"'   ");
			
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

//RWS_CPWS_GRAVITYMAIN_TBL 
stmt9=conn.createStatement();
				rs9=stmt9.executeQuery("select count(*) from RWS_MPWS_GRAVITYMAIN_TBL      where asset_code= '"+assetcode+"'  and substr(gravitymain_code,1,2)='"+districtcode+"' and substr(gravitymain_code,6,2)='"+mandalcode+"' and substr(gravitymain_code,13,2)='"+panchayatcode+"' and substr(gravitymain_code,8,3)='"+villagecode+"'   ");
			
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
				//RWS_CPWS_OHBR_SC_PARAM_TBL 
                stmt10=conn.createStatement();
				rs10=stmt10.executeQuery("select count(*) from RWS_MPWS_OHBR_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(ohbr_code,1,2)='"+districtcode+"' and substr(ohbr_code,6,2)='"+mandalcode+"' and substr(ohbr_code,13,2)='"+panchayatcode+"' and substr(ohbr_code,8,3)='"+villagecode+"'    ");
			
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
//RWS_CPWS_OHSR_SC_PARAM_TBL 
stmt11=conn.createStatement();
rs11=stmt11.executeQuery("select count(*) from RWS_MPWS_OHSR_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(ohsr_code,1,2)='"+districtcode+"' and substr(ohsr_code,6,2)='"+mandalcode+"' and substr(ohsr_code,13,2)='"+panchayatcode+"' and substr(ohsr_code,8,3)='"+villagecode+"'   ");
			
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
	
//RWS_CPWS_OTHERS_PARAM_TBL 
stmt12=conn.createStatement();
rs12=stmt12.executeQuery("select count(*) from RWS_MPWS_OTHERS_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(other_comp_code,1,2)='"+districtcode+"' and substr(other_comp_code,6,2)='"+mandalcode+"' and substr(other_comp_code,13,2)='"+panchayatcode+"' and substr(other_comp_code,8,3)='"+villagecode+"'   ");
			
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

//RWS_CPWS_PUMPHOUSE_PARAM_TBL
stmt14=conn.createStatement();
rs14=stmt14.executeQuery("select count(*) from RWS_MPWS_PUMPHOUSE_PARAM_TBL  where asset_code= '"+ assetcode+"'  and substr(pumphouse_code,1,2)='"+districtcode+"' and substr(pumphouse_code,6,2)='"+mandalcode+"' and substr(pumphouse_code,13,2)='"+panchayatcode+"' and substr(pumphouse_code,8,3)='"+villagecode+"'    ");
			
				while(rs14.next())
				{
					count14=rs14.getInt(1);
						%>
				<tr bgcolor="#ffffff">
				<td class=rptValue>Pump House</td>
				<td class=rptValue><a href="rws_pumphouse_rpt.jsp?typeassetcode=<%=typeassetcode%>&districtcode=<%=districtcode%>&mandalcode=<%=mandalcode%>&panchayatcode=<%=panchayatcode%>&villagecode=<%=villagecode%>&typeassetname=<%=typeassetname%>&districtname=<%=districtname%>&mandalname=<%=mandalname%>&panchayatname=<%=panchayatname%>&villagename=<%=villagename%>&assetcode=<%=assetcode%>"><%=count14%></a></td>
				</tr>
				
<%
	
							}
     
//RWS_CPWS_PUMPINGMAIN_TB
			stmt15=conn.createStatement();
rs15=stmt15.executeQuery("select count(*) from RWS_MPWS_PUMPINGMAIN_TBl  where asset_code= '"+assetcode +"'  and substr(pumpingmain_code,1,2)='"+districtcode+"' and substr(pumpingmain_code,6,2)='"+mandalcode+"' and substr(pumpingmain_code,13,2)='"+panchayatcode+"' and substr(pumpingmain_code,8,3)='"+villagecode+"'   ");
			
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
			
//RWS_CPWS_PUMP_DET_SC_PARAM_TBL 
	 //RWS_CPWS_RW_COLLWELL_PARAM_TBL 
		stmt17=conn.createStatement();
        rs17=stmt17.executeQuery("select count(*) from RWS_MPWS_RW_COLLWELL_PARAM_TBL    where asset_code= '"+assetcode+"'   and substr(rw_collwell_code,1,2)='"+districtcode+"' and substr(rw_collwell_code,6,2)='"+mandalcode+"' and substr(rw_collwell_code,13,2)='"+panchayatcode+"' and substr(rw_collwell_code,8,3)='"+villagecode+"'");
			
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
				
//RWS_CPWS_SS_SC_PARAM_TBL 
		stmt18=conn.createStatement();
rs18=stmt18.executeQuery("select count(*) from RWS_MPWS_SS_SC_PARAM_TBL    where asset_code= '"+ assetcode+"'   and substr(sssc_code,1,2)='"+districtcode+"' and substr(sssc_code,6,2)='"+mandalcode+"' and substr(sssc_code,13,2)='"+panchayatcode+"' and substr(sssc_code,8,3)='"+villagecode+"'   ");
			
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
		
//RWS_CPWS_SUBCOMP_PARAM_TBL 
	stmt19=conn.createStatement();
rs19=stmt19.executeQuery("select count(*) from RWS_MPWS_SUBCOMP_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(pump_code,1,2)='"+districtcode+"' and substr(pump_code,6,2)='"+mandalcode+"' and substr(pump_code,13,2)='"+panchayatcode+"' and substr(pump_code,8,3)='"+villagecode+"'    ");
			
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
				


	
//RWS_CPWS_SUMP_M_SC_PARAM_TBL 
	stmt20=conn.createStatement();
rs20=stmt20.executeQuery("select count(*) from RWS_MPWS_SUMP_M_SC_PARAM_TBL     where asset_code= '"+ assetcode+"'  and substr(sumpcode,1,2)='"+districtcode+"' and substr(sumpcode,6,2)='"+mandalcode+"' and substr(sumpcode,13,2)='"+panchayatcode+"' and substr(sumpcode,8,3)='"+villagecode+"'  ");
			
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
				//RWS_CPWS_WATCHMAN_PARAM_TBL 
					stmt21=conn.createStatement();
rs21=stmt21.executeQuery("select count(*) from RWS_MPWS_WATCHMAN_PARAM_TBL   where asset_code= '"+assetcode+"'  and substr(watchman_code,1,2)='"+districtcode+"' and substr(watchman_code,6,2)='"+mandalcode+"' and substr(watchman_code,13,2)='"+panchayatcode+"' and substr(watchman_code,8,3)='"+villagecode+"'");
			
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

	stmt23=conn.createStatement();
	rs23=stmt23.executeQuery("select count(*),p.source_type_code,substr(p.source_code,17,3) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '4%%' and p.source_type_code=s.source_type_code and substr(p.source_code,1,2)='" + districtcode + "' and substr(p.source_code,6,2)='" + mandalcode + "' and substr(p.source_code,13,2)='" + panchayatcode + "' and substr(p.source_code,8,3)='" + villagecode + "' and asset_code='" + assetcode + "' and p.source_type_code='1' group by p.source_type_code,substr(p.source_code,17,3) ");
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
	rs24=stmt24.executeQuery("select count(*),p.source_type_code,substr(p.source_code,17,3) from rws_source_tbl p,rws_source_type_tbl s where substr(source_code,17,3) like '4%%' and p.source_type_code=s.source_type_code and substr(p.source_code,1,2)='" + districtcode + "' and substr(p.source_code,6,2)='" + mandalcode + "' and substr(p.source_code,13,2)='" + panchayatcode + "' and substr(p.source_code,8,3)='" + villagecode + "' and asset_code='" + assetcode + "' and p.source_type_code='2' group by p.source_type_code,substr(p.source_code,17,3) ");
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
		
		//RWS_CPWS_WTP_SC_PARAM_TBL 
	stmt22=conn.createStatement();
rs22=stmt22.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_MPWS_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"' and substr(wtpsc_code,20,2) like 'R%' GROUP BY SUBSTR(WTPSC_CODE,20,2) ");
			
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
	//ss filter
stmt42=conn.createStatement();
rs42=stmt42.executeQuery("select count(*),substr(wtpsc_code,20,2) from RWS_MPWS_WTP_SC_PARAM_TBL       where asset_code= '"+assetcode+"'  and substr(wtpsc_code,1,2)='"+districtcode+"' and substr(wtpsc_code,6,2)='"+mandalcode+"' and substr(wtpsc_code,13,2)='"+panchayatcode+"' and substr(wtpsc_code,8,3)='"+villagecode+"' and substr(wtpsc_code,20,2) like 'S%' group by substr(wtpsc_code,20,2) ");
			
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
	

	}
		







			

		}
	
catch(Exception e)
{
	out.println("Exception"+e);
}
%>
</table>
</form>

</body>

<%@ include file="/commons/rws_footer.jsp" %>
</p>
</html>
