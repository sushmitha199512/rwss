<%
java.util.ArrayList selectedHabs = (java.util.ArrayList)session.getAttribute("tempSelectedHabs");
%>
<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetForm" />
<%
String typeOfAsset = request.getParameter("assetTypeCode");

String convType = request.getParameter("convtype");

System.out.println("From JSP"+convType);

%>
<SCRIPT LANGUAGE="JavaScript">

function validateAssetAnnualMaintenance(){
	//alert("hi---");
	 
	if(document.forms[0].finYear.value==""){
		alert("Please Select Financial Year");
		return false;
	}
	else if(document.forms[0].power.value=="" && document.forms[0].meterial.value=="" && document.forms[0].salaries.value==""){
		alert("Please Enter Any One Field (Power / Materual / Salaries)");
		return false;
	}
	else{ 
		document.forms[0].action="switch.do?prefix=/masters&page=/annualMaintenance.do&mode=save";
		document.forms[0].submit();
	}
}
function annualDetails(){
	
	if(document.forms[0].finYear.value==""){
		alert("Please Select Financial Year");
		return false;
	}
	else{ 
		document.forms[0].action="switch.do?prefix=/masters&page=/annualMaintenance.do&mode=get";
		document.forms[0].submit();
	}
}
function annualDetails1(){
	
	
	var power=document.forms[0].power.value;
	var meterial=document.forms[0].meterial.value;
	var salaries=document.forms[0].salaries.value;
	if(document.forms[0].power.value==""){
		power=0;
	}
	if(document.forms[0].meterial.value==""){
		meterial=0;
	}
	if(document.forms[0].salaries.value==""){
		salaries=0;
	}
	document.forms[0].total.value=parseInt(power)+parseInt(meterial)+parseInt(salaries);
}

</SCRIPT>

<%@ include file="/commons/rws_header2.jsp" %>

<body id="docBody" onload="check();checkDefunct();linkagealert();showHideDpYield()">
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<html:form action="annualMaintenance.do" method="post">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Annual Maintenance Form" />
	<jsp:param name="TWidth" value="400"/>
	<jsp:param name="contextHelpUrl" value="/pred/help/assethelp.doc" />
</jsp:include>

<table align=center  bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1" style="border-collapse:collapse;" width="440" >	
<tr>
	<td class="mycborder">
		<fieldset>
		<legend>Annual Maintenance</legend>
		<label>
		
	<table border=0 width="250" align="center">
	<tr>
	
	<input type="hidden" name="assetCode"  value="<%=(String)session.getAttribute("assetCode")%>"  >
		<td class="textborder">Financial Year
			
		</td>
		<td class="textborder" >
		<html:select property="finYear" styleClass="mycombo" onchange="return annualDetails();">
						<html:option value="">SELECT...</html:option>
						<logic:notEmpty name="finyear">
						<html:options collection="finyear"  
									  property="value" labelProperty="label" />
						</logic:notEmpty>			  
						</html:select>
		</td>
		
		
	</tr>
	<tr>
	
		<td class="textborder">Power(In Rs.)
					</td>
		<td class="textborder" >
		<html:text property="power" styleClass="mytext" onkeypress="return decimalsOnly(event)" onkeyup="return annualDetails1();" />
		</td>
		
		
	</tr>
	<tr>
	
		<td class="textborder">Materials(In Rs.)
					</td>
		<td class="textborder" >
		<html:text property="meterial" styleClass="mytext"  onkeypress="return decimalsOnly(event)" onkeyup="return annualDetails1();" />
		</td>
		
		
	</tr>
	<tr>
	
		<td class="textborder">Salaries(In Rs.)
					</td>
		<td class="textborder" >
		<html:text property="salaries" styleClass="mytext" onkeypress="return decimalsOnly(event)" onkeyup="return annualDetails1();" />
		</td>
		
		
	</tr>
	<tr>
	
		<td class="textborder">Total
					</td>
		<td class="textborder" >
		<html:text property="total" styleClass="mytext"/>
		</td>
		
		
	</tr>
	</table>
	</label>
	</fieldset>
		</tr>
		<tr>
			<td align="center">
		
			
			  <html:button property="mode" title="Save Annual Maintenance" styleClass="btext" value="save" onclick="return validateAssetAnnualMaintenance()" />
			  
			</td>
		</tr>
		
	</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="400" />
</jsp:include>
<br>


</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%
if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
	// System.out.println("water sample ");
	 String water=(String)session.getAttribute("water");
	// System.out.println("water sample "+water +" "+(water!=null) +" "+water.equals("water"));
	 
	 //String returnVal=(String)session.getAttribute("returnVal");
	 if(water!=null && water.equals("water"))
	 {
	// System.out.println("setsession values null ");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	window.close();
	</script>
<%  }
 else
 {
 %>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess);
	window.close();
	</script>
<%
 }
 }
				
%>



