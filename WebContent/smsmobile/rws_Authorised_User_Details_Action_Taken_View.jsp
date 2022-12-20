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
<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
System.out.println("loggedUser"+loggedUser);
String circle=loggedUser.substring(1,3);

session.setAttribute("circle",circle);
int styleCount=0;
String style="";
int count=1;
%>
<html>
<body>
<html:form  action="AuthorisedUserDetails" method="post">
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
			<td align="center" class="gridhdbg" colspan=21>Authorized Mobile User Action Taken Details</td>
	
	<tr >
	<td class=gridhdbg >S.No</td>
	<td class=gridhdbg >Habitation Code</td>
	<td class=gridhdbg >IMEI No of Device</td>	
	<td class=gridhdbg >User Name</td>
	<td class=gridhdbg >Data Collector Name</td>
	<td class=gridhdbg >Mobile Number</td>
	<td class=gridhdbg >Designation </td>
	<td class=gridhdbg >Gender</td>
	<td class=gridhdbg >Email id</td>
	<td class=gridhdbg >Address</td>	
	<td class=gridhdbg >Service Request</td>
	<td class=gridhdbg >Date Of Request</td>
	<td class=gridhdbg >Auth User Registration</td>
	<td class=gridhdbg >Authorized By</td>
	<td class=gridhdbg >Date Of Authorization</td>
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
<logic:notEmpty name="authorisedUserDetailsForm" property="users">
	<logic:iterate id="users" name="authorisedUserDetailsForm" property="users" indexId="index">
		<tr>
		    <td class=<%=style %> style="text-align: center;"><%=count++ %></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="habCode" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="IMEINo" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="userName" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="dataCollectorName" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="mobileNumber" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="designation" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="gender" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="emailId" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="address" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="serviceRequest" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="dateofRequest" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="status" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="authorisedBy" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="users" property="dateOfAuthorization" /></td>
		    
		  	<%-- <td class=<%=style %> style="text-align: left;"><a href="#" onclick="viewWorks('switch.do?prefix=/smsmobile&page=/AuthorisedUserDetails.do&mode=userEdit')">Edit</a></td> --%>
		    
		   
		   </tr>
 
	   </logic:iterate>
	   </logic:notEmpty>
</table>	
</html:form>
	<%@ include file = "/reports/footer.jsp" %>
 </body>
</html>