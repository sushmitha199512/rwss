<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%@ include file="/reports/conn.jsp" %>
<%! public String isNull1(int str){
if(str==0)
return "-";
else return str+"";
} %>
<%! public String isNull(String str){
if(str==null)
return "-";
else return str;} %>



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

int sno=0;
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
String panchcode="";
panchcode=request.getParameter("panchcode");
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
		<td class=rptValue colspan=3><font color="navy">Asset:<%=typeassetname%>&nbsp;District:<%=districtname%>&nbsp;Mandal:<%=mandalname%>&nbsp;Panchayat:<%=panchayatname%>&nbsp;Village:<%=villagename%></td>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan="14"> Assets - OPENWELL </td>
</tr>
</table>
<table border=1 cellpadding=1 cellspacing=1 width="100%">
<tr align=center>
               <td class=btext>Sl.No</td>
			   <td class=btext>Openwell Code</td>
			   <td class=btext>Location</td>
			   <td class=btext>Diameter</td>
			   <td class=btext>Depth</td>
			   <td class=btext>Normal Water Level</td>
			   <td class=btext>Minimum Water Level</td>
			   <td class=btext>Maximum Water Level</td>
			   <td class=btext>Platform Exists</td>
			   <td class=btext>PlatForm Condition</td>
			   <td class=btext>Purpose</td>
			   <td class=btext>Quality</td>
			   <td class=btext>Flouride Percentage</td>
			   <td class=btext>Brakish Percentage</td>
			   <td class=btext>Iron Percentage</td>
			   <td class=btext>Other Type</td>
			   <td class=btext>Other Percentage</td>
			   <td class=btext>Flouride</td>
			   <td class=btext>Brakish</td>
			   <td class=btext>Iron</td>
			   <td class=btext>Others</td>
			   </tr>

<%

try
{


   
		stmt1=conn.createStatement();
	
String query=null;
//query="select  openwell_code,nvl(location,'-'),nvl(diameter,0),nvl(depth,0),nvl(normal_water_level,0),nvl(min_water_level,0),nvl(max_water_level,0),nvl(platform_exists,'-'),nvl(platform_condition,'-'),purpose,quality,nvl(flouride_per,0),nvl(brakish_per,0),nvl(iron_per,0),nvl(other_type,'-'),nvl(other_per,0),nvl(rad_flouride,'-'),nvl(rad_brakish,'-'),nvl(rad_iron,'-'),nvl(rad_others,'-') from rws_open_well_mast_tbl where  substr(openwell_code,1,2)='"+districtcode+"' and substr(openwell_code,6,2)='"+mandalcode+"' and substr(openwell_code,13,2)='"+panchayatcode+"' and substr(openwell_code,8,3)='"+villagecode+"' and asset_code='"+assetcode+"' ";
query="select  openwell_code,nvl(location,'-'),nvl(diameter,0),nvl(depth,0),nvl(normal_water_level,0),nvl(min_water_level,0),nvl(max_water_level,0),nvl(platform_exists,'-'),nvl(platform_condition,'-'),purpose,quality,nvl(flouride_per,0),nvl(brakish_per,0),nvl(iron_per,0),nvl(other_type,'-'),nvl(other_per,0),nvl(rad_flouride,'-'),nvl(rad_brakish,'-'),nvl(rad_iron,'-'),nvl(rad_others,'-') from rws_open_well_mast_tbl where   asset_code='"+assetcode+"' ";
		rs1=stmt1.executeQuery(query);
		while(rs1.next())
    	{
			sno++;
		

			
				%>
 

				
				<tr bgcolor="#ffffff">
                <td class=rptValue><%=sno++%></td>
				<td class=rptValue><%=rs1.getString(1)%></td>
				<td class=rptValue><%=isNull(rs1.getString(2))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(3))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(4))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(5))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(6))%></td>
                 <td class=rptValue><%=isNull1(rs1.getInt(7))%></td>
                <td class=rptValue><%=isNull(rs1.getString(8))%></td>
				<td class=rptValue><%=isNull(rs1.getString(9))%></td>
				<td class=rptValue><%=isNull(rs1.getString(10))%></td>
		        <td class=rptValue><%=isNull(rs1.getString(11))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(12))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(13))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(14))%></td>
				<td class=rptValue><%=isNull(rs1.getString(15))%></td>
				<td class=rptValue><%=isNull1(rs1.getInt(16))%></td>
                <td class=rptValue><%=isNull(rs1.getString(17))%></td> 
                <td class=rptValue><%=isNull(rs1.getString(18))%></td> 
				<td class=rptValue><%=isNull(rs1.getString(19))%></td>
				<td class=rptValue><%=isNull(rs1.getString(20))%></td>
				</tr>


<%
if(sno==0)
	{
			%>
			<tr>
				<td align="center" class="rptHeading" colspan="14"> No Records for your query  </td>
				</tr>
				<%
	}

 	

			
			
			
		}

		
}
catch(Exception e)
{
e.printStackTrace();	
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

</html>
