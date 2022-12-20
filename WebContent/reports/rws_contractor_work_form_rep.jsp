<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<Script language="javascript">
function getyear()
{
   alert("in mode year");
   document.forms[0].action="switch.do?prefix=/reports&page=/ContractorWork.do?mode=year";
   document.forms[0].submit();
}
function getcontractor()
{
   alert("in mode contractor");
   document.forms[0].action="switch.do?prefix=/reports&page=/ContractorWork.do?mode=contractor";
   document.forms[0].submit();
}
function viewreport()
{
  if ((document.forms[0].myear.value==" ") && (document.forms[0].mdistrict_year.value==" ") && (document.forms[0].mcontractor.value==" "))
  {
     alert("Please Select contractor/year/district details");
     return false;
   }
   else
   {
   alert("Please Wait for the Report........");
   document.forms[0].action="switch.do?prefix=/reports&page=/ContractorWork.do?mode=view";
   document.forms[0].submit();
   }
}

function main()
{
	window.location="/pred/home.do";
}
</script>
<html:form action="ContractorWork.do">
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Contractor - No of works Taken Up" />
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
		<td>District</td>
		<td>
          			<html:select property="mdistrict" styleClass="combo" onchange="javascript:getyear()">
					<html:option value="ALL">ALL</html:option>
						<logic:present name="district">	
							<html:options collection="district" name="labelValueBean"  property="value" labelProperty="label" />						
                        </logic:present>
				</html:select>
			</td></tr>
	<tr>
		<td>Year</td>
		<td>
				<html:select property="myear" styleClass="combo" onchange="javascript:getcontractor()">
					<html:option value="ALL">ALL</html:option>
						<logic:present name="year">	
							<html:options collection="year" name="labelValueBean"  property="value" labelProperty="label" />						
                        </logic:present>
				</html:select>
			</td></tr>
    <tr>
		<td>Contractor</td>
        <td>
				<html:select property="mcontractor" styleClass="combo" >
					<html:option value="ALL">ALL</html:option>
						<logic:present name="contractor">	
							<html:options collection="contractor" name="labelValueBean"  property="value" labelProperty="label" />						
                        </logic:present>
				</html:select>
			</td></tr>
  <tr><td colspan=2 align=center><input type=button value=ViewReport onclick="viewreport()"></td></tr>
</table>	
</td>
</tr>
</html:form>



