<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<script language="JavaScript">
window.history.forward(1);

function getData()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=DeptOptForms";
document.forms[0].submit();
}
function viewReport()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=DeptReport";
document.forms[0].submit();
return false;
}
function getFromDates()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=datejoin";
document.forms[0].submit();
}
function getDeptopted()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=deptopt";
document.forms[0].submit();
}
function disable()
{
	if(document.empForm.desig[0].checked)
	{
		 //document.empForm.desgnCode.disabled=true;
	     //document.empForm.tempdesgCode.disabled=false;
	     document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=DeptOptForms";
	     document.forms[0].submit();
	}
	else if(document.empForm.desig[1].checked)
	{
		//document.empForm.desgnCode.disabled=true;
		
		document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=DeptOptForms";
		document.forms[0].submit();
	}
	else if(document.empForm.desig[2].checked)
	{
		//document.empForm.desgnCode.disabled=true;
		
		document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=DeptOptForms";
		document.forms[0].submit();
	}
	
//	document.empForm.tempdesgCode.disabled=true;	
}



//-->
</script>

<html:form action="Employee.do?mode=DeptOptForms" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Employee DepartmentOpted Report " />
	<jsp:param name="TWidth" value="450"/>
</jsp:include>

<table  bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="490" align="center">
<tr>
<td>
	<table border=0 width="300" align=center style="margin-bottom:5;margin-top:5">
	  	    
	  <tr>
	  <td  class="textborder" >Department Opted<font color="#FF6666">*</font></td>
	  <td  class="textborder" >
		<html:radio property="department" value="RWS" ><font size=2 color="purple">CE RWS&nbsp;</font></html:radio>
		<html:radio property="department" value="PR" ><font size=2 color="purple">PR</font></html:radio>
	 </td>
	 </tr>
	 
	 <tr>
	 </tr>
	 
	 
	<tr>
	<td  class="textborder">Date Of Joining</td>
	<td  class="textborder">
		<html:select property="fromDate" styleClass="mycombo" style="width:100" ><!-- onchange="getFromDates()" -->
		<html:option value=""><font class="myfontclr1">Select...</font></html:option>
		<html:options collection="fromdate" property="fromDate" labelProperty="fromDate" />
		</html:select>
	</td>
	</tr>
	 
	 <tr>
	 </tr>
	 
	<tr>
	 <td  class="textborder" nowrap>Spouse Working</td>
	 <td class="textborder">
	    <html:radio property="spouseworking" value="S"><font size=2 color="purple">State</font></html:radio><BR>
		<html:radio property="spouseworking" value="C"><font size=2 color="purple">Central</font></html:radio></td>
 		<td class="textborder">
 		<html:radio property="spouseworking" value="P"><font size=2 color="purple">PSU</font></html:radio>
<!-- 		<html:radio property="spouseemployd" value="N"><font size=2 color="purple">NotWorking</font></html:radio></td>-->
</td>
	</tr>

	<tr>
	</tr>

     <tr>
	 <td  class="textborder"><bean:message key="app.apcat" /></td>
	 <td  class="textborder">
		<html:select property="apcatog" style="width:130px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="catcodes" name="rwsMaster" property="catCode" labelProperty="catNoName" />
		</html:select>
	 </td>
	 </tr>
	 
	 <tr>
	 </tr>
	 
	 <tr>
		<td class="textborder" nowrap>Nature Of Employment</td>
		<td class="textborder"><html:radio property="desig" value="P"  onclick="javascript:disable();"><font size=2 color="purple">Permanent</font></html:radio>
		<html:radio property="desig" value="T" onclick="javascript:disable();"><font size=2 color="purple">Temporary</font></html:radio></td>
		<td class="textborder"><html:radio property="desig" value="W" onclick="javascript:disable();"><font size=2 color="purple">WorkCharged</font></html:radio>
		<html:radio property="desig" value="A" onclick="javascript:disable();"><font size=2 color="purple">All</font></html:radio></td>
		</tr>

	<tr>
		<td  class="textborder" nowrap>Designation</td> 
		<td><html:select property="desgnCode" style="width:150px" styleClass="mycombo" onchange="javascript:getData()">
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="desgns" name="rwsMaster" property="desgnCode" labelProperty="desgnName" />
		</html:select>
		</td>
	</tr>
		
		<tr>
		<td class="textborder" nowrap>Qualification</td>
		<td class="textborder"><html:select property="qual" style="width:125px" styleClass="mycombo">
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:options collection="qualcodes" name="rwsMaster" property="qualCode" labelProperty="qualNoName" />
		</html:select></td>
		</tr>
		
		
		
		<tr>
		<td  class="textborder" nowrap>Present Designation</td>
		<td  class="textborder">
			<html:select property="presentdesig" style="width:150px" styleClass="mycombo"  >
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<html:options collection="desgns1" name="rwsMaster" property="desgnCode" labelProperty="desgnName" />
			</html:select>
		</td>
		</tr>
		
		
		
		
		
	 
			  	
	</table>
</td>
</tr>
	<tr>
    <td colspan="2" align="center">
    <html:button property="mode" value="View Report" styleClass="btext" onclick="viewReport()" />
    </td>
	</tr>
	
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="450"/>
</jsp:include>
</table>	
</html:form>
<!-- </body>-->
<%@ include file="/commons/rws_footer.jsp"%>

	