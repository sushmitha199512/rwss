<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/struts-html-el.tld" prefix="htmlel" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<script language="JavaScript">
<!--
function getData2()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/reportsDisplay.do?mode=data";
	document.forms[0].submit();
}

function state()
{

	if(document.forms[0].level[1].checked==true)
	{	
		showdiv('s1');
		showdiv('m1');
	}
	else 
	{
		hidediv('s1');
		hidediv('m1');
	}
}


function hidediv(id)
 {
	//safe function to hide an element with a specified id
	document.getElementById(id).style.display = 'none';
	//document.empForm.dacctest.value="";
 }
function showdiv(id) {
	//safe function to hide an element with a specified id
	document.getElementById(id).style.display = 'block';
 }
	
//-->
</script>



<body onload="javascript:state();">

<html:form action="reportsDisplay.do" >

<%
//System.out.println(request.getPathInfo());
//stem.out.println("Path:"+request.getContextPath()); 
//System.out.println("Path1:"+request.getRequestURI());
//System.out.println("Path1:"+request.getRequestURL().substring(0,22));
%>

<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="760" align="center">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width="20%" height="80%" align = "right" bgcolor="#edf2f8">
	<tr>
<td align="right"><a href="./home.jsp">Home</a>
</tr>
		</table>
	</caption>
<tr>
<td>
	<fieldset>
	<legend>Habitaiton Status Details</legend>
	<label>
		
	<table border=0 width="770" align=center>
		
		<tr>
		<td class="textborder">Level
		
		<html:radio property="level" value="S" onclick="javascript:state();">STATE</html:radio>
		<html:radio property="level" value="D" onclick="javascript:state();">DISTRICT</html:radio>
		</td>
		<td id="s1" class="textborder" style="display:none">District
		<html:select property="district" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()" >
		<html:option value="ALL"><font class="myfontclr1">ALL</html:option>
  	    <logic:present name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
		</td>
	
		<td id="m1" class="textborder" style="display:none">Mandal
		<html:select property="mandal" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()">
		<html:option value="ALL"><font class="myfontclr1">ALL</font></html:option>
		<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
		
		</td>
		</tr>
		</table>
		</label>
		</fieldset>
		<!-- ***************************************************************-->
<tr>
	<td colspan="2" align="center">
		<html:submit property="mode" title="submit" styleClass="btext" value="Submit"/>
		</td>
		</tr>
		
	
</table>
<table><tr><td colspan="10"></td></tr></table>

<%	try
	{	
	java.util.ArrayList state11 = (java.util.ArrayList)session.getAttribute("state");
	//java.util.ArrayList state12 = (java.util.ArrayList)session.getAttribute("state1");

	if(request.getParameter("level").equals("S"))
	{
	%>
	<%@ include file="./rws_habitation_status_state_rpt.jsp" %>
	<%
	}
	
	if(request.getParameter("level").equals("D") && request.getParameter("district").equals("ALL"))
	{
	%>
		<%@ include file="./rws_habitation_status_district_rpt.jsp" %>
	<%
	}	
	if(request.getParameter("level").equals("D") && !request.getParameter("district").equals("ALL"))
	{
	%>
	<%@ include file="./rws_habitation_status_mandal_rpt.jsp" %>
	<%
	}
	
	}catch(Exception e)
	{
	//System.out.println("error in state array"+e);
	}
	
	%>
	
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
