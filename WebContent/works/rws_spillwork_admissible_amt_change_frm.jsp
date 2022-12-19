<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%

int count = 1;
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();

String md=request.getParameter("mode");
String md1=request.getParameter("mode1");
String releaseDate=request.getParameter("releaseDate");
if(releaseDate==null){
releaseDate=RwsUtils.getCurrentDate("dd-MMM-yyyy");
}


%>
<meta http-equiv="X-UA-Compatible" content="IE=8, IE=9, chrome=1"/>
<head>
<script language="javascript" type="text/javascript" src="/pred12052015/resources/javascript/datetimepicker.js"></script>
<script  language="javascript" >


function getWorks()
	{
	   
	   	 	  if(document.forms[0].circleCode.value==''){
	  alert("Please Select Circle Code");
		return false;
	  }
	  else if(document.forms[0].cmbDivision.value==''){
	  alert("Please Select Division Code");
		return false;
	  }
	 
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkAdmChange.do&mode=data&mode1=getWorks";
		document.forms[0].submit();	
		}
	}

function getWorks1()
	{
	   
	   	 	  if(document.forms[0].circleCode.value==''){
	  alert("Please Select Circle Code");
		return false;
	  }
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkAdmChange.do&mode=data&mode1=getWorks1";
		document.forms[0].submit();	
		}
	}



function fnSave(count)
{

	  var flag=false;var i=0;
 for(i=1;i<count;i++){
if(document.forms[0].elements['check'+i].checked==true){

flag=true;
break;
}
}

if(!flag){
	alert("Please Select Work");
return;
}
		document.forms[0].action="switch.do?prefix=/works&page=/SpillWorkAdmChange.do&mode=data&mode1=save";
               document.forms[0].submit();
}

</script>

</head>

<html:form action="SpillWorkAdmChange.do">
<body>


<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<table width="100%">
<tr><td align=right><a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>

</td></tr>
</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Bill Amount Admissible To Be Changed With Bill Amount Contractor" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Office Details</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2" border="0"
				bordercolor="#8A9FCD" style="border-collapse:collapse;" >
	
		<tbody class="formTBody">

			<tr class="textborder">
				<%
	  String cirfi=(String)session.getAttribute("fixcircle");
	  String usercode=RWS_USER.getCircleOfficeCode();
      String username=RWS_USER.getCircleOfficeName();
      String divusercode=RWS_USER.getDivisionOfficeCode();
      String divusername=RWS_USER.getDivisionOfficeName();
      String subusercode=RWS_USER.getSubdivisionOfficeCode();
      java.util.Date systemdate= new java.util.Date(System.currentTimeMillis());
	
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
	    String transdate=null;
	  transdate=dateFormat.format(systemdate);
	  
 				%>


                    <logic:present name="circles">
					<logic:notPresent name="fixcircle">
						<td class="textborder">Circle<span class="mandatory">*</span></td>
						<td class="textborder"><html:select property="circleCode"
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getWorks1();">
							<html:option value="">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="circles" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:notPresent>
					<logic:present name="fixcircle">

						<td class="textborder">Circle<span class="mandatory">*</span></td>
						<logic:present name="RWS_USER" property="circleOfficeName">
							<html:hidden property="circleCode" />
							<td class="textborder"><html:text property="circleOfficeName"
								name="RWS_USER" readonly="true" styleClass="mytext"
								style="width:100px" /> <html:hidden property="circleOfficeCode"
								name="RWS_USER" /></td>
						</logic:present>
					</logic:present>
				</logic:present>



</tr>
	</table>
	</label>
	</fieldset>

	</td>

	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="100%" border=1
		style="border-collapse:collapse">
		<tr bgcolor="#8A9FCD">
			<td class="bwborder" colspan="14"><B><font color="#FFFFFF">Bill Amount Admissible To Be Changed With Bill Amount Contractor</B></td>
			<td align="center"></td>
		</tr>
		<tr>
			<td class="clrborder" align="center">S.No.</td>
			<td class="clrborder" align="center">Work Name</td>
			<td class="clrborder" align="center">Work ID</td>
			<td class="clrborder" align="center">Program</td>
			<td class="clrborder" align="center">SubProgram</td>
			<td class="clrborder" align="center">Sanction Date</td>
			<td class="clrborder" align="center">Sanction&nbsp;Amount<br>
			(in lakhs)</td>
			<td class="clrborder" align="center">Bill SL No.</td>
			<td class="clrborder" align="center">Bill No.</td>
	<td class="clrborder" align="center">Bill Amount Contractor<br>
			(in lakhs)</td>
<!-- <td class="clrborder" align="center"><span class="mandatory">*</span>So Far Refund Amount (In Rupees)</td>
			<td class="clrborder" align="center"><span class="mandatory">*</span>Refund Amount (In Rupees)</td>

			<td class="clrborder" align="center"><span class="mandatory">*</span>Cheque No</td>
			<td class="clrborder" align="left" width="10%" >Cheque Date</td> -->
			<td class="clrborder" align="left" width="10%" >Bill Amount Admissible</td>
			<td class="clrborder" align="center">Remarks</td>
			<td class="clrborder" align="center">Select</td>

		</tr>


		<nested:iterate id="refundForm" property="refundWorks"
			indexId="ndx">


<nested:equal name="refundForm" property="checks" value="on">
<!-- some action -->
	<tr align="left" bgcolor="#E3E4FA">
</nested:equal>

<nested:notEqual name="refundForm" property="checks" value="on">
<!-- some other action -->
	<tr align="left" onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
</nested:notEqual>
		
				<td class="bwborder"><%=count++%></td>

				<td class="bwborder"><bean:write name="refundForm"
					property="work_name" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="work_id" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="programme_name" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="subProgramme_name" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="sanctionDate" /></td>
				<td class="bwborder"><bean:write name="refundForm"
					property="sanctionAmoount" /></td>
					<td class="bwborder"><bean:write name="refundForm"
					property="billSNo" /></td>
					<td class="bwborder"><bean:write name="refundForm"
					property="billNo" /></td>
				<td class="bwborder"><nested:text  name="refundForm" indexed="true"  style="width: 0px" property="releaseAmount" disabled="true" />
				<bean:write name="refundForm" property="releaseAmount" /></td>

					<td class="bwborder">
					<nested:text  name="refundForm" indexed="true"  style="width: 0px" property="admissibleAmount" disabled="true" />
					<bean:write name="refundForm" property="admissibleAmount" /></td>
<html:hidden name="refundForm" property="contractorAmountInRs" indexed="true"  style="width: 120px"  />
<html:hidden name="refundForm" property="admissibleAmountInRs" indexed="true"  style="width: 120px"  />
<html:hidden name="refundForm" property="billNo" indexed="true"  style="width: 120px"  />
<td class="bwborder"><nested:textarea name="refundForm" property="remarks" indexed="true"  style="width: 120px"  /></td>

<td>
<nested:equal name="refundForm" property="checks" value="on">
<!-- some action -->
<input type=checkbox name=check<%=count-1%>  checked value='<bean:write name="refundForm" property="work_id" />' >
</nested:equal>

<nested:notEqual name="refundForm" property="checks" value="on">
<!-- some other action -->
<input type=checkbox name=check<%=count-1%>   value='<bean:write name="refundForm" property="work_id" />' >
</nested:notEqual>
</td>

			</tr>
			</nested:iterate>

		<%if(count==1)
{ %>
		<tr>
			<td colspan="14" align="center" class="btext">No Records</td>
		</tr>
		<%}
	else
	{
		
		%>
		<tr>
			<td colspan="11" align="center"><input type="button" value="Update"
				onClick="fnSave(<%=count %>);"><%-- &nbsp;&nbsp;&nbsp;<input type="button" value="Forward To ENC"
				onClick="fnforwardToENC(<%=count %>);"> --%></td>
		</tr>
		<%
		
	
}
%>
<input type="hidden" name="resultCount" value="<%=count%>">
<html:hidden property="deldate" value='<%=transdate%>'/>
</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
<br>
<br>
<table align=left><tr><td><font color="red">Note:</font></td><td>1.Please Select the Work before saving.</td></tr>
<tr><td><font color="red" colspan=1></font></td><td>2.After Saving then you can forward to ENC.</td></tr>
</table>
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%
 if(session.getAttribute("message")!=null)
 {	
	 String message=(String)session.getAttribute("message");
session.removeAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess)
	</script>
<%
 } %>


	
	
