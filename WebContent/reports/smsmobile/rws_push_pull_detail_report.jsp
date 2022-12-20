<%@ include file="/commons/rws_header1.jsp"%>

<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

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
 


    Statement stmt1=null;
int slno=0;
    String qry="", str="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
    String dcode=request.getParameter("dcode");
   
    String dname=request.getParameter("dname");
   
    String fromdate=request.getParameter("fromdate");
   
    String todate=request.getParameter("todate");
   
    String status=request.getParameter("status");
   
	String mcode=request.getParameter("mcode");
	String habcode=request.getParameter("habcode");
	
	String mname=request.getParameter("mname");
	
	
	
    

   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center">
	
		
		
		</tr></table>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
	<a href="#" onClick="window.close();">Close</a>
	 
	</tr>  
	
	
	</table>
	</caption>
	
	
		
   	
   <table width="75%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <%
try
{
if(status.equals("rcPULL"))
{
%>
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="17"><b>Residual Chlorine PULL Details </b></td>
		
		</tr>

	 <tr>
	
	<td class=gridhdbg>Sl.No</td>
    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
    <td class=gridhdbg>Asset Code</td>
    
    <td class=gridhdbg>Local Person Name</td>
    <td class=gridhdbg>Location</td>
    <td class=gridhdbg>Message Send Date</td>
    <td class=gridhdbg>RC PPM Value</td>
    <td class=gridhdbg>Action Taken</td>
    <td class=gridhdbg>Date Of Action</td>
    <td class=gridhdbg>Remarks</td>
    
   
   
	
       </tr>
       
       	<%
     
 
		
       	str="select panch_name,nvl(b.asset_code,'-'),DATA_COLLECTOR_NAME,c.LOCATION,PPM_VALUE,nvl(to_char(ACTION_DATE,'dd/mm/yyyy'),'-'),nvl(to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),'-'),nvl(b.REMARKS,'-') ,c.habitation_code,to_char(TEST_DATE,'dd/mm/yyyy')  from rws_panchayat_raj_tbl a,RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE a.panch_code=c.habitation_code and b.sms_mobile=c.MOBILE  and c.habitation_code='"+habcode+"' and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  order by to_char(TEST_DATE,'dd/mm/yyyy') ";   
		 
	   
	   stmt1=conn.createStatement();
	
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
			 
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
		   %>
              
              <tr>
              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(9)%>/<br/><%=rs.getString(1)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
			 
			  
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%></td>
			   <td class="<%=style%> "style="text-align: left;"><%=rs.getString(10)%></td>
			  <td class="<%=style%> "style="text-align: right;"><%=rs.getDouble(5)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(6)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(7)%></td>
			  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(8)%></td>
			 
				
				</tr>
              
              
              
              
		    <%
	   }
		 ps.close();
		 rs.close();
		}
else if(status.equals("dfPULL")){
	%>
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>Defunct Scheme PULL Details </b></td>
			
			</tr>

		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
	    <td class=gridhdbg>Asset Code</td>
	    
	    <td class=gridhdbg>Local Person Name</td>
	    <td class=gridhdbg>Location</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>Status</td>
	    <td class=gridhdbg>Action Taken</td>
	    <td class=gridhdbg>Date Of Action</td>
	    <td class=gridhdbg>Remarks</td>
	    
	   
	   
		
	       </tr>
	       
	       	<%
	     
	 
			
	       	str="select panch_name,nvl(b.asset_code,'-'),DATA_COLLECTOR_NAME,c.LOCATION,decode(STATUS,'Y','Yes','N','No'),nvl(to_char(ACTION_DATE,'dd/mm/yyyy'),'-'),nvl(to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),'-'),nvl(b.REMARKS,'-') ,c.habitation_code,to_char(SMS_DATE,'dd/mm/yyyy')  from rws_panchayat_raj_tbl a,RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE a.panch_code=c.habitation_code and b.sms_mobile=c.MOBILE  and c.habitation_code='"+habcode+"' and SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  order by to_char(SMS_DATE,'dd/mm/yyyy') ";   
	      // 	System.out.println("str---"+str);
		   
		   stmt1=conn.createStatement();
		
		    ps=conn.prepareStatement(str);
			 rs=ps.executeQuery();
			 while(rs.next())
		   {
				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(9)%>/<br/><%=rs.getString(1)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
				 
				  
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%></td>
				   <td class="<%=style%> "style="text-align: left;"><%=rs.getString(10)%></td>
				  <td class="<%=style%> "style="text-align: right;"><%=rs.getString(5)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(6)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(7)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(8)%></td>
				 
					
					</tr>
	              
	              
	              
	              
			    <%
		   }
			}
else if(status.equals("drPULL")){
	%>
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>Drought Tanker PULL Details </b></td>
			
			</tr>

		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
	    <td class=gridhdbg>Tanker Location</td>
	    
	    <td class=gridhdbg>Local Person Name</td>
	    <td class=gridhdbg>Location</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>Tanker Status</td>
	    <td class=gridhdbg>Action Taken</td>
	    <td class=gridhdbg>Date Of Action</td>
	    <td class=gridhdbg>Remarks</td>
	    
	   
	   
		
	       </tr>
	       
	       	<%
	     
	 
			
	       	str="select panch_name,nvl(b.LOCATION,'-'),DATA_COLLECTOR_NAME,c.LOCATION,decode(TANKER_STATUS,'Y','Yes','N','No'),nvl(to_char(TANKER_SUPPLY_DATE,'dd/mm/yyyy'),'-'),nvl(to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),'-'),nvl(b.REMARKS,'-') ,c.habitation_code,to_char(SEND_DATE,'dd/mm/yyyy')  from rws_panchayat_raj_tbl a,RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE a.panch_code=c.habitation_code and b.sms_mobile=c.MOBILE  and c.habitation_code='"+habcode+"' and SEND_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  order by to_char(SEND_DATE,'dd/mm/yyyy') ";   
	       //	System.out.println("str---"+str);
		   
		   stmt1=conn.createStatement();
		
		    ps=conn.prepareStatement(str);
			 rs=ps.executeQuery();
			 while(rs.next())
		   {
				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(9)%>/<br/><%=rs.getString(1)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
				 
				  
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%></td>
				   <td class="<%=style%> "style="text-align: left;"><%=rs.getString(10)%></td>
				  <td class="<%=style%> "style="text-align: right;"><%=rs.getString(5)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(6)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(7)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(8)%></td>
				 
					
					</tr>
	              
	              
	              
	              
			    <%
		   }
			}
else if(status.equals("ohPULL")){
	%>
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>OHSR PULL Details </b></td>
			
			</tr>

		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
	    <td class=gridhdbg>Asset Code</td>
	    
	    <td class=gridhdbg>Local Person Name</td>
	    <td class=gridhdbg>Location</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>OHSR Clean Status</td>
	    <td class=gridhdbg>Action Taken</td>
	    <td class=gridhdbg>Date Of Action</td>
	    <td class=gridhdbg>Remarks</td>
	    
	   
	   
		
	       </tr>
	       
	       	<%
	     
	 
			
	       	str="select panch_name,nvl(b.asset_code,'-'),DATA_COLLECTOR_NAME,c.LOCATION,decode(GLSR_OHSR_CLEAN_STATUS,'Y','Yes','N','No'),nvl(to_char(ACTION_DATE,'dd/mm/yyyy'),'-'),nvl(to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),'-'),nvl(b.REMARKS,'-') ,c.habitation_code,to_char(TEST_DATE,'dd/mm/yyyy')  from rws_panchayat_raj_tbl a,rws_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE a.panch_code=c.habitation_code and b.sms_mobile=c.MOBILE AND GLSR_OHSR='O'  and c.habitation_code='"+habcode+"' and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  order by to_char(TEST_DATE,'dd/mm/yyyy') ";   
	       //	System.out.println("str---"+str);
		   
		   stmt1=conn.createStatement();
		
		    ps=conn.prepareStatement(str);
			 rs=ps.executeQuery();
			 while(rs.next())
		   {
				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(9)%>/<br/><%=rs.getString(1)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
				 
				  
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%></td>
				   <td class="<%=style%> "style="text-align: left;"><%=rs.getString(10)%></td>
				  <td class="<%=style%> "style="text-align: right;"><%=rs.getString(5)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(6)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(7)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(8)%></td>
				 
					
					</tr>
	              
	              
	              
	              
			    <%
		   }
			}
else if(status.equals("glPULL")){
	%>
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>GLSR PULL Details </b></td>
			
			</tr>

		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
	    <td class=gridhdbg>Asset Code</td>
	    
	    <td class=gridhdbg>Local Person Name</td>
	    <td class=gridhdbg>Location</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>GLSR Clean Status</td>
	    <td class=gridhdbg>Action Taken</td>
	    <td class=gridhdbg>Date Of Action</td>
	    <td class=gridhdbg>Remarks</td>
	    
	   
	   
		
	       </tr>
	       
	       	<%
	     
	 
			
	       	str="select panch_name,nvl(b.asset_code,'-'),DATA_COLLECTOR_NAME,c.LOCATION,decode(GLSR_OHSR_CLEAN_STATUS,'Y','Yes','N','No'),nvl(to_char(ACTION_DATE,'dd/mm/yyyy'),'-'),nvl(to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),'-'),nvl(b.REMARKS,'-') ,c.habitation_code,to_char(TEST_DATE,'dd/mm/yyyy')  from rws_panchayat_raj_tbl a,rws_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE a.panch_code=c.habitation_code and b.sms_mobile=c.MOBILE AND GLSR_OHSR='G'  and c.habitation_code='"+habcode+"' and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  order by to_char(TEST_DATE,'dd/mm/yyyy') ";   
	       //	System.out.println("str---"+str);
		   
		   stmt1=conn.createStatement();
		
		    ps=conn.prepareStatement(str);
			 rs=ps.executeQuery();
			 while(rs.next())
		   {
				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(9)%>/<br/><%=rs.getString(1)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
				 
				  
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%></td>
				   <td class="<%=style%> "style="text-align: left;"><%=rs.getString(10)%></td>
				  <td class="<%=style%> "style="text-align: right;"><%=rs.getString(5)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(6)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(7)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(8)%></td>
				 
					
					</tr>
	              
	              
	              
	              
			    <%
		   }
			}
else if(status.equals("rcPUSH")){
	%>
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>Residual Chlorine PUSH Details </b></td>
			
			</tr>

		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
	    <td class=gridhdbg>Mobile</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>SMS Description</td>
	   
	    
	   
	   
		
	       </tr>
	       
	       	<%
	     
	 
			
	       	str="select MOBILE,nvl(to_char(SMS_DATE,'dd/mm/yyyy'),'-'),SMS_DESC,HABITATION_CODE,PANCH_NAME from rws_panchayat_raj_tbl a,RWS_SMS_IN_OUT_STATUS_TBL b   WHERE PANCH_CODE=habitation_code and  habitation_code='"+habcode+"'  and SMS_MODULE_AREA='RC'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";   
	       //	System.out.println("str---"+str);
		   
		   stmt1=conn.createStatement();
		
		    ps=conn.prepareStatement(str);
			 rs=ps.executeQuery();
			 while(rs.next())
		   {
				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%>/<br/><%=rs.getString(5)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(1)%></td>
				 <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				 
					
					</tr>
	              
	              
	              
	              
			    <%
		   }
			}
else if(status.equals("dfPUSH")){
	%>
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>Defunct Scheme PUSH Details </b></td>
			
			</tr>

		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
	    <td class=gridhdbg>Mobile</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>SMS Description</td>
	   
	    
	   
	   
		
	       </tr>
	       
	       	<%
	     
	 
			
	       	str="select MOBILE,nvl(to_char(SMS_DATE,'dd/mm/yyyy'),'-'),SMS_DESC,HABITATION_CODE,PANCH_NAME from rws_panchayat_raj_tbl a,RWS_SMS_IN_OUT_STATUS_TBL b   WHERE PANCH_CODE=habitation_code and  habitation_code='"+habcode+"'  and SMS_MODULE_AREA='DF'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";   
	       //	System.out.println("str---"+str);
		   
		   stmt1=conn.createStatement();
		
		    ps=conn.prepareStatement(str);
			 rs=ps.executeQuery();
			 while(rs.next())
		   {
				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%>/<br/><%=rs.getString(5)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(1)%></td>
				 <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				 
					
					</tr>
	              
	              
	              
	              
			    <%
		   }
			}
else if(status.equals("drPUSH")){
	%>
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>Tanker PUSH Details </b></td>
			
			</tr>

		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
	    <td class=gridhdbg>Mobile</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>SMS Description</td>
	   
	    
	   
	   
		
	       </tr>
	       
	       	<%
	     
	 
			
	       	str="select MOBILE,nvl(to_char(SMS_DATE,'dd/mm/yyyy'),'-'),SMS_DESC,HABITATION_CODE,PANCH_NAME from rws_panchayat_raj_tbl a,RWS_SMS_IN_OUT_STATUS_TBL b   WHERE PANCH_CODE=habitation_code and  habitation_code='"+habcode+"'  and SMS_MODULE_AREA='DR'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";   
	       //	System.out.println("str---"+str);
		   
		   stmt1=conn.createStatement();
		
		    ps=conn.prepareStatement(str);
			 rs=ps.executeQuery();
			 while(rs.next())
		   {
				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%>/<br/><%=rs.getString(5)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(1)%></td>
				 <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				 
					
					</tr>
	              
	              
	              
	              
			    <%
		   }
			}
else if(status.equals("ohPUSH")){
	%>
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>OHSR PUSH Details </b></td>
			
			</tr>

		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
	    <td class=gridhdbg>Mobile</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>SMS Description</td>
	   
	    
	   
	   
		
	       </tr>
	       
	       	<%
	     
	 
			
	       	str="select MOBILE,nvl(to_char(SMS_DATE,'dd/mm/yyyy'),'-'),SMS_DESC,HABITATION_CODE,PANCH_NAME from rws_panchayat_raj_tbl a,RWS_SMS_IN_OUT_STATUS_TBL b   WHERE PANCH_CODE=habitation_code and  habitation_code='"+habcode+"'  and SMS_MODULE_AREA='OH'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";   
	       //	System.out.println("str---"+str);
		   
		   stmt1=conn.createStatement();
		
		    ps=conn.prepareStatement(str);
			 rs=ps.executeQuery();
			 while(rs.next())
		   {
				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%>/<br/><%=rs.getString(5)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(1)%></td>
				 <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				 
					
					</tr>
	              
	              
	              
	              
			    <%
		   }
			}
else if(status.equals("glPUSH")){
	%>
	   <tr align=center  align=center>
			<td class="gridhdbg" colspan="17"><b>GLSR PUSH Details </b></td>
			
			</tr>

		 <tr>
		
		<td class=gridhdbg>Sl.No</td>
	    <td class=gridhdbg>Habitation Code/<br/>Habitation Name</td>
	    <td class=gridhdbg>Mobile</td>
	    <td class=gridhdbg>Message Send Date</td>
	    <td class=gridhdbg>SMS Description</td>
	   
	    
	   
	   
		
	       </tr>
	       
	       	<%
	     
	 
			
	       	str="select MOBILE,nvl(to_char(SMS_DATE,'dd/mm/yyyy'),'-'),SMS_DESC,HABITATION_CODE,PANCH_NAME from rws_panchayat_raj_tbl a,RWS_SMS_IN_OUT_STATUS_TBL b   WHERE PANCH_CODE=habitation_code and  habitation_code='"+habcode+"'  and SMS_MODULE_AREA='GL'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";   
	       //	System.out.println("str---"+str);
		   
		   stmt1=conn.createStatement();
		
		    ps=conn.prepareStatement(str);
			 rs=ps.executeQuery();
			 while(rs.next())
		   {
				 
				 if(styleCount%2==0){
					 style="gridbg1";
				 }else{
					 style="gridbg2";
				 }
				 styleCount++;
			   %>
	              
	              <tr>
	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
	              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(4)%>/<br/><%=rs.getString(5)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(1)%></td>
				 <td class="<%=style%> "style="text-align: left;"><%=rs.getString(2)%></td>
				  <td class="<%=style%> "style="text-align: left;"><%=rs.getString(3)%></td>
				 
					
					</tr>
	              
	              
	              
	              
			    <%
		   }
			}

		%> 
		<%  

	   } catch(Exception e)
	   {
	   e.printStackTrace();
	   }
	   finally{
		  
	   conn.close();
	   }
	   %>
	
    
</table>
	</table>	
    
  

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>