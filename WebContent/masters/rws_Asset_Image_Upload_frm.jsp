<%
java.util.ArrayList selectedHabs = (java.util.ArrayList)session.getAttribute("tempSelectedHabs");
%>
<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetForm" />
<%
String typeOfAsset = request.getParameter("assetTypeCode");

String convType = request.getParameter("convtype");

System.out.println("From JSP"+convType);

%>
<SCRIPT LANGUAGE="JavaScript">

function validateAssetImage(){
	//alert("hi---");
	var file=document.forms[0].uploadAsset.value;
	if(file==""){
		alert("Select Uploaded Asset Image");
		return false;
	}
	else{
		document.forms[0].action="switch.do?prefix=/masters&page=/AssetImage.do&mode=imageUpload";
		document.forms[0].submit();
	}
}
</SCRIPT>

<%@ include file="/commons/rws_header2.jsp" %>

<body id="docBody" onload="check();checkDefunct();linkagealert();showHideDpYield()">
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<html:form action="AssetImage.do" method="post" enctype="multipart/form-data">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Asset Image Upload Form" />
	<jsp:param name="TWidth" value="500"/>
	<jsp:param name="contextHelpUrl" value="/pred/help/assethelp.doc" />
</jsp:include>

<table align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1" style="border-collapse:collapse;" width="540" >	
<tr>
	<td class="mycborder">
		<fieldset>
		<legend>Asset Image</legend>
		<label>
		
	<table border=0 width="520">
	<tr>
	<td width="60"></td>
	<input type="hidden" name="assetCode"  value="<%=(String)session.getAttribute("assetCode")%>"  >
		<td class="textborder">Upload Asset Image
			<span class="mandatory">*</span>
		</td>
		<td class="textborder" >
		<html:file property="uploadAsset" styleClass="mytext"   style="width:250px"/>
		</td>
		
		
	</tr>
	
	</table>
	</label>
	</fieldset>
		</tr>
		<tr>
			<td align="center">
		
			
			  <html:button property="mode" title="Save an Asset Image" styleClass="btext" value="Upload" onclick="return validateAssetImage()" />
			  
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
	// System.out.println("water sample ");
	 String water=(String)session.getAttribute("water");
	// System.out.println("water sample "+water +" "+(water!=null) +" "+water.equals("water"));
	 
	 //String returnVal=(String)session.getAttribute("returnVal");
	 if(water!=null && water.equals("water"))
	 {
	// System.out.println("setsession values null ");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	window.close();
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



