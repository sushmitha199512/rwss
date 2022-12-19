<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<HTML>

<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
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

function viewWorks(URL)
{
var popFeatures = "width=950,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}


</script>
<form>
<%
String dcode=request.getParameter("dcode");
String division=request.getParameter("division");
String month=request.getParameter("month");
String startyear=request.getParameter("startyear");
String endyear=request.getParameter("endyear");
String mode=request.getParameter("mode");
//System.out.println("mode"+mode);
String dname=request.getParameter("dname");
String divname=request.getParameter("divname");

/* System.out.println("startyear"+startyear);
System.out.println("endyear"+endyear);
System.out.println("month"+month);
System.out.println("dname"+dname);
System.out.println("divname"+divname); */
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();
    String qry="";
    int styleCount=0;
    String style="";
    
   	%>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">					
			<a href="#" onClick="window.close();">Close</a>
		</table>
	</caption>
<tr  align="center">
<%if(mode.equals("MPNC")){ %>
		<td align="center" class=gridhdbg >WaterQuality Samples Report(MPN Coliform/100 ml) For District:&nbsp;<%=dname%>&nbsp;&nbsp;Division:&nbsp;<%=divname%> &nbsp;</td>
		<%}else if(mode.equals("MPNE")){ %>
		<td align="center" class=gridhdbg >WaterQuality Samples Report(MPN E-Coliform/100 ml) For District:&nbsp;<%=dname%>&nbsp;&nbsp;Division:&nbsp;<%=divname%>&nbsp; </td>
		<%}else { %>
			<td align="center" class=gridhdbg >Physico-Chemical Contaminated Samples Report For District:&nbsp;<%=dname%>&nbsp;&nbsp;Division:&nbsp;<%=divname%>&nbsp; </td>
			<%} %>
</tr>
</table>
<table    width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>
	<%if(mode.equals("PCC")){ %>
	<td class=gridhdbg >Sl.No</td>
	<td class=gridhdbg >District</td>
	<td class=gridhdbg >Mandal</td>
	<td class=gridhdbg >Panchayat</td>
	<td class=gridhdbg >Village</td>
	<td class=gridhdbg >HabCode</td>
	<td class=gridhdbg >Hab Name</td>	
	<td class=gridhdbg >Source Code</td>
	<td class=gridhdbg >Lab Name</td>
	<%}else{ %>
	
	<td class=gridhdbg >Sl.No</td>
	<td class=gridhdbg >District</td>
	<td class=gridhdbg >Mandal</td>
	<td class=gridhdbg >Panchayat</td>
	<td class=gridhdbg >Village</td>
	<td class=gridhdbg >HabCode</td>
	<td class=gridhdbg >Hab Name</td>
	
	<td class=gridhdbg >SourceCode</td>
	<td class=gridhdbg >Parameter Name</td>
	
	
	<td class=gridhdbg >Parameter Value</td>
	
	
       
     
	  <%} %>
   

   </tr>
       
<%
try
{
	


   //main qry
   Statement stmt8=null,stmt7=null;
   ResultSet rs8=null,rs7=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;
  
   String query="",qry1="";
   
  if(mode.equals("MPNC"))
  {
     // query="select distinct dname,mname,pname,vname,panch_code,panch_name,a.source_code,e.TESTING_PARAMETER_CODE,e.TESTING_PARAMETER_NAME,d.TESTING_PARAMETER_VALUE   from  rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c,RWS_WQ_TEST_RESULTS_LNK_TBL  d,rws_wq_para_test_tbl e where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and  a.test_id=d.test_id and d.TESTING_PARAMETER_CODE=e.TESTING_PARAMETER_CODE and e.test_code=2 and e.TESTING_PARAMETER_code='01'  and TESTING_PARAMETER_VALUE is not null and my_to_number(TESTING_PARAMETER_VALUE) is not null and CIRCLE_OFFICE_CODE ='"+dcode+"' AND division_office_code='"+division+"' and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"'  AND SAMP_COLLECT_DATE between TO_DATE('"+startyear+"','dd/MON/yyyy') and to_date('"+endyear+"','dd/MON/yyyy')";
     query="select distinct a.source_code,e.TESTING_PARAMETER_NAME,nvl(max(d.TESTING_PARAMETER_VALUE),'-') from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c,RWS_WQ_TEST_RESULTS_LNK_TBL  d,rws_wq_para_test_tbl e where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and  a.test_id=d.test_id and  b.test_code=2 and d.TESTING_PARAMETER_code='01' and  e.TESTING_PARAMETER_code='01' and e.test_code=2 and CIRCLE_OFFICE_CODE ='"+dcode+"' AND division_office_code='"+division+"' and TESTING_PARAMETER_VALUE is not null and TESTING_PARAMETER_VALUE is not null    and SAMP_COLLECT_DATE between TO_DATE('"+startyear+"','dd/MON/yyyy') and to_date('"+endyear+"','dd/MON/yyyy') and d.TESTING_PARAMETER_VALUE is not null and d.TESTING_PARAMETER_VALUE >0 ";
     if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		{
    	 query+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
		}
		
	query+=" group by a.source_code,e.TESTING_PARAMETER_NAME";	  
		
  } 
  else if(mode.equals("PCC"))
  {
	  query="select   a.source_code,LAB_NAME  from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c,RWS_WQ_TEST_RESULTS_LNK_TBL  d,RWS_WATER_QUALITY_LAB_TBL e,rws_wq_para_test_tbl F where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and   a.test_id=d.test_id and  d.TESTING_PARAMETER_code=F.TESTING_PARAMETER_code and  a.lab_code=e.lab_code and b.test_code=1 and substr(c.panch_code,1,2)='"+dcode+"' and a.division_office_code='"+division+"' and SAMP_COLLECT_DATE between '"+startyear+"' and '"+endyear+"' and ((d.TESTING_PARAMETER_code='04' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null  and d.TESTING_PARAMETER_VALUE is not null) or  (d.TESTING_PARAMETER_code='05' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='07' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='12' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='13' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and  my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='15' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='14' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='16' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null) or  (d.TESTING_PARAMETER_code='06' and to_number(TRIM(d.TESTING_PARAMETER_VALUE))>to_number(TRIM(f.MAX_PERMISSIBLE_VALUE)) and my_to_number(TESTING_PARAMETER_VALUE) is not null))  and TESTING_PARAMETER_VALUE is not null and  to_number(TESTING_PARAMETER_VALUE)>to_number(F.MAX_PERMISSIBLE_VALUE) ";
	  if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
		{
  	 query+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
		}
	  
	  query+="group by a.source_code,LAB_NAME ";
	  
  }
  
  else
  {
	  query="select distinct a.source_code,e.TESTING_PARAMETER_NAME,nvl(max(d.TESTING_PARAMETER_VALUE),'-') from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c,RWS_WQ_TEST_RESULTS_LNK_TBL  d,rws_wq_para_test_tbl e where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and  a.test_id=d.test_id and b.test_code=2 and d.TESTING_PARAMETER_code='02' and  e.TESTING_PARAMETER_code='02' and e.test_code=2 and CIRCLE_OFFICE_CODE ='"+dcode+"' AND division_office_code='"+division+"' and TESTING_PARAMETER_VALUE is not null  and TESTING_PARAMETER_VALUE >0 and TESTING_PARAMETER_VALUE is not null    and SAMP_COLLECT_DATE between TO_DATE('"+startyear+"','dd/MON/yyyy') and to_date('"+endyear+"','dd/MON/yyyy')";
	     if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
			{
	    	 query+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
			}
			
		query+=" group by a.source_code,e.TESTING_PARAMETER_NAME";
  }
    
 // System.out.println("query PCC@@@@@@@@@"+query);
  rs8=stmt8.executeQuery(query);
 //System.out.println("query PCC"+query);  
   while(rs8.next())
   {
   	String source_code=rs8.getString(1);
   	String hab_code=source_code.substring(0,16);
   //	System.out.println("hab_code"+hab_code);
   	
	stmt7=conn.createStatement();
	    qry1="select dname,mname,pname,vname,panch_code,panch_name from rws_complete_hab_view where panch_code='"+hab_code+"'";
	   rs7=stmt7.executeQuery(qry1);
	   //System.out.println("qry1"+qry1);
	   if(rs7.next()){
	
	   
	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	<%if(mode.equals("PCC")){ %>
	<td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	
	  <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(1)%></td>
      <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(2)%></td>
       <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(3)%></td>
        <td class="<%=style%> "style="text-align: left"> <%=rs7.getString(4)%></td>
         <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(5)%></td>
         <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(6)%></td>
     <td class="<%=style%> "style="text-align: left;"><a href="#" onclick="viewWorks('rws_wq_samples_pcc_drill.jsp?dcode=<%=dcode%>&division=<%=division%>&month=<%=month%>&startyear=<%=startyear%>&endyear=<%=endyear%>&dname=<%=dname%>&divname=<%=divname%>&sourcecode=<%=rs8.getString(1)%>')"> <%=rs8.getString(1)%></a></td>
     <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
     <%}else{ %>
	
    <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
     <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(1)%></td>
      <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(2)%></td>
       <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(3)%></td>
        <td class="<%=style%> "style="text-align: left"> <%=rs7.getString(4)%></td>
         <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(5)%></td>
          <td class="<%=style%> "style="text-align: left;"> <%=rs7.getString(6)%></td>
           <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(1)%></td>
            <td class="<%=style%> "style="text-align: left;"> <%=rs8.getString(2)%></td>
            
               <td class="<%=style%> "style="text-align: right;"> <%=rs8.getString(3)%></td>
          
  
<%} %>
  
  	</tr>
  	
<%

	   }
	   rs7.close();
	   stmt7.close();
}%>
<tr>
	
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