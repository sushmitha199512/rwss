<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
String rDistrict=null;
String dname=request.getParameter("dname");
	session.setAttribute("dname",dname);
	if(request.getParameter("district")!=null)
	{
	rDistrict = request.getParameter("district");
	}
	session.setAttribute("district",rDistrict);
	System.out.println("rDistrict:"+rDistrict);
	String query=null;
	Statement stmt1=null;
   ResultSet rs2 =null;
 try
{
%>
<html>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="../home.jsp">Home|</a></td>
				<td class="bwborder"><A HREF="javascript:history.go(-1)">Back</A>|</td>
			<td class="bwborder"><a href="./rws_cons_xls.jsp"  target="_new">Excel</a></td>
				
			</tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Constituency Wise Population Report</font></td>	
	</tr>
	<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="btext" colspan=40>District: <%=dname%></td>		
	</tr>	
	<tr align=center  align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<td class=btext rowspan = 2>Constituency</td>
	<td class=btext rowspan="2">Tot(Habs)</td>
	<td class=btext colspan = "6" align="Center">Population&nbsp;&nbsp;</td>
	</tr>
	<tr align = center>
	<td class=btext>SC Population</td>
	<td class=btext>ST Population</td>
	<td class=btext>Plain Population</td>
	<td class=btext> Total Population</td>
	</tr>
	<%
	 query="select distinct c.constituency_code,c.constituency_name,count(*) ,sum(census_sc_popu) ,sum(census_st_popu) ,sum(census_plain_popu)from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+rDistrict+"' group by c.constituency_code,c.constituency_name ";
// System.out.println("qqq11111:"+query);
	 int sno=0;
	stmt1=conn.createStatement();	
		rs2 = stmt1.executeQuery(query);	
		int habTotal=0,scTotal=0,stTotal=0,plainTotal=0;
	while(rs2.next())
	{     
	%>
	    
		<tr>
		<td class=rptValue><%=++sno%></td>
		<td class=rptValue><a href="./rws_const_habslist_rpt.jsp?dcode=<%=rDistrict%>&concode=<%=rs2.getString(1)%>&dname=<%=dname%>"><%=rs2.getString(2)%></a></td>
		<td class=rptValue align="right"><%=rs2.getInt(3)%></td>
		<td class=rptValue align="right"><%=rs2.getInt(4)%></td>
		<td class=rptValue align="right"><%=rs2.getInt(5)%></td>
		<td class=rptValue align="right"><%=rs2.getInt(6)%></td>
		<td class=rptValue align="right"><%=rs2.getInt(4)+rs2.getInt(5)+rs2.getInt(6)%></td>
		</tr>
		<%    habTotal+=rs2.getInt(3);
		scTotal+=rs2.getInt(4);
		stTotal+=rs2.getInt(5);
		plainTotal+=rs2.getInt(6);}

		rs2.close();
		int grandtotal=0;
		grandtotal=scTotal+stTotal+plainTotal;
		%>
</tr>
  	<tr>
		<td class=btext colspan=2 align="right">Grand Total</td>
		<td class=btext align="right"><font color="blue"><%=habTotal%></font></td>
		<td class=btext align="right"><%=scTotal%></td>
		<td class=btext align="right"><%=stTotal%></td>
		<td class=btext align="right"><%=plainTotal%></td>
		<td class=btext align="right"><%=grandtotal%></td>
		
	</tr>
<%
	}catch(Exception e){

	// System.out.println("Exception in jsp:"+e);
	}%>
	</table>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
