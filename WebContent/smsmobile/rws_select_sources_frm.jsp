<%@include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@page import="java.sql.*, java.util.*, java.util.Date, java.text.* " %>
<%@page import="nic.watersoft.smsmobile.*"%>
<%	
	String habitation = request.getParameter("habitation");
String mesid=request.getParameter("msgid");
String value=request.getParameter("count");
String astcode="";
if(astcode.equals(""))
	astcode=request.getParameter("astCode");

%>
<html>
<title> WaterSoft </title>
<head>
<script>
window.history.forward(1);
function sourceSelected(index)
{
	var sourceCode=document.forms[0].elements["source["+index+"].sourceCode"].value;
	var astCode=document.forms[0].elements["source["+index+"].assetCode"].value;
	var sourceName=document.forms[0].elements["source["+index+"].sourceName"].value+"/"+document.forms[0].elements["source["+index+"].location"].value;
	var assetName=document.forms[0].elements["source["+index+"].assetName"].value;
if(window.opener!=null&& !window.opener.closed){
window.opener.document.forms[0].elements["schemes["+<%=value%>+"].assetCode"].value=astCode;
window.opener.document.forms[0].elements["schemes["+<%=value%>+"].assetName"].value=assetName;
window.opener.document.forms[0].elements["schemes["+<%=value%>+"].sourceCode"].value=sourceCode;
window.opener.document.forms[0].elements["schemes["+<%=value%>+"].sourceName"].value=sourceName;
window.opener.document.forms[0].elements["schemes["+<%=value%>+"].astType"].value=astCode.substring(6,8);
<%-- window.opener.document.forms[0].elements["schemes["+<%=value%>+"].repairs"].value=sourceName; --%>
//window.opener.document.forms[0].action="switch.do?prefix=/smsmobile&page=/SchemesActionTaken.do?&mesid="+mesid+"&sourceCode="+sourceCode+"&astCode="+astCode+"&mode=sourceprint";
window.opener.document.forms[0].action="switch.do?prefix=/smsmobile&page=/SchemesActionTaken.do&mode=sourceprint";
window.opener.document.forms[0].submit(); 
}
self.close();
}
</script>
</head>
<body bgcolor="#edf2f8">

<p align="center">
<font face=verdana size=2><b></b></font>
</p>


<%-- <html:form  action="SchemesActionTaken" method="post"> --%>
<form name="f1" method="post">

<BR>
<table border= 0 cellspacing = 0 cellpadding = 0   bordercolor=#000000 style="border-collapse:collapse" bgcolor="">	
	
	<tr>
		<td class="textborder" align="center" >Select Asset Code<font color="red">*</font>	:	
		<%-- <html:select property="astCode" styleClass="mycombo" style="width:200px"   onchange="source();return:true;">
		<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
       	<html:options collection="assets" name="labelValueBean" property="value" labelProperty="label" />
       	</html:select> --%>
       	<select name="astCode" onchange="this.form.submit()">
       	<option value="">select</option>
       	<%String qry="select ASSET_CODE,ASSET_NAME FROM RWS_ASSET_MAST_TBL WHERE HAB_CODE='"+habitation+"' AND TYPE_OF_ASSET_CODE IN ('01','02','03','04','09')"; 
       		stmt=conn.createStatement();
       		rs=stmt.executeQuery(qry);
       		while(rs.next()){%>
       		<option value="<%=rs.getString("ASSET_CODE")%>" ><%=rs.getString("ASSET_CODE") %>-<%=rs.getString("ASSET_NAME") %></option>
       		<%}%>
       		</select>
		</td>
	</tr>
	</table>
<br>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	
	
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>Sources in Above Selected Asset</td>	
	</tr>
	<tr align = center>
		<td class=btext >Sl.No</td>
		<td class=btext >select</td>
      	<td class=btext >Scheme Type</td>
        <td class=btext >Source Code </td>
        <td class=btext >Source Name </td>
		<td class=btext >Location</td>
		<td class=btext >Status</td>
		<td class=btext >LATITUDE</td>
		<td class=btext >LONGITUDE </td>
	</tr>
<%

if(astcode!=null && !astcode.equals("")){
	//System.out.println(astcode);
    SMSBased_WQ_Schemes_Drought_DAO residualChlorineDAO=new SMSBased_WQ_Schemes_Drought_DAO(); 
	java.util.ArrayList sources =new  java.util.ArrayList();
	java.util.ArrayList repairs =new  java.util.ArrayList();
	sources=residualChlorineDAO.getAllComponents(astcode);
	request.setAttribute("sources",sources);

int count=0; %>

	<nested:iterate id="source" name="sources" indexId="ndx">
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" > <%=count %></td>
<td  class="bwborder" >	<input type="radio" name="radio1" onclick="<%= "javascript : sourceSelected(" +ndx +"); " %>" ></td>
<td  class="bwborder" align=left nowrap><nested:write name="source" property="astType" /></td>
<td class="bwborder">
	<nested:hidden name="source" property="sourceCode" indexed="true"/> 
	<nested:hidden name="source" property="sourceName" indexed="true"/> 
	<nested:write name="source" property="sourceCode" />
</td>
<td  class="bwborder" align=left nowrap><nested:write name="source" property="sourceName" /></td>
<td  class="bwborder" align=left nowrap><nested:write name="source" property="location" /></td>
<td  class="bwborder" align=left nowrap><nested:write name="source" property="status" /></td>
<td  class="bwborder" align=left nowrap><nested:write name="source" property="latitude" /></td>
<td  class="bwborder" align=left nowrap><nested:write name="source" property="longitude" /></td>
<td  class="bwborder" align=left nowrap>
<%-- <nested:select name="source" property="repCode" styleClass="mycombo" style="width:140px" indexed="true">
<nested:notEmpty name="source" property="repairs">
<nested:optionsCollection property="repairs"  label="label" value="value"/>
</nested:notEmpty>
</nested:select> --%>
</td>
<nested:hidden name="source" property="assetCode" indexed="true" />
<nested:hidden name="source" property="assetName" indexed="true" />
<nested:hidden name="source" property="location" indexed="true" />
<%-- <nested:hidden name="source" property="repairs" indexed="true" /> --%>
</tr>
</nested:iterate>
	
	<% if(count==0) 
		{%>
		<tr><td  align="center"  colspan=9> No Records </td></tr>
		<%}
		}else{%>
		<tr><td  align="center"  colspan=9> No Records </td></tr>
		<%}%>
</table>
</form>

<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

