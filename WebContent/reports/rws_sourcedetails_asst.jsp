<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st=null,st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null,rs9=null,
	rs10 = null,rs11=null,rs12=null,rs13=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null,qu=null, a1="",codename=null,mand=null,mname=null,dist=null,dname=null,panch=null,pname=null,vill=null,vname=null,habcode=null,hname=null,code=null,sourcecode=null;
     String a="";
	 code=request.getParameter("code");
	 sourcecode=request.getParameter("sourcecode");%>
<html>
<title> WaterSoft </title>
<head>
<!--<script>
		window.history.forward(1);
	</script>-->
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}


</style>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">


<table border = 1 cellspacing = 0 cellpadding = 0 width=50% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_hab_asset_status_no_frm.jsp">Back|</a>
				<a href="../home.jsp">Home|</a>
				<!--<a href="./rws_cir_div_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;-->
				<!--<a href="./rws_cir_div_status_rpt_print_excel.jsp" target="_new">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" >
			<font color="ffffff">Sources Status Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
    <tr><% 
	if(request.getParameter("dname")!=null){%>
<td align="center" class="mystyle1"><font color="navy">District: <%=request.getParameter("dname") %>&nbsp;&nbsp;&nbsp;<%=codename%>&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(request.getParameter("mname")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Mandal:<%=request.getParameter("mname") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%} if(request.getParameter("pname")!=null){%>
<td align="center" nowrap class="mystyle1"><font color="navy">Panchayat: <%=request.getParameter("pname") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%} if(request.getParameter("vname")!=null){%>
<td align="center" nowrap class="mystyle1"><font color="navy">Village: <%=request.getParameter("vname") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(request.getParameter("hname")!=null){%>
<td align="center" nowrap class="mystyle1"><font color="navy">Habitation:<%=request.getParameter("hname") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	 <% if(code.equals("HP"))
	 {
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>Habitation</td>
		<td class="btext" align=center>HandPumpCode</td>
		<td class="btext" align=center >Location</td>
		<td class="btext" align=center>Diameter</td>
		<td class="btext" align=center>Depth(Mts)</td>
		<td class="btext" align=center>Casing(Type)</td>
		<td class="btext" align=center>No of<br>GI Pipes</td>
		<td class="btext" align=center>General<br>Condition</td>
		<td class="btext" align=center>Static Water Level(Mts)</td>
		<td class="btext" align=center>Summer Water Level(Mts)</td>
		<td class="btext" align=center>No of hrs<br>Serving<br>per day</td>
		<td class="btext" align=center>Hp No<br> Painted</td>
		<td class="btext" align=center>Repairs<br> Per Year</td>
		<td class="btext" align=center>Drain</td>
		<td class="btext" align=center>Drain<br> Condition</td>
		<td class="btext" align=center>Hygiene</td>
		<td class="btext" align=center>Avg Time<BR>to Fill<br>10 Lts</td>
		
	</tr>
     <%
	 }
	else if(code.equals("POND"))
	{
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>Habitation</td>
		<td class="btext" align=center>PondCode</td>
		<td class="btext" align=center>PondName</td>
		<td class="btext" align=center>Location</td>
		<td class="btext" align=center>AreaSize</td>
		<td class="btext" align=center>Vol of<br>Storage(cum)</td>
		<td class="btext" align=center>Hygenity</td>
		<td class="btext" align=center>Purpose</td>
		<td class="btext" align=center>Fed By</td>
		<td class="btext" align=center>Fed Name</td>
		<td class="btext" align=center>WaterQuality</td>
		</tr>
     <%
	 }
	 else if(code.equals("OPENWELL"))
	{
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>Habitation</td>
		<td class="btext" align=center>OpenwellCode </td>
		<td class="btext" align=center>Location</td>
		<td class="btext" align=center>Diameter</td>
		<td class="btext" align=center>Depth(Mts)</td>
		<td class="btext" align=center>Normal<br>Water Level(Mts)</td>
		<td class="btext" align=center>Minimum<br>Water Level(Mts)</td>
		<td class="btext" align=center>Maximum<br>Water Level(Mts)</td>
		<td class="btext" align=center>Platform Exists</td>
		<td class="btext" align=center>Platform Condition</td>
		<td class="btext" align=center>Purpose</td>
        <td class="btext" align=center>Quality</td>
		</tr>
     <%
	 }
	 else if(code.equals("SHALLOW"))
	{
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>Habitation</td>
		<td class="btext" align=center>ShallowHandPumpCode</td>
		<td class="btext" align=center>Location</td>
		<td class="btext" align=center>Diameter</td>
		<td class="btext" align=center>Depth(Mts)</td>
		<td class="btext" align=center>Hygiene</td>
		<td class="btext" align=center>Avg Time</td>
		<td class="btext" align=center>Avg Hours</td>
		<td class="btext" align=center>WaterQuality</td>
		</tr>
     <%
	 }
	  else if(code.equals("PWSPUMPSETS") || code.equals("MPWSPUMPSETS") || code.equals("CPWSPUMPSETS"))
	{
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>Habitation</td>
		<td class="btext" align=center>PumpCode</td>
		<td class="btext" align=center>Location</td>
		<td class="btext" align=center>PumpMake</td>
		<td class="btext" align=center>PumpType</td>
		<td class="btext" align=center>PumpCapacity</td>
		<td class="btext" align=center>YearsOf<br>Commissioning</td>
		<td class="btext" align=center>HoursRunning<br>PerDay</td>
		<td class="btext" align=center>Usage</td>
		<td class="btext" align=center>Designed<br>Head</td>
		<td class="btext" align=center>Designed<br>LPM</td>
		<td class="btext" align=center>ControlPanel</td>
		<td class="btext" align=center>Feeder</td>
		<td class="btext" align=center>Hours Of Power<br>Availability </td>
		<td class="btext" align=center>Feasibility Of<br>getting<br>Urban Line</td>
		<td class="btext" align=center>App.Cost Of<br>Urban Feeder<br>Rs.(in Lakhs)</td>
		<td class="btext" align=center>Distance From<br>Where Urban Line<br>Can Be Had</td>
		<td class="btext" align=center>Low Voltage<br>Problems</td>
		<td class="btext" align=center>Remarks</td>
		
		</tr>
     <%
	 }

		else if(code.equals("PWSSUBSURFACE") || code.equals("PWSSURFACE") || code.equals("CPWSSUBSURFACE") || code.equals("CPWSSURFACE") || code.equals("MPWSSUBSURFACE") || code.equals("MPWSSURFACE") )
	{
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>Habitation</td>
		<td class="btext" align=center>SourceCode</td>
		<td class="btext" align=center>SourceName</td>
		<td class="btext" align=center>No Of<br>Habitations Covered</td>
		<td class="btext" align=center>Population<br>Benefitted</td>
		<td class="btext" align=center>Seasonal</td>
		<td class="btext" align=center>SourceCondition</td>
		<td class="btext" align=center>StaticWaterLevel</td>
		<td class="btext" align=center>SummerWaterLevel</td>
		<td class="btext" align=center>Yeild</td>
		<td class="btext" align=center>DistanceNear<br>WaterSource</td>
		<td class="btext" align=center>WaterQuality</td>
		<td class="btext" align=center>Location</td>
		<td class="btext" align=center>Depth(Mts)</td>
		<td class="btext" align=center>Diameter</td>
		<td class="btext" align=center>Type</td>
		</tr>
     <%
	 }

try
{

st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);


if(code.equals("HP") && sourcecode!=null)
	{
qu="SELECT * from rws_hp_subcomp_param_tbl where hp_code='"+sourcecode+"'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,rws_hp_subcomp_param_tbl h where pr.panch_code=substr(h.hp_code,1,16) and h.hp_code='"+sourcecode+"'";
	}
	else if(code.equals("POND") && sourcecode!=null)
	{
qu="SELECT * from rws_OPENWELL_POND_TBL where POND_code='"+sourcecode+"'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,rws_OPENWELL_POND_TBL h where pr.panch_code=substr(h.POND_code,1,16) and h.POND_code='"+sourcecode+"'";
	}
	else if(code.equals("OPENWELL") && sourcecode!=null)
	{
qu="SELECT * from rws_OPEN_WELL_mast_TBL where OPENWELL_code='"+sourcecode+"'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,rws_OPEN_WELL_MAST_TBL h where pr.panch_code=substr(h.OPENWELL_code,1,16) and h.OPENWELL_code='"+sourcecode+"'";
	}
	else if(code.equals("SHALLOW") && sourcecode!=null)
	{
qu="SELECT * from rws_SHALLOWHANDPUMPS_TBL where SHALLOWHP_code='"+sourcecode+"'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,rws_SHALLOWHANDPUMPS_TBL h where pr.panch_code=substr(h.SHALLOWHP_code,1,16) and h.SHALLOWHP_code='"+sourcecode+"'";
	}
	else if(code.equals("PWSPUMPSETS") && sourcecode!=null)
	{
qu="SELECT * from RWS_AST_SUBCOMP_PARAM_TBL where PUMP_code='"+sourcecode+"'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,RWS_AST_SUBCOMP_PARAM_TBL h where pr.panch_code=substr(h.PUMP_code,1,16) and h.PUMP_code='"+sourcecode+"'";
	}
	else if(code.equals("MPWSPUMPSETS") && sourcecode!=null)
	{
qu="SELECT * from RWS_AST_SUBCOMP_PARAM_TBL where PUMP_code='"+sourcecode+"'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,RWS_AST_SUBCOMP_PARAM_TBL h where pr.panch_code=substr(h.PUMP_code,1,16) and h.PUMP_code='"+sourcecode+"'";
	}
	else if(code.equals("CPWSPUMPSETS") && sourcecode!=null)
	{
qu="SELECT * from RWS_AST_SUBCOMP_PARAM_TBL where PUMP_code='"+sourcecode+"'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,RWS_AST_SUBCOMP_PARAM_TBL h where pr.panch_code=substr(h.PUMP_code,1,16) and h.PUMP_code='"+sourcecode+"'";
	}
	else if(code.equals("PWSSUBSURFACE") && sourcecode!=null)
	{
qu="SELECT * from RWS_SOURCE_TBL where SOURCE_code='"+sourcecode+"' and source_type_code='1'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,RWS_SOURCE_TBL h where pr.panch_code=substr(h.SOURCE_code,1,16) and h.SOURCE_code='"+sourcecode+"'";
	}
	else if(code.equals("PWSSURFACE") && sourcecode!=null)
	{
qu="SELECT * from RWS_SOURCE_TBL where SOURCE_code='"+sourcecode+"' and source_type_code='2'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,RWS_SOURCE_TBL h where pr.panch_code=substr(h.SOURCE_code,1,16) and h.SOURCE_code='"+sourcecode+"'";
	}
	else if(code.equals("CPWSSUBSURFACE") && sourcecode!=null)
	{
qu="SELECT * from RWS_SOURCE_TBL where SOURCE_code='"+sourcecode+"' and source_type_code='1'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,RWS_SOURCE_TBL h where pr.panch_code=substr(h.SOURCE_code,1,16) and h.SOURCE_code='"+sourcecode+"'";
	}
	else if(code.equals("CPWSSURFACE") && sourcecode!=null)
	{
qu="SELECT * from RWS_SOURCE_TBL where SOURCE_code='"+sourcecode+"' and source_type_code='2'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,RWS_SOURCE_TBL h where pr.panch_code=substr(h.SOURCE_code,1,16) and h.SOURCE_code='"+sourcecode+"'";
	}
	else if(code.equals("MPWSSUBSURFACE") && sourcecode!=null)
	{
qu="SELECT * from RWS_SOURCE_TBL where SOURCE_code='"+sourcecode+"' and source_type_code='1'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,RWS_SOURCE_TBL h where pr.panch_code=substr(h.SOURCE_code,1,16) and h.SOURCE_code='"+sourcecode+"'";
	}
	else if(code.equals("MPWSSURFACE") && sourcecode!=null)
	{
qu="SELECT * from RWS_SOURCE_TBL where SOURCE_code='"+sourcecode+"' and source_type_code='2'";
query="select distinct pr.panch_name from rws_panchayat_raj_tbl pr,RWS_SOURCE_TBL h where pr.panch_code=substr(h.SOURCE_code,1,16) and h.SOURCE_code='"+sourcecode+"'";
	}

	

	
	
    rs1=st1.executeQuery(qu);
	rs2=st2.executeQuery(query);
	rs1.next();
	rs2.next();

	 int slno=0,total=0;
	if(code.equals("HP"))
	 {
	%>      <TR>
		<td class=rptValue align=center><%=++slno%></td>
        <td class=rptValue align=center><%=rs2.getString(1)%></td>
		<td class=rptValue align=center><%=rs1.getString("HP_CODE")%></td>
		<td class=rptValue align=center><%=rs1.getString("LOCATION")==null ? "-" : rs1.getString("LOCATION")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DIAMETER")==null ? "-" : rs1.getString("DIAMETER")%></td>
		<td class=rptValue align=center><%=rs1.getString("DEPTH")==null ? "-" : rs1.getString("DEPTH")%></TD>
		<td class=rptValue align=center><%=rs1.getString("CASING")==null ? "-" : rs1.getString("CASING")%></td>
		<td class=rptValue align=center><%=rs1.getString("GI_NO")==null ? "-" : rs1.getString("GI_NO")%></TD>
		<td class=rptValue align=center><%=rs1.getString("GEN_CONDITION")==null ? "-" : rs1.getString("GEN_CONDITION")%></td>
		<td class=rptValue align=center><%=rs1.getString("STATIC_WL")==null ? "-" : rs1.getString("STATIC_WL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("SUMMER_WL")==null ? "-" : rs1.getString("SUMMER_WL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("SER_HRS")==null ? "-" : rs1.getString("SER_HRS")%></TD>
		<td class=rptValue align=center><%=rs1.getString("PAINTED")==null ? "-" : rs1.getString("PAINTED")%></TD>
		<td class=rptValue align=center><%=rs1.getString("REPAIRS")==null ? "-" : rs1.getString("REPAIRS")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DRAIN")==null ? "-" : rs1.getString("DRAIN")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DRAIN_CONDITION")==null ? "-" : rs1.getString("DRAIN_CONDITION")%></TD>
		<td class=rptValue align=center><%=rs1.getString("HYGIENE")==null ? "-" : rs1.getString("HYGIENE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("AVG_TIME")==null ? "-" : rs1.getString("AVG_TIME")%></TD>
		
</TR>
<%
	 }
else if(code.equals("POND"))
	 {
	%>      <TR>
		<td class=rptValue align=center><%=++slno%></td>
        <td class=rptValue align=center><%=rs2.getString(1)%></td>
		<td class=rptValue align=center><%=rs1.getString("POND_CODE")==null ? "-" : rs1.getString("POND_CODE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("POND_NAME")==null ? "-" : rs1.getString("POND_NAME")%></TD>
		<td class=rptValue align=center><%=rs1.getString("POND_LOCATION")==null ? "-" : rs1.getString("POND_LOCATION")%></TD>
		<td class=rptValue align=center><%=rs1.getString("SIZE_AREA")==null ? "-" : rs1.getString("SIZE_AREA")%></TD>
		<td class=rptValue align=center><%=rs1.getString("STORAGE_VOL")==null ? "-" : rs1.getString("STORAGE_VOL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("HYGENITY")==null ? "-" : rs1.getString("HYGENITY")%></TD>
		<td class=rptValue align=center><%=rs1.getString("USAGE_PURPOSE")==null ? "-" : rs1.getString("USAGE_PURPOSE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("FED_BY")==null ? "-" : rs1.getString("FED_BY")%></TD>
		<td class=rptValue align=center><%=rs1.getString("FED_NAME")==null ? "-" : rs1.getString("FED_NAME")%></TD>
		<td class=rptValue align=center><%=rs1.getString("WATER_QUALITY")==null ? "-" : rs1.getString("WATER_QUALITY")%></TD>
	</TR>
<%
	 } 
	 else if(code.equals("OPENWELL"))
	 {
	%>      <TR>
		<td class=rptValue align=center><%=++slno%></td>
        <td class=rptValue align=center><%=rs2.getString(1)%></td>
		<td class=rptValue align=center><%=rs1.getString("OPENWELL_CODE")==null ? "-" : rs1.getString("OPENWELL_CODE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("LOCATION")==null ? "-" : rs1.getString("LOCATION")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DIAMETER")==null ? "-" : rs1.getString("DIAMETER")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DEPTH")==null ? "-" : rs1.getString("DEPTH")%></TD>
		<td class=rptValue align=center><%=rs1.getString("NORMAL_WATER_LEVEL")==null ? "-" : rs1.getString("NORMAL_WATER_LEVEL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("MIN_WATER_LEVEL")==null ? "-" : rs1.getString("MIN_WATER_LEVEL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("MAX_WATER_LEVEL")==null ? "-" : rs1.getString("MAX_WATER_LEVEL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("PLATFORM_EXISTS")==null ? "-" : rs1.getString("PLATFORM_EXISTS")%></TD>
		<td class=rptValue align=center><%=rs1.getString("PLATFORM_CONDITION")==null ? "-" : rs1.getString("PLATFORM_CONDITION")%></TD>
		<td class=rptValue align=center><%=rs1.getString("PURPOSE")==null ? "-" : rs1.getString("PURPOSE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("QUALITY")==null ? "-" : rs1.getString("QUALITY")%></TD>
	</TR>
<%
	 } 
	else if(code.equals("SHALLOW"))
	 {
	%>      <TR>
		<td class=rptValue align=center><%=++slno%></td>
        <td class=rptValue align=center><%=rs2.getString(1)%></td>
		<td class=rptValue align=center><%=rs1.getString("SHALLOWHP_CODE")==null ? "-" : rs1.getString("SHALLOWHP_CODE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("LOCATION")==null ? "-" : rs1.getString("LOCATION")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DIAMETER")==null ? "-" : rs1.getString("DIAMETER")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DEPTH")==null ? "-" : rs1.getString("DEPTH")%></TD>
		<td class=rptValue align=center><%=rs1.getString("HYGIENE")==null ? "-" : rs1.getString("HYGIENE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("AVERAGE_TIME")==null ? "-" : rs1.getString("AVERAGE_TIME")%></TD>
		<td class=rptValue align=center><%=rs1.getString("AVERAGE_HOURS")==null ? "-" : rs1.getString("AVERAGE_HOURS")%></TD>
		<td class=rptValue align=center><%=rs1.getString("WATER_QUALITY")==null ? "-" : rs1.getString("WATER_QUALITY")%></TD>
		</TR>
<%
	 }
	else if(code.equals("PWSPUMPSETS")|| code.equals("CPWSPUMPSETS")||code.equals("MPWSPUMPSETS"))
	 {
	%>      <TR>
		<td class=rptValue align=center><%=++slno%></td>
        <td class=rptValue align=center><%=rs2.getString(1)%></td>
		<td class=rptValue align=center><%=rs1.getString("PUMP_CODE")==null ? "-" : rs1.getString("PUMP_CODE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("LOCATION")==null ? "-" : rs1.getString("LOCATION")%></TD>
		<td class=rptValue align=center><%=rs1.getString("PUMP_MAKE")==null ? "-" : rs1.getString("PUMP_MAKE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("PUMP_CPTY")==null ? "-" : rs1.getString("PUMP_CPTY")%></TD>
		<td class=rptValue align=center><%=rs1.getString("PUMP_TYPE")==null ? "-" : rs1.getString("PUMP_TYPE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("YEAR_COMM")==null ? "-" : rs1.getString("YEAR_COMM")%></TD>
		<td class=rptValue align=center><%=rs1.getString("HR_RUN")==null ? "-" : rs1.getString("HR_RUN")%></TD>
		<td class=rptValue align=center><%=rs1.getString("USAGE")==null ? "-" : rs1.getString("USAGE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DESIGNED_HEAD")==null ? "-" : rs1.getString("DESIGNED_HEAD")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DESIGNED_LPM")==null ? "-" : rs1.getString("DESIGNED_LPM")%></TD>
		<td class=rptValue align=center><%=rs1.getString("CONTROL_PANEL")==null ? "-" : rs1.getString("CONTROL_PANEL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("FEEDER")==null ? "-" : rs1.getString("FEEDER")%></TD>
		<td class=rptValue align=center><%=rs1.getString("POWER_AVAIL_PER_DAY")==null ? "-" : rs1.getString("POWER_AVAIL_PER_DAY")%></TD>
		<td class=rptValue align=center><%=rs1.getString("FEAS_URBAN_LINE")==null ? "-" : rs1.getString("FEAS_URBAN_LINE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("COST")==null ? "-" : rs1.getString("COST")%></TD>
		<td class=rptValue align=center><%=rs1.getString("URBAN_LINE_DISTANCE")==null ? "-" : rs1.getString("URBAN_LINE_DISTANCE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("LOW_VOLT_PROB")==null ? "-" : rs1.getString("LOW_VOLT_PROB")%></TD>
		<td class=rptValue align=center><%=rs1.getString("SUGGESTIONS")==null ? "-" : rs1.getString("SUGGESTIONS")%></TD>
		</TR>
<%
	 } 
	else if(code.equals("PWSSUBSURFACE") || code.equals("PWSSURFACE") || code.equals("CPWSSUBSURFACE") || code.equals("CPWSSURFACE") || code.equals("MPWSSUBSURFACE") || code.equals("MPWSSURFACE"))
	 {
	%>      <TR>
		<td class=rptValue align=center><%=++slno%></td>
        <td class=rptValue align=center><%=rs2.getString(1)%></td>
		<td class=rptValue align=center><%=rs1.getString("SOURCE_CODE")==null ? "-" : rs1.getString("SOURCE_CODE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("SOURCE_NAME")==null ? "-" : rs1.getString("SOURCE_NAME")%></TD>
		<td class=rptValue align=center><%=rs1.getString("NO_OF_HABITAITONS_COVERD")==null ? "-" : rs1.getString("NO_OF_HABITAITONS_COVERD")%></TD>
		<td class=rptValue align=center><%=rs1.getString("POPULATION_BENIFITED")==null ? "-" : rs1.getString("POPULATION_BENIFITED")%></TD>
		<td class=rptValue align=center><%=rs1.getString("SEASONAL")==null ? "-" : rs1.getString("SEASONAL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("SOURCE_CONDITION")==null ? "-" : rs1.getString("SOURCE_CONDITION")%></TD>
		<td class=rptValue align=center><%=rs1.getString("STATIC_WATER_LEVEL")==null ? "-" : rs1.getString("STATIC_WATER_LEVEL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("SUMMER_WATER_LEVEL")==null ? "-" : rs1.getString("SUMMER_WATER_LEVEL")%></TD>
		<td class=rptValue align=center><%=rs1.getString("YIELD")==null ? "-" : rs1.getString("YIELD")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DIST_NEAR_PRIVATE_SOURCE")==null ? "-" : rs1.getString("DIST_NEAR_PRIVATE_SOURCE")%></TD>
		<td class=rptValue align=center><%=rs1.getString("WATER_QUALITY")==null ? "-" : rs1.getString("WATER_QUALITY")%></TD>
		<td class=rptValue align=center><%=rs1.getString("LOCATION")==null ? "-" : rs1.getString("LOCATION")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DIAMETER")==null ? "-" : rs1.getString("DIAMETER")%></TD>
		<td class=rptValue align=center><%=rs1.getString("DEPTH")==null ? "-" : rs1.getString("DEPTH")%></TD>
		<td class=rptValue align=center><%=rs1.getString("TYPE")==null ? "-" : rs1.getString("TYPE")%></TD>
		</TR>
<%
	 } %>
	</table>	
<% }
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>

