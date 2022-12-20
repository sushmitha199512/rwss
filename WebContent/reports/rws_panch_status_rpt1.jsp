
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null, a1="",query1=null;

	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
	String dCode;
	String mCode;
	String con=request.getParameter("con");
 
 if(district==null && mandal==null)
 {
   //dCode=String.valueOf(session.getAttribute("dcode"));
    dCode=request.getParameter("dcode");
    mCode=request.getParameter("mcode");
	session.setAttribute("mCode",mCode); 
	String mname=request.getParameter("mname");
	session.setAttribute("mName",mname); 

 }
 else
 {
	 dCode = district;
	 mCode = mandal;
 }
	
 String fdate=(String)session.getAttribute("FDate");
int start=0,end,limit = 10;
	int Cnt,pgn,tpn;

%>
		
<%
int Count=0,i=0;
// System.out.println("coount of rows is    ");
try
{
	
	 if(fdate!=null && !fdate.equals("0") )
	{
		a1 =  " and status_date ='" + fdate +"' ";
	}
	    String currentYear=null,qq2=null;
		st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
query1="select distinct to_char(status_date,'yyyy') from rws_hab_static_dir_tbl h where status_date is not null";
rs2=st7.executeQuery(query1);
while (rs2.next())
	{
    currentYear=rs2.getString(1);
	}
/*java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
java.util.Date currentDate = new java.util.Date();
currentYear= dateFormat.format(currentDate).substring(0,4);*/

 if(fdate.substring(7,11).equals(currentYear))
	{
//	   qq2="SELECT DISTINCT p.pcode, p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_panchayat_tbl p,rws_hab_static_dir_tbl HD,rws_panchayat_raj_tbl pr where p.dcode=substr(HD.hab_code,1,2) and p.mcode=substr(HD.hab_code,6,2) and p.pcode=substr(HD.hab_code,13,2)  and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=hd.hab_code group by p.pcode, p.pname";
		qq2 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_hab_static_dir_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname";
	}
	else
	{

	//		qq2="SELECT DISTINCT p.pcode, p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3, SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_panchayat_tbl p,rws_habitation_dir_his_tbl HD,rws_panchayat_raj_tbl pr where p.dcode=substr(HD.hab_code,1,2) and p.mcode=substr(HD.hab_code,6,2) and p.pcode=substr(HD.hab_code,13,2)  and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=hd.hab_code group by p.pcode, p.pname";
	qq2 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_dir_his_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname";
	}
	
		//qq2 = "select DISTINCT d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_hab_static_dir_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' group by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname";

	st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
	rs6=st6.executeQuery(qq2);	
	
		
		
%>
<html>
<head>

<title> WaterSoft </title>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="javascript:history.back(-1)">Back|</a> 
				<a href="../home.jsp">Home</a>
				<!--<a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_coverage_status_rpt_print_excel.jsp?dCode=<%=dCode%>&mCode=<%=mCode%>
				&FDate=<%=fdate%>" target="_new">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Habitation Coverage Status  Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
<%if(fdate!=null && !fdate.equals("0") )
	{%>
<tr>
		<td class="textborder" align="center">
			<font size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;Status As On : </font><font color=#F2A80D> <%=fdate %> </font></td>
	</tr>
	<% }%>
	<tr>
	<td align="center" class="btext"><font color="navy">District: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>

<td align="center" class="btext"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<td align="center" class="btext"><font color="navy">Constituncey: <%=con%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>

</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>Panchayat Name</td>
        <td class="btext" rowspan=2>Total</td>
		<td align="center" class="btext" colspan=9> Habitation Status</td> 
	<tr>
		<td class="btext">FC </td>
		<td class="btext">PC4 </td>
		<td class="btext">PC3 </td>
		<td class="btext">PC2</td>
		<td class="btext">PC1</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		
		</tr>	


<%		int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
			 int slno=0,total=0;
	 while(rs6.next())
		{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
		<td class="mystyle1">
			<a href="rws_panch_only_status_rpt.jsp?pcode=<%=rs6.getString(5)%>&pname=<%=rs6.getString(6)%>&FDate=<%=fdate%>&dcode=<%=dCode%>&mcode=<%=mCode%>&con=<%=con%>"><%=rs6.getString(6)%></a></td>
        
		<%  /*total=rs6.getInt(3)+rs6.getInt(4)+rs6.getInt(5)+rs6.getInt(6)+rs6.getInt(7)+rs6.getInt(8)+rs6.getInt(9)+rs6.getInt(10);
		 System.out.println("total is "+total);*/
		  %>
		  
		 <td class=btext><%=rs6.getInt(14)%></td>
		<td class=rptValue><%=rs6.getString(7)%></td>
			<% fcTotal+=rs6.getInt(7); %>
			<td class=rptValue><%=rs6.getString(8)%></td>
			<% pc4Total+=rs6.getInt(8); %>
			<td class=rptValue><%=rs6.getString(9)%></td>
			<% pc3Total+=rs6.getInt(9); %>
			<td class=rptValue><%=rs6.getString(10)%></td>
			<% pc2Total+=rs6.getInt(10); %>
			<td class=rptValue><%=rs6.getString(11)%></td>
			<% pc1Total+=rs6.getInt(11); %>
			<td class=rptValue><%=rs6.getString(12)%></td>
			<% ncTotal+=rs6.getInt(12); %>
			<td class=rptValue><%=rs6.getString(13)%></td>
			<% nssTotal+=rs6.getInt(13); %>
			
			</tr>
<%
			}
			rs6.close();
			

int grandtotal=0;
grandtotal=fcTotal+pc4Total+pc3Total+pc2Total+pc1Total+ncTotal+nssTotal;

%>
</tr>
  
	<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext><font color="blue"><%=grandtotal%></font></td>
		<td class=btext><%=fcTotal%></td>
		<td class=btext><%=pc4Total%></td>
		<td class=btext><%=pc3Total%></td>
		<td class=btext><%=pc2Total%></td>
		<td class=btext><%=pc1Total%></td>
		<td class=btext><%=ncTotal%></td>
		<td class=btext><%=nssTotal%></td>
		
		
		
		
		
	</tr>
</table>
<%
		
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>

</table>
</TD></TR>
<%@ include file = "footer.jsp" %>
</TABLE>
</form>
</body>
</html>
