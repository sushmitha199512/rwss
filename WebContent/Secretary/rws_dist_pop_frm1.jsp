<%@ include file = "/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		try{
	Statement stmt1 = null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;

	Statement st3 = null;
	ResultSet rs3 = null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	 ResultSet rs5=null;
	
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">
	window.history.forward(1);
function unview()
{
    var a=document.getElementById('date').value;
	alert(a);
	if(a!="0")
	{
       document.getElementById('dist').disabled=true;
	}
	 
}
function fnSubmit()

{	
	if(document.f1.district.selectedIndex=="")
	{
	
		alert("SELECT DISTRICT...");		
		return false;
	}
	/*if(document.f1.FDate.selectedIndex=="")
	{
	
		alert("SELECT Status Date...");		
		return false;
	}*/
	
}
function fnDistSubmit()
	{ 
		//document.f1.action="./rws_dist_pop_rpt.jsp";
		document.f1.action="./rws_dist_popstatus_rpt.jsp";
		//document.f1.action="./rws_dist_popcate_rpt.jsp";
		document.f1.submit();
		
	}
	

</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post" onLoad="unview()">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
			<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">DistrictWise-Population Report</font>
			</td>	
		</tr>


<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String Tchart = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String dCode=null;
	String mCode=null;
	String pCode=null;
	String fromDate=null;
	String Fdate=null;
	String toDate=null;
	String TDATE=null;	
	
%>
<TR> 
	<TD   valign=top  align="center" height="30%" width="100%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>
		<% 
	rDist = request.getParameter("district");
	//System.out.println("Rdist   "   +rDist);
	%>
	<td class = btext><font color=navy><b>District</b> </font>
	<font color=red><b>*</b> </font></td>
	<td class = btext colspan=3><SELECT name="district" id="date" style="width:125px" class="mycombo" >
	
	<option value="51" SELECTed> ALL</option>
	<% 
		session.setAttribute("dName","ALL");
		session.setAttribute("dCode",rDist);
	%>
		</tr>
	
	</table>
</TD></TR>
<TR>	
<TD colspan=2 align=center valign=top>	


			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button id="dist" onclick="fnDistSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
	<%
		
		conn.close();
		} catch(Exception e){	
			e.printStackTrace();
			}
	

		%>
</TD></TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "/reports/footer.jsp" %>


