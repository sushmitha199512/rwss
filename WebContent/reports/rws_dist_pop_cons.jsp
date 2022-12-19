<%@ include file = "conn.jsp" %>
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
	String dcode = request.getParameter("district");
	nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();

%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">
function fnDistSubmit()
	{ 
	 var logValue = '<%=loggedUser%>';
 if(logValue=="admin" || logValue=="secrwss" || logValue=="minrwss"  || logValue=="100000" || logValue=="ce_vqc"|| logValue=="ce_stp"|| logValue=="ce_nab"|| logValue=="pdccdu"|| logValue=="pdswsm"|| logValue=="cerwss"|| logValue=="ENC")
			{
	document.f1.dname.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text;
	 
	document.f1.action="./rws_const_coverage_rpt.jsp";
		document.f1.submit();
		}
		else{
		 document.f1.action="./rws_const_coverage_rpt.jsp";
		document.f1.submit();
		}
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
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Constituency Wise-Population Report</font>
			</td>	
		</tr>


<%

%>
<TR> 
	<TD   valign=top  align="center" height="30%" width="100%">
<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>
		<% 

dcode = request.getParameter("district");
String query="";
%>

	
<tr colspan=2>
	<td align="center"><font color=navy face="verdana" size="2"><b>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("secrwss")||loggedUser.equals("minrwss")||loggedUser.equals("100000")||loggedUser.toString().equals("ENC")||loggedUser.toString().equals("cerwss")||loggedUser.toString().equals("pdswsm")||loggedUser.toString().equals("pdccdu")||loggedUser.toString().equals("ce_nab")||loggedUser.toString().equals("ce_stp")||loggedUser.toString().equals("ce_vqc")))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
	 <option value="">-Select-</option>
		
		<%

		    stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl d ,rws_aap_selected_tbl b  where d.dcode<>16  and substr(b.work_id,5,2)=d.dcode  order by d.dname";
			rs = stmt.executeQuery(query);
		 while(rs.next())
		{
			
				if(rs.getString(1).equals(dcode))
				{
					
				%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
			<%
				}
				else
				{
			%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
			<%
				}
			}
						rs.close();			
						stmt.close();
		}
		else
		{
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
			
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>

		
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
<input type="hidden" name="dname">
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>


