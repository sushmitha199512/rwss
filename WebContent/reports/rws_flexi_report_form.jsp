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
function numeralsOnly1(evt)
{

    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : ((evt.which) ? evt.which : 0));
    if (charCode > 31 && (charCode < 48 || charCode > 57) && (charCode!=46))
	{
	    alert("Only numbers are allowed in this field.");
        return false;
    }
    else if(ch==1)
    {
	    ch=2;
    	alert(" sdfEnter the Number in 22.22 Format");
    	return true;
    }
    return true;
}
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
document.forms[0].action="switch.do?prefix=/reports&page=/flexReport.do?mode=outFlex";
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
document.forms[0].action="switch.do?prefix=/reports&page=/flexReport.do?mode=inFlexi";
document.forms[0].submit();
}
function fnSelectionChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnPanchayataChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport.do?mode=inFlexi";
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
<html:form action="/flexReport.do">
<jsp:include page="/commons/TableHeader.jsp">
<jsp:param name="TableName" value="Habitation-Free Format Report"/>
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
	
</TABLE>
</fieldset>

<table align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;" width="780" >	
<tr>
	<td class="mycborder">
	<fieldset>
	<legend>Populations Details</legend>
	 <table  border=0  width="100%">
			<tr>
				<td><font color="#000000" face=verdana size=2><B>Census Plain</b>
				    <SELECT name="cp_condition">
							<OPTION value="&gt;=" selected>&gt;=</OPTION>
							<OPTION value="&lt;=">&lt;=</OPTION>
							<OPTION value="=">=</OPTION>
							<OPTION value="&gt;">&gt;</OPTION>
							<OPTION value="&lt;">&lt;</OPTION>
				   </SELECT>
				<html:text property="cp" size="15" onkeypress="return numeralsOnly()"></html:text></td>
				<td><font color="#000000" face=verdana size=2><B>Census SC</b>&nbsp;&nbsp;&nbsp;
				        <SELECT name="csc_condition">
							<OPTION value="&gt;=" selected>&gt;=</OPTION>
							<OPTION value="&lt;=">&lt;=</OPTION>
							<OPTION value="=">=</OPTION>
							<OPTION value="&gt;">&gt;</OPTION>
							<OPTION value="&lt;">&lt;</OPTION>
						</SELECT> 
				<html:text property="csc" size="15" onkeypress="return numeralsOnly()"></html:text></td>
                <td><font color="#000000" face=verdana size=2><B>Floating Pop</b>&nbsp;
                       <SELECT name="flopop_condition">
							<OPTION value="&gt;=" selected>&gt;=</OPTION>
							<OPTION value="&lt;=">&lt;=</OPTION>
							<OPTION value="=">=</OPTION>
							<OPTION value="&gt;">&gt;</OPTION>
							<OPTION value="&lt;">&lt;</OPTION>
						</SELECT>
                
                <html:text	property="flopop" size="10" onkeypress="return numeralsOnly()"></html:text></td>
                    					
			</tr>
			<tr>
				<td><font color="#000000" face=verdana size=2><B>Census ST</b>&nbsp;&nbsp;&nbsp;
				<SELECT name="cst_condition">
							<OPTION value="&gt;=" selected>&gt;=</OPTION>
							<OPTION value="&lt;=">&lt;=</OPTION>
							<OPTION value="=">=</OPTION>
							<OPTION value="&gt;">&gt;</OPTION>
							<OPTION value="&lt;">&lt;</OPTION>
						</SELECT>
				
				 <html:text	property="cst" size="15" onkeypress="return numeralsOnly()"></html:text></td>
				<td><font color="#000000" face=verdana size=2><B>Census Total</b>
				<SELECT name="ctot_condition">
							<OPTION value="&gt;=" selected>&gt;=</OPTION>
							<OPTION value="&lt;=">&lt;=</OPTION>
							<OPTION value="=">=</OPTION>
							<OPTION value="&gt;">&gt;</OPTION>
							<OPTION value="&lt;">&lt;</OPTION>
						</SELECT>
				
				<html:text property="ctot" size="15" onkeypress="return numeralsOnly()"></html:text></td>
				<td><font color="#000000" face=verdana size=2><B>Reason for Floating</B>
				<SELECT	name="freason">
							<OPTION value="" selected>SELECT...</OPTION>
							<OPTION value="market">Market</OPTION>
							<OPTION value="temple">Temple</OPTION>
							<OPTION value="others">Others...</OPTION>
					</SELECT>
			 </td>
			</tr>
			 <tr>
	  <td ><font color="#000000" face=verdana size=2><B>Habitation Type</b>
		
		                <html:select property="habType" styleClass="mycombo" style="width:80px">
		                       <html:option value="">SELECT...</html:option>
		                       <html:option value="NORMAL">NORMAL</html:option>
		                       <html:option value="AGENCY">AGENCY</html:option>
		                       <html:option value="COASTAL">COASTAL</html:option>
		                </html:select>   
		</td>
		<td ><font color="#000000" face=verdana size=2><B>Habitation SubType</b>
		
		                <html:select property="habSubType" styleClass="mycombo" style="width:80px">
		                       <html:option value="">SELECT...</html:option>
		                       <html:option value="PLAIN">PLAIN</html:option>
		                       <html:option value="SC">SC</html:option>
		                       <html:option value="ST">ST</html:option>
		                </html:select>   
		</td>
		<td class="textborder" >&nbsp;Habitation Category</b>
		
		                <html:select property="habCat" styleClass="mycombo" style="width:65px">
						<html:option value="">SELECT...</html:option>
		                       <html:option value="NONE">NONE</html:option>
    	                       <html:option value="HILLY">HILLY</html:option>
    	                       <html:option value="DDP">DDP</html:option>
		                       
		                </html:select>   
		</td>
</tr>
		</table>
	</fieldset>
	
<table align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
	<td class="mycborder">
		<fieldset>
		<legend>Current Coverage Status</legend>
	<table  border=0  width="100%">
	
	<tr>
    	<td><INPUT type="checkbox" name="compl_stat" value="FC" ><font color="#000000" face=verdana size=2><B>FC</td>
        <td><INPUT type="checkbox" name="compl_stat" value="PC1"><font color="#000000" face=verdana size=2><B>PC1</td>
        <td><INPUT type="checkbox" name="compl_stat" value="PC2"><font color="#000000" face=verdana size=2><B>PC2</td>
        <td><INPUT type="checkbox" name="compl_stat" value="PC3"><font color="#000000" face=verdana size=2><B>PC3</td>
        <td><INPUT type="checkbox" name="compl_stat" value="PC4"><font color="#000000" face=verdana size=2><B>PC4</td>
        <td><INPUT type="checkbox" name="compl_stat" value="NC"><font color="#000000" face=verdana size=2><B>NC</td>
        <td><INPUT type="checkbox" name="compl_stat" value="NSS"><font color="#000000" face=verdana size=2><B>NSS</td>
	</TR>
</table>
</fieldset>

<table align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
	<td class="mycborder">
		<fieldset>
		<legend>Previous Year Coverage Status</legend>
   <table  border=0  width="100%">
	
	<tr>
    	<td><INPUT type="checkbox" name="prev_stat" value="FC"><font color="#000000" face=verdana size=2><B>FC</td>
        <td><INPUT type="checkbox" name="prev_stat" value="PC1"><font color="#000000" face=verdana size=2><B>PC1</td>
        <td><INPUT type="checkbox" name="prev_stat" value="PC2"><font color="#000000" face=verdana size=2><B>PC2</td>
        <td><INPUT type="checkbox" name="prev_stat" value="PC3"><font color="#000000" face=verdana size=2><B>PC3</td>
        <td><INPUT type="checkbox" name="prev_stat" value="PC4"><font color="#000000" face=verdana size=2><B>PC4</td>
        <td><INPUT type="checkbox" name="prev_stat" value="NC"><font color="#000000" face=verdana size=2><B>NC</td>
        <td><INPUT type="checkbox" name="prev_stat" value="NSS"><font color="#000000" face=verdana size=2><B>NSS</td>
   </TR>
</table>
</fieldset>

<table align=center bgcolor="#DEE3E0" bordercolor="#8A9FCD"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
<td class="mycborder">
	<fieldset>
		<legend>Water Resource Details</legend>
    <table  border=0  width="100%">
	<tr>
		<td><font color="#000000" face=verdana size=2><B>Total Water Supply (Safe)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
		<SELECT name="tot_wat_supl_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
		<html:text property="tot_wat_supl" size="10" onkeypress="return numeralsOnly()"></html:text>
		
		</td>
		<td><font color="#000000" face=verdana size=2><B>Exist Water Level&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
		<SELECT name="ext_wat_lvl_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
				</SELECT>
		<html:text property="ext_wat_lvl" size="10" onkeypress="return numeralsOnly()"></html:text>
		</td>
	</tr>
	<!-- commented by pranavi -->
   <!-- <tr>
		<td><font color="#000000" face=verdana size=2><B>Dist.From Surface Source(No)</b>
		<SELECT name="near_surf_source_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
							<html:text property="near_surf_source" size="10" onkeypress="return numeralsOnly()"></html:text></td>
		<td><font color="#000000" face=verdana size=2><B>Dist.From Ground Source(No)</b>
		<SELECT name="near_ground_source_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>		
		<html:text	property="near_ground_source" size="10" onkeypress="return numeralsOnly()"></html:text></td>
	</tr>-->
</table>
</fieldset>

<font color="#000000" face=verdana size=2><B>
  &nbsp;&nbsp;Prop. Year for Full Coverage</B></font>&nbsp;<font color="#000000" face=verdana size=1>(yyyy)</font><INPUT type="text" name="prop_year" size="10" maxlength="4" value="" onkeypress="return numeralsOnly();">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b><font color="#000000" face=verdana size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Amount Required for FC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT name="amnt_reqd_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>&nbsp;<INPUT type="text" name="amnt_reqd" size="10" maxlength="10"  onkeypress="return numeralsOnly()">
</b>
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<font color="#000000" face=verdana size=1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>

<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<TR><TH WIDTH="22%">Report Type<TH WIDTH="76%">Report Layout</TH></TR>

<tr>
<td><font color="#000000" face=verdana size=2><B>Master Report
<table>
<tr><td><INPUT type="radio" name="creport" value="masterd" onclick="JavaScript:disableField();showMe();"><font color="#000000" face=verdana size=2>Districts</td></tr>
<tr><td><INPUT type="radio" name="creport" value="masterm" onclick="JavaScript:showMe();disableField(); return mmvalidate();"><font color="#000000" face=verdana size=2>Mandals</td></tr>
<tr><td><INPUT type="radio" name="creport" value="masterp" onclick="JavaScript:showMe();disableField(); return mmvalidate();"><font color="#000000" face=verdana size=2>Panchayats</td></tr>
<tr><td><INPUT type="radio" name="creport" value="masterv" onclick="JavaScript:showMe();disableField(); return mmvalidate();"><font color="#000000" face=verdana size=2>villages</td></tr>
<tr><td><INPUT type="radio" name="creport" value="masterh" onclick="JavaScript:showMe();disableField(); return mmvalidate();"><font color="#000000" face=verdana size=2>Habitations</td></tr>
<tr><td><INPUT type="radio" name="creport" value="stateglance" onclick="JavaScript:stateGlance();"><font color="#000000" face=verdana size=2>State At a Glance</td></tr>
</table>
</td>
<td rowspan="3">
<table>
<tr>
<td>
<INPUT type="checkbox" name="fields" value="Constituency" checked onClick="return false"><font color="#000000" face=verdana size=2><B>Constituency</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Mandal" checked onClick="return false"><font color="#000000" face=verdana size=2><B>Mandal</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Panchayat" checked onClick="return false"><font color="#000000" face=verdana size=2><B>Panchayat</B></font>&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="fields" value="Village" checked onClick="return false"><font color="#000000" face=verdana size=2><B>Village</B></font></td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="Habitation" checked onClick="return false"><font color="#000000" face=verdana size=2><B>Habitation</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Habitation Type"><font color="#000000" face=verdana size=2><B>Habitation Type </B></font></td><td>
<INPUT type="checkbox" name="fields" value="Habitation Sub Type"><font color="#000000" face=verdana size=2><B>Habitation Sub Type</B></font></td><td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="Habitation Category"><font color="#000000" face=verdana size=2><B>Habitation Category</B></font></td><td>
<INPUT type="checkbox" name="fields" value="LPCD (Safe Supply)"><font color="#000000" face=verdana size=2><B>LPCD (Safe Supply)</td><td>
<INPUT type="checkbox" name="fields" value="Update Date"><font color="#000000" face=verdana size=2><B>Update Date</td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="Prev Yr Status" onClick="fnchk()"><font color="#000000" face=verdana size=2><B>Previous Yr. Status</td><td>
<INPUT type="checkbox" name="fields" value="Present Yr Status" onClick="fnchk()"><font color="#000000" face=verdana size=2><B>Present Yr. Status</td><td>
<INPUT type="checkbox" name="fields" value="Reasons for Slippage" onClick="fncheckslippage()"><font color="#000000" face=verdana size=2><B>Reasons for Slippage</td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="Census Year"><font color="#000000" face=verdana size=2><B>Census Year</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Census Plain Pop."><font color="#000000" face=verdana size=2><B>Census Plain Pop.</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Census SC Pop"><font color="#000000" face=verdana size=2><B>Census SC Pop.</B></font></td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="Census ST Pop"><font color="#000000" face=verdana size=2><B>Census ST Pop.</B></font></td><td>
<INPUT type="checkbox" name="fields" value="Floationg Pop"><font color="#000000" face=verdana size=2><B>Floating Pop.</B></font></td><td nowrap>
<INPUT type="checkbox" name="fields" value="Reason for Floating Pop."><font color="#000000" face=verdana size=2><B>Reason for Float. Pop.</B></font></td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="Status Date"><font color="#000000" face=verdana size=2><B>Status Date</td><td>
<INPUT type="checkbox" name="fields" value="Plain Pop. Covered"><font color="#000000" face=verdana size=2><B>Plain Pop. Covered</td><td>
<INPUT type="checkbox" name="fields" value="SC Pop. Covered"><font color="#000000" face=verdana size=2><B>SC Pop. Covered</td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="ST Pop. Covered"><font color="#000000" face=verdana size=2><B>ST Pop. Covered</td><td>
<INPUT type="checkbox" name="fields" value="Total Population"><font color="#000000" face=verdana size=2><B>Total Population</B>(Plain+SC+ST)</td><td>
<INPUT type="checkbox" name="fields" value="No Of HouseHolds"><font color="#000000" face=verdana size=2><B>No Of House Holds</td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="No Of HouseConnections"><font color="#000000" face=verdana size=2><B>No Of House Connections</td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="No Of Cattles"><font color="#000000" face=verdana size=2><B>No Of Cattles</td><td>
<!-- <INPUT type="checkbox" name="fields" value="Coverage Status"><font color="#000000" face=verdana size=2><B>Coverage Status</td><td>-->
<!-- <INPUT type="checkbox" name="fields" value="Near Surface Source"><font color="#000000" face=verdana size=2><B>Near Surface Source</td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="Near Ground Source"><font color="#000000" face=verdana size=2><B>Near Ground Source</td><td>-->
<INPUT type="checkbox" name="fields" value="No Of Existing Sources"><font color="#000000" face=verdana size=2><B>No&nbsp;Of&nbsp;Existing&nbsp;Sources</td><td>
<INPUT type="checkbox" name="fields" value="No Of Safe Sources"><font color="#000000" face=verdana size=2><B>No Of Safe&nbsp;Sources</td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="Remarks"><font color="#000000" face=verdana size=2><B>Remarks</td><td>
<INPUT type="checkbox" name="fields" value="Quality Affected"><font color="#000000" face=verdana size=2><B>Quality Affected</td><td>
<INPUT type="checkbox" name="fields" value="Nearest Available Source"><font color="#000000" face=verdana size=2><B>Nearest&nbsp;Available&nbsp;Source</td></tr><tr><td>
<INPUT type="checkbox" name="fields" value="Distance From HouseHolds"><font color="#000000" face=verdana size=2><B>Distance&nbsp;From&nbsp;HouseHolds</td><td>
<INPUT type="checkbox" name="fields" value="Prop FC Year"><font color="#000000" face=verdana size=2><B>Prop. FC Year</td><td nowrap>
<INPUT type="checkbox" name="fields" value="Prop FC Amnt"><font color="#000000" face=verdana size=2><B>Prop.FC Est.Amount</td></tr><tr>
<td colspan='2'><INPUT type="checkbox" name="fields" value="Total Water Supply(Unsafe)"><font color="#000000" face=verdana size=2><B>Total&nbsp;Water&nbsp;Supply&nbsp;(UnSafe)</B></td><td>
<INPUT type="checkbox" name="fields" value="Total Water Supply(Safe)"><font color="#000000" face=verdana size=2><B>Total&nbsp;Water&nbsp;Supply&nbsp;(Safe)</td>
</tr>
<tr>
<td colspan="1"><INPUT type="checkbox" name="fields" value="Minority"><font color="#000000" face=verdana size=2><B>Is Minority Hab</B></td>
<td colspan="1"><INPUT type="checkbox" name="fields" value="LWE/Naxal"><font color="#000000" face=verdana size=2><B>Is LWE/Naxal</B></td>
<td colspan="1"><INPUT type="checkbox" name="fields" value="LPCD(UnSafe)"><font color="#000000" face=verdana size=2><B>LPCD(UnSafe)</B></td></tr><tr>
<td colspan="1"><INPUT type="checkbox" name="fields" value="LPCD(Cooking)"><font color="#000000" face=verdana size=2><B>Safe LPCD of Drinking & Cooking</B></td>
<td colspan="1"><INPUT type="checkbox" name="fields" value="TSP(ITDA)"><font color="#000000" face=verdana size=2><B>TSP(ITDA)</B></td>
<td colspan="1"><INPUT type="checkbox" name="fields" value="LATITUDE"><font color="#000000" face=verdana size=2><B>LATITUDE</B></td>
<td colspan="1"><INPUT type="checkbox" name="fields" value="LONGITUDE"><font color="#000000" face=verdana size=2><B>LONGITUDE</B></td></tr>
<tr><td colspan="1"><INPUT type="checkbox" name="fields" value="ELEVATION"><font color="#000000" face=verdana size=2><B>ELEVATION</B></td>
<td colspan="1"><INPUT type="checkbox" name="fields" value="WAY_POINT"><font color="#000000" face=verdana size=2><B>WAY_POINT</B></td>
<td colspan="1"><INPUT type="checkbox" name="fields" value="LANDMARK"><font color="#000000" face=verdana size=2><B>LANDMARK</B></td>

</tr>
<TR><td colspan="1"><INPUT type="checkbox" name="fields" value="PUBLICTAP"><font color="#000000" face=verdana size=2><B>PUBLIC TAPS</B></td>
<td colspan="1"><INPUT type="checkbox" name="fields" value="PUBLICSTANDPOST"><font color="#000000" face=verdana size=2><B>PUBLIC TAPS WITH STAND POSTS </B></td>

<td colspan="1"><INPUT type="checkbox" name="fields" value="EXISTCHECKDAM"><font color="#000000" face=verdana size=2><B>No.of Existing Check Dams</B></td>
<td colspan="1"><INPUT type="checkbox" name="fields" value="REQCHECKDAM"><font color="#000000" face=verdana size=2><B>No.of Required Check Dams</B></td>
</TR>
<br>
<tr>   
<td colspan="3" align="center">
<INPUT type="checkbox" name="checkall" value="true" onclick="javascript:playCheckBoxes();"><font color="indigo" face="verdana" size=2><B>Check All</B></font></td>
</tr>
<tr><td class="mycborder" colspan="3">
<div id="a1">
<frameset><legend>Population Details</legend>
<table  border=0  width="100%">
<tr>
<td class="textborder"><font color="#000000" face=verdana size=2><B><INPUT type="checkbox" name="popdet" value="Census Plain Pop.">Census Plain</td>
<td class="textborder"><font color="#000000" face=verdana size=2><B><INPUT type="checkbox" name="popdet" value="Census SC Pop.">Census SC</td>
<td class="textborder"><font color="#000000" face=verdana size=2><B><INPUT type="checkbox" name="popdet" value="Census ST Pop.">Census ST</td>
<td class="textborder"><font color="#000000" face=verdana size=2><B><INPUT type="checkbox" name="popdet" value="Census Float Pop.">Census Float</td>
</tr>
<tr><td colspan="3"><font color="#000000" face=verdana size=2><B><INPUT type="checkbox" name="popdet" value="Total Population">Total Population </B>(Plain+SC+ST)</td></tr>
</TABLE></frameset></div>
</td></tr>
</table>  
</td></tr>
<tr><td ><font color="#000000" face=verdana size=2><B>Detail Report
<table>
<tr><td><INPUT type="radio" name="creport" value="hlist" onclick="JavaScript:enableField();showMe();"><font color="#000000" face=verdana size=2>Habitations List</font></td></tr>
</table></td>

<tr><td><font color="#000000" face=verdana size=2><B>Consolidated Report
<table>
<tr><td><INPUT type="radio" name="creport" value="chlist" onclick="JavaScript:disableField();showMe();"><font color="#000000" face=verdana size=2>No. Of Habitations</td></tr>
</table>
</td></tr> 
</table>
	</fieldset>

	<center><input type="button" value="Submit" name="Submit" class="btext" onclick="JavaScript:mpvCheck();flex_func();">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <INPUT type="reset" value="Reset" readonly class="btext">
	</center>
	</table></table></table></table></table>
	</td>
	</tr></table>
	
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="780" />
	</jsp:include>
	
</html:form>
</center>
<%@ include file="/commons/rws_footer.jsp"%>
</center>
</BODY>
</html:html>
