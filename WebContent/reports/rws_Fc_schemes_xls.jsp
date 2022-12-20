<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>

<%
        String dcode =(String)session.getAttribute("dcode");
		String mcode=(String)session.getAttribute("mcode");
		String pcode=(String)session.getAttribute("pcode");
		String vcode=(String)session.getAttribute("vcode");
		String habcode=(String)session.getAttribute("habcode");
		String dname=(String)session.getAttribute("dname");
		String mname=(String)session.getAttribute("mname");
		String pname=(String)session.getAttribute("pname");
		String vname=(String)session.getAttribute("vname");
		String habname=(String)session.getAttribute("habname");
		String status=(String)session.getAttribute("status");
		String scheme=(String)session.getAttribute("scheme");
		String sname=(String)session.getAttribute("sname");
		String name2=(String)session.getAttribute("name2");
				String scheme1=(String)session.getAttribute("scheme1");
		String qry="";
		//System.out.println("mname"+mname);
	%>
<form>
<p align="center"><font class="rptvalue" size=3><b>Habitation and Assets Analysis Report</b></font><BR><br></p>

<table><tr>
<td class="btext">Under</td><td class="rptvalue"></td>
<td class="btext">District:</td><td class="rptvalue"><%=dname%></td>
<%if(mname!=null && !mname.equals("")){%>
<td class="btext">- Mandal:</td><td class="rptvalue"><%=mname%></td>
<%}if(pname!=null && !pname.equals("")){%>
<td class="btext">- Panchayat:</td><td class="rptvalue"><%=pname%></td>
<%}if(vname!=null && !vname.equals("")){%>
<td class="btext">- Village:</td><td class="rptvalue"><%=vname%></td>
<%}%>
<td class="btext">- Coverage Status:</td><td class="rptvalue"><%=status%></td>
<%	if(scheme!=null && !scheme.equals("")){%>
<td class="btext">-Not Having Scheme:</td><td class="rptvalue"><%=sname%></td>
<%}else{%>
<td class="btext">- Having Scheme:</td><td class="rptvalue"><%=name2%></td>
<%}%>
</tr>
</table>

 <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
<tr align=center>
<td class=btext ><b>S.No</b></font></td>
<td class=btext ><b>District Name</b></font></td>
<td class=btext><b>Mandal Name</b></font></td>
<td class=btext><b>Panchayat Name</b></font></td>
<td class=btext><b>Village Name</b></font></td>
<td class=btext><b>Habitation Name</b></font></td>
<td class=btext><b>Coverage Status</b></font></td>
<td class=btext><b>Total Population</b></font></td>
<td class=btext><b>CPWS</b></font></td>
<td class=btext><b>PWS</b></font></td>
<td class=btext><b>MPWS</b></font></td>
<td class=btext><b>DP</b></font></td>
<td class=btext><b>HANDPUMPS</b></font></td>

<%
try{
	if(scheme!=null && !scheme.equals(""))
	{
//System.out.println("f"+scheme);
	qry="select c.DNAME ,c.MNAME,c.   PNAME ,c.  VNAME ,c. PANCH_NAME ,c.COVERAGE_STATUS,( CENSUS_PLAIN_POPU + CENSUS_SC_POPU + CENSUS_ST_POPU ),cpws,pws,mpws,dp,hp,c.panch_code from  RWS_ALL_ASSET_COUNT_TBL b,rws_complete_hab_view c where  c.COVERAGE_STATUS='"+status+"' and substr(b.hab_code,1,2)='"+dcode+"' and  b.hab_code=c.panch_code ";
	if(mcode!=null && !mcode.equals(""))
	{
	qry+=" and substr(b.hab_code,6,2)='"+mcode+"' ";
	}
	if(pcode!=null && !pcode.equals(""))
	{
	qry+=" and substr(c.panch_code,13,2)='"+pcode+"' ";
	}
	if(vcode!=null && !vcode.equals(""))
	{
	qry+=" and substr(c.panch_code,8,3)='"+vcode+"' ";
	}
	if(habcode!=null && !habcode.equals(""))
	{
	qry+=" and panch_code='"+habcode+"' ";
	}
	if(scheme!=null && scheme.equals("03"))
	{
		qry+="and (cpws=0)";
	}
	else if(scheme!=null && scheme.equals("01"))
	{
		qry+="and (cpws=0 and pws=0)";
	}
	else if(scheme!=null && scheme.equals("02"))
	{
		qry+="and (cpws=0 and pws=0 and mpws=0)";
	}
	else if(scheme!=null && scheme.equals("09"))
	{
		qry+="and (cpws=0 and pws=0 and mpws=0 and dp=0)";
	}
	else if(scheme!=null && scheme.equals("04"))
	{
		qry+="and (cpws=0 and pws=0 and mpws=0 and dp=0 and hp=0)";
	}
	}
	else
	{
qry="select c.DNAME ,c.MNAME,c.   PNAME ,c.  VNAME ,c. PANCH_NAME ,c.COVERAGE_STATUS,( CENSUS_PLAIN_POPU + CENSUS_SC_POPU + CENSUS_ST_POPU ),cpws,pws,mpws,dp,hp,c.panch_code from  RWS_ALL_ASSET_COUNT_TBL b,rws_complete_hab_view c where  c.COVERAGE_STATUS='"+status+"' and substr(b.hab_code,1,2)='"+dcode+"' and  b.hab_code=c.panch_code ";
    if(mcode!=null && !mcode.equals(""))
	{
	qry+=" and substr(b.hab_code,6,2)='"+mcode+"' ";
	}
	if(pcode!=null && !pcode.equals(""))
	{
	qry+=" and substr(c.panch_code,13,2)='"+pcode+"' ";
	}
	if(vcode!=null && !vcode.equals(""))
	{
	qry+=" and substr(c.panch_code,8,3)='"+vcode+"' ";
	}
	if(habcode!=null && !habcode.equals(""))
	{
	qry+=" and panch_code='"+habcode+"' ";
	}
	if(scheme1!=null && scheme1.equals("03"))
	{
		qry+="and (cpws<>0)";
	}
	else if(scheme1!=null && scheme1.equals("01"))
	{
		qry+="and (cpws=0 and pws<>0)";
	}
	else if(scheme1!=null && scheme1.equals("02"))
	{
		qry+="and (cpws=0 and pws=0 and mpws<>0)";
	}
	else if(scheme1!=null && scheme1.equals("09"))
	{
		qry+="and (cpws=0 and pws=0 and mpws=0 and dp<>0)";
	}
	else if(scheme1!=null && scheme1.equals("04"))
	{
		qry+="and (cpws=0 and pws=0 and mpws=0 and dp=0 and hp<>0)";
	}
		}
//System.out.println(qry);
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
int count = 1;
if(rs.isBeforeFirst()){
while(rs.next())
	{
		%>
		<tr>
		<td class=rptvalue ><%=count++%></td>
		<td class=rptvalue nowrap><%=rs.getString(1)%></td>
		<td class=rptvalue nowrap><%=rs.getString(2)%></td>
		<td class=rptvalue nowrap><%=rs.getString(3)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(4)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(5)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(6)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(7)%></td>
<%
	if(rs.getInt(8)>0)
	{
	%>
	<td class=rptvalue  align="left"><%=rs.getString(8)%></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}
if(rs.getInt(9)>0)
	{
	%>
	<td class=rptvalue  align="left"><%=rs.getString(9)%></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}
	if(rs.getInt(10)>0)
	{
	%>
	<td class=rptvalue  align="left"><%=rs.getString(10)%></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}
	if(rs.getInt(11)>0)
	{
	%>
	<td class=rptvalue  align="left"><%=rs.getString(11)%></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}
	if(rs.getInt(12)>0)
	{
	%>
	<td class=rptvalue  align="left"><%=rs.getString(12)%></td>
	<%}
	else{%>
	<td class=rptvalue align="left">0</td>
	<%}%>
	</tr>
<%}
}

else{
 %>
 <tr>
<td class="rptValue" align=center colspan=8>No Records Match With This Selection Criteira</td></tr>
<%}
}
catch(Exception e)
{
	e.printStackTrace();
}

%>
</form>
</table>
<%@ include file="/commons/rws_footer.jsp"%>

