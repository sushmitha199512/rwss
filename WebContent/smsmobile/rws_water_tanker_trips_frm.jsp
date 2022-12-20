<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<script>
function getData2(){   
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/tankerTrips.do?mode=data";
	document.forms[0].submit();     
}
function fnSave()
{	
	var district=document.forms[0].dist.value;	
 	var mandal=document.forms[0].mand.value;	
	var habcode=document.forms[0].habCode.value;	
    var date=document.forms[0].date.value;	
	var nooftrips = document.forms[0].noOfTrips.value;
	if (district == "" || district == null) {
			alert("Please Select District");
			return;
	}else if (mandal == "" || mandal == null) {
		alert("Please Select Mandal");
		return;
	}else if (habcode == "" || habcode == null) {
		alert("Please Select Habitation");
		return;
	}else if (nooftrips == "" || nooftrips == null) {
		alert("Please Enter No. Of Trips");
		return;
	}else if (date == "" || date == null) {
		alert("Please Select Date");
		return;
	}else{
		document.forms[0].action = "switch.do?prefix=/smsmobile&page=/tankerTrips.do&mode=save";
		document.forms[0].submit();
	}
}
function viewfun() {
	var district=document.forms[0].dist.value;	
 	var mandal=document.forms[0].mand.value;		
	if (district == "" || district == null) {
			alert("Please Select District");
			return;
	}else if (mandal == "" || mandal == null) {
		alert("Please Select Mandal");
		return;
	}else{
		document.forms[0].action = "switch.do?prefix=/smsmobile&page=/tankerTrips.do&mode=view";
		document.forms[0].submit();
	}
}
function fnUpdate()
{	
	var date=document.forms[0].date.value;	
	var nooftrips = document.forms[0].noOfTrips.value;
	if (nooftrips == "" || nooftrips == null || nooftrips == "0" ) {
		alert("Please Enter No. Of Trips");
		return;
	}else if (date == "" || date == null) {
		alert("Please Select Date");
		return;
	}else{
		document.forms[0].action = "switch.do?prefix=/smsmobile&page=/tankerTrips.do&mode=modify";
		document.forms[0].submit();
	}
}
function init(){
	var flag=document.forms[0].flag.value;	
	alert(falg);
}
</script>
<body onload="init();">
	<html:form action="/tankerTrips.do">
		<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"	value="${sessionScope.csrfToken}" />
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName"
				value="Target Number Of Trips Form " />
			<jsp:param name="TWidth" value="400" />
		</jsp:include>
		<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1"	styl e=" border-collapse:collapse;" width="400">			
			<tr>
			<td>
			   <fieldset>
			   <legend><bean:message key="legend.habitationDetails"/></legend>
			   <label>
			   <table  border=0  width="400"  align=center  style="margin-bottom:0;margin-top:0">
			      <tr>
				    <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
					<td class="textborder" width="150">
						<html:select property="dist" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
						<html:option value=""><font class="myfontclr1">SELECT...</html:option>
				         <logic:present name="districts">
						<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
				        </logic:present >
						</html:select>
					</td>
					</tr>
					<tr>
					<td class="textborder" width="100"><bean:message key="app.mandal"/><font color="#FF6666">*</font></td>
					<td class="textborder" width="150">
						    <html:select property="mand" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()">
							<html:option value=""><font class="myfontclr1">SELECT...</html:option>
				             <logic:present name="mandals">
							<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
				            </logic:present >
							</html:select>
					</td>
					</tr>
					<%-- <td class="textborder" width="100">
				<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
				<td class="textborder" width="150">
					<html:select property="panchayat" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
					<html:option value="">SELECT...</html:option>
			        <logic:present name="panchayats">
					<html:options collection="panchayats" name="rwsLocationBean" property="value" labelProperty="label" />
			        </logic:present >
					</html:select>
				</td>
				<td class="textborder" width="100">
				<bean:message key="app.village" /><font color="#FF6666">*</font></td>
				<td class="textborder" width="150">
					<html:select property="vill" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
					<html:option value="">SELECT...</html:option>
			        <logic:present name="villages">
					<html:options collection="villages" name="rwsLocationBean" property="value" labelProperty="label" />
			        </logic:present >
					</html:select>
				</td> --%>					
					<tr>
						<td class="textborder" width="100">Habitation<font color="#FF6666">*</font></td>
						<td class="textborder" width="150">
							<html:select property="habCode" styleClass="mycombo" style="width:150px"  onchange="javascript:getData3()">
							<html:option value="">SELECT...</html:option>
						        <logic:present name="habitations">
						  			<html:options collection="habitations" name="labelValueBean" property="value" labelProperty="labelValue" />
						  		  </logic:present >
							</html:select>
						</td>			    
					</tr>
					<tr>
						<td class="textborder" width="100">No.&nbsp;of&nbsp;trips<font color="#FF6666">*</font></td>
						<td class="textborder" width="150">
								<html:text  property="noOfTrips"   styleClass="mytext" style="width:150"  onkeypress="return decimalsOnly(event)"    />
						</td>			    
					</tr>
					<tr>
					<td class="textborder" width="100">Date<font color="#FF6666">*</font></td>
						<td class="textborder" width="150">				    	
				    	<html:text  property="date"   
				    			   styleClass="mytext" style="width:100"  />
				    		   <a href="javascript: showCalendarFuture(document.getElementById('date'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle"> 		
						  </a>
				    </TD>
					</tr>
					</table>
					</label>
				</fieldset>
				</td>
			</tr>
			<tr align=center>
				<td>
				<logic:equal value="save" property="flag" name="tankerTripsForm">
					<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()" />
				</logic:equal>
				<logic:equal value="edit" property="flag" name="tankerTripsForm">
					<html:button property="update" title="Save the Fields" styleClass="btext" value="Update" onclick="return fnUpdate()" />
				</logic:equal>
					<html:button property="View" title="View the Fields" styleClass="btext" value="View" onclick="return viewfun()" />
				</td>
			</tr>
			<html:hidden property="flag"  name="tankerTripsForm"/>
			<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="400"/>
			</jsp:include>
		</table>
	</html:form>
</body>
</html>
<script language="javascript">
<% if(request.getAttribute("message")!=null) {%>
 alert('<%=request.getAttribute("message")%>');
<% }%>
</script>