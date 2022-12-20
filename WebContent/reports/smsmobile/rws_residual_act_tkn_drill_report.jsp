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
   
		<td class="gridhdbg" colspan="17"><b>SMS Based - Action Taken District:<font color="red"><%=dname%></font></b></td>
		
		
		</tr>
  
	
       
       	<%
       try
		{
    		if(mode1.equals("mandal")){
    		
    		%>
    			 <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	<td class=gridhdbg rowspan=2>Mandal</td>
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
    		
    		
    		
    	int rcA=0,rcN=0,rcTot=0,drA=0,drN=0,dfN=0,dfA=0,ohA=0,ohN=0,glN=0,glA=0;
    	   stmt1=conn.createStatement();
    		String qry1="select dcode,mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by dcode";
    		
    			
    		rst = stmt1.executeQuery(qry1); 
    			
    			
    			while(rst.next())
    			{
    				
    				str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and PPM_VALUE<0.2  and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <>'') and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    				
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 rcA= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and PPM_VALUE<0.2  and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='')  and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 rcN= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and PPM_VALUE<0.2  and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"'   and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
  				 stmt2=conn.createStatement();
  				 rs=stmt2.executeQuery(str);
  				 if(rs.next())
  	    		   {
  					 rcTot= rs.getInt(1);
  	    		   }
  				 stmt2.close();
  				 rs.close();
   				str="select count(*) from RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE<>'')  and SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 dfA= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				str="select count(*) from RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='')  and SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 dfN= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				str="select count(*) from RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE<>'')  and SEND_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 drA= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				str="select count(*) from RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and SEND_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 drN= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
		
   				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and GLSR_OHSR='O'  and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <> '') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
				 stmt2=conn.createStatement();
				 rs=stmt2.executeQuery(str);
				 if(rs.next())
	    		   {
					 ohA= rs.getInt(1);
	    		   }
				 stmt2.close();
				 rs.close();
				 
				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and GLSR_OHSR='O'  and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
				 stmt2=conn.createStatement();
				 rs=stmt2.executeQuery(str);
				 if(rs.next())
	    		   {
					 ohN= rs.getInt(1);
	    		   }
				 stmt2.close();
				 rs.close();
				 
				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and GLSR_OHSR='G'  and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <> '') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
				 stmt2=conn.createStatement();
				 rs=stmt2.executeQuery(str);
				 if(rs.next())
	    		   {
					 glA= rs.getInt(1);
	    		   }
				 stmt2.close();
				 rs.close();
				 
				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and GLSR_OHSR='G'  and substr(c.habitation_code,1,2)='"+dcode+"' and substr(c.habitation_code,6,2)='"+rst.getString(2)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
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
    	              <td class="<%=style%> "style="text-align: left;"><a href="rws_residual_act_tkn_drill_report.jsp?mode1=hab&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=rst.getString(3)%>"><%=rst.getString(3)%></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (rcA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=rcA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (rcN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=rcN%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (rcTot != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=rcTot%></font></td>
    				  
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (dfA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=dfA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (dfN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=dfN%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (drA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=drA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (drN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=drN%></font></td>
    				  
    					 <td class="<%=style%> "style="text-align: right;"><font <%if (ohA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=ohA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (ohN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=ohN%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (glA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=glA%></font></td>
    				  <td class="<%=style%> "style="text-align: right;"><font <%if (glN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=glN%></font></td>
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
	<td class=gridhdbg rowspan=2>Habitation Code/Habitation Name</td>
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
    		
    		
    		
    	int rcA=0,rcN=0,rcTot=0,drA=0,drN=0,dfN=0,dfA=0,ohA=0,ohN=0,glN=0,glA=0;
    	   stmt1=conn.createStatement();
    		String qry1="select panch_code,panch_name from rws_panchayat_raj_tbl  where substr(panch_code,1,2)='"+dcode+"'  and substr(panch_code,6,2)='"+mcode+"' order by panch_code";
    		
    			
    		rst = stmt1.executeQuery(qry1); 
    			
    			
    			while(rst.next())
    			{
    				
    			 str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE  and PPM_VALUE<0.2 and c.habitation_code='"+rst.getString(1)+"'  and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <>'') and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    			 //System.out.println("rcA :- "+str);				 	
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 rcA= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
				 str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE  and PPM_VALUE<0.2 and c.habitation_code='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='')  and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
				 //System.out.println("rcN :- "+str);
				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 rcN= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
				 str="select count(*) from RWS_RESIDUAL_CHLORINE_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE  and PPM_VALUE<0.2 and c.habitation_code='"+rst.getString(1)+"'   and TEST_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
				 //System.out.println("rcTot :- "+str);
				 stmt2=conn.createStatement();
  				 rs=stmt2.executeQuery(str);
  				 if(rs.next())
  	    		   {
  					 rcTot= rs.getInt(1);
  	    		   }
  				 stmt2.close();
  				 rs.close();
   				 str="select count(*) from RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE  and c.habitation_code='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE<>'')  and SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
   				 //System.out.println("dfA :- "+str);
				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 dfA= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				 str="select count(*) from RWS_SCHEME_STATUS_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  b.sms_mobile =c.MOBILE and c.habitation_code='"+rst.getString(1)+"'  and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='')  and SMS_DATE between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
   				 //System.out.println("dfN :- "+str);
				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 dfN= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
				 str="select count(*) from RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and  c.habitation_code='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE<>'')  and SEND_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
				 //System.out.println("drA :- "+str);
				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 drA= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();
   				 str="select count(*) from RWS_DROUGHT_TANKER_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and c.habitation_code='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and SEND_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
   				 //System.out.println("drN :- "+str);
				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					 drN= rs.getInt(1);
   	    		   }
   				 stmt2.close();
   				 rs.close();

   				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and GLSR_OHSR='O'  and  c.habitation_code='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <> '') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
   				 //System.out.println("ohA :- "+str);
				 stmt2=conn.createStatement();
				 rs=stmt2.executeQuery(str);
				 if(rs.next())
	    		   {
					 ohA= rs.getInt(1);
	    		   }
				 stmt2.close();
				 rs.close();
				 
				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and GLSR_OHSR='O'  and c.habitation_code='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
				 //System.out.println("ohN :- "+str);
				 stmt2=conn.createStatement();
				 rs=stmt2.executeQuery(str);
				 if(rs.next())
	    		   {
					 ohN= rs.getInt(1);
	    		   }
				 stmt2.close();
				 rs.close();
				 
				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and GLSR_OHSR='G'  and c.habitation_code='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <> '') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
				 //System.out.println("glA :- "+str);
				 stmt2=conn.createStatement();
				 rs=stmt2.executeQuery(str);
				 if(rs.next())
	    		   {
					 glA= rs.getInt(1);
	    		   }
				 stmt2.close();
				 rs.close();
				 
				 str="select count(*) from RWS_OHSR_GLSR_SMS_TBL B,RWS_MOBILE_SMS_REGISTER_TBL c  WHERE  to_char(b.sms_mobile) =c.MOBILE and GLSR_OHSR='G'  and c.habitation_code='"+rst.getString(1)+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and TEST_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
				 //System.out.println("glN :- "+str);
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
    	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(1)%>&nbsp;/&nbsp;<%=rst.getString(2)%></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_rc_detail_report.jsp?&status=rcA&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (rcA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=rcA%></font></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_rc_detail_report.jsp?&status=rcN&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (rcN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=rcN%></font></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_rc_detail_report.jsp?&status=rcT&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (rcTot != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=rcTot%></font></a></td>
    				  
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_df_detail_report.jsp?&status=dfA&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (dfA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=dfA%></font></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_df_detail_report.jsp?&status=dfN&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (dfN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=dfN%></font></a></td>
    				  
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_dr_status_report.jsp?&status=drA&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (drA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=drA%></font></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_dr_status_report.jsp?&status=drN&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (drN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=drN%></font></a></td>
    				  
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_oh_gl_status_report.jsp?&status=ohA&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (ohA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=ohA%></font></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_oh_gl_status_report.jsp?&status=ohN&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (ohN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=ohN%></font></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_oh_gl_status_report.jsp?&status=glA&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (glA != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=glA%></font></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_oh_gl_status_report.jsp?&status=glN&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>')"><font <%if (glN != 0){%> color="#800080" style="font-weight:bold;" <%}%> size="2"><%=glN%></font></a></td>
    					
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