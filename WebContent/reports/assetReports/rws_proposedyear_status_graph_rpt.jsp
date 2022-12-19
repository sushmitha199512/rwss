<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*,java.text.SimpleDateFormat" %>
<%@ include file ="/reports/conn.jsp"  %>

<%	
    int totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnc=0,totnss=0,tot=0;
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null,r8=null;
	int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};	
	String query = null, a1="";
%>

<html>
<head>
<title> WaterSoft </title>
<script>
window.history.forward(1);
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
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="rws_graph_frm1.jsp">Back |</a>
				<a href="/pred/home.jsp">Home </a>
				<!--<a href="../home.jsp">Print |</a>
				<a href="../home.jsp">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff"> Assets  </font></td>
	</tr>
<tr><td valign=top align=center>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	

</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width="15%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<%
try
{
%>
	


	
	<%@ include file = "rws_proposed_FCyr_tot_rpt.jsp" %>
		 
		

			
		
	 <%@ include file = "rws_proposed_FCyr_graph.jsp" %>
	 <%
}
	 catch(Exception e)
	 {
		 out.println("Exception"+e);
	 }
	 
	 finally
{
try
{
if(rs!=null)
{
rs.close();
}
if(stmt!=null)
{
stmt.close();
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

</TD></TR>
</TABLE>

</body>
</html>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
