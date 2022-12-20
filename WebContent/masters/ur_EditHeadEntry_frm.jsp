 <%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="headForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/UrHead.do?mode=edit" method="post" enctype="multipart/form-data" onsubmit="return validateHeadForm(this)" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Head Office Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">

		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.hoc" />&nbsp;</FONT></td>
		<td  class=mycborder >
		<html:text property="hoc" styleClass="mytext" maxlength="1" readonly="true" />
		</td>
		</tr>
		
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.hon" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hon"  styleClass="mytext" maxlength="20" />
		</td>
		</tr>

        <tr >
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.honame" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hoName"  size="30" styleClass="mytext" maxlength="40" />
		</td>
		</tr>
		
		<tr>
	 <td class="mycborder" width="100"> <FONT class=myfontclr>Officer&nbsp;Image<font color="#FF6666"></font> </td>
	 <td><html:file property="hoImageStatus" styleClass="mytext" style="width:150px" onchange="javascript:rest();javascript:ValidateFileUpload();" /></td>
   
	</tr>

		</table>

	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Save"  onclick="return winView()"  />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset"  />
	 	 
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

 