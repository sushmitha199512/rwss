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
 	var win = window.open(url,name,'width=' + w + ', height=' + h + ', ' +
	  'location=yes, menubar=no, ' +
	  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
	 win.focus();
}
</script>
<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
//System.out.println("loggedUser"+loggedUser);
String circle=loggedUser.substring(1,3);
session.setAttribute("circle",circle);
int styleCount=0;
String style="";
int count=1;
%>
<html>
<body>
<html:form  action="ResidualChlorine" method="post">
	<table border = 0 cellspacing = 0 cellpadding = 0 width="60%" style="border-collapse:collapse" >
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr>
				<td align="right" ><a href="/pred/home.jsp?loginMode=watersoft">Home |</a></td>
				<td align="right"><a href="javascript:onclick=history.go(-1)"> Back  &nbsp;</a></td>
			</tr>
		</table>
	</caption>
	</table>
	
<table  cellspacing=0 cellpadding=0 width="80%"	 style="border-collapse: collapse" 	align="center">
<tr>
			<td align="center" class="gridhdbg" colspan=21>Schemes Action Taken Details</td>
	<tr >
	<td class=gridhdbg >S.No</td>
	<td class=gridhdbg >Habitation Code/Name</td>
	<td class=gridhdbg >Asset Code/Name</td>
	<td class=gridhdbg >Source Name/Location</td>	
	<td class=gridhdbg >Latitude-Longitude</br>/Location</td>
	<td class=gridhdbg >Location</td>
	<td class=gridhdbg >Test Date</td>
	<td class=gridhdbg >PPM Value</td>
	<td class=gridhdbg >SMS Mobile</td>
	<td class=gridhdbg >Action Date</td>
	<td class=gridhdbg >Potable</td>
	<td class=gridhdbg >Mode of Service Request</td>
	<td class=gridhdbg >Registered Service Request</td>
	<td class=gridhdbg >Action Entered Date</td>
	<td class=gridhdbg >Entered By</td>
	<td class=gridhdbg >Remarks</td>
	<!--  <td class=gridhdbg >Edit</td>  -->
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
<logic:notEmpty name="residualChlorineForm" property="chlorides1">
	<logic:iterate id="chlorides" name="residualChlorineForm" property="chlorides1" indexId="index">
		<tr>
		    <td class=<%=style %> style="text-align: center;"><%=count++ %></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="habitationName" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="assetCode" />/</br><bean:write name="chlorides" property="assetName" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="sourceName" /></td>
		    <logic:equal name="chlorides" property="selectSource" value="true">
				<td class=<%=style %> style="text-align: left;"><bean:write name="chlorides"  property="locLat"/></br>/<bean:write name="chlorides" property="locLong" /></td>
			</logic:equal>
			<logic:equal name="chlorides" property="selectSource" value="false">
			<td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="msgLocation" />
			</logic:equal>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="location" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="testDate" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="ppmValue" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="smsMobile" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="dateOfAction" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="actionTaken" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="modeOfCapture" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="serviceRequest" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="dateEntered" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="enteredBy" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="chlorides" property="remarks" /></td>
		    
		   <html:hidden property="mesid" name="chlorides" />
		  	<%--  <td class=<%=style %> style="text-align: left;"><a href="#" onclick="viewWorks('switch.do?prefix=/smsmobile&page=/ResidualChlorine.do&mode=chloridesEdit')">Edit</a></td> --%> 
	   </tr>
	 </logic:iterate>
</logic:notEmpty>
</table>	
</html:form>
	<%@ include file = "/reports/footer.jsp" %>
 </body>
</html>