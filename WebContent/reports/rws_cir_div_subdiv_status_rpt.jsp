
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null, a1="";

	String district=request.getParameter("district");
	String mandal=request.getParameter("mandal");
	String dCode;
	String mCode;
   String dName=String.valueOf(session.getAttribute("dName"));
 
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
	int start=0,end,limit = 10;
	int Cnt,pgn,tpn;

%>
		
<%
int Count=0,i=0;
// //System.out.println("coount of rows is    ");

	
			

String s=request.getParameter("start");


      /* String qq2="SELECT DISTINCT d.subdivision_office_code , d.subdivision_office_name as \"Subdivision Name\",SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI  from  rws_habitation_directory_tbl HD, rws_subdivision_office_tbl d where  d.division_office_code = HD.division_office_code and  HD.circle_office_code = '" + dCode + "'  and HD.division_office_code='"+mCode+"' group by d.subdivision_office_code , d.subdivision_office_name";*/

	   String qq2="SELECT  distinct sd.subdivision_office_code,sd.subdivision_office_name,sum(case when coverage_status='FC' then 1 else 0 end)as fc ,sum(case when coverage_status='PC1' then 1 else 0 end) as pc1,sum(case when coverage_status='PC2' then 1 else 0 end) as pc2,sum(case when coverage_status='PC3' then 1 else 0 end) as pc3,sum(case when coverage_status='PC4' then 1 else 0 end) as pc4,sum(case when coverage_status='NC' then 1 else 0 end) as nc,sum(case when coverage_status='NSS' then 1 else 0 end) as nss,sum(case when coverage_status='UI' then 1 else 0 end) as ui,count(*) from  rws_habitation_directory_tbl h, rws_subdivision_office_tbl sd where  sd.circle_office_code=h.circle_office_code and sd.division_office_code = h.division_office_code and  h.subdivision_office_code = sd.subdivision_office_code and sd.circle_office_code = '"+dCode+"'  and sd.division_office_code='"+mCode+"'  group by sd.subdivision_office_code , sd.subdivision_office_name";

        
	
	
    try
	{
	st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
	rs6=st6.executeQuery(qq2);	
	
	%>
<html>
<head>
<script>
		window.history.forward(1);
	</script>
	<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}
</style>
<title> WaterSoft </title>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">


<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_office_coverage_frm.jsp">Back|</a>
				<a href="../home.jsp">Home</a>
				<!-- <a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_coverage_status_rpt_print_excel.jsp" target="_new">Excel</a> -->
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

	<tr>
	<td align="center" class="btext"><font color="navy">Circle: <%=session.getAttribute("dName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>

<td align="center" class="btext"><font color="navy">Division: <%=session.getAttribute("mName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>
</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr >
	
	
		<td class="btext" rowspan=2>S.NO.</td>
		<td class="btext" rowspan=2>Subdivision Name</td>
		<td class="btext" rowspan=2>Total</td> 
		<td align="center" class="btext" colspan=9> Habitation Status</td> 
<tr>
		<td class="btext">FC </td>
		<td class="btext">PC1 </td>
		<td class="btext">PC2 </td>
		<td class="btext">PC3</td>
		<td class="btext">PC4</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		<td class="btext">UI</td>
		</tr>
	
<%
	 
				int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
			 int slno=0,total=0;
	 while(rs6.next())
		{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
		<td class="mystyle1">
			<a href="rws_subdiv_mandal_coverage_rpt.jsp?pcode=<%=rs6.getString(1)%>&pname=<%=rs6.getString(2)%>&mcode=<%=mCode%>&dcode=<%=dCode%>"><%=rs6.getString(2)%></a></td>
        
		<% 
			/*total=rs6.getInt(3)+rs6.getInt(4)+rs6.getInt(5)+rs6.getInt(6)+rs6.getInt(7)+rs6.getInt(8)+rs6.getInt(9)+rs6.getInt(10);
		 System.out.println("total is "+total);*/
		  %>
		  
		 <td class=btext><%=rs6.getInt(11)%></td>
		<td class=rptValue><%=rs6.getString(3)%></td>
			<% fcTotal+=rs6.getInt(3); %>
			<td class=rptValue><%=rs6.getString(4)%></td>
			<% ncTotal+=rs6.getInt(4); %>
			<td class=rptValue><%=rs6.getString(5)%></td>
			<% nssTotal+=rs6.getInt(5); %>
			<td class=rptValue><%=rs6.getString(6)%></td>
			<% pc1Total+=rs6.getInt(6); %>
			<td class=rptValue><%=rs6.getString(7)%></td>
			<% pc2Total+=rs6.getInt(7); %>
			<td class=rptValue><%=rs6.getString(8)%></td>
			<% pc3Total+=rs6.getInt(8); %>
			<td class=rptValue><%=rs6.getString(9)%></td>
			<% pc4Total+=rs6.getInt(9); %>
			<td class=rptValue><%=rs6.getString(10)%></td>
			<% uiTotal+=rs6.getInt(10); %>
			</tr>
<%
			}
			rs6.close();
			

		
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
		<td class=btext><%=uiTotal%></td>
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
