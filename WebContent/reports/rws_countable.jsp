<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	String rDistrict=null;
	String date=null;
	rDistrict = String.valueOf(session.getAttribute("districtCode"));
	date = String.valueOf(session.getAttribute("FDATE"));
	String districtName = String.valueOf(session.getAttribute("districtName"));
	int pass = Integer.parseInt(request.getParameter("pass"));
	

	String query=null, query1 = null; 
	Statement stmt1 = null;
	int slno = 0,NOP=0;
	int Count = 0, i = 0,Count1=0;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0,nodatatotal=0,subfctotal=0,subpc1total=0,subpc2total=0,subpc3total=0,subpc4total=0,subnctotal=0,subnsstotal=0,subuitotal=0,subnodatatotal=0,NOP1=0;

	try
	{
%>
<html>
<head>
<script>
  window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
  <caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		<tr align="right">
			<td class="bwborder"><a href="./rws_hab_updates_frm.jsp">Back </a>|</td>
			<td class="bwborder"><a href="../home.jsp">Home </a>|</td>
			<td class="bwborder"><a href="./rws_countable_xls.jsp?rDistrict=<%=rDistrict%>&pass=<%=pass%>" target="_new">Excel</a></td>
 			<%--<td class="bwborder"><a href="./rws_excel1_prnt.jsp?rDistrict=<%=rDistrict%>" target="_new">Print |</a></td>--%>
		</tr>
	</table>
  </caption>

  <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>District-Habitation-Report</td>	
  </tr>
<% 
	
	if(rDistrict != null && rDistrict.equals("00"))
	{
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=15>District: All</td>
	</tr>	
<%
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1"))
	{
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=15>District: <%=districtName%></td>	
	</tr>	

<%
	}
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan=2>Slno</td>
		<td class=btext rowspan=2>District</td>	
		<td class=btext rowspan=2>Update Month</td>
		<td class=btext rowspan=2>No Of Habitations<br>Updated</td>
		<td class=btext colspan=10>Coverage Status</td>
	<tr>
		<td class="btext">FC </td>
		<td class="btext">PC1 </td>
		<td class="btext">PC2 </td>
		<td class="btext">PC3</td>
		<td class="btext">PC4</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td> 
		<!-- <td class="btext">UI</td>
		<td class="btext">NODATA</td> --> 
	</tr>
 </tr>
<%	try{
	if(rDistrict != null && rDistrict.equals("00"))
	{
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT distinct d.dcode,D.DNAME,count(HD.HAB_CODE), substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11) as update_date1,substr(to_char(hd.update_date,'dd-mon-yyyy'),4,10) as update_date,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+date+"' and hd.coverage_status is not null and hd.coverage_status<>'UI'  group by d.dcode,d.dname,substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11),substr(to_char(hd.update_date,'dd-mon-yyyy'),4,10)";//,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI,SUM(Case When HD.coverage_status is null then 1 Else 0 End)as Nodata
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	}
	if(!rDistrict.equals("00"))
	{
	    query="SELECT distinct d.dcode,D.DNAME,count(HD.HAB_CODE),substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11) as update_date1,substr(to_char(hd.update_date,'dd-mon-yyyy'),4,10) as update_date,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE  and d.dcode='"+rDistrict+"' AND substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+date+"' and hd.coverage_status is not null and hd.coverage_status<>'UI' group by d.dcode,d.dname,substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11),substr(to_char(hd.update_date,'dd-mon-yyyy'),4,10)";
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    }
    
	rs=stmt1.executeQuery(query);
	rs.last();
    Count = rs.getRow();
	
	rs.beforeFirst();
	
	if(Count!=0)
	{
	 while(rs.next())
	 {
	
%>	
     <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
        <td class=rptValue><%=rs.getString(4)%></td>
		
<% 
	if(rDistrict.equals("00"))
	{
		
%>
		<td class="rptValue"><a href="./rws_hab_updates_rpt.jsp?dcode=<%=rs.getString(1)%>&dName=<%=rs.getString(2)%>
		&updateDate=<%=rs.getString(4)%>"><%=rs.getString(3)%></a></td>
<%
	}
	else
	{
%>
        <td class="rptValue" align="right"><%=rs.getString(3)%></td>
<%
	}
%>
        <td class="rptValue" align="right"><%=rs.getString(6)%></td>			
		<td class="rptValue" align="right"><%=rs.getString(7)%></td>
        <td class="rptValue" align="right"><%=rs.getString(8)%></td>
		<td class="rptValue" align="right"><%=rs.getString(9)%></td>			
		<td class=rptValue align="right"><%=rs.getString(10)%></td>
        <td class=rptValue align="right"><%=rs.getString(11)%></td>
		<td class=rptValue align="right"><%=rs.getString(12)%></td>			
		<%--<td class=rptValue align="right"><%=rs.getString(13)%></td>
		<td class=rptValue align="right"><%=rs.getString(14)%></td>--%> 
	</tr>
<% 
	    NOP=NOP+rs.getInt(3);
	    fcgtotal =  fcgtotal + rs.getInt(6);
		pc1gtotal = pc1gtotal + rs.getInt(7);	
		pc2gtotal = pc2gtotal + rs.getInt(8);	
		pc3gtotal = pc3gtotal + rs.getInt(9);	
		pc4gtotal = pc4gtotal + rs.getInt(10);	
		ncgtotal = ncgtotal + rs.getInt(11);	
		nssgtotal = nssgtotal + rs.getInt(12);	
//		uitotal = uitotal + rs.getInt(13);
	//	nodatatotal = nodatatotal + rs.getInt(14);
	
		}
%>
	<tr>
		<td class="btext" align="right"colspan=3>GRANDTOTAL</td>
		<td class="rptValue" align="right"><a href="./rws_hab_updates_rpt.jsp?districtCode=<%=rDistrict%>&districtName=<%=districtName%>&updateDate=<%=date%>"><%=NOP%></a></td>
		<td class="btext" align="right"><%=fcgtotal%></td>
		<td class="btext" align="right"><%=pc1gtotal%></td>
		<td class="btext" align="right"><%=pc2gtotal%></td>
		<td class="btext" align="right"><%=pc3gtotal%></td>
		<td class="btext" align="right"><%=pc4gtotal%></td>
		<td class="btext" align="right"><%=ncgtotal%></td>
		<td class="btext" align="right"><%=nssgtotal%></td>
		<%--<td class="btext" align="right"><%=uitotal%></td>
		<td class="btext" align="right"><%=nodatatotal%></td>--%>
    </tr>
<%
	}
	else
	{
%>
 	 <td align="center" class="rptHeading" colspan=12>There are no Records</td>
	 <p><a align=center href="./rws_hab_updates_frm.jsp">GO BACK</a></p>
<%
	}
	}catch(Exception e){}
	finally{
	try{
    rs.close();
	stmt1.close();
	}catch(Exception e){}
	}
	}	
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
	try{
	conn.close();
	}catch(Exception e){}
	}
%>
</table>
<input type="hidden" name="pass"> 
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>