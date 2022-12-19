<%@ page import="java.text.DecimalFormat,java.math.BigDecimal,java.util.*" %>
<%@ page import="nic.watersoft.commons.CommonLists" %>
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%	
	String printValue = request.getParameter("printValue");
	printValue = "Y";
	System.out.println(printValue);
	Statement st1=null,st2=null,st3=null,st4=null,st5=null;
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
	int sno=1;
	String per = request.getParameter("per");
	String assetname = request.getParameter("assetname");
	int col1=0,col2=0,col3=0;double col4=0;
try
{
	if(printValue!=null && printValue.equals("Y")){response.setContentType("application/vnd.ms-excel");}
	else{response.setContentType("text/plain");%>
	<%@ include file="/commons/rws_header2.jsp"%>
	<%}%>
<html>
<title> WaterSoft </title>
<head>
<style>
tr.even {
  background-color: #ddd;
}
tr.odd {
  background-color: #eee;
}
</style>
<script>
$(document).ready(function(){	$('table.striped tr:odd').addClass('odd');
$('table.striped tr:even').addClass('even');
});
function fnGet()
{
		if(document.f1.per.value=="")
			alert("Please Select District");
		else
		{
			document.forms[0].assetname.value = document.f1.per.options[document.f1.per.options.selectedIndex].text;
			document.forms[0].submit();
		}
}
</script>
<style>
#content {
	position:absolute;
	width:200px;
	height:115px;
	z-index:1;
	left: 373px;
	top: 220px;
}
-->
</style>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<%if(printValue!=null && printValue.equals("Y"))
	{}else{
	%>
<table  align="right">
<tr>
<td align="right"><a href="../home.jsp">Home</a>|<a href="rws_sustainability_works.jsp?printValue=Y&per=<%=per%>" target="_new">Excel</a>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr>
		<td class="textborder" align="left">Select District<span class="mandatory">*</span></td>
		<td><select name="per" style="width:150px" class="mycombo">
		<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT dcode,dname from rws_district_tbl where dcode<>'16' order by dname");
		while(rs.next())
		{
				if(per!=null && per.equals(rs.getString(1))){
			%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>
			<%}else{
			%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
			<%}
		}%>
		</select>
		</td>
	</tr>
	<tr>
	<td colspan="2" align=center>
	<input type="button" value="Get Report" onclick="fnGet()" class="btext">
	</td>
	</tr>
</table>
<%}%>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" class="striped">

	<tr bgcolor="lavander">
		<td class="textborder" align="center">
			<font color="blue">List of Sustainability Works</font><font color="red">(NREGS & NRDWP Only)</font><font color="black"></font></td>
	</tr>
<tr><td valign=top>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr align="center">
		<td class="btext" rowspan="2">S. No.</td>
		<td class="btext" rowspan="2">District</td>
		<td class="btext" rowspan="2">Division</td>
		<td class="btext" rowspan="2">Mandal</td>
		<td class="btext" rowspan="2">Panchayat</td>
		<td class="btext" rowspan="2">Village</td>
		<td class="btext" rowspan="2">Habitation</td>
 		<td class="btext" rowspan="2">Work ID</td>
		<td class="btext" rowspan="2">Work Name</td>
		<td class="btext" colspan="2">Est. Cost(In Lakhs)</td>
		<td class="btext" colspan="2">Expenditure(In Lakhs)</td>
		<td class="btext" rowspan="2">Type</td>
		<td class="btext" rowspan="2">Physical Stage</td>
	</tr>
	<tr>
		<td class="btext">NREGS</td>
		<td class="btext">NRDWP</td>
		<td class="btext">NREGS</td>
		<td class="btext">NRDWP</td>
	</tr>
<%
	DecimalFormat ndf = new DecimalFormat("####.00");
try
{
	CommonLists cl = new CommonLists();
	//System.out.println(cl.getWorkStatus("50010410100019"));
	if(per!=null && !per.equals("")){
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	String qrere = "";
	qrere = "select DNAME,DIVISION_OFFICE_NAME,MNAME,VNAME,PNAME,PANCH_NAME,w.work_id,work_name,decode(SUSTAINABILITY_RELATED,'01','Infiltration Rings','02','Recharge Pits','03','Check Dams','04','Percolation Tanks','05','Sub-surface Dykes','06','Injection Wells','07','Rain Water Harvesting Structure','08','Soak Pit for Handpump','09','Removal of Defunct HP','10','Revival of Traditional Water Harvesting Structures','11','Ponds/Tanks','12','Others') as type from  rws_work_admn_tbl w,rws_admn_hab_lnk_tbl b,RWS_COMPLETE_HAB_VIEW C,RWS_DIVISION_OFFICE_TBL D where w.work_id=b.work_id AND HAB_CODE=PANCH_CODE AND SUBSTR(W.OFFICE_CODE,2,2)=substr(w.work_id,5,2) AND SUBSTR(W.OFFICE_CODE,4,1)=D.DIVISION_OFFICE_CODE and (w.admin_date < '01-apr-2010' and w.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION < '01-apr-2010') or w.admin_date >= '01-apr-2010') and substr(w.work_id,7,2)='10' and substr(w.work_id,5,2)=D.CIRCLE_OFFICE_CODE and programme_code in ('50','56')";
	if(per!=null && !per.equals(""))
	{
		qrere += " and dcode='"+per+"' ";
	}
	qrere += " ORDER BY 1,2,3,4,5,6";
	//System.out.println("qrere:"+qrere);
	rs2=st2.executeQuery(qrere);
	int pop = 0,count = 1;
	double nregsAmt=0.0,nrdwpAmt=0.0,nregsExp=0.0,nrdwpExp=0.0;
	double nregsAmt1=0.0,nrdwpAmt1=0.0,nregsExp1=0.0,nrdwpExp1=0.0;
	st3 = conn.createStatement();
	while(rs2.next())
	{
		%>
<tr>
				<td class="rptValue" nowrap align="center"><%=count++%></td>
				<td class="rptValue" nowrap align="left"><%=rs2.getString(1)%></td>
				<td class="rptValue" nowrap align="left"><%=rs2.getString(2)%></td>
				<td class="rptValue" nowrap align="left"><%=rs2.getString(3)%></td>
				<td class="rptValue" nowrap align="left"><%=rs2.getString(4)%></td>
				<td class="rptValue" nowrap align="left"><%=rs2.getString(5)%></td>
				<td class="rptValue" nowrap align="left"><%=rs2.getString(6)%></td>
				<%if(printValue!=null && printValue.equals("Y"))
				{
				%><td class="rptValue" nowrap align="left">'<%=rs2.getString(7)%></td>
				<%}else{%>
				<td class="rptValue" nowrap align="left"><%=rs2.getString(7)%></td>
				<%}%>
				<td class="rptValue" nowrap align="left"><%=rs2.getString(8)%></td>
				<%
					rs3 = st3.executeQuery("SELECT (SELECT SANCTION_AMOUNT FROM RWS_WORK_ADMN_TBL WHERE WORK_ID='"+rs2.getString(7)+"' AND PROGRAMME_CODE='56')A,(SELECT SANCTION_AMOUNT FROM RWS_WORK_ADMN_PROG_LNK_TBL WHERE WORK_ID='"+rs2.getString(7)+"' AND PROGRAMME_CODE='56')C,(SELECT SANCTION_AMOUNT FROM RWS_WORK_ADMN_TBL WHERE WORK_ID='"+rs2.getString(7)+"' AND PROGRAMME_CODE='50')B,(SELECT SANCTION_AMOUNT FROM RWS_WORK_ADMN_PROG_LNK_TBL WHERE WORK_ID='"+rs2.getString(7)+"' AND PROGRAMME_CODE='50')D,(SELECT NVL(TOTAL,0) FROM RWS_EXP_VIEW WHERE WORK_ID='"+rs2.getString(7)+"' AND PROGRAMME_CODE='56')E,(SELECT NVL(TOTAL,0) FROM RWS_EXP_VIEW WHERE WORK_ID='"+rs2.getString(7)+"' AND PROGRAMME_CODE='50')F FROM DUAL");
					if(rs3.next())
					{
						double a1=0.0,a2=0.0,a3=0.0,a4=0.0,a5=0.0,a6=0.0;
						if(rs3.getString(1)!=null && !rs3.getString(1).equals(""))
							a1 = rs3.getDouble(1);
						if(rs3.getString(2)!=null && !rs3.getString(2).equals(""))
							a2 = rs3.getDouble(2);
						if(rs3.getString(3)!=null && !rs3.getString(3).equals(""))
							a3 = rs3.getDouble(3);
						if(rs3.getString(4)!=null && !rs3.getString(4).equals(""))
							a4 = rs3.getDouble(4);
						if(rs3.getString(5)!=null && !rs3.getString(5).equals(""))
							a5 = rs3.getDouble(5);
						if(rs3.getString(6)!=null && !rs3.getString(6).equals(""))
							a6 = rs3.getDouble(6);
						nregsAmt=a1+a2;
						nrdwpAmt=a3+a4;
						nregsExp=a5;
						nrdwpExp=a6;
						nregsAmt1+=a1+a2;
						nrdwpAmt1+=a3+a4;
						nregsExp1+=a5;
						nrdwpExp1+=a6;
					}

				%>
				<td class="rptValue" nowrap align="right"><%=nregsAmt%></td>
				<td class="rptValue" nowrap align="right"><%=nrdwpAmt%></td>
				<td class="rptValue" nowrap align="right"><%=nregsExp%></td>
				<td class="rptValue" nowrap align="right"><%=nrdwpExp%></td>
				<td class="rptValue" nowrap align="left"><%=rs2.getString(9)%></td>
				<td class="rptValue" nowrap align="left"><%=cl.getWorkStatus(rs2.getString(7),conn)%></td>
		</tr>
		<%
		}
}
}catch(Exception e)
{e.printStackTrace();}
finally
{
	if(rs3!=null)rs3.close();
	if(st3!=null)st3.close();
	if(rs2!=null)rs2.close();
	if(st2!=null)st2.close();
	if(rs1!=null)rs1.close();
	if(st1!=null)st1.close();
	if(conn!=null)conn.close();
}
%>
<%
}
catch(Exception e)
{e.printStackTrace();}
%>
</table></table>
<%if(printValue!=null && printValue.equals("Y"))
	{}else{%>
<%@ include file = "footer.jsp" %>
<%}%>
<INPUT type="hidden" name="assetname">
</form>
</body>
</html>