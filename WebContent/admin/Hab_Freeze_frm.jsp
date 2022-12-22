
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<Script language="javascript">
function freezecheck()
{
	var checkedRadio="";
	for (i=0; i<document.forms[0].freeze.length; i++) 
	{
	         if (document.forms[0].freeze[i].checked==true)
	         {
	            checkedRadio=document.forms[0].freeze[i].value
	         }
	}

	if(checkedRadio=="freeze") 
		alert("Do u want to freeze the status for "+document.forms[0].mdistrict.options[document.forms[0].mdistrict.selectedIndex].text+" District");
	
} 
</script>

<html:form action="FreezeHab.do">

<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Freeze Habitation Status" />
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td></tr></thead>
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


<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"  style="border-collapse:collapse;" width="100%" >	
<tr><td> <input type=radio name=freeze value=freeze checked>Freeze</td>
<td> <input type =radio name=freeze value=unfreeze>Unfreeze</td>
</tr>
	<tr>
			<td><bean:message key="app.district" /><span class="mandatory">*</span></td>
			<td>
				<html:select property="mdistrict" styleClass="combo">
					<html:option value="">ALL</html:option>
						<logic:present name="districts">	
							<html:options collection="districts" property="value" labelProperty="label" />
						</logic:present>
				</html:select>
			</td>
		</tr>
	<tr>
		<td>Freeze Habitation status for</td>
		<td><html:text property="mhabstatus" style="font-weight:bold;color:green"/></td>
	</tr>	
	<tr><td colspan=4 align=center><input type=button value=Submit onclick="freezecheck()"></td></tr>
</table>	
</td>
</tr>
</html:form>