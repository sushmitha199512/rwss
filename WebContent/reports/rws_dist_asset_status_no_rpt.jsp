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
 String panchayat=request.getParameter("panchayat");
 
 
 
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 

//String distCode=(String)(session.getAttribute("districtCode"));

 //String fdate=request.getParameter("FDate");
//String tdate=request.getParameter("TDate");



int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	

%>
<html>
<title> WaterSoft </title>
<head>
<script>
		window.history.forward(1);
	</script>
<style>
.mystyle
{
	border-width:1;
	color:brown;
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
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">


<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_hab_asset_status_no_frm.jsp">Back|</a>
				<a href="../home.jsp">Home|</a>
				<!--<a href="./rws_cir_div_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;-->
				<!--<a href="./rws_cir_div_status_rpt_print_excel.jsp" target="_new">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="9">
			<font color="ffffff">Asset Status Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
    <tr><% 
	if(session.getAttribute("dName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("dName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Mandal: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%} if(session.getAttribute("pName")!=null){%>
<td align="center" nowrap class="mystyle1"><font color="navy">Panchayat: <%=session.getAttribute("pName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%} if(session.getAttribute("vName")!=null){%>
<td align="center" nowrap class="mystyle1"><font color="navy">Village: <%=session.getAttribute("vName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}if(session.getAttribute("hName")!=null){%>
<td align="center" nowrap class="mystyle1"><font color="navy">Habitation:<%=session.getAttribute("hName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
</tr>
</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	    <td class="btext">S.NO.</td>
		<td class="btext">DISTRICT</td>
		<td class="btext">PWS</td> 
        <td class="btext">CPWS </td>
		<td class="btext">MPWS </td>
		<td class="btext">PONDS </td>
		<td class="btext">OPENWELLS</td>
		<td class="btext">HANDPUMPS</td>
		<td class="btext">SHALLOWHNDPUMPS</td>
		</tr>
		

<%
int Count=0,i=0;
String s=request.getParameter("start");


try{
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

String qu1="SELECT distinct d.dcode,d.dname as DISTRICT,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '6%' then 1 else 0 END)AS PWS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '8%' then 1 else 0 END)AS CPWS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '4%' then 1 else 0 END)AS MPWS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '7%' then 1 else 0 END)AS PONDS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%' then 1 else 0 END)AS OPENWELLS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' then 1 else 0 END)AS HANDPUMPS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%' then 1 else 0 END)AS SHALLOWHNDPUMPS FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_district_tbl d WHERE M.ASSET_CODE=S.ASSET_CODE and d.dcode=substr(M.hab_code,1,2) group by d.dcode,d.dname";

 //System.out.println("sadiq ali else  "+qu1);
	rs6=st6.executeQuery(qu1);	
	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
			 int slno=0,total=0;
	 while(rs6.next())
		{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
		<td class="mystyle1">
			<a href="rws_mand_asset_status_no_rpt.jsp?dcode=<%=rs6.getString(1)%>
			&dname=<%=rs6.getString(2)%>"><%=rs6.getString(2)%></a></td>
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
			</tr>
<%
			}
			rs6.close();
			
int grandtotal=0;
grandtotal=fcTotal+ncTotal+nssTotal+pc1Total+pc2Total+pc3Total+pc4Total;

%>
</tr>
	<tr>
		<td class=btext colspan=2>Grand Total</td>
		<td class=btext><%=fcTotal%></td>
		<td class=btext><%=ncTotal%></td>
		<td class=btext><%=nssTotal%></td>
		<td class=btext><%=pc1Total%></td>
		<td class=btext><%=pc2Total%></td>
		<td class=btext><%=pc3Total%></td>
		<td class=btext><%=pc4Total%></td>
		
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

