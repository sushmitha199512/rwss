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
 



    String qry="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
    
String dname=request.getParameter("dname");
String dcode=request.getParameter("district");
String mcode=request.getParameter("mandal");
String fromDate=request.getParameter("fromDate");
String toDate=request.getParameter("toDate");
String status=request.getParameter("status");

    System.out.println("mcode"+mcode);
    
    

   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  </td>
<%-- 	<td ><a href="rws_news_paper_clippings_rpt_xls.jsp?level=<%=level%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>">Excel  &nbsp; </td> --%>
	 
	</tr>  
	
	
	</table>
	</caption>
	
	
		
   	
   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="17"><b>Generic Complaints For <%=dname %></b></td>
		
		</tr>
  
	 <tr>
	
	<td class=gridhdbg>Sl.No</td>
    <td class=gridhdbg>Mandal/<br>Panchayat/<br>Village</td>
    <td class=gridhdbg>Hab Code/<br>Hab Name</td>
    <td class=gridhdbg>Complaint No</td>
    <td class=gridhdbg>Complaint Date</td>
    <td class=gridhdbg>Complaint&nbsp;Discription</td>
    <td class=gridhdbg>Grievance Related To</td>
    <td class=gridhdbg>Grievance Category</td>
    <td class=gridhdbg>Grievance Entry Category</td>
    <td class=gridhdbg>Name/<br>Address/<br>Phone No/<br>EmailId</td>
     <td class=gridhdbg>Attended Date</td>
    <td class=gridhdbg >Attended By</td>
    <td class=gridhdbg >Action Taken</td>
     <td class=gridhdbg>Action Description</td>
    <td class=gridhdbg >Message Sent</td>
    <td class=gridhdbg>Message Sent Date</td>
   
   
	
       </tr>
	
     <%
    
     try{
    	 Statement stmt1=null;
         ResultSet rs1=null;
         int sno=1;
         stmt1=conn.createStatement();
         
         if(status.equals("Not Attended")){
        	 if(mcode.equals("ALL")){
        		   	 qry="select a.MNAME,a.PNAME,a.VNAME,a.PANCH_CODE,a.PANCH_NAME,COMPLAINT_NO,to_char(COMPLAINT_DATE,'dd/mm/yyyy'),nvl(COMPLAINT_STATUS,'--'),nvl(COMPLAINT_DESC,'--'),nvl(REMARKS,'--'),nvl(NAME,'--'),nvl(ADDRESS,'--'),nvl(PHONE_NO,'0'),to_char(ATTENDED_DATE,'dd/mm/yyyy'),nvl(ATTENDED_BY,'--'),nvl(ACTION_TAKEN,'--'),nvl(ACTION_DESC,'--'),nvl(MESSAGE_SENT,'--'),to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),nvl(GRIEVANCE_RELATED_TO,'--'),nvl(GRIEVANCE_CATEGORY,'--'),nvl(EMAILID,'--'),nvl(GRIEVANCE_ENTRY_CATEGORY,'--') from rws_complete_hab_view a,RWS_GENERIC_COMPLAINTS_REG_TBL b where b.HABITATION_CODE=a.PANCH_CODE and substr(HABITATION_CODE,1,2)='"+dcode+"' and COMPLAINT_DATE between to_date('"+fromDate+"','dd/mm/yyyy') and to_date('"+toDate+"','dd/mm/yyyy') and ATTENDED_DATE IS NULL and URBAN_WATER='R' order by COMPLAINT_DATE";
        	 }
        	 else{
        		 qry="select a.MNAME,a.PNAME,a.VNAME,a.PANCH_CODE,a.PANCH_NAME,COMPLAINT_NO,to_char(COMPLAINT_DATE,'dd/mm/yyyy'),nvl(COMPLAINT_STATUS,'--'),nvl(COMPLAINT_DESC,'--'),nvl(REMARKS,'--'),nvl(NAME,'--'),nvl(ADDRESS,'--'),nvl(PHONE_NO,'0'),to_char(ATTENDED_DATE,'dd/mm/yyyy'),nvl(ATTENDED_BY,'--'),nvl(ACTION_TAKEN,'--'),nvl(ACTION_DESC,'--'),nvl(MESSAGE_SENT,'--'),to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),nvl(GRIEVANCE_RELATED_TO,'--'),nvl(GRIEVANCE_CATEGORY,'--'),nvl(EMAILID,'--'),nvl(GRIEVANCE_ENTRY_CATEGORY,'--') from rws_complete_hab_view a,RWS_GENERIC_COMPLAINTS_REG_TBL b where b.HABITATION_CODE=a.PANCH_CODE and substr(HABITATION_CODE,1,2)='"+dcode+"' and substr(HABITATION_CODE,6,2)='"+mcode+"' and COMPLAINT_DATE between to_date('"+fromDate+"','dd/mm/yyyy') and to_date('"+toDate+"','dd/mm/yyyy') and ATTENDED_DATE IS NULL and URBAN_WATER='R' order by COMPLAINT_DATE";
        	 }
         }
         else{
        	 if(mcode.equals("ALL")){
    		   	 qry="select a.MNAME,a.PNAME,a.VNAME,a.PANCH_CODE,a.PANCH_NAME,COMPLAINT_NO,to_char(COMPLAINT_DATE,'dd/mm/yyyy'),nvl(COMPLAINT_STATUS,'--'),nvl(COMPLAINT_DESC,'--'),nvl(REMARKS,'--'),nvl(NAME,'--'),nvl(ADDRESS,'--'),nvl(PHONE_NO,'0'),to_char(ATTENDED_DATE,'dd/mm/yyyy'),nvl(ATTENDED_BY,'--'),nvl(ACTION_TAKEN,'--'),nvl(ACTION_DESC,'--'),nvl(MESSAGE_SENT,'--'),to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),nvl(GRIEVANCE_RELATED_TO,'--'),nvl(GRIEVANCE_CATEGORY,'--'),nvl(EMAILID,'--'),nvl(GRIEVANCE_ENTRY_CATEGORY,'--') from rws_complete_hab_view a,RWS_GENERIC_COMPLAINTS_REG_TBL b where b.HABITATION_CODE=a.PANCH_CODE and substr(HABITATION_CODE,1,2)='"+dcode+"' and COMPLAINT_DATE between to_date('"+fromDate+"','dd/mm/yyyy') and to_date('"+toDate+"','dd/mm/yyyy') and ATTENDED_DATE IS NOT NULL and URBAN_WATER='R' order by COMPLAINT_DATE";
    	 }
    	 else{
    		 qry="select a.MNAME,a.PNAME,a.VNAME,a.PANCH_CODE,a.PANCH_NAME,COMPLAINT_NO,to_char(COMPLAINT_DATE,'dd/mm/yyyy'),nvl(COMPLAINT_STATUS,'--'),nvl(COMPLAINT_DESC,'--'),nvl(REMARKS,'--'),nvl(NAME,'--'),nvl(ADDRESS,'--'),nvl(PHONE_NO,'0'),to_char(ATTENDED_DATE,'dd/mm/yyyy'),nvl(ATTENDED_BY,'--'),nvl(ACTION_TAKEN,'--'),nvl(ACTION_DESC,'--'),nvl(MESSAGE_SENT,'--'),to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),nvl(GRIEVANCE_RELATED_TO,'--'),nvl(GRIEVANCE_CATEGORY,'--'),nvl(EMAILID,'--'),nvl(GRIEVANCE_ENTRY_CATEGORY,'--') from rws_complete_hab_view a,RWS_GENERIC_COMPLAINTS_REG_TBL b where b.HABITATION_CODE=a.PANCH_CODE and substr(HABITATION_CODE,1,2)='"+dcode+"' and substr(HABITATION_CODE,6,2)='"+mcode+"' and COMPLAINT_DATE between to_date('"+fromDate+"','dd/mm/yyyy') and to_date('"+toDate+"','dd/mm/yyyy') and ATTENDED_DATE IS NOT NULL and URBAN_WATER='R' order by COMPLAINT_DATE";
    	 }
         }
      						
     
        
         System.out.println("qry anupama"+qry);
      	 
         rs1=stmt1.executeQuery(qry);
       
         while(rs1.next())
         {
        	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>  

 
   <tr>
	
	  <td class="<%=style%> "style="text-align: right;"> <%=sno++%></td>
      
      <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(1)%>/<BR><%=rs1.getString(2)%>/<BR><%=rs1.getString(3)%></td>
      
         <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(4)%>/<BR><%=rs1.getString(5)%></td>
         
          <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(6)%></td>
           <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(7)%></td>
           <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(9)%></td>
          <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(20)%></td>
           <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(21)%></td>
             <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(23)%></td>
             
            
               <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(11)%>/<BR><%=rs1.getString(12)%>/<BR><%=rs1.getString(13)%>/<BR><%=rs1.getString(22)%></td>
                 <%if(rs1.getString(14)!=null){ %>
        			<td class="<%=style%> "style="text-align: left;"><%=rs1.getString(14)%></td>
        			<%} 
        			else{
        			%>
        			<td class="<%=style%> "style="text-align: left;">--</td>
        			<%} %>
                  <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(15)%></td>
                   <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(16)%></td>
                    <td class="<%=style%> "style="text-align: left;"><%=rs1.getString(17)%></td>
        			<td class="<%=style%> "style="text-align: left;"><%=rs1.getString(18)%></td>
        			<%if(rs1.getString(19)!=null){ %>
        			<td class="<%=style%> "style="text-align: left;"><%=rs1.getString(19)%></td>
        			<%} 
        			else{
        			%>
        			<td class="<%=style%> "style="text-align: left;">--</td>
        			<%} %>
     </tr>
   
    <%
         }
     }
     catch(Exception e){
    	 e.printStackTrace();
     }
     finally{
    	 
     }
    %>
</table>
	</table>	
    
  

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>