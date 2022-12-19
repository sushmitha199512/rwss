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



String divname=request.getParameter("divname");
//System.out.println("divname******"+divname);
String cname=request.getParameter("cname");
String subdivname=request.getParameter("subdivname");
String year=(String)session.getAttribute("year");
String[] ar=year.split("-");
String yearStart=ar[0];
String yearEnd=ar[1];
String month=(String)session.getAttribute("month");
String typeofsource=request.getParameter("typeofsource");
String circleofficecode=request.getParameter("circleofficecode");
System.out.println("typeofsource*******"+typeofsource);
String divisionofficecode=request.getParameter("divisionofficecode");
//System.out.println("divisionofficecode************"+divisionofficecode);


String[] programes=request.getParameterValues("program");






int count=1;

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
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >District:&nbsp;<%=cname %>&nbsp;&nbsp;&nbsp;&nbsp; </td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg><b>SL&nbsp;NO</b></td>
<td class=gridhdbg><b>District</b></td>
<td class=gridhdbg><b>Mandal</b></td>
<td class=gridhdbg><b>Panchayat</b></td>
<td class=gridhdbg><b>Village</b></td>
<td class=gridhdbg><b>Hab Name</b></td>
<td class=gridhdbg><b>Hab Code</b></td>
<td class=gridhdbg><b>Source Code</b></td>




  </tr>


	<%ResultSet rs3=null;
	Statement stmt3=null;
	
	//String z1="",z2="",z3="",z4="",z5="",z6="";
	int styleCount=0;
	StringBuffer style=new StringBuffer();
	StringBuffer q1=new StringBuffer();
	try
      {
		




		q1.delete(0,q1.length());
			
			
			
		if(typeofsource!=null && typeofsource.equals("01"))
		{
			 q1.append("select dname,mname,pname,vname,panch_name,panch_code ,c.division_office_code,c.source_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and FIELD_TEST_CHEMICAL ='Y' and substr(c.source_code,20,2)='SO' and dcode='"+circleofficecode+"' and c.division_office_code='"+divisionofficecode+"'");
		}
		else
		{
			 q1.append("select dname,mname,pname,vname,panch_name,panch_code ,c.division_office_code,c.source_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) and FIELD_TEST_CHEMICAL ='Y' and dcode='"+circleofficecode+"' and c.division_office_code='"+divisionofficecode+"'");
			
		}
			if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			 {
			  q1.append(" and to_char(test_date,'MON')='"+month+"' ");
			 }
			 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
			 {
			  q1.append(" and test_date between '"+yearStart+"' and '"+yearEnd+"'");
			 }
			q1.append(" group by  dname,mname,pname,vname,panch_name,panch_code ,c.division_office_code,source_code   order by 2 ");

			
			
			
			
			
			

//System.out.println("q2***********"+q1);


//"select substr(c.panch_code,1,2),count(distinct c.panch_code) from rws_wq_test_results_tbl b,rws_complete_hab_view c where  substr(b.source_code,1,16)=c.panch_code  and C.COVERAGE_STATUS<>'UI' and  to_date(prepared_on)>='1-APR-"+yr+"' and  to_date(prepared_on)<'31-MAR-"+yr1+"'  group by  substr(c.panch_code,1,2) order by 1";

stmt3=conn.createStatement();
//System.out.println("queryssss*******&&&&&&&&&&&*"+query);
//String sh1="",sh2="",sh3="",sh4="",sh5="";
rs3=stmt3.executeQuery(q1.toString());
//System.out.println("q2*****ggggg******"+q1);
//String scode="",labcode="",testid="",condemn="",prepared="";
while(rs3.next()){
	
	//System.out.println("q2*****ggggg******");
		
	style.delete(0,style.length());
	
	 if(styleCount%2==0){
		 style.append(("gridbg1"));
	 }else{
		 style.append(("gridbg2"));
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
<td class="<%=style %>" style="text-align: left;" align="right"><%=rs3.getString(8)%></td>

</tr>
<% 


}
}

     
     catch(Exception e)
     {
    	 
    	// System.out.println("exception in waterqtly report:"+e);
     e.printStackTrace();
    
     } 
     finally{
    	 
    	
     }
	%>
	
</table>
</form>

