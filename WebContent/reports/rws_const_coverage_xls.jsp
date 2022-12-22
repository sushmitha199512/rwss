<%@ page contentType = "application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file = "conn.jsp" %>
<%

String rDistrict=null, rConstituency=null, rMandal=null, rPanchayat=null, rVillage=null;
	if(request.getParameter("district")!=null)
	{
	rDistrict = request.getParameter("district");
	}
	else
	{
	rDistrict="00";
	}
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rVillage = request.getParameter("village");
	rConstituency = request.getParameter("constituency");
	
	String dname=(String)session.getAttribute("districtName");
	String cname=(String)session.getAttribute("constituencyName");
	String mname=(String)session.getAttribute("mandalName");
	String pname=(String)session.getAttribute("panchayatName");
	String vname=(String)session.getAttribute("villageName");
	
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
	
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Constituency Wise Coverage Status Report</font></td>	
	</tr>
	<% if(rVillage!=null && !rVillage.equals("00") && !rVillage.equals("-1"))
	{%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class=btext colspan=10>District:<%=dname%> &nbsp;&nbsp;&nbsp;&nbsp;Constituency:<%=cname%>&nbsp;&nbsp;Mandal:<%=mname%> &nbsp; &nbsp;&nbsp;Panchayat:<%=pname%>&nbsp;&nbsp;Village:<%=vname%></td>
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

	 else if(rPanchayat!=null && !rPanchayat.equals("00") && !rPanchayat.equals("-1"))
	{%>
	<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class=btext colspan=10>District:<%=dname%> &nbsp;&nbsp;&nbsp;&nbsp;Constituency:<%=cname%>&nbsp;&nbsp;Mandal: &nbsp;Panchayat:Mandal:<%=mname%> &nbsp;&nbsp;Panchayat:<%=pname%>&nbsp;&nbsp;</td>
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
				
	else if(rMandal!=null && !rMandal.equals("00") && !rMandal.equals("-1"))
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
 else if(rConstituency!=null && !rConstituency.equals("00") && !rConstituency.equals("-1"))
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
			
			
	<%}
	else if(rDistrict!=null && !rDistrict.equals("00")){%>
			<tr  align="center" bgcolor="#edf2f8">
		<td align="center" class= btext colspan=10>District:<%=dname%> </td>		
	</tr>	
	<tr align=center  align=center>
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
	<%} else{%>
	<tr align="center" bgcolor="#edf2f8">
		<td align="center" class=btext colspan=10><b>District:</b> All</td>		
	</tr>	
	<tr align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		<td class=btext rowspan = 2>Total</td>
		<td class=btext colspan = 7>Coverage Status</td>
	</tr>
	<tr align = center >
		<td class=btext>FC</td>
		<td class=btext>NC</td>
		<td class=btext>NSS</td>
		<td class=btext>PC1</td>
		<td class=btext>PC2</td>
		<td class=btext>PC3</td>
		<td class=btext>PC4</td>
	</tr>

	<%}
				
	query="select  distinct d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM (Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  group by d.dcode,d.dname order by d.dcode";
	String drillType="dist";
if(rDistrict!=null && !rDistrict.equals("00"))
 {
	
	drillType="cons";
 query="select distinct c.constituency_code,c.constituency_name,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+rDistrict+"' group by c.constituency_code,c.constituency_name ";
}
if(rConstituency!=null && !rConstituency.equals("00") && !rConstituency.equals("-1"))
{
	drillType="mand";	
	query="select distinct m.mcode,m.mname,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM (Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+rDistrict+"'  and c.constituency_code='"+rConstituency+"' group by m.mcode,m.mname";
} 
 if(rMandal!=null && !rMandal.equals("00") && !rMandal.equals("-1"))
	{
	   drillType="panchayat";
	  query="select distinct p.pcode,p.pname,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM (Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+rDistrict+"'  and c.constituency_code='"+rConstituency+"' and m.mcode='"+rMandal+"' group by p.pcode,p.pname";
	}
	if(rPanchayat!=null && !rPanchayat.equals("00") && !rPanchayat.equals("-1"))
	{
		drillType="village";
		query="select distinct v.vcode,v.vname,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM (Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+rDistrict+"'  and c.constituency_code='"+rConstituency+"' and m.mcode='"+rMandal+"'  and p.pcode='"+rPanchayat+"' group by v.vcode,v.vname";
	}
	if(rVillage!=null && !rVillage.equals("00") && !rVillage.equals("-1"))
	{
		 drillType="habs";
		query="select distinct h.panch_code,h.panch_name,SUM(Case When Hd.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When Hd.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When Hd.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM (Case When Hd.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When Hd.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When Hd.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When Hd.coverage_status='PC4' then 1 Else 0 End) AS PC4,count(*) from rws_constituency_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode=c.dcode and m.mcode=c.mcode and d.dcode='"+rDistrict+"'  and c.constituency_code='"+rConstituency+"' and m.mcode='"+rMandal+"'  and p.pcode='"+rPanchayat+"' and v.vcode='"+rVillage+"' group by h.panch_code,h.panch_name";
	}
	String dis=request.getParameter("district");
	String  cons=request.getParameter("constituency");
	String man=request.getParameter("mandal");
	String panch=request.getParameter("panchayat");
	String vill=request.getParameter("village");
	
	//// System.out.println("di:"+dis);
	//// System.out.println("c:"+cons);
	//// System.out.println("man:"+man);
	//// System.out.println("p:"+panch);
	//// System.out.println("v:"+vill);

	 int sno=0;
	stmt1=conn.createStatement();	
	//// System.out.println("all "+query);
	rs2 = stmt1.executeQuery(query);	
	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
	while(rs2.next())
	{
		//// System.out.println("drillType:"+drillType);
	%>
	    
	      <tr>
        <td class=rptValue><%=++sno%></td>
        <%if(drillType.equals("dist")) {%>
		 <td class=rptValue><a href="./rws_const_coverage_drill_rpt.jsp?driltype=<%=drillType%>&dcode=<%=rs2.getString(1)%>&concode=<%=cons%>&mcode=<%=man%>&pcode=<%=panch%>&vcode=<%=vill%>&distname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
		 <%}else if(drillType.equals("cons")){%>
		 <td class=rptValue><a href="./rws_const_coverage_drill_rpt.jsp?driltype=<%=drillType%>&dcode=<%=dis%>&concode=<%=rs2.getString(1)%>&mcode=<%=man%>&pcode=<%=panch%>&vcode=<%=vill%>&distname=<%=dname%>&cname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
		 <%} else if (drillType.equals("mand")) {%>
		 <td class=rptValue><a href="./rws_const_coverage_drill_rpt.jsp?driltype=<%=drillType%>&dcode=<%=dis%>&concode=<%=cons%>&mcode=<%=rs2.getString(1)%>&pcode=<%=panch%>&vcode=<%=vill%>&distname=<%=dname%>&cname=<%=cname%>&mname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
		 <%}else if (drillType.equals("panchayat")) {%>
		 <td class=rptValue><a href="./rws_const_coverage_drill_rpt.jsp?driltype=<%=drillType%>&dcode=<%=dis%>&concode=<%=cons%>&mcode=<%=man%>&pcode=<%=rs2.getString(1)%>&vcode=<%=vill%>&distname=<%=dname%>&cname=<%=cname%>&mname=<%=mname%>&pname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
		 <%} else if (drillType.equals("village")) {%>
		 <td class=rptValue><a href="./rws_const_coverage_drill_rpt.jsp?driltype=<%=drillType%>&dcode=<%=dis%>&concode=<%=cons%>&mcode=<%=man%>&pcode=<%=panch%>&vcode=<%=rs2.getString(1)%>&distname=<%=dname%>&cname=<%=cname%>&mname=<%=mname%>&pname=<%=pname%>&vname=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
		 <%} else  if (drillType.equals("habs")) {%>
		 <td class=rptValue><%=rs2.getString(2)%></td>
		 <%}%>
	      <td class=btext><%=rs2.getInt(10)%></td>
		    <td class=rptValue><%=rs2.getInt(3)%></td>
			<% fcTotal+=rs2.getInt(3); %>
			<td class=rptValue><%=rs2.getInt(4)%></td>
			<% ncTotal+=rs2.getInt(4); %>
			<td class=rptValue><%=rs2.getInt(5)%></td>
			<% nssTotal+=rs2.getInt(5); %>
			<td class=rptValue><%=rs2.getInt(6)%></td>
			<% pc1Total+=rs2.getInt(6); %>
			<td class=rptValue><%=rs2.getInt(7)%></td>
			<% pc2Total+=rs2.getInt(7); %>
			<td class=rptValue><%=rs2.getInt(8)%></td>
			<% pc3Total+=rs2.getInt(8); %>
			<td class=rptValue><%=rs2.getInt(9)%></td>
			<% pc4Total+=rs2.getInt(9); %>
						
	  </tr>
	 <%}
	  rs2.close();
	int grandtotal=0;
	grandtotal=fcTotal+ncTotal+nssTotal+pc1Total+pc2Total+pc3Total+pc4Total+uiTotal;
%>
</tr>

    
	<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext><font color="blue"><%=grandtotal%></font></td>
		<td class=btext><%=fcTotal%></td>
		<td class=btext><%=ncTotal%></td>
		<td class=btext><%=nssTotal%></td>
		<td class=btext><%=pc1Total%></td>
		<td class=btext><%=pc2Total%></td>
		<td class=btext><%=pc3Total%></td>
		<td class=btext><%=pc4Total%></td>
		
	</tr>
<%
	}catch(Exception e){

	// System.out.println("Exception in jsp:"+e);
	}%>
	</table>

</form>
</body>
</html>
