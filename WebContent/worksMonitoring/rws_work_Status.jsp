<%@ include file="/commons/rws_header1.jsp" %>
<%@ page import="nic.watersoft.contractor.Rws_Tender_Register_Opening_Bean" %>
 
 
 <SCRIPT LANGUAGE="JavaScript">
 
</SCRIPT>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
<%@ include file="/commons/rws_header2.jsp" %>
<body  >
<html:form  action="WorkStat.do?mode=data" enctype="multipart/form-data"   >
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Work Progress" />
	<jsp:param name="TWidth" value="780" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	   width="810" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B>Office Details</B>
		</legend>
		<label>
		<table cellpadding="0" cellspacing="0" border="0" width="810" 
			   bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr>
			<logic:present name="RWS_USER" property="headOfficeName">
				<td class="textborder">Head&nbsp;Office&nbsp;:</td>
				<td class="textborder">
				<html:text property="headOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="headOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			<logic:present name="RWS_USER" property="circleOfficeName">
				<td class="textborder">Circle&nbsp;:</td>
				<td class="textborder">
				<html:text property="circleOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			<logic:present name="RWS_USER" property="divisionOfficeName">
				<td class="textborder">Division&nbsp;:</td>
				<td class="textborder">
				<html:text property="divisionOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext"  style="width:100px"/>
				<html:hidden property="divisionOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			<logic:present name="RWS_USER" property="subdivisionOfficeName">
				<td class="textborder">Subdivision&nbsp;:</td>
				<td class="textborder">
				<html:text property="subdivisionOfficeName" name="RWS_USER" 
						   readonly="true" styleClass="mytext" style="width:100px"/>
				<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
				</td>
			</logic:present>
			</tr>
		    </table>
		    </label>
		    </fieldset>
		   

	   	   
</table>		
<jsp:include page="/commons/TableFotter.jsp">
		
<jsp:param name="TWidth" value="780"/>
</jsp:include>

</html:form><!-- -->
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%> 
