<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%@ include file="/reports/conn.jsp" %>

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
String type="";
type=request.getParameter("rs");

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
				<td class="bwborder"><a href="rws_graph_frm1.jsp">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>
			
			</tr>
		</table>
	</caption>
	<tr bgcolor="#edf2f8" align="center">
		<td class=rptValue colspan=3><font color="navy">Asset:<%=typeassetname%>&nbsp;District:<%=districtname%>&nbsp;Mandal:<%=mandalname%>&nbsp;Panchayat:<%=panchayatname%>&nbsp;Village:<%=villagename%></td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Assets - FILTERS </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>WtpSc Code</td>
			   <td class=btext>Wtp Typew</td>
			   <td class=btext>Wtp Mld</td>
			   <td class=btext>Wtp Size</td>
			   <td class=btext>Units Stand By</td>
			   <td class=btext>Back Wash Frequency</td>
			   <td class=btext>Performance</td>
			   <td class=btext>Use Capcity Mld</td>
			   <td class=btext>Extension Scope</td>
			   <td class=btext>Frequency Sand Scrap</td>
			   <td class=btext>Asset Code</td>
			   </tr>


<%

try
{
//	 String query="select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_AST_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "' and substr(wtpsc_code,1,2)='" + districtcode + "' and substr(wtpsc_code,6,2)='" + mandalcode + "' and substr(wtpsc_code,13,2)='" + panchayatcode + "' and substr(wtpsc_code,8,3)='" + villagecode + "' and substr(wtpsc_code,20,2)='" + type + "' "
	 String query="select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_AST_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "' and substr(wtpsc_code,20,2)='" + type + "' ";

	     if(type.equals("RS"))
		{
		stmt1=conn.createStatement();
		rs1=stmt1.executeQuery(query);
		while(rs1.next())
    	{
 %>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
				</tr>
<%
}
		}
		 if(type.equals("SS"))
		{
stmt1=conn.createStatement();
//String query="select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_AST_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "' and substr(wtpsc_code,1,2)='" + districtcode + "' and substr(wtpsc_code,6,2)='" + mandalcode + "' and substr(wtpsc_code,13,2)='" + panchayatcode + "' and substr(wtpsc_code,8,3)='" + villagecode + "' and substr(wtpsc_code,20,2)='" + type + "' ";
 query="select  wtpsc_code,nvl(wtp_typw,'-'),wtp_mld,nvl(wtp_size,'-'),units_standby,backwash_feq,nvl(performance,'-'),nvl(use_capacitymld,'0'),nvl(extention_scope,'-'),nvl(freq_sand_scrap,'0'),asset_code from RWS_AST_WTP_SC_PARAM_TBL   where asset_code='" + assetcode + "'and substr(wtpsc_code,20,2)='" + type + "' ";
		rs1=stmt1.executeQuery(query);
		while(rs1.next())
    	{
	     				%>
				
				<tr bgcolor="#ffffff">
				<td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=rs1.getString(2)%></td>
				<td class=rptValue><%=rs1.getInt(3)%></td>
				<td class=rptValue><%=rs1.getString(4)%></td>
				<td class=rptValue><%=rs1.getInt(5)%></td>
				<td class=rptValue><%=rs1.getInt(6)%></td>
				<td class=rptValue><%=rs1.getString(7)%></td>
				<td class=rptValue><%=rs1.getString(8)%></td>
				<td class=rptValue><%=rs1.getString(9)%></td>
				<td class=rptValue><%=rs1.getString(10)%></td>
				<td class=rptValue><%=rs1.getInt(11)%></td>
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
