
 <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%System.out.println("Hai this is return back"); %>
<html:html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">

<style>
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt
}

fieldset {
	border: 1px solid green
}

legend {
	padding: 0.2em 0.5em;
	border: 1px solid green;
	color: green;
	font-size: 90%;
	text-align: right;
}

.tstyle {
	background: transparent url('images/bg.jpg') no-repeat;
	color: #747862;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
}
</style>

<%

	 
	 	int count = 1;
 %>


<%
     Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	 String transdate=null;
	 transdate=dateFormat.format(systemdate);
 %>

<script language="JavaScript">

function getMandal()
{
   
	document.forms[0].action="switch.do?prefix=/works&page=/RfdTraining.do?mode=mandal";
	document.forms[0].submit();
         
}

function getPanch()
{
    
	document.forms[0].action="switch.do?prefix=/works&page=/RfdTraining.do?mode=panch";
	document.forms[0].submit();
    
     
} 

function fnSave()
{
   	
	if(document.forms[0].dist.value!=null && document.forms[0].mand.value!=null && document.forms[0].panch.value!=null)
	{

		if(document.forms[0].elements["vwscAchmt"].value==""){
             alert("Please Enter VWSC Member Count");
             return false;
		}

		if(document.forms[0].elements["ftkAchmt"].value==""){
			 alert("Please Enter FTK Training Kit Usage ");
             return false;
		}
	
		document.forms[0].action="switch.do?prefix=/works&page=/RfdTraining.do?mode=save";
		document.forms[0].submit();
	}
	else
		alert("Select the Panchayat Detalis");
    
     
} 

function init()
{
 
	document.forms[0].action="switch.do?prefix=/works&page=/RfdTraining.do?mode=init";
	document.forms[0].submit();
    
     
} 

function fnView()
{
    // alert("panchs");
	document.forms[0].action="switch.do?prefix=/works&page=/RfdTraining.do?mode=view";
	document.forms[0].submit();
    
     
} 

function getData()
{
  
	document.forms[0].action="switch.do?prefix=/works&page=/RfdTraining.do?mode=getData";
	document.forms[0].submit();
    
     
} 

</script>

<body>
<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="RfdTraining.do">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="WaterQuality Training Entry" />
	<jsp:param name="TWidth" value="670" />
</jsp:include>


<table bgcolor="ffffe0" bordercolor="#8A9FCD" style="border-collapse:collapse;" width="700" >
<tr>
<td>
   <fieldset>
   <legend>Office Details</legend>
   <label>
   <table  border=0  width="700"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="btext2" ><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="btext2">
		<html:select property="dist"  style="width:150px" onchange="javascript:getMandal()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
		</td>
		<td class="btext2" >
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="btext2" >
		    <html:select property="mand"  style="width:150px" onchange="javascript:getPanch()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
             <logic:present name="mandals">
			<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
            </logic:present >
			</html:select>
	</td>
		<td class="btext2" >
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="btext2">
		<html:select property="panch" style="width:150px"  onchange="javascript:getData()">
		<html:option value="">SELECT...</html:option>
        <logic:present name="panchayats">
		<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label"/>
        </logic:present >
		</html:select>
	</td>
		</tr>
	
			
    </table>   
		</label>
	</fieldset>
	</td>
</tr>

<tr>
<td>
   <fieldset>
   <legend>Trained Member Details</legend>
   <label>
   
   <table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
    
    <tr align="center"  class="btext2">
    
    <td  align="center"  class="btext2">VWSC members Trained(in no.)
   	<html:text property="vwscAchmt" onkeypress="return decimalsOnly(event)"  maxlength="4"/>
	</td>
	
	
	<td  align="center"  class="btext2" >Usage of FTK kits(in no.)<html:text property="ftkAchmt"  onkeypress="return decimalsOnly(event)" maxlength="4"/>
	</td>
	
		
</tr>

</table>
</label>
</fieldset>

    
    
    <tr align=center  class="btext2">
<td  class="btext2" colspan="4">
<input type="button"  class="btext2" name="Save"   value="&nbsp;&nbsp;Save&nbsp;&nbsp;" onclick="fnSave();">
<input type="button"  class="btext2"  name="View"   value="&nbsp;&nbsp;View&nbsp;&nbsp;" onclick="fnView();">
</td>
</tr>
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="670"/>
</jsp:include>
</table>   
		</label>



<input type=hidden name=hab1>
 

</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
