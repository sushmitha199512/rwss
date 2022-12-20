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

function fnSubmit()
{
	
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
		document.forms[0].action="./rws_tanker_movement_abstract_rpt.jsp?mode=date";
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

<form method="post">
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
	<%
	try
	{
		String dcode = request.getParameter("district");
		String dname="";
	%>
	<tr><td class=gridhdbg>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") ||loggedUser.equals("1000DR")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px">
			<option value="00">ALL</option> 

		<%
			stmt = conn.createStatement();
		//	query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
		query="select distinct dcode,dname from rws_district_tbl a,RWS_GENERIC_COMPLAINTS_REG_TBL b where a.dcode=substr(b.HABITATION_CODE,1,2) order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<%
				}
				}
				rs.close();			
				stmt.close();
				}
		else
		{
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	
	%></SELECT></td></tr>
	
	<tr>
	<td class=gridhdbg>From&nbsp;Date<font color="red">*</font></td>
		<td class=btext>
	<input type="text" name="fromDate" style="width:90" />&nbsp;<a href="javascript: showCalendarFuture(document.getElementById('fromDate'));">
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle"></a>
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>To&nbsp;Date<font color="red">*</font></td>
		<td class=btext>
	<input type="text" name="toDate" style="width:90"  />&nbsp;<a href="javascript: showCalendarFuture(document.getElementById('toDate'));"  >
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle" ></a>
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
	   <td class="gridhdbg" colspan="17"><b>Tanker Movement Details (From:<font color="red"><%=fromdate %></font> To:<font color="red"><%=todate %></font>)</b></td>
	   <%
   }
   else{
	   DateFormat dateFormat=new SimpleDateFormat("MM/yyyy"); 
	   DateFormat dateFormat1=new SimpleDateFormat("dd/MM/yyyy");
       Date date=new  Date();
       String cDate=dateFormat.format(date);
      
       fromdate="01/"+cDate;
       todate=dateFormat1.format(date);
      // System.out.println("fromdate---"+fromdate);
       //System.out.println("to---"+todate);
   %>
		<td class="gridhdbg" colspan="17"><b>Tanker Movement Details for Current Month</b></td>
		<%} %>
		
		</tr>
  
	
       
       	<%
        session.setAttribute("fromdate", fromdate);
	       session.setAttribute("todate", todate);
       
    	   String dt = todate; 
    	   SimpleDateFormat sdf1 = new SimpleDateFormat("dd/mm/yyyy");
    	   Calendar c = Calendar.getInstance();
    	   c.setTime(sdf1.parse(dt));
    	   c.add(Calendar.DATE, 1);  
    	   dt = sdf1.format(c.getTime());  
    	  
    		
    		%>
    			 <tr>
	
	<td class=gridhdbg rowspan=2>Sl.No</td>
	<td class=gridhdbg rowspan=2>District</td>
	
	
	<td class=gridhdbg rowspan=2>No of Mandals</td>
	<td class=gridhdbg rowspan=2>No of Habitations</td>
	
	
	<td class=gridhdbg colspan=2>No. of tanker trips</td>
	
   </tr>
   <tr>
   
    <td class=gridhdbg rowspan=1>Source</td>
    <td class=gridhdbg rowspan=1>Destination</td>
    
   
   
	
       </tr>
    		<%
    		
    		
    		
    	int sourceTrips=0,destinationTrips=0,noMandals=0,noHabs=0;
    	   stmt1=conn.createStatement();
    	   String qry1="";
    	  
   		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")  ||loggedUser.equals("pdswsm") ||loggedUser.equals("cerwss") ||loggedUser.equals("secrwss") ||loggedUser.equals("1000DR") ))
   		{
   	
    		
    		if(dcode==null||dcode.equals("00")||dcode.equals(""))
    		{
    			qry1="select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
    		}
    		else
    		{
    			qry1="select dcode,dname from rws_district_tbl where dcode <> '16' AND dcode = '"+dcode+"' order by dcode";
    		}
    		
   		}
   		else{
   			//System.out.println(loggedUser);
   			qry1="select dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
   			//System.out.println(qry1);
   		}
    		rst = stmt1.executeQuery(qry1); 
    			
    			
    			while(rst.next())
    			{
    				str="select count(trip_id)  from RWS_TANKER_MOVEMENT_TBL  where substr(source_code,1,2)='"+rst.getString(1)+"' and TANKER_TRIP_START_DATE_TIME>=to_date('"+fromdate+"','dd/mm/yyyy') and TANKER_TRIP_START_DATE_TIME<=to_date('"+dt+"','dd/mm/yyyy')";
    				
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				 if(rs.next())
    	    		   {
    					 sourceTrips= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 str="select count(trip_id)  from RWS_TANKER_MOVEMENT_TBL where substr(source_code,1,2)='"+rst.getString(1)+"' and TANKER_TRIP_END_DATE_TIME>=to_date('"+fromdate+"','dd/mm/yyyy') and TANKER_TRIP_END_DATE_TIME<=to_date('"+dt+"','dd/mm/yyyy')";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				// System.out.println("na"+str);
    				 if(rs.next())
    	    		   {
    					 destinationTrips= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				 
    				 str="select count(distinct m.MCODE) from RWS_TANKER_MOVEMENT_TBL t, rws_mandal_tbl m where substr(t.source_code,1,2)='"+rst.getString(1)+"' and TANKER_TRIP_END_DATE_TIME>=to_date('"+fromdate+"','dd/mm/yyyy') and TANKER_TRIP_END_DATE_TIME<=to_date('"+dt+"','dd/mm/yyyy') and substr(t.source_code,6,2)=m.MCODE";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				// System.out.println("na"+str);
    				 if(rs.next())
    	    		   {
    					 noMandals= rs.getInt(1);
    	    		   }
    				 stmt2.close();
    				 rs.close();
    				
    				 str="select count(distinct p.panch_code) from RWS_TANKER_MOVEMENT_TBL t, rws_panchayat_raj_tbl p where substr(t.source_code,1,2)='"+rst.getString(1)+"' and TANKER_TRIP_END_DATE_TIME>=to_date('"+fromdate+"','dd/mm/yyyy') and TANKER_TRIP_END_DATE_TIME<=to_date('"+dt+"','dd/mm/yyyy') and substr(t.source_code,1,16)=p.panch_code";
    				 stmt2=conn.createStatement();
    				 rs=stmt2.executeQuery(str);
    				// System.out.println("na"+str);
    				 if(rs.next())
    	    		   {
    					 noHabs= rs.getInt(1);
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
    	              <td class="<%=style%> "style="text-align: left;"><%=rst.getString(2)%></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="rws_tanker_movement_mandals_rpt.jsp?mode1=mandal&dcode=<%=rst.getString(1)%>&dname=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>"><%=noMandals%></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><a href="rws_tanker_movement_habs_rpt.jsp?mode1=mandal&dcode=<%=rst.getString(1)%>&dname=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>"><%=noHabs%></a></td>
    				  <td class="<%=style%> "style="text-align: right;"><%=sourceTrips%></td>
    				  <td class="<%=style%> "style="text-align: right;"><%=destinationTrips%></td>
    				  
    				  
    					
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
	</table>	
  
  

<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>