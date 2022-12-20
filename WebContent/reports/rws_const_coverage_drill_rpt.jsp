<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<% 
		String  dist=request.getParameter("dcode");
		String  con=request.getParameter("concode");
		String  man=request.getParameter("mcode");
		String  panch=request.getParameter("pcode");
		String  vill=request.getParameter("vcode");
		String drill=request.getParameter("driltype");
		String code=request.getParameter("code");
		String dname=request.getParameter("distname");
		String cname=request.getParameter("cname");
		String mname=request.getParameter("mname");
		String pname=request.getParameter("pname");
		String vname=request.getParameter("vname");
		/*// System.out.println("d:"+dist);
		// System.out.println("c:"+con);
		// System.out.println("m:"+man);
		// System.out.println("p:"+panch);
		// System.out.println("v:"+vill);
		// System.out.println("drill:"+drill);
		// System.out.println("code:"+code);*/
		//// System.out.println("dname:"+dname);
		//// System.out.println("cname:"+cname);
String query="";%>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="../home.jsp">Home|</a></td>
				<td class="bwborder"><A HREF="javascript:history.go(-1)">Back|</a></td>
			<td class="bwborder"><a href="./rws_const_coverage_drill_xls.jsp?driltype=<%=drill%>&dcode=<%=dist%>&concode=<%=con%>&mcode=<%=man%>&pcode=<%=panch%>&vcode=<%=vill%>&distname=<%=dname%>&cname=<%=cname%>&mname=<%=mname%>&pname=<%=pname%>&vname=<%=vname%>" target= "_new ">Excel</a></td>
				
			</tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Constituency Wise Coverage Status Report</font></td>	
	</tr>


<% 	if(drill.equals("village"))
	{%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class=btext colspan=10>District:<%=dname%> &nbsp;&nbsp;&nbsp;&nbsp;Constituency:<%=cname%>&nbsp;&nbsp;Mandal:<%=mname%> &nbsp;&nbsp;&nbsp;Panchayat:<%=pname%>&nbsp;&nbsp;&nbsp;Village:<%=vname%></td>
	</tr>	
	<tr align=center align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>	
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
			
			
	<%}

	 else if(drill.equals("panchayat"))
	{%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class=btext colspan=10>District:<%=dname%> &nbsp;&nbsp;&nbsp;&nbsp;Constituency:<%=cname%>&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%> &nbsp;&nbsp;&nbsp;Panchayat:<%=pname%></td>
	</tr>	
	<tr align=center align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Village</td>	
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
			
			
	<%}
				
	else  if(drill.equals("mand"))
	{%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class=btext colspan=10>District:<%=dname%> &nbsp;&nbsp;&nbsp;&nbsp;Constituency:<%=cname%>&nbsp;&nbsp;Mandal:<%=mname%> </td>
	</tr>	
	<tr align=center align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Panchayat</td>	
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
			
			
	<%}
 else if(drill.equals("cons"))
	{%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class=btext colspan=10>District:<%=dname%> &nbsp;&nbsp;&nbsp;&nbsp;Constituency:<%=cname%> </td>
	</tr>	
	<tr align=center align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Mandal</td>	
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
<%} else if(drill.equals("dist"))
	{%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class=btext colspan=10>District:<%=dname%> &nbsp;&nbsp;&nbsp;&nbsp; </td>
	</tr>	
	<tr align=center align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Constituency</td>	
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center>
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
		
	</tr>
			
			
	<%}

String drill1="";
if(drill.equals("dist"))
 {
	 
	query="select distinct c.constituency_code,c.constituency_name,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+dist+"' group by c.constituency_code,c.constituency_name ";
	//// System.out.println("qry1:"+query);
	drill1="cons";
	
}

if(drill.equals("cons"))
{
	query="select distinct m.mcode,m.mname,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM (Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+dist+"'  and c.constituency_code='"+con+"' group by m.mcode,m.mname";
	//// System.out.println("qry2:"+query);
	drill1="mand";
} 
 if(drill.equals("mand"))
	{
	   
	  query="select distinct p.pcode,p.pname,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM (Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+dist+"'  and c.constituency_code='"+con+"' and m.mcode='"+man+"' group by p.pcode,p.pname";
	  //// System.out.println("qry3:"+query);
	  drill1="panchayat";
	}
	if(drill.equals("panchayat"))
	{
		
		query="select distinct v.vcode,v.vname,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM (Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+dist+"'  and c.constituency_code='"+con+"' and m.mcode='"+man+"'  and p.pcode='"+panch+"' group by v.vcode,v.vname";
		//// System.out.println("qry4:"+query);
		drill1="village";
	}
	if( drill.equals("village"))
	{
		query="select distinct h.panch_code,h.panch_name,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM (Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+dist+"'  and c.constituency_code='"+con+"' and m.mcode='"+man+"'  and p.pcode='"+panch+"' and v.vcode='"+vill+"' group by h.panch_code,h.panch_name";
		//// System.out.println("qry5:"+query);
	}
int sno=0,fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
stmt=conn.createStatement();
rs=stmt.executeQuery(query);
while(rs.next())
{%>
    <tr>
			<td class=rptValue><%=++sno%></td>
			
			<%if(drill.equals("dist")) {%><td class=rptValue><a href="./rws_const_coverage_drill_rpt.jsp?driltype=<%=drill1%>&dcode=<%=dist%>&mcode=<%=man%>&concode=<%=rs.getString(1)%>&pcode=<%=panch%>&vcode=<%=vill%>&distname=<%=dname%>&cname=<%=rs.getString(2)%>"><%=rs.getString(2)%></td>
			<%} 
			else if(drill.equals("cons")) {%>
			<td class=rptValue><a href="./rws_const_coverage_drill_rpt.jsp?driltype=<%=drill1%>&dcode=<%=dist%>&mcode=<%=rs.getString(1)%>&concode=<%=con%>&pcode=<%=panch%>&vcode=<%=vill%>&distname=<%=dname%>&cname=<%=cname%>&mname=<%=rs.getString(2)%>"><%=rs.getString(2)%></td>
			<%} else if (drill.equals("mand")){%>
			<td class=rptValue><a href="./rws_const_coverage_drill_rpt.jsp?driltype=<%=drill1%>&dcode=<%=dist%>&mcode=<%=man%>&concode=<%=con%>&pcode=<%=rs.getString(1)%>&vcode=<%=vill%>&distname=<%=dname%>&cname=<%=cname%>&mname=<%=mname%>&pname=<%=rs.getString(2)%>"><%=rs.getString(2)%></td>
			<%}else if (drill.equals("panchayat")){%>
			<td class=rptValue><a href="./rws_const_coverage_drill_rpt.jsp?driltype=<%=drill1%>&dcode=<%=dist%>&mcode=<%=man%>&concode=<%=con%>&pcode=<%=panch%>&vcode=<%=rs.getString(1)%>&distname=<%=dname%>&cname=<%=cname%>&mname=<%=mname%>&pname=<%=pname%>&vname=<%=rs.getString(2)%>"><%=rs.getString(2)%></td>
			<%}else if (drill.equals("village")) {%>
			<td class=rptValue align="right"><%=rs.getString(2)%></td>
			<%}%>
			<td class=btext align="right"><%=rs.getInt(10)%></td>
		    <td class=rptValue align="right"><%=rs.getInt(3)%></td>
			<% fcTotal+=rs.getInt(3); %>
			<td class=rptValue align="right"><%=rs.getInt(4)%></td>
			<% ncTotal+=rs.getInt(4); %>
			<td class=rptValue align="right"><%=rs.getInt(5)%></td>
			<% nssTotal+=rs.getInt(5); %>
			<td class=rptValue align="right"><%=rs.getInt(6)%></td>
			<% pc1Total+=rs.getInt(6); %>
			<td class=rptValue align="right"><%=rs.getInt(7)%></td>
			<% pc2Total+=rs.getInt(7); %>
			<td class=rptValue align="right"><%=rs.getInt(8)%></td>
			<% pc3Total+=rs.getInt(8); %>
			<td class=rptValue align="right"><%=rs.getInt(9)%></td>
			<% pc4Total+=rs.getInt(9); %>
						
	 <%}%>
	 </tr>
	 <% int grandtotal=0;
	grandtotal=fcTotal+ncTotal+nssTotal+pc1Total+pc2Total+pc3Total+pc4Total+uiTotal;
%>
</tr>

    
	<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext align="right"><font color="blue"><%=grandtotal%></font></td>
		<td class=btext align="right"><%=fcTotal%></td>
		<td class=btext align="right"><%=ncTotal%></td>
		<td class=btext align="right"><%=nssTotal%></td>
		<td class=btext align="right"><%=pc1Total%></td>
		<td class=btext align="right"><%=pc2Total%></td>
		<td class=btext align="right"><%=pc3Total%></td>
		<td class=btext align="right"><%=pc4Total%></td>
		
	</tr>
</table>
</body>
<%@ include file = "footer.jsp" %>
</form>
</html>

