<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="wqDrillStatusForm" />
 <script language="JavaScript">
<!--

	function getData()
	{
		var workId=document.wqDrillStatusForm.workCode.value;
		if(workId==""){ 
			 alert("Please Select Work");}
		else{	 
		 url = "switch.do?prefix=/estimates&page=/ShowWorkDetails.do&type=new&workId="+workId;
		 window.open(url,"", "width=534,height=240,left=189,top=200,scrollbars=1");
  	   }
	}
	
//-->
</script>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/DrillStatus.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Source Finalisation Drilling Status" />
	<jsp:param name="TWidth" value="450" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="490" border=1 style="border-collapse:collapse;" >
<tr>
<td colspan="4">
		<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
		<tr>
		<td class="bwborder">Work Id&nbsp;:<font color="#FF6666">*</td>
		<td class="bwborder">
		<html:select property="workCode" styleClass="mycombo" style="width:123px" >
		<html:option value="">SELECT...</html:option>
		<html:options collection="workIds" name="rwsMaster"  property="workCode" labelProperty="workCode" />
		&nbsp;&nbsp;<input type="button" class="btext" value="..." style="width:22px;height:19px" onclick="getData()">
		</html:select>
		</td>
		<td class="bwborder">Drilling Status<font color="#FF6666">*</td>
		<td class="bwborder">
		<html:select property="drillStatus" styleClass="mycombo" style="width:123px">
		<html:option value="">SELECT...</html:option>
		<html:option value="1">Ongoing</html:option>
		<html:option value="2">Completed</html:option>
		<html:option value="3">Deffered</html:option>
		<html:option value="4">Not Intiated</html:option>
		</html:select>
		</td>
		<tr>
		<td class="bwborder">Date Of Drilling<font color="#FF6666">*</td>
		<td class="bwborder" nowrap>
		<html:text property="drillDate" size="10" value="" styleClass="mytext"  maxlength="10"/>
		<a href="javascript: showCalendar(document.wqDrillStatusForm.drillDate);">
		<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/>
		</a></td>
		<td class="bwborder">Yield<font color="#FF6666">*</td>
		<td class="bwborder">
		<html:text property="yield" styleClass="mytext" style="width:100px" maxlength="5"/>
		</td>
		</tr>
		</table>
		
	<tr>
	<td class="bwborder">
	<bean:define id="userId" name="RWS_USER" property="userId" />
	<html:hidden property="preparedBy" value="<%=(String)userId%>"/>
	</td>
	<td align="center">
	<html:submit property="mode" title="Save the Fields"  styleClass="btext" value="Save" onclick="return validateWqDrillStatusForm(wqDrillStatusForm)"/>
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	<html:submit property="mode" title="View the Fields" styleClass="btext" value="View" />
	</td>
	<td class="bwborder" align="right">
	<html:hidden property="preparedOn" value="<%=fmt.format(new java.util.Date())%>" />
	</td>
	</tr>
	</table>
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="450"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>