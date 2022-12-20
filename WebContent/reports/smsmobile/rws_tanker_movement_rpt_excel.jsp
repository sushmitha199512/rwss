<%@page import="java.util.Date"%>
  <%-- <%@ include file="/commons/rws_header1.jsp"%> --%>  
 <%-- <%@ include file="/commons/rws_header2.jsp"%> --%>  
<%@ page import="java.text.DecimalFormat.*" %>
<%@ page import="java.io.*,java.util.*,java.text.*" %>
<%@ page import="nic.watersoft.commons.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/reports/conn.jsp" %>
<%response.setContentType("application/vnd.ms-excel");%>
<%
	String query = null;
	String loggedUser=request.getParameter("loggedUser");
	String qry3="";
	String distDtlsQry = null;
    String mndDtlsQry = null;
    String panchDtlsQry = null;
    String villageDtlsQry = null;
    String habDtlsQry = null;
    String dcode="",mcode="",pcode="",vcode="",hcode="",tanker_reg_no="";
	
%>
<jsp:useBean id="RWS_USER" scope="session" class="nic.watersoft.commons.RwsUser" />
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="javascript" type="text/javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
<form  name=f1  method="post">
<%
String mode=request.getParameter("mode");
session.setAttribute("mode", mode);
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
     if(isModeChange.equalsIgnoreCase("initial")||isModeChange.equalsIgnoreCase("date")){
   %>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="20%"   style="border-collapse:collapse"  ALIGN=CENTER>
	
	<br>
	<br>
	<tr></tr>
	<tr>
		<td colspan=2 align=center>
			<input type=button id="circ" onclick="fnSubmit()" value="Get Data" class = btext>
		</td>
	</tr>
	</table>
		<table border=0 rules=none style="border-collapse:collapse" align = "right"> 
	</table>
	</caption>
   <table width="45%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr   align=center>
   <%
   if(!fromdate.equals("null") && !fromdate.equals(""))
   {
	   %>
	   <td class="gridhdbg" colspan="17"><b>Tanker Movement Details (From:<font color="red"><%=fromdate %></font> To:<font color="red"><%=todate %></font>)</b></td>
	   <%
   }
   else
   {
	   DateFormat dateFormat=new SimpleDateFormat("MM/yyyy"); 
	   DateFormat dateFormat1=new SimpleDateFormat("dd/MM/yyyy");
       Date date=new  Date();
       String cDate=dateFormat.format(date);
       fromdate="01/"+cDate;
       todate=dateFormat1.format(date);
       //System.out.println("fromdate---"+fromdate);
      // System.out.println("to---"+todate);
   %>
		<td class="gridhdbg" colspan="17"><b>Tanker Movement Details for Current Month</b></td>
		<%} %>
		
		</tr>
       	<%
        session.setAttribute("fromdate", fromdate);
	       session.setAttribute("todate", todate);
       try
		{  
    		%>
    			 <tr>
	<td class=gridhdbg rowspan=1>Sl.No</td>
	<td class=gridhdbg rowspan=1>District</td>
	<td class=gridhdbg colspan=1>Total no of trips(Completed Trips - Disapproved Trips)</td>
   </tr>
   <!-- <tr>
    <td class=gridhdbg rowspan=1>Source</td>
    <td class=gridhdbg rowspan=1>Destination</td>
       </tr> -->
    		<%	
    	int sourceTrips=0,destinationTrips=0;
    	   stmt1=conn.createStatement();
    	   String qry1="";
    	   String val="1";
    	   String userId = "00";
   		String regex = "[0-9]+";
   		if(loggedUser!=null){
   			userId = loggedUser.substring(1,3);
   		    userId.matches(regex);
   		}
   	    if(loggedUser!=null &&  userId.matches(regex) &&  !userId.equals("00")){
   	    	qry1="SELECT dcode,dname from rws_district_tbl where dcode='"+userId+"'";
   	    }else{
   	    	qry1="SELECT dcode,dname from rws_district_tbl    order by dname";
   	    }
    		rst = stmt1.executeQuery(qry1); 
    			while(rst.next())
    			{
    				/* if(rst.getString(1) != null && rst.getString(1).equals("07") || rst.getString(1).equals("09")  || rst.getString(1).equals("11") || rst.getString(1).equals("12") ){
    				str="select count(distinct trip_id) from RWS_TANKER_MOVEMENT_PVT_TBL  where substr(dest_habitation,1,2)='"+rst.getString(1)+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy') ";
    				}else{ */
	  				str="select count(distinct trip_id) from RWS_TANKER_MOVEMENT_TBL  where substr(dest_habitation,1,2)='"+rst.getString(1)+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy')  and (APPROVEL_STATUS <> 'N' or APPROVEL_STATUS is null) and TANKER_TRIP_END_DATE_TIME is not null ";
    				// System.out.println("###   "+str);

    				stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 sourceTrips= rs.getInt(1);
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
    	              
    	             <%if(request.getParameter("rtype")!=null) {%>
    	             
    	             <%if(sourceTrips>0){%>
    	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(2)%></td>
    				 <%}else{ %>
    				     	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(2)%></td>
    				 
    				 <%} %>
    				 <%}else{ %>
    				 <%if(sourceTrips>0){%>
    				 <td class="<%=style%> "style="text-align: left;"><%=rst.getString(2)%></td>
    				 <%}else{ %>
    				    				 <td class="<%=style%> "style="text-align: left;"><%=rst.getString(2)%></td>
    				
    				
    				<%} %>
    				<% } %>
    				 
    				 
    				  
    				  <%if(sourceTrips>0){%>
    				  <td class="<%=style%> "style="text-align: right;"><%=sourceTrips%></td>
    				<%}else{ %>
    				
    				<td class="<%=style%> "style="text-align: right;"><%=sourceTrips%></td>
    				
    				<%} %>
    				
    					</tr>			
    	<%
		}	
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
<%-- <%@ include file = "/commons/rws_footer.jsp" %> --%>
</p>