<%@ include file="/commons/rws_header1.jsp" %>


</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<%nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(); %>
<table align="center" cellpadding="0" cellspacing="0">
<tr>
<td>
<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
<tr>
<td>
<fieldset>
<legend>Office Details</legend>
<label>
	<table >
	<tbody class="label">
	<tr>
	<logic:present name="RWS_USER" property="headOfficeName">
		<td  ><b><bean:message key="app.headoffice" /></b></td>
		<td  >
			<logic:equal name="RWS_USER" property="headOfficeCode" value="0">
				<html:select property="headOfficeCode" onchange="javascript: fnGetOffices(this)"
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="headOffices" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
					<html:text property="headOfficeName"   styleClass="label"
							name="RWS_USER" readonly="true"/>
					<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual>
		</td>
		</logic:present>
		<logic:present name="RWS_USER" property="circleOfficeName">
		<td  ><b><bean:message key="app.circle" /></b></td>
		<td  >
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode" onchange="javascript: fnGetOffices(this)" 
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName"  styleClass="label"
						   name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
		</logic:present>
	    <logic:present name="RWS_USER" property="divisionOfficeName">
		<td  ><b><bean:message key="app.division" /></b></td>
		<td  >
		<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:select property="divisionOfficeCode" onchange="javascript: fnGetOffices(this)"
						 styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:text property="divisionOfficeName"  styleClass="label"
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		</logic:present>
		<logic:present name="RWS_USER" property="subdivisionOfficeName">
		<td ><b><bean:message key="app.subdivision" /></b></td>
		<td >
		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subdivisionOfficeCode" styleClass="combo"
						 onchange="javascript: fnGetOffices(this)">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName"  styleClass="label"
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		</logic:present>
	</tr>
	</tbody> 
	</table>
	
</label>
</fieldset>
</td>
</tr>

<logic:present name="repWorks">
 
<tr bgcolor="#DEE3E0">
<td>

<fieldset>
<legend>Representative Proposals Pending for administrative sanction</legend>
<label>
<%int sno=1;%>
<table bgcolor="#DEE3E0" border="1" bordercolor="black" align="center" width="750" cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr bgcolor="#8A9FCD">
    <th><bean:message key="app.sno" /></th>
 	<th><bean:message key="app.workname" /></th>
	<th><bean:message key="app.proposalid" /></th>
	<th><bean:message key="app.proposaldate" /></th>
	<th><bean:message key="app.repName" /></th>
 	<th><bean:message key="app.scheme" /></th>
	<th><bean:message key="app.programme" /></th>
	<th><bean:message key="app.subprogramme" /></th>
 	<th><bean:message key="app.estimatecost" />(Rs. in lakhs)</th>
	 
</tr>
</thead>
 <tbody class="label">
 <!-- code added -->
 	 
 	 <c:set var="officeCode" value="" />
 	 <%String officeCode=""; %>
	 <c:set var="user" value="${sessionScope.RWS_USER.officeName}" scope="request" />
	 <%String user=(String)request.getAttribute("user"); %>
	 <%String headOfficeCode="",circleOfficeCode="",divisionOfficeCode="",subDivisionOfficeCode="";boolean circleChanged=false,divisionChanged=false,subDivisionChanged=false; %>
	 <c:forEach items="${sessionScope.repWorks}" var="item" varStatus="status">
	 <c:set var="index" value="${status.index}" />
	 <c:set var="officeCode" value="${item.subdivisionOfficeCode}" scope="request" />
	 <%officeCode=(String)request.getAttribute("officeCode"); %>
	 <%
	if(headOfficeCode.equals(""))
	{
		 headOfficeCode=officeCode.substring(0,1);
	}
	if(circleOfficeCode.equals("") && !user.equals("Head Office"))
	{
	 	circleOfficeCode=officeCode.substring(1,3);
	}
	if(divisionOfficeCode.equals("") && !(user.equals("Circle Office")||user.equals("Head Office")))
	{
	 	divisionOfficeCode=officeCode.substring(3,4);
	}
	
	if(!(circleOfficeCode.equals(officeCode.substring(1,3))) &&!(user.equals("Sub Division Office"))&&!(user.equals("Division Office"))&&!(user.equals("Circle Office")))
	{ 
		circleOfficeCode=officeCode.substring(1,3);
	 	circleChanged=true;
	} 
	if(((!divisionOfficeCode.equals(officeCode.substring(3,4)))||circleChanged) &&!(user.equals("Sub Division Office")) && !(user.equals("Division Office")))
	{ 
		divisionOfficeCode=officeCode.substring(3,4); 
	 	divisionChanged=true;
	}
	
	if((!subDivisionOfficeCode.equals(officeCode.substring(4,6))||divisionChanged) &&!(user.equals("Sub Division Office")))
	 { 
	 	subDivisionOfficeCode=officeCode.substring(4,6); 
	 	subDivisionChanged=true;
	 } 
	 if(circleChanged && divisionChanged && subDivisionChanged)
	 {%>
	 	<tr class="row1"><td bgcolor="lightyellow" colspan="20" >Proposals submitted from  <%= rwsOffices.getCircleOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,officeCode.substring(1,3))%> Circle
	 	<%= rwsOffices.getDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,officeCode.substring(3,4))%> Division
	 	<%= rwsOffices.getSubDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,divisionOfficeCode,officeCode.substring(4,6)) %> SubDivision</td></tr>
	 <%}
	 else if(divisionChanged && subDivisionChanged)
	 {%>
	 	<tr class="row1"><td bgcolor="lightyellow" colspan="20" >Proposals submitted from  <%= rwsOffices.getDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,officeCode.substring(3,4))%> Division
	 	<%= rwsOffices.getSubDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,divisionOfficeCode,officeCode.substring(4,6)) %> SubDivision</td></tr>
	 <%}
	 else if(subDivisionChanged)
	 {%>
	 	<tr class="row1"><td bgcolor="lightyellow" colspan="20" >Proposals submitted from  <%= rwsOffices.getSubDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,divisionOfficeCode,officeCode.substring(4,6))%> Sub Division
	 <%} 
	 circleChanged=false;divisionChanged=false;subDivisionChanged=false;
	 %>
	<tr class='<c:out value="row${index%2}"/>'>
	<td width="30"><%=sno++%>
   	<td width="145" ><c:out value="${item.proposalName}" />
		</td>
		<td align="center" width="85"><c:out value="${item.proposalId}" /></td>
		<td align="center" width="65"><c:out value="${item.proposalDate}" /></td>
		<td align="center" width="85"><c:out value="${item.repName}" /></td>
		<td align="left" width="60">&nbsp;<c:out value="${item.assetName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.programmeName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.subprogrammeName}" /></td>
 		<td align="right" width="60">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.estimateCost}" />&nbsp;
		</td>
	</tr>
	</c:forEach>
 </tbody>
</table><br>
</label>
</fieldset>
</td>
</tr>
</logic:present>


<logic:present name="adminSanctionWorks">
 
<tr bgcolor="#DEE3E0">
<td>
<fieldset>
<legend>Proposals with Administratively Sanctioned</legend>
<label>
<%int sno=1;%>
<table bgcolor="#DEE3E0" border="1" bordercolor="black" align="center" width="750" cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr bgcolor="#8A9FCD">
    <th><bean:message key="app.sno" /></th>
 	<th><bean:message key="app.workname" /></th>
	<th><bean:message key="app.proposalid" /></th>
  	<th><bean:message key="app.scheme" /></th>
	<th><bean:message key="app.programme" /></th>
	<th><bean:message key="app.subprogramme" /></th>
 	<th><bean:message key="app.estimatecost" />(Rs.)</th>
 	<th><bean:message key="app.administrativeDate" /></th>
 	<th>Sanctioned Amount(Rs.)</th>
 	<th><bean:message key="app.sanctioningAuthority" /></th>
	 
</tr>
</thead>
 <tbody class="label">
 	 <c:set var="officeCode" value="" />
 	 <%String officeCode=""; %>
	 <c:set var="user" value="${sessionScope.RWS_USER.officeName}" scope="request" />
	 <%String user=(String)request.getAttribute("user"); %>
	 <%String headOfficeCode="",circleOfficeCode="",divisionOfficeCode="",subDivisionOfficeCode="";boolean circleChanged=false,divisionChanged=false,subDivisionChanged=false; %>
	
	 <c:forEach items="${sessionScope.adminSanctionWorks}" var="item" varStatus="status">
	 
	 <c:set var="officeCode" value="${item.subdivisionOfficeCode}" scope="request" />
	 <%officeCode=(String)request.getAttribute("officeCode"); %>
	 <%
	 if(headOfficeCode.equals(""))
	 {
		headOfficeCode=officeCode.substring(0,1);
	 }
	 if(circleOfficeCode.equals("") && !user.equals("Head Office"))
	 {
	 	circleOfficeCode=officeCode.substring(1,3);
	 }
	 if(divisionOfficeCode.equals("") && !(user.equals("Circle Office")||user.equals("Head Office")))
	 {
	 	divisionOfficeCode=officeCode.substring(3,4);
	 }
	 
	 if(!(circleOfficeCode.equals(officeCode.substring(1,3))) &&!(user.equals("Sub Division Office"))&&!(user.equals("Division Office"))&&!(user.equals("Circle Office")))
	 { 
	 	circleOfficeCode=officeCode.substring(1,3);
	 	circleChanged=true;
	 } 
	 
	 if(((!divisionOfficeCode.equals(officeCode.substring(3,4)))||circleChanged) &&!(user.equals("Sub Division Office")) && !(user.equals("Division Office")))
	 { 
	 	divisionOfficeCode=officeCode.substring(3,4); 
	 	divisionChanged=true;
	 }
	
	if((!subDivisionOfficeCode.equals(officeCode.substring(4,6))||divisionChanged) &&!(user.equals("Sub Division Office")))
	 { 
	 	subDivisionOfficeCode=officeCode.substring(4,6); 
	 	subDivisionChanged=true;
	 } 
	 if(circleChanged && divisionChanged && subDivisionChanged)
	 {%>
	 	<tr class="row1"><td bgcolor="lightyellow" colspan="20" >Proposals submitted from  <%= rwsOffices.getCircleOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,officeCode.substring(1,3))%> Circle
	 	<%= rwsOffices.getDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,officeCode.substring(3,4))%> Division
	 	<%= rwsOffices.getSubDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,divisionOfficeCode,officeCode.substring(4,6)) %> SubDivision</td></tr>
	 <%}
	 else if(divisionChanged && subDivisionChanged)
	 {%>
	 	<tr class="row1"><td bgcolor="lightyellow" colspan="20" >Proposals submitted from  <%= rwsOffices.getDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,officeCode.substring(3,4))%> Division
	 	<%= rwsOffices.getSubDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,divisionOfficeCode,officeCode.substring(4,6)) %> SubDivision</td></tr>
	 <%}
	 else if(subDivisionChanged)
	 {%>
	 	<tr class="row1"><td bgcolor="lightyellow" colspan="20" >Proposals submitted from  <%= rwsOffices.getSubDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,divisionOfficeCode,officeCode.substring(4,6))%> Sub Division
	 <%} 
	 circleChanged=false;divisionChanged=false;subDivisionChanged=false;
	 %>
	
	<c:set var="index" value="${status.index}" />
	<tr class='<c:out value="row${index%2}"/>'>
	<td width="30"><%=sno++%>
   	<td width="145" ><c:out value="${item.proposalName}" />
		</td>
		<td align="center" width="85"><c:out value="${item.proposalId}" /></td>
 		<td align="left" width="60">&nbsp;<c:out value="${item.assetName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.programmeName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.subprogrammeName}" /></td>
 		<td align="right" width="60">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.estimateCost}" />&nbsp;
		</td>
		<td align="left" width="70">&nbsp;<c:out value="${item.adminDate}" /></td>
		<td align="right" width="60">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.sanctionedAmount}" />&nbsp;
		</td>
		<td align="left" width="70">&nbsp;<c:out value="${item.sanctioningAuthority}" /></td>
	</tr>
	</c:forEach>
 </tbody>
</table><br>
</label>
</fieldset>
</td>
</tr>
</logic:present>



<logic:present name="techSanctionWorks">
 
<tr bgcolor="#DEE3E0">
<td>
<fieldset>
<legend>Proposals with Technical Sanctioned </legend>
<label>
<%int sno=1;%>
<table bgcolor="#DEE3E0" border="1" bordercolor="black" align="center" width="750" cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr bgcolor="#8A9FCD">
    <th><bean:message key="app.sno" /></th>
 	<th><bean:message key="app.workname" /></th>
	<th><bean:message key="app.proposalid" /></th>
  	<th><bean:message key="app.scheme" /></th>
	<th><bean:message key="app.programme" /></th>
	<th><bean:message key="app.subprogramme" /></th>
 	<th><bean:message key="app.estimatecost" />(Rs.)</th>
  	<th>Sanctioned Amount(Rs.)</th>
 	<th>Technical Sanction Date</th>
	 
</tr>
</thead>
 <tbody class="label">
 	 <c:set var="officeCode" value="" />
 	 <%String officeCode=""; %>
	 <c:set var="user" value="${sessionScope.RWS_USER.officeName}" scope="request" />
	 <%String user=(String)request.getAttribute("user"); %>
	 <%String headOfficeCode="",circleOfficeCode="",divisionOfficeCode="",subDivisionOfficeCode="";boolean circleChanged=false,divisionChanged=false,subDivisionChanged=false; %>
	 <c:forEach items="${sessionScope.techSanctionWorks}" var="item" varStatus="status">
	   	<c:set var="index" value="${status.index}" />
	   	<c:set var="officeCode" value="${item.subdivisionOfficeCode}" scope="request" />
	 	<%officeCode=(String)request.getAttribute("officeCode"); %>
		<%
		if(headOfficeCode.equals(""))
	 	{
	 		headOfficeCode=officeCode.substring(0,1);
	 	}
	 	if(circleOfficeCode.equals("") && !user.equals("Head Office"))
	 	{
	 		circleOfficeCode=officeCode.substring(1,3);
	 	}
	 	if(divisionOfficeCode.equals("") && !(user.equals("Circle Office")||user.equals("Head Office")))
	 	{
	 		divisionOfficeCode=officeCode.substring(3,4);
	 	}
	 	if(!(circleOfficeCode.equals(officeCode.substring(1,3))) &&!(user.equals("Sub Division Office"))&&!(user.equals("Division Office"))&&!(user.equals("Circle Office")))
	 	{ 
	 		circleOfficeCode=officeCode.substring(1,3);
	 	 	circleChanged=true;
	 	} 
	  	if(((!divisionOfficeCode.equals(officeCode.substring(3,4)))||circleChanged) &&!(user.equals("Sub Division Office")) && !(user.equals("Division Office")))
	 	{ 
	 		divisionOfficeCode=officeCode.substring(3,4); 
	 		divisionChanged=true;
		}
		if((!subDivisionOfficeCode.equals(officeCode.substring(4,6))||divisionChanged) &&!(user.equals("Sub Division Office")))
	 	{ 
	 		subDivisionOfficeCode=officeCode.substring(4,6); 
	 		subDivisionChanged=true;
		} 
	 	if(circleChanged && divisionChanged && subDivisionChanged)
	 	{%>
	 		<tr class="row1"><td bgcolor="lightyellow" colspan="20" >Proposals submitted from  <%= rwsOffices.getCircleOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,officeCode.substring(1,3))%> Circle
	 		<%= rwsOffices.getDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,officeCode.substring(3,4))%> Division
	 		<%= rwsOffices.getSubDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,divisionOfficeCode,officeCode.substring(4,6)) %> SubDivision</td></tr>
	 	<%}
	 	else if(divisionChanged && subDivisionChanged)
	 	{%>
	 		<tr class="row1"><td bgcolor="lightyellow" colspan="20" >Proposals submitted from  <%= rwsOffices.getDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,officeCode.substring(3,4))%> Division
	 		<%= rwsOffices.getSubDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,divisionOfficeCode,officeCode.substring(4,6)) %> SubDivision</td></tr>
	 	<%}
	 	else if(subDivisionChanged)
	 	{%>
	 		<tr class="row1"><td bgcolor="lightyellow" colspan="20" >Proposals submitted from  <%= rwsOffices.getSubDivisionOfficeName((javax.sql.DataSource)request.getAttribute("dataSource"),headOfficeCode,circleOfficeCode,divisionOfficeCode,officeCode.substring(4,6))%> Sub Division
	 	<%} 
	 	circleChanged=false;divisionChanged=false;subDivisionChanged=false;
	 	%>
	 	<tr class='<c:out value="row${index%2}"/>'>
		<td width="30"><%=sno++%>
   		<td width="145" ><c:out value="${item.proposalName}" />
		</td>
		<td align="center" width="85"><c:out value="${item.proposalId}" /></td>
 		<td align="left" width="60">&nbsp;<c:out value="${item.assetName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.programmeName}" /></td>
		<td align="left" width="70">&nbsp;<c:out value="${item.subprogrammeName}" /></td>
 		<td align="right" width="80">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.estimateCost}" />&nbsp;
		</td>

		<td align="right" width="60">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.sanctionedAmount}" />&nbsp;
		</td>
		<td align="left" width="70">&nbsp;<c:out value="${item.adminDate}" /></td>
	</tr>
	</c:forEach>
 </tbody>
</table><br>
</label>
</fieldset>
</td>
</tr>
</logic:present>


<logic:present name="completedWorks" >
<tr bgcolor="#DEE3E0">
<td>
<fieldset>
<legend>Completed Works</legend>
<label>
<%int sno=1;%>
<table bgcolor="#DEE3E0" border="1" bordercolor="black" align="center" width="750" cellpadding="0" 
cellspacing="0" style="border-collapse:collapse">
<thead class="gridHeader">
<tr bgcolor="#8A9FCD">
    <th><bean:message key="app.sno" /></th>
 	<th><bean:message key="app.workId" /></th>
	<th><bean:message key="app.workName" /></th>
  	<th><bean:message key="app.habitation" /></th>
 	<th><bean:message key="app.assetCost" />(Rs.)</th>
	<th><bean:message key="app.location" /></th>
	<th><bean:message key="app.assetStatus" /></th>
	<th><bean:message key="app.startYear" /></th>
	<th><bean:message key="app.endYear" /></th>
   
	 
</tr>
</thead>
 <tbody class="label">
 	 
	<c:forEach items="${sessionScope.completedWorks}" var="item" varStatus="status">
	 
	<tr class='<c:out value="row${index%2}"/>'>
	<td width="30"><%=sno++%>
   	<td width="85" ><c:out value="${item.assetCode}" />
		</td>
		<td align="center" width="145"><c:out value="${item.assetName}" /></td>
 		<td align="left" width="60">&nbsp;<c:out value="${item.leadHabitation}" /></td>
 		<td align="right" width="80">
			<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	value="${item.assetCost}" />&nbsp;
		</td>
		<td align="left" width="70">&nbsp;<c:out value="${item.location}" /></td>
 		<td align="left" width="70">&nbsp;<c:out value="${item.assetStatus}" /></td>
 		<td align="left" width="70">&nbsp;<c:out value="${item.startYear}" /></td>
 		<td align="left" width="70">&nbsp;<c:out value="${item.endYear}" /></td>
	</tr>
	</c:forEach>
 </tbody>
</table><br>
</label>
</fieldset>
</td>
</tr>
</logic:present>


 </table>


<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>

</body>
</html>
