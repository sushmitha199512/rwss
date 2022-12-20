<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>

<script language="javascript">


function getMileStoneStageCode(){

document.forms[0].action="switch.do?prefix=/masters&page=/ddwsmilestonestage.do?mode=data&mode1=stageCode";
	document.forms[0].submit();
}
function validate()
{
	if(document.forms[0].mileStoneCode.value=='0')
	{

		alert("please Select MileStone ");
				return false;
	}
	 
 else if(document.forms[0].mileStoneStageName.value=='')
	{

		alert("please Enter MileStone Stage Name ");
				return false;
	}
 else if(document.forms[0].mileStoneStagePercentage.value=='0.0' || document.forms[0].mileStoneStagePercentage.value=='0' || document.forms[0].mileStoneStagePercentage.value=='')
	{
	 alert("please Enter MileStone Stage Percentage ");
		return false;
	}
	else
		{
		
	document.forms[0].action="switch.do?prefix=/masters&page=/ddwsmilestonestage.do?mode=save";
	document.forms[0].submit();
}
}
</script>
<html:form action="ddwsmilestonestage.do">
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
	<jsp:param name="TableName" value="DDWS Physical MileStoneStage"  />
	<jsp:param name="TWidth" value="300" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	


<tr>
	<td class="mycborder">
	<FONT class=myfontclr>Mile Stone<font color="#FF6666">*</font></FONT></td>
	<td>
	<html:select property="mileStoneCode" styleClass="mycombo" style="width:123px" onchange="javascript:getMileStoneStageCode()">
	<html:option value="0"><font class=myfontclr1>SELECT...</html:option>
	<logic:present name="mileStonesList">
	<html:options collection="mileStonesList" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	</html:select>
	</tr>
<tr>
	<td class=mycborder >
	<FONT class=myfontclr>MileStone Stage Code:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="mileStoneStageCode" value="<%=(String)request.getAttribute(\"mileStoneStageCode\")%>" styleClass="thin-text-box" maxlength="2"  readonly="true"/>
	</td></tr>
	<tr >
<tr>
		<td class=mycborder >
	<FONT class=myfontclr>MileStone Stage Name:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="mileStoneStageName"  styleClass="thin-text-box" />
	</td>
	</tr>
	<tr>
		<td class=mycborder >
	<FONT class=myfontclr>MileStone Stage Percentage:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:text property="mileStoneStagePercentage"  styleClass="thin-text-box" onkeypress="return decimalsOnly()"/>
	</td>
	</tr>
<%-- 	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>DDWS Linked:<font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	<html:select property="ddwsLinked"  styleClass="mycombo" >
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

