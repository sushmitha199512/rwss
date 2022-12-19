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
session.setAttribute("mode1",mode1 );
String dcode=request.getParameter("dcode");
session.setAttribute("dcode",dcode );
String dname=request.getParameter("dname");
session.setAttribute("dname", dname);

//
String mcode=request.getParameter("mcode");
session.setAttribute("mcode",mcode );
String mname=request.getParameter("mname");
session.setAttribute("mname", mname);
//System.out.println(mcode+"&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"+mname);

//
String fromdate=request.getParameter("fromdate");
session.setAttribute("fromdate",fromdate );
String todate=request.getParameter("todate");
session.setAttribute("todate", todate);
String type=request.getParameter("type");
session.setAttribute("type",type );
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
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </a></td>
	<!-- <td ><a href="javascript:onclick=history.go(-1)">Back  </td> -->
	<% if(mode1.equals("mandal")){ %>
	<td ><a href="rws_tanker_movement_rpt.jsp?mode=initial">Back|&nbsp;</td>
	<td ><a href="rws_tanker_movement_drill_rpt_excel.jsp?mode1=mandal&type=<%=type%>&dcode=<%=dcode%>&dname=<%=dname%>&fromdate=<%=fromdate%>&todate=<%=todate%>"">Excel</td>
	<%}else { 
		
		%>
	<td ><a href="rws_tanker_movement_drill_rpt.jsp?mode1=mandal&type=<%=type%>&dcode=<%=dcode%>&dname=<%=dname%>&fromdate=<%=fromdate%>&todate=<%=todate%>"">Back|&nbsp;</td>
	<td ><a href="rws_tanker_movement_drill_rpt_excel.jsp?mode1=hab&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=dcode%>">Excel</a></td>
	<% } %>
	
	</tr>  
	</table>
	</caption>
	
	<% if(mode1.equals("mandal")){%>
	
   <table width="45%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr   align=center>
		<td class="gridhdbg" colspan="17"><b>Tanker Movement Details for District:<font color="red"><%=dname%> </font><br>(From:<font color="red"><%=fromdate %></font> To:<font color="red"><%=todate %></font>)</b></td>
		</tr>
		
		<%}else{ %>
		<table width="45%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr   align=center>
		<td class="gridhdbg" colspan="17"><b>Tanker Movement Details for District:<font color="red"><%=dname%> </font> Mandal:<font color="red"><%=mname%> </font><br>(From:<font color="red"><%=fromdate %></font> To:<font color="red"><%=todate %></font>)</b></td>
		</tr>
		<%} %>
       	<%
	
       try
		{
    		if(mode1.equals("mandal")){
    		
    		%>
    			 <tr>
	<td class=gridhdbg rowspan=1>Sl.No</td>
	<td class=gridhdbg rowspan=1>Mandal</td>
	<td class=gridhdbg colspan=1>Completed trips</td>
	<td class=gridhdbg colspan=1>Not completed trips </td>
		<td class=gridhdbg colspan=1>Disapproved  trips </td>
		<td class=gridhdbg colspan=1>Total no of  trips(Completed Trips - Disapproved Trips) </td>
   </tr>
    		<%
    		/* String tableName = "";
    		if(dcode != null && dcode.equals("07") || dcode.equals("09") || dcode.equals("11") || dcode.equals("12") ){
    			tableName = "RWS_TANKER_MOVEMENT_PVT_TBL";
    		}else{
    			tableName = "RWS_TANKER_MOVEMENT_TBL";
    		} */
    	int sourceTrips_completd=0,sourceTrips_in_completd=0,sourceTrips_disapproved=0,sourceTrips_total=0;
    	  
			long 	total_sourceTrips_completd=0,
					total_sourceTrips_in_completd=0,
					total_sourceTrips_disapproved= 0,
					total_sourceTrips_total=0;
    		
    		stmt1=conn.createStatement();
    		String qry1="select dcode,mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by mname";
    		rst = stmt1.executeQuery(qry1); 
    			while(rst.next())
    			{
   //str="select count(distinct trip_id)  from "+tableName+"  where substr(dest_habitation,1,2)='"+dcode+"' and substr(dest_habitation,6,2)='"+rst.getString(2)+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy')";

        			str="select SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is  not null and (approvel_status<>'N' or approvel_status is null) THEN 1 else 0 END )as completed_trips_count, SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is  null THEN 1 else 0 END ) notcompleted_trips_count , SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is not null and approvel_status = 'N' THEN 1 ELSE 0 END ) as disapproved_trips_count,SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is  not null  THEN 1 else 0 END ) as Totaltrips from RWS_TANKER_MOVEMENT_TBL  where substr(dest_habitation,1,2)='"+dcode+"' and substr(dest_habitation,6,2)='"+rst.getString(2)+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy')  and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy') ";
                  //System.out.println(str);
   				 stmt2=conn.createStatement();
   				 rs=stmt2.executeQuery(str);
   				 if(rs.next())
   	    		   {
   					sourceTrips_completd= rs.getInt(1);
   					sourceTrips_in_completd= rs.getInt(2);
   					sourceTrips_disapproved= rs.getInt(3);
   					sourceTrips_total=rs.getInt(1) - rs.getInt(3);
   					
   			      total_sourceTrips_completd+=sourceTrips_completd;
   						total_sourceTrips_in_completd+=sourceTrips_in_completd;
   						total_sourceTrips_disapproved+= sourceTrips_disapproved;
   						total_sourceTrips_total+=sourceTrips_total;
   	    		   }
   				 stmt2.close();
   				 rs.close(); 
    				 if(styleCount%2==0){
    					 style="gridbg1";
    				 }else{
    					 style="gridbg2";
    				 }
    				
    				 
    				  if(sourceTrips_total>0) {
    					  styleCount++;
    			   %>
    	              <tr>
    	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
    	            <%-- <td class="<%=style%> "style="text-align: left;"><%=rst.getString(3)%></td> --%>
    	            
    	            <%if(sourceTrips_total>0){%>
   	              <td class="<%=style%> "style="text-align: left;"><a href="rws_tanker_movement_drill_rpt.jsp?mode1=hab&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=rst.getString(3)%>"><%=rst.getString(3)%></a></td>
    				   <%}else{ %>
    				   <td class="<%=style%> "style="text-align: left;"><%=rst.getString(3)%></td> 
    				   
    				   <%} %> 
 
    	              
    				   <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_completd%></td> 
    				   
    				   
    				   
    				   
    				   <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_in_completd%></td> 
    				   
    				  
    				   
    				   
    				   
    				   <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_disapproved%></td> 
    				   
    				 
    				   
    				   
    				   <%if(sourceTrips_total>0){%>
   	              <td class="<%=style%> "style="text-align: right;"><a href="rws_tanker_movement_drill_rpt.jsp?mode1=hab&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=rst.getString(3)%>"><%=sourceTrips_total%></a></td>
    				   <%}else{ %>
    				   <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_total%></td> 
    				   
    				   <%} %> 
    				   
    				    				  
    					</tr>			
    	<%
    	
    				 }
    	
    	
		}
    			%>
    			<tr>
                    
                    <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;">Total:</td>
                    
                    <td class="btext" style="text-align: right;"><%=total_sourceTrips_completd%></td>
                    <td class="btext" style="text-align: right;"><%=total_sourceTrips_in_completd%></td>
                    <td class="btext" style="text-align: right;"><%=total_sourceTrips_disapproved%></td>
                    <td class="btext" style="text-align: right;"><%=total_sourceTrips_total%></td>
                    <!-- <td class="btext" style="text-align: right;"></td> -->
                                       
                </tr>
    			<% 
    		}
    		else{
    		
    			 mcode=request.getParameter("mcode");
    			 mname=request.getParameter("mname");   			
    			session.setAttribute("mcode",mcode );
    			session.setAttribute("mname",mname );
    			request.setAttribute("mcode", mcode);
    			request.setAttribute("mname", mname);
    			
    			//System.out.println(mcode+"%%%%%%%%333333%%%%%%%%%"+mname);

    			
    		%>
    		
    			 <tr>
	
	<td class=gridhdbg rowspan=1>Sl.No</td>
	<td class=gridhdbg rowspan=1>Habitation Code/Habitation Name</td>
	<td class=gridhdbg colspan=1>Completed trips</td>
	<td class=gridhdbg colspan=1>Not completed trips </td>
		<td class=gridhdbg colspan=1>Disapproved  trips </td>
	<td class=gridhdbg colspan=1>Total no of trips(Completed Trips - Disapproved Trips)</td>
   </tr> 
    		<%
    		int sourceTrips_completd=0,sourceTrips_in_completd=0,sourceTrips_disapproved=0,sourceTrips_total=0;
    		
			long	total_sourceTrips_completd= 0,
					total_sourceTrips_in_completd= 0,
					total_sourceTrips_disapproved= 0,
				    total_sourceTrips= 0;
    		//System.out.println(fromdate+"@@@@@@@@@@"+todate);
    		String fromdateNew=fromdate.replace("/", "-");
    		String todateNew=todate.replace("/", "-");
    		
    		//System.out.println(fromdateNew+"@@@@@@@@@@"+todateNew);
    		
    		/* String tableName = "";
    		if(dcode != null && dcode.equals("07") || dcode.equals("09") || dcode.equals("11") || dcode.equals("12") )
    			tableName = "RWS_TANKER_MOVEMENT_PVT_TBL";
    		else
    			tableName = "RWS_TANKER_MOVEMENT_TBL"; */
    	int sourceTrips=0,destinationTrips=0;
    	   stmt1=conn.createStatement();
    	   //String qry1="select panch_code,panch_name from rws_panchayat_raj_tbl  where substr(panch_code,1,2)='"+dcode+"'  and substr(panch_code,6,2)='"+mcode+"' order by panch_code";
    		String qry1="select panch_code,panch_name from rws_panchayat_raj_tbl  where substr(panch_code,1,2)='"+dcode+"'  and substr(panch_code,6,2)='"+mcode+"' order by panch_name";
    		
    		
    		//System.out.println("@@@@@@@@@@ "+qry1);
    		rst = stmt1.executeQuery(qry1); 
    			while(rst.next())
    			{
    				//str="select count(distinct trip_id)  from RWS_TANKER_MOVEMENT_TBL  where substr(source_code,1,16)='"+rst.getString(1)+"' and TANKER_TRIP_START_DATE_TIME between to_date('"+fromdate+"','dd/mm/yyyy') and to_date('"+todate+"','dd/mm/yyyy')+1";
    			/////////str="select count(distinct trip_id)  from "+tableName+"  where substr(dest_habitation,1,16)='"+rst.getString(1)+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy') and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy')";
                           			str="select SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is  not null and (approvel_status<>'N' or approvel_status is null) THEN 1 else 0 END )as completed_trips_count, SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is  null THEN 1 else 0 END ) notcompleted_trips_count , SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is not null and approvel_status = 'N' THEN 1 ELSE 0 END ) as disapproved_trips_count,SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is  not null  THEN 1 else 0 END ) as Totaltrips from RWS_TANKER_MOVEMENT_TBL  where  substr(dest_habitation,1,16)='"+rst.getString(1)+"' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromdate+"','dd/mm/yyyy')  and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+todate+"','dd/mm/yyyy') ";

    				//System.out.println("$$$ "+str);
      				 stmt2=conn.createStatement();
      				 rs=stmt2.executeQuery(str);
      				 if(rs.next())
      	    		   {
      					sourceTrips_completd= rs.getInt(1);
       					sourceTrips_in_completd= rs.getInt(2);
       					sourceTrips_disapproved= rs.getInt(3);
      					 sourceTrips= rs.getInt(1) - rs.getInt(3);
      					total_sourceTrips_completd+= sourceTrips_completd;
      							total_sourceTrips_in_completd+= sourceTrips_in_completd;
      							total_sourceTrips_disapproved+= sourceTrips_disapproved;
      						    total_sourceTrips+= sourceTrips;
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				 
    				 if(styleCount%2==0){
    					 style="gridbg1";
    				 }else{
    					 style="gridbg2";
    				 }
    				
    				 if(sourceTrips>0) {
    					 styleCount++;
    			   %>
    	              <tr>
    	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
    	              
    	              <%if(sourceTrips>0){%>
   	              <td class="<%=style%> "style="text-align: left;"><a href="rws_tanker_movement_detailed_drill.jsp?&status=source&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdateNew%>&todate=<%=todateNew%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>&total=<%=sourceTrips%>"><%=rst.getString(1)%>&nbsp;/&nbsp;<%=rst.getString(2)%></a></td>
    	             <%}else{ %>
    	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(1)%>&nbsp;/&nbsp;<%=rst.getString(2)%></td>
    	             
    	             <%} %>
    	               <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_completd%></td> 
    				   
    				   <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_in_completd%></td> 
    				   
    				   <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_disapproved%></td> 
    				  
    	              <%if(sourceTrips>0){%>
    	              <td class="<%=style%> "style="text-align: right;"><a href="rws_tanker_movement_detailed_drill.jsp?&status=source&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdateNew%>&todate=<%=todateNew%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>&total=<%=sourceTrips%>"> <%=sourceTrips%></a></td>
    	             <%}else{ %>
    	              <td class="<%=style%> "style="text-align: right;"> <%=sourceTrips%></td>
    	             
    	             <%} %>
    	             
    					</tr>				
    	<%
    				 }
		}
    			%>
    			
    			
    			
    		    			<tr>
                    
                    <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;">Total:</td>
                    
                    <td class="btext" style="text-align: right;"><%=total_sourceTrips_completd%></td>
                    <td class="btext" style="text-align: right;"><%=total_sourceTrips_in_completd%></td>
                    <td class="btext" style="text-align: right;"><%=total_sourceTrips_disapproved%></td>
                    <td class="btext" style="text-align: right;"><%=total_sourceTrips%></td>
                    <!-- <td class="btext" style="text-align: right;"></td> -->
                                       
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