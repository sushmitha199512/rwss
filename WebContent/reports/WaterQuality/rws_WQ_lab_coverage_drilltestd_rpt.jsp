<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<html>

<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
<script language="JavaScript">


function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}



</script>



<%



int count=1;
String yr=request.getParameter("yr1");
String endyear=request.getParameter("endyear");
System.out.println("yr"+yr);
System.out.println("endyear"+endyear);


String divname=request.getParameter("divname");
String dname=request.getParameter("dname");
String year=request.getParameter("year");

String subdivname=request.getParameter("subdivname");
/* String yr=(String)session.getAttribute("yr");

//String yr1=request.getParameter("yr1"); 
String yr2=(String)session.getAttribute("yr2"); */
//System.out.println("Y3*******"+yr2);
String circleofficecode=request.getParameter("circleofficecode");
//System.out.println("circleofficecode************"+circleofficecode);
String divisionofficecode=request.getParameter("divisionofficecode");
//String subdivisionofficecode=request.getParameter("subdivisionofficecode");

String[] programes=request.getParameterValues("program");
//System.out.println("programes*****"+programes);
//String pro=(String)session.getAttribute("programes",programes);
String dcode=request.getParameter("dcode");
   if(dcode!=null){
		session.setAttribute("dcode",dcode);
		//System.out.println("dcode*********"+dcode);
		
}


    DecimalFormat ndf = new DecimalFormat("##.##");



 %>
<form>
<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>
</td>
<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
	</tr>  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >District:&nbsp;<%=dname %>&nbsp;&nbsp;&nbsp;&nbsp; </td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
<td class=gridhdbg ><b>District</b></td>
<td class=gridhdbg ><b>Mandal </b></td>
<td class=gridhdbg ><b>Panchayat </b></td>
<td class=gridhdbg><b>Village </b></td>
<td class=gridhdbg><b>Hab Name </b></td>
<td class=gridhdbg><b>Hab Code </b></td>




  </tr>


	<%ResultSet rs3=null;
	Statement stmt3=null;
	
	//String z1="",z2="",z3="",z4="",z5="",z6="";
	int styleCount=0;
	String style="";

	try
      {
		
String query="";




//before querry
query="select distinct dname,mname,pname,vname,panch_name,panch_code from rws_wq_test_results_tbl b,rws_complete_hab_view c where  substr(b.source_code,1,16)=c.panch_code  and C.COVERAGE_STATUS<>'UI' and  to_date(prepared_on)>='1-APR-"+yr+"' and  to_date(prepared_on)<'31-MAR-"+endyear+"' and dcode='"+dcode+"'  order by dname";

//"select substr(c.panch_code,1,2),count(distinct c.panch_code) from rws_wq_test_results_tbl b,rws_complete_hab_view c where  substr(b.source_code,1,16)=c.panch_code  and C.COVERAGE_STATUS<>'UI' and  to_date(prepared_on)>='1-APR-"+yr+"' and  to_date(prepared_on)<'31-MAR-"+yr1+"'  group by  substr(c.panch_code,1,2) order by 1";

stmt3=conn.createStatement();
//System.out.println("queryssss*******&&&&&&&&&&&*"+query);
//String sh1="",sh2="",sh3="",sh4="",sh5="";
rs3=stmt3.executeQuery(query);

//String scode="",labcode="",testid="",condemn="",prepared="";
while(rs3.next()){
	
	
		
		
	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	
	
	

%>
<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(1)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(2)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(3)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(4)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(5)%></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(6)%></td>

</tr>
<% 


}
}

     
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
	
</table>
</form>

