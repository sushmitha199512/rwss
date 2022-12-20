
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
query1="select distinct to_char(status_date,'yyyy') from rws_habitation_directory_tbl h where status_date is not null";
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
	   qq2="SELECT DISTINCT p.pcode, p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_panchayat_tbl p,rws_habitation_directory_tbl HD,rws_panchayat_raj_tbl pr where p.dcode=substr(HD.hab_code,1,2) and p.mcode=substr(HD.hab_code,6,2) and p.pcode=substr(HD.hab_code,13,2)  and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=hd.hab_code group by p.pcode, p.pname";
	}
	else
	{

			qq2="SELECT DISTINCT p.pcode, p.pname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3, SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,count(*) from rws_panchayat_tbl p,rws_habitation_dir_his_tbl HD,rws_panchayat_raj_tbl pr where p.dcode=substr(HD.hab_code,1,2) and p.mcode=substr(HD.hab_code,6,2) and p.pcode=substr(HD.hab_code,13,2)  and substr(HD.hab_code,1,2)='"+dCode+"' and substr(HD.hab_code,6,2)='"+mCode+ "' and status_date ='" + fdate +"' and coverage_status is not null and pr.panch_code=hd.hab_code group by p.pcode, p.pname";
	}
	
	st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
	rs6=st6.executeQuery(qq2);	
	
		
		
%>
<html>
<head>
<script>
	window.history.forward(1);
</script>
<title> WaterSoft </title>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_coverage_status_frm1.jsp">Back|</a>
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
			<font color="ffffff">GOI-Habitation Coverage Status  Report </font></td>
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

<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %></font></td>
</tr>
<%} %>


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
		<td align="center" class="btext" colspan=5> Habitation Status</td> 
	<tr>
		<td class="btext">FC </td>
		<td class="btext">PC</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		
		</tr>	


<%		int fcTotal=0,ncTotal=0,nssTotal=0,pcTotal=0,pchabs=0,nchabs=0,pc2Total=0,uiTotal=0;
			 int slno=0,total=0;
	 while(rs6.next())
		{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
		<td class="mystyle1">
			<a href="rws_goi_panch_only_rpt.jsp?pcode=<%=rs6.getString(1)%>&pname=<%=rs6.getString(2)%>&FDate=<%=fdate%>&dcode=<%=dCode%>&mcode=<%=mCode%>"><%=rs6.getString(2)%></a></td>
        
		<%  /*total=rs6.getInt(3)+rs6.getInt(4)+rs6.getInt(5)+rs6.getInt(6)+rs6.getInt(7)+rs6.getInt(8)+rs6.getInt(9)+rs6.getInt(10);
		 System.out.println("total is "+total);*/
		  %>
		  
		 <td class=btext align="right"><%=rs6.getInt(10)%></td>
		   <td class=rptValue align="right"><%=rs6.getString(3)%></td>
			<% fcTotal+=rs6.getInt(3); %>
			<%pchabs=rs6.getInt(4)+rs6.getInt(5)+rs6.getInt(6);%>
			<td class=rptValue align="right"><%=pchabs%></td>
			<% pcTotal+=pchabs;%>
            <%nchabs=rs6.getInt(7)+rs6.getInt(8);%>
			<td class=rptValue align="right"><%=nchabs%></td>
			<% ncTotal+=nchabs; %>
			<td class=rptValue align="right"><%=rs6.getString(9)%></td>
			<% nssTotal+=rs6.getInt(9); %>
			
			</tr>
<%
			}
			rs6.close();
			

int grandtotal=0;
grandtotal=fcTotal+pcTotal+ncTotal+nssTotal;

%>
</tr>
  
	<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext align="right"><font color="blue"><%=grandtotal%></font></td>
		<td class=btext align="right"><%=fcTotal%></td>
		<td class=btext align="right"><%=pcTotal%></td>
		<td class=btext align="right"><%=ncTotal%></td>
		<td class=btext align="right"><%=nssTotal%></td>
		
		
		
		
		
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
</table>
</TD></TR>
</TABLE>
</form>
</body>
</html>
