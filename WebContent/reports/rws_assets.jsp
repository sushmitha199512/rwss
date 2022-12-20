<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st=null,st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null,st9=null,st10=null,st11=null,st12=null,st13=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null,rs9=null,
	rs10 = null,rs11=null,rs12=null,rs13=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null,qu=null, a1="",codename=null,mand=null,mname=null,dist=null,dname=null,panch=null,pname=null,vill=null,vname=null,habcode=null,hname=null,code=null,sourcecode=null;
     
	 code=request.getParameter("code");
	 dist=request.getParameter("dcode");
	 mand=request.getParameter("mcode");
	 panch=request.getParameter("pcode");
	 habcode=request.getParameter("hcode");
	%>
<html>
<title> WaterSoft </title>
<head>
<!--<script>
		window.history.forward(1);
	</script>-->
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
<form name=f1 method="post">


<table border = 1 cellspacing = 0 cellpadding = 0 width=50% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_coverage_status_frm1.jsp">Back|</a>
				<a href="../home.jsp">Home|</a>
				<!--<a href="./rws_cir_div_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;-->
				<!--<a href="./rws_cir_div_status_rpt_print_excel.jsp" target="_new">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" >
			<font color="ffffff">Status Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
    <tr><% 
	if(session.getAttribute("dName1")!=null){%>
<td align="center" class="btext" nowrap><font color="navy">District: <%=session.getAttribute("dName1") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("mName1")!=null){%>
<td align="center" class="btext" nowrap><font color="navy">Mandal:<%=session.getAttribute("mName1") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%} if(session.getAttribute("pName")!=null){%>
<td align="center" nowrap class="btext"><font color="navy">Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%} if(request.getParameter("vname")!=null){%>
<td align="center" nowrap class="btext"><font color="navy">Village: <%=session.getAttribute("vname") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(request.getParameter("hname")!=null){%>
<td align="center" nowrap class="btext"><font color="navy">Habitation:<%=request.getParameter("hname") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	 <% if(code.equals("Assets"))
	 {
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>AssetName-AssetCode</td>
        <td class="btext" align=center>Location</td>
		<td class="btext" align=center>Asset Status</td>
		<td class="btext" align=center>Date Of Creation</td>
		<td class="btext" align=center>Cost Of Asset<br>(Rs In Lakhs)</td>
		

		
	</tr>
     <%
	 }
	else if(code.equals("Works"))
	{
	 %>
        <td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>Work Name</td>
		<td class="btext" align=center>Programme Name</td>
		<td class="btext" align=center>SubProgramme Name</td>
		<td class="btext" align=center>Asset Name</td>
		<td class="btext" align=center>Work Category</td>
		</tr>
   

	

	
     <%
	 }

try
{

st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);


if(code.equals("Assets"))
	{
qu="select distinct b.asset_name,b.location,decode(b.asset_status,'1','Working','2','Not Working','3','Dried','4','Seasonal','5','Condemed'),to_char(b.date_creation,'DD-MON-YYYY'),b.asset_cost,a.type_of_asset_code,b.asset_code from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s,rws_hab_static_dir_tbl h where d.panch_code=h.hab_code and b.asset_code=s.asset_code and d.panch_code=substr(scheme_code,1,16) and substr(d.panch_code,1,2)='"+dist+"' and substr(d.panch_code,6,2)='"+mand+"' and substr(d.panch_code,13,2)='"+panch+"' and substr(d.panch_code,1,16)='"+habcode+"' and b.type_of_asset_code=a.type_of_asset_code";


	}
	else if(code.equals("Works"))
	{
/*qu="SELECT * from rws_work_admn_tbl w,rws_admn_hab_lnk_tbl a,rws_panchayat_raj_tbl pr,rws_hab_static_dir_tbl h  where h.hab_code=pr.panch_code and a.hab_code=pr.panch_code and w.work_id=a.work_id and substr(pr.panch_code,1,2)='"+dist+"' and  substr(pr.panch_code,6,2)='"+mand+"' and substr(pr.panch_code,13,2)='"+panch+"' and substr(pr.panch_code,1,16)='"+habcode+"'";*/

qu="SELECT distinct w.work_id,w.work_name,p.programme_name,sp.subprogramme_name,t.TYPE_OF_ASSET_NAME,nvl(w.work_category,'-'),w.type_of_asset from rws_work_admn_tbl w,rws_admn_hab_lnk_tbl a,rws_panchayat_raj_tbl pr,rws_hab_static_dir_tbl h,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_asset_type_tbl t  where h.hab_code=pr.panch_code and a.hab_code=pr.panch_code and w.work_id=a.work_id and p.programme_code=w.programme_code and sp.programme_code=w.programme_code and sp.subprogramme_code=w.subprogramme_code and w.TYPE_OF_ASSET=t.TYPE_OF_ASSET_CODE and substr(pr.panch_code,1,2)='"+dist+"' and  substr(pr.panch_code,6,2)='"+mand+"' and substr(pr.panch_code,13,2)='"+panch+"' and substr(pr.panch_code,1,16)='"+habcode+"'";


//out.println(qu);
	}
	 rs1=st1.executeQuery(qu);
	 int slno=0,total=0;
	while(rs1.next())
	{
	
	if(code.equals("Assets"))
	 {
		
	%>      <TR>
		<td class=rptValue align=left><%=++slno%></td>
        <td class=rptValue align=left><!-- <a href="./rws_comp_rpt.jsp?type=<%=rs1.getString(6)%>
		&assetcd=<%=rs1.getString(7)%>"> --><%=rs1.getString(1)%><%="-"+rs1.getString(7)%><!--  </a> --></td>
		<% if(rs1.getString(2)!=null)
		 {
		%>
		<td class=rptValue align=left><%=rs1.getString(2)%></td>
		<%}else{%>

         <td class=rptValue align=left><%="-"%></td>
		 <%}
		 if(rs1.getString(3)!=null)
		 {
		%>
		<td class=rptValue align=left><%=rs1.getString(3)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(4)!=null)
		 {
		%>
		<td class=rptValue align=left><%=rs1.getString(4)%></td>
		<%} else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}
		 if(rs1.getString(5)!=null)
		 {
		%>
		<td class=rptValue align=right><%=rs1.getString(5)%></td>
		<%}
		else{%>

         <td class=rptValue align=center><%="-"%></td>
		 <%}%>
		
		</TR>
<%
	 }
else if(code.equals("Works"))
	 {
	%>      <TR>
		<td class=rptValue align="left"><%=++slno%></td>
        <td class=rptValue align="left"><a href="./rws_wrk_progress1.jsp?work_id=<%=rs1.getString(1)%>&dcode=<%=dist%>&scheme=<%=rs1.getString(7)%>"><%=rs1.getString(2)%><%="-"+rs1.getString(1)%></a>
		</td>
		<td class=rptValue align="left"><%=rs1.getString(3)%></td>
		<td class=rptValue align="left"><%=rs1.getString(4)%></TD>
		<td class=rptValue align="left"><%=rs1.getString(5)%></TD>
		<td class=rptValue align="right"><%=rs1.getString(6)%></TD>
	</TR>
<%
	 } 
	 } %>
	</table>	
<% }
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>

