
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>

<form>
<%

String crcode=(String)session.getAttribute("crcode");
String drcode=(String)session.getAttribute("drcode");
String srcode=(String)session.getAttribute("srcode");
String crName=(String)session.getAttribute("crName");
String drName=(String)session.getAttribute("drName");
String srName=(String)session.getAttribute("srName");

String FDate=(String)session.getAttribute("FDate");
String access=(String)session.getAttribute("access");
System.out.println("access----"+access+FDate);
String TDate=(String)session.getAttribute("TDate");
String SubStrDate="";
String UserId="";

%>

<% 

/* try{
	SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
	SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MM-yy");
	java.util.Date date = sdfSource.parse(FDate);
	fromdate = sdfDestination.format(date);
	crdate=fromdate.replace(fromdate.substring(7,11),fromdate.substring(9,11));
// 	System.out.println(crdate);

}
catch(Exception pe)
{ 
  System.out.println("Exception : " + pe);
} */



/* try{
	SimpleDateFormat sdfDestination = new SimpleDateFormat("dd/mm/yyyy");
	SimpleDateFormat sdfSource = new SimpleDateFormat("dd-MM-yy");
	java.util.Date date = sdfSource.parse(TDate);
	todate = sdfDestination.format(date);
	drdate=todate.replace(todate.substring(7,11),todate.substring(9,11));
	//System.out.println(drdate);
}
catch(ParseException pe)
{ 
  System.out.println("Parse Exception : " + pe);
} */
//System.out.println(TDate);
String qry="";
String qry1="";
int count=1;
String div="";
int styleCount=0;
String style="";
if(access.equals("useraccess"))
{
	
%>

<table border = 1 cellspacing = 0 cellpadding = 0 width="600px"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align="right" >
	<tr>
	<td class=btext>From Date:&nbsp;&nbsp;<%=FDate%> To Date:&nbsp;&nbsp;<%=TDate%> </td>
	</tr>
	<tr align="right">
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back |&nbsp; </td>
	<td   class="bwborder"><a href="./rws_report.audit_user_xls.jsp">Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" > User Audit - Report</td>
	</tr>
	</table>
	  <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="600px" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
     <tr>
     <td class=btext  nowrap align=center colspan=1>S No.</td>
     <td class=btext  nowrap align=center colspan=1>Circle</td>
  	 <td class=btext  nowrap align=center colspan=1>Division</td>
     <td class=btext  nowrap align=center colspan=1>SubDivision</td>
	 
     <%
try
{
	Statement statement=null;
	 ResultSet resultSet=null;
   
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   String ss=null;
    
   if(crcode!=null && drcode.equals("00"))
   {
	qry="select distinct b.user_id,a.office_code,to_char(b.access_date,'dd/mm/yyyy'),count(b.access_date) from rws_password_tbl a ,rws_log_tbl b where a.user_id=b.user_id and substr(office_code,2,2)='"+crcode+"' and b.access_date BETWEEN to_date('"+FDate+"','dd/mm/yyyy') and to_date('"+TDate+"','dd/mm/yyyy') and substr(b.user_id,5,2) not in('AO','EE','DR') and substr(b.user_id,1,1)='1' group by b.user_id,a.office_code,to_char(b.access_date,'dd/mm/yyyy') order by b.user_id,to_char(b.access_date,'dd/mm/yyyy') ASC ";
	%>
	<!-- <td class=btext  nowrap align=center colspan=1>Division</td> -->
   <%	 
   }
   else if(crcode!=null && drcode!="00" && srcode.equals("00"))
	{%>
	<!-- <td class=btext  nowrap align=center colspan=1>Division</td>
	<td class=btext  nowrap align=center colspan=1>SubDivision</td> -->
   <% qry="select distinct b.user_id,a.office_code,to_char(b.access_date,'dd/mm/yyyy'), count(b.access_date)  from rws_password_tbl a ,rws_log_tbl b where a.user_id=b.user_id and substr(office_code,2,2)='"+crcode+"' and substr(office_code,4,1)='"+drcode+"' and b.access_date BETWEEN to_date('"+FDate+"','dd/mm/yyyy') and to_date('"+TDate+"','dd/mm/yyyy') and substr(b.user_id,5,2) not in('AO','EE','DR') and substr(b.user_id,1,1)='1' group by b.user_id,a.office_code,to_char(b.access_date,'dd/mm/yyyy') order by b.user_id,to_char(b.access_date,'dd/mm/yyyy') ASC";
	}
    else if(crcode!=null && drcode!="00" && srcode!="00")
     {%>
    	<!-- <td class=btext  nowrap align=center colspan=1>Division</td>
    	<td class=btext  nowrap align=center colspan=1>SubDivision</td> -->
    	
    <%  qry="select distinct b.user_id,a.office_code,to_char(b.access_date,'dd/mm/yyyy'), count(b.access_date)  from rws_password_tbl a ,rws_log_tbl b where a.user_id=b.user_id and substr(office_code,2,2)='"+crcode+"' and substr(office_code,4,1)='"+drcode+"' and substr(office_code,5,2)='"+srcode+"' and b.access_date BETWEEN to_date('"+FDate+"','dd/mm/yyyy') and to_date('"+TDate+"','dd/mm/yyyy') and substr(b.user_id,5,2) not in('AO','EE','DR') and substr(b.user_id,1,1)='1' group by b.user_id,a.office_code,to_char(b.access_date,'dd/mm/yyyy') order by b.user_id,to_char(b.access_date,'dd/mm/yyyy') ASC ";
     }
   %>
    		
    	 <td class=btext  nowrap align=center colspan=1>UserId</td>
      <td class=btext  nowrap align=center colspan=1>Logged Date</td>
      <td class=btext nowrap align=center colspan=1>Logged Count</td>
      </tr>
      
      <tr>	
    		
    		<% 
   
    		
    System.out.println(qry);
    rs8=stmt8.executeQuery(qry);
  
    System.out.println("qry"+qry);
   
   if(rs8.next())
   {
   rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
	   
   			  	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 
	 styleCount++;
	 String str=rs8.getString(3);
	 SubStrDate=str.substring(0,10);
	 String user=(String) rs8.getString(1);
	 String d=user.substring(3,4);
	 String sd=user.substring(4,6);
	 %>
	 
	 <% /* if(crcode!=null && drcode.equals("00"))
   { */
		 String dname="";
		 String divisionquery="select DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME from rws_division_office_tbl where CIRCLE_OFFICE_CODE='"+crcode+"' and DIVISION_OFFICE_CODE='"+d+"'";
		 statement=conn.createStatement();
		 resultSet=statement.executeQuery(divisionquery);
		 if(resultSet.next()){
			 dname=resultSet.getString(2);
		 }
		 else{
			 dname="--" ;
		 }
		 statement.close();
		 resultSet.close();
		 
		 String sname="";
		 String subdivisionquery="select SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME from rws_subdivision_office_tbl where CIRCLE_OFFICE_CODE='"+crcode+"' and DIVISION_OFFICE_CODE='"+d+"' and SUBDIVISION_OFFICE_CODE='"+sd+"' ";
		 statement=conn.createStatement();
		 resultSet=statement.executeQuery(subdivisionquery);
		 if(resultSet.next()){
			 sname=resultSet.getString(2);
		 }
		 else{
			 sname="--" ;
		 }
		 statement.close();
		 resultSet.close(); 
   %>
	<tr>
	<td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=crName%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=dname%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=sname%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=user%> 
   <td  class="<%=style%> "style="text-align: left;"> <%=SubStrDate%></td>  
   <td  class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_display_useraudit_report.jsp?laggdate=<%=SubStrDate%>&UserId=<%=user%>')"><%=rs8.getString(4)%></a></td> 
   </tr>
   	<%/* }  	
     else if(crcode!=null && drcode!="00" && srcode.equals("00"))
	{
    	 String sname="";
		 String divisionquery="select SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME from rws_subdivision_office_tbl where CIRCLE_OFFICE_CODE='"+crcode+"' and DIVISION_OFFICE_CODE='"+d+"' and SUBDIVISION_OFFICE_CODE='"+sd+"' ";
		 Statement statement=conn.createStatement();
		 ResultSet resultSet=statement.executeQuery(divisionquery);
		 if(resultSet.next()){
			 sname=resultSet.getString(2);
		 }
		 else{
			 sname="--" ;
		 }
		 statement.close();
		 resultSet.close(); */
	%>
	<%-- <tr>
	<td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=crName%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=drName%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=sname%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=user%> 
   <td  class="<%=style%> "style="text-align: left;"> <%=SubStrDate%></td>  
   <td  class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_display_useraudit_report.jsp?laggdate=<%=SubStrDate%>&UserId=<%=user%>')"><%=rs8.getString(4)%></a></td> 
   </tr> --%>
	<%/* }
     else if(crcode!=null && drcode!="00" && srcode!="00")
     { */%>
     <%-- <tr>
	<td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=crName%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=drName%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=srName%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=user%> 
   <td  class="<%=style%> "style="text-align: left;"> <%=SubStrDate%></td>  
   <td  class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_display_useraudit_report.jsp?laggdate=<%=SubStrDate%>&UserId=<%=user%>')"><%=rs8.getString(4)%></a></td> 
   </tr> --%>
	 
	 <%//}%>
	
<%
   }
   }
   else{
	   %>
	   <tr >
	   <td nowrap align=center colspan=7>No Record Found</td>
	   </tr>
 
 <%   }
		}catch(Exception e)
		{
		e.printStackTrace();
		}

}
else {
	%>
	
	<table border = 1 cellspacing = 0 cellpadding = 0 width="600px"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align="center" >
	<tr>
	<td class=btext>From Date:&nbsp;&nbsp;<%=FDate%> To Date:&nbsp;&nbsp;<%=TDate%> </td>
	</tr>
	<tr align="right">
	<td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td class="bwborder"><a href="javascript:onclick=history.go(-1)">Back |&nbsp; </td>
	<td   class="bwborder"><a href="./rws_report.audit_user_xls.jsp">Excel</a></td>
	</tr>  
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" >User Not Accessed WatertSoft</td>
	</tr>
	</table>
	 <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="600px" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
     <tr>
     <td class=btext  nowrap align=center colspan=1>S No.</td>
    <td class=btext  nowrap align=center colspan=1>Circle</td>
	<td class=btext  nowrap align=center colspan=1>Division</td>
	<td class=btext  nowrap align=center colspan=1>SubDivision</td>
<% 
try{
	 Statement statement=null;
	 ResultSet resultSet=null;
Statement stmt2=null;
ResultSet rs2=null;
int sno=1;
stmt2=conn.createStatement();
if(crcode!=null && drcode.equals("00"))
{%>
<!-- <td class=btext  nowrap align=center colspan=1>Division</td> -->
<%
	qry1="select distinct user_id from rws_password_tbl where substr(office_code,2,2)='"+crcode+"' and user_id not in (select b.user_id from rws_password_tbl a ,rws_log_tbl b where a.user_id=b.user_id and substr(office_code,2,2)='"+crcode+"' and b.access_date BETWEEN to_date('"+FDate+"','dd/mm/yyyy') and to_date('"+TDate+"','dd/mm/yyyy')  group by b.user_id) and substr(user_id,5,2) not in('AO','EE','DR') and substr(user_id,1,1)='1' order by user_id	";
}
else if(crcode!=null && drcode!="00" && srcode.equals("00")){
	%>
	<!-- <td class=btext  nowrap align=center colspan=1>Division</td>
	<td class=btext  nowrap align=center colspan=1>SubDivision</td> -->
	<%
qry1="select  distinct user_id from rws_password_tbl where substr(office_code,2,2)='"+crcode+"' and user_id not in (select  a.user_id  from rws_password_tbl a ,rws_log_tbl b where a.user_id=b.user_id and substr(office_code,2,2)='"+crcode+"' and substr(office_code,4,1)='"+drcode+"'  and b.access_date BETWEEN to_date('"+FDate+"','dd/mm/yyyy') and to_date('"+TDate+"','dd/mm/yyyy') group by a.user_id,a.office_code,to_char(b.access_date,'dd/mm/yyyy')) and substr(user_id,5,2) not in('AO','EE','DR') and substr(user_id,1,1)='1' order by user_id ";
}
else if(crcode!=null && drcode!="00" && srcode!="00"){
	
qry1="select  distinct user_id from rws_password_tbl where substr(office_code,2,2)='"+crcode+"' and user_id not in (select  a.user_id  from rws_password_tbl a ,rws_log_tbl b where a.user_id=b.user_id and substr(office_code,2,2)='"+crcode+"' and substr(office_code,4,1)='"+drcode+"' and substr(office_code,5,2)='"+srcode+"' and b.access_date BETWEEN to_date('"+FDate+"','dd/mm/yyyy') and to_date('"+TDate+"','dd/mm/yyyy') group by a.user_id,a.office_code,to_char(b.access_date,'dd/mm/yyyy'))and substr(user_id,5,2) not in('AO','EE','DR') and substr(user_id,1,1)='1' order by user_id )";
%>
<!-- <td class=btext  nowrap align=center colspan=1>Division</td>
<td class=btext  nowrap align=center colspan=1>SubDivision</td> -->

<% 
}
%>

<td class=btext  nowrap align=center colspan=1>UserId</td>

</tr>

<tr>	
	
	<% 
System.out.println("qryyyy"+qry1);
rs2=stmt2.executeQuery(qry1);
if(rs2.next())
{
	rs2=stmt2.executeQuery(qry1);
while(rs2.next())
{
	 if(styleCount%2==0){
	 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	 String n=rs2.getString(1);
	 String d=n.substring(3,4);
	 String sd=n.substring(4,6);
%>


	<%/*  if(crcode!=null && drcode.equals("00"))
   { */
		 String dname="";
		 String divisionquery="select DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME from rws_division_office_tbl where CIRCLE_OFFICE_CODE='"+crcode+"' and DIVISION_OFFICE_CODE='"+d+"'";
		 statement=conn.createStatement();
		 resultSet=statement.executeQuery(divisionquery);
		 if(resultSet.next()){
			 dname=resultSet.getString(2);
		 }
		 else{
			 dname="--" ;
		 }
		 statement.close();
		 resultSet.close();
		 
		 String sname="";
		 String subdivisionquery="select SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME from rws_subdivision_office_tbl where CIRCLE_OFFICE_CODE='"+crcode+"' and DIVISION_OFFICE_CODE='"+d+"' and SUBDIVISION_OFFICE_CODE='"+sd+"' ";
		 statement=conn.createStatement();
		 resultSet=statement.executeQuery(subdivisionquery);
		 if(resultSet.next()){
			 sname=resultSet.getString(2);
		 }
		 else{
			 sname="--" ;
		 }
		 statement.close();
		 resultSet.close();
   %>
   <%-- <tr>
	<td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=crName%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=dname%></td>
	<td  class="<%=style%> "style="text-align: right;"> <%=rs2.getString(1)%></td>
	</tr> --%>
	
   	<%/* }  	
     else if(crcode!=null && drcode!="00" && srcode.equals("00"))
	{
    	 String sname="";
		 String divisionquery="select SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME from rws_subdivision_office_tbl where CIRCLE_OFFICE_CODE='"+crcode+"' and DIVISION_OFFICE_CODE='"+d+"' and SUBDIVISION_OFFICE_CODE='"+sd+"' ";
		 Statement statement=conn.createStatement();
		 ResultSet resultSet=statement.executeQuery(divisionquery);
		 if(resultSet.next()){
			 sname=resultSet.getString(2);
		 }
		 else{
			 sname="--" ;
		 }
		 statement.close();
		 resultSet.close(); */
	%>
	<%-- <tr>
	  
	<td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=crName%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=drName%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=sname%></td>
	<td  class="<%=style%> "style="text-align: right;"> <%=rs2.getString(1)%></td>
	</tr> --%>
	
	<%/* }
     else if(crcode!=null && drcode!="00" && srcode!="00")
     { */%>
     <tr>
	<td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=crName%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=dname%></td>
	<td  class="<%=style%> "style="text-align: left;"> <%=sname%></td>
   <td  class="<%=style%> "style="text-align: right;"> <%=rs2.getString(1)%></td> 
   </tr>
	 
	 <%//}%>
	
<%
   }
   }
   else{
	   %>
	   <tr >
	   <td nowrap align=center colspan=7>No Record Found</td>
	   </tr>
 
 <%   }

} 

catch(Exception ex){
ex.printStackTrace();
}

}
%>
  </table>
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>