<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script>
function fnPickHabitations(tenderIdNo,noOfWorks)
{

	var	newWindow;
    
     var width = 600;
	 var height = 200;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));

 	 var url = "switch.do?prefix=/contractor&page=/TenderNotification.do&mode=dispWork&noOfWorks="+noOfWorks
			   + "&tenderIdNo="+tenderIdNo;
	      var properties = "width=400,height=260,left=210,top=210,toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }
   	 
}

//-->
</script>
<table width="90%">
<tr><td align=right><html:link page="/TenderNotification.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_TenderNotification_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_TenderNotification_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table   width="90%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Tender Notification Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
<tr>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Tender Id No.</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">No. Of Works</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Tender Issue Date</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Tender Closing Date </FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Cost Of Tender </FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Sales Tax </FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Estimated Contractor Value</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
	</td>
	</tr>

<logic:iterate id="tenderDetailsList" name="tenderDetails">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="tenderDetailsList" property="tenderIdNo" /></FONT>
</td>
<td  class=mycborder1 align="center">
<FONT class=myfontclr1><bean:write name="tenderDetailsList" property="noOfWorks" /></FONT>
<input type="button" value="..." style="width:20px;height:18px" class="btext"  onclick="fnPickHabitations('<bean:write name='tenderDetailsList' property='tenderIdNo' />','<bean:write name="tenderDetailsList" property="noOfWorks" />')">
&nbsp;&nbsp;

</td>

<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="tenderDetailsList" property="issueDate" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="tenderDetailsList" property="closeDate" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderDetailsList" property="costOfTender" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderDetailsList" property="salesTax" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderDetailsList" property="estContractValue" /></FONT>
</td>


<td  class=mycborder1 align=center>
<a href="
TenderNotification.do?tenderIdNo=<bean:write name='tenderDetailsList' property='tenderIdNo' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="TenderNotification.do?tenderIdNo=<bean:write name='tenderDetailsList' property='tenderIdNo' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
