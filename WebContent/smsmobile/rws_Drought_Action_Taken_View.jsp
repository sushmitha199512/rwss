<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>

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
<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
String circle=loggedUser.substring(1,3);

session.setAttribute("circle",circle);
int styleCount=0;
String style="";
int count=1;
%>
<html>
<body>
<html:form  action="DroughtActionTaken" method="post">
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			

			<tr><td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home |</a></td>
				<td align="right"><a href="javascript:onclick=history.go(-1)"> Back  &nbsp;</a></td></tr>

		</table>
	</caption>
	</table>
	
<table  cellspacing=0 cellpadding=0 width="80%"	 style="border-collapse: collapse" 	align="center">
<tr>
			<td align="center" class="gridhdbg" colspan=21>Drought Action Taken Details</td>
	<tr >
	<td class=gridhdbg >S.No</td>
	<td class=gridhdbg >Habitation Code</td>
	<td class=gridhdbg >Habitation Name</td>
	
	
	<td class=gridhdbg >Send Date</td>
	<td class=gridhdbg >Location</td>
	<td class=gridhdbg >Tanker Status</td>
	<td class=gridhdbg >Tanker Update Status</td>
	<td class=gridhdbg >Tanker Supply Date</td>
	<td class=gridhdbg >SMS Mobile</td>
	<td class=gridhdbg >Action Entered Date</td>
	<td class=gridhdbg >Entered By</td>
	<td class=gridhdbg >Service Request</td>
	<td class=gridhdbg >Remarks</td>
	<!-- <td class=gridhdbg >Edit</td> -->
	</tr>
	
<tr align="center"  class="gridhdbg">

</tr>
<tr>
<%	 if(styleCount%2==0){
	 style="gridbg1";
}else{
	 style="gridbg2";
}
styleCount++; %>
<logic:notEmpty name="droughtForm" property="drought1">
	<logic:iterate id="drought" name="droughtForm" property="drought1" indexId="index">
		<tr>
		    <td class=<%=style %> style="text-align: center;"><%=count++ %></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="droughtHabCode" /></td>
		     <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="panchayat" /></td>
		    
		    
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="smsDate" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="location" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="tankerStatus" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="tankerUpdateStatus" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="tankerSupplyDate" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="smsMobile" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="dateEntered" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="enteredBy" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="serviceRequest" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="drought" property="remarks" /></td>
		    
		   
		    
       </tr>
 
	   </logic:iterate>
	   </logic:notEmpty>
</table>	
</html:form>
	<%@ include file = "/reports/footer.jsp" %>
 </body>
</html>