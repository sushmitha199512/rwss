<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<head>
<script language="javascript">
<!--
function statusfrm()
{
//alert(document.forms[0].status.value);
}
function init()
{
}

function submitfrm()
{
document.forms[0].action="switch.do?prefix=/reports&page=/unidentified.do&mode=listHabs";
document.forms[0].submit();
}


function funcClose()
{
	if(typeof(window.opener)!="undefined") 
	{
		//alert("child");
		self.close();
	}
	else
	{
		//alert("parent");
		winClose();
	}

}
function funcDistrictChanged()
{
	document.forms[0].action="/pred/reports/unidentified.do?mode=data";	
	document.forms[0].submit();
}
function selectionChanged(mode)
{
	if(document.forms[0].panchayat)
	{
		document.forms[0].action="/pred/reports/unidentified.do?mode=data";
		document.forms[0].submit();
	}
}


//-->
</script>

</head>
<body> <!-- onload="showHabCode();funcInit()" -->
<html:form action="unidentified.do?mode=data">

<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="UnIdentified Habs Report" />
		<jsp:param name="TWidth" value="100%" />
		<jsp:param name="contextHelpUrl" value="/pred/help/Hab.doc" />
	</jsp:include>
</td>
</tr>
</thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>



<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="100%" >
<tr>
<td>
		<%-- <input type="hidden" name="prevMode" value=<%=request.getAttribute("mode") %> > --%>
		<fieldset>
		<legend>Select</legend>
		<label>
	<table  border=0  width="100%">
	<tr>
		<td class="textborder">District<span class="mandatory">*</span></td>
		<td class="textborder">
			<html:select property="district" style="width:150px" onchange="javascript:funcDistrictChanged()" styleClass="mycombo">
			<html:option value="ALL">ALL</html:option>
			<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" /> 
			</html:select></td>
</tr>
<tr>	
		<td class="textborder">Mandal</td>
		<td>
			<html:select property="mandal" style="width:150px" styleClass="mycombo" onchange="selectionChanged('panchayats')">
			<html:option value="ALL">ALL</html:option>
			<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" /> 
			</html:select></td>
	</tr>
	<tr>
		<td class="textborder">Panchayat</td>
		<td>
			<html:select property="panchayat" style="width:150px" styleClass="mycombo" onchange="selectionChanged('villages')">
			<html:option value="ALL">ALL</html:option>
			<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" /> 
			</html:select></td>
	</tr>

	<tr>
		<td class="textborder">Village</td>
		<td>
			<html:select property="village" style="width:150px" styleClass="mycombo" onchange="selectionChanged('habitations')">
			<html:option value="ALL">ALL</html:option>
			<html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
			</html:select></td>
	</tr>
		
	<tr>
	<td class="textborder">Coverage Status</td>
	<td>
		<html:select property="status" style="width:150px" styleClass="mycombo" onchange="statusfrm()">
		<html:option value="UI">UI</html:option>
		<html:option value="NULL">NULL</html:option>
		</html:select>
	</td>
		
		</table>
		</label>
		</fieldset>
		<tr>
		<td>
	<table width="100%">
	<tr>
	 <td class="textborder" align="center">
	       <html:button property="dublicate" value="Habitations" styleClass="btext" onclick="submitfrm();"/>
	    </td>
	</tr>
		</table>		
		</td>
		</tr>	
	
	
	</table>
 </td>
 </tr>
 </tbody>
 </table>
 
	</html:form>
	
	</body>
<%@ include file="/commons/rws_alert.jsp"%>		 

	