<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%@ include file="/reports/conn.jsp" %>
<%! public String isNull(String str){
if(str==null)
return "-";
else return str;} %>
<%! public String isNull1(int str){
if(str==0)
return "-";
else return str+"";
} %>



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


int psno=0;
int tot=0;
int total=0;
Statement stmt1=null;
ResultSet rs1=null;

String pname="";
String vname="";

String typeassetname="";
typeassetname=request.getParameter("typeassetname");

String assetcode="";
assetcode=request.getParameter("assetcode");

int sno=1;
String districtcode="";
String mandalcode="";
String panchayatcode="";
String villagecode="";
String mandalname="";
String districtname="";
String panchayatname="";
String villagename="";

districtname=request.getParameter("districtname");
mandalname=request.getParameter("mandalname");
panchayatname=request.getParameter("panchayatname");
villagename=request.getParameter("villagename");

districtcode=request.getParameter("districtcode");
mandalcode=request.getParameter("mandalcode");
panchayatcode=request.getParameter("panchayatcode");
villagecode=request.getParameter("villagecode");
String habcode="";
habcode=request.getParameter("habcode");
String typeassetcode="";
typeassetcode=request.getParameter("typeassetcode");

%>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>
			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#edf2f8" align="center">
		<td class=rptValue colspan=3>
<font   color="navy">Asset:<%=typeassetname%>&nbsp;District:<%=districtname%>&nbsp;Mandal:<%=mandalname%>&nbsp;Panchayat:<%=panchayatname%>&nbsp;Village:<%=villagename%></td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan="14"> Assets - PUMPHOUSE </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Pump Code</td>
			   <td class=btext>Location</td>
			   <td class=btext>Pump Make</td>
			   <td class=btext>Pump Capacity(in HP)</td>
			   <td class=btext>Pump Type</td>
			   <td class=btext>Year of Commissioning</td>
			   <td class=btext>Hours Running per Day</td>
			   <td class=btext>Usage</td>
			   <td class=btext>Designed Head</td>
			   <td class=btext>Designed LPM</td>
			   
			   
			   <td class=btext>Hours Of Power Availability</td>
			   <td class=btext>Low Voltage Problems</td>
			   <td class=btext>Remarks</td>
			   <td class=btext>Feeder</td>
			   
			   <td class=btext>Generator Existing</td>
			   </tr>


<%

try
{
	 

//String pumpquery="select  pump_code,nvl(pump_make,'-'),pump_cpty,nvl(pump_type,'-'),nvl(year_comm,'-'),hr_run,nvl(usage,'-'),designed_lpm,designed_head,nvl(control_panel,'-'),nvl(low_volt_prob,'-'),power_avail_per_day,nvl(feas_urban_line,'-'),cost,urban_line_distance,nvl(suggestions,'-'),nvl(location,'-'),nvl(feeder,'-') from rws_ast_subcomp_param_tbl  where asset_code='" + assetcode + "' and substr(pump_code,1,2)='" + districtcode + "' and substr(pump_code,6,2)='" + mandalcode + "' and substr(pump_code,13,2)='" + panchayatcode + "' and substr(pump_code,8,3)='" + villagecode + "'";
//String pumpquery="select  pump_code,nvl(pump_make,'-'),pump_cpty,nvl(pump_type,'-'),nvl(year_comm,'-'),hr_run,nvl(usage,'-'),designed_lpm,designed_head,nvl(control_panel,'-'),nvl(low_volt_prob,'-'),power_avail_per_day,nvl(feas_urban_line,'-'),cost,urban_line_distance,nvl(suggestions,'-'),nvl(location,'-'),nvl(feeder,'-'),nvl(generator_existing,'-') from rws_ast_subcomp_param_tbl  where asset_code='" + assetcode + "'";
String query="select PUMP_CODE,nvl(LOCATION,'-'),nvl(PUMP_MAKE,'-'),nvl(PUMP_TYPE,'-'),nvl(PUMP_CPTY,0),nvl(YEAR_COMM,'-'),nvl(HR_RUN,0),decode(USAGE,'S','Stand By','R','Regular')usage,nvl(DESIGNED_HEAD,0.0),nvl(DESIGNED_LPM,0.0),nvl(POWER_AVAIL_PER_DAY,0.0),decode(LOW_VOLT_PROB,'Y','Yes','N','No'),nvl(SUGGESTIONS,'-'),nvl(FEEDER,'-'),decode(GENERATOR_EXISTING,'Y','Yes','N','No')generator from rws_ast_subcomp_param_tbl where asset_code='"+assetcode+"'";
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(query);
		while(rs1.next())
    	{
    	    	
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString("PUMP_CODE")%></td>
				<td class=rptValue><%=isNull(rs1.getString(2))%></td>
				<td class=rptValue><%=isNull(rs1.getString(3))%></td>
				<td class=rptValue><%=isNull(rs1.getString(4))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(5))%></td>
				<td class=rptValue><%=isNull(rs1.getString(6))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(7))%></td>
				<td class=rptValue><%=isNull(rs1.getString(8))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(9))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(10))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(11))%></td>
				<td class=rptValue><%=isNull(rs1.getString(12))%></td>
				<td class=rptValue><%=isNull(rs1.getString(13))%></td>
				<td class=rptValue><%=isNull(rs1.getString(14))%></td>
				<td class=rptValue><%=isNull(rs1.getString(15))%></td>
				</tr>
			

	
<%	}
}
catch(Exception e)
{
	out.println("Exception"+e);
}
finally
{
try
{
if(rs1!=null)
{
rs1.close();
}
if(stmt1!=null)
{
stmt1.close();
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

<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>

</p>
</html>
