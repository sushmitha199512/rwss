<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<html:html>
<html:javascript formName="targetHabWorkForm" />
<script language="JavaScript">
<%
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String transdate=null;
	transdate=dateFormat.format(systemdate);
%>
function getData2()
{
	if(document.forms[0].dist.value==null || document.forms[0].dist.value=="")
	{
		alert("Select District");
		return false;
	}
	else if(document.forms[0].finYear.value==null || document.forms[0].finYear.value=="")
	{
		alert("Select Financial Year");
		return false;
	}
	else
	{
	document.forms[0].action="switch.do?prefix=/masters&page=/HabWork.do&mode=viewdata";
    document.forms[0].submit();
	}
	
	
}
function isSaveAttended()
{
	//alert(document.forms[0].dist.value);
	//alert(1);
	if(document.forms[0].dist.value==null || document.forms[0].dist.value=="")
	{
		alert("Select District");
		return false;
	}
	else if(document.forms[0].finYear.value==null || document.forms[0].finYear.value=="")
	{
		alert("Select Financial Year");
		return false;
	}
	else if(document.forms[0].svsHabs.value==null || document.forms[0].svsHabs.value=="")
	{
		alert("Enter SVS Habs");
		return false;
	}
	else if(document.forms[0].svsExp.value==null || document.forms[0].svsExp.value=="")
	{
		alert("Enter SVS Exp");
		return false;
	}
	else if(document.forms[0].mvsHabs.value==null || document.forms[0].mvsHabs.value=="")
	{
		alert("Enter MVS Habs");
		return false;
	}
	else if(document.forms[0].mvsExp.value==null || document.forms[0].mvsExp.value=="")
	{
		alert("Enter MVS Exp");
		return false;
	}
	else if(document.forms[0].schHabs.value==null || document.forms[0].schHabs.value=="")
	{
		alert("Enter School Habs");
		return false;
	}
	else if(document.forms[0].angHabs.value==null || document.forms[0].angHabs.value=="")
	{
		alert("Enter Anganwadi Habs");
		return false;
	}
	
	else if(document.forms[0].pwsHabitations.value==null || document.forms[0].pwsHabitations.value=="")
	{
		alert("Enter Pws Habs");
		return false;
	}
	else if(document.forms[0].houseConnections.value==null || document.forms[0].houseConnections.value=="")
	{
		alert("Enter House Connections");
		return false;
	}
	
	else if(document.forms[0].pcHabs.value==null || document.forms[0].pcHabs.value=="")
	{
		alert("Enter Pc Habitations");
		return false;
	}
	
	else if(document.forms[0].qaHabs.value==null || document.forms[0].qaHabs.value=="")
	{
		alert("Enter QA Habitations");
		return false;
	}
	
	else
		
	{
		
	
	document.forms[0].action="switch.do?prefix=/masters&page=/HabWork.do&mode=save";
    document.forms[0].submit();
	}

}
function isView()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/HabWork.do&mode=view";
    document.forms[0].submit();
}



</script>

<body  onload="javascript:init();">


<html:form action="/HabWork.do">

	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table align=center border=0>
<tr>
<td><a href="javascript:history.go(-1)">Back</a></td>
</tr>
</table>

<table>
<tr><td align=right class=clrborder><br>( <b style="font-family: Rupee Foradian;">`</b>.Expenditure In Lakhs )</td></tr>
</table>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Targets For Financial Year Entry Form " />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="100%" >
	   
	   
<tr>
<td>
   <fieldset>
   <legend></legend>
   <label>
   <table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
   <tr align=left>
<td width="100%" class=clrborder ><font color="#000000" face=verdana size=2><B><bean:message key="app.finYear" /><font color="#FF6666">*</font>&nbsp;


    <html:select property="finYear" style="width:135px" styleClass="mycombo"  onchange="javascript:getData2()">

	<logic:present name="expyears">
	
	<html:option value="">SELECT</html:option>	
	<html:options collection="expyears" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	
	</html:select>
</td>
</tr>
   <tr align=left>
	    <td class=clrborder><font color="#000000" face=verdana size=2><B><bean:message key="app.dist" /><font color="#FF6666">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:select property="dist" styleClass="mycombo" style="width:135px"  >
		<html:option value="all">ALL</html:option>	
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
		</td>
		</tr>
		
		
		</table>
		</label>
	</fieldset>
		   
<tr>
  <td  bgcolor="#8A9FCD">
	  <font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Targets for Financial Year </font>	

	</td>
	</tr>
	<tr><td>
			<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="100%" align=center>
				<tr>
					<td class=clrborder align=center>Sl.No</td>
                    
					<td class=clrborder align=center><bean:message key="app.svsHabs" /></td>
					<td class=clrborder align=center><bean:message key="app.svsExp" /> <font color="#FF6666">*</font><br>( <b style="font-family: Rupee Foradian;">`</b>. In Lakhs ) </td>
                    <td class=clrborder align=center><bean:message key="app.mvsHabs" /></td>
                    <td class=clrborder align=center><bean:message key="app.mvsExp" /> <font color="#FF6666">*</font><br>( <b style="font-family: Rupee Foradian;">`</b>. In Lakhs )</td>
                    <td class=clrborder align=center><bean:message key="app.schHabs" /></td>
					<td class=clrborder align=center><bean:message key="app.angHabs" /></td>
					
					
					
					<td class=clrborder align=center><bean:message key="app.noofVwsctrained" /></td>
					<td class=clrborder align=center><bean:message key="app.trtoFtkkits" /></td>
					<td class=clrborder align=center><bean:message key="app.wqftkTests" /></td>
					<td class=clrborder align=center><bean:message key="app.pcHabs" /><font color="#FF6666">*</font>
					<td class=clrborder align=center><bean:message key="app.qaHabs" /><font color="#FF6666">*</font>
					<td class=clrborder align=center><bean:message key="app.pwsHabitations" /><font color="#FF6666">*</font>
					<td class=clrborder align=center><bean:message key="app.houseConnections" /><font color="#FF6666">*</font>
					
				
				    
				
					
				
					
					
					
				</tr>

	<%int count=0; %>


	
		<tr bgcolor="#ffffff">
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
		<td class="bwborder"><%=count %></td>
		
		<td class=bwborder align=center nowrap><html:text property="svsHabs"  onkeypress="return numeralsOnly(event)" size="5" maxlength="5"  /></td>
		
		<td class=bwborder align=center nowrap><html:text property="svsExp"  onkeypress="return decimalsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center nowrap><html:text property="mvsHabs"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>  
		<td class=bwborder align=center nowrap><html:text property="mvsExp"  onkeypress="return decimalsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center><html:text property="schHabs"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center nowrap><html:text property="angHabs"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center nowrap><html:text property="noofVwsctrained"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center nowrap><html:text property="trtoFtkkits"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center nowrap><html:text property="wqftkTests"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center nowrap><html:text property="pcHabs"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center nowrap><html:text property="qaHabs"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center nowrap><html:text property="pwsHabitations"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>
		<td class=bwborder align=center nowrap><html:text property="houseConnections"  onkeypress="return numeralsOnly(event)"  size="5" maxlength="5"  /></td>
		
		</tr>
		
	
	</table>
	</td>
	</tr>
	<!-- onclick="return isSaveAttended();" -->
	<tr>
		<td class="textborder" align=center>			 
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return isSaveAttended()"  />
		<html:button property="mode" title="View the Fields" styleClass="btext" value="View" onclick="return isView();" />
				</td>
				
	</tr>
	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
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


