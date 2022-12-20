<%@ include file="/commons/rws_header1.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<%//System.out.println("in jsp");
java.util.ArrayList samples = new java.util.ArrayList();%>
<html:javascript formName="waterSampleResForm" />
<script language="JavaScript">
<!--
	function getParameters(that)
	{
		var testval=that.value;
	 
		if(that.checked)
		{
			url = "switch.do?prefix=/wquality&page=/WaterSampleRes.do?mode=testview&testCode="+testval+"&testId="+<%=request.getParameter("testId")%>;
			window.open(url,"", "width=850,height=500,left=100,top=150,scrollbars=1,resizable=1");
		}
	}
	
//-->
</script>
<%@ include file="/commons/rws_header2.jsp" %>
<%//System.out.println("in jsp1");%>

<html:form action="/WaterSampleRes.do?mode=edit">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Sample Test Result" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<%//System.out.println("in jsp2");%>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
<tr>
<td class="bwborder" >
<fieldset>
<legend><B>Office Details</B></legend>
<label>
<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
<tr>
    <logic:present name="RWS_USER" property="headOfficeName">
	<td class="bwborder">Head&nbsp;:</td>
	<td class="bwborder">
	<html:text property="headOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
	</td>
	 </logic:present>
	<logic:present name="RWS_USER" property="circleOfficeName">
	<td class="bwborder">Circle&nbsp;:</td>
	<td class="bwborder">
	<html:text property="circleOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
	<html:hidden property="circleOfficeCode" name="RWS_USER" />
	</td>
    </logic:present>
	<logic:present name="RWS_USER" property="divisionOfficeName">
	<td class="bwborder">Division&nbsp;:</td>
	<td class="bwborder">
	<html:text property="divisionOfficeName" name="RWS_USER" readonly="true" styleClass="mytext"  style="width:100px"/>
	<html:hidden property="divisionOfficeCode" name="RWS_USER" />
	</td>
	</logic:present>
	<logic:present name="RWS_USER" property="subdivisionOfficeName">
	<td class="bwborder">Subdivision&nbsp;:</td>
	<td class="bwborder">
	<html:text property="subdivisionOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
	<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
	</td>
	</logic:present>
  	</tr>
	</table>
	</label>
	</fieldset>
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
	<tr >
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Select</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Habitation</font></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Sample Collected By</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Source</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Sample Collected Date</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Lab</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Test</FONT>
	</td>
	</tr>
<%//System.out.println("in jsp3");%>

<logic:present name="watersampleres">
<%
java.util.ArrayList aa = (java.util.ArrayList)session.getAttribute("watersampleres");
//System.out.println("aa size:"+aa.size());
//System.out.println("in jsp3.5");
%>
<%
samples = (java.util.ArrayList)session.getAttribute("watersampleres");
%>
</logic:present>


<tr >

<td  class=mycborder1 align=center>
<%
//System.out.println("source code::"+(String)samples.get(6));
session.setAttribute("sourcecode",(String)samples.get(6));
 %>
<FONT class=myfontclr1>
<input type="radio" name="testCode<%=(String)samples.get(0)%>" value="<%=(String)samples.get(0)%>" onClick="getParameters(this)"></FONT>
</td>

<td  class=mycborder1 >
<FONT class=myfontclr1><%=(String)samples.get(3)%></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><%=(String)samples.get(4)%></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1> <%=(String)samples.get(6)%></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1> <%=(String)samples.get(5)%></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1> <%=(String)samples.get(8)%></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1> <%=(String)samples.get(1)%></FONT>
</td>
</tr>

</table>


        <table cellspacing=2 cellpadding=2 border=1 bordercolor= "#8A9FCD" style="border-collapse:collapse;" rules=none width="100%">
		<tr>
		<td class="bwborder">Update Source Data:</td>
		<td>
		<html:select property="updateSource" styleClass="mycombo">
		<html:option value="">SELECT...</html:option>
		<html:option value="Y">YES</html:option>
		<html:option value="N">NO</html:option>
		</html:select>
		
	<td class="bwborder">Potable&nbsp;&nbsp;:</td>
	<td>
	<html:select property="condemnSource" styleClass="mycombo" >
	<html:option value="">SELECT...</html:option>
	<html:option value="Y">YES</html:option>
	<html:option value="N">NO</html:option>
	</html:select>
	</td>
	 
			<td class="bwborder">Forwarded On&nbsp;:</td>
		<td class="bwborder" nowrap><html:text property="forwadedOn" value="<%=fmt.format(new java.util.Date())%>" size="12" style="width:80px" styleClass="mytext"/>
		<a href="javascript: showCalendar(document.waterSampleResForm.forwadedOn);">
		<img src="<rws:context page='/images/calendar.gif'/>" width="22" height="17" border="0" alt="" align="absmiddle"/></a></td>
	
	<td><font face="verdana" style="font-size:9pt;">Recommendations:</td>
	<td colspan=3><html:textarea property="recommendations" style="width:150px" onkeypress="upperOnly()"/></td>
	</tr>
	</table>
	<tr >
		<td align=center>
		<html:submit property="mode" title="Save the Fields"  styleClass="btext" value="Submit" onclick="return validateWaterSampleResForm(waterSampleResForm)"/>
        <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	    </td>
	</tr>
</table>
  
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>