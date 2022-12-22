
<%@ include file="/commons/rws_header1.jsp" %>


<SCRIPT LANGUAGE="JavaScript">

function validateWorkImage(){
	
	var file=document.forms[0].scannedCopy.value;
	if(file==""){
		alert("Select Uploaded Work Image");
		return false;
	}
	else{
		document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=saveImage";
        document.forms[0].submit();
	}
}
</SCRIPT>

<%@ include file="/commons/rws_header2.jsp" %>

<body id="docBody" onload="check();checkDefunct();linkagealert();showHideDpYield()">
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<html:form action="aap1.do" method="post" enctype="multipart/form-data">
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Work Image Upload Form" />
	<jsp:param name="TWidth" value="500"/>

</jsp:include>

<table align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1" style="border-collapse:collapse;" width="540" >	
<tr>
	<td class="mycborder">
		<fieldset>
		<legend>Work Image</legend>
		<label>
		
	<table border=0 width="520">
	<tr>
	<td width="60"></td>
	<%-- <input type="hidden" name="workId"  value="<%=(String)session.getAttribute("workId")%>"  > --%>
	<html:hidden property="workId" styleClass="mytext"   style="width:250px"/>
		<td class="textborder">Upload Work Image
			<span class="mandatory">*</span>
		</td>
		<td class="textborder" >
		<html:file property="scannedCopy" styleClass="mytext"   style="width:250px"/>
		</td>
		
		
	</tr>
	
	</table>
	</label>
	</fieldset>
		</tr>
		<tr>
			<td align="center">
		
			
			  <html:button property="mode" title="Save an Work Image" styleClass="btext" value="Upload" onclick="return validateWorkImage()" />
			  
			</td>
		</tr>
		
	</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="500" />
</jsp:include>
<br>


</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%
if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
	 String water=(String)session.getAttribute("water");
	 if(water!=null && water.equals("water"))
	 {
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	window.close();
	document.forms[0].action="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=getWorks";
	document.forms[0].submit();
	</script>
<%  }
 else
 {
 %>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	window.close();
	</script>
<%
 }
 }
				
%>



