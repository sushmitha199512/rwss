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
StringBuffer divname=new StringBuffer();
divname.append(request.getParameter("divname"));
//System.out.println("divname"+divname);
StringBuffer dname=new StringBuffer(request.getParameter("dname"));


//StringBuffer subdivname=new StringBuffer(request.getParameter("subdivname"));
//StringBuffer yr=new StringBuffer(String.valueOf(session.getAttribute("yr")));

//String yr1=request.getParameter("yr1"); 
//StringBuffer yr3=new StringBuffer(String.valueOf(session.getAttribute("yr3")));
////System.out.println("Y3*******"+yr3);
//String subdivisionofficecode=request.getParameter("subdivisionofficecode");

StringBuffer dcode=new StringBuffer(request.getParameter("dcode"));
//System.out.println("dcode*********"+dcode);
   if(dcode.toString()!=null){
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
	StringBuffer style=new StringBuffer();
	StringBuffer query=new StringBuffer();
	try
      {
		

	//	style.delete(0,style.length());

		query.delete(0,query.length());

//before querry
query.append("select distinct dname,mname,pname,vname,panch_name,panch_code from rws_wq_test_results_tbl b,rws_complete_hab_view c where  substr(b.source_code,1,16)=c.panch_code  and C.COVERAGE_STATUS<>'UI' and  to_date(prepared_on)>='1-JAN-2012' and  to_date(prepared_on)<'31-DEC-2014' and dcode='"+dcode.toString()+"'  order by dname");
//select substr(c.panch_code,1,2),count(distinct c.panch_code) from rws_water_sample_collect_tbl a,rws_wq_test_results_tbl b,rws_complete_hab_view c where c.panch_code=a.hab_code and a.source_code=b.source_code and a.test_id=b.test_id and C.COVERAGE_STATUS<>'UI' and  to_date(b.prepared_on)>='1-JAN-2012' and  to_date(b.prepared_on)<='31-DEC-2014'  group by  substr(c.panch_code,1,2) order by 1
//"select substr(c.panch_code,1,2),count(distinct c.panch_code) from rws_wq_test_results_tbl b,rws_complete_hab_view c where  substr(b.source_code,1,16)=c.panch_code  and C.COVERAGE_STATUS<>'UI' and  to_date(prepared_on)>='1-APR-"+yr+"' and  to_date(prepared_on)<'31-MAR-"+yr1+"'  group by  substr(c.panch_code,1,2) order by 1";

stmt3=conn.createStatement();
System.out.println("queryssss*******&&&&&&&&&&&*"+query);
//String sh1="",sh2="",sh3="",sh4="",sh5="";
rs3=stmt3.executeQuery(query.toString());

//String scode="",labcode="",testid="",condemn="",prepared="";
while(rs3.next()){
	
	
		
	style.delete(0,style.length());
	
	 if(styleCount%2==0){
		 style.append("gridbg1");
	 }else{
		 style.append("gridbg2");
	 }
	 styleCount++;
	
	
	

%>
<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style.toString() %>" style="text-align: left;" align="right"><%=rs3.getString(1)%></td>
<td class="<%=style.toString() %>" style="text-align: left;" align="right"><%=rs3.getString(2)%></td>
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
     finally{
    	 
    	 divname=null;
    	 dname=null;
    	 //yr=null;
    	// yr3=null;
    	 dcode=null;
    	 style=null;
    	 query=null;
     }
	%>
	
</table>
</form>

