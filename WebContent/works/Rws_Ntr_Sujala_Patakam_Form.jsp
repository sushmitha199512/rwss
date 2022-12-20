 <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">

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
     Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	 String transdate=null;
	 transdate=dateFormat.format(systemdate);
 %>

<script language="JavaScript">


function getMandals()
{
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujala.do?mode=mandals";
	document.forms[0].submit();  
     
	
} 

function getVillages()
{
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujala.do?mode=villages";
	document.forms[0].submit();  
     
	
} 

function getPanchayats()
{
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujala.do?mode=panchayats";
	document.forms[0].submit();  
     
} 

function getHabs()
{
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujala.do?mode=prhabs";
	document.forms[0].submit();  
	
} 

function getSourceDetails()
{
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujala.do?mode=sourceDetails";
	document.forms[0].submit();  
	
}


function init()
{
	document.forms[0].action="switch.do?prefix=/works&page=/ntrSujala.do?mode=init";
	document.forms[0].submit();
    
} 




function changeColor(o)
{
    o.style.backgroundColor=(o.style.backgroundColor=='e0ffff')?('e0ffff'):('transparent');
}

function fngetenable(index){
    IsSchmeExists(index);
    
	 var len=document.forms[0].resultCount.value;
		len = len-1;
		for( var j=0;j<len;j++)
		{
			if(document.getElementById("sourceList["+j+"].checks").checked==true)
			{
				document.getElementById("sourceList["+j+"].buildingAvailability").removeAttribute("disabled");	
				document.getElementById("sourceList["+j+"].anyFirm").removeAttribute("disabled");	
				document.getElementById("sourceList["+j+"].anyCoporate").removeAttribute("disabled");
			}else{
				
				document.getElementById("sourceList["+j+"].buildingAvailability").setAttribute("disabled","true");
				document.getElementById("sourceList["+j+"].anyFirm").setAttribute("disabled","true");
				document.getElementById("sourceList["+j+"].anyCoporate").setAttribute("disabled","true");

			}	
		}
}

function fngetenable1(){
	 var len=document.forms[0].resultCount.value;
		len = len-1;
		for( var j=0;j<len;j++)
		{
			if(document.getElementById("sourceList["+j+"].checks").checked==true)
			{
				if(document.getElementById("sourceList["+j+"].buildingAvailability").checked==true){
					document.getElementById("sourceList["+j+"].buildingName").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].buildingLoc").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].buildingSize").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].waterAvailabilty").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].powerAvailability").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].phaseImpl").removeAttribute("disabled");

				}else{
					document.getElementById("sourceList["+j+"].buildingName").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].buildingLoc").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].buildingSize").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].waterAvailabilty").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].powerAvailability").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].phaseImpl").setAttribute("disabled","true");

				}		
			}	
		}
}

function fngetenable2(){
	 var len=document.forms[0].resultCount.value;
		len = len-1;
		for( var j=0;j<len;j++)
		{
			if(document.getElementById("sourceList["+j+"].checks").checked==true)
			{
				if(document.getElementById("sourceList["+j+"].buildingAvailability").checked==true){
					
					if(document.getElementById("sourceList["+j+"].waterAvailabilty").checked==true){
						document.getElementById("sourceList["+j+"].waterAvalDist").removeAttribute("disabled");
					}else{
						document.getElementById("sourceList["+j+"].waterAvalDist").setAttribute("disabled","true");

					}
				}
			}	
		}
}
function fngetenable3(){
	 var len=document.forms[0].resultCount.value;
		len = len-1;
		for( var j=0;j<len;j++)
		{
			if(document.getElementById("sourceList["+j+"].checks").checked==true)
			{
				if(document.getElementById("sourceList["+j+"].anyFirm").checked==true){
					document.getElementById("sourceList["+j+"].anyFirmName").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].anyFirmloc").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].anyFirmExtPlantType").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].anyFirmExtPlantCap").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].phaseImpl").setAttribute("disabled","true");

				}else{
					document.getElementById("sourceList["+j+"].anyFirmName").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].anyFirmloc").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].anyFirmExtPlantType").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].anyFirmExtPlantCap").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].phaseImpl").removeAttribute("disabled");
				}
			}	
		}
}
function fngetenable4(){
	 var len=document.forms[0].resultCount.value;
		len = len-1;
		for( var j=0;j<len;j++)
		{
			if(document.getElementById("sourceList["+j+"].checks").checked==true)
			{
				if(document.getElementById("sourceList["+j+"].anyCoporate").checked==true){
					document.getElementById("sourceList["+j+"].anyCoporateName").removeAttribute("disabled");
					document.getElementById("sourceList["+j+"].anyCoporateloc").removeAttribute("disabled");
					
				}else{
					document.getElementById("sourceList["+j+"].anyCoporateName").setAttribute("disabled","true");
					document.getElementById("sourceList["+j+"].anyCoporateloc").setAttribute("disabled","true");
				}
			}	
		}
}

function fnSave(){
	 var habitations1="";
	 var bldgstatus="N";
	 var bldgwtrstatus="N";
	 var powerstatus="N";
	 var waterplanttatus="N";
	 var progstatus="N";
	var len=document.forms[0].resultCount.value;
	len = len-1;
	var checkcnt=0;
	for( var j=0;j<len;j++)
	{
				if(document.getElementById("sourceList["+j+"].checks").checked==true)
		{
			habitations1=habitations1+document.getElementById("sourceList["+j+"].shabCode").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].sourceCode").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].testid").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].testDate").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].issueIdent").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].plantType").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].genHealIssuesIdent").value;
			if(document.getElementById("sourceList["+j+"].buildingAvailability").checked==true){
				bldgstatus="Y";
			}
			habitations1=habitations1+"@"+bldgstatus;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].buildingName").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].buildingLoc").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].buildingSize").value;
			if(document.getElementById("sourceList["+j+"].waterAvailabilty").checked==true){
				bldgwtrstatus="Y";
			}
			habitations1=habitations1+"@"+bldgwtrstatus;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].waterAvalDist").value;
			if(document.getElementById("sourceList["+j+"].powerAvailability").checked==true){
				powerstatus="Y";
			}
			habitations1=habitations1+"@"+powerstatus;
			if(document.getElementById("sourceList["+j+"].anyFirm").checked==true){
				waterplanttatus="Y";
			}
			habitations1=habitations1+"@"+waterplanttatus;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].anyFirmName").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].anyFirmloc").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].anyFirmExtPlantType").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].anyFirmExtPlantCap").value;
			if(document.getElementById("sourceList["+j+"].anyCoporate").checked==true){
				progstatus="Y";
			}
			habitations1=habitations1+"@"+progstatus;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].anyCoporateName").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].anyCoporateloc").value;
			habitations1=habitations1+"@"+document.getElementById("sourceList["+j+"].phaseImpl").value;
			habitations1=habitations1+"@"
		
			checkcnt++;
		}
	}
	habitations1=habitations1+"D,";
	
	  if(habitations1=="")
	   {
		 alert("Select atleast one check box to save");
     }
	  else{
	   if(checkcnt>1){
		   alert("only one source is allowed to save for one Habitation.");
	   } else{
	     if(confirm("Are You Sure To Save The Checked Habitation(s)")) {
			  document.forms[0].hab1.value = habitations1;
	          document.forms[0].action="switch.do?prefix=/works&page=/ntrSujala.do&mode=save";
       document.forms[0].submit();
			}}
	  }
}


function IsSchmeExists(index){
	
	
	var len=document.forms[0].resultCount.value;
	
	len=len-1;
	var flag=false;
	
	var sourceCode=document.getElementById("sourceList["+index+"].sourceCode").value;
	if(sourceCode.indexOf("SO")>0){
		return true;
	}
	for( var j=0;j<len;j++)
	{
		var sourceCode=document.getElementById("sourceList["+j+"].sourceCode").value;
		if(sourceCode.indexOf("SO")>0){
			alert("If Scheme source available, other sources cannot be selected.");
			document.getElementById("sourceList["+index+"].checks").checked=false;
			return;
			
		}
	}
}

function autocompletion()
{
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}

</script>

<body  onload="autocompletion()">

<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="ntrSujala.do">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="NTR Sujala Patakam" />
	<jsp:param name="TWidth" value="5500" />
</jsp:include>


<table  style="border-collapse:collapse;"  >
<tr align="left">
<td>
   <fieldset>
   <legend>Office Details</legend>
   <label>
   <table  border=0  width="800"  align="left"  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="btext2" width="100">District<font color="#FF6666">*</font>
		<td class="textborder" width="150">
		<html:select property="circleCode" styleClass="mycombo" style="width:130px" onchange="javascript:getMandals()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="circles">
		<html:options collection="circles" name="rwsLocationBean" property="value" labelProperty="label" />
		</logic:present >
		</html:select>
		</td>
		<td class="btext2" width="100">Mandal<font color="#FF6666">*</font>
		
			<td class="bwborder" >
				<html:select property="mandal" styleClass="mycombo" style="width:140px" onchange="javascript:getPanchayats()" >
				<html:option value="">SELECT...</html:option>
				<logic:notEmpty name="mandals">
				<html:options collection="mandals" name="labelValueBean"  property="value" labelProperty="label" />
				</logic:notEmpty>
				</html:select>
				</td>
		<td class="btext2" width="100">Panchayat<font color="#FF6666">*</font>
		<td class="textborder" width="150">
		<html:select property="panchCode" styleClass="mycombo" style="width:130px" onchange="javascript:getVillages()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
        <logic:present name="panchayats">
		<html:options collection="panchayats" name="rwsLocationBean" property="value" labelProperty="label" />
		</logic:present >
		</html:select>
		</td>
		</tr>
	<tr>
	    <td class="btext2" width="100">Village<font color="#FF6666">*</font>
		
			<td class="bwborder" >
				<html:select property="village" styleClass="mycombo" style="width:140px" onchange="javascript:getHabs()" >
				<html:option value="">SELECT...</html:option>
				<logic:notEmpty name="villages">
				<html:options collection="villages" name="rwsLocationBean" property="value" labelProperty="label"/>
				</logic:notEmpty>
				</html:select>
			</td>
			
			<TD class="btext2">
				<bean:message key="app.habCode" /><font color="#FF6666">*</font>
			</TD>
		    <TD colspan=3 class="bwborder">
		    	<html:select property="habCode" styleClass="mycombo" style="width:280px"  onchange="javascript:getSourceDetails()">
				<html:option value="">SELECT...</html:option>
				<logic:notEmpty name="prhabs">
				<html:options collection="prhabs" name="rwsLocationBean" property="value" labelProperty="label" />
				</logic:notEmpty>
				</html:select>
				
			</TD>
			
			
		</tr>
	
			
    </table>   
		</label>
	</fieldset>
	</td>
</tr>


<tr>
<td>
   <fieldset>
   <legend>NTR Sujala Patakam Details</legend>
   <label>
   
<table  border=1  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
    
<tr align="center"  class="btext2">
<td rowspan=2>Select</td>
     <td rowspan=2>SlNo</td>
     <td rowspan=2>Constituency</td>
     <td rowspan=2>Habitation/<br>Population/<br>Status</td>
     <td rowspan=2>Type of Source</td>
     <td rowspan=2>Source Code/<br>Source Name/<br>Source Location/Source Condition</td> 
     <td colspan=13>Raw Water Chemical analysis details  and problem of the selected source</td> 
     <td rowspan=2>Water Quality <br> issues identified </td>
     <td rowspan=2>Type of Plant Suggested</td>   
     <td rowspan=2> General Health issues identified in this habitation - Provide the details in consultation with Health Department</td>
     <td rowspan=2>Availablity of existing Building  for installation of Water Treatment Plant</td>
     <td colspan=4>Building Details</td>
     <td rowspan=2>Whether any firm/ NGO/ SHGs  installed Water Treatment <br> plant in this habitation</td>
     <td colspan=3>Firm/ NGO/ SHGs Details</td>
     <td rowspan=2>Whether any Corporate  House/ NGO/ SHGs are ready  to take up this programme on voluntary basis</td>
     <td colspan=1>Corporate House/ NGO/ SHGs  Details</td>
     <td rowspan=2>Phase Implementaion Details</td>
    
     
         		
</tr>
<tr align="center"  class="btext2">
       <td>Test Date</td> 
       <td>Colour (Co-Pt)</td>
       <td>Turbidity NTU</td>
       <td>pH</td>
       <td>TDS mg/l</td>
       <td>Fluoride mg/l</td>
       <td>Chlorides mg/l</td>
       <td>Nitrate mg/l</td>
       <td>Iron  (Fe) mg/l</td>
       <td>Sulphate mg/l as So4</td> 
       <td>Alkalinity mg/l as Caco3</td>
       <td>Hardness mg/l as Caco3</td>
       <td>E. Coli no/100Ml</td>	  
       <td>Name/Location/Size(sft)</td>
       <td>Is Water convinently Available</td>	     		
       <td>Distance of Water Available from Buliding<br>(In Meters)</td> 
       <td>Is Power Available</td>	
       <td>Name/Location</td>
       <td>Exisiting Plant Type</td>
       <td>Plant Capacity <br>(LPH)</td>
       <td>Name/Location</td>      
</tr>
<tr align="center"  class="btext2">
<%
for(int k=1;k<34;k++)
{
%>
<td > <%=k %>  </td>


<%} %>

</tr>
 <%
  int count=1;
 %>
   
	<logic:notEmpty name="NtrSujala" property="sourceList">
	<nested:iterate id="sourceList" name="NtrSujala" property="sourceList" indexId="ndx">
	
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
	<td  class="rptValue"><html:checkbox name="sourceList" property="checks"   indexed="true" onclick='<%= "fngetenable(" + ndx + ")" %>'  onchange='<%= "fngetenable(" + ndx + ")" %>'  /></td>
		<td class="rptValue"><%=count++%></td>		
	    <td  class="rptValue" ><bean:write name="sourceList" property="constCode"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="shabCode"  />/<br><bean:write name="sourceList" property="habPop"  />/<br><bean:write name="sourceList" property="habstatus"  /></td>
	    <nested:hidden name="sourceList" property="shabCode"  indexed="true"/>
	    <td  class="rptValue" ><bean:write name="sourceList" property="sourceType"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="sourceCode"  /><html:hidden name="sourceList" property="sourceCode" indexed="true" ></html:hidden>/<br><bean:write name="sourceList" property="sourceName"/>/<br><bean:write name="sourceList" property="sourcelocation"/>/<bean:write name="sourceList" property="sourcecondition"  /></td>
	     <nested:hidden name="sourceList" property="sourceCode"  indexed="true"/>
	     <nested:hidden name="sourceList" property="testid"  indexed="true"/>
	    <td  class="rptValue" ><bean:write name="sourceList" property="testDate"  /></td>
	   <nested:hidden name="sourceList" property="testDate"  indexed="true"/>
	    
	    <td  class="rptValue" ><bean:write name="sourceList" property="coptValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="turbValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="phValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="tdsValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="flourideValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="chlorideValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="nitrateValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="ironValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="sulphateValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="alkalinitValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="hardnessValue"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="ecoliValue"  /></td>
	    	     <nested:hidden name="sourceList" property="issueIdent"  indexed="true"/>
	      <nested:hidden name="sourceList" property="plantType"  indexed="true"/>
	    <td  class="rptValue" ><bean:write name="sourceList" property="issueIdent"  /></td>
	    <td  class="rptValue" ><bean:write name="sourceList" property="plantType"  /></td>
	    <td  class="rptValue" ><html:text property="genHealIssuesIdent" name="sourceList" indexed="true" onkeypress="return alpha(event)" maxlength="50"/></td>
	    <td  class="rptValue" ><html:checkbox property="buildingAvailability" name="sourceList"  indexed="true" disabled="true" onclick="fngetenable1()"></html:checkbox></td>
	    <td  class="rptValue" ><html:text property="buildingName" disabled="true" name="sourceList"  indexed="true"  maxlength="50"/>/<html:text property="buildingLoc" disabled="true" name="sourceList"  indexed="true" maxlength="30"/>/<html:text property="buildingSize" disabled="true" name="sourceList"  indexed="true" maxlength="5" onkeypress="return decimalsOnly(event)" /></td>
	    	    <td  class="rptValue" ><html:checkbox property="waterAvailabilty" disabled="true" name="sourceList"  indexed="true" onclick="fngetenable2()"></html:checkbox></td>
	    	    <td  class="rptValue" ><html:text property="waterAvalDist" disabled="true" name="sourceList"  indexed="true" maxlength="5" onkeypress="return decimalsOnly(event)"/></td>
	        <td  class="rptValue" ><html:checkbox property="powerAvailability" disabled="true" name="sourceList"  indexed="true"></html:checkbox>
	       </td>
	    <td  class="rptValue" ><html:checkbox property="anyFirm" disabled="true" onclick="fngetenable3()" name="sourceList"  indexed="true"></html:checkbox></td>
	    	    
	    	    	    <td  class="rptValue" ><html:text property="anyFirmName" disabled="true" name="sourceList"  indexed="true" maxlength="50" onkeypress="return alpha(event)"/>/<html:text property="anyFirmloc" disabled="true" name="sourceList"  indexed="true" maxlength="30" onkeypress="return alpha(event)"/></td>
	    	    	    <td  class="rptValue" >
	    	    	    <html:select property="anyFirmExtPlantType" name="sourceList"   indexed="true" styleClass="mycombo" style="width:80px" >
				<html:option value="">SELECT...</html:option>
				<logic:notEmpty name="plantTypes">
				<html:options collection="plantTypes" name="rwsLocationBean" property="value" labelProperty="label" />
				</logic:notEmpty>
				</html:select>
	    	    	   </td>
	    	    	     <td  class="rptValue" ><html:text property="anyFirmExtPlantCap" disabled="true" name="sourceList"  indexed="true" maxlength="5" onkeypress="return decimalsOnly(event)"/></td>
	    <td  class="rptValue" ><html:checkbox property="anyCoporate" disabled="true" name="sourceList"  indexed="true" onclick="fngetenable4()"></html:checkbox></td>
	    	    	    	     <td  class="rptValue" ><html:text property="anyCoporateName" maxlength="50" disabled="true" name="sourceList"  indexed="true" onkeypress="return alpha(event)"/>/<html:text property="anyCoporateloc" maxlength="30" disabled="true" name="sourceList"  indexed="true" onkeypress="return alpha(event)"/></td>
	    
	   	    	    <td  class="rptValue" ><html:select property="phaseImpl"  name="sourceList"  indexed="true" disabled="true">
	   	    	    <html:option value="1">I</html:option>
	   	    	    <html:option value="2">II</html:option>
	   	    	     <html:option value="3">III</html:option>
	   	    	     <html:option value="4">IV</html:option>
	   	    	    </html:select></td>
	  
	    
	    

 </tr>
 </nested:iterate>
 </logic:notEmpty>
 <%if(count==1)
		{
		%><tr><td colspan="34" align="center" class="btext">No Records</td></tr><%}
		else{%><tr><td colspan="34" align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext"><!-- &nbsp;&nbsp;<input type=button value=View id="vBtn" onClick="fnView();" class="btext"> --></td></tr><%}%>
		<input type="hidden" name="resultCount" value="<%=count%>"/>
<input type=hidden name=hab1>
  
</table>
</label>
</fieldset>
</td>
</tr>


<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="5500"/>
</jsp:include>
</table>   

</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
