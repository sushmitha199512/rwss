<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="tenderNotificationForm"/>
 </head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<html:form action="TenderNotification.do?mode=dispWork">


<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
<td colspan=4 align=left><b>Tender Notification for Works</b>
</td>
</tr>


<tr bgcolor="#8A9FCD">
    <th><bean:message key="app.workId" /></th>
	<th><bean:message key="app.workName" /></th>
 </tr>
</thead>
<tbody class="gridText">
 
	<tr class="<c:out value='row${index%2}'/>">
  <% int count=1; %>
	<nested:iterate id="TENDER_LIST" property="workIds">
 
		<tr class="row<%=count%2%>">
 	   <%count=count+1; %>
		<td   align=center ><bean:write name="TENDER_LIST" property="workId"/>
		</td> 
	 	<td    align=left ><bean:write name="TENDER_LIST" property="workName"/>
  		</td>
		 
		</tr>
		</nested:iterate>
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="4" align="left">
		Total No. of  Works:&nbsp;<%= (count-1)%> 
	</th>
</tr>
</tfoot>
</table><br>
<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</body>
</html:form>
</html>




