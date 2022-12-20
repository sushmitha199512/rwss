<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<html:javascript formName="headForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<script language="JavaScript">

function validateHeadForm()
{
	var sourceImg = document.getElementById('hoImage');
    var FileUploadPath = sourceImg.value;  	
	if(document.forms[0].hoc.value=="" || document.forms[0].hoc.value==""){
		alert("Please Enter Head Office Code");
		return false;
	}else if(document.forms[0].hon.value=="" || document.forms[0].hon.value==""){
		alert("Please Enter Head Office Name");
		return false;
	}else if(document.forms[0].hoName.value=="" || document.forms[0].hoName.value==""){
		alert("Please Enter Head Of Office Name");
		return false;
	}else if (!fileMimeType(FileUploadPath)) {			
		return false;
	}else{
		document.forms[0].action="switch.do?prefix=/masters&page=/Head.do?mode=save";
		document.forms[0].submit();	
 	}		
} 

</script>

<html:form  action="/Head.do" method="post" enctype="multipart/form-data">
<jsp:include page="/commons/TableHeader.jsp" >
	<jsp:param name="TableName" value="Head Office Entry Form" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;"  width="340" >
<tr>
<td>
	<table  border=0  width="300"  align=center  style="margin-bottom:5;margin-top:5">
	<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Head Office Code&nbsp;<font color="#ff6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hoc" value="<%=(String)request.getAttribute(\"hcode\")%>" styleClass="mytext" maxlength="1" readonly="true" />
		</td>
		</tr>
		
		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Head Office Name<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hon" value="" styleClass="mytext"  />
		</td>
		</tr>

		<tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Officer Name<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="hoName" value="" styleClass="mytext"  />
		</td>
		</tr>
		
		<!-- teja -->
		 <tr >
		<td  class=mycborder >
		<FONT class=myfontclr>Officer Image<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
	<html:file property="hoImage" value="" styleClass="mytext"  /></td>
		
		</tr> 
		
</table>
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save"  onclick="return validateHeadForm()" />  
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:submit property="mode" title="View All the Fields" styleClass="btext" value="View"  />
	 
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="300"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>