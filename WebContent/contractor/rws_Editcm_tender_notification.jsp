<%@ include file="/commons/rws_header1.jsp" %>

<html:javascript formName="tenderNotificationForm"/>

<SCRIPT LANGUAGE="JavaScript">
<!--
 
function fnPickWorks()
{
	var	newWindow;
	var typeOfTender = document.getElementById("typeOfTender").value;
  	var message="";
  	var tenderIdNo=document.getElementById("tenderIdNo").value;
	if(typeOfTender=="")
	 message=message+"Packaged is required\n";
 	 if(message!="")
	 {
	  alert(message) 
	 }	 
	 else{ 
	 if(typeOfTender=="Y"){
	  var width = 638;
	  var height = 332;
	  var left = parseInt((screen.availWidth/2)-(width/2));
	  var top = parseInt((screen.availHeight/2)-(height/2));
  	  var url = "switch.do?prefix=/contractor&page=/TenderNotification.do&mode=dispWork&tenderIdNo="+tenderIdNo;
      var properties = "width=400,height=260,left=210,top=210,toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes";
	  if( !newWindow || newWindow.closed)
	  {
	 	newWindow = window.open(url, "", properties);
	  }
	  else
	  {
 		newWindow.focus();
 	  }
 	 } 
   }	 
}

//-->
</script>
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="TenderNotification.do&mode=edit" onsubmit="return validateTenderNotificationForm(this)">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Tender Notification Entry Form" />
	<jsp:param name="TWidth" value="740" />
</jsp:include>
	<TABLE bgcolor="#DEE3E0" width="780" border="1" cellpadding="1" rules="none" cellspacing="0" bordercolor= "#8A9FCD" style="border-collapse:collapse"> 
		<TR>
		<TD class="textborder" colspan="6" >
			<fieldset>
			<legend  ><B>Office Details</B></legend>
			<label>
			<table bgcolor="#DEE3E0" cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" align="center">
			<tr>
			<logic:present name="RWS_USER" property="headOfficeName">
			<td class="textborder">Head Office&nbsp;:</td>
			<td class="textborder">
			<html:text property="headOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
			</td>
			</logic:present>
			<logic:present name="RWS_USER" property="circleOfficeName">
			<td class="textborder">Circle&nbsp;:</td>
			<td class="textborder">
			<html:text property="circleOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
			<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</td>
			</logic:present>
			<logic:present name="RWS_USER" property="divisionOfficeName">
			<td class="textborder">Division&nbsp;:</td>
			<td class="textborder">
			<html:text property="divisionOfficeName" name="RWS_USER" readonly="true" styleClass="mytext"  style="width:100px"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
			</td>
			</logic:present>
			<logic:present name="RWS_USER" property="subdivisionOfficeName">
			<td class="textborder">Subdivision&nbsp;:</td>
			<td class="textborder">
			<html:text property="subdivisionOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
			</td>
			</logic:present>
			</tr>
			</table>
			</label>
			</fieldset>
		</TD>
		</TR>
		<TR>
			<TD nowrap class="textborder" >Tender Id No.&nbsp;<font color="#FF6666">*</font>:</TD>
			<TD class="textborder" colspan="6" align="left"><html:text property="tenderIdNo"  maxlength="15" readonly="true"></html:text></TD>
		</TR>
		<TR>
			<TD nowrap class="textborder">Packaged&nbsp;<font color="#FF6666">*</font>:</TD>
			<TD class="textborder">
				<html:select property="typeOfTender" styleClass="mycombo" style="width:80px">
				<html:option value="">SELECT...</html:option>
				<html:option value="Y">YES</html:option>
				<html:option value="N">NO</html:option>
				</html:select>
			</TD>
			<TD nowrap class="textborder">No. Of Works<font color="#FF6666">*</font>&nbsp;:</TD>
			<TD class="textborder"><html:text property="noOfWorks" style="width:70px" maxlength="2" readonly="true"></html:text>
			<html:button property="addWorkId" value="..." styleClass="btext" title="Click Here" style="height:20px;width:20px"
								 onclick="javascript: fnPickWorks()" />
			</TD>
			<TD nowrap class="textborder">Tender Type&nbsp;:</TD>
			<TD class="textborder"><html:text property="tenderType" style="width:70px" maxlength="2"></html:text></TD>
		</TR>
		<TR>
			<TD nowrap class="textborder">Tender Issue Date<font color="#FF6666">*</font>&nbsp;:</TD>
			<TD class="textborder">
			<html:text property="issueDate" style="width:80px" maxlength="10"></html:text>
			<a href="javascript: showCalendar(document.tenderNotificationForm.issueDate);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
			</TD>
			<TD nowrap class="textborder">Tender Closing Date<font color="#FF6666">*</font>&nbsp;:</TD>
			<TD class="textborder"><html:text property="closeDate" style="width:70px" maxlength="10"></html:text>
			<a href="javascript: showCalendar(document.tenderNotificationForm.closeDate);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
			</TD>
			<TD nowrap class="textborder">Mode Of Execution&nbsp;:</TD>
			<TD class="textborder"><html:text property="modeOfExecution" style="width:70px" maxlength="5"></html:text></TD>
		</TR>
		<TR>
			<TD nowrap class="textborder">Cost Of Tender<font color="#FF6666">*</font>&nbsp;:</TD>
			<TD class="textborder"><html:text property="costOfTender" style="width:80px" maxlength="11"></html:text></TD>
			<TD nowrap class="textborder">Sales Tax Cost<font color="#FF6666">*</font>&nbsp;:</TD>
			<TD class="textborder"><html:text property="salesTax" style="width:70px" maxlength="11"></html:text></TD>
			<TD nowrap class="textborder">Estimated Contractor Value<font color="#FF6666">*</font>&nbsp;:</TD>
			<TD class="textborder"><html:text property="estContractValue" style="width:70px" maxlength="5"></html:text></TD>
		</TR>
		<TR><td colspan=6><hr color="#8A9FCD"></td></TR>
		<TR>
			<TD class="textborder" colspan="6" align=center>
				<html:submit title="Save" styleClass="btext" value="Save"   />
				<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />	
				<bean:define id="userId" name="RWS_USER" property="userId" />
				<html:hidden property="preparedBy" value="<%=(String)userId%>"/>
				<html:hidden property="preparedOn" value="<%=sdf.format(new java.util.Date())%>"/>
			</TD>
		</TR>
	</TABLE>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="740"/>
</jsp:include>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

