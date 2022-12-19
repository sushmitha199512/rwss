<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	String rDistrict=null;
	String dcode=request.getParameter("dcode");
	String concode=request.getParameter("concode");
	String dname=request.getParameter("dname");
	//int habTotal,scTotal,stTotal,plainTotal;
	System.out.println("dcode:"+dcode);
	String query=null;
	Statement stmt1=null;
	ResultSet rs2 =null;
	int grandtotal=0;
	try
{
%>
<html>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="../home.jsp">Home|</a></td>
				<td class="bwborder"><A HREF="javascript:history.go(-1)">Back</A></td>
				</table>
				<br>
				<br>
	<table border = 1 cellspacing = 0 cellpadding = 0 width=60%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
	<td align="center" class="btext" colspan=40>District: <%=dname%></td>		
	</tr>	
	<tr align=center  align=center>
	<td class=btext rowspan = 2>Sl.No</td>
	<td class=btext rowspan = 2>Hab Name</td>
	<td class=btext colspan = "6" align="Center">Population&nbsp;&nbsp;</td>
	</tr>
	<tr align = center>
	<td class=btext>SC Population</td>
	<td class=btext>ST Population</td>
	<td class=btext>Plain Population</td>
	<td class=btext> Total Population</td>
	</tr>
	<%
		
 query="select panch_name,census_sc_popu,census_st_popu,census_plain_popu  from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+dcode+"'  and c.constituency_code='"+concode+"' ";
 //System.out.println("qin habs:"+query);
	int sno=0;
	stmt1=conn.createStatement();	
	rs2 = stmt1.executeQuery(query);	
	int habTotal=0,scTotal=0,stTotal=0,plainTotal=0;
	//int grandtotal=0;
	while(rs2.next())
	{		
	%>
	<tr>
	<td class=rptValue><%=++sno%></td>
	<td class=rptValue ><%=rs2.getString(1)%></td>
	<td class=rptValue align="right"><%=rs2.getInt(2)%></td>
	<td class=rptValue align="right"><%=rs2.getInt(3)%></td>
	<td class=rptValue align="right"><%=rs2.getInt(4)%></td>
	<td class=rptValue align="right"><%=rs2.getInt(2)+rs2.getInt(3)+rs2.getInt(4)%></td>
	</tr>
		<%scTotal+=rs2.getInt(2);
		stTotal+=rs2.getInt(3);
		plainTotal+=rs2.getInt(4);}
		rs2.close();
		grandtotal=scTotal+stTotal+plainTotal;
		%>
</tr>
	<tr>
	<td class=btext colspan=2 align="right">Grand Total</td>
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
