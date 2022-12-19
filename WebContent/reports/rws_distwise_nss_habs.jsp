<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
 <%		
 Statement st1=null,st2=null;
 ResultSet rs1 = null,rs2=null;
 String query1=null,qu1=null;
 String fdate=(String)session.getAttribute("FDate");
 String gtxidValueOld = "",gtxidValue="";
 System.out.println("fdate year"+fdate.substring(7,11));
 String curryear=RwsUtils.getCurrentYear();
 System.out.println("curryear"+curryear);
 %>
<html>
<title> WaterSoft </title>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_coverage_status_frm1.jsp">Back|</a>
				<a href="../home.jsp">Home|</a><a href="./rws_distwise_nss_habs_xls.jsp">Excel</a>
				</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">NSS Habitations Details  Report as on <%=fdate%></font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
<tr>
<td align="center" class="btext"><font color="navy">ALL Districts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
		<td class="btext" >S.NO.</td>
		<td class="btext" >District</td> 
		<td class="btext">Mandal</td> 
		<td class="btext">Panchayat</td> 
        <td class="btext">Vilage</td> 
		<td class="btext">Habitation ID</td> 
		<td class="btext">Habitaion Name</td> 
		<td class="btext">Habitation Status</td>
        <td class="btext">Contamination Type</td> 
        <td class="btext">Contaminated Value</td>  
	  </tr>

<%
int slno=0;
try{
	st1=conn.createStatement();
	if(fdate.substring(7,11).equals(curryear))
	{
	query1="select DISTINCT d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,hd.coverage_status,ct.CONTAMINATION_NAME ,nvl(hc.cont_perc,'0') from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd , rws_hab_contamination_tbl hc,RWS_CONTAMINATION_TBL ct where d.dcode=m.dcode ";
	query1+="and m.dcode=p.dcode ";
	query1+="and m.mcode =p.mcode ";
	query1+="and p.dcode=v.dcode ";
	query1+="and p.mcode=v.mcode ";
	query1+="and p.pcode=v.pcode ";
	query1+="and substr (h.panch_code,1,2) = v.dcode ";
	query1+="and substr (h.panch_code,6,2) = v.mcode ";
	query1+="and substr(h.panch_code,13,2) = v.pcode ";
	query1+="and substr (h.panch_code,8,3) = v.vcode ";
	query1+="and h.panch_code=hd.hab_code ";
	query1+="and hd.coverage_status is not null  and hd.coverage_status <> 'UI'  and  hd.coverage_status='NSS' ";
	query1+="and hd.status_date ='"+fdate+"' and hd.hab_code=hc.hab_code and hc.cont_type=ct.CONTAMINATION_CODE   order by 1";
    }
    else
	{
    query1="select DISTINCT d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,hd.coverage_status,ct.CONTAMINATION_NAME ,nvl(hc.cont_perc,'0') from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_dir_his_tbl hd , rws_hab_contamination_tbl hc,RWS_CONTAMINATION_TBL ct where d.dcode=m.dcode ";
	query1+="and m.dcode=p.dcode ";
	query1+="and m.mcode =p.mcode ";
	query1+="and p.dcode=v.dcode ";
	query1+="and p.mcode=v.mcode ";
	query1+="and p.pcode=v.pcode ";
	query1+="and substr (h.panch_code,1,2) = v.dcode ";
	query1+="and substr (h.panch_code,6,2) = v.mcode ";
	query1+="and substr(h.panch_code,13,2) = v.pcode ";
	query1+="and substr (h.panch_code,8,3) = v.vcode ";
	query1+="and h.panch_code=hd.hab_code ";
	query1+="and hd.coverage_status is not null  and hd.coverage_status <> 'UI'  and  hd.coverage_status='NSS' ";
	query1+="and hd.status_date ='"+fdate+"' and hd.hab_code=hc.hab_code and hc.cont_type=ct.CONTAMINATION_CODE  order by 1";
	}




	System.out.println("query1"+query1);
    rs1=st1.executeQuery(query1);
	while (rs1.next())
	{    
       gtxidValue =rs1.getString(1);
		++ slno;
		%>  <tr>
		    <td class=btext align="left"><%=slno %></td>
             <% if(!gtxidValue.equals(gtxidValueOld)){%>
		     <td class=btext align="left"><%=rs1.getString(1) %></td>
             <%}
             else
				{%>
                   <td class=rptValue align="left"></td>
                <%}%>

		    <td class=rptValue align="left"><%=rs1.getString(2) %></td>
			<td class=rptValue align="left"><%=rs1.getString(3) %></td>
			<td class=rptValue align="left"><%=rs1.getString(4) %></td>
			<td class=rptValue align="left"><%=rs1.getString(5) %></td>
			<td class=rptValue align="left"><%=rs1.getString(6) %></td>
			<td class=rptValue align="left"><%=rs1.getString(7) %></td>
			<td class=rptValue align="left"><%=rs1.getString(8) %></td>
			<td class=rptValue align="left"><%=rs1.getString(9) %></td>
			
			 </tr>
	<%
    gtxidValueOld = gtxidValue;
   }
	rs1.close();
	%>
   
    </table>
 <%}
	catch(Exception e)
	{
	 e.printStackTrace();
    }
   
 %>
 </table>
</form>
 <%@ include file = "footer.jsp" %>
 </body>
 </html>
