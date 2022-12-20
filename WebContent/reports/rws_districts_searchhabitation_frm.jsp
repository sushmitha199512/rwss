<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header4.jsp" %>
<html:html>
<script language="JavaScript">
function init()
{
	document.forms[0].mandalName.value = "";
}
function fnSearch()
{
    if(document.forms[0].mandalName.value=="" || document.forms[0].mandalName.value == null)
    {
    	alert("Enter Search String");
		document.forms[0].mandalName.focus();
		return false;
    }
    else
    {
    	return true;
    }
}
function show()
{
	document.getElementById('text').style.display = "block";
}
function showpanchayat()
{
   document.getElementById('text').style.display = "block";
}
function cleartext()
{
	document.forms[0].mandalName.value='';
}
</script>

<body onload="init()";>


<html:form action="DistrictHabitationSearch.do?mode=search" focus="mandalName">
<table border=0 width="340">			
			<tr align="right">
				
				<td class="bwborder" align="right"><a href="/pred/rws_login_frm.jsp">Home</a></td>
			
			</tr>
		</table>

<jsp:include page="/commons/TableHeader3.jsp">
	<jsp:param name="TableName" value="Search" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" align="center">
	<tr>
		<td align="center"><input type=radio name="districtradio"   value="1"  CHECKED onclick="cleartext()" />Mandal&nbsp;&nbsp;&nbsp;&nbsp;</td>
    </tr>
    <tr>
    	<td align="center"><html:radio property="districtradio" value="2"onclick="cleartext()" />Panchayat</td>
	</tr>
   	<tr>
		<td align="center"><html:radio property="districtradio" value="3" onclick="cleartext()"  />Village&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
   	</tr>
   	<tr>
		<td align="center"><html:radio property="districtradio" value="4" onclick="cleartext()"   />Habitation</td>
    </tr>
   	<tr>
    	<td class="textborder" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    Enter Your Search String:&nbsp;<html:text property="mandalName" styleClass="mytext" style="width:80px"/><br></td>
  	</tr>
    <tr>
		<td align=center><html:submit property="mode" title="Search Habitation"  styleClass="btext" value="Search" onclick="return fnSearch()" /></td>
	</tr>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="300"/>
	</jsp:include>
</table>
</html:form>
</body>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
<%if(request.getAttribute("message") != null){ %>
<%@ include file="/commons/rws_alert.jsp"%>
<%} %>

