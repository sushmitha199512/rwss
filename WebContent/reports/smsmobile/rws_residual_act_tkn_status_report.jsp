<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String qry3="";	
	System.out.println("user :"+loggedUser);
%>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">

function preventBack() { window.history.forward();}  
setTimeout("preventBack()", 0);  
window.onload = function () { null }; 


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
		document.forms[0].action="./rws_residual_act_tkn_status_report.jsp?mode=date";
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
// System.out.println("todate"+todate);

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
	<tr></tr>
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
		<td class="gridhdbg" colspan="17"><b>SMS Based - Action Taken in Current Month</b></td>
		<%} %>
		
		</tr>
  
	
       
       	<%
       try
		{
    		
    		
    		%>
    			 <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	<td class=gridhdbg rowspan=2>District</td>
	<td class=gridhdbg colspan=3>Residual Chlorine(RC)</td>
	<td class=gridhdbg colspan=2>Schemes(DF)</td>
	<td class=gridhdbg colspan=2>Tanker(DR)</td>
	<td class=gridhdbg colspan=2>OHSR(OH)</td>
	<td class=gridhdbg colspan=2>GLSR(GL)</td>
   </tr>
   <tr>
   
    <td class=gridhdbg rowspan=1>Attended</td>
    <td class=gridhdbg rowspan=1>Not Attended</td>
    <td class=gridhdbg rowspan=1>Total Tested</td>
    <td class=gridhdbg rowspan=1>Attended</td>
    <td class=gridhdbg rowspan=1>Not Attended</td>
    <td class=gridhdbg rowspan=1>Attended</td>
    <td class=gridhdbg rowspan=1>Not Attended</td>
    <td class=gridhdbg rowspan=1>Attended</td>
    <td class=gridhdbg rowspan=1>Not Attended</td>
    <td class=gridhdbg rowspan=1>Attended</td>
    <td class=gridhdbg rowspan=1>Not Attended</td>
   
   
	
       </tr>
    		<%
    		
    		
    		
    	int rcA=0,rcN=0,rcTot=0,drA=0,drN=0,dfN=0,dfA=0,ohA=0,ohN=0,glA=0,glN=0;
    	   stmt1=conn.createStatement();
    	   String qry1="";
    	  
   		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")  ||loggedUser.equals("pdswsm") ||loggedUser.equals("cerwss") ||loggedUser.equals("secrwss")||loggedUser.equals("minrwss") ))
   		{
   	
    		qry1="select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
    		
   		}
   		else{
   			//System.out.println(loggedUser);
   			qry1="select dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
   			//System.out.println(qry1);
   		}
    		rst = stmt1.executeQuery(qry1); 
    			
    			
    			while(rst.next())
    			{
    				str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and PPM_VALUE<0.2  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <>'') and TEST_DATE>=to_date('"+fromdate+"','dd/mm/yyyy') and TEST_DATE<=to_date('"+todate+"','dd/mm/yyyy')+1";
    				
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 rcA= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and PPM_VALUE<0.2  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='')  and TEST_DATE>=to_date('"+fromdate+"','dd/mm/yyyy') and TEST_DATE<=to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 rcN= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and PPM_VALUE<0.2  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"'  and TEST_DATE>=to_date('"+fromdate+"','dd/mm/yyyy') and TEST_DATE<=to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 rcTot= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				str="select count(*) from RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE<>'')  and SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 dfA= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				str="select count(*) from RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='')  and SMS_DATE between  to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 dfN= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				str="select count(*) from RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE<>'')  and SEND_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 drA= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				str="select count(*) from RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE  and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and SEND_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 drN= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();

    				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and GLSR_OHSR='O' and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <> '') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 ohA= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 
    				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and GLSR_OHSR='O' and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 ohN= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 
    				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and GLSR_OHSR='G' and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <> '') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 glA= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 
    				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and GLSR_OHSR='G' and substr(c.habitation_code,1,2)='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 glN= rs.getInt(1);
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
    	              <td class="<%=style%> "style="text-align: left;"><a href="rws_residual_act_tkn_drill_report.jsp?mode1=mandal&dcode=<%=rst.getString(1)%>&dname=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>"><%=rst.getString(2)%></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (rcA != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=rcA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (rcN != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=rcN%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (rcTot != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=rcTot%></font></td>
    				  
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (dfA != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=dfA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (dfN != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=dfN%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (drA != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=drA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (drN != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=drN%></font></td>
    				  
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (ohA != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=ohA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (ohN != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=ohN%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (glA != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=glA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (glN != 0){%>color="#800080" style="font-weight:bold;"<%}%> size="2"><%=glN%></font></td>
    				</tr>
    	<%
		}
		}
       catch(Exception e)
	   {
    	   System.out.println("Exception user :"+loggedUser);
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