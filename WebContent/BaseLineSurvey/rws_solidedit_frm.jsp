<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
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

.btext1 {
	text-transform: uppercase;
	color: green;
}

.btext3 {
	color: red;
	font-weight: bold;
}
</style>
<STYLE>
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
</STYLE>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<head>


<script language="JavaScript">
<%
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String transdate=null;
	transdate=dateFormat.format(systemdate);
%>


function init()
{
	dCode='';
	mCode='';
	pCode='';
	vCode='';
	habCode='';
}
function getData2()
{
	
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/SolidWaste.do&mode=data";
    document.forms[0].submit();
}
function fnView()
{
	//alert(1);
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/SolidWaste.do&mode=cview";
    document.forms[0].submit();
}

function fnSave()
{
		
	 if(document.forms[0].totDustbins.value=="" || document.forms[0].totDustbins.value==null)
		    
	   {
	     alert("Enter Dust Bins");
	     return false;
	   
	   }
		 

	 else if(document.forms[0].totSoakpits.value=="" || document.forms[0].totSoakpits.value==null)
    {
        alert("Enter Total Soak Pits");
        return false;
        
    }
    else if(document.forms[0].totCompits.value=="" || document.forms[0].totCompits.value==null)
    {
        alert("Enter Composite pits");
        return false;
    }
    else if(document.forms[0].totTricycles.value=="" || document.forms[0].totTricycles.value==null)
    {
        alert("Enter Total Tri Cycles");
        return false;
    }
    else if(document.forms[0].extraFacilities.value=="" || document.forms[0].extraFacilities.value==null)
    {
        alert("Enter Extra Facilities");
        return false;
    }
    else if(document.forms[0].otherInNo.value=="" || document.forms[0].otherInNo.value==null)
    {
        alert("Enter Other In No");
        return false;
    }
    else if(document.forms[0].drainageExist.value=="" || document.forms[0].drainageExist.value==null)
    {
        alert("Select Drainage Exist");
        return false;
    }
    else if(document.forms[0].surveyDate.value=="" || document.forms[0].surveyDate.value==null)
    {
        alert("Select Survey Date");
        return false;
    }
    else
    {
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/SolidWaste.do&mode=edit";
    document.forms[0].submit();
	


}

}

</script>

<body  onload="javascript:init();">


<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="/SolidWaste.do">

<table>
<tr><td align="right">
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="BaseLine Survey Solid Waste Details Edit Entry Form" />
	<jsp:param name="TWidth" value="960" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border="1" 
	   style="border-collapse:collapse;" width="1000" >
		<tr>
			<td class="textborder" >
<tr>
<td>
   <fieldset>
   <legend><b>Habitation Details</b><span class="mandatory">*</span></legend>
   <label>

<table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
    <tr>
	    <td class="btext2" width="100"><bean:message key="app.district"/>
	    <html:text property="dName" readonly="true" />
		</td>
		<td class="btext2" width="100">
	<bean:message key="app.mandal"/><html:text property="mName"  readonly="true"/>
	</td>
		<td class="btext2" width="100">
	<bean:message key="app.panchayat" /><html:text property="pName"  readonly="true"/>
	</td>
	<td class="btext2" width="100">
	<bean:message key="app.village" /><html:text property="vName"  readonly="true"/>
	</td>
		</tr>
		<tr>
		<td></td>
		<td></td>
		</tr>
		<tr>
		<td class="btext2" width="100">
		<bean:message key="app.Hab" /><html:text property="panchName"  readonly="true" />
		</td>
		</tr>


	
	
</table>
</label>
</fieldset>
</td>
</tr><table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border="1" 
	   style="border-collapse:collapse;" width="1000" >
		<tr>
		<td>
		<legend><b>Solid Waste Details</b><span class="mandatory">*</span></legend>
		<table  border=0  width="100%">
		<tr>
		<td class="btext2">Total Dust Bins<font color="#FF6666">*</font><font color="#FF6666"></font>
		</td>
		<td class="textborder" >
		<html:text property="totDustbins"    maxlength="4" size="4" onkeypress="numeralsOnly(event)" />
		<html:hidden property="solidCode"     />
		</td>

		<td class="btext2">Total Soak Pits<font color="#FF6666">*</font><font color="#FF6666"></font>
		</td>
		<td class="textborder" >
		<html:text property="totSoakpits"    maxlength="4" size="4" onkeypress="numeralsOnly(event)" /></td>
		</tr>
        <tr><td>&nbsp;</td></tr>
		<tr>
		<td class="btext2">Total Composite Pits<font color="#FF6666">*</font><font color="#FF6666"></font> 
		</td>
		<td class="textborder" >
		<html:text property="totCompits"   maxlength="4" size="4" onkeypress="numeralsOnly(event)" /></td>

		<td class="btext2">Total Tri Cycles<font color="#FF6666">*</font><font color="#FF6666"></font>
		</td>
		<td class="textborder" >
		<html:text property="totTricycles"    maxlength="4" size="4" onkeypress="numeralsOnly(event)" /></td>
		</tr>
        <tr><td>&nbsp;</td></tr>
		
		<tr>
		<td class="btext2">Extra Facilities<font color="#FF6666">*</font><font color="#FF6666"></font>
		</td>
		<td class="textborder" >
		<html:text property="extraFacilities"    maxlength="25" size="25" onkeypress="return alpha(event)" /></td>

		<td class="btext2">Other In No.<font color="#FF6666">*</font><font color="#FF6666"></font>
		</td>
		<td class="textborder" >
		<html:text property="otherInNo"    maxlength="4" size="4" onkeypress="numeralsOnly(event)" /></td>
		</tr>
		
		
		<tr>
		
		<tr><td>&nbsp;</td></tr>
		
		<td class="btext2" >Drainage Exist<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<html:select property="drainageExist" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
			</html:select>
		</td>
		
		
		<td class="btext2" >
	Survey Date<font color="#FF6666">*</font></td><td><html:text property="surveyDate"  styleClass="mytext" style="width:100px" readonly="true" />
	<a href="javascript:showCalendar(document.BaseLineForm.surveyDate);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
	</tr>
		
				</table>		
				</fieldset>
				</label>
				</td>
				</tr>
				
	
	<tr>
		<td class="textborder" align=center>			 
		<html:button property="mode" title="Update/Save the Fields" styleClass="btext2" value="Save" onclick="fnSave()"  />
		
		
				</td>
				
	</tr>
	

			
 
	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="960"/>
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


