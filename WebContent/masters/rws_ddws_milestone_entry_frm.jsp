<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>

<script language="javascript">
function validate()
{
		
	 if(document.forms[0].mileStoneName.value=='')
	{

		alert("please Enter MileStone Name ");
				return false;
	}
	 else if(document.forms[0].phyPercentage.value=='0.0' || document.forms[0].phyPercentage.value=='0' || document.forms[0].phyPercentage.value=='')
		{
		 alert("please Enter MileStone Percentage ");
			return false;
		}
	else
		{
		
	document.forms[0].action="switch.do?prefix=/masters&page=/ddwsmilestone.do?mode=save";
	document.forms[0].submit();
}
}
</script>
<html:form action="ddwsmilestone.do">
	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
			<tr align="right">
<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>
			
			</tr>  
		</table>
	</caption>

</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="DDWS Physical MileStone Entry" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>DDWS MileStone Code:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="mileStoneCode" value="<%=(String)request.getAttribute(\"mileStoneCode\")%>" styleClass="thin-text-box" maxlength="2" readonly="true" />
	</td></tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>DDWS MileStone Name:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="mileStoneName"  styleClass="thin-text-box" />
	</td>
	</tr>
	<tr >
		<td class=mycborder >
	<FONT class=myfontclr>DDWS MileStone Percentage:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="phyPercentage"  styleClass="thin-text-box" onkeypress="return decimalsOnly()"/>
	</td>
	</tr>
	<%-- <tr>
	<td class=mycborder >
	<FONT class=myfontclr>DDWS Linked:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:select property="ddwsStatus"  styleClass="mycombo" >
	<html:option value="">----Select----</html:option>
	<html:option value="Y">Yes</html:option>
	<html:option value="N">No</html:option>
	</html:select>
	</td>
	</tr> --%>
</table>

<tr>
	<td colspan="2" align="center">
	<html:button property="mode" title="Save the Fields" styleClass="btext" value="save" onclick="return validate()"/> 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

