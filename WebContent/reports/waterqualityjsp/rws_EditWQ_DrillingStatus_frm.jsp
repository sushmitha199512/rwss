<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<html:javascript formName="wqDrillStatusForm" />

<html:form action="/DrillStatus.do?mode=edit" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Source Finalisation Drilling Status" />
	<jsp:param name="TWidth" value="450" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="490" border=1 style="border-collapse:collapse;" >
<tr>
<td colspan="3">
		<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
		<tr>
		<td class="bwborder">Work Id&nbsp;:<font color="#FF6666">*</td>
		<td class="bwborder">
		<html:text property="workCode" styleClass="mytext" style="width:123px"  readonly="true" />
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
		<html:text property="drillDate" size="10"  styleClass="mytext" maxlength="10" />
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
	 
	<td align="center">
	<html:submit property="mode" title="Save the Fields"  styleClass="btext" value="Submit" onclick="return validateWqDrillStatusForm(wqDrillStatusForm)"/>
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	
	</td>
	 
	</tr>
	</table>
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="450"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>