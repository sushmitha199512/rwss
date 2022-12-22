
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/rws_header1.jsp" %>
<html:html>


 

<script language="JavaScript">
function fnSea()
{
var url;
if(document.forms[0].complntno.value== "" || document.forms[0].complntno.value==null)
    {
    alert("Enter Complaint Number");
    return false;
    }
   
  
   else
   {
       
        url="switch.do?prefix=/complaints&page=/ComplaintNogeneric.do?mode=cview";
		document.forms[0].action=url;
		document.forms[0].submit;
   }
}
function fnSearch(url)
{

	 var width = 838;
	 var height = 600;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}


function init()
{
document.forms[0].complntno.value='';
}
</script>
<body>
<%@ include file="/commons/rws_header4.jsp" %>
   <html:form action="ComplaintNogeneric.do">
    <jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Know your Generic Grievance Status " />
	<jsp:param name="TWidth" value="315" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="355" align="center">
<tr>

<td align=center>Complaint Number<font color="#FF6666">*</font>:<html:text property="complntno" 
 styleClass="mytext" style="width:90px"  maxlength="14" size="14"  onkeypress="upperOnly()" />
</td>
</tr>
 <tr>
	<td align=center>
	<html:submit property="mode" title=" Complaint Status"  styleClass="btext" value="Complaint Status" onclick="fnSea();"/>
	<html:submit property="save" title=" Forget Complaint Number"  styleClass="btext"  value="?" onclick="fnSearch('switch.do?prefix=/complaints&page=/ComplaintNogeneric.do?mode=get3');"/></td>
	
	 </tr>
	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="315"/>
</jsp:include>
</table>

</html:form>
</html:html>

<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
</body>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>





