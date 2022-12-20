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
	//System.out.println("loddeduser"+loggedUser.substring(0,4));
	String qry3="";
	String distDtlsQry = null;
    String mndDtlsQry = null;
    String panchDtlsQry = null;
    String villageDtlsQry = null;
    String habDtlsQry = null;
    String dcode="",mcode="",pcode="",vcode="",hcode="",tanker_reg_no="";
	
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
function isFutureDate(idate){
    var today = new Date().getTime(),
        idate = idate.split("-");
        idate = new Date(idate[2], idate[1] - 1, idate[0]).getTime();
       return (today - idate) < 0;
}
function fnSubmit()
{
	var frmdate=document.getElementById("fromDate").value;
	var todate=document.getElementById("toDate").value;
	if(document.getElementById("fromDate").value=='')
		{
		alert("please Select From Date");
		return false;
		}
	else if(document.getElementById("toDate").value=='')
		{
		alert("please Select To Date");
		return false;
		}
	else
		{
		 var res = frmdate.split("-", 3);
		 var fnfrmdate=res[1]+"/"+res[0]+"/"+res[2];
		 var res1 = todate.split("-", 3);
		 var fntodate=res1[1]+"/"+res1[0]+"/"+res1[2];
		 var date1 = new Date(fnfrmdate); 
		 var date2 = new Date(fntodate); 
		 // To calculate the time difference of two dates 
		 var Difference_In_Timed = date2.getTime() - date1.getTime(); 
		 // To calculate the no. of days between two dates 
		 var Difference_In_Days = Difference_In_Timed / (1000 * 3600 * 24); 
		 //To display the final no. of days (result) 
		 //alert("Total number of days between dates  <br>"+ date1 + "<br> and <br>" + date2 + " is: <br> " + Difference_In_Days); 
		 var today = new Date();
         var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
           var datef1 = new Date(frmdate); 
          var datef2 = new Date(date); 
           // To calculate the time difference of two dates 
           var Difference_In_Timec = datef1.getTime() - datef2.getTime(); 
           // To calculate the no. of days between two dates 
         var Difference_In_Daysf1 = Difference_In_Timec / (1000 * 3600 * 24);
         var datef3 = new Date(todate); 
         //alert("todate"+todate);
         //alert("date"+date);
   
         // To calculate the time difference of two dates 
            var Difference_In_Timea = datef3.getTime() - datef2.getTime(); 
   
             // To calculate the no. of days between two dates 
          var Difference_In_Daysf2 = Difference_In_Timea / (1000 * 3600 * 24);
 
             //alert(Difference_In_Daysf2);
		        from = new Date(frmdate);
		          to = new Date(todate);  
		           if(from > to)
			{
			alert("from date is not greater than todate.");
			}
		else{	    	    	
 if(!isFutureDate(frmdate))
 {
 	if(!isFutureDate(todate)){	
    if(Number(Difference_In_Days) <= 30){
	    document.forms[0].fromDate.value=frmdate;
		document.forms[0].toDate.value=todate;
		document.forms[0].action="./rws_tanker_movement_rpt.jsp?mode=date";
		document.forms[0].submit();
 }
    else
 	{
 	alert("Please select dates between one month.");
 	}
 
 	}else
 	{
 	alert("To Date Cannot be greater than current date.");
 	}
    }
    else
	{
	alert("From Date Cannot be greater than current date.");
	}   	
		
	}
	}
}
function fnSubmitAbs()
{
	var frmdate=document.getElementById("fromDate").value;
	var todate=document.getElementById("toDate").value;
	document.forms[0].fromDate.value=frmdate;
	document.forms[0].toDate.value=todate;
	document.forms[0].action="./rws_tanker_movement_rpt.jsp?mode=initial";
	document.forms[0].submit();
}
function fnSubmitDet()
{
	var frmdate=document.getElementById("fromDate").value;
	var todate=document.getElementById("toDate").value;
	document.forms[0].fromDate.value=frmdate;
	document.forms[0].toDate.value=todate;
	document.forms[0].action="./rws_tanker_movement_rpt.jsp?mode=det";
	document.forms[0].submit();	
}
function fnSubmitTank()
{
	var frmdate=document.getElementById("fromDate").value;
	var todate=document.getElementById("toDate").value;
	document.forms[0].fromDate.value=frmdate;
	document.forms[0].toDate.value=todate;
	document.forms[0].action="./rws_tanker_movement_rpt.jsp?mode=tanker";
	document.forms[0].submit();	
}





function fnSubmitDetailsTnk()
{
	var frmdate=document.getElementById("fromDate1").value;
	var todate=document.getElementById("toDate1").value;
    var distCode=document.getElementById("districts").value;
    var dname = document.f1.districts.options[document.f1.districts.options.selectedIndex].text;
    var mandCode=document.getElementById("mandals").value;
    var mname = document.f1.mandals.options[document.f1.mandals.options.selectedIndex].text;
    var panchCode=document.getElementById("panchayats").value;
    var pname = document.f1.panchayats.options[document.f1.panchayats.options.selectedIndex].text;
    var villCode=document.getElementById("tanker").value;
    var vname = document.f1.tanker.options[document.f1.tanker.options.selectedIndex].text;
    /* var habCode=document.getElementById("habitation").value;
    var hname = document.f1.habitation.options[document.f1.habitation.options.selectedIndex].text; */
	if(document.f1.districts.selectedIndex=="")
    {
	   alert("SELECT DISTRICT...");		
	   return false;
    }
	 if(document.f1.mandals.selectedIndex=="")
	{
		alert("SELECT Mandal...");		
		return false;
	}
	 if(document.f1.panchayats.selectedIndex=="")
		{
			alert("SELECT Panchayat...");		
			return false;
		}
	 if(document.f1.tanker.selectedIndex=="")
		{
			alert("SELECT Tanker...");		
			return false;
		}
	 if(!document.getElementById("fromDate1").value=='')
	{
		 if(document.getElementById("toDate1").value=='')
			{
			alert("please Select To Date");
			return false;
			} 
	}
 if(!document.getElementById("toDate1").value=='')
	{
	 if(document.getElementById("fromDate1").value=='')
		{
		alert("please Select From Date");
		return false;
		}
	} 
 var res = frmdate.split("-", 3);
 var fnfrmdate=res[1]+"/"+res[0]+"/"+res[2];
 var res1 = todate.split("-", 3);
 var fntodate=res1[1]+"/"+res1[0]+"/"+res1[2];
 var date1 = new Date(fnfrmdate); 
 var date2 = new Date(fntodate); 
 // To calculate the time difference of two dates 
 var Difference_In_Timea = date2.getTime() - date1.getTime(); 
 // To calculate the no. of days between two dates 
 var Difference_In_Days = Difference_In_Timea / (1000 * 3600 * 24); 
 var today = new Date();
 var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
 var datef1 = new Date(frmdate); 
 var datef2 = new Date(date); 
 // To calculate the time difference of two dates 
 var Difference_In_Timeb = datef1.getTime() - datef2.getTime(); 
 // To calculate the no. of days between two dates 
 var Difference_In_Daysf1 = Difference_In_Timeb / (1000 * 3600 * 24);
 var datef3 = new Date(todate); 
 // To calculate the time difference of two dates 
 var Difference_In_Timec = datef3.getTime() - datef2.getTime(); 
 // To calculate the no. of days between two dates 
 var Difference_In_Daysf2 = Difference_In_Timec / (1000 * 3600 * 24);    
         from = new Date(frmdate);
          to = new Date(todate);
    if(from > to)
	{
	
	alert("from date is not greater than todate.");
	}
    else
    {
    	document.f1.action="./rws_tanker_movement_detailed_drill_dist_tanker.jsp";
	     document.f1.submit();
    /* if(!isFutureDate(frmdate))
    {
 	if(!isFutureDate(todate))
 	{
    if(Number(Difference_In_Days) <= 30)
    {
    	 document.f1.action="./rws_tanker_movement_detailed_drill_dist_tanker.jsp";
	     document.f1.submit();
    }
    else
    {
          alert("Please select dates between one month...");
    }
    }
 	else
    {
          alert("To Date Cannot be greater than current date.");
    }
    }
    else
	{
	       alert("From Date Cannot be greater than current date.");
	} */	
	
}	
}







function fnSubmitDetails()
{
	var frmdate=document.getElementById("fromDate").value;
	var todate=document.getElementById("toDate").value;
    var distCode=document.getElementById("district").value;
    var dname = document.f1.district.options[document.f1.district.options.selectedIndex].text;
    var mandCode=document.getElementById("mandal").value;
    var mname = document.f1.mandal.options[document.f1.mandal.options.selectedIndex].text;
    var panchCode=document.getElementById("panchayat").value;
    var pname = document.f1.panchayat.options[document.f1.panchayat.options.selectedIndex].text;
    var villCode=document.getElementById("village").value;
    var vname = document.f1.village.options[document.f1.village.options.selectedIndex].text;
    var habCode=document.getElementById("habitation").value;
    var hname = document.f1.habitation.options[document.f1.habitation.options.selectedIndex].text;
	if(document.f1.district.selectedIndex=="")
    {
	   alert("SELECT DISTRICT...");		
	   return false;
    }
	 if(document.f1.mandal.selectedIndex=="")
	{
		alert("SELECT Mandal...");		
		return false;
	}
	 if(document.getElementById("fromDate").value=='')
	{
	    alert("please Select From Date");
	    return false;
	}
 if(document.getElementById("toDate").value=='')
	{
	alert("please Select To Date");
	return false;
	} 
 var res = frmdate.split("-", 3);
 var fnfrmdate=res[1]+"/"+res[0]+"/"+res[2];
 var res1 = todate.split("-", 3);
 var fntodate=res1[1]+"/"+res1[0]+"/"+res1[2];
 var date1 = new Date(fnfrmdate); 
 var date2 = new Date(fntodate); 
 // To calculate the time difference of two dates 
 var Difference_In_Timea = date2.getTime() - date1.getTime(); 
 // To calculate the no. of days between two dates 
 var Difference_In_Days = Difference_In_Timea / (1000 * 3600 * 24); 
 var today = new Date();
 var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
 var datef1 = new Date(frmdate); 
 var datef2 = new Date(date); 
 // To calculate the time difference of two dates 
 var Difference_In_Timeb = datef1.getTime() - datef2.getTime(); 
 // To calculate the no. of days between two dates 
 var Difference_In_Daysf1 = Difference_In_Timeb / (1000 * 3600 * 24);
 var datef3 = new Date(todate); 
 // To calculate the time difference of two dates 
 var Difference_In_Timec = datef3.getTime() - datef2.getTime(); 
 // To calculate the no. of days between two dates 
 var Difference_In_Daysf2 = Difference_In_Timec / (1000 * 3600 * 24);    
         from = new Date(frmdate);
          to = new Date(todate);
    if(from > to)
	{
	
	alert("from date is not greater than todate.");
	}
    else
    {
    if(!isFutureDate(frmdate))
    {
 	if(!isFutureDate(todate))
 	{
    if(Number(Difference_In_Days) <= 30)
    {
    	 document.f1.action="./rws_tanker_movement_detailed_drill_dist_det.jsp";
	     document.f1.submit();
    }
    else
    {
          alert("Please select dates between one month...");
    }
    }
 	else
    {
          alert("To Date Cannot be greater than current date.");
    }
    }
    else
	{
	       alert("From Date Cannot be greater than current date.");
	}	
	
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
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" colspan=3 class=btext>
		<!--  <INPUT TYPE="radio" name="command" value="0"/>Run
        <INPUT TYPE="radio" NAME="command" VALUE="1"/>Walk-->
        <input type="radio" value="1" name="rtype" checked onclick="fnSubmitAbs()" >Abstract
        <input type="radio" value="2" name="rtype" onclick="fnSubmitDet()">Detailed Report
        <input type="radio" value="3" name="rtype" onclick="fnSubmitTank()">Tanker Wise 
			<!--  <input type="radio" name="reptype" id="con" value="con" onclick="checkFirstRadiobuttonSatus();"/>Only 
            <input type="radio" name="reptype" id="det" value="det" onclick="checkSecondRadiobuttonSatus();"/>All-->
		</td>
	</tr>
	<% if(isModeChange.equalsIgnoreCase("initial")){ %>
	
	 <tr>
	<td class=gridhdbg>From&nbsp;Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="fromDate" id="fromDate" style="width:90" />
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>To&nbsp;Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="toDate" id="toDate" style="width:90"  />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr> 
	<%}else{ %>
		<tr>
	<td class=gridhdbg>From&nbsp;Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="fromDate" id="fromDate" style="width:90" <%if(request.getParameter("fromDate")!= null) {%>
		value='<%=request.getParameter("fromDate") %>' 
		<%}else{ %>value=''<%} %> />
		
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>To&nbsp;Date<font color="red">*</font></td>
	
	<td class=btext>
		<input type="text" name="toDate" id="toDate" style="width:90"  
		<%if(request.getParameter("toDate")!= null) {%>
		value='<%=request.getParameter("toDate") %>' 
		<%}else{ %>value=''<%} %> />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<%} %>
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
		
			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home &nbsp; </td>
	<!-- <td ><a href="javascript:onclick=history.go(-1)">Back  </td> -->
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
       try
		{  
    		%>
    			 <tr>
	<td class=gridhdbg rowspan=1>Sl.No</td>
	<td class=gridhdbg rowspan=1>District</td>
	<td class=gridhdbg colspan=1>No. of trips</td>
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
   		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")  ||loggedUser.equals("pdswsm") ||loggedUser.equals("cerwss") ||loggedUser.equals("secrwss") ||loggedUser.equals("1000DR")||loggedUser.substring(0,4).equals("col_") ||loggedUser.equals("minrwss") ))
   		{
   	
    		qry1="select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
    		
   		}
   		else{
   			qry1="select dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
   		}
    		rst = stmt1.executeQuery(qry1); 
    			while(rst.next())
    			{
    				str="select count(distinct trip_id) from RWS_TANKER_MOVEMENT_TBL  where substr(source_code,1,2)='"+rst.getString(1)+"' and TANKER_TRIP_START_DATE_TIME>=to_date('"+fromdate+"','dd/mm/yyyy') and TANKER_TRIP_START_DATE_TIME<=to_date('"+todate+"','dd/mm/yyyy')+1";
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
    	             
    	              <td class="<%=style%> "style="text-align: left;"><a href="rws_tanker_movement_drill_rpt.jsp?mode1=mandal&type=<%=request.getParameter("rtype")%>&dcode=<%=rst.getString(1)%>&dname=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>"><%=rst.getString(2)%></a></td>
    				 
    				 <%}else{ %>
    				 <td class="<%=style%> "style="text-align: left;"><a href="rws_tanker_movement_drill_rpt.jsp?mode1=mandal&type=<%=val%>&dcode=<%=rst.getString(1)%>&dname=<%=rst.getString(2)%>&fromdate=<%=fromdate%>&todate=<%=todate%>"><%=rst.getString(2)%></a></td>
    				<% } %>
    				 
    				  <td class="<%=style%> "style="text-align: right;"><%=sourceTrips%></td>
    				
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
<%}else if(isModeChange.equalsIgnoreCase("det")){ %>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
				<tr><td align="right" class="bwborder"></td> 
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3> Tanker Movement - Detailed Report</td>	
	</tr>
	<%
try
{ 
	 dcode = request.getParameter("district");
	 mcode = request.getParameter("mandal");
	 pcode = request.getParameter("panchayat");
	 vcode = request.getParameter("village");
	 hcode = request.getParameter("habitation");
	 
	%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" colspan=3 class=btext>
        <input type="radio" value="1" name="rtype"  onclick="fnSubmitAbs()" >Abstract
        <input type="radio" value="2" name="rtype" checked onclick="fnSubmitDet()">Detailed Report
         <input type="radio" value="3" name="rtype"  onclick="fnSubmitTank()">Tanker Wise 
			
		</td>
	</tr>
<%-- <tr><td class=rptLabel>District <font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
    <%
			stmt = conn.createStatement();
    		distDtlsQry="SELECT dcode,dname from rws_district_tbl    order by dname";
			rs = stmt.executeQuery(distDtlsQry);
			while(rs.next())
			{
				//System.out.println("rs.getString(1) :"+dcode);
			     		if(rs.getString(1).equals(dcode))
						{
			%>
							 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
							
			<%
			            session.setAttribute("dName",rs.getString(2));
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
	%>
		</tr> --%>      
		<%-- <tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")  ||loggedUser.equals("pdswsm") ||loggedUser.equals("cerwss") ||loggedUser.equals("secrwss") ))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dcode";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				
				<%
				 session.setAttribute("dName",rs.getString(2));
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
	%></tr>  --%>
	 <tr><td class=rptLabel>District <font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
    <%
   // System.out.println("mode in det :"+mode);
			stmt = conn.createStatement();
    
    
    if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")  ||loggedUser.equals("pdswsm") ||loggedUser.equals("cerwss") ||loggedUser.equals("secrwss") ))
	{
    	
    		distDtlsQry="SELECT dcode,dname from rws_district_tbl    order by dname";
	}
    else
	{
		distDtlsQry="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
	}
			rs = stmt.executeQuery(distDtlsQry);
			while(rs.next())
			{
				//System.out.println("rs.getString(1) :"+dcode);
			     		if(rs.getString(1).equals(dcode))
						{
			     			
			%>
							 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
			
							
			<%          // session.setAttribute("dcode",rs.getString(1));
			
			         //request.setAttribute("dname", rs.getString(2));
			            session.setAttribute("dName",rs.getString(2));
			            session.removeAttribute("mName");
			            session.removeAttribute("pName");
			            session.removeAttribute("vName");
			            session.removeAttribute("hName");
			
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
	%>
		</tr>   
				<tr><td class=rptLabel>Mandal <font color="red">*</font></td>
		<td class=btext>
		
		<SELECT name="mandal"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()" >
			<option value="0">-Select-</option>
		   
    <%
			stmt = conn.createStatement();
                mndDtlsQry="SELECT MCODE, MNAME FROM RWS_MANDAL_TBL WHERE DCODE='"+dcode+ "'   ORDER BY MNAME";
			rs = stmt.executeQuery(mndDtlsQry);
			while(rs.next())
			{
	        if(rs.getString(1).equals(mcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>		  
	<%
	            session.setAttribute("mName",rs.getString(2));
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
	%>
	
	</td>
		</tr>
		<tr><td class=rptLabel>Panchayat</td>
		<td class=btext>
		
		<SELECT name="panchayat"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
		    	
    <%
			stmt = conn.createStatement();
    panchDtlsQry="SELECT PCODE, PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE='"+dcode+ "' AND MCODE='"+mcode+ "'  ORDER BY PNAME";
			rs = stmt.executeQuery(panchDtlsQry);
			while(rs.next())
			{
				
	     if(rs.getString(1).equals(pcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
	<%
	session.setAttribute("pName",rs.getString(2));	
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
	%>
	
	</td>
		</tr>
		
		<tr><td class=rptLabel>Village</td>
		<td class=btext>
		<SELECT name="village"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()" 
		
		>
			<option value="0">-Select-</option>
		    
    <%
			stmt = conn.createStatement();
    villageDtlsQry="SELECT VCODE, VNAME FROM RWS_VILLAGE_TBL WHERE DCODE='"+dcode+ "' AND MCODE='"+mcode+ "' AND PCODE='"+pcode+ "' ORDER BY VNAME";
			rs = stmt.executeQuery(villageDtlsQry);
			while(rs.next())
			{
				
	           if(rs.getString(1).equals(vcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
	<%
	session.setAttribute("vName",rs.getString(2));
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
	%>
	
	</td>
		</tr>
		<tr><td class=rptLabel>Habitation</td>
		<td class=btext>
		<SELECT name="habitation"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
		    
    <%
			stmt = conn.createStatement();
            habDtlsQry="SELECT PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE SUBSTR(HAB_CODE,1,2)='"+dcode+ "'  AND SUBSTR(HAB_CODE,6,2)='"+mcode+ "' AND SUBSTR(HAB_CODE,13,2)= '"+pcode+ "' AND SUBSTR(HAB_CODE,8,3)= '"+vcode+ "'  ORDER BY PANCH_NAME";
			rs = stmt.executeQuery(habDtlsQry);
			while(rs.next())
			{
				
	          if(rs.getString(1).equals(hcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
	<%
	session.setAttribute("hName",rs.getString(2));	
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
	%>
	
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>From&nbsp;Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="fromDate" id="fromDate" style="width:90" <%if(request.getParameter("fromDate")!= null) {%>
		value='<%=request.getParameter("fromDate") %>' 
		<%}else{ %>value=''<%} %> />
		
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>To&nbsp;Date<font color="red">*</font></td>
	<td class=btext>
		<input type="text" name="toDate" id="toDate" style="width:90"  
		<%if(request.getParameter("toDate")!= null) {%>
		value='<%=request.getParameter("toDate") %>' 
		<%}else{ %>value=''<%} %> />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<TR>	
<TD colspan=2 align=center valign=top>
<tr>
		<td colspan=2 align=center>
		<input type=button id="dist" onclick="fnSubmitDetails()" value="Get Data" class = btext></td>
	</tr>
</TD>
</TR>	
	<%	
}
	catch(Exception e)
		{
 System.out.println("Exception in tanker moving Report frm jsp:"+e);
        }
    %>
</table>


<%}else{ %>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
				<tr><td align="right" class="bwborder"></td> 
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3> Tanker Movement - Tanker Wise Detailed Report</td>	
	</tr>
	<%
try
{ 
	 dcode = request.getParameter("districts");
	 mcode = request.getParameter("mandals");
	 pcode = request.getParameter("panchayats");
	// vcode = request.getParameter("village");
	// hcode = request.getParameter("habitation");
	tanker_reg_no = request.getParameter("tanker");
	%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" colspan=3 class=btext>
        <input type="radio" value="1" name="rtype"  onclick="fnSubmitAbs()" >Abstract
        <input type="radio" value="2" name="rtype"  onclick="fnSubmitDet()">Detailed Report
        <input type="radio" value="3" name="rtype" checked onclick="fnSubmitTank()">Tanker Wise 
			
		</td>
	</tr>
<%-- <tr><td class=rptLabel>District <font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
    <%
			stmt = conn.createStatement();
    		distDtlsQry="SELECT dcode,dname from rws_district_tbl    order by dname";
			rs = stmt.executeQuery(distDtlsQry);
			while(rs.next())
			{
				//System.out.println("rs.getString(1) :"+dcode);
			     		if(rs.getString(1).equals(dcode))
						{
			%>
							 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
							
			<%
			            session.setAttribute("dName",rs.getString(2));
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
	%>
		</tr> --%>      
		<%-- <tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")  ||loggedUser.equals("pdswsm") ||loggedUser.equals("cerwss") ||loggedUser.equals("secrwss") ))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dcode";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				
				<%
				 session.setAttribute("dName",rs.getString(2));
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
	%></tr>  --%>
	 <tr><td class=rptLabel>District <font color="red">*</font></td>
		<td class=btext>
			<SELECT name="districts" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
    <%
			stmt = conn.createStatement();
    
    
    if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")  ||loggedUser.equals("pdswsm") ||loggedUser.equals("cerwss") ||loggedUser.equals("secrwss") ))
	{
    	
    		distDtlsQry="SELECT dcode,dname from rws_district_tbl    order by dname";
	}
    else
	{
		distDtlsQry="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
	}
			rs = stmt.executeQuery(distDtlsQry);
			while(rs.next())
			{
				//System.out.println("rs.getString(1) :"+dcode);
			     		if(rs.getString(1).equals(dcode))
						{
			     			
			%>
							 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
			
							
			<%          // session.setAttribute("dcode",rs.getString(1));
			
			         //request.setAttribute("dname", rs.getString(2));
			            session.setAttribute("dName",rs.getString(2));
			            session.removeAttribute("mName");
			            session.removeAttribute("pName");
			            session.removeAttribute("vName");
			            session.removeAttribute("hName");
			
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
	%>
		</tr>   
				<tr><td class=rptLabel>Mandal <font color="red">*</font></td>
		<td class=btext>
		
		<SELECT name="mandals"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()" >
			<option value="0">-Select-</option>
		   
    <%
			stmt = conn.createStatement();
                mndDtlsQry="SELECT MCODE, MNAME FROM RWS_MANDAL_TBL WHERE DCODE='"+dcode+ "'   ORDER BY MNAME";
			rs = stmt.executeQuery(mndDtlsQry);
			while(rs.next())
			{
	        if(rs.getString(1).equals(mcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>		  
	<%
	            session.setAttribute("mName",rs.getString(2));
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
	%>
	
	</td>
		</tr>
		<tr><td class=rptLabel>Panchayat<font color="red">*</font></td>
		<td class=btext>
		
		<SELECT name="panchayats"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
		    	
    <%
			stmt = conn.createStatement();
    panchDtlsQry="SELECT PCODE, PNAME FROM RWS_PANCHAYAT_TBL WHERE DCODE='"+dcode+ "' AND MCODE='"+mcode+ "'  ORDER BY PNAME";
			rs = stmt.executeQuery(panchDtlsQry);
			while(rs.next())
			{
				
	     if(rs.getString(1).equals(pcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
	<%
	session.setAttribute("pName",rs.getString(2));	
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
	%>
	
	</td>
		</tr>
		
		<tr><td class=rptLabel>Tanker<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="tanker"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()" 
		
		>
			<option value="0">-Select-</option>
		    
    <%
			stmt = conn.createStatement();
    villageDtlsQry="SELECT  distinct tanker_reg_no FROM rws_tanker_reg_tbl WHERE substr(habitation_code,1,2)='"+dcode+ "' AND substr(habitation_code,6,2)='"+mcode+ "' AND substr(habitation_code,13,2)='"+pcode+ "' ORDER BY tanker_reg_no";
			rs = stmt.executeQuery(villageDtlsQry);
			while(rs.next())
			{
				
	           if(rs.getString(1).equals(tanker_reg_no))
				{
	        	  
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(1)%></option> 
	<%
	session.setAttribute("tName",rs.getString(1));
				}
				else
				{
					
	%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option> 
	<%
				}
			}
						rs.close();			
						stmt.close();
	%>
	
	</td>
		</tr> 
	<%-- 	<tr><td class=rptLabel>Habitation</td>
		<td class=btext>
		<SELECT name="habitation"   id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
		    
    <%
			stmt = conn.createStatement();
            habDtlsQry="SELECT PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE SUBSTR(HAB_CODE,1,2)='"+dcode+ "'  AND SUBSTR(HAB_CODE,6,2)='"+mcode+ "' AND SUBSTR(HAB_CODE,13,2)= '"+pcode+ "' AND SUBSTR(HAB_CODE,8,3)= '"+vcode+ "'  ORDER BY PANCH_NAME";
			rs = stmt.executeQuery(habDtlsQry);
			while(rs.next())
			{
				
	          if(rs.getString(1).equals(hcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
	<%
	session.setAttribute("hName",rs.getString(2));	
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
	%>
	
	</td>
	</tr> --%>
	<tr>
	<td class=gridhdbg>From&nbsp;Date</td>
	<td class=btext>
		<input type="text" name="fromDate1" id="fromDate" style="width:90" <%if(request.getParameter("fromDate1")!= null) {%>
		value='<%=request.getParameter("fromDate1") %>' 
		<%}else{ %>value=''<%} %> />
		
		<a href="javascript:NewCal('fromDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<tr>
	<td class=gridhdbg>To&nbsp;Date</td>
	<td class=btext>
		<input type="text" name="toDate1" id="toDate" style="width:90"  
		<%if(request.getParameter("toDate1")!= null) {%>
		value='<%=request.getParameter("toDate1") %>' 
		<%}else{ %>value=''<%} %> />
		<a href="javascript:NewCal('toDate','ddmmyyyy');"><img src="/pred/images/cal.gif" width="16" height="17" border="0" alt="Pick a date"></a>
	</td>
	</tr>
	<TR>	
<TD colspan=2 align=center valign=top>
<tr>
		<td colspan=2 align=center>
		<input type=button id="dist" onclick="fnSubmitDetailsTnk()" value="Get Data" class = btext></td>
	</tr>
</TD>
</TR>	
	<%	
}
	catch(Exception e)
		{
 System.out.println("Exception in tanker moving Report frm jsp:"+e);
        }
    %>
</table>
<%} %>
	</table>	
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>