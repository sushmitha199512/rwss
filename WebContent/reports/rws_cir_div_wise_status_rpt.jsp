<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %> 
 <%@ include file = "conn.jsp" %>
 
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
  String dcode;
  //System.out.println("district="+district);
 // //System.out.println("mandal="+mandal);
 // //System.out.println("panchayat="+panchayat);

// //System.out.println("dDDDDDDDDDDDDDDD"+session.getAttribute("dName") );
 // //System.out.println("mMMMMMMMMMMMMMMl="+session.getAttribute("mName"));
 // //System.out.println("pPPPPPPPPPPPPPPPP="+session.getAttribute("pName"));
 if(district==null)
 {
 
  dcode=request.getParameter("dcode");
 session.setAttribute("dcode",dcode);

 String dname=request.getParameter("dname");
  session.setAttribute("dName",dname);
   session.setAttribute("subdiv",null);
 }
 else
 {
	dcode = district;
	 session.setAttribute("dcode",dcode);
 }
 
int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	int Count=0,i=0;

%>
		

<%
try
{
String s=request.getParameter("start");

int slno=0;
String qq2="SELECT DISTINCT d.division_office_code,d.division_office_name,nvl(am.hab_code,'-'),nvl(am.CENSUS_YEAR,'-'),nvl(am.CENSUS_PLAIN_POPU,'0'),nvl(am.CENSUS_SC_POPU,'0'),nvl(am.CENSUS_ST_POPU,'0'),nvl(am.FLOAT_POP,'0'),nvl(am.FLOAT_POP_REASONS,'-'),nvl(to_Char(am.STATUS_DATE,'DD-MON-YY'),'-'),nvl(am.PLAIN_POPU_COVERED,'0'),nvl(am.SC_POP_COVERED,'0'),nvl(am.ST_POP_COVERED,'0'),nvl(am.TOTAL_WATER_SUPPLY,'0'),nvl(am.EXIST_WATER_LEVEL,'0'),nvl(am.COVERAGE_STATUS,'-'),nvl(am.NEAR_SURFACE_SOURCE,'0'),nvl(am.NEAR_GROUND_SOURCE,'0'),nvl(am.REMARKS,'-'),nvl(am.QUALITY_AFFECTED,'-'),nvl(to_Char(am.UPDATE_DATE,'DD-MON-YY'),'-'),nvl(am.PREVIOUS_YR_STATUS,'-'),nvl(am.PRESENT_YR_STATUS,'-'),nvl(am.PROPOSED_FC_YEAR,'-'),nvl(am.PROPOSED_FC_EST_AMT,'0')  from rws_panchayat_raj_tbl tm, rws_habitation_directory_tbl am, rws_division_office_tbl d where  d.circle_office_code=am.circle_office_code and d.division_office_code = am.division_office_code and am.hab_code=tm.panch_code and  am.circle_office_code = '"+dcode+"' order by d.division_office_code , d.division_office_name";

	
	////System.out.println("query is  "+qq2);

	st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                      ResultSet.CONCUR_READ_ONLY);
	rs6=st6.executeQuery(qq2);	
	rs6.last();
	Count = rs6.getRow();
	////System.out.println("coount of rows is  CCCCCCCCCCCCCCC  "+Count);
	rs6.beforeFirst();
	%>
<html>
<head>
<title> WaterSoft </title>
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

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr>
			<td align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
	
	
		<tr align="right">
			<td class="bwborder">
				<a href="./rws_office_wise_details_frm.jsp">Back&nbsp;|&nbsp;</a>
				<a href="../home.jsp">Home &nbsp;|&nbsp;</a>
			<!-- 	<a href="./rws_coverage_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_xls.jsp" target="_new">Excel</a>-->
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
	<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	</tr>
</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">

<%
	String st=request.getParameter("start");%>
	<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	<td class="btext">S.no</td>
		<td class="btext">Division Name</td>
		<td class="btext">HabCode</td>
		<td class="btext">CensusYear</td>
        <td class="btext">Census<BR>PlainPopu</td>
        <td class="btext">Census<BR>SCPop</td>        
        <td class="btext">Census<BR>STPop</td>  
		<td class="btext">FloatPop</td>
		<td class="btext">FloatPop<br>Reasons</td>
		<td class="btext">StatusDate</td>
		<td class="btext">PlainPop<br>Covered</td>
        <td class="btext">SCPop<br>Covered</td>  
		<td class="btext">STPop<br>Covered</td> 
	    <td class="btext">TotalWater<br>Supply</td>
		<td class="btext">ExistWater<br>level</td>
        <td class="btext">Coverage Status</td>        
        <td class="btext">NearSurface<br>Source</td>  
		<td class="btext">NearGround<br>Source </td>
		<td class="btext">Remarks  </td>
		<td class="btext">Quality Affected</td>
        <td class="btext">UpdateDate</td>
        <td class="btext">PreviousYr<br>Status </td>        
        <td class="btext">PresentYr<br>Status </td> 
		<td class="btext">ProposedFC<br>Year</td>        
        <td class="btext">ProposedFC<br>EstAmt</td> 
		</tr>

<%
	if(Count!=0){
	end = start + limit;
		
while(rs6.next())
		{
			 %>
		<tr align=left bgcolor="#ffffff">
			<td class="rptValue"><%=++slno%> </td>
			<td class="rptValue"><a href="rws_cir_div_subdiv_wise_status_rpt.jsp?mcode=<%=rs6.getString(1)%>&mname=<%=rs6.getString(2)%>"><%=rs6.getString(2)%></a></td>
           <td class="rptValue"><%=rs6.getString(3)%></td>
		  <td class="rptValue"><%=rs6.getString(4)%></td> 
		  <td class="rptValue"><%=rs6.getString(5)%> </td> 
    	  <td class="rptValue"><%=rs6.getString(6)%></td>  
		 <td class="rptValue"><%=rs6.getString(7)%></td> 
		 <td class="rptValue"><%=rs6.getString(8)%> </td>   
		 <td class="rptValue"><%=rs6.getString(9)%></td>
		<td class="rptValue"><%=rs6.getString(10)%></td> 
		 <td class="rptValue"><%=rs6.getString(11)%></td>
		  <td class="rptValue"><%=rs6.getString(12)%></td> 
		  <td class="rptValue"><%=rs6.getString(13)%></td> 
    	  <td class="rptValue"><%=rs6.getString(14)%></td>  
		 <td class="rptValue"><%=rs6.getString(15)%></td> 
		<td class="rptValue"><%=rs6.getString(16)%></td>   
		<td class="rptValue"><%=rs6.getString(17)%></td>
		<td class="rptValue"><%=rs6.getString(18)%></td>
		<td class="rptValue"><%=rs6.getString(19)%></td> 
		 <td class="rptValue"><%=rs6.getString(20)%></td>
		  <td class="rptValue"><%=rs6.getString(21)%></td> 
		  <td class="rptValue"><%=rs6.getString(22)%></td> 
    	  <td class="rptValue"><%=rs6.getString(23)%></td>  
		 <td class="rptValue"><%=rs6.getString(24)%></td> 
		 <td class="rptValue"><%=rs6.getString(25)%></td> 
	    
	</tr>

		
<%
		}%>
		</table>
<% }else { // //System.out.println("There are no Recoreds");
%>
<p>There are no Records</p>
<%}
conn.close();
 }catch(Exception e){  //System.out.println("error is"+e);
}

%>
