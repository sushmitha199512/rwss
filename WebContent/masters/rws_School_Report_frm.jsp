<%@ include file="/commons/rws_head.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<script language="JavaScript">
window.history.forward(1);
<!--

function  enable(field)
{
	document.getElementById(field).disabled=false;
}

function  disable(field)
{
	document.getElementById(field).disabled=true;
}

function getClassify()
{
	return true;
}

function funFac()
{
	return true;
}

function getData()
{
document.forms[0].action="switch.do?prefix=/masters&page=/schoolrep.do&mode=data";
document.forms[0].submit();
}

function viewFun()
{
var dist=document.getElementById('district').value;
var mand=document.getElementById('mandal').value;
var panch=document.getElementById('panchayat').value;
var vill=document.getElementById('village').value;
var hab=document.getElementById('habitation').value;
var nos=document.getElementById('nostudents').value;
var nob=document.getElementById('noBoys').value;
var nog=document.getElementById('noGirls').value;
var faci=document.getElementById('facilities').value;
var classi=document.getElementById('classify').value;
var categ=document.getElementById('category').value;
var message="";
var res=0;
if(dist=="-1")
{
alert("Select District Name");
return false;
}
else 
{
	return true;
}
}


function totalfn1()
{

var nos=document.getElementById('noStudents').value;
var nob=document.getElementById('noBoys').value;
var nog=document.getElementById('noGirls').value;
no=parseInt(nob)+parseInt(nog);
if(parseInt(nos)!=no)
{
alert("No.Of Students != No.Of Boys+No.Of Girls");
}
return true;
}



//-->
</script>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy serve
%>

<title>School Master</title>
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
</head>

<body bgcolor="#edf2f8">
<html:form action="schoolrep.do&mode=data">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="School Form" />
	<jsp:param name="TWidth" value="740" />
	<jsp:param name="contextHelpUrl" value="./help/Help For PRED.doc" />
</jsp:include>

<table width="780" border="0" bgcolor="#DEE3E0" bordercolor="#8A9FCD" style="border-collapse:collapse;" align="center">
<tr>
<td>  
	<fieldset>
	<legend>District Details</legend>
	<label>
	<table border=0 width="100%" align="center">
	<tr>
		<td class="textborder" width="50%">District<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:select property="district" styleClass="mycombo" style="width:160px" onchange="getData();">
		<option value="-1">SELECT...</option>
		<logic:present name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
		</td>

	   	<td class="textborder" width="50%">Mandal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:select property="mandal" style="width:160px" styleClass="mycombo" onchange="getData();">
		<option value="-1">SELECT...</option>
		<logic:present name="mandals">
		<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	    </td>

   </tr>
  
    <tr>
 		<td class="textborder" width="50%">Panchayat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:select property="panchayat" style="width:160px" styleClass="mycombo" onchange="getData();">
		<option value="-1">SELECT...</option>
		<logic:present name="panchayats">
		<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	    </td>


		<td width="50%" class="textborder">Village&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:select property="village" style="width:160px" styleClass="mycombo" onchange="getData();" >
		<option value="-1">SELECT...</option>
		<logic:present name="villages">
		<html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
		</logic:present>
		</html:select>
	    </td>
    </tr>

    <tr>
	    <td width="290" class="textborder">Habitation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="textborder">
		<html:select property="habitation" style="width:160px" styleClass="mycombo" onchange="javascript:getData();" ><!-- disabled="true" -->
		<option value="-1">SELECT...</option>
		<logic:present name="habitations">
		<html:options collection="habitations" name="labelValueBean" property="habCode" labelProperty="habName" />
		</logic:present>
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
	<legend>School Details</legend>
	<label>
	<table width="100%" border="0" align="center">
  
   <tr>
    <td width="50%" class="textborder"><span>Category of School: </span><span class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <html:select property="category" style="width:160px" styleClass="mycombo" onchange="return getClassify();">
			<option value="00">SELECT..</option>
			<option value="01">Balwadi/Aganwadi</option>
	        <option value="02">Primary</option>
	        <option value="03">Upper Primary</option>
	        <option value="04">Secondary </option>
	        <option value="05">Sr. Secondary</option>
	      </html:select></span>
    </td>
    
    <td width="50%"><span class="textborder">Classification of<br> School:</span><span class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;
       <html:select property="classify" style="width:160px" styleClass="mycombo" >
		    <option value="00">SELECT..</option>
		    <option value="Government">Govt.</option>
	        <option value="Local Body">Local Body</option>
	        <option value="Govt.Aided">Govt. Aided</option>
	        <option value="Private">Private</option>
		</html:select></span>
	</td>
  </tr>  
	
	<tr>
	
	  <td width="50%"><span class="textborder">Facilities Available:</span><span class="textborder"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <html:select property="facilities" style="width:160px" styleClass="mycombo" onchange="return funFac();">
	    <html:option value="00">SELECT..</html:option>
		<html:option value="Drinking Water Only">Drinking Water Only</html:option>
        <html:option value="Sanitation (Toilet Only)">Sanitation (Toilet Only)</html:option>
        <html:option value="Sanitation (Urinal Only)">Sanitation (Urinal Only)</html:option>
        <html:option value="Sanitation (Both)">Sanitation (Both)</html:option>
        <html:option value="Both (Drink. and Sani.)">Both (Drink. &amp; Sani.)</html:option>
        <html:option value="None">None</html:option>
	</html:select>
    </span></td>
  </tr>  
  </table>
  </label>
  </fieldset>
  
  <fieldset>
	<legend>Student Details</legend>
	<label>
	<table width="100%" border="0" >

  <tr>
    <td class="textborder">Number of <span id="lblnoofStudents">Students:&nbsp;&nbsp;&nbsp;</span><span class="textborder">&nbsp;&nbsp;
    <html:select property="noStudents1" style="width:40px" styleClass="mycombo">
		    <OPTION value="&gt;=" selected>&gt;=</OPTION>
			<OPTION value="&lt;=">&lt;=</OPTION>
			<OPTION value="=">=</OPTION>
			<OPTION value="&gt;">&gt;</OPTION>
			<OPTION value="&lt;">&lt;</OPTION>
		</html:select>
	    <html:text property="noStudents" style="width:110px;height:23px" styleClass="mytext" onkeypress="return numeralsOnly(event)"/></span>
    </td>

    
  </tr>
  
  <tr>    
  <td width="50%"><span class="textborder">Number of Boys:</span><span class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <html:select property="noBoys1" style="width:40px" styleClass="mycombo">
		    <OPTION value="&gt;=" selected>&gt;=</OPTION>
			<OPTION value="&lt;=">&lt;=</OPTION>
			<OPTION value="=">=</OPTION>
			<OPTION value="&gt;">&gt;</OPTION>
			<OPTION value="&lt;">&lt;</OPTION>
		</html:select>
  	    <html:text property="noBoys" style="width:110px;height:23px" styleClass="mytext" onkeypress="return numeralsOnly(event)" />      
    </span></td>
    
    <td width="50%" align="left"><span class="textborder">Number of Girls:</span><span class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     <html:select property="noGirls1" style="width:40px" styleClass="mycombo">
		    <OPTION value="&gt;=" selected>&gt;=</OPTION>
			<OPTION value="&lt;=">&lt;=</OPTION>
			<OPTION value="=">=</OPTION>
			<OPTION value="&gt;">&gt;</OPTION>
			<OPTION value="&lt;">&lt;</OPTION>
	</html:select>
    <html:text property="noGirls" style="width:110px;height:23px" styleClass="mytext" onkeypress="return numeralsOnly(event)"   />  <!-- onblur="return totalfn1()" -->    
	</span></td>
   </tr>
     
  </table>
  </label>
  </fieldset>
  
  <fieldset>
	<legend>Separate Boys & Girls Details</legend>
	<label>
	<table width="100%" border="0" align="center">

    <tr>
    <td width="50%" class="textborder">Toilets Available&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <html:select property="toilets" style="width:160px" styleClass="mycombo">
	  <option value="00">SELECT..</option>
	  <option value="Yes(Only for Boys)">Yes (Only for Boys)</option>
      <option value="Yes(Only for Girls)">Yes (Only for Girls)</option>
      <option value="Yes(for Both)">Yes (for Both)</option>
      <option value="None">None</option>
    </html:select>
    </td>
    
     <td width="50%"><span class="textborder">Urinal Available:</span><span class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;
    <html:select property="urinals" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="Yes(Only for Boys)">Yes (Only for Boys)</option>
        <option value="Yes(Only for Girls)">Yes (Only for Girls)</option>
        <option value="Yes(for Both)">Yes (for Both)</option>
        <option value="None">None</option>
      </html:select>
    </span></td>
  </tr>
  
  </table>
  </label>
  </fieldset>
  
  <fieldset>
	<legend>Reasons for Non Availibility Details</legend>
	<label>
	<table width="100%" border="0" align="center">
  
  <tr>
    <td width="50%" class="textborder">Drinking Water Facility:<span class="textborder">
    <html:select property="nonDrink" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="O and M">O &amp; M</option>
        <option value="Quality Of Water">Quality Of Water</option>
        <option value="Quantity Of Water">Quantity Of Water</option>
        <option value="Drying Of Sources">Drying Of Sources</option>
        <option value="Multiple Reasons">Multiple Reasons</option>
        <option value="Others">Others</option>
     </html:select>
    </span></td>

    <td width="50%" class="textborder">Sanitation Facility:<span class="textborder">&nbsp;
    <html:select property="nonSani" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="O and M">O &amp; M</option>
        <option value="Quantity Of Water">Quantity Of Water</option>
        <option value="Drying Of Sources">Drying Of Sources</option>
        <option value="Multiple Reasons">Multiple Reasons</option>
        <option value="Others">Others</option>
      </html:select>
    </span></td>
  </tr>
 
 </table>
  </label>
  </fieldset>
  
  <fieldset>
	<legend>Target Details</legend>
	<label>
	<table width="100%" border="0" align="center">
 
  <tr>
    <td width="50%" class="textborder">
    <span id="lblTargetDrinking">Target for Drinking water:<br></span>
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month:<html:select property="drkMonth" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="Jaunary">Jaunary</option>
        <option value="Febuary">Febuary</option>
        <option value="March">March</option>
        <option value="April">April</option>
        <option value="May">May</option>
        <option value="June">June</option>
        <option value="July">July</option>
        <option value="August">August</option>
        <option value="September">September</option>
        <option value="October">October</option>
        <option value="November">November</option>
        <option value="December">December</option>
    </html:select>

    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year:
    <html:select property="drkYear" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="2002">2002</option>
        <option value="2003">2003</option>
        <option value="2004">2004</option>
        <option value="2005">2005</option>
        <option value="2006">2006</option>
        <option value="2007">2007</option>
        <option value="2008">2008</option>
        <option value="2009">2009</option>
        <option value="2010">2010</option>
        <option value="2011">2011</option>
        <option value="2012">2012</option>
        <option value="2013">2013</option>
        <option value="2014">2014</option>
        <option value="2015">2015</option>
        <option value="2016">2016</option>
        <option value="2017">2017</option>
    </html:select>
	</p>
    </td>
    <td width="50%" class="textborder">Target for Sanitation:<span id="lblSanitationMonth"><br></span>

    <span id="lblTargetDrinkingMonth">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Month:</span>
    <html:select property="saniMonth" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="Jaunary">Jaunary</option>
        <option value="Febuary">Febuary</option>
        <option value="March">March</option>
        <option value="April">April</option>
        <option value="May">May</option>
        <option value="June">June</option>
        <option value="July">July</option>
        <option value="August">August</option>
        <option value="September">September</option>
        <option value="October">October</option>
        <option value="November">November</option>
        <option value="December">December</option>
    </html:select>

    
    <p>
       <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: <html:select property="saniYear" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="2002">2002</option>
        <option value="2003">2003</option>
        <option value="2004">2004</option>
        <option value="2005">2005</option>
        <option value="2006">2006</option>
        <option value="2007">2007</option>
        <option value="2008">2008</option>
        <option value="2009">2009</option>
        <option value="2010">2010</option>
        <option value="2011">2011</option>
        <option value="2012">2012</option>
        <option value="2013">2013</option>
        <option value="2014">2014</option>
        <option value="2015">2015</option>
        <option value="2016">2016</option>
        <option value="2017">2017</option>
  </html:select>
  </p></td>
  </tr>
  
  </table>
  </label>
  </fieldset>
  
  <fieldset>
	<legend>Source of Funding Details</legend>
	<label>
	<table width="100%" border="0" align="center">
 
  <tr>
    <td class="textborder" width="50%">Drinking Water Facility:
     <html:select property="sourceDrkFund" style="width:160px" styleClass="mycombo">
	  <option value="00">SELECT..</option>
      <option value="ARWSP">ARWSP</option>
      <option value="Swajaldhara">Swajaldhara</option>
      <option value="SSA">SSA</option>
      <option value="Finance Commission">Finance Commission</option>
      <option value="State Scheme">State Scheme</option>
      <option value="Private">Private</option>
    </html:select></td>
    
    <td class="textborder" width="50%"><span class="textborder">Sanitation Facility:</span><span class="textborder">
    &nbsp;&nbsp;<html:select property="sourceSaniFund" style="width:160px" styleClass="mycombo">
	    <option value="00">SELECT..</option>
        <option value="SSA">SSA</option>
        <option value="Finance Commission">Finance Commission</option>
        <option value="State Scheme">State Scheme</option>
        <option value="Private">Private</option>
        <option value="TSC">TSC</option>
    </html:select>
    </span></td>
   </tr>
  
</table>

</label>
</fieldset>

</td>
</tr>
<tr>
</tr>
 <tr>
    <td colspan="2" align="center">
		<html:submit property="mode" title="View the Fields" styleClass="btext" value="View" onclick="return viewFun();" />
 		<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" /> 

	</td>
 </tr>
 <tr>
</tr>
 <tr>
</tr>
 
</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="740" />
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

