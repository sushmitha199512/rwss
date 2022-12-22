<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="agencyForm" />
<%@ include file="/commons/rws_header2.jsp" %>


<html:form action="/Agency.do?mode=edit" onsubmit="return validateAgencyForm(this)" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Agency Entry Edit Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>AgencyCode</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="agencyCode"  styleClass="mytext" maxlength="4"  readonly="true"/>
		</td>
		</tr>
		
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>AgencyName</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="agencyName" styleClass="mytext" />
		</td>
		</tr>
		
		</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Save" onclick="return winView()" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

