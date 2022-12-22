<%@ include file="/commons/rws_head.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html:html>
<HEAD>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="../theme/Master.css" rel="stylesheet" type="text/css">
<TITLE></TITLE>
</HEAD>
<BODY onload="javascript:showMe();selectAllCheckBoxes();init();">
<center>
<script language="javascript">
var ch=1;

function twoNums()
{
var lev=document.forms[0].tot_wat_supl.value;
if(lev.length>=2)
{
alert("Only Two Numbers are Allowed");
return false;    
}
else 
{
   return true;
}
}
function flex_func()
{
if(formValidate() && reportValidate() && !((document.forms[0].fields[0].checked || document.forms[0].fields[1].checked || document.forms[0].fields[2].checked) && (document.forms[0].district.value=="" ) ) )
{
document.forms[0].action="switch.do?prefix=/Sanitation&page=/IhhlReport.do?mode=outFlex";
document.forms[0].submit();
}
}
function init()
{
document.forms[0].creport[0].checked=false;
document.forms[0].creport[1].checked=false;
document.forms[0].creport[2].checked=false;
document.forms[0].creport[3].checked=false;
document.forms[0].creport[4].checked=false;
document.forms[0].creport[5].checked=false;
document.forms[0].creport[6].checked=false;
document.forms[0].creport[7].checked=false;
// removing this code || document.forms[0].districtName.value!="" for solving javascript error 
if(document.forms[0].district.value!="" )
{
document.forms[0].creport[0].disabled=true;
	 if(document.forms[0].district.value=='ALL')
	 {
		document.forms[0].creport[1].disabled=true;
		document.forms[0].creport[2].disabled=true;
		document.forms[0].creport[3].disabled=true;
		document.forms[0].creport[4].disabled=true;
		document.forms[0].creport[5].disabled=true;
		document.forms[0].creport[7].disabled=true;
		uncheckAllCheckBoxes();
	 }
}
if(document.forms[0].mandal.value!="")
{
document.forms[0].creport[1].disabled=true;
document.forms[0].fields[0].disabled=false;
}
if(document.forms[0].panchayat.value!="")
{
document.forms[0].creport[2].disabled=true;
document.forms[0].fields[1].disabled=false;
}
if(document.forms[0].village.value!="")
{
document.forms[0].creport[3].disabled=true;
document.forms[0].fields[2].disabled=false;
}
if(document.forms[0].habCode.value!="")
{
document.forms[0].creport[4].disabled=true;
document.forms[0].fields[3].disabled=false;
}
}

function funcDistrictChanged()
{
document.forms[0].action="switch.do?prefix=/Sanitation&page=/IhhlReport.do?mode=inFlexi";
document.forms[0].submit();
}
function fnSelectionChanged()
{
	document.forms[0].action="switch.do?prefix=/Sanitation&page=/IhhlReport.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnPanchayataChanged()
{
	document.forms[0].action="switch.do?prefix=/Sanitation&page=/IhhlReport.do?mode=inFlexi";
	document.forms[0].submit();
}

function disableField()
{

for(var i=0;i<document.forms[0].fields.length;i++)
{
document.forms[0].fields[i].disabled=true;
}

}
function enableField()
{
for(var i=0;i<document.forms[0].fields.length;i++)
{
document.forms[0].fields[i].disabled=false;
}
   
	if(document.forms[0].mandal.value!="")
		{
		document.forms[0].fields[0].disabled=false;
		}
	if(document.forms[0].panchayat.value!="")
	   {
		document.forms[0].fields[1].disabled=false;
	   }
	if(document.forms[0].village.value!="")
      {
      document.forms[0].fields[2].disabled=false;
      }
     if(document.forms[0].habCode.value!="")
	  {
//      document.forms[0].fields[3].disabled=true; 
      }
}




function mpvCheck()
{
if((document.forms[0].fields[0].checked || document.forms[0].fields[1].checked || document.forms[0].fields[2].checked) && (document.forms[0].district.value=="" ) )
{
alert("District Required ");
}
return;
}

function mmvalidate()
{
	if (document.forms[0].district.value=="" )
	{
		alert("District Required");
	}
return;
}


function condition()
{
	alert("condition ok");
	if(document.forms[0].district.value=="")
	{
		alert("District Required");
		
		}
	else if(document.forms[0].village.value!="")
	{ alert("For Consolidated Report Select only District.. Mandal,Panchayat,Village is Not Required");
		}

	else if(document.forms[0].panchayat.value!="")
	{
		alert("For Consolidated Report Select only District.. Mandal &Panchayat is Not Required");
		}
	
	else if(document.forms[0].mandal.value!="")
	{ 
		alert("For Consolidated Report Select Only District.. Mandal is Not Required");
	}
	else
	{
		document.forms[0].action="switch.do?prefix=/Sanitation&page=/IhhlReport.do?mode=outFlex";
		document.forms[0].submit();
	}
	}
function reportValidate()
{
var selected=false;
var report=document.forms[0].creport;
for (var i=0;i<report.length;i++)
{
if (report[i].checked)
{
selected=true;
}
}
if( selected==false)
{
alert("Report Type is Required");
}
return selected;
}


function selectAllCheckBoxes() {	
	var formObj;
	var fldObj;
	formObj = document.forms[0];
	for (var i=0;i < formObj.length;i++) 
	{
	fldObj = formObj.elements[i];
	if (fldObj.type == 'checkbox')
	 { 
	 if (fldObj.name == 'fields' || fldObj.name== 'checkall')
	  { 
	  fldObj.checked = true;
	  }
	 } 
    } 
	if(document.forms[0].mandal.value!="")
		{
		document.forms[0].fields[0].disabled=false;
		}
	if(document.forms[0].panchayat.value!="")
		{
		document.forms[0].fields[1].disabled=false;
		}
	if(document.forms[0].village.value!="")
    {
      document.forms[0].fields[2].disabled=false;
     }
     if(document.forms[0].habCode.value!="")
     {
     // document.forms[0].fields[3].disabled=false;
     }
    }
    
    
    function uncheckAllCheckBoxes() {	

	var formObj;

	var fldObj;

	formObj = document.forms[0];
      // alert("in uncheck all function");
	for (var i=0;i < formObj.length;i++) {

		fldObj = formObj.elements[i];
                
		if (fldObj.type == 'checkbox') 
		{ 
		if (fldObj.name == 'fields')
		 { 
            fldObj.checked = false;
          }
		} 
        }
        document.forms[0].fields[0].checked=true;
        document.forms[0].fields[1].checked=true;
        document.forms[0].fields[2].checked=true;
        document.forms[0].fields[3].checked=true;
		document.forms[0].fields[4].checked=true;
        
    if(document.forms[0].mandal.value!="")
		{
		document.forms[0].fields[0].disabled=false;
		}
	if(document.forms[0].panchayat.value!="")
		{
		document.forms[0].fields[1].disabled=false;
		}
	if(document.forms[0].village.value!="")
       {
      document.forms[0].fields[2].disabled=false;
       }
       if(document.forms[0].habCode.value!="")
       {
   //    document.forms[0].fields[3].disabled=true;
       }
 }

function playCheckBoxes()
{
var button=document.forms[0].checkall.checked;
if (button==true)
{
selectAllCheckBoxes();
}
else
{
uncheckAllCheckBoxes();
}
}


function formValidate()
{
var formstatus=true;
var formfield;
var formfield1;
var farr=new Array();
var count=0;
formfield = document.forms[0];

	for (var i=0;i < formfield.length;i++)
	 {
    	formfield1 = formfield.elements[i];
    
    		if (formfield1.type == 'text') 
	     	{ 
	     	if (formfield1.value == "")
		      { 
     			farr[count]=formfield1.name;
     			count++;
     		  }
		    } 
	     
	     if(formfield1.type=='checkbox')
	     {
	        if(formfield1.name=='compl_stat' || formfield1.name=='prev_stat')
	        {
	        if(!(formfield1.checked))
	        {
	        farr[count]=formfield1.name;
	        count++;
	        }
	        }
	        }
	 }
	 if ((document.forms[0].creport[0].checked==false))
      {
     if((document.forms[0].district.value=="" ))
       {
      if(farr.length==25)
        {
         formstatus=false;
        }
       }
       }
	 if(formstatus==false)
	 {
	 alert("District Required");
	 }
return formstatus;
}

function stateGlance()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/DistrictListAction.do";
	document.forms[0].submit();
}

function showMe() {
if((document.forms[0].creport[7].checked))
{
	document.getElementById('a1').style.display='block';
	document.forms[0].checkall.disabled=true; 
}
else
{
	document.getElementById('a1').style.display='none';
	document.forms[0].checkall.disabled=false; 
}
}

function fncheckslippage(){
//alert("in the fncheckslippage");
//alert("value--->"+document.forms[0].fields[9].value);
//alert("value 1-------->"+document.forms[0].fields[10].value);
document.forms[0].fields[9].checked=true;
document.forms[0].fields[10].checked=true;
}
function fnchk(){
//alert("in the fnchk");
if(document.forms[0].fields[11].checked){
//alert("in the fnchk function");
document.forms[0].fields[9].checked=true;
document.forms[0].fields[10].checked=true;
}
}
</script>
<center>
<html:form action="/IhhlReport.do">
<jsp:include page="/commons/TableHeader.jsp">
<jsp:param name="TableName" value="IHHL-Free Format Report"/>
<jsp:param name="TWidth" value="780"/>
<jsp:param name="Tborder" value="0"/>
</jsp:include>

<table align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
	<tr><td class="mycborder">
		<fieldset>
		<legend>District Details</legend>
		 <table  border=0  width="100%">
		 <tr><td><font color="#000000" face=verdana size=2><B>District&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 
		 <logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
         <html:select property="district" style="width:141px"   onchange="javascript: funcDistrictChanged();" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <html:option value="ALL">ALL</html:option>
		 <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
    	 </html:select>
		 </logic:equal>
		 
		 <logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
		 <html:text property="districtName" styleClass="mytext" style="width:140px"  readonly="true" />
		 <html:hidden property="district"/>
		 </logic:notEqual>
		</td>

	<td class="textborder">Mandal&nbsp;
		<html:select property="mandal" style="width:140px"    styleClass="mycombo" onchange="fnSelectionChanged()">
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	</td>
</tr>

	<tr><td>
		<font color="#000000" face=verdana size=2><B>Panchayat
		<html:select property="panchayat" style="width:140px"    styleClass="mycombo" onchange="fnSelectionChanged()" >
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
		</html:select>
	 </td>

	<td>
		 <font color="#000000" face=verdana size=2><B>Village
		 <html:select property="village" style="width:140px"    styleClass="mycombo" onchange="fnSelectionChanged()">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
		 </html:select>
	</td>
	</tr>
		
    <tr>
        <td><font color="#000000" face=verdana size=2><B>Habitation</b>
        <html:select property="habCode" styleClass="mycombo" style="width:280px"   onchange="javascript:fnSelectionChanged()">
	    <html:option value="">SELECT...</html:option>
	    <html:options collection="habitations" name="rwsMaster" property="habCode" labelProperty="habitationCode" />
	    </html:select>
        </td>
        
        </tr>
        <tr>
        
       <td>
		 <font color="#000000" face=verdana size=2><B>Constituency
		 <html:select property="constituency" style="width:140px"    styleClass="mycombo" >
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <html:options collection="constituents" name="labelValueBean" property="value" labelProperty="label" />
		 </html:select>
	</td>
        
     </tr>	
	
</TABLE>
</fieldset>

<table align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;" width="780" >	
<tr>
	<td class="mycborder">
	<fieldset>
	<legend>IHHL Details</legend>
	 <table  border=0  width="100%">
			

			 <tr>
	  <td ><font color="#000000" face=verdana size=2><B>Gender</b>
		
		                <html:select property="gen" styleClass="mycombo" style="width:80px">
		                       <html:option value="">SELECT...</html:option>
		                       <html:option value="F">FeMale</html:option>
		                       <html:option value="M">Male</html:option>
		                    
		                </html:select>   
		</td>
		
		
			<td>
		 <font color="#000000" face=verdana size=2><B>Card Type
		 <html:select property="cardid" style="width:140px"    styleClass="mycombo" onchange="fnSelectionChanged()">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <html:options collection="cardtypes" name="labelValueBean" property="value" labelProperty="label" />
		 </html:select>
	</td>
		

		<td>
		 <font color="#000000" face=verdana size=2><B>Category
		 <html:select property="category" style="width:140px"    styleClass="mycombo" onchange="fnSelectionChanged()">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <html:options collection="categories" name="labelValueBean" property="value" labelProperty="label" />
		 </html:select>
	</td>
	
			<td>
		 <font color="#000000" face=verdana size=2><B>Sub Category
		 <html:select property="subcategory" style="width:140px"    styleClass="mycombo" >
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <html:options collection="subcategories" name="labelValueBean" property="value" labelProperty="label" />
		 </html:select>
	</td>
	
		</tr>
		</table>
	</fieldset>
	


<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<TR><TH WIDTH="22%">Report Type<TH WIDTH="76%">Report Layout</TH></TR>

<tr>
<td><font color="#000000" face=verdana size=2>

</td>
<td rowspan="3">
<table>
<tr>
<td>
<INPUT type="checkbox" name="fields" value="Constituency" checked onClick="return false"><font color="#000000" face=verdana size=2><B>Constituency</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Mandal" checked onClick="return false"><font color="#000000" face=verdana size=2><B>Mandal</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Panchayat" checked onClick="return false" ><font color="#000000" face=verdana size=2><B>Panchayat</B></font>&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="fields" value="Village" checked onClick="return false"><font color="#000000" face=verdana size=2><B>Village</B></font></td></tr>
<tr><td>
<INPUT type="checkbox" name="fields" value="Habitation" checked onClick="return false"><font color="#000000" face=verdana size=2><B>Habitation</B></font></td></tr>


<tr><td>
<INPUT type="checkbox" name="fields" value="Family Head" ><font color="#000000" face=verdana size=2><B>Family Head</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Father/Husband Name"><font color="#000000" face=verdana size=2><B>Father Husband Name</td><td>
<INPUT type="checkbox" name="fields" value="Gender" ><font color="#000000" face=verdana size=2><B>Gender</td></tr>
<tr><td>
<INPUT type="checkbox" name="fields" value="Card Type" ><font color="#000000" face=verdana size=2><B>Card Type</td><td>
<INPUT type="checkbox" name="fields" value="Card Number" ><font color="#000000" face=verdana size=2><B>Card Number</td><td>
<INPUT type="checkbox" name="fields" value="Category" ><font color="#000000" face=verdana size=2><B>Category</td></tr>

<tr><td>
<INPUT type="checkbox" name="fields" value="Sub Category" ><font color="#000000" face=verdana size=2><B>Sub Category</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Aadhaar Card" ><font color="#000000" face=verdana size=2><B>Aadhaar Card</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Mobile Number" ><font color="#000000" face=verdana size=2><B>Mobile Number</B></font></td></tr>

<tr><td>
<INPUT type="checkbox" name="fields" value="Toilet Constructed From" ><font color="#000000" face=verdana size=2><B>Toilet Constructed From</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Is Having Toilet" ><font color="#000000" face=verdana size=2><B>Is Having Toilet</B></font></td><td nowrap>
<INPUT type="checkbox" name="fields" value="Is Having Toilet Functional" ><font color="#000000" face=verdana size=2><B>Is Having Toilet Functional</B></font></td></tr>

<tr><td>
<INPUT type="checkbox" name="fields" value="Is Having Toilet Functional Used" ><font color="#000000" face=verdana size=2><B>Is Having Toilet Functional Used</td><td>
<INPUT type="checkbox" name="fields" value="Is WaterFacility Avaliable" ><font color="#000000" face=verdana size=2><B>Is WaterFacility Available</td><td>
<INPUT type="checkbox" name="fields" value="HabCode State" ><font color="#000000" face=verdana size=2><B>HabCode State</td></tr>

<tr>
<td>
<INPUT type="checkbox" name="fields" value="GramPanchayat Code" ><font color="#000000" face=verdana size=2><B>GramPanchayatCode</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Benificial Id" ><font color="#000000" face=verdana size=2><B>Benificial Id</B></font></td><td>

<INPUT type="checkbox" name="fields" value="NBA Village Id" ><font color="#000000" face=verdana size=2><B>NBA Village Id</B></font></td></tr>



<br>
<tr>   
<td colspan="3" align="center">
<INPUT type="checkbox" name="checkall" value="true" onclick="javascript:playCheckBoxes();"><font color="indigo" face="verdana" size=2><B>Check All</B></font></td>
</tr>
<tr><td class="mycborder" colspan="2">

</td></tr>
</table>  
</td></tr>
<tr><td ><font color="#000000" face=verdana size=2><B>Detail Report
<table>
<tr><td><INPUT type="radio" name="creport" value="hlist" onclick="JavaScript:enableField();showMe();"><font color="#000000" face=verdana size=2>IHHL List</font></td></tr>
</table></td>

<tr><td><font color="#000000" face=verdana size=2><B>Consolidated Report
<table>
<tr><td><INPUT type="radio" name="creport" value="chlist" onclick="JavaScript:disableField();showMe();" ><font color="#000000" face=verdana size=2>No. Of IHHL's</td></tr>
</table>
</td></tr> 
</table>
	</fieldset>

	<center><input type="button" value="Submit" name="Submit" class="btext" onclick="JavaScript:mpvCheck();flex_func();">
	<!-- 		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <INPUT type="reset" value="Reset" readonly class="btext"> -->
	</center>
	</table></table>
	
	</table>
	
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="780" />
	</jsp:include>
	
</html:form>
</center>

<p align="center">
<font face="Times New Roman" size="2" color="red" align="center">
Note:1. For Detail Report Select District,Mandal and Panchayat are Mandatory Fields.Village and Habitation is optional</font></p>
<p align="center">
<font face="Times New Roman" size="2" color="red" align="center">
2.For Consolidated Report Select District and Any one of IHHL Details  like Gender/CardType/Category & SubCategory </font></p>



<%@ include file="/commons/rws_footer.jsp"%>
</center>
</BODY>
</html:html>
