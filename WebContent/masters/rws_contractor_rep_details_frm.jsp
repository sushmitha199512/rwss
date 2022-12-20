<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_admin_authorization_struts.jsp"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%
String checkb = request.getParameter("contractRadioVal");
if(checkb==null)checkb="";
%>
<html:html>
<script type="text/javascript">
function init()
{

	var value = '<%=checkb %>';

	if(value=="2")
	{
		document.getElementById('text1').style.display='none';
		document.getElementById('text2').style.display='block';
		document.getElementById('text3').style.display='none';
		
	}
}
function fnSearch()
{
    if(document.forms[0].firstName.value=="" || document.forms[0].firstName.value == null)
    {
    	alert("Please Enter Contactor name or Starting Letter");
//		document.forms[0].firstName.focus();
		return false;
    }
    else
    {
    	document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=ViewContractor";
        document.forms[0].submit();
    }
}

function fnDivisionwise()
{
		if(document.forms[0].circleOfficeCode.value=='')
			{
				alert("Please Select Circle");
				return false;
			}
			
	else
	{
    	document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=viewdivisionwiseContractor";
        document.forms[0].submit();
	}
}
function fnContactorsList()
{

		document.forms[0].amnt.value=document.getElementById("amount").value;
    	document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=amountwisecontractors";
        document.forms[0].submit();

}

function getDivisions()
{
	
	document.forms[0].action="switch.do?prefix=/masters&page=/Contractor.do?mode=getCircles&contractRadioVal=2";
    document.forms[0].submit();
	
	
}
function show()
{

	if(document.forms[0].contractRadio[0].checked)
	{
		document.getElementById('text1').style.display='block';
		document.getElementById('text2').style.display='none';
		document.getElementById('text3').style.display='none';
	}
	else if(document.forms[0].contractRadio[1].checked)
	{
		document.getElementById('text1').style.display='none';
		document.getElementById('text2').style.display='block';
		document.getElementById('text3').style.display='none';
	}
	else if(document.forms[0].contractRadio[2].checked)
	{
		document.getElementById('text1').style.display='none';
		document.getElementById('text2').style.display='none';
		document.getElementById('text3').style.display='block';
	}

	
}
</script>

<body onload="init();">
<html:form action="Contractor.do">
<table border=0 width="340">			
			<tr align="right">
				
				<td class="bwborder" align="right"><a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a></td>
			
			</tr>
		</table>

<jsp:include page="/commons/TableHeader3.jsp">
	<jsp:param name="TableName" value="Contractor" />
	<jsp:param name="TWidth" value="300" />
</jsp:include>


<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" align="center">
<tr>
	<td><input type=radio id="r1" name="contractRadio"   value="1"   onclick="show()" />Contractor Wise</td>
	<td><input type=radio id="r2" name="contractRadio"  onclick="show()"   value="2"/>Office Wise</td>
    <td><input type=radio id="r3" name="contractRadio"  onclick="show()"   value="3"/>Amount Wise</td>

	
</tr>
</table>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="340" align="center">

	<tr>
		<td>

		<div id="text1"  style="display:none;">
		<table>
    	<tr>
    	<td class="textborder" align="center" >Enter Starting Letter of Contractor:&nbsp;<html:text property="firstName" styleClass="mytext" style="width:80px" maxlength="25"  onkeypress="return alpha(event)"   /><html:submit property="mode" title="View"  styleClass="btext" value="View " onclick="return fnSearch()" /></td></tr>
		</tr>
      
	  </table>
	  </div>
	  <div id="text2"  style="display:none;">
  		<table>
	  	<tr>
		<td class="textborder">Circle&nbsp;&nbsp;&nbsp;
		<span class="mandatory">*</span>
			
				<html:select property="circleOfficeCode"  style="width:140px" onchange="javascript:getDivisions()" 
							 styleClass="mycombo"> 
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:present name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:present>			  
				</html:select>
			
				</td>
</tr>
<tr>
<td class="textborder">Division&nbsp;&nbsp;
                 

				<html:select property="divisionOfficeCode" style="width:140px"  styleClass="combo" >
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:notEmpty name="divisions1">
				<html:options collection="divisions1" name="labelValueBean" property="value" labelProperty="label" />
				</logic:notEmpty>			  
				</html:select>

				</td>
	</tr>
<tr><td class="textborder">Category 
	
		<SELECT name="category"   style="width:140px">
		<option value=''>Select</option>
		<option value='1'>Projects</option>
		<option value='2'>Normal</option>
		<option value='3'>District Level</option>
		 </SELECT></td>
	</tr>

	
	<tr>
	<td align="center"><html:submit property="mode" title="View"  styleClass="btext" value="View " onclick="return fnDivisionwise()" /></td>
	</tr>
	</table>
	</div>

	  <div id="text3"  style="display:none;">
		<table>
    	<tr>
    	<td class="textborder" align="center" >Sanction Amount(In Lakhs):>=</td><td><select name="amount"><option value="100">100</option><option value="1000">1000</option></select></td>

<tr><td></td><td><html:submit property="mode" title="View"  styleClass="btext" value="View " onclick="return fnContactorsList()" /></td></tr>
		    
	  </table>
</div>
</td>
</tr>
<tr><td>

    	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="300"/>
	</jsp:include>
</table>
<input type="hidden" id="amnt">
</html:form>
</body>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
<%if(request.getAttribute("message") != null){ %>
<%@ include file="/commons/rws_alert.jsp"%>
<%} %>

