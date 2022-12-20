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

</script>
<form>
<%


String date=request.getParameter("date");


System.out.println("date"+date);



  	
nic.watersoft.works.WorksData1 w=new nic.watersoft.works.WorksData1();



    String qry="";
    int styleCount=0;
    String style="";

    
    
    
    
	
     
    
   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	<tr >
	<td align="center" class="gridhdbg" > Grievance Status Abstract Report					
 </td>
	</tr>
    
	</table>
   
   <table width="60%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
    
	<tr>
	
	<td class=gridhdbg >Sl.No</td>
   <td class=gridhdbg >District</td>
   <td class=gridhdbg >Complaint No</td>
    <td class=gridhdbg >Name/<br>Address/<br>Phone&nbsp;NO/<br>Email</td> 
   <td class=gridhdbg >Complaint Date</td>  
   <td class=gridhdbg >Complaint&nbsp;Descripition</td>
   <td class=gridhdbg >Grievance&nbsp;Related&nbsp;To</td>
   <td class=gridhdbg >Grievance&nbsp;Category</td>
   <td class=gridhdbg >Grievance&nbsp;Entry&nbsp;Category</td>
   
    <td class=gridhdbg >Nature of Problem</td>  
  <td class=gridhdbg >Action Taken</td> 
  <td class=gridhdbg >Action&nbsp;Description</td>  
<td class=gridhdbg >Attanded Date</td> 
 
<td class=gridhdbg >Attanded By</td>
<td class=gridhdbg >Message Sent to Petitioner</td>
<td class=gridhdbg >Message Sent Date</td>   
   </tr>
       
<%
try
{
	


   //main qry
   Statement stmt8=null;
   ResultSet rs8=null;
   int sno=1;
   stmt8=conn.createStatement();
   
   int totalconstructed=0,pop=0,housholdsnc=0,toilethav=0,toiletnothav=0;
qry="select COMPLAINT_NO,Name,ADDRESS,PHONE_NO,to_char(COMPLAINT_DATE,'dd/mm/yyyy'),COMPLAINT_DESC,nvl(NATURE_PROBLEM,'-'),nvl(ACTION_TAKEN,'-'),nvl(ACTION_DESC,'-'),nvl(to_char(ATTENDED_DATE,'dd/mm/yyyy'),'-'),nvl(ATTENDED_BY,'-'),nvl(MESSAGE_SENT,'-'),nvl(to_char(MESSAGE_SENT_DATE,'dd/mm/yyyy'),'-'),DNAME,nvl(GRIEVANCE_RELATED_TO,'-'),nvl(GRIEVANCE_CATEGORY,'-'),nvl(GRIEVANCE_ENTRY_CATEGORY,'-'),nvl(EMAILID,'-') from RWS_GENERIC_COMPLAINTS_REG_TBL a,rws_complete_hab_view b where a.habitation_code=b.panch_code and  COMPLAINT_DATE=to_date('"+date+"','dd/mm/yyyy') and ATTENDED_DATE is not null and URBAN_WATER='R'";

   
   
      
   System.out.println(qry);   
        
   
	 
  rs8=stmt8.executeQuery(qry);
   while(rs8.next())
   {
   	
	
	
	
	 if(styleCount%2==0){
		 style="gridbg1";
	 }else{
		 style="gridbg2";
	 }
	 styleCount++;
	

	 
%>
	<tr>
	
    	<td class="<%=style %>" style="text-align: left;"><%=sno++%></td>
    	<td class="<%=style %>" style="text-align: left;"><%=rs8.getString(14)%></td> 
     <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(1)%></td> 
      <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(2)%>/<br><%=rs8.getString(3)%>/<br><%=rs8.getString(4)%>/<br><%=rs8.getString(18)%></td>  
      <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(5)%></td>    
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(6)%></td>
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(15)%></td> 
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(16)%></td> 
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(17)%></td>  
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(7)%></td> 
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(8)%></td> 
  
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(9)%></td> 
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(10)%></td> 
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(11)%></td> 
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(12)%></td> 
  <td class="<%=style %>" style="text-align: left;"><%=rs8.getString(13)%></td> 
  	</tr>
  	
<%



}%>
<tr>
	
  
  
   	
 
 
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
	finally{
		if(conn!=null)
			conn.close();
	}


%>
    
</table>

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>