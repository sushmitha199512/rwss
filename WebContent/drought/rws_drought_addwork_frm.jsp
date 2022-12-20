<%@ include file="/commons/rws_header1.jsp" %>
 <script language="JavaScript">
 			<% int workCount = 0;int count=0;%>
<!--
function setEndoresement(that)
{
	var frm = that.form;
	var fieldValue = that.value;
	if(fieldValue == "OTHERS")
		frm.others.disabled = false;	
	else
	{	
		frm.others.value = "";
		frm.others.disabled = true;	
	}
	
}
function fnSubmit()
{
	var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do";
	var frm = document.forms["RepresentativeProposalForm"];
	frm.action = url;
	frm.submit();
	//return false;
}

function fnAddWork()
{
	var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do&mode=Add";
	var frm = document.forms["RepresentativeProposalForm"];
	frm.action = url;
	frm.submit();
}

function fnGetOffices(that)
{
	var field = that.name;
	
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do"
			+ "&mode=circles";
	else
	if(field == 'circleOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do"
			+ "&mode=divisions";
	else
	if(field == 'divisionOfficeCode')	
		url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do"
			+ "&mode=subdivisions";		
	frm.action = url;
	frm.submit();

}
 
 
function fnGetSubprogrammes(elem)
{
	var index = elem.name.substr(5,1);
//	alert(elem.name + "   "+index);
	
	var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do&mode=subprogrammes"
			+ "&index="+index;
	var frm = document.forms["RepresentativeProposalForm"];
	frm.action = url;
	frm.submit();
}
var newWindow;
 
function setDisplayValues()
{  
	var workCount = document.getElementById("workCount").value;
 
 	var programmecode;
 	var sancAmnt;
 	var admnNo;
	var message ="";
	for(var i=0; i<workCount; i++)
	{
		elementProgrammecode = document.getElementById("WORK["+i+"].programmeCode");
	 	elementSubProgrammeCode = document.getElementById("WORK["+i+"].subprogrammeCode");
	 	var programmeName = elementProgrammecode.options[elementProgrammecode.options.selectedIndex].text;
	 	document.getElementById("WORK["+i+"].programmeName").value=programmeName;
	 	var subProgrammeName = elementSubProgrammeCode.options[elementSubProgrammeCode.options.selectedIndex].text;
	 	document.getElementById("WORK["+i+"].subProgrammeName").value=subProgrammeName;
	 	
	 	  
	}
	if(message.length >0)
	{
		alert(message);
		return false;
	}
	return true;
	
}
function validateWorks()
{  
	var workCount = document.getElementById("workCount").value;
 
 	var programmecode;
 	var sancAmnt;
 	var admnNo;
	var message ="";
	for(var i=0; i<workCount; i++)
	{
		programmecode = document.getElementById("WORK["+i+"].programmeCode").value;
	 	if(programmecode.length == 0 || programmecode == '')
			message+="Programmecode Rquired In Row " + (i+1)+"--";   
		sancAmnt = document.getElementById("WORK["+i+"].sanctionAmout").value;
	 	if(sancAmnt.length == 0 || sancAmnt == '')
			message+="Sanction Amount Rquired In Row " + (i+1)+"--"; 
		admnNo = document.getElementById("WORK["+i+"].adminiStrativeNum").value;
	 	if(admnNo.length == 0 || admnNo == '')
			message+="Admin Sanction Number In Row " + (i+1) + "  "; 
		  
	}
	if(message.length >0)
	{
		alert(message);
		return false;
	}
	return true;
	
}
function fnSave()
{ var val= validateWorks() ;
 
  if(val==true)
	 {
	var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do&mode=Add Programs";
	var frm = document.forms["RepresentativeProposalForm"];
	frm.action = url;
	frm.submit();
	}	 
 	 
}
function fnUpdate()
{ var val= validateWorks() ;
 
  if(val==true)
	 {
		var workId = '<%=request.getParameter("workId")%>';
		var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do&mode=Add Programs&status=stat&workId="+workId;
		var frm = document.forms["RepresentativeProposalForm"];
		frm.action = url;
		frm.submit();
	}	 
}
function UpdateRevProg()
{ var val= validateWorks() ;
   if(val==true)
	 {
		setDisplayValues();
		
		var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do&mode=Add Rev Programs&status=stat";
		var frm = document.forms["RepresentativeProposalForm"];
		frm.action = url;
		frm.submit();
	}	 
}
function UpdateRevFromViewProg()
{ var val= validateWorks() ;
   if(val==true)
	 {
		var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do&mode=AddRevFromViewPrograms";
		var frm = document.forms["RepresentativeProposalForm"];
		frm.action = url;
		frm.submit();
	}	 
}
//-->
</script>
<body>
<html:javascript formName="RepresentativeProposalForm" htmlComment="true" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="AddMoreProgramsForOneWork" >

<table cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>

<thead>
<tr>
<td>
 	   <%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>

   <TABLE CELLPADDING="0" CELLSPACING="0"   style="border-collapse:collapse"  bordercolor= "#8A9FCD">
   <TR>
      <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_t_left1.gif'/>" ALT=""></TD>
	  <TD  bgcolor="#8A9FCD" width=100%>
	  <table border=0 style="border-collapse:collapse" cellpadding=0 cellspacing=0 width="100%">
	  <tr><td >
	  <font color="#000000" face=verdana size=2><B>Add More Than One Programme</B><font></td>
	    <td align=right><IMG SRC="<rws:context page='/images/icon_help.gif'/>" WIDTH="12" HEIGHT="12" >&nbsp;
		<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="window.close()" style="cursor:hand" alt="Close">
		</tr></table>
		</td>
	  <TD WIDTH="20" bordercolor=white><IMG SRC="<rws:context page='/images/r_t_right1.gif'/>" ALT=""></TD>
   </TABLE>
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
	<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" 
		   style="border-collapse:collapse">
	 

	<tr>
	<td>
		<fieldset>
		<legend><bean:message key="legend.workDetails" /></legend>
		<label>
			<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr>
				<th><bean:message key="app.select" /></th>
				<th><bean:message key="app.workName" /></th>
				<th>Work ID</th>
	 	 		<th><bean:message key="app.programme" /></th>
				<th><bean:message key="app.subprogramme" /></th>
				<th>Admin Sanc No.</th>
				<th>Sanction Amount</th>
				<th>Admin Sanc Date</th>
				<logic:present name="UpdateAddedProgragsForRevise">
				<th>Revised Sanc No.</th>
				<th>Revised Sanction Amount </th>
				<th>Revised Sanc Date</th>
				 </logic:present>
				 <logic:present name="FromViewUpdateRevProgs">
				<th>Revised Sanc No.</th>
				<th>Revised Sanction Amount </th>
				<th>Revised Sanc Date</th>
				 </logic:present>
				 
			</tr>
			</thead>
			<tbody>
			<nested:iterate id="WORK" property="proposals" indexId="ndx">
			<% workCount++; %>
			<tr bgcolor="#ffffff">
				<td width="40px" align="center">
					<input type="checkbox" name="remove" value="<%= ndx%>">
				</td>
				<td>
					<nested:text name="WORK" property="workName"   maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()" readonly="true"/>
				</td>
				<td>
					<nested:text name="WORK" property="workId"  maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()"  readonly="true" />
				</td>
		 		<td>
					<logic:present name="programmes1">
						<nested:select name="WORK" property="programmeCode" indexed="true"
									   style="width: 80px" styleClass="noborder-text-box" 
									   onchange="javascript: fnGetSubprogrammes(this)">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<nested:options collection="programmes1" name="labelValueBean" 
										  property="value" labelProperty="label" />
						</nested:select>
						<nested:hidden name="WORK" property="programmeName" indexed="true"/>
					</logic:present>
				</td>
				<td>
					<nested:select name="WORK" property="subprogrammeCode" indexed="true"
								   style="width: 80px" styleClass="noborder-text-box">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:notEmpty name="WORK" property="subprogrammes">
							<nested:optionsCollection property="subprogrammes" />
						</logic:notEmpty>
					</nested:select>
					<nested:hidden name="WORK" property="subProgrammeName" indexed="true"/>
					
				</td>
				<td>
					<nested:text name="WORK" property="adminiStrativeNum" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 />
				</td>
				<td>
					<nested:text name="WORK" property="sanctionAmout" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								   onkeypress="return decimalsOnly(event)" />
				</td>
				
				<td nowrap>
					<nested:text name="WORK" property="adminiStrativeDate" indexed="true" maxlength="10" style="width: 100px;text-align: left" readonly="true"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count++%>].adminiStrativeDate'));">
		             <IMG SRC="<rws:context page='/images/calendar.gif'/>"   border="0" height="17" ></a>
		 		</td>
			<logic:present name="UpdateAddedProgragsForRevise">
				 	<td>
					<nested:text name="WORK" property="revisedAdminiStrativeNum" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box"/>
				    </td>
				 	<td>
					<nested:text name="WORK" property="revisedSanctionAmout" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								   onkeypress="return decimalsOnly(event)" />
				    </td>
				    
				   <td>
					<nested:text name="WORK" property="revisedAdminiStrativeDate" indexed="true" maxlength="10" style="width: 100px;text-align: left"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].revisedAdminiStrativeDate'));">
		             <IMG SRC="<rws:context page='/images/calendar.gif'/>"   border="0" height="17" ></a>
		 		  </td>
		 		  <input type="hidden" value="YES" name="AddNewForRev"/>
			</logic:present>
			<logic:present name="FromViewUpdateRevProgs">
				 	<td>
					<nested:text name="WORK" property="revisedAdminiStrativeNum" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box"/>
				    </td>
				 	<td>
					<nested:text name="WORK" property="revisedSanctionAmout" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								   onkeypress="return decimalsOnly(event)" />
				    </td>
				    
				   <td>
					<nested:text name="WORK" property="revisedAdminiStrativeDate" indexed="true" maxlength="10" style="width: 100px;text-align: left"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count-1%>].revisedAdminiStrativeDate'));">
		             <IMG SRC="<rws:context page='/images/calendar.gif'/>"   border="0" height="17" ></a>
		 		  </td>
		 		  <input type="hidden" value="YES" name="AddNewForRev"/>
			</logic:present>
			</tr>
			</nested:iterate>
			<input type="hidden" name="workCount" value="<%= workCount %>">
			</tbody>
			</table>
			<table width="100%">
			<tr>
			<td align="right">
		        <logic:notPresent name="UpdateAddedProgragsForRevise">
		         <logic:notPresent name="FromViewUpdateRevProgs">
				 <html:button property="mode" styleClass="btext" style="width:120px"
					onclick="return fnAddWork()">
					Add New Programme
				</html:button> 
				
				<%
				System.out.println("workCountworkCountworkCountworkCount:"+workCount);
					if(workCount < 1) { %>
				
				<html:button property="mode" styleClass="btext" style="width:120px"
					onclick="return fnRemove(this)" disabled="true">
					Remove Programme
				</html:button>
				<% } else {%>
				<html:button property="mode" styleClass="btext"
						style="width:120px" onclick="return fnRemove(this)">
					<bean:message key="button.removeWorks" />
				</html:button>
				
				<% } %>
				 </logic:notPresent>
                </logic:notPresent>
			</td>
			</tr>
			</table>
		</label>
		</fieldset>
	</td>
	</tr>
 	<tr>
	<td>
		<table width="100%">
		<tr>
			<td align="center">
			    <logic:notPresent name="UpdateAddedProgras">
			    <logic:notPresent name="UpdateAddedProgragsForRevise">
			    <logic:notPresent name="FromViewUpdateRevProgs">
				<html:button property="mode" styleClass="btext" onclick="return fnSave()">
					Add Programs
				</html:button>
				</logic:notPresent>
				</logic:notPresent>
				</logic:notPresent>
				<logic:present name="UpdateAddedProgras">
				<html:button property="mode" styleClass="btext" onclick="return fnUpdate()">
				  Update
			 	</html:button>
				 <input type="hidden" value="YES" name="UpdateProg"/>
				</logic:present>
			 	<logic:present name="UpdateAddedProgragsForRevise">
				<html:button property="mode" styleClass="btext" onclick="return UpdateRevProg()">
				  Update   
			 	</html:button>
				 <input type="hidden" value="YES" name="UpdateProg"/>
				</logic:present>
			 	<logic:present name="FromViewUpdateRevProgs">
				<html:button property="mode" styleClass="btext" onclick="return UpdateRevFromViewProg()">
				  Update  
			 	</html:button>
				 <input type="hidden" value="YES" name="UpdateProg"/>
				</logic:present>
				<html:reset property="mode" styleClass="btext">
					<bean:message key="button.clear" />
				</html:reset>
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
<html:hidden property="init" />
<html:hidden property="userId" name="RWS_USER" />
<html:hidden property="officeCode" name="RWS_USER" />
</html:form>
<%
 if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	if(mess=="Programs Added Successfully"|| mess=="Revised Programs Added Successfully")
		self.close();
	</script>
<%
 }
 %>
 <script>
 function fnRemove(that)
{
	var frm = that.form;
	var removeIds = frm.elements("remove");
	var workCountt = '<%=workCount%>';
	if(workCountt>0)
	{
		var len = removeIds.length;
		var count = 0;
		if(typeof len != "number")
			removeIds = [removeIds];
		if(workCountt==1)
		{
			if(document.forms[0].remove.checked==true)
				count++;
		}
		else
		{
			for(var i=0; i<workCountt; i++)
			{
				if(document.forms[0].remove[i].checked==true)
					count++;
			}
		}
		if(count == 0)
			alert("Please select atleast one work to remove!");
		else		
		{
			var workId = '<%=request.getParameter("workId")%>';
			var url = "switch.do?prefix=/drought&page=/AddMoreProgramsForOneWork.do"
				+ "&mode=Remove&workId="+workId;
			frm.action = url;
			frm.submit();		  
		}
	}
}
 </script>
</body>
<%@ include file="/commons/rws_footer.jsp" %>