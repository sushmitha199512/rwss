<%@include file="/commons/rws_header1.jsp"%>
<script>
<!--
function getSubTask(id)
{
	var index = id.name.substr(5,1);
	var taskCode = id.value;
	var url = "switch.do?prefix=/estimates&page=/PickTaskSubTask.do"
			+ "&index="+index+"&mode=subtask"; 
	id.form.action=url;		
	id.form.submit();		
}
function getSubTaskDesc(id)
{
	var index = id.name.substr(5,1);
	var url = "switch.do?prefix=/estimates&page=/PickTaskSubTask.do"
			+ "&index="+index+"&mode=desc";
	id.form.action=url;		
	id.form.submit();		
}
function fnAddRemoveTask(that)
{	
	var index=that.name;
	if(that.value == "+")
	{ 	url = "switch.do?prefix=/estimates&page=/PickTaskSubTask.do&mode=add"
			+ "&index="+index;
	}
	else
	if(that.value == "-")
	{ 	url = "switch.do?prefix=/estimates&page=/PickTaskSubTask.do&mode=remove"
	 		+ "&index="+index;
	}
	that.form.action=url;
	that.form.submit();
}

function fnSave(that)
{
	var frm = that.form;
	var url = "switch.do?prefix=/estimates&page=/SaveTaskSubTask.do";
	frm.action = url;
	frm.submit();
}
//-->
</script>
</HEAD>

<BODY bgcolor="#DEE3E0" leftmargin="0" topmargin="0">
<html:form action="SaveTaskSubTask">
<table width="650" border="1" bordercolor="#000000" cellpadding="0" cellspacing="0" 
	   style="border-collapse:collapse">
<caption align="left">
	<table>
	<tr>
		<td class="staticLabel">Asset Type</td>
		<td class="staticLabel">:</td>
		<td class="staticLabelBold"><c:out value="${TaskSubTaskForm.assetTypeName}" /></td>	
		<td class="staticLabel">Work Component</td>
		<td class="staticLabel">:</td>
		<td class="staticLabelBold"><c:out value="${TaskSubTaskForm.componentName}" /></td>
		<td class="staticLabel">Sub Component</td>
		<td class="staticLabel">:</td>
		<td class="staticLabelBold"><c:out value="${TaskSubTaskForm.subComponentName}" /></td>
	</tr>	
	</table>
</caption>
<THEAD class="gridHeader">
<tr>
	<th>Task</th>
	<th>Sub Task</th>
	<th>Description</th>
	<th>Action</th>
</tr>
</THEAD>
<tbody class="gridContent">
<nested:iterate id="TASK" property="tasks" indexId="ndx">
<tr bgcolor="#ffffff">
	<td width="150">
		<nested:select name="TASK" property="taskCode" styleClass="combo" 
					   indexed="true" onchange="javascript: getSubTask(this)">
			<html:option value="">
				<bean:message key="app.pleaseSelect" />
			</html:option>
			<logic:present name="assetTasks">
			<nested:options collection="assetTasks" name="labelValueBean" property="value"
					      labelProperty="label" />
			</logic:present>		      
		</nested:select> 	
	</td>
	<td width="150">
		<nested:select name="TASK" property="subTaskCode" styleClass="combo"
					   indexed="true" onchange="javascript: getSubTaskDesc(this)">
			<html:option value="">
				<bean:message key="app.pleaseSelect" />
			</html:option>
			<logic:notEmpty name="TASK" property="assetSubTasks">
				<nested:optionsCollection property="assetSubTasks" />
			</logic:notEmpty>
		</nested:select>
	</td>
	<td width="300">
		<nested:text name="TASK" property="subTaskDesc" indexed="true" 
					 style="width:300px" styleClass="gridText" />
	</td>
	<td width="50" align="center">
		<input type="button" name="<%= ndx.intValue() %>" class="btext" style="width:25px"
			   value="<bean:write name="TASK" property="actionName" />"
			   title="<bean:write name='TASK' property='title'/>"
			   onclick="javascript: fnAddRemoveTask(this)">
 	</td>
</tr>	
</nested:iterate>
</tbody>
</table>
<br>
<center>
	<input type="button" value="Save" class="btext" onclick="javascript: fnSave(this)">
	<input type="button" value="Close" class="btext" onclick="javascript: fnClose()">
</center>
</html:form>
</BODY>
</HTML>
