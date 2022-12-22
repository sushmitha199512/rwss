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
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

function fnSubmit()
{
	//alert("hi");
	var frmdate=document.getElementById("fromDate").value;
	var todate=document.getElementById("toDate").value;
	if(document.getElementById("fromDate").value='')
		{
		alert("please Select From Date");
		return false;
		}
	else if(document.getElementById("toDate").value='')
		{
		alert("please Select To Date");
		return false;
		}
	else
		{
		document.forms[0].fromDate.value=frmdate;
		document.forms[0].toDate.value=todate;
		//document.forms[0].action="rws_residual_act_tkn_status_report.jsp?fromDate="+frmdate+"&toDate="+todate;
		document.forms[0].action="./rws_pull_push_report.jsp?mode=date";
		document.forms[0].submit();
		
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
<script language="javascript" type="text/javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>

<form method="post">
<%
String mode=request.getParameter("mode");
String fromdate="";
String todate=""; 
 if(mode.equals("initial")){
	  fromdate="";
	  todate=""; 
	
 }
 else{
 fromdate=request.getParameter("fromDate");
 todate=request.getParameter("toDate");

 }
 //System.out.println("fromdate"+fromdate);
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
	<table border = 0 cellspacing = 0 cellpadding = 0 width="20%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr>
	<td class=gridhdbg>From Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="fromDate" id="fromDate" style="width:90" />
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>To Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="toDate" id="toDate" style="width:90"  />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
		<td colspan=2 align=center>
			<input type=button id="circ" onclick="fnSubmit()" value="Get Data" class = btext>
		</td>
	</tr>
	
	</table>
	
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  </td>

	 
	</tr>  
	
	
	</table>
	</caption>
	
	
		
   	
   <table width="75%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr   align=center>
   <%
   if(!fromdate.equals("null") && !fromdate.equals("")){
	   %>
	   <td class="gridhdbg" colspan="17"><b>Residual Chlorine Action Taken(From:<font color="red"><%=fromdate %></font> To:<font color="red"><%=todate %></font>)</b></td>
	   <%
   }
   else{
	   DateFormat dateFormat=new SimpleDateFormat("MM/yyyy"); 
	   DateFormat dateFormat1=new SimpleDateFormat("dd/MM/yyyy");
       Date date=new  Date();
       String cDate=dateFormat.format(date);
      
       fromdate="01/"+cDate;
       todate=dateFormat1.format(date);
       //System.out.println("fromdate---"+fromdate);
       //System.out.println("to---"+todate);
   %>
		<td class="gridhdbg" colspan="17"><b>PULL & PUSH SMS Detail Report for Current Month</b></td>
		<%} %>
		
		</tr>
  
	
       
       	<%
       try
		{
    		
    		
    		%>
    			 <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	<td class=gridhdbg rowspan=2>District</td>
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
    		String qry1="select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
    		
    			
    		rst = stmt1.executeQuery(qry1); 
    			
    			
    			while(rst.next())
    			{
    				str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  ";
    				//System.out.println("rc query1----"+str);
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 rcPULL= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				
    				str="select count(*) from RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
    				//System.out.println("scheme query1----"+str);
    				stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 dfPULL= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				
    				 str="select count(*) from RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"'  and SEND_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
    				// System.out.println("drought query1----"+str);
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 drPULL= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				// System.out.println();
    				 str="select count(*) from rws_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' AND GLSR_OHSR='O' and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
    				// System.out.println("ohsr query1----"+str);
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 ohPULL= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 

    				 str="select count(*) from rws_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' AND GLSR_OHSR='G' and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
    				 //System.out.println("glsr query1----"+str);
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 glPULL= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 
    				
    				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL   WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"'  and SMS_MODULE_AREA='RC'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
    				// System.out.println("rc query2----"+str);
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 rcPUSH= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				// System.out.println();
    				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"'  and SMS_MODULE_AREA='DF'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
    				// System.out.println("scheme query2----"+str);
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 dfPUSH= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 
    				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"'  and SMS_MODULE_AREA='DR'   AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')  ";
    				// System.out.println("dr query2----"+str);
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 drPUSH= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				
    				 
    				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"'  and SMS_MODULE_AREA='OH'  AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
    				// System.out.println("oh query2----"+str);
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 //System.out.println("str"+str);
    				 if(rs.next())
    	    		   {
    					 ohPUSH= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 
    				 str="select count(*) from RWS_SMS_IN_OUT_STATUS_TBL  WHERE   substr(habitation_code,1,2)='"+rst.getString(1)+"'  and SMS_MODULE_AREA='GL'  AND SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy') ";
    				 //System.out.println("gl query2----"+str);
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
    	              <td class="<%=style%> "style="text-align: left;"><a href="rws_push_pull_drill_report.jsp?mode1=mandal&dcode=<%=rst.getString(1)%>&dname=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>"><%=rst.getString(2)%></td>
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