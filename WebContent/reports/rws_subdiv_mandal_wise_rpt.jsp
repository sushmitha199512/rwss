<%@ include file = "conn.jsp" %>
<%@ include file = "header_rpt.jsp" %>
<%		
	Statement st1=null,st2 = null,st3 = null,st4 = null,st5 = null,st6=null,st7=null,st8=null;
	ResultSet rs1 = null,rs2 = null,rs3= null,rs4 = null,rs5 = null,rs6 = null,rs7=null,rs8=null;
	ResultSetMetaData rsm=null;
	ResultSet r1 = null,r2 = null,r3 = null,r4 = null,r5 = null,r6=null,r7=null, r8=null;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null, a1="";



 
/*
 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
 String panchayat=request.getParameter("panchayat");

String district1=request.getParameter("district1");
 String mandal1=request.getParameter("mandal1");
 String panchayat1=request.getParameter("panchayat1");

String divCode=request.getParameter("divCode");
String subcode=request.getParameter("pcode");
  String subdiv=request.getParameter("pname");
 


  String dcode,mCode,pCode;

 if(district==null && mandal==null && panchayat==null)
 {
 
 dcode=request.getParameter("dcode");
 session.setAttribute("dcode",dcode);
 String dname=request.getParameter("dname");
  session.setAttribute("dName",dname);

    mCode=request.getParameter("mcode");
	session.setAttribute("mCode",mCode); 
	String mname=request.getParameter("mname");
	session.setAttribute("mName",mname); 

     pCode=request.getParameter("pcode");
	session.setAttribute("pCode",pCode); 
	String pname=request.getParameter("pname");
	session.setAttribute("pName",pname); 

  //session.setAttribute("pName",null);
 // session.setAttribute("subdiv",subdiv);
 
 }
 else
 {
	dcode = district;
	//divCode = mandal;
	//mcode = panchayat;
	mCode = mandal;
	pCode = panchayat;
	 session.setAttribute("dcode",dcode);
 }*/

 String district=request.getParameter("district");
 String mandal=request.getParameter("mandal");
  String panchayat=request.getParameter("panchayat");
	String dCode;
	String mCode;
	String pCode;
 //String panchayat=request.getParameter("panchayat");
 
  //System.out.println("district="+district);
 // //System.out.println("mandal="+mandal);
 // //System.out.println("panchayat="+panchayat);

// //System.out.println("dDDDDDDDDDDDDDDD"+session.getAttribute("dName") );
 // //System.out.println("mMMMMMMMMMMMMMMl="+session.getAttribute("mName"));
 // //System.out.println("pPPPPPPPPPPPPPPPP="+session.getAttribute("pName"));
 if(district==null && mandal==null && panchayat==null)
 {
    //dCode=String.valueOf(session.getAttribute("dcode"));
	dCode=request.getParameter("dcode");
    //mCode=String.valueOf(session.getAttribute("mcode"));
	mCode=request.getParameter("mcode");
    pCode=request.getParameter("pcode");
	session.setAttribute("pCode",pCode); 
	String pname=request.getParameter("pname");
	session.setAttribute("pName",pname); 

 }
 else
 {
	 dCode = district;
	 mCode = mandal;
	 pCode=panchayat;
 }
	

////System.out.println("dDDDDDDDDDDDDDDD       "+dCode ); 
 ////System.out.println("mMMMMMMMMMcode  ="+mCode);


int start=0,end,limit = 10;
	int Cnt,pgn,tpn;
	int Count=0,i=0;



String s=request.getParameter("start");

int slno=0;
try{	
String qq2="SELECT DISTINCT m.mcode,m.mname,nvl(am.hab_code,'-'),nvl(am.CENSUS_YEAR,'-'), nvl(am.CENSUS_PLAIN_POPU,'0'),nvl(am.CENSUS_SC_POPU,'0'),nvl(am.CENSUS_ST_POPU,'0'),nvl(am.FLOAT_POP,'0'),nvl(am.FLOAT_POP_REASONS,'-'),nvl(to_Char(am.STATUS_DATE,'DD-MON-YY'),'-'),nvl(am.PLAIN_POPU_COVERED,'0'),nvl(am.SC_POP_COVERED,'0'),nvl(am.ST_POP_COVERED,'0'),nvl(am.TOTAL_WATER_SUPPLY,'0'),nvl(am.EXIST_WATER_LEVEL,'0'),nvl(am.COVERAGE_STATUS,'-'),nvl(am.NEAR_SURFACE_SOURCE,'0'),nvl(am.NEAR_GROUND_SOURCE,'0'),nvl(am.REMARKS,'-'),nvl(am.QUALITY_AFFECTED,'-'),nvl(to_Char(am.UPDATE_DATE,'DD-MON-YY'),'-'),nvl(am.PREVIOUS_YR_STATUS,'-'),nvl(am.PRESENT_YR_STATUS,'-'),nvl(am.PROPOSED_FC_YEAR,'-'),nvl(am.PROPOSED_FC_EST_AMT,'0')  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl am,rws_mandal_subdivision_tbl ms where d.dcode=substr(am.hab_code,1,2) and m.mcode=substr(am.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(am.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=am.hab_code and  ms.circle_office_code='"+ dCode+"' and ms.division_office_code ="+mCode+" and ms.subdivision_office_code='"+ pCode+"'  and ms.circle_office_code=am.circle_office_code and ms.division_office_code=am.division_office_code and ms.subdivision_office_code = am.subdivision_office_code order by m.mname"; 

/*String qq2="SELECT distinct  m.mcode, m.mname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h,rws_mandal_subdivision_tbl ms where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"' and ms.circle_office_code='"+ dcode+"' and ms.division_office_code ="+divCode+" and ms.subdivision_office_code='"+ mcode+"'  and ms.circle_office_code=h.circle_office_code and ms.division_office_code=h.division_office_code and ms.subdivision_office_code = h.subdivision_office_code order by m.mname"; */

/*	String qq2="SELECT distinct  m.mcode, m.mname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+dcode+"' order by m.mname"; */
	//System.out.println("query is  "+qq2);

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
				<a href="./rws_office_wise_details_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;
				<a href="../home.jsp">Home &nbsp;|&nbsp;</a>
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
	<td align="center" class="mystyle1"><font color="navy">Circle: <%=session.getAttribute("dName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>

<td align="center" class="mystyle1"><font color="navy">Division: <%=session.getAttribute("mName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
<td align="center" class="mystyle1"><font color="navy">Sub division: <%=session.getAttribute("pName") %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>
	<!--<tr>
	<td align="center" class="mystyle1"><font color="navy">District: <%=session.getAttribute("circle")%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
</tr>-->



</table>

<INPUT TYPE="hidden" name="start" value="<%=start%>">
<%
	String st=request.getParameter("start");
// //System.out.println("val of start    "+st);%>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr >
	
	
		<td class="btext">S.NO.</td>
		<td class="btext">Mandal Name</td> 
		<td class="btext">HabCode</td>
		<td class="btext">CensusYear</td>
        <td class="btext">Census<BR>PlainPopu </td>
        <td class="btext">Census<BR>SCPop </td>        
        <td class="btext">Census<BR>STPop</td>  
		<td class="btext">FloatPop</td>
		<td class="btext">FloatPop<br>Reasons</td>
		<td class="btext">StatusDate </td>
		<td class="btext">PlainPop<br>Covered  </td>
        <td class="btext">SCPop<br>Covered  </td>  
		<td class="btext">STPop<br>Covered  </td> 
	    <td class="btext">TotalWater<br>Supply  </td>
		<td class="btext">ExistWater<br>level   </td>
        <td class="btext">Coverage Status  </td>        
        <td class="btext">NearSurface<br>Source  </td>  
		<td class="btext">NearGround<br>Source </td>
		<td class="btext">Remarks  </td>
		<td class="btext">Quality Affected     </td>
        <td class="btext">UpdateDate     </td>
        <td class="btext">PreviousYr<br>Status  </td>        
        <td class="btext">PresentYr<br>Status   </td> 
		<td class="btext">ProposedFC<br>Year  </td>        
        <td class="btext">ProposedFC<br>EstAmt   </td> 
		</tr>
	
<%
	 String mandcode[]=new String[Count];
	 String temp="";
	if(Count!=0){
		end = start + limit;
		
			//for(int j = start; j<=Count ; j++)
			int j=0;
				while(rs6.next())
					{	
					%>
		<tr align=left bgcolor="#ffffff">
			<td class="rptValue"><%=++slno%> </td>
			<td class="rptValue"><%=rs6.getString(2)%></td>
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
   <%}%>
   </table>
<%
}else { // //System.out.println("There are no Recoreds");
%>
<p>"There are no Recoreds sadiq"</p>
<%}
conn.close();
}
catch(Exception e){  //System.out.println("error is"+e);
	}
%>
