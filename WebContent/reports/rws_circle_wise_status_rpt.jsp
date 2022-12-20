<%@ include file = "conn.jsp" %>
<%@ include file = "header_rpt.jsp" %>
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
 
  //System.out.println("district="+district);
  //System.out.println("mandal="+mandal);
  //System.out.println("panchayat="+panchayat);

// //System.out.println("dDDDDDDDDDDDDDDD"+session.getAttribute("dName") );
 // //System.out.println("mMMMMMMMMMMMMMMl="+session.getAttribute("mName"));
 // //System.out.println("pPPPPPPPPPPPPPPPP="+session.getAttribute("pName"));
 
 String dCode=String.valueOf(session.getAttribute("dCode"));
 String mCode=String.valueOf(session.getAttribute("mCode")); 
 String pCode=String.valueOf(session.getAttribute("pCode")); 

////System.out.println("dDDDDDDDDDDDDDDD       "+dCode ); 
// //System.out.println("mMMMMMMMMMcode  ="+mCode);
// //System.out.println("pPPPPPPPPPPPPPPPP=   "+pCode);
 //String fdate=request.getParameter("FDate");
//String tdate=request.getParameter("TDate");

int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	

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
				<a href="./rws_office_wise_details_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home &nbsp;|&nbsp;</a>
				<!--<a href="./rws_cir_div_status_rpt_print.jsp" target="_new">Print&nbsp;|&nbsp;</a>&nbsp;
				<a href="./rws_xls.jsp" target="_new">Excel</a>-->
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
			<font color="ffffff">Habitation Office Wise Details Status  Report </font></td>
	</tr>
<tr><td valign=top>

<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center>	

	<tr><% if(!dCode.equals("51") && (!dCode.equals("null"))) {%>
	<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %><% } %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<% if(session.getAttribute("mName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<%}%>
<% if(session.getAttribute("pName")!=null){%>
<td align="center" class="mystyle1"><font color="navy">Subdivision: <%=session.getAttribute("pName") %></font></td>
</tr>
<%} %>


</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// //System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
        <td class="btext">S.no</td>
		<td class="btext">Circle Name</td>
		<td class="btext">HabCode</td>
		<td class="btext">CensusYear</td>
        <td class="btext">Census<BR>PlainPopu </td>
        <td class="btext">Census<BR>SCPop </td>        
        <td class="btext">Census<BR>STPop</td>  
		<td class="btext">FloatPop</td>
		<td class="btext">FloatPop<br>Reasons</td>
		<td class="btext">StatusDate </td>
		<td class="btext">PlainPop<br>Covered</td>
        <td class="btext">SCPop<br>Covered</td>  
		<td class="btext">STPop<br>Covered</td> 
	    <td class="btext">TotalWater<br>Supply</td>
		<td class="btext">ExistWater<br>level</td>
        <td class="btext">Coverage Status</td>        
        <td class="btext">NearSurface<br>Source</td>  
		<td class="btext">NearGround<br>Source </td>
		<td class="btext">Remarks</td>
		<td class="btext">Quality Affected</td>
        <td class="btext">UpdateDate</td>
        <td class="btext">PreviousYr<br>Status</td>        
        <td class="btext">PresentYr<br>Status</td> 
		<td class="btext">ProposedFC<br>Year</td>        
        <td class="btext">ProposedFC<br>EstAmt</td> 
		</tr>

<%
  int j=0;
int Count=0,i=0;
String s=request.getParameter("start");

int slno=0;

try{
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

String qu1 ="SELECT DISTINCT c.circle_office_code,c.circle_office_name,nvl(am.hab_code,'-'),nvl(am.CENSUS_YEAR,'-'),nvl(am.CENSUS_PLAIN_POPU,'0'),nvl(am.CENSUS_SC_POPU,'0'),nvl(am.CENSUS_ST_POPU,'0'),nvl(am.FLOAT_POP,'0'),nvl(am.FLOAT_POP_REASONS,'-'),nvl(to_Char(am.STATUS_DATE,'DD-MON-YY'),'-'),nvl(am.PLAIN_POPU_COVERED,'0'),nvl(am.SC_POP_COVERED,'0'),nvl(am.ST_POP_COVERED,'0'),nvl(am.TOTAL_WATER_SUPPLY,'0'),nvl(am.EXIST_WATER_LEVEL,'0'),nvl(am.COVERAGE_STATUS,'-'),nvl(am.NEAR_SURFACE_SOURCE,'0'),nvl(am.NEAR_GROUND_SOURCE,'0'),nvl(am.REMARKS,'-'),nvl(am.QUALITY_AFFECTED,'-'),nvl(to_Char(am.UPDATE_DATE,'DD-MON-YY'),'-'),nvl(am.PREVIOUS_YR_STATUS,'-'),nvl(am.PRESENT_YR_STATUS,'-'),nvl(am.PROPOSED_FC_YEAR,'-'),nvl(am.PROPOSED_FC_EST_AMT,'0') from rws_panchayat_raj_tbl tm, rws_habitation_directory_tbl am, rws_circle_office_tbl c where c.circle_office_code=am.circle_office_code and am.hab_code=tm.panch_code order by c.circle_office_code,c.circle_office_name";

 //System.out.println("sadiq ali else  "+qu1);
	rs6=st6.executeQuery(qu1);	
	rs6.last();
	Count = rs6.getRow();
rs6.beforeFirst();
String distcode[]=new String[Count];

		String temp="";
		String temp1="";
		String temp2="";
		String distname="";
		String mandname="";
		String panchname="";

		
	if(Count!=0){
	// if(request.getParameter("start") !=  null) {
	//start = Integer.parseInt(request.getParameter("start"));
	// //System.out.println("start values  is "+start);
		//}
		//else
		//{
		//start = 1;
			// //System.out.println("start values  is "+start);	
		//}
		end = start + limit;
		
		//for(int j = start; j <=Count ; j++)
		
		//{	
          while(rs6.next())
		{
			%>
		    <tr align=left bgcolor="#ffffff">
			<td class="rptValue"><%=++slno%></td>
			<td class="rptValue"><a href="rws_cir_div_wise_status_rpt.jsp?dcode=<%=rs6.getString(1)%>&dname=<%=rs6.getString(2)%>"><%=rs6.getString(2)%></a></td>
          <td class="rptValue"><%=rs6.getString(3)%></td>
		  <td class="rptValue"><%=rs6.getString(4)%></td> 
		  <td class="rptValue"><%=rs6.getString(5)%></td> 
    	  <td class="rptValue"><%=rs6.getString(6)%></td>  
		  <td class="rptValue"><%=rs6.getString(7)%></td> 
		  <td class="rptValue"><%=rs6.getString(8)%></td>   
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

<%}else { // //System.out.println("There are no Recoreds");%>
<p>There are no rEcords</p>
<%}
conn.close();
}catch(Exception e){e.printStackTrace();}
%>
