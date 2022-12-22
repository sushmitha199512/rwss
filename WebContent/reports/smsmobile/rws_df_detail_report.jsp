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
   // System.out.println("dcode"+dcode);
    String dname=request.getParameter("dname");
    //System.out.println("dname"+dname);
    String fromdate=request.getParameter("fromdate");
    //System.out.println("fromdate"+fromdate);
    String todate=request.getParameter("todate");
   // System.out.println("todate"+todate);
    String status=request.getParameter("status");
    //System.out.println("status"+status);
	String mcode=request.getParameter("mcode");
	String habcode=request.getParameter("habcode");
	 // System.out.println("mcode"+mcode);
	String mname=request.getParameter("mname");
	 // System.out.println("mname"+mname);

	
    

   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center">
	
		
		
		</tr></table>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
	<td ><a href="#" onClick="window.close();">Close</a></td>

	 
	</tr>  
	
	
	</table>
	</caption>
	
	
		
   	
   <table width="75%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="17"><b>Defunct Scheme Action Taken </b></td>
		
		</tr>
  
	 <tr>
	
	<td class=gridhdbg>Sl.No</td>
    <td class=gridhdbg>Habitation Code/</br>Habitation Name</td>
    <td class=gridhdbg>Asset Code</td>
    
    <td class=gridhdbg>Local Person Name</td>
    <td class=gridhdbg>Location</td>
    <td class=gridhdbg>Message Send Date</td>
    <td class=gridhdbg>Scheme Status</td>
    <td class=gridhdbg>Action Taken</td>
    <td class=gridhdbg>Date Of Action</td>
    <td class=gridhdbg>Remarks</td>
    
   
   
	
       </tr>
       
       	<%
       try
		{
    	 
    	   
	if(status.equals("dfA"))
	{
	   str="select distinct panch_name,nvl(b.asset_code,'-'),DATA_COLLECTOR_NAME,c.LOCATION,STATUS,nvl(to_char(ACTION_DATE,'dd/mm/yyyy'),'-'),nvl(to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),'-'),nvl(b.REMARKS,'-') ,c.habitation_code,nvl(to_char(SMS_DATE,'dd/mm/yyyy'),'-'), nvl(B.MESG_ID,'0') from rws_panchayat_raj_tbl a,rws_scheme_status_sms_tbl B,RWS_MOBILE_SMS_REGISTER_TBL c,rws_mandal_subdivision_tbl d WHERE a.panch_code=c.habitation_code and b.sms_mobile =c.MOBILE and  c.habitation_code='"+habcode+"' and (ACTION_ENTERED_DATE is not null or ACTION_ENTERED_DATE <>'') and SMS_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')";
	}
	else if(status.equals("dfN"))
	{
		str="select distinct panch_name,nvl(b.asset_code,'-'),DATA_COLLECTOR_NAME,c.LOCATION,STATUS,nvl(to_char(ACTION_DATE,'dd/mm/yyyy'),'-'),nvl(to_char(ACTION_ENTERED_DATE,'dd/mm/yyyy'),'-'),nvl(b.REMARKS,'-') ,c.habitation_code,nvl(to_char(SMS_DATE,'dd/mm/yyyy'),'-'), nvl(B.MESG_ID,'0') from rws_panchayat_raj_tbl a,rws_scheme_status_sms_tbl B,RWS_MOBILE_SMS_REGISTER_TBL c,rws_mandal_subdivision_tbl d WHERE a.panch_code=c.habitation_code and b.sms_mobile =c.MOBILE and  c.habitation_code='"+habcode+"' and (ACTION_ENTERED_DATE is null or ACTION_ENTERED_DATE='') and SMS_DATE  between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')";
	}
		
	      
		 
	   
	   stmt1=conn.createStatement();
	 //System.out.println("222222222222:"+str);
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
              <td class="<%=style%> "style="text-align: left;"><%=rs.getString(9)%>/</br><%=rs.getString(1)%></td>
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