<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
<HTML>
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

<form>
<%
String dcode=request.getParameter("dcode");
String division=request.getParameter("division");
String month=request.getParameter("month");
String startyear=request.getParameter("startyear");
String endyear=request.getParameter("endyear");
String sourcecode=request.getParameter("sourcecode");
String dname=request.getParameter("dname");
String divname=request.getParameter("divname");
String typeofsource=request.getParameter("typeofsource");
  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
    String qry="";
    int styleCount=0;
    String style="";    
    
   	%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="60%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<td  class="bwborder"><a href="javascript:history.go(-1)">Back|
			<a href="#" onClick="window.close();">Close</a>  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg >WaterQuality Sources Report For District:&nbsp;<%=dname%>&nbsp;&nbsp;Division:&nbsp;<%=divname%>&nbsp; </td>
	</tr>

</table>
<table    width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>	
	<td class=gridhdbg >Sl.No</td>
	<!-- <td class=gridhdbg >District</td>
	<td class=gridhdbg >Mandal</td>
	<td class=gridhdbg >Panchayat</td>
	<td class=gridhdbg >Village</td>
	<td class=gridhdbg >HabCode</td>
	<td class=gridhdbg >Hab Name</td> -->	
	<td class=gridhdbg >SourceCode</td>
	<td class=gridhdbg >Parameter Name</td>
	<td class=gridhdbg nowrap="nowrap">MIN-MAX Value</td>
	<td class=gridhdbg >Parameter Value</td> 
  </tr>       
<%
try
{

String sourceCode="";
   //main qry
   Statement stmt8=null,stmt7=null;
   ResultSet rs8=null,rs7=null;
   int sno=1;
   stmt8=conn.createStatement();   
   int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;  
   String query="",qry1="";
   	  
	     if(typeofsource!=null && typeofsource.equals("01"))
	     {
	     query="select  a.source_code,e.TESTING_PARAMETER_NAME,nvl(max(d.TESTING_PARAMETER_VALUE),'-'),nvl(e.MIN_PERMISSIBLE_VALUE,0),nvl(e.MAX_PERMISSIBLE_VALUE,0) from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c,RWS_WQ_TEST_RESULTS_LNK_TBL  d,rws_wq_para_test_tbl e where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and  a.test_id=d.test_id and b.test_code=1 and d.TESTING_PARAMETER_code=e.TESTING_PARAMETER_code and  CIRCLE_OFFICE_CODE ='"+dcode+"' AND division_office_code='"+division+"' and a.source_code='"+sourcecode+"' and ((d.TESTING_PARAMETER_code='04' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null  and d.TESTING_PARAMETER_VALUE is not null) or  (d.TESTING_PARAMETER_code='05' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='07' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='12' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='13' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='15' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='14' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='16' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='06' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null))  and my_to_number(TESTING_PARAMETER_VALUE) is not null and substr(a.source_code,20,2)='SO' and SAMP_COLLECT_DATE between '"+startyear+"' and '"+endyear+"' ";
	     }
	     else
	     {
	    	 query="select  a.source_code,e.TESTING_PARAMETER_NAME,nvl(max(d.TESTING_PARAMETER_VALUE),'-'),nvl(e.MIN_PERMISSIBLE_VALUE,0),nvl(e.MAX_PERMISSIBLE_VALUE,0) from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c,RWS_WQ_TEST_RESULTS_LNK_TBL  d,rws_wq_para_test_tbl e where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and  a.test_id=d.test_id and b.test_code=1 and d.TESTING_PARAMETER_code=e.TESTING_PARAMETER_code and CIRCLE_OFFICE_CODE ='"+dcode+"' AND division_office_code='"+division+"' and a.source_code='"+sourcecode+"' and ((d.TESTING_PARAMETER_code='04' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null  and d.TESTING_PARAMETER_VALUE is not null) or  (d.TESTING_PARAMETER_code='05' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='07' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='12' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='13' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='15' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='14' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='16' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='06' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(e.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null))  and my_to_number(TESTING_PARAMETER_VALUE) is not null and SAMP_COLLECT_DATE between '"+startyear+"' and '"+endyear+"' ";
	     }
	     if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
	    	 query+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			
	     query+=" group by  a.source_code,e.TESTING_PARAMETER_NAME,nvl(e.MIN_PERMISSIBLE_VALUE,0),nvl(e.MAX_PERMISSIBLE_VALUE,0) "; 
		
		//System.out.println("query"+query); 
			  
  rs8=stmt8.executeQuery(query); 
   while(rs8.next())
   {
   	String source_code=rs8.getString(1);
   	String hab_code=source_code.substring(0,16);
   //	System.out.println("hab_code"+hab_code);
   		stmt7=conn.createStatement();
	    qry1="select dname,mname,pname,vname,panch_code,panch_name from rws_complete_hab_view where panch_code='"+hab_code+"'";
	   rs7=stmt7.executeQuery(qry1);
	//  System.out.println("qry1"+qry1);
	   if(rs7.next()){	   
	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;	 
%>
	<tr>	
	    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	    <!-- <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(1)%></td>
	    <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(2)%></td>
	    <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(3)%></td>
	    <td class="<%=style%> "style="text-align: left"> <%=rs7.getString(4)%></td>
	    <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(5)%></td>
	    <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(6)%></td>-->          
	    <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(1)%></td>
	    <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(2)%></td>
	    <td class="<%=style%> "style="text-align: right;">  <%=rs8.getString(4)%>-<%=rs8.getString(5)%></td>
	    <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(3)%></td>   
  	</tr>  	
<%
sourceCode=rs8.getString(1);
	   }
	   rs7.close();
	   stmt7.close();
}%>	
  <tr align="left">  	
   	</tr>
<%
if(stmt8!=null){
	stmt8.close();
}
if(rs8!=null){
	rs8.close();
}

	}catch(Exception e)
		{
		e.printStackTrace();
		}
%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>