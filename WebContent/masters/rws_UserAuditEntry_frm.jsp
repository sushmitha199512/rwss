<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html>
<head>
<script src="/pred/resources/javascript/jquery-3.6.0.js"></script>
<script language="JavaScript">
function funcBeforeSubmit()
{
	if(document.forms[0].fromDate.value=="")
	{
		alert("Please select From Date");
		return false;
	}
	else if(document.forms[0].toDate.value=="")
	{
		alert("Please select To Date");
		return false;
	}
}
function getToDate()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/UserAudit.do?mode=data1&fromDate="+document.forms[0].fromDate.value;
	//alert('todate is'+document.forms[0].fromDate.value);
	document.forms[0].submit();
}
function getFromDate()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/UserAudit.do?mode=data";
	//alert('todate is'+document.forms[0].fromDate.value);
	document.forms[0].submit();
}

function userCheck()
{
	 var response = '';
	 var path=  window.location.href;
	 var arr  = path.split("page=");
	 $.ajax({ type: "POST",   
	          url: "switch.do?prefix=/admin&page=/ajaxCall.do&modeCheck=AuthCheck&urlPath="+encodeURIComponent(arr[1]),
	          async: false,
	          success : function(resp)
	          {
	        	  resp;
	              //window.location = '/../commons/UnAuthorize.jsp';

	          }
	 });  
}
</script>
</head> 
<body onLoad="userCheck();">

<html:form action="UserAudit.do" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="User Audit Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>
<% 
//System.out.println("Started JSP page of"+request.getParameter("mode")+" datemode-->rws_UserAuditEntry_frm.jsp"); %>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.userid" /><font color="#FF6666">*</font></FONT>
		</td>
	<td class=mycborder>
	<html:select property="user" styleClass="mycombo" style="width:150" onchange="javascript:getFromDate();">
	 <html:option value="00"><font class=myfontclr1>ALL</html:option>
    <html:options collection="users" property="userid" labelProperty="user" />
	</html:select>
	</td></tr>
	
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.from"/><bean:message key="app.date" /><font color="#FF6666">*</font></FONT>
	</td>
	<td class=mycborder >
	 <html:select property="fromDate" styleClass="mycombo" style="width:150" onchange="javascript:getToDate()" >
	 <html:option value=""><font class=myfontclr1>Select...</html:option>
     <html:options collection="fromdates" property="fromDate" labelProperty="fromDate" />
     </html:select>
	</td></tr>
	
	
	<%String mode=null;
	mode=request.getParameter("mode");
	//System.out.println("mode in jsp page :"+mode);
	if(mode.equals("data1"))
	{%>
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.to" /><bean:message key="app.date"/><font color="#FF6666">*</font></FONT>
		</td>
	<td class=mycborder >
	<html:select property="toDate" styleClass="mycombo" style="width:150">
	<!--<html:option value=''>SELECT...</html:option>-->
	<html:options collection="todates" property="toDate" labelProperty="toDate"/>
	</html:select>
	</td>
	</tr>

<%	}
    if(mode.equals("data"))
	{%>
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.to" /><bean:message key="app.date" /><font color="#FF6666">*</font></FONT>
		</td>
	<td class=mycborder >
	<html:select property="toDate" styleClass="mycombo" style="width:150">
	<html:option value="">Select...</html:option>
	</html:select>
	</td>
	</tr>
	<%	}
%>
	
</table>

<tr>
	<td colspan="2" align="center">
		<html:submit property="mode" title="View the Fields" styleClass="btext" value="View" onclick="return funcBeforeSubmit()"/> 
	</td>
</tr>
</table> 

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html> 
