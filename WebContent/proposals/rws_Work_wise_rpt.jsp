<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ include file="/commons/rws_header1.jsp" %>
<SCRIPT LANGUAGE="JavaScript">

function showFields()
{
if (document.forms[0].plan[0].checked)
	{
	document.forms[0].wrktype[0].disabled=false;
	document.forms[0].wrktype[1].disabled=false;
	document.forms[0].wrktype[2].disabled=true;
    if(document.forms[0].wrktype[1].checked)
    {
    document.forms[0].wrktype[1].checked=true;
    }
    else
    {
    document.forms[0].wrktype[0].checked=true;
    }
	}
else if (document.forms[0].plan[1].checked)
	{
	document.forms[0].wrktype[0].disabled=true;
	document.forms[0].wrktype[1].disabled=true;
	document.forms[0].wrktype[2].disabled=false;
	document.forms[0].wrktype[2].checked=true;
	}
else
{
    document.forms[0].plan[0].checked=true;
    document.forms[0].wrktype[0].checked=true;  
    document.forms[0].wrktype[0].disabled=false;
	document.forms[0].wrktype[1].disabled=false;
	document.forms[0].wrktype[2].disabled=true;
}
}
function checkMe(type)
{
		if(type==0)
		{
		document.forms[0].wrktype[0].checked=true;
		}
		else if(type==1)
		{
		document.forms[0].wrktype[1].checked=true;
	    }
}
function disButton()
 { 
  document.getElementById('mode').disabled=true;
 }
 function viewButton()
 {
  var val= document.getElementById('workId').value;
  if(val!='')
  { 
  document.getElementById('mode').disabled=false;
  }
  else
  {
  document.getElementById('mode').disabled=true;
  }
 }
function fnGetWorkCategories()
{
  	var url = "switch.do?prefix=/proposals&page=/Workwise.do&mode=workcategories";
    document.forms[0].action=url;
    document.forms[0].submit();
}
function fnGetSchemes()
{
  	var url = "switch.do?prefix=/proposals&page=/Workwise.do&mode=scheme";
    document.forms[0].action=url;
    document.forms[0].submit();
}
function fnGetprogrammes()
{
  	var url = "switch.do?prefix=/proposals&page=/Workwise.do&mode=programmes";
	var frm = document.forms[0];
	frm.action = url;
	frm.submit();
}
function fnGetSubprogrammes()
{
  	var url = "switch.do?prefix=/proposals&page=/Workwise.do&mode=subprogrammes";
	var frm = document.forms[0];
	frm.action = url;
	frm.submit();
}
function fnGetWorks()
{
  	var url = "switch.do?prefix=/proposals&page=/Workwise.do&mode=works";
	var frm = document.forms[0];
	frm.action = url;
	frm.submit();
}
function getReport()
{
var url = "switch.do?prefix=/proposals&page=/Workwise.do&mode=rpt";
	var frm = document.forms[0];
	frm.action = url;
	frm.submit();
}
 
</SCRIPT>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
<%@ include file="/commons/rws_header2.jsp" %>
<body  onload="disButton();showFields()">
<html:form  action="Workwise.do" enctype="multipart/form-data"   >
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Workwise Report" />
	<jsp:param name="TWidth" value="713" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" 
	    border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  >
				<B> </B>
		</legend>
		<label>
		<table cellpadding="1" cellspacing="1" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr>
			<td class="textborder">
				<bean:message key="app.circle" />s
				<span class="mandatory">*</span>
		    </td>
		    <td class="textborder">
	 		 <html:select property="circleOfficeCode" onchange="javascript:fnGetWorkCategories();" styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</td>
		 <td class="textborder">
         <html:radio value="1" property="plan" onclick="showFields();checkMe(0);fnGetWorkCategories();"/>
		 Plan
         <html:radio value="2" property="plan" onclick="showFields();fnGetWorkCategories();"/>
         Non-Plan
    	 </td>
    	 <td class="textborder" nowrap>
			<html:radio value="1" property="wrktype" onclick="fnGetWorkCategories();"/>
			MainScheme
           	<html:radio value="2" property="wrktype" onclick="checkMe(1);fnGetWorkCategories();"/>
           	Augmentation
			<html:radio value="3" property="wrktype" onclick="fnGetWorkCategories();"/>          
			Maintenance
         </td>
		</tr>
	    <tr>
	    <td class="textborder">
				Work Category<span class="mandatory">*</span>
		    </td>
		    <td class="textborder">
	 		 <html:select property="workCat" styleClass="combo" onchange="fnGetSchemes()">
			 		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			 		<logic:present name="workCats">
			 		<html:options collection="workCats" name="labelValueBean" property="value" labelProperty="label" />
			        </logic:present>		  
			 </html:select>
			</td>
	     <td class="textborder">
				Schemes<span class="mandatory">*</span>
		    </td>
		    <td class="textborder">
	 		 <html:select property="typeOfAsset" styleClass="combo" onchange="fnGetprogrammes()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					 <logic:present name="assetTypes">
					<html:options collection="assetTypes" name="labelValueBean" property="value" labelProperty="label" />
					 </logic:present>		  
				</html:select>
			</td>
			</tr>
			<tr>
			<td class="textborder">
				Programs<span class="mandatory">*</span>
		    </td>
		    <td class="textborder">
	 		 <html:select property="programs" onchange="javascript:fnGetSubprogrammes();" styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					  <logic:present name="programmes">
					<html:options collection="programmes" name="labelValueBean" 
								  property="value" labelProperty="label" />
					 </logic:present>		  
				</html:select>
			</td>
	   		<td class="textborder">
				Sub Programs<span class="mandatory"></span>
		    </td>
		    <td class="textborder">
	 		 <html:select property="subPrograms"  onchange="javascript:fnGetWorks();" styleClass="combo">
					<html:option value="00"><bean:message key="app.pleaseSelect" /></html:option>
					<logic:present name="SubPrograms">
					<html:options collection="SubPrograms" name="labelValueBean" property="value" labelProperty="label" />
				 	</logic:present>	  
				</html:select>
			</td>
	    </tr>
	    <tr>
			<td class="textborder">
				Works<span class="mandatory">*</span>
		    </td>
		    <td class="textborder" colspan="10">
	 		 <html:select property="workId"   onchange="viewButton()" styleClass="comboLarge" >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					 <logic:present name="WorkIds">
					<html:options collection="WorkIds" name="labelValueBean" property="workName" labelProperty="workId" />
				 	</logic:present>	  
				</html:select>
			</td>
	    </tr>
	    <tr>
	    <td>
	    &nbsp;
	    </td>
	    </tr>
	    <tr class="staticLabelBold" >
	    <td align="center" colspan="4">
	    <html:button property="mode" value="View Report" styleClass="btext" onclick="getReport()"/>
	    </td>
	    </tr> 
		</table>
      </label>
	</fieldset>
</table>		
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="713"/>
</jsp:include>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%> 
