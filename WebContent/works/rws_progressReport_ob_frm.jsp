<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<head>
<script language="javascript">
	
function copyToClosingBalance()
{
	document.forms[0].closingBalance.value=document.forms[0].openingBalance.value;
}
function getOpeningBalance()
{
	var proceed=true;
	if(document.forms[0].district.value=="")
	{
		alert("District is required");
		proceed=false;
	}
	else if(document.forms[0].financialYear.value=="")
	{
		alert("Financial Year is required");
		proceed=false;
	}
	
	else if(document.forms[0].financialYear.value.length!=9)
	{
		alert("Invalid FinancialYear format.\n Format example: 2005-2006");
		document.forms[0].financialYear.focus();
		proceed=false;
	}
	else if(document.forms[0].financialYear.value.length==9)
	{
		var fromYear=parseInt(document.forms[0].financialYear.value.substring(0,4),10);
		var toYear=parseInt(document.forms[0].financialYear.value.substring(5,9),10);
		if((toYear-fromYear)!=1)
		{								
			alert("Invalid Financial Year format.\nThe difference between fromYear and toYear should be 1\n Format example: 2005-2006");
			document.forms[0].financialYear.focus();
			proceed=false;
		}
	}
	if(proceed)
	{
		document.forms[0].action="/pred/works/ProgressReportOBEntry.do?mode=getOpeningBalance";
		document.forms[0].submit();
	}
	else
	{
		document.forms[0].programme.value="";
	}
}
function validateFrm()
{
	if(document.forms[0].district.value=="")
	{
		alert("District is required");
		return false;
	}
	if(document.forms[0].division.value=="")
	{
		alert("Division is required");
		return false;
	}
	else if(document.forms[0].programme.value=="")
	{
		alert("Programme is required");
		return false;
	}
	else if(document.forms[0].openingBalance.value=="")
	{
		alert("Opening Balance is required");
		return false;
	}
	else if(document.forms[0].financialYear.value=="")
	{
		alert("Financial Year is required");
		return false;
	}
	
	else if(document.forms[0].financialYear.value.length!=9)
	{
		alert("Invalid FinancialYear format.\n Format example: 2005-2006");
		document.forms[0].financialYear.focus();
		return false;
	}
	else if(document.forms[0].financialYear.value.length==9)
	{
		var fromYear=parseInt(document.forms[0].financialYear.value.substring(0,4),10);
		var toYear=parseInt(document.forms[0].financialYear.value.substring(5,9),10);
		if((toYear-fromYear)!=1)
		{								
			alert("Invalid Financial Year format.\nThe difference between fromYear and toYear should be 1\n Format example: 2005-2006");
			document.forms[0].financialYear.focus();
			return false;
		}
		
	}
	
	return true;

}
function fnView()
{
	document.forms[0].action="/pred/works/ProgressReportOBEntry.do?mode=viewOpeningBalance";
	document.forms[0].submit();

}
function submitFrm()
{
	
	if(validateFrm())
	{
		document.forms[0].action="/pred/works/ProgressReportOBEntry.do?mode=saveOpeningBalance";
		document.forms[0].submit();
	}
}
function districtChanged()
{
  document.forms[0].action="/pred/works/ProgressReportOBEntry.do?mode=getDivisions";
  document.forms[0].submit();
}

</script>
</head>
<body>
<html:form action="ProgressReportOBEntry.do" >
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Progress Report Opening Balance Entry Form" />
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
			<legend align="right"></legend>
			<label>
				<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"  style="border-collapse:collapse;" width="100%" >	
					<tr class="clrborder">
					 	<td width="100"><font color="black">District</font></td>
					 	<td>
					 	<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
							<html:select property="district"  styleClass="mycombo" style="width:200px" onchange="JavaScript:districtChanged();">
							<html:option value=""><bean:message key="app.pleaseSelect" />
									</html:option>
									<logic:notEmpty name="districts">
										<html:options collection="districts" name="labelValueBean"
											property="value" labelProperty="label" />
									</logic:notEmpty>
		  					</html:select>
						</logic:equal>
						
						<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
							<html:text property="dname" styleClass="mytext" style="width:200px"
						   		 readonly="true" />
							<html:hidden property="district" />
						</logic:notEqual>
	  					
						</td>
					</tr>
					<tr class="clrborder">
					 	<td width="100"><font color="black">Division</font></td>
					 	<td>
					 	<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
							<html:select property="division"  styleClass="mycombo" style="width:200px">
							<html:option value=""><bean:message key="app.pleaseSelect" />
									</html:option>
									<logic:notEmpty name="divisions">
										<html:options collection="divisions" name="labelValueBean"
											property="value" labelProperty="label" />
									</logic:notEmpty>
		  					</html:select>
						</logic:equal>
						
						<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
							<html:text property="dname" styleClass="mytext" style="width:200px"
						   		 readonly="true" />
							<html:hidden property="district" />
						</logic:notEqual>
	  					
						</td>
					</tr>
					
					
					
					<tr class="clrborder">
					<td><font color="black">Financial Year</font></td>
					<td>
					<!-- 
					<html:text property="financialYear"   
				    			   styleClass="mytext" maxlength="9" style="width:200" onkeypress="return financialYearOnly(event,this)"/>
				    -->
				     <html:select  style="width:200px"
									property="financialYear" styleClass="mycombo" >
									<html:option value="">
										<bean:message key="app.pleaseSelect" />
									</html:option>
									<logic:notEmpty name="financialYearsList">
										<html:options collection="financialYearsList" name="labelValueBean"
											property="value" labelProperty="label" />
									</logic:notEmpty>

					</html:select>
				    </td>	
					</tr>
					<tr class="clrborder">
					<td><font color="black">Programme</font></td>
					<td>
					 <html:select  property="programme"   styleClass="mycombo" style="width:200" onchange="getOpeningBalance()">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						<logic:notEmpty name="programmesList">
		 					  <html:options collection="programmesList" name="labelValueBean"
											property="value" labelProperty="label" />
						<</logic:notEmpty>
	 				</html:select>
	 				</td>	
					</tr>
					<tr class="clrborder">
					<td><font color="black">Opening Balance</font></td>
					<td>
					<%if(request.getAttribute("dataExists")!=null && request.getAttribute("dataExists").equals("true"))
					{%>
					<html:text property="openingBalance"   
				    			   styleClass="mytext"  style="width:200" onkeypress="return decimalsOnly(event,this)" onkeyup="copyToClosingBalance()" readonly="true"/>
				    <%} else{%>
				    <html:text property="openingBalance"   
				    			   styleClass="mytext"  style="width:200" onkeypress="return decimalsOnly(event,this)" onkeyup="copyToClosingBalance()"/>
				    <%} %>
				    </td>	
					</tr>
					<tr>
					<tr class="clrborder">
					<td><font color="black">Closing Balance</font></td>
					<td>
					<%if(request.getAttribute("dataExists")!=null && request.getAttribute("dataExists").equals("true"))
					{%>
					<html:text property="closingBalance"   
				    			   styleClass="mytext"  style="width:200" onkeypress="return decimalsOnly(event,this)" readonly="true"/>
				     <%} else{%>
				    <html:text property="closingBalance"   
				    			   styleClass="mytext"  style="width:200" onkeypress="return decimalsOnly(event,this)"/>
				    <%} %>
				     
				    </td>	
					</tr>
					<tr>
					<td colspan="2" align="center"><input type="button" class="btext" value="Save" onclick="submitFrm()" />
					<input type="button" class="btext" value="View" onclick="fnView()" /></td>
					</tr>
				 </table>
			</label>
			</fieldset>
		</td>
</tr>
</table>
</td></tr></tbody></table>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
			