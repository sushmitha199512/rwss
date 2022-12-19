<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1=null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null,query1=null, a1="",currentYear=null,qu1=null;

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");

 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 


 // String fdate=request.getParameter("FDate");
//String fdate=(String)session.getAttribute("FDate");
String fdate=request.getParameter("FDate");
// System.out.println("fdate:"+fdate);
String tdate=request.getParameter("TDate");
if(fdate != null)
{
a1 =  " and status_date ='" + fdate +"' ";


}


int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	int Count=0,i=0;

%>
<html>
<title> WaterSoft </title>
<head>
<script>
// window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_hab_coverage_status_rpt.jsp">Back|</a>
				<a href="../home.jsp">Home|</a>
				<!--<a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_coverage_status_rpt_print_excel.jsp" target="_new">Excel</a>-->
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
<%if(fdate!=null && !fdate.equals("0"))
	{%>
<tr>
		<td class="textborder" align="center">
			<font size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status As On : </font><font color=#F2A80D> <%=fdate%> </font></td>
	</tr>
	<% }%>
	<tr><% if(!dCode.equals("51")|| dCode.equals("51")) {%>
	<td align="center" class="btext"><font color="navy">District: All<% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="btext"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>
</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// // System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr >
	
		
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>District Name</td> 
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
		

<%

String s=request.getParameter("start");


try{
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
query1="select distinct to_char(status_date,'yyyy') from rws_habitation_directory_tbl h where status_date is not null";
rs2=st7.executeQuery(query1);
while (rs2.next())
	{
    currentYear=rs2.getString(1);
	}
/*String currentprevYear=null,qu1=null,currentYear=null;
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
java.util.Date currentDate = new java.util.Date();
currentYear= dateFormat.format(currentDate).substring(0,4);
java.util.Date currentMinus1Y = new java.util.Date(currentDate.getTime()) ;
// change year to year  - 1 in this date
currentMinus1Y.setYear(currentMinus1Y.getYear()-1) ;
currentprevYear= dateFormat.format(currentMinus1Y).substring(0,4);*/

/*if(fdate.substring(7,11).equals(currentYear))
	{
qu1="SELECT DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_habitation_directory_tbl HD,rws_panchayat_raj_tbl pr  where d.dcode=substr(HD.hab_code,1,2) and status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=hd.hab_code group by d.dcode,d.dname"; 
   }
else
	{
       qu1="SELECT DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_habitation_dir_his_tbl HD,rws_panchayat_raj_tbl pr where d.dcode=substr(HD.hab_code,1,2) and status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=hd.hab_code group by d.dcode,d.dname"; 
	}*/
	qu1 = "select DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM (Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and status_date ='"+fdate+"' group by d.dcode,d.dname";
// System.out.println("Query:"+qu1);
	rs6=st6.executeQuery(qu1);	
	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
			 int slno=0,total=0;
	 while(rs6.next())
		{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
		<td class="mystyle1">
			<a href="rws_mandal_status_rpt123.jsp?dcode=<%=rs6.getString(1)%>&dname=<%=rs6.getString(2)%>&FDate=<%=fdate%>"><%=rs6.getString(2)%></a></td>
        
		<%  /*total=rs6.getInt(3)+rs6.getInt(4)+rs6.getInt(5)+rs6.getInt(6)+rs6.getInt(7)+rs6.getInt(8)+rs6.getInt(9)+rs6.getInt(10);
		 // System.out.println("total is "+total);*/
		 
		 session.setAttribute("dname",rs6.getString(2));
		 
		  %>
		  
		 <td class=btext><%=rs6.getInt(10)%></td>
		<td class=rptValue><%=rs6.getString(3)%></td>
			<% fcTotal+=rs6.getInt(3); %>
			<td class=rptValue><%=rs6.getString(4)%></td>
			<% pc4Total+=rs6.getInt(4); %>
			<td class=rptValue><%=rs6.getString(5)%></td>
			<% pc3Total+=rs6.getInt(5); %>
			<td class=rptValue><%=rs6.getString(6)%></td>
			<% pc2Total+=rs6.getInt(6); %>
			<td class=rptValue><%=rs6.getString(7)%></td>
			<% pc1Total+=rs6.getInt(7); %>
			<td class=rptValue><%=rs6.getString(8)%></td>
			<% ncTotal+=rs6.getInt(8); %>
			<td class=rptValue><%=rs6.getString(9)%></td>
			<% nssTotal+=rs6.getInt(9); %>
			
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
<%@ include file = "footer.jsp" %>

</form>
</body>
</html>
