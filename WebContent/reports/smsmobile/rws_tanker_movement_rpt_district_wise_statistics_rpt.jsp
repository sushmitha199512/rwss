<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<%
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();	
%>
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
<script language="javascript" type="text/javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
<form  name=f1  method="post">
<%
String mode=request.getParameter("mode");
session.setAttribute("mode", mode);
String fromdate="";
String todate=""; 
String dcode="";
 fromdate=request.getParameter("fDate");
 todate=request.getParameter("toDate");
 dcode=request.getParameter("district");
 session.setAttribute("fromdate",fromdate );
 session.setAttribute("todate", todate);
 String dname=request.getParameter("dname");
 //System.out.println("!!!!!!!!!!!!!!!!"+dname);
Statement stmt1=null,stmt2=null;
ResultSet rst=null,rst2=null;
int slno=0;
    String qry="", str="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
   %>
   <%String isModeChange = request.getParameter("mode");
   %>
   <%
     if(isModeChange.equalsIgnoreCase("date")){
   %>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER >
	<caption>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home | &nbsp; </td>
	 <td ><a href="rws_tanker_movement_daily_statistics_frm.jsp">Back</td>
	
	</tr>  
	</table>
	</caption>
   <table width="45%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr   align=center>
   <%
   if(!fromdate.equals("null") && !fromdate.equals("")){
	   %>
	   
	   <tr bgcolor="#8A9FCD" align="center" colspan="17">
	<td align="center" class="rptHeading" colspan="17"> Tanker Movement Details</td>
	</tr>
	 <tr  align="center" colspan="17"> 
	<td class="rptHeading" colspan="17"> District:<font color=red><%=dname%></font>&nbsp;&nbsp;&nbsp;&nbsp;From Date :<font color=red><%=fromdate%></font>&nbsp;&nbsp;&nbsp;&nbsp;To Date:<font color=red><%=todate%></font><font color=red>&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	 </tr> 
	   
	   
<%-- 	   <td class="gridhdbg" colspan="17"><b>Tanker Movement Details for District:<font color=red><%=dname%></font>(From Date :<font color="red"><%=fromdate %></font> To Date:<font color="red"><%=todate %></font>)</b></td>
 --%>	   <%
   }
    %>
		
		</tr>
       	<%
        session.setAttribute("fromdate", fromdate);
	       session.setAttribute("todate", todate);
       try
		{  
    		%>
    			 <tr>
	<td class=btext   align=center rowspan=1>Sl.No</td>
	<td class=btext   align=center rowspan=1>Date</td>
		<td class=btext   align=center colspan=1>No.of.Habs</td>
		<td class=btext   align=center colspan=1>Population Served</td>
		<td class=btext   align=center colspan=1>No.of Tanker Trips</td>
	  <td class=btext   align=center colspan=1>Quantity(KL)</td>

   </tr>
   
    		<%	
    	int sourceTrips=0,destinationTrips=0,noofHabs=0,populationserved=0,totalnooftrips=0,quantityinql=0;
    		long sum_habs=0,sum_population=0,sum_trips=0,sum_kl=0;
    		String tsDate="",tsDateNew="";;
    		stmt1=conn.createStatement();
    	   String qry1="";
    	   String val="1";
   		
    	   String userId = "00";
   		String regex = "[0-9]+";
   		if(loggedUser!=null){
   			userId = loggedUser.substring(1,3);
   		    userId.matches(regex);
   		}
   	    
   	   
   	    
   	 /* qry1="select count(DISTINCT a.TRIP_ID),count(DISTINCT a.DEST_HABITATION),sum(DISTINCT c.ACT_TOT_POPU),sum(b.TANKER_CAPACITY_IN_KLTS),trunc(a.tanker_trip_start_date_time)   from RWS_TANKER_MOVEMENT_TBL a,RWS_TANKER_REG_TBL b,RWS_COMPLETE_HAB_VIEW c where "+
			 "a.TANKER_REG_NO=b.TANKER_REG_NO and a.DEST_HABITATION=c.PANCH_CODE and  substr(dest_habitation,1,2)='"+dcode+"'  and TANKER_TRIP_END_DATE_TIME is  not null and   approvel_status='Y'  and  to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and   to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy') group by trunc(a.tanker_trip_start_date_time)" ;
    		
			 */ 
			 
			 qry1="    select count(distinct trip_id),count(DISTINCT a.DEST_HABITATION),sum(DISTINCT c.ACT_TOT_POPU),sum(b.TANKER_CAPACITY_IN_KLTS),trunc(a.tanker_trip_start_date_time) from RWS_TANKER_MOVEMENT_TBL a,RWS_COMPLETE_HAB_VIEW c,RWS_TANKER_REG_TBL b  where  substr(dest_habitation,1,2)='"+dcode+"' and a.DEST_HABITATION=c.PANCH_CODE and a.TANKER_REG_NO=b.TANKER_REG_NO and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy')  and (APPROVEL_STATUS <> 'N' or APPROVEL_STATUS is null) and TANKER_TRIP_END_DATE_TIME is not null group by trunc(a.tanker_trip_start_date_time)";
			 
			 //System.out.println("++++++"+qry1);
			 
			 rs = stmt1.executeQuery(qry1); 
    			while(rs.next())
    			{
    					 tsDate=rs.getString(5);
    					 String tsd[]=tsDate.split(" ");
    					 String tsdn[]=tsd[0].split("-");
    					 tsDateNew=tsdn[2]+"-"+tsdn[1]+"-"+tsdn[0];
    					 sourceTrips= rs.getInt(1);
    					 noofHabs=rs.getInt(2);
    					 populationserved=rs.getInt(3);
    					 quantityinql=rs.getInt(4);
    					 sum_trips=sum_trips+rs.getInt(1);
    					 sum_habs=sum_habs+rs.getInt(2);
    					 sum_population=sum_population+rs.getInt(3);
    					 sum_kl=sum_kl+rs.getInt(4);
    	    		   
    				 if(styleCount%2==0){
    					 style="gridbg1";
    				 }else{
    					 style="gridbg2";
    				 }
    				 styleCount++;
    			   %>
    	              <tr>
    	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
    	              <td class="<%=style%> "style="text-align: left;"><%=tsDateNew%></td>
    				 <td class="<%=style%> "style="text-align: right;"><%=noofHabs%></td>
    				 <td class="<%=style%> "style="text-align: right;"><%=populationserved%></td>
    				 <td class="<%=style%> "style="text-align: right;"><%=sourceTrips%></td>
    				 <td class="<%=style%> "style="text-align: right;"><%=quantityinql%></td>

    					</tr>			
    	<%
		}	
    			%>
    			 <tr>
                    <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;">Total:</td>
                    <td class="btext" style="text-align: right;"><%=sum_habs%></td>
                    <td class="btext" style="text-align: right;"><%=sum_population%></td>
                    <td class="btext" style="text-align: right;"><%=sum_trips%></td>
                    <td class="btext" style="text-align: right;"><%=sum_kl%></td>
                    
                   
                                       
                </tr>
    			<%
    			
    			
    			
		}
 catch(Exception e)
	   {
	   e.printStackTrace();
	   }
	   finally{
		  if(conn!=null){
	   conn.close();
		  }
	   }
	   %>
</table>
<%} %>

	</table>	
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>