<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%@	page import="java.sql.*, java.util.*, java.util.Date, java.text.* " %>
<%
	Statement stq1=null,st2=null,stq3=null,stq4=null,st3=null,st44=null;
	ResultSet  rsq1=null,rs2=null,rsq3=null,rsq4=null,rs3=null;
	int sno=1;
	int total1=0,total2=0,total3=0,total4=0,total5=0,total6=0,total7=0,total8=0,total9=0,total10=0,total11=0,total12=0,total13=0,total14=0,total15=0,total16=0,total17=0,total18=0,total19=0,total20=0,total21=0,total22=0,total23=0;
	int totalInserted = 0;
	Statement stqq =null,popst=null; 
	ResultSet rsqq = null,poprs=null;
	String per = request.getParameter("per");
	String dir_tbl  = "",per_tbl="";
%>
<html>
<title> WaterSoft </title>
<head>
<script>
window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 0 cellspacing = 0 cellpadding = 0 width=50% bordercolor=#000000 style="border-collapse:collapse">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "left">			
			<tr align="left">
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
			</tr>
		</table>
	</caption>
	<tr>
		<td class="textborder" align="center" colspan="8">&nbsp;</td>
	</tr>
	<tr>
		<td class="textborder" align="center" colspan="8">Coverage Status&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="per" onchange="this.form.submit()">
			<option value="">Select..</option>
			<%
				if(per!=null && per.equals("NC")){%>
				<option value="NC" selected>NC</option>
				<option value="NSS">NSS</option>
				<option value="PC1">PC1</option>
				<option value="PC2">PC2</option>
				<option value="PC3">PC3</option>
				<option value="PC4">PC4</option>
				<option value="FC">FC</option>
			<%}
			else if(per!=null && per.equals("NSS")){%>
				<option value="NC">NC</option>
				<option value="NSS" selected>NSS</option>
				<option value="PC1">PC1</option>
				<option value="PC2">PC2</option>
				<option value="PC3">PC3</option>
				<option value="PC4">PC4</option>
				<option value="FC">FC</option>
			<%}
			else if(per!=null && per.equals("PC1")){%>
				<option value="NC">NC</option>
				<option value="NSS">NSS</option>
				<option value="PC1" selected>PC1</option>
				<option value="PC2">PC2</option>
				<option value="PC3">PC3</option>
				<option value="PC4">PC4</option>
				<option value="FC">FC</option>
			<%}
			else if(per!=null && per.equals("PC2")){%>
				<option value="NC">NC</option>
				<option value="NSS">NSS</option>
				<option value="PC1">PC1</option>
				<option value="PC2" selected>PC2</option>
				<option value="PC3">PC3</option>
				<option value="PC4">PC4</option>
				<option value="FC">FC</option>
			<%}
			else if(per!=null && per.equals("PC3")){%>
				<option value="NC">NC</option>
				<option value="NSS">NSS</option>
				<option value="PC1">PC1</option>
				<option value="PC2">PC2</option>
				<option value="PC3" selected>PC3</option>
				<option value="PC4">PC4</option>
				<option value="FC">FC</option>
			<%}
			else if(per!=null && per.equals("PC4")){%>
				<option value="NC">NC</option>
				<option value="NSS">NSS</option>
				<option value="PC1">PC1</option>
				<option value="PC2">PC2</option>
				<option value="PC3">PC3</option>
				<option value="PC4" selected>PC4</option>
				<option value="FC">FC</option>
			<%}
			else if(per!=null && per.equals("FC")){%>
				<option value="NC">NC</option>
				<option value="NSS">NSS</option>
				<option value="PC1">PC1</option>
				<option value="PC2">PC2</option>
				<option value="PC3">PC3</option>
				<option value="PC4">PC4</option>
				<option value="FC" selected>FC</option>
			<%}
			else {%>
				<option value="NC">NC</option>
				<option value="NSS">NSS</option>
				<option value="PC1">PC1</option>
				<option value="PC2">PC2</option>
				<option value="PC3">PC3</option>
				<option value="PC4">PC4</option>
				<option value="FC">FC</option>
			<%}
			%>
		</select>
		</td>
	</tr>
</table>
<BR>
<%
if(per!=null && !per.equals("")){
try
{
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>Coverage of <%=per%> Habitations Under SpillOver Works </td>	
	</tr>
	<tr align = center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		<td class=btext rowspan = 2>Mandal</td>
		<td class=btext rowspan = 2>Panchayat</td>
		<td class=btext rowspan = 2>Village</td>
		<td class=btext rowspan = 2 nowrap>Habitation</td>
		<td class=btext colspan = 3>Population</td>
		<td class=btext rowspan = 2 nowrap>Work Name</td>
		<td class=btext rowspan = 2>Work Id</td>
		<td class=btext rowspan = 2>Est.Cost<BR>(In Lakhs)</td>
	</tr>
	<tr align = center>
		<td class=btext>Plain</td>
		<td class=btext>SC</td>
		<td class=btext>ST</td>
	</tr>
	<%
	try
		{
	st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	String qrry = "select b.work_id,b.sanction_amount,b.work_name,d.*,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU from RWS_WORK_ADMN_TBL B,RWS_ADMN_HAB_LNK_TBL c,rws_complete_hab_view d WHERE c.hab_code=d.panch_code and b.work_id=c.work_id and work_cancel_dt is null and b.work_id in (select work_id from RWS_DDWS_SCHEME_DATA_PORT where work_asset='W' minus select distinct work_id from RWS_DDWS_WORKS_MPR_TBL) and coverage_status='"+per+"' order by d.dname,work_id";
	//System.out.println("qrry:"+qrry);
	rs2=st2.executeQuery(qrry);
	stq1=conn.createStatement();
	while(rs2.next())
		{
			%>			
			<tr>	
				<td class="rptValue"><%=sno++%></td>
				<td class="rptValue"><%=rs2.getString(5)%></td>
				<td class="rptValue"><%=rs2.getString(7)%></td>
				<td class="rptValue"><%=rs2.getString(9)%></td>
				<td class="rptValue"><%=rs2.getString(11)%></td>
				<td class="rptValue"><%=rs2.getString(13)%></td>
				<td class="rptValue" nowrap><%=rs2.getString(14)%></td>
				<td class="rptValue"><%=rs2.getString(15)%></td>
				<td class="rptValue" ALIGN="RIGHT"><%=rs2.getString(16)%></td>
				<td class="rptValue" nowrap><%=rs2.getString(3)%></td>
				<td class="rptValue"><%=rs2.getString(1)%></td>
				<td class="rptValue" align="right"><%=rs2.getString(2)%></td>
			</tr>
		<%
		}
			}catch(Exception e)
			{e.printStackTrace();}
	}
	catch(Exception e)
	{e.printStackTrace();}
	finally
	{
		try
		{
			if(rs2!=null)rs2.close();
			if(st2!=null)st2.close();
			if(conn!=null)conn.close();
		}
		catch(Exception e)
		{e.printStackTrace();}
	}
	
 	%>
</table>
<%}
	else
	{
		%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=25>Coverage of <%=per%> Habitations Under SpillOver Works </td>	
	</tr>
	<tr align = center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		<td class=btext rowspan = 2>Mandal</td>
		<td class=btext rowspan = 2>Panchayat</td>
		<td class=btext rowspan = 2>Village</td>
		<td class=btext rowspan = 2>Habitation</td>
		<td class=btext colspan = 3>Population</td>
		<td class=btext rowspan = 2>Work Name</td>
		<td class=btext rowspan = 2>Work Id</td>
		<td class=btext rowspan = 2>Est.Cost<BR>(In Lakhs)</td>
	</tr>
	<tr align = center>
		<td class=btext>Plain</td>
		<td class=btext>SC</td>
		<td class=btext>ST</td>
	</tr>
	</table>
<%}%>
<p>
<font face="verdana" size="2" color="red"><b>Note:**** 1.</b> Coverage of Habitations Under SpillOver Works i.e., Project Shelf Works Carried from 2009-10 to 2010-11</font>
</p>
</form>
</body>
</html>

