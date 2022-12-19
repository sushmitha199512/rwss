<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<%@ include file = "conn.jsp" %>
<%

String dcode = (String)session.getAttribute("dcode");
String mandal = (String)session.getAttribute("mandal");
String year = (String)session.getAttribute("year");

String dname = (String)session.getAttribute("dname");
String mname = (String)session.getAttribute("mname");
WorksData1 wd = new WorksData1();
int cur_year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
String qry="";
int cur_year=cur_year1;
int year1=Integer.parseInt(year); 
	String qtab="";
	String qtab1="";

%>
<form>
<h3 align="center">Slippage Habitations List</h3>
<font color="blue" face=verdana size=2>District:</font><font color="black" face=verdana size=2><%=dname%></font>&nbsp; 
<font color="blue" face=verdana size=2>Year:</font><font color="black" face=verdana size=2><%=year%></font>&nbsp; 

<%if(mandal!=null && mandal.length()>0){%>
<font color="blue" face=verdana size=2>Mandal:</font><font color="black" face=verdana size=2><%=mname%></font>&nbsp; 

<%}%>

<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
<tr align=center>
<td class=btext ><b>S.No</b></font></td>
<%
if(mandal!=null && !mandal.equals("")){}else{%>
<td class=btext><b>Mandal</b></font></td>
<%}%>
<td class=btext><b>Panchayat</b></font></td>
<td class=btext><b>Village</b></font></td>
<td class=btext ><b>Habitation Code</b></font></td>
<td class=btext><b>Habitation Name</b></font></td>
<td class=btext><b>Prev. Year Status</b></font></td>
<td class=btext><b>Current Coverage Status</b></font></td>
<%
if(cur_year==year1 || cur_year-1==year1)
{
%>
<td class=btext><b>Slippage Reason</b></font></td>
<%}%>
</tr>
<%
	if(cur_year==year1)
	{
		qtab="RWS_HABITATION_DIRECTORY_TBL";
		qry = "select pname,vname,panch_code,panch_name,a.PREVIOUS_YR_STATUS,a.COVERAGE_STATUS,mname,slippage_desc from "+qtab+" a, RWS_COMPLETE_HAB_VIEW b,rws_slippage_reason_tbl c where a.hab_code=b.panch_code and dcode='"+dcode+"'  and a.slippage_code=c.slippage_code and a.slippage_code is not null";
		if(mandal!=null && !mandal.equals(""))
		{
		qry+=" and mcode='"+mandal+"' ";
		}
	}
	else if(cur_year-1==year1)
	{
	qtab="RWS_HABITATION_DIR_HIS_TBL";
		qry = "select pname,vname,panch_code,panch_name,a.PREVIOUS_YR_STATUS,a.COVERAGE_STATUS,mname,slippage_desc from "+qtab+" a, RWS_COMPLETE_HAB_VIEW b,rws_slippage_reason_tbl c where a.hab_code=b.panch_code and dcode='"+dcode+"'  and a.slippage_code=c.slippage_code and a.slippage_code is not null";
		if(mandal!=null && !mandal.equals(""))
		{
		qry+=" and mcode='"+mandal+"' ";
		}
	}
	else
	{
	qtab1="RWS_HABITATION_DIR_HIS"+year+"_TBL";
	//System.out.println("qtable name"+qtab);
	 qry = "select pname,vname,panch_code,panch_name,a.PREVIOUS_YR_STATUS,a.COVERAGE_STATUS,mname from "+qtab1+" a, RWS_COMPLETE_HAB_VIEW b where a.hab_code=b.panch_code and dcode='"+dcode+"' ";
	if(mandal!=null && !mandal.equals(""))
	{
	qry+=" and mcode='"+mandal+"' ";
	}
	}
		
//System.out.println(qry);
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
int count = 1;
 Statement stmt1=conn.createStatement();
if(rs.isBeforeFirst())
{
	while(rs.next())
	{
		
		int cuur_stat1=0;
		int prev_status1=0;
		String cuur_stat = rs.getString("COVERAGE_STATUS");
		String prev_status = rs.getString("PREVIOUS_YR_STATUS");
		if(cuur_stat==null)cuur_stat="-";
		if(prev_status==null)prev_status="-";
		if(cuur_stat.equals("FC"))
		  cuur_stat1=1;
		if(cuur_stat.equals("PC4"))
		  cuur_stat1=2;
		if(cuur_stat.equals("PC3"))
		  cuur_stat1=3;
		if(cuur_stat.equals("PC2"))
		  cuur_stat1=4;
		if(cuur_stat.equals("PC1"))
		  cuur_stat1=5;
		if(cuur_stat.equals("NC"))
		  cuur_stat1=6;
		if(cuur_stat.equals("NSS"))
		  cuur_stat1=7;
			  
		if(prev_status.equals("FC"))
		  prev_status1=1;
		if(prev_status.equals("PC4"))
		  prev_status1=2;
		if(prev_status.equals("PC3"))
		  prev_status1=3;
		if(prev_status.equals("PC2"))
		  prev_status1=4;
		if(prev_status.equals("PC1"))
		  prev_status1=5;
		if(prev_status.equals("NC"))
		  prev_status1=6;
		if(prev_status.equals("NSS"))
		  prev_status1=7;  
			if(prev_status1 < cuur_stat1)
		{
			
		%>
	 <tr>
		<td class=rptvalue ><%=count++%></td>
		<%if(mandal!=null && !mandal.equals("")){}else{%>
		<td class=rptvalue nowrap><%=rs.getString(7)%></td>
		<%}%>
		<td class=rptvalue nowrap><%=rs.getString(1)%></td>
		<td class=rptvalue nowrap><%=rs.getString(2)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(3)%></td>
		<td class=rptvalue  nowrap><%=rs.getString(4)%></td>
		<td class=rptvalue ><%=prev_status%></td>
		<td class=rptvalue ><%=cuur_stat%></td>

		<%
		if(cur_year==year1 || cur_year-1==year1)
		{
	%>		<td class=rptvalue nowrap><%=rs.getString(8)%></td><%
		}	
	%>
		 <%}
	}
}
else
{%>
	<script>
		var di = '<%=dname%>';
		var ma = '<%=mname%>';
		alert("There are no Slippage Habitations in Selected District:"+di+" and Mandal:"+ma);
		document.location.href="rws_Slipage_hab_frm.jsp";
	</script>
<%}%>
</form>
</table>
<%@ include file="/commons/rws_footer.jsp"%>

