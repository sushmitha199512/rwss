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
String fromdate=request.getParameter("fromdate");
session.setAttribute("fromdate",fromdate );
String todate=request.getParameter("todate");
session.setAttribute("todate", todate);
String type=request.getParameter("type");
session.setAttribute("type",type );
PreparedStatement stmt1=null,stmt2=null;
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
   <table width="45%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   
   <%if(mode1.equals("mandal")){ %>
   <tr   align=center>
		<td class="gridhdbg" colspan="17"><b>Transportation<br/> <%-- for District:<font color="red"><%=dname%> </font> --%>Date:-  (From: <font color="red"><%=fromdate %></font> To: <font color="red"><%=todate %></font>)</b></td>

		</tr>
		
		
		
       	<%
   }
       try
		{
    		if(mode1.equals("mandal")){
    		
    		%>
    			 <tr>
	<td class=gridhdbg rowspan=1>Sl.No</td>
	<td class=gridhdbg rowspan=1>District</td>
	<td class=gridhdbg rowspan=1>Division</td>
	<td class=gridhdbg rowspan=1>Sub Division</td>
	<td class=gridhdbg rowspan=1>Mandal</td>
	<td class=gridhdbg colspan=1>Total no  of  Habs </td>
	<td class=gridhdbg colspan=1>Population served </td>
	<td class=gridhdbg colspan=1>Total no of  trips </td>
	<td class=gridhdbg colspan=1>Quantity in KL </td>
	
	<!-- <td class=gridhdbg colspan=1>No. of Tankers
(Maximum
number of
Tankers in a day) </td> -->
	
	
   </tr>
    		<%
    	
    		int sourceTrips_completd=0,sourceTrips_in_completd=0,sourceTrips_disapproved=0,sourceTrips_total=0,destHabs_total=0,total_served_popu=0,total_kl=0;
    	    long sum_habs=0,sum_population=0,sum_trips=0,sum_kl=0;
    		String qry1="SELECT CO.CIRCLE_OFFICE_CODE,M.MCODE,M.MNAME,CO.CIRCLE_OFFICE_NAME,DO.DIVISION_OFFICE_CODE,"+
					"DO.DIVISION_OFFICE_NAME as divname,SDO.SUBDIVISION_OFFICE_CODE,SDO.SUBDIVISION_OFFICE_NAME as sdivname,"+
    		"D.DCODE as districtcode,D.DNAME  as districtname FROM RWS_CIRCLE_OFFICE_TBL CO,RWS_DIVISION_OFFICE_TBL DO,"+
					"RWS_SUBDIVISION_OFFICE_TBL SDO,RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_MANDAL_SUBDIVISION_TBL MS WHERE CO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND CO.HEAD_OFFICE_CODE=1 AND DO.DIVISION_OFFICE_CODE=MS.DIVISION_OFFICE_CODE AND DO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND SDO.SUBDIVISION_OFFICE_CODE=MS.SUBDIVISION_OFFICE_CODE AND SDO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND SDO.DIVISION_OFFICE_CODE=MS.DIVISION_OFFICE_CODE AND D.DCODE=MS.DCODE AND M.MCODE=MS.MCODE AND M.DCODE=MS.DCODE ORDER BY MS.CIRCLE_OFFICE_CODE";
    		
    		stmt1=conn.prepareStatement(qry1);
    		
    		rst = stmt1.executeQuery(); 
    			while(rst.next())
    			{
    				/*
    				select count(DISTINCT a.TRIP_ID),sum(DISTINCT c.ACT_TOT_POPU),count(DISTINCT a.DEST_HABITATION),sum(b.TANKER_CAPACITY_IN_KLTS) from RWS_TANKER_MOVEMENT_TBL a,RWS_TANKER_REG_TBL b,RWS_COMPLETE_HAB_VIEW c where a.TANKER_REG_NO=b.TANKER_REG_NO and a.DEST_HABITATION=c.PANCH_CODE and 
c.DCODE='06' and c.MCODE='50';
    				*/
    		/* str="select SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is  not null and (approvel_status!='N' or approvel_status is null) THEN 1 else 0 END )"+
    				"as completed_trips_count,COUNT(distinct dest_habitation) AS totalhabs from RWS_TANKER_MOVEMENT_TBL  where substr(dest_habitation,1,2)=? and substr(dest_habitation,6,2)=? and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date(?,'dd/mm/yyyy')  and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy') ";
   			
    				 */
    				 
    				 /* str="select count(DISTINCT a.TRIP_ID),count(DISTINCT a.DEST_HABITATION),sum(DISTINCT c.ACT_TOT_POPU),sum(b.TANKER_CAPACITY_IN_KLTS) from RWS_TANKER_MOVEMENT_TBL a,RWS_TANKER_REG_TBL b,RWS_COMPLETE_HAB_VIEW c where a.TANKER_REG_NO=b.TANKER_REG_NO and a.DEST_HABITATION=c.PANCH_CODE and "+
    						 "c.DCODE=? and c.MCODE=? and TANKER_TRIP_END_DATE_TIME is  not null and approvel_status='Y' and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date(?,'dd/mm/yyyy') "+
    						 "and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy')";
    				 */
        str="select count(DISTINCT a.TRIP_ID),count(DISTINCT a.DEST_HABITATION),sum(DISTINCT c.ACT_TOT_POPU),sum(b.TANKER_CAPACITY_IN_KLTS) from RWS_TANKER_MOVEMENT_TBL a,RWS_TANKER_REG_TBL b,RWS_COMPLETE_HAB_VIEW c where a.TANKER_REG_NO=b.TANKER_REG_NO and a.DEST_HABITATION=c.PANCH_CODE and "+
    	    						 "c.DCODE=? and c.MCODE=? and TANKER_TRIP_END_DATE_TIME is  not null and approvel_status!='N' and approvel_status is not null and  to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date(?,'dd/mm/yyyy') "+
    	    						 "and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy')";
    	    				
    			stmt2=conn.prepareStatement(str); 
    			stmt2.setString(1, rst.getString(1));
    			stmt2.setString(2, rst.getString(2));
    			stmt2.setString(3, fromdate);
    			stmt2.setString(4, todate);
   				 rs=stmt2.executeQuery();
   				 if(rs.next())
   	    		   {
   					sourceTrips_total=rs.getInt(1);
   					sum_trips=sum_trips+rs.getInt(1);
   					
   					destHabs_total=rs.getInt(2);
   					sum_habs=sum_habs+rs.getInt(2);
   					total_served_popu=rs.getInt(3);
   					sum_population=sum_population+rs.getInt(3);
   					total_kl=rs.getInt(4);
   					sum_kl=sum_kl+rs.getInt(4);
   	    		   }
   				 stmt2.close();
   				 rs.close(); 
    				 if(styleCount%2==0){
    					 style="gridbg1";
    				 }else{
    					 style="gridbg2";
    				 }
    				 //styleCount++;
    				 
    			   %>
    			   
    			   <%if(sourceTrips_total<=0)
  				 {
  					 continue;
  				 }else{
  					 styleCount++;
  					 %>
    			   
    	              <tr>
    	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
    	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(4)%></td>
    	               <td class="<%=style%> "style="text-align: left;"><%=rst.getString(6)%></td>
    	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(8)%></td>
    	              <%-- <%if(sourceTrips_total>0){%>
    	              <td class="<%=style%> "style="text-align: left;"><a href="rws_tanker_movement_drill_statitics_rpt.jsp?mode1=hab&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=rst.getString(3)%>"><%=rst.getString(3)%></a></td>
    				   <%}else{ %> --%>
    				   
    				       	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(3)%></td>
    				   
    				<%--    <%} %> --%>
    				   
    				     <%if(sourceTrips_total>0){%>
    				     	              <td class="<%=style%> "style="text-align: right;"><a href="rws_tanker_movement_drill_daily_statitics_rpt.jsp?mode1=hab&type=<%=type%>&dname=<%=rst.getString("districtname")%>&divname=<%=rst.getString("divname")%>&sdivname=<%=rst.getString("sdivname")%>&dcode=<%=rst.getString("districtcode")%>&mcode=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=rst.getString(3)%>"><%=destHabs_total%></a></td>
    				 
    				 <%}else{ %> 
    				   
    				       	              <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_total%></td>
    				   
    				 <%} %> 
    				 
    				   <td class="<%=style%> "style="text-align: right;"><%=total_served_popu%></td>
    				   <%--  <%if(sourceTrips_total>0){%>
    	              <td class="<%=style%> "style="text-align: right;"><a href="rws_tanker_movement_drill_daily_statitics_rpt.jsp?mode1=hab&type=<%=type%>&dname=<%=rst.getString("districtname")%>&divname=<%=rst.getString("divname")%>&sdivname=<%=rst.getString("sdivname")%>&dcode=<%=rst.getString("districtcode")%>&mcode=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>&mname=<%=rst.getString(3)%>"><%=sourceTrips_total%></a></td>
    				   <%}else{ %>  --%>
    				   
    				       	              <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_total%></td>
    				   
    				<%--  <%} %>   --%>
    				  <td class="<%=style%> "style="text-align: right;"><%=total_kl%></td>
    				   <%-- <td class="<%=style%> "style="text-align: right;">--</td> --%>
    					</tr>
    					
    					<%} %>
    					
    					
    								
    	<%
		}
    			
    		%>
    		
    		 <tr>
                    <td class="btext" style="text-align: right;" ></td>
                    <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;">Total:</td>
                    <td class="btext" style="text-align: right;"><%=sum_habs%></td>
                    <td class="btext" style="text-align: right;"><%=sum_population%></td>
                    <td class="btext" style="text-align: right;"><%=sum_trips%></td>
                    <td class="btext" style="text-align: right;"><%=sum_kl%></td>
                    <!-- <td class="btext" style="text-align: right;"></td> -->
                                       
                </tr>
    		
    		<%	
    			
    			
    			
    			
    		}
    		else{
    		
    			String mcode=request.getParameter("mcode");
    			String mname=request.getParameter("mname"); 
    			String districtname=request.getParameter("dname");
    			String divname=request.getParameter("divname"); 
    			String sdivname=request.getParameter("sdivname"); 
    			//System.out.println(districtname+"@@@@@@@@@@");
    			session.setAttribute("mcode",mcode );
    			session.setAttribute("mname",mname );
    			
    		%>
    		<tr   align=center>
		<td class="gridhdbg" colspan="17"><b>Transportation  for District:<font color="red"><%=dname%> </font> Division:<font color="red"><%=divname%></font> Sub Division:<font color="red"><%=sdivname%>   </font> Mandal:<font color="red"><%=mname%>   </font> <br/> Date:-  (From: <font color="red"><%=fromdate %></font> To: <font color="red"><%=todate %></font>)</b></td>
		
		
		
		</tr>
    			 <tr>
	    <td class=gridhdbg rowspan="3" colspan="1"> Sl.No</td>
	    <td class=gridhdbg rowspan="3">District</td>
	<td class=gridhdbg rowspan="3">Division</td>
	<td class=gridhdbg rowspan="3">Sub Division</td>
	    <td class=gridhdbg rowspan="3">Mandal</td>
	    	<td class=gridhdbg rowspan="3">Gram Panchayat </td>
	    	<td class=gridhdbg rowspan="3">Habitation </td>
	    <td class=gridhdbg rowspan="3">Habitation Code</td>
		<td class=gridhdbg colspan="3">Transportation</td>
		</tr>
		<tr>
		<td class=gridhdbg rowspan="2"  colspan=1>Population served </td>
		<td class=gridhdbg  colspan="2">Supply details</td>
               </tr> 
               
               <tr>
               <td class=gridhdbg  colspan=1>Total no of  trips </td>
		     <td class=gridhdbg  colspan=1>Quantity in KL </td>
               </tr>
    		<%
    		String fromdateNew=fromdate.replace("/", "-");
    		String todateNew=todate.replace("/", "-");
    		int sourceTrips_completd=0,sourceTrips_in_completd=0,sourceTrips_disapproved=0,sourceTrips_total=0,destHabs_total=0,total_served_popu=0,total_kl=0;
    	    long sum_habs=0,sum_population=0,sum_trips=0,sum_kl=0;
    	  //int sourceTrips_completd=0,sourceTrips_in_completd=0,sourceTrips_disapproved=0,sourceTrips_total=0;
    	  
    	//  String qry1="select panch_code,panch_name,hab_code from rws_panchayat_raj_tbl  where substr(panch_code,1,2)=?  and substr(panch_code,6,2)=? order by panch_name"; 		

    	  String qry1="select panch_code,panch_name,PNAME from RWS_COMPLETE_HAB_VIEW  where substr(panch_code,1,2)=?  and substr(panch_code,6,2)=? order by panch_name"; 		
    		
    	  
    	  
    	  stmt1=conn.prepareStatement(qry1);
    		stmt1.setString(1, dcode);
    		stmt1.setString(2, mcode);
    		rst = stmt1.executeQuery(); 
    			while(rst.next())
    			{
                  str="select count(DISTINCT a.TRIP_ID),count(DISTINCT a.DEST_HABITATION),sum(DISTINCT c.ACT_TOT_POPU),sum(b.TANKER_CAPACITY_IN_KLTS) from RWS_TANKER_MOVEMENT_TBL a,RWS_TANKER_REG_TBL b,RWS_COMPLETE_HAB_VIEW c where a.TANKER_REG_NO=b.TANKER_REG_NO and a.DEST_HABITATION=c.PANCH_CODE and "+
    	    						 "substr(a.dest_habitation,1,2)=? and substr(a.dest_habitation,6,2)=? and substr(a.dest_habitation,1,16)=? and TANKER_TRIP_END_DATE_TIME is  not null and approvel_status!='N' and approvel_status is not null and  to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date(?,'dd/mm/yyyy') "+
    	    						 "and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy')";
      				stmt2=conn.prepareStatement(str);
      				stmt2.setString(1, dcode);
      				stmt2.setString(2, mcode);
      				stmt2.setString(3, rst.getString(1));
      	    		stmt2.setString(4, fromdate);
      	    		stmt2.setString(5, todate);
      				 rs=stmt2.executeQuery();
      				 if(rs.next())
      	    		   {
      					//sourceTrips_completd= rs.getInt(1);
      					sourceTrips_total=rs.getInt(1);
       					sum_trips=sum_trips+rs.getInt(1);
       					
       					destHabs_total=rs.getInt(2);
       					sum_habs=sum_habs+rs.getInt(2);
       					total_served_popu=rs.getInt(3);
       					sum_population=sum_population+rs.getInt(3);
       					total_kl=rs.getInt(4);
       					sum_kl=sum_kl+rs.getInt(4);
      	    		   }
      				 stmt2.close();
      				 rs.close();
      				 
    				 if(styleCount%2==0){
    					 style="gridbg1";
    				 }else{
    					 style="gridbg2";
    				 }
    				 //styleCount++;
    			   %>
    			   <%if(sourceTrips_total<=0)
  				 {
  					 continue;
  				 }else{
  					 styleCount++;
  					 %>
    	              <tr>
    	              <td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
    	              <td class="<%=style%> "style="text-align: left;"><%=dname%></td>
    	              <td class="<%=style%> "style="text-align: left;"><%=divname%></td>
    	              <td class="<%=style%> "style="text-align: left;"><%=sdivname%></td>
    	               <td class="<%=style%> "style="text-align: left;"><%=mname%></td>
    	              
    	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(3)%></td>
    	               <td class="<%=style%> "style="text-align: left;"><%=rst.getString(2)%></td> 
    	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(1)%></td>
    	             
    	              <td class="<%=style%> "style="text-align: right;"><%=total_served_popu%></td>
    	              <td class="<%=style%> "style="text-align: right;"><%=sourceTrips_total%></td>
    	              <td class="<%=style%> "style="text-align: right;"><%=total_kl%></td>
    				  </tr>	
    				  			
    	<%
  		 }
		}	
    			%>
    			 <tr>
    			 <td class="btext" style="text-align: right;" ></td>
                    <td class="btext" style="text-align: right;"></td>
                     <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;" ></td>
                    <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;"></td>
                    <td class="btext" style="text-align: right;">Total:</td>
                   
                    <td class="btext" style="text-align: right;"><%=sum_population%></td>
                    <td class="btext" style="text-align: right;"><%=sum_trips%></td>
                    <td class="btext" style="text-align: right;"><%=sum_kl%></td>
                                     
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