<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*,java.text.SimpleDateFormat" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		int totfc=0,totpc1=0,totpc2=0,totpc3=0,totpc4=0,totnc=0,totnss=0,tot=0;
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null,r8=null;
	int[] colors = {0xb8bc9c, 0xa0bdc4, 0x999966, 0x333366, 0xc3c3e6};	
	String query = null, a1="";

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");
 

 
 String dCode=(String)session.getAttribute("dCode");
 String mCode=(String)session.getAttribute("mCode"); 
 String pCode=(String)session.getAttribute("pCode"); 

String prgmType=request.getParameter("program");
session.setAttribute("prgmType",prgmType);
System.out.println("prgmType"+prgmType);
String prgmName=request.getParameter("prgname");
	

int start=0,end,limit = 10;
	int Cnt,pgn,tpn;

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

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_wrks_progress_graph_frm.jsp">Back |</a>
				<a href="../home.jsp">Home </a>
				<!--<a href="../home.jsp">Print |</a>-->
				<!--<a href="./rws_borewell_dist_tot_rpt_xls.jsp?dcode=<%=dCode%>">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Work Status Progress Graph  for <%=prgmName %> Programe</font></td>
	</tr>
<tr><td valign=top align=center>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
	<tr><% if(!dCode.equals("51")|| dCode.equals("51")) {%>
	<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("dName") %><% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>


</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
%>


<table border = 1 cellspacing = 0 cellpadding = 0 width="15%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	
	
<%
int Count=0,i=0;
// //.out.println("coount of rows is    ");
try
		{
	
	if(district.equals("51")){

		%>	<%@ include file="./rws_wrks_progress_graph_tot.jsp" %>
		
		<%	}  
		 else if(!district.equals("51")){

		%>	<%@ include file="./rws_wrks_progress_graph_tot.jsp" %>
		
		<%	} %> 
		
	 <%@ include file = "./rws_wrks_progress_graph.jsp"%>	
	<%
	}
	catch(Exception ee)
	{
	//response.sendRedirect("./ErrorPage.jsp");
	}
	finally
	{
		conn.close();
	}
%>
</table>

</TD></TR>
</TABLE>

</body>
</html>

<%@ include file = "footer.jsp" %>
