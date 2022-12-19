<%@ include file="/commons/rws_header1.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<script>
function fnContinue(){

	return true;
	//document.forms[0].action="switch.do?prefix=/works&page=/TokenVerify.do&mode=processToken";
	//document.forms[0].submit();
	//var openerDoc = opener.document;
	//openerDoc.getElementById("frwdButton").disabled =false;
	

}

function processToken()
{
	//alert("yes calling");

		var signdatabase64 = document.SmartCardSignerApplet.signFilefromJS("sasasa");
	alert(signdatabase64);
	//document.forms[0].action="switch.do?prefix=/masters&page=/eeDSRegForm.do&mode=processCertificate&signvalue="+signdatabase64;
	//document.forms[0].submit();

	}
</script>
</head>
<body bgcolor="#f0ffff">
<html:form action="/TokenVerify.do?mode=processToken" >
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Token Details" />
	<jsp:param name="TWidth" value="100%" />
	</jsp:include>
	<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border=1 style="border-collapse:collapse;">
	<tr><td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Token&nbsp;Password:&nbsp;&nbsp;&nbsp;</td><td><html:password property="pinValue" ></html:password></td><td><html:submit property="btn"  styleClass="btext1" value="Continue"  onclick=" processToken();"></html:submit></td></tr>
	</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>
 <APPLET  code="nic.otc.SmartCardSignerApplet.class"  NAME="SmartCardSignerApplet" archive="applet/SmartCardSignerApplet.jar" width=500 height=500 MAYSCRIPT>  
  </APPLET>  

</body>
</html>