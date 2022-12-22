
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
String typeassetcode="";
int sno=1;
int psno=0;
int tot=0;
int total=0;
Statement stmt1=null;
ResultSet rs1=null;
String districtname="";
String districtcode="";
String typeassetname="";
typeassetname=request.getParameter("typeassetname");

typeassetcode=request.getParameter("asset_name");

%>
<p align=center>

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="50%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="rws_graph_frm1.jsp">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home</a></td>
			
			</tr>
			
		</table>
	</caption>
	<tr bgcolor="#edf2f8" align="center">
		<td class=rptValue colspan=3><font color="navy"> Asset: <%=typeassetname%></td>
	</tr>
	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Assets - District Wise</td>
</tr>
</table>
<table border=1 cellpadding=0 cellspacing=0 width="50%">
<tr align=center bgcolor="#ffffff">
<td class=btext>Sl.No</td>
<td class=btext>District</td>
<td class=btext>Total</td>
</tr>

<%
try
{
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery("select  count(*),d.dname,d.dcode from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_district_tbl d,rws_asset_scheme_tbl s where  a.type_of_asset_code='" + typeassetcode + "' and b.asset_code=s.asset_code  and d.dcode=substr(b.hab_code,1,2) and b.type_of_asset_code=a.type_of_asset_code  group by d.dname,d.dcode order by d.dname "); 

   while(rs1.next())

	{
		psno++;
		districtname=rs1.getString(2);
		
		session.setAttribute("typeassetcode",typeassetcode);
		total=rs1.getInt(1);
		tot=tot+total;
		%>
		<tr bgcolor="#ffffff">
		<td class=rptValue><%=sno++%></td>
		<td class=rptValue><a href="rws_mandal_rpt.jsp?districtcode=<%=rs1.getString(3)%>&districtname=<%=rs1.getString(2)%>&typeassetname=<%=typeassetname%>&typeassetcode=<%=typeassetcode%>"><%=districtname%></a></td>
		<td class=rptValue><%=total%></td>
		</tr>
		
		<%
	}
		%>
			<tr>
		<td class=rptValue >Total:</td>
		<td></td>
		
		<td class=rptValue ><%=tot%></td>
		</tr>
		<%
			if(psno==0)
		{
%>
	<tr bgcolor="#FFFFFF" align="center">
		<td class="rptSubValue" colspan="3">NO RECORDS FOR YOUR QUERY...</td>	
	</tr>
	<%
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




