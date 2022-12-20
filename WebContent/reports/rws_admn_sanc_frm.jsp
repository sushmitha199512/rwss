ded<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<Script language="javascript">
function showstatus()
{
if (document.forms[0].mfin_year.value=="") 
{
 alert("Please select the Year/Chart type");
 return false;
}
else
{
 alert("Please Wait for the graph........");
 document.forms[0].action="switch.do?prefix=/reports&page=/AdmnSancGraph.do?mode=graph";
 document.forms[0].submit();
}
}

function main()
{
	window.location="/pred/home.do";
}
</script>
<html:form action="AdmnSancGraph.do">
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="District Wise Admnistrative Sanction" />
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

<table align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"  style="border-collapse:collapse;" width="100%" >	
	<tr>
		<td>Financial Year</td>
		<td>
				<html:select property="mfin_year" styleClass="combo" >
					<html:option value="">Select</html:option>
						<logic:present name="finyear">	
							<html:options collection="finyear" name="labelValueBean"  property="value" labelProperty="label" />						
                        </logic:present>
				</html:select>
			</td></tr>
  <tr><td colspan=2 align=center><input type=button value=ViewReport onclick="showstatus()"></td></tr>
</table>	
</td>
</tr>
</html:form>



