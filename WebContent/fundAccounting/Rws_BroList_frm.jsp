<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function frmSubmit()
{
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/broDetailsList.do&mode=getBroList_frm_view";
	document.forms[0].submit();
}
</script>
<body >
<html:form action="broDetails.do" >
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="BRO Details" />
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


<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	

<tr>
	<td class="mycborder">
		<fieldset>
			<legend>BRO Details </legend>
			<label>
				<table  border=0  width="100%">
				
				<tr>
					<TD class="textborder">
					
						Financial Year<font color="#FF6666">*</font>
					</TD>
				    <TD class="bwborder">
				   <html:select  style="width:120" property="bro_financialYear" styleClass="mycombo" >
					<html:option value="">ALL...........</html:option>
					<logic:notEmpty name="financialYearsList">
					<html:options collection="financialYearsList" name="broDetails" 
								  property="bro_financialYear" labelProperty="bro_financialYear" />
					</logic:notEmpty>
				
					</html:select>
						
				    </TD>
			  </tr>
			  
			  <tr><td align="center" colspan="4"><input type="button" value="submit" class="btext" onclick="frmSubmit()">
			  </tr>
			  </table>
			</label>
		</fieldset>
	</td></tr></table>
</td></tr></tbody></table></html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

