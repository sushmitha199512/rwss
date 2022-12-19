<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="conn.jsp"%>
<%ResultSet rs1 =null;
  Statement st = null ;
  String Dcode=request.getParameter("dcode");
  String Dname=request.getParameter("dname");
  String covStatusQry = (String)session.getAttribute("covStatusQryy");

 %>
<head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table width="100%" cellspacing="0" cellpadding="2" border="1"  bordercolor=#000000
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">

<tr align="center">
			<td align="center" class="rptHeading" colspan=6>Habitation list having CPWS schemes for District : <%=Dname%></td>	
		</tr>
<tr bgcolor="#8A9FCD">
    <th>Sno</th>
    <th>Mandal Code</th>
	<th>Mandal Name</th>
   	<th>Habitation Code</th>
	<th>Habitation Name</th>
	<th>CPWS Count</th>
	
	
</tr>
</thead>
<tbody class="gridText">
<%
try{
		String gethabsqry="select a.hab_code,b.panch_name ,a.cpws_no,substr(a.hab_code,6,2),m1.mname from rws_hab_supply_status_tbl a,rws_panchayat_raj_tbl b,rws_mandal_tbl m1 where a.hab_code=b.panch_code and substr(a.hab_code,6,2) = m1.mcode  and substr(a.hab_code,1,2) = m1.dcode  and cpws_no <>'0' and a.hab_code in (select h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+Dcode+"'"+covStatusQry+")";
		st=conn.createStatement();
		rs1 = st.executeQuery(gethabsqry); 
		int sno=1;
		while (rs1.next()){
		
		%><tr>
		
		    <td class=rptValue><%=sno++%></td>
		    <td class=rptValue align="center"><%=rs1.getString(4)%></td>
			<td class=rptValue><%=rs1.getString(5)%></td>
			<td class=rptValue><%=rs1.getString(1)%></td>
			<td class=rptValue><%=rs1.getString(2)%></td>
			<td class=rptValue align="center"><%=rs1.getString(3)%></td>

		<%}

} catch(Exception e)
{
	e.printStackTrace();
}
finally
{
if(rs1!=null){rs1.close();}
if(st!=null){st.close();}
if(conn!=null){conn.close();}
}

 %>
</tbody>

</table><br>
<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</body>
</html>
