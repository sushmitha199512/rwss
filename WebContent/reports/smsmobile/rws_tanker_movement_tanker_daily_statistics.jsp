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
    /* String mndDtlsQry = null;
    String panchDtlsQry = null;
    String villageDtlsQry = null;
    String habDtlsQry = null; */
    String dcode="";
%>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<script language="JavaScript">
function fnSubmitDetails()
{
	var frmdate=document.getElementById("fromDate").value;
	var todate=document.getElementById("toDate").value;
    //var distCode=document.getElementById("district").value;
    //var dname = document.f1.district.options[document.f1.district.options.selectedIndex].text;
    /* var mandCode=document.getElementById("mandal").value;
    var mname = document.f1.mandal.options[document.f1.mandal.options.selectedIndex].text;
    var panchCode=document.getElementById("panchayat").value;
    var pname = document.f1.panchayat.options[document.f1.panchayat.options.selectedIndex].text;
    var villCode=document.getElementById("village").value;
    var vname = document.f1.village.options[document.f1.village.options.selectedIndex].text;
    var habCode=document.getElementById("habitation").value;
    var hname = document.f1.habitation.options[document.f1.habitation.options.selectedIndex].text; */
	/* if(document.f1.district.selectedIndex=="")
    {
	   alert("SELECT DISTRICT...");		
	   return false;
    } */

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
		//alert("@@@@@@@@");
		//"&y1="
		
		document.f1.action="./rws_tanker_movement_drill_daily_statitics_rpt.jsp?mode1=mandal&type=1&fromdate="+frmdate+"&todate="+todate+"";
	     		//document.f1.action="./rws_tanker_movement_drill_statitics_rpt.jsp?mode1=mandal&type=1";
	     		//document.forms[0].action="rws_residual_act_tkn_status_report.jsp?fromDate="+frmdate+"&toDate="+todate;

		document.f1.submit();
		}
 
 
/*  var res = frmdate.split("-", 3);
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
    	 alert("...");
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
	
} */	
}
function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
/* function fnSubmitDet()
{
	var frmdate=document.getElementById("fromDate").value;
	var todate=document.getElementById("toDate").value;
	document.forms[0].fromDate.value=frmdate;
	document.forms[0].toDate.value=todate;
	document.forms[0].action="./rws_tanker_movement_rpt.jsp?mode=det";
	document.forms[0].submit();	
}
 */

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
   <%if(isModeChange.equalsIgnoreCase("det")){ %>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
				<tr><td align="right" class="bwborder"></td> 
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3> Tanker Statistics -  Daily Report</td>	
	</tr>
	<%
try
{ 
	 dcode = request.getParameter("district");
	 /* mcode = request.getParameter("mandal");
	 pcode = request.getParameter("panchayat");
	 vcode = request.getParameter("village");
	 hcode = request.getParameter("habitation"); */
	 
	%>
	<%--  <tr><td class=rptLabel>District <font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="0">-Select-</option>
    <%
  
    String userId = "00";
   	String regex = "[0-9]+";
   	if(loggedUser!=null){
   		userId = loggedUser.substring(1,3);
   	    userId.matches(regex);
   	}
       
       if(loggedUser!=null &&  userId.matches(regex) &&  !userId.equals("00")){
    	   distDtlsQry="SELECT dcode,dname from rws_district_tbl where dcode='"+userId+"'";
       }else{
    	   distDtlsQry="SELECT dcode,dname from rws_district_tbl    order by dname";
       }
			rs = stmt.executeQuery(distDtlsQry);
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
	%>
		</tr>  --%>  
				
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
<%}%>
	</table>	
	</form>
<p align=center>
<%@ include file = "/commons/rws_footer.jsp" %>
</p>