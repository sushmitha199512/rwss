<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>

<script language="JavaScript">

function viewWorks(URL)
{
	alert("URL"+URL);
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
<html:form  action="SchemesActionTaken" method="post">
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
			<td align="center" class="gridhdbg" colspan=21>Schemes Action Taken Details</td>
	<tr >
	<td class=gridhdbg >S.No</td>
	<td class=gridhdbg >Asset Code</td>
	 <td class=gridhdbg >Component Code</td>
	<td class=gridhdbg >Habitation Code</td>
    <td class=gridhdbg >Habitation Name</td>
    <td class=gridhdbg >Local Person  Name</td>
	<td class=gridhdbg >SMS Mobile</td>
	<td class=gridhdbg >SMS Date</td>
	<td class=gridhdbg >Status</td>
	<td class=gridhdbg >Service Request</td>
	<td class=gridhdbg >Action Date</td>
	<td class=gridhdbg >Updated Status</td>
	<td class=gridhdbg >Action Entered Date</td>
	<td class=gridhdbg >Remarks</td>
	<!--  <td class=gridhdbg >Edit</td> -->
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
<logic:notEmpty name="schemesForm" property="schemes1">
	<logic:iterate id="schemes" name="schemesForm" property="schemes1" indexId="index">
		<tr>
		    <td class=<%=style %> style="text-align: center;"><%=count++ %></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="assetCode" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="sourceCode" /></td> 
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="habitation" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="habitationName" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="localpersonname" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="smsMobile" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="smsDate" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="schemeStatus" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="serviceRequest" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="dateOfAction" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="actionTaken" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="dateEntered" /></td>
		    <td class=<%=style %> style="text-align: left;"><bean:write name="schemes" property="remarks" /></td>
		    <html:hidden property="mesid" name="schemes" />
		    
		   
		    
       </tr>
 
	   </logic:iterate>
	   </logic:notEmpty>
</table>	
</html:form>
	<%@ include file = "/reports/footer.jsp" %>
 </body>
</html>