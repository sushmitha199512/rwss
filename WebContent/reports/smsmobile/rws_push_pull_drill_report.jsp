<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>

<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">

function viewWorks(URL)
{
	//alert("URL"+URL);
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

<form method="post">
<%

String mode1=request.getParameter("mode1");
//System.out.println("mode1"+mode1);
String dcode=request.getParameter("dcode");
//System.out.println("mode1"+mode1);
String dname=request.getParameter("dname");
//System.out.println("dname"+dname);
String fromdate=request.getParameter("fromdate");
//System.out.println("fromdate"+fromdate);
String todate=request.getParameter("todate");
//System.out.println("todate"+todate);



    Statement stmt1=null,stmt2=null;
ResultSet rst=null,rst2=null;
int slno=0;
    String qry="", str="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
   
	
    

   %>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
	
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  </td>

	 
	</tr>  
	
	
	</table>
	</caption>
	
	
		
   	
   <table width="75%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr   align=center>
   
		<td class="gridhdbg" colspan="17"><b>Residual Chlorine Action Taken District:<font color="red"><%=dname%></font></b></td>
		
		
		</tr>
  
       	<%
       try
		{
    		if(mode1.equals("mandal")){
    		
    		%>
    			 <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	<td class=gridhdbg rowspan=2>Mandal</td>
	<td class=gridhdbg colspan=5>PULL</td>
	<td class=gridhdbg colspan=5>PUSH</td>
	
   </tr>
   <tr>
   
    <td class=gridhdbg rowspan=1>RC</td>
    <td class=gridhdbg rowspan=1>DF</td>
    <td class=gridhdbg rowspan=1>DR</td>
    <td class=gridhdbg rowspan=1>OH</td>
    <td class=gridhdbg rowspan=1>GL</td>
    
    
    <td class=gridhdbg rowspan=1>RC</td>
    <td class=gridhdbg rowspan=1>DF</td>
    <td class=gridhdbg rowspan=1>DR</td>
    <td class=gridhdbg rowspan=1>OH</td>
    <td class=gridhdbg rowspan=1>GL</td>
   
   
   
	
       </tr>
    		<%
    		
    		
    		
    		int rcPULL=0,dfPULL=0,drPULL=0,ohPULL=0,glPULL=0,rcPUSH=0,dfPUSH=0,drPUSH=0,ohPUSH=0,glPUSH=0;
    	   stmt1=conn.createStatement();
    		String qry1="select dcode,mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by dcode";
    		
    			
    		rst = stmt1.executeQuery(qry1); 
    			
    			
    			while(rst.next())
    			{
    				str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  ";
    				
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 rcPULL= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				
   				str="select count(*) from RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 dfPULL= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				
   				str="select count(*) from RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"'  and SEND_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 drPULL= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				 
   				 str="select count(*) from rws_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' AND GLSR_OHSR='O' and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 ohPULL= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				 
   				 
   				 str="select count(*) from rws_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' AND GLSR_OHSR='G' and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 glPULL= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				 
   				
   				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL   WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"' and substr(habitation_code,6,2)='"+rst.getString(2)+"'  and SMS_MODULE_AREA='RC'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 rcPUSH= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				 
   				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"' and substr(habitation_code,6,2)='"+rst.getString(2)+"'  and SMS_MODULE_AREA='DF'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 dfPUSH= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				 
   				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"' and substr(habitation_code,6,2)='"+rst.getString(2)+"'  and SMS_MODULE_AREA='DR'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  ";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 drPUSH= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				
   				 
   				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"' and substr(habitation_code,6,2)='"+rst.getString(2)+"'  and SMS_MODULE_AREA='OH'  AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				// System.out.println("str"+str);
   				 if(rs.next())
   	    		   {
   					 ohPUSH= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				 
   				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"' and substr(habitation_code,6,2)='"+rst.getString(2)+"'  and SMS_MODULE_AREA='GL'  AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 //System.out.println("str"+str);	
   				 if(rs.next())
   	    		   {
   					 glPUSH= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();

   		   
   		  
   				 
   				 if(styleCount%2==0){
   					 style="gridbg1";
   				 }else{
   					 style="gridbg2";
   				 }
   				 styleCount++;
   			   %>
   	              
   	              <tr>
   	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
   	              <td class="<%=style%> "style="text-align: left;"><a href="rws_push_pull_drill_report.jsp?mode1=hab&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=rst.getString(3)%>"><%=rst.getString(3)%></td>
   				  <td class="<%=style%> "style="text-align: right;"><%=rcPULL%></td>
   				  <td class="<%=style%> "style="text-align: right;"><%=dfPULL%></td>
   				  
   				  <td class="<%=style%> "style="text-align: right;"><%=drPULL%></td>
   				  <td class="<%=style%> "style="text-align: right;"><%=ohPULL%></td>
   				  <td class="<%=style%> "style="text-align: right;"><%=glPULL%></td>
   				  
   				  <td class="<%=style%> "style="text-align: right;"><%=rcPUSH%></td>
   				  <td class="<%=style%> "style="text-align: right;"><%=dfPUSH%></td>
   				  <td class="<%=style%> "style="text-align: right;"><%=drPUSH%></td>
   				  <td class="<%=style%> "style="text-align: right;"><%=ohPUSH%></td>
   				  <td class="<%=style%> "style="text-align: right;"><%=glPUSH%></td>
   				  
   				  
   				 
   				  
   					
   					</tr>
   		
   		 
   					
   	<%
		}
    			
    		}
    		else{
    		
    			String mcode=request.getParameter("mcode");
    			String mname=request.getParameter("mname");
    		
    			
    		%>
    			
           			 <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	<td class=gridhdbg rowspan=2 nowrap="nowrap">Habitation Code/Habitation Name</td>
	<td class=gridhdbg colspan=5>PULL</td>
	<td class=gridhdbg colspan=5>PUSH</td>
	
   </tr>
   <tr>
   
    <td class=gridhdbg rowspan=1>RC</td>
    <td class=gridhdbg rowspan=1>DF</td>
    <td class=gridhdbg rowspan=1>DR</td>
    <td class=gridhdbg rowspan=1>OH</td>
    <td class=gridhdbg rowspan=1>GL</td>
    
    
    <td class=gridhdbg rowspan=1>RC</td>
    <td class=gridhdbg rowspan=1>DF</td>
    <td class=gridhdbg rowspan=1>DR</td>
    <td class=gridhdbg rowspan=1>OH</td>
    <td class=gridhdbg rowspan=1>GL</td>
   
   
   
	
       </tr>
    		<%
    		
    		
    		
    		int rcPULL=0,dfPULL=0,drPULL=0,ohPULL=0,glPULL=0,rcPUSH=0,dfPUSH=0,drPUSH=0,ohPUSH=0,glPUSH=0;
    	   stmt1=conn.createStatement();
    		String qry1="select panch_code,panch_name from rws_panchayat_raj_tbl  where substr(panch_code,1,2)='"+dcode+"'  and substr(panch_code,6,2)='"+mcode+"' order by panch_code";
    		
    			
    		rst = stmt1.executeQuery(qry1); 
    			
    			
    			while(rst.next())
    			{
    				str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile=c.MOBILE  and c.habitation_code='"+rst.getString(1)+"' and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  ";
    				
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 if(rs.next())
      	    		   {
      					 rcPULL= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				
      				str="select count(*) from RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and  c.habitation_code='"+rst.getString(1)+"' and SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 if(rs.next())
      	    		   {
      					 dfPULL= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				
      				str="select count(*) from RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and c.habitation_code='"+rst.getString(1)+"'  and SEND_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 if(rs.next())
      	    		   {
      					 drPULL= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				 
      				 str="select count(*) from rws_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and c.habitation_code='"+rst.getString(1)+"'  AND GLSR_OHSR='O' and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 if(rs.next())
      	    		   {
      					 ohPULL= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				 
      				 
      				 str="select count(*) from rws_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and c.habitation_code='"+rst.getString(1)+"' AND GLSR_OHSR='G' and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 if(rs.next())
      	    		   {
      					 glPULL= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				 
      				
      				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL   WHERE   habitation_code='"+rst.getString(1)+"'  and SMS_MODULE_AREA='RC'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 if(rs.next())
      	    		   {
      					 rcPUSH= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				 
      				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   habitation_code='"+rst.getString(1)+"'  and SMS_MODULE_AREA='DF'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 if(rs.next())
      	    		   {
      					 dfPUSH= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				 
      				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   habitation_code='"+rst.getString(1)+"'  and SMS_MODULE_AREA='DR'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  ";
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 if(rs.next())
      	    		   {
      					 drPUSH= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				
      				 
      				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   habitation_code='"+rst.getString(1)+"'  and SMS_MODULE_AREA='OH'  AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 //System.out.println("str"+str);
      				 if(rs.next())
      	    		   {
      					 ohPUSH= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				 
      				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   habitation_code='"+rst.getString(1)+"' and SMS_MODULE_AREA='GL'  AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 //System.out.println("str"+str);	
      				 if(rs.next())
      	    		   {
      					 glPUSH= rs.getInt(1);
      	    		   }
      				 stmt2.close();
      				 rs.close();

      		   
      		  
      				 
      				 if(styleCount%2==0){
      					 style="gridbg1";
      				 }else{
      					 style="gridbg2";
      				 }
      				 styleCount++;
      			   %>
      	              
      	              <tr>
      	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
      	              <td class="<%=style%> "style="text-align: left;" nowrap="nowrap"><%=rst.getString(1)%>&nbsp;/&nbsp;<%=rst.getString(2)%></td>
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=rcPULL&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=rcPULL%></a></td>
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=dfPULL&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=dfPULL%></a></td>
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=drPULL&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=drPULL%></a></td>
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=ohPULL&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=ohPULL%></a></td>
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=glPULL&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=glPULL%></a></td>
      				  
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=rcPUSH&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=rcPUSH%></a></td>
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=dfPUSH&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=dfPUSH%></a></td>
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=drPUSH&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=drPUSH%></a></td>
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=ohPUSH&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=ohPUSH%></a></td>
      				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_push_pull_detail_report.jsp?&status=glPUSH&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><%=glPUSH%></a></td>
      				  
      				  
      				 
      				  
      					
      					</tr>
      		
      		 
      					
      	<%
   		}
    			
    		}		}
 catch(Exception e)
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