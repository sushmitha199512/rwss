<%@page import="java.util.Date"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat.*" %>
<%@ include file="/reports/conn.jsp" %>
<head>
<style>
        .thumbnail{
position: relative;
z-index: 0;
}

.thumbnail:hover{
z-index: 50;
cursor:pointer;
}

.thumbnail span{ /*CSS for enlarged image*/
position:absolute;
left: -9999px;
background-color:#eae9d4;
padding: 10px;
font-family: 'Droid Sans', sans-serif;
font-size:.9em;
text-align: center; 
color: #495a62; 
-webkit-box-shadow: 0 0 20px rgba(0,0,0, .75));
-moz-box-shadow: 0 0 20px rgba(0,0,0, .75);
box-shadow: 0 0 20px rgba(0,0,0, .75);
-webkit-border-radius: 8px; 
-moz-border-radius: 8px; 
border-radius:8px;
}

.thumbnail span img{ 
padding:2px;
background:#ccc;
}

.thumbnail:hover span{ 
top: -280px; 
left: -250px;
width:50px;
height:50px;
}
        </style> 
</head>
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
int counts=0;
	ResultSet rs1=null;
   PreparedStatement ps1=null;
    int slno=0;
    String qry="",qry1="",str="", str1="",qr="";
    int styleCount=0;
    String style="";
    int totalClippings=0;
    String dcode=request.getParameter("dcode");
    session.setAttribute("dcode", dcode);
    //System.out.println("%%%%%%%%%%%%dcode"+dcode);
     String dname=request.getParameter("dname");
    session.setAttribute("dname", dname); 
    //System.out.println("dname"+dname);
    String fromdate=request.getParameter("fromdate");
    
    session.setAttribute("fromdate", fromdate);
   // System.out.println("fromdate"+fromdate);
    String todate=request.getParameter("todate");
    
    session.setAttribute("todate", todate);
  //  System.out.println("todate"+todate);
    /* String status=request.getParameter("status");
    session.setAttribute("status", status); */
   // System.out.println("status"+status);
	String mcode=request.getParameter("mcode");
	session.setAttribute("mcode", mcode);
	
	String habcode=request.getParameter("habcode");
	session.setAttribute("habcode", habcode);
	String habName=request.getParameter("habname");
	session.setAttribute("habname", habName);
	/*   System.out.println("mcode"+mcode); */
	/* String mname=request.getParameter("mname");
	session.setAttribute("mname", mname); */
	
    /* String type=request.getParameter("type");
    session.setAttribute("type",type ); */

    /* String panchname=request.getParameter("panchname");
    session.setAttribute("panchname",panchname ); */
    
   /*  String villagename=request.getParameter("villagename");
    session.setAttribute("villagename",villagename ); */
    
	String trip_id="";

	 /* String dt = todate; 
    	   SimpleDateFormat sdf1 = new SimpleDateFormat("dd/mm/yyyy");
    	   Calendar c = Calendar.getInstance();
    	   c.setTime(sdf1.parse(dt));
    	   c.add(Calendar.DATE, 1);  
    	   dt = sdf1.format(c.getTime());   */
    

   	%>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<tr align="center">
		</tr></table>
		<table border=0 rules=none style="border-collapse:collapse" align = "right">

	<tr align="right">
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back  |</td> 
	<td ><a href="rws_tanker_movement_detailed_statistics_drill_excel.jsp?&status=source&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdate%>&todate=<%=todate%>&habcode=<%=habcode%>&habname=<%=habName%>">Excel  </td> 
		<%-- <td ><a href="./habitation_wise_components_list_excel.jsp?id=<%=id%>&scode=<%=scode%>&ccode=<%=circle_code%>&districtName=<%=districtName%>&mandName=<%=mandName%>&divcode=<%=div_code%>&subdivcode=<%=sub_div_code%>">Excel </td> --%>
	
	
<%-- 	 <td class="<%=style%> "style="text-align: left;"><a href="rws_tanker_movement_detailed_statistics_drill.jsp?&status=source&type=<%=type%>&dname=<%=dname%>&dcode=<%=dcode%>&mcode=<%=mcode%>&fromdate=<%=fromdateNew%>&todate=<%=todateNew%>&mname=<%=mname%>&habcode=<%=rst.getString(1)%>&habname=<%=rst.getString(2)%>"><%=rst.getString(1)%>&nbsp;/&nbsp;<%=rst.getString(2)%></a></td>
 --%>	</tr>  
	</table>
	</table>
	</caption>

   <table width="50%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center>
		<td class="gridhdbg" colspan="30"><b>Tanker Movement Details for District:<%=dname%> and Habitaion:<%=habcode%>/<%=habName %> (From:<%=fromdate %> To:<%=todate %>)</b></td>
		</tr>
  
	 <tr>
	<td class=gridhdbg >Sl.No</td>
	<td class=gridhdbg >Habitation Code/Habitation Name</td>
	<td class=gridhdbg >Trip date</td>
	<td class=gridhdbg >Tanker Reg. No.</td>
	<td class=gridhdbg >Completed trips</td>
	<td class=gridhdbg >Not completed trips </td>
		<td class=gridhdbg >Disapproved  trips </td>
    <td class=gridhdbg >No of trips</td>
       </tr>
       	<%
       try
		{	
    	   /*  str="select  TANKER_REG_NO,count(distinct trip_id) as no_of_trips,nvl(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'--')   from"+
       " RWS_TANKER_MOVEMENT_TBL   where "+
            		  " dest_habitation=?   "+
            		  " and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >="+ 
            		  " to_date(?,'dd/mm/yyyy') and "+
            		  " to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy') group by TANKER_REG_NO,TANKER_TRIP_START_DATE_TIME "+
            		   "order by tanker_reg_no,TANKER_TRIP_START_DATE_TIME desc"; */
	  
            		 //  str="    select  TANKER_REG_NO,count(TANKER_REG_NO) as no_of_trips,to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy')   from RWS_TANKER_MOVEMENT_TBL   where  dest_habitation=?    and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >= to_date(?,'dd/mm/yyyy') and  to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy') group by TANKER_REG_NO,to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy') order by tanker_reg_no,to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy') desc";
            		 str="    select  TANKER_REG_NO,count(TANKER_REG_NO) as no_of_trips,to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is  not null and (approvel_status!='N' or approvel_status is null) THEN 1 else 0 END )as completed_trips_count, SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is  null THEN 1 else 0 END ) notcompleted_trips_count , SUM(CASE WHEN TANKER_TRIP_END_DATE_TIME is not null and approvel_status = 'N' THEN 1 ELSE 0 END ) as disapproved_trips_count    from RWS_TANKER_MOVEMENT_TBL   where  dest_habitation=?    and to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') >= to_date(?,'dd/mm/yyyy') and  to_date(to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date(?,'dd/mm/yyyy') group by TANKER_REG_NO,to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy') order by tanker_reg_no,to_char(TANKER_TRIP_START_DATE_TIME,'dd/mm/yyyy') desc";
            		   
            		   ps=conn.prepareStatement(str);
	   
	   //System.out.println("@@@@@@     "+str);
	   
	   ps.setString(1, habcode);
	   ps.setString(2, fromdate);
	   ps.setString(3,todate );
		 rs=ps.executeQuery();
		 if (!rs.isBeforeFirst() ) {    
			    %> 
			    
			    <table>
			    <tr><td><h1>No data found</h1></td></tr>
			    </table>
			<%}

		 while(rs.next())
	   {
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			
			 styleCount++;
			 
			 counts+=rs.getInt(2);
			 
			   %>
			 <tr>
			<td class="<%=style%> "style="text-align: center;"><%=++slno%></td>
			<td class="<%=style%> "style="text-align: center;"><%=habcode%>/<%=habName %></td>
			<td class="<%=style%> "style="text-align: right;"><%=rs.getString(3)%></td>
			<td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_tanker_movement_drill1_rpt.jsp?status=tanker&regno=<%=rs.getString(1)%>')"><%=rs.getString(1)%></a></td> 
			<td class="<%=style%> "style="text-align: right;"><%=rs.getInt(4)%></td>
			<td class="<%=style%> "style="text-align: right;"><%=rs.getString(5)%></td>
			<td class="<%=style%> "style="text-align: right;"><%=rs.getString(6)%></td> 
			<td class="<%=style%> "style="text-align: right;"><a href="rws_tanker_movement_detailed_drill_dist_det_statistics_rpt.jsp?status=tanker&habitation=<%=habcode%>&fromDate=<%=fromdate%>&toDate=<%=todate%>&district=<%=dcode%>&hName=<%=habName%>&actdate=<%=rs.getString(3)%>&tankerregno=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></td> 
<%-- 						<td class="<%=style%> "style="text-align: right;"><a href="#" onclick="viewWorks('rws_tanker_movement_detailed_drill_dist_det_statistics_rpt.jsp?status=tanker&habitation=<%=habcode%>&fromDate=<%=fromdate%>&toDate=<%=todate%>&district=<%=dcode%>&hName=<%=habName%>&actdate=<%=rs.getString(3)%>&tankerregno=<%=rs.getString(1)%>')"><%=rs.getString(2)%></a></td> 
 --%>			
			
			
			
<%-- 			 <td class="<%=style%> "style="text-align: right;"><%=rs.getString(2)%></td>
 --%>				</tr>	
					<% 
					
		}%>
		<%--  <tr>
			<td   style="text-align: right;" style="font-weight:bold">TOTAL</td>
			<td   style="text-align: right;"></td>
			<td   style="text-align: right;"></td>
			<td   style="text-align: right;" style="font-weight:bold"><%=counts%></td>
			</tr> --%>
		 
		 <% 
		 
		 rs.close();	 	    
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