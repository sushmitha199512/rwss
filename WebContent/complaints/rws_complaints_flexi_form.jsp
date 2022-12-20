<%@ include file="/commons/rws_header1.jsp"%>
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
function flex_func()
{
if(formValidate() && reportValidate() && !((document.forms[0].fields[0].checked || document.forms[0].fields[1].checked || document.forms[0].fields[2].checked) && (document.forms[0].district.value=="" && document.forms[0].districtName.value=="") ) )
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

if(document.forms[0].district.value!="" || document.forms[0].districtName.value!="")
{
document.forms[0].creport[0].disabled=true;
}
if(document.forms[0].mandal.value!="")
{
document.forms[0].creport[1].disabled=true;
document.forms[0].fields[0].disabled=true;
}
if(document.forms[0].panchayat.value!="")
{
document.forms[0].creport[2].disabled=true;
document.forms[0].fields[1].disabled=true;
}
if(document.forms[0].village.value!="")
{
document.forms[0].creport[3].disabled=true;
document.forms[0].fields[2].disabled=true;
}
if(document.forms[0].habCode.value!="")
{
document.forms[0].creport[4].disabled=true;
document.forms[0].fields[3].disabled=true;
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
		document.forms[0].fields[0].disabled=true;
		}
	if(document.forms[0].panchayat.value!="")
	   {
		document.forms[0].fields[1].disabled=true;
	   }
	if(document.forms[0].village.value!="")
      {
      document.forms[0].fields[2].disabled=true;
      }
     if(document.forms[0].habCode.value!="")
	  {
      document.forms[0].fields[3].disabled=true; 
      }
}

function mpvCheck()
{
if((document.forms[0].fields[0].checked || document.forms[0].fields[1].checked || document.forms[0].fields[2].checked) && (document.forms[0].district.value=="" && document.forms[0].districtName.value=="") )
{
alert("District Required  OR \n Uncheck Mandal,Panchayat,Village in Report Layout.");
}
return;
}

function mmvalidate()
{
if (document.forms[0].district.value=="" && document.forms[0].districtName.value=="")
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
		document.forms[0].fields[0].disabled=true;
		}
	if(document.forms[0].panchayat.value!="")
		{
		document.forms[0].fields[1].disabled=true;
		}
	if(document.forms[0].village.value!="")
    {
      document.forms[0].fields[2].disabled=true;
     }
     if(document.forms[0].habCode.value!="")
     {
     document.forms[0].fields[3].disabled=true;
     }
    }
    
    
    function uncheckAllCheckBoxes() {	

	var formObj;

	var fldObj;

	formObj = document.forms[0];

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
    if(document.forms[0].mandal.value!="")
		{
		document.forms[0].fields[0].disabled=true;
		}
	if(document.forms[0].panchayat.value!="")
		{
		document.forms[0].fields[1].disabled=true;
		}
	if(document.forms[0].village.value!="")
       {
      document.forms[0].fields[2].disabled=true;
       }
       if(document.forms[0].habCode.value!="")
       {
       document.forms[0].fields[3].disabled=true;
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
     if((document.forms[0].district.value=="" && document.forms[0].districtName.value==""))
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
function getData2()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/freeFormatComplaint.do&mode=get2";
document.forms[0].submit();

}
function fnComplaintSubmit()
{
document.forms[0].action="switch.do?prefix=/complaints&page=/freeFormatComplaint.do&mode=view";
document.forms[0].submit();

}

</script>
<center>
<html:form action="/freeFormatComplaint.do">
<jsp:include page="/commons/TableHeaderComplaints.jsp">
<jsp:param name="TableName" value="Complaint-Free Format Report"/>
<jsp:param name="TWidth" value="890"/>
<jsp:param name="Tborder" value="0"/>
</jsp:include>

<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="810" >	<tr>
		<tr><td class="mycborder">
		<fieldset>
   <legend>District Details</legend>
   <label>
   <table  border=0  width="810"  align=center  style="margin-bottom:0;margin-top:0">
   
   <tr>
   <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:125px" onchange="javascript:getData2()" >
		<html:option value="-1"><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
		</logic:present>
		</html:select>
	<%System.out.println("in jsp1.1"); %>
	
	<td class="textborder" width="100">
	<bean:message key="app.mandal"/>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()">
			<html:option value="-1"><font class="myfontclr1">SELECT...</html:option>
			<logic:present name="mandals">
			<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
			</logic:present>
			
			</html:select>
	</td>
	
	<td class="textborder" width="100">
	<bean:message key="app.panchayat" />
	<td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
		<html:option value="-1">SELECT...</html:option>
		<logic:present name="panchayats">
		<html:options collection="panchayats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
		</logic:present>
		</html:select>
	</td>
	<td width="50%" class="textborder">Village&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:select property="village" style="width:160px" styleClass="mycombo" onchange="getData2();" >
		<option value="-1">SELECT...</option>
		<logic:present name="villages">
		<html:options collection="villages" name="rwsLocationBean" property="villageCode" labelProperty="villageName" />
		</logic:present>
		</html:select>
	    </td>
    </tr>
		
	<tr>
	<td class="textborder" nowrap width="100">
	<bean:message key="app.habCode" /></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:getData2()">
		<html:option value="-1">SELECT...</html:option>
		<logic:present name="habitations">
		<html:options collection="habitations" name="rwsLocationBean" property="habCode" labelProperty="habName" />
		</logic:present>
		</html:select>
	</td>
	</tr>
			
	</table>
	</label>
	</fieldset>
	 
		
		<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;" width="920" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend>Complaint Details</legend>
		 <table  border=0  width="100%">
		   <tr>
		    <td class="textborder" width="100">Complaint Category<td>
  
 			<html:select property="category" styleClass="mycombo" style="width:125px" >
			<html:option value="-1"><font class="myfontclr1">SELECT...</html:option>
			<html:option value="01"><font class="myfontclr1">LEAKING</html:option>
			<html:option value="02"><font class="myfontclr1">PUMP DAMAGED</html:option>
			</html:select>
			</td>
		
		<td class="textborder" width="100">Status<font color="#FF6666"></font></td>
		<td class="textborder">
		<html:select property="complntstatus" styleClass="mycombo" style="width:125px" onchange="javascript:getData2()" >
		<html:option value=""><font class="myfontclr1">Select</html:option>
		<html:option value="Working"><font class="myfontclr1">Working</html:option>
		<html:option value="Not Working"><font class="myfontclr1">Not Working</html:option>
		<html:option value="Condemned"><font class="myfontclr1">Condemned</html:option>
		<html:option value="Dried"><font class="myfontclr1">Dried</html:option>
		<html:option value="Others"><font class="myfontclr1">Others</html:option>
		</html:select>
		</td>
			 
				
</tr>
			
	<tr>   
    <td class="textborder" width="100">Complaint Date</td>
	<td class="textborder"><html:select property="complntdt" styleClass="mycombo" style="width:125px" onchange="javascript:getData2()" >
		<html:option value="-1">SELECT...</html:option>
		<logic:present name="fromdates">
		<html:options collection="fromdates"  property="complntdt" labelProperty="complntdt" />
		</logic:present>
		</html:select>
	</td>
	 <td class="textborder" width="100">Attended Date</td>
	 <td class="textborder"><html:select property="attendt" styleClass="mycombo" style="width:125px" onchange="javascript:getData2()" >
		<html:option value="">SELECT...</html:option>
		<logic:present name="todates">
		<html:options collection="todates"  property="attendt" labelProperty="attendt" />
		</logic:present>
		</html:select>
	</td>
	</tr>
	<tr>
    <td>

   <INPUT type="checkbox" name="fields" value="d"><font color="#000000" face=verdana size=2><b>Complaint Description</b></font></td>
   
</tr>
	
		
				</table>
			
			
	</table>
	
		<tr>
		<td>				

	<center> <input type="button" value="Submit" name="Submit" class="btext" onclick="JavaScript:fnComplaintSubmit()">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <INPUT type="reset" value="Reset" readonly class="btext">
	</center>
	
	</td>
	</tr></table>
	
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="890" />
	</jsp:include>
	
</html:form>
</center>
<%@ include file="/commons/rws_footer.jsp"%>
</center>
<script language="javascript">
<%
 if(request.getAttribute("message1")!=null)
 {
%>
 alert('<%=request.getAttribute("message1")%>');
<%
 }
%>
</script>

</BODY>
</html:html>
