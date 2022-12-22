<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null,district=null,mandal=null,panchayat=null,village=null,habitation=null,a1="";
    String dCode=null, mCode=null,pCode=null,vCode=null,hCode=null,qq2=null;

district=request.getParameter("district");
mandal=request.getParameter("mandal");
  panchayat=request.getParameter("panchayat");
 village=request.getParameter("village");
  habitation=request.getParameter("habitation");

  if(district==null && mandal==null && panchayat==null && village==null && habitation==null)
 {
	String dName=String.valueOf(session.getAttribute("dName"));
    String mName=String.valueOf(session.getAttribute("mName"));
    String pName=String.valueOf(session.getAttribute("pName"));
    dCode=request.getParameter("dcode");
	session.setAttribute("dcode",dCode); 
	 mCode=request.getParameter("mcode");
	session.setAttribute("mcode",mCode); 
	 pCode=request.getParameter("pcode");
	session.setAttribute("pcode",pCode); 
    vCode=request.getParameter("vcode");
	session.setAttribute("vCode",vCode); 
	String vname=request.getParameter("vname");
	session.setAttribute("vName",vname); 

 }
 else
 {
	 dCode = district;
	 mCode = mandal;
	 pCode=panchayat;
	 vCode=village;
	 hCode=habitation;
 }
	
int start=0,end,limit = 10;
	int Cnt,pgn,tpn;

%>
		
<%
    if((vCode!=null && hCode==null)||(vCode!=null &&(hCode.equals("0")|| hCode.equals("-1"))))
	{
		
	 qq2="SELECT DISTINCT pr.panch_code AS HABITATIONCODE,pr.panch_name AS HABITATION,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '6%' then 1 else 0 END)AS PWS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '8%' then 1 else 0 END)AS CPWS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '4%' then 1 else 0 END)AS MPWS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '7%' then 1 else 0 END)AS PONDS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%' then 1 else 0 END)AS OPENWELLS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' then 1 else 0 END)AS HANDPUMPS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%' then 1 else 0 END)AS SHALLOWHNDPUMPS  FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_panchayat_raj_tbl pr WHERE M.ASSET_CODE=S.ASSET_CODE and substr(M.hab_code,1,2)='"+dCode+"' and substr(M.hab_code,6,2)='"+mCode+"' and substr(M.hab_code,13,2)='"+pCode+"' and substr(M.hab_code,8,3) ='"+vCode+"' and M.hab_code = pr.PANCH_CODE group by  pr.panch_code,pr.panch_name"; 
	}
	else
	{
		
	 qq2="SELECT DISTINCT pr.panch_code AS HABITATIONCODE,pr.panch_name AS HABITATION,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '6%' then 1 else 0 END)AS PWS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '8%' then 1 else 0 END)AS CPWS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '4%' then 1 else 0 END)AS MPWS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '7%' then 1 else 0 END)AS PONDS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%' then 1 else 0 END)AS OPENWELLS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' then 1 else 0 END)AS HANDPUMPS,sum(Case When SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%' then 1 else 0 END)AS SHALLOWHNDPUMPS  FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S,rws_panchayat_raj_tbl pr WHERE M.ASSET_CODE=S.ASSET_CODE and M.hab_code = pr.PANCH_CODE and substr(M.hab_code,1,2)='"+dCode+"' and substr(M.hab_code,6,2)='"+mCode+"' and substr(M.hab_code,13,2)='"+pCode+"' and substr(M.hab_code,8,3) = '"+vCode+"'  and  substr(M.hab_code,1,16)='"+hCode+"' group by  pr.panch_code,pr.panch_name";
	}
	try
	{
	st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
	rs6=st6.executeQuery(qq2);	
	
		
%>
<html>
<head>
<title> WaterSoft </title>
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
				<a href="./rws_hab_asset_status_no_frm.jsp">Back |</a>
				<a href="../home.jsp">Home |</a>
				<!-- <a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_coverage_status_rpt_print_excel.jsp" target="_new">Excel</a> -->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="9">
			<font color="ffffff">Asset Status  Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	
<tr>
	<td align="center" class="btext"><font color="navy">District: <%=session.getAttribute("dName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>

<td align="center" class="btext"><font color="navy">Mandal: <%=session.getAttribute("mName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<td align="center" class="btext"><font color="navy">Panchayat: <%=session.getAttribute("pName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>

	<tr>
	<!--<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("circle") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>-->

<td align="center" class="btext"><font color="navy">Village: <%=session.getAttribute("vName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<td align="center" class="btext"><% if(session.getAttribute("hName")!=null){%>
<font color="navy">Habitation: <%=session.getAttribute("hName")%> 
<%}%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>
</table>
<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	 <tr>
	    <td class="btext">S.NO.</td>
		<td class="btext">HABITATION</td>
		<td class="btext">PWS</td> 
        <td class="btext">CPWS </td>
		<td class="btext">MPWS </td>
		<td class="btext">PONDS </td>
		<td class="btext">OPENWELLS</td>
		<td class="btext">HANDPUMPS</td>
		<td class="btext">SHALLOWHNDPUMPS</td>
		</tr>

         


<%		
	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
			 int slno=0,total=0;
	 while(rs6.next())
		{
		
		++ slno;
	
%>
		<td class=rptValue><%=slno%></td>
		
			<!--<a href="rws_cir_div_sub_man_panch_hab_status_rpt.jsp?panCode=<%=rs6.getString(1)%>&panName=<%=rs6.getString(2)%>&dcode=<%=dCode%>"><%=rs6.getString(2)+'-'%><%=rs6.getString(1)%></a></td>-->
            <td class=rptValue><%=rs6.getString(2)+'-'%><%=rs6.getString(1)%></td>
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
