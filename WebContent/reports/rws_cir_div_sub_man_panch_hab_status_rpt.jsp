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
	int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	int Count=0,i=0;
	String dCode;
   String manCode;
  String panCode;
	 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");

String district1=request.getParameter("district1");
 String mandal1=request.getParameter("mandal1");
 String panchayat1=request.getParameter("panchayat1");

if(district==null && mandal==null && panchayat==null)
{
   //dCode=String.valueOf(session.getAttribute("dcode"));
   //manCode=String.valueOf(session.getAttribute("manCode")); 
    dCode=request.getParameter("dcode");
	manCode=request.getParameter("mancode");
    panCode=request.getParameter("panCode");
	session.setAttribute("panCode",panCode); 

	 String panName=request.getParameter("panName");
	session.setAttribute("panName",panName); 
}
else
{
dCode=district1;
manCode = mandal1;
panCode= panchayat1;
}
// System.out.println("val    "+district);
String s=request.getParameter("start");
// System.out.println("val of start    "+s);
int slno=0;
try{
	 
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String qu1 = "SELECT pr.panch_name,nvl(coverage_status,'--') from rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where  pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dCode+"' and substr(h.hab_code,6,2)='"+manCode+"' and  substr(h.hab_code,13,2)='"+panCode+"'   order by coverage_status";
//System.out.println("coount of rows is    "+qu1);
//	r6=st6.executeQuery("SELECT dcode,dname FROM RWS_DISTRICT_tbl order by dname");	
	r6=st6.executeQuery(qu1);	
	r6.last();
	Count = r6.getRow();
	
	
	r6.beforeFirst();
	
	// System.out.println("eeeeee555555555555555555");
	
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
				<a href="../home.jsp">Home|</a>
			    <a href="./rws_coverage_status_rpt_print_excel.jsp?dcode=<%=dCode%>&mancode=<%=manCode%>
				&pancode=<%=panCode%>" target="_new">Excel</a>
				<!-- 	<a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;-->
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
<td align="center" class="btext"><font color="navy">Sub Division: <%=session.getAttribute("pName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>
<tr>	
	<!--<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("circle") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>-->
<td align="center" class="btext"><font color="navy">Mandal: <%=session.getAttribute("manName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<td align="center" class="btext"><font color="navy">Panchayat: <%=session.getAttribute("panName") %></font></td>
</tr>

</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
		<tr>	
	
		<td class="btext" >S.NO.</td>
		<td class="btext" >Habitation</td>
		<td class="btext" >Coverage Status</td> 
</tr>	

<%	 
if(Count!=0){
	 if(request.getParameter("start") !=  null) {
	start = Integer.parseInt(request.getParameter("start"));
	// System.out.println("start values  is "+start);
		}
		else
		{
			start = 1;
			
		}
		end = start + limit;
		
		for(int j = start; j <= Count ; j++)
		{	//rs6.next();
			r6.absolute(j);	
			
	%>
		<tr align=left bgcolor="#ffffff">
			<td class="mystyle1"><%=j %> </td>
			<td class="mystyle1"><%=r6.getString(1) %> </td> 
		     <td class="mystyle1"><%=r6.getString(2) %> </td> 
		</tr>
		<%
		}
}else { // //System.out.println("There are no Recoreds");%>
<%="There are no Records"%>
<%}

}catch(Exception e){e.printStackTrace();}
finally
{
	conn.close();
}
	
%>
</table>
</td></tr>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
