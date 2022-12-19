
<%System.out.println("work free format jsp");%>
<%@ include file="/commons/rws_head.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@	page import="java.util.*" %>
<%@ include file="/masters/Rws_Habstatus_Entry_Frm_Script.jsp" %>
<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	userid = users.getUserId(); 

%> 
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
<BODY>
<script type="text/javascript">
window.onload = function() {init();}
function init() 
{
if(document.forms[0].plan[0].checked)
{
if(document.forms[0].augnew[0].checked)
{
	document.forms[0].augnew[2].disabled=true;
	document.forms[0].augnew[0].disabled=false;
	document.forms[0].augnew[0].checked=true;
	document.forms[0].augnew[1].disabled=false;
}
else if(document.forms[0].augnew[1].checked)
{
	document.forms[0].augnew[2].disabled=true;
	document.forms[0].augnew[0].disabled=false;
	document.forms[0].augnew[1].disabled=false;
	document.forms[0].augnew[1].checked=true;
}
else if(document.forms[0].augnew[2].checked)
{
	document.forms[0].augnew[2].disabled=true;
	document.forms[0].augnew[0].disabled=false;
	document.forms[0].augnew[0].checked=true;
	document.forms[0].augnew[1].disabled=false;
}
else
{
	document.forms[0].augnew[0].checked=false;
	document.forms[0].augnew[2].disabled=true;
}
}
else if(document.forms[0].plan[1].checked)
{
document.forms[0].augnew[0].disabled=true;//document.forms[0].augnew[0].checked=false;
document.forms[0].augnew[1].disabled=false;//document.forms[0].augnew[1].checked=false;
document.forms[0].augnew[2].disabled=false;//document.forms[0].augnew[2].checked=true;
}

if(document.forms[0].program.value == null || document.forms[0].program.value == "")
{
 	document.forms[0].commonfields[4].checked = true;
}
else
{
 	document.forms[0].commonfields[4].checked = false;
}
if(document.forms[0].subprogram.value == null || document.forms[0].subprogram.value == "")
{
 	document.forms[0].commonfields[5].checked = true;
}
else
{
 	document.forms[0].commonfields[5].checked = false;
}
if(document.forms[0].workcategory.value == null || document.forms[0].workcategory.value == "")
{
 	document.forms[0].commonfields[0].checked = true;
}
else
{
 	document.forms[0].commonfields[0].checked = false;
}
if(document.forms[0].scheme.value == null || document.forms[0].scheme.value == "")
{
 	document.forms[0].commonfields[3].checked = true;
}
else
{
 	document.forms[0].commonfields[3].checked = false;
}
/* if(document.forms[0].expyear.value == null || document.forms[0].expyear.value == "")
{
 	document.forms[0].commonfields[6].checked = true;
}
else
{
 	document.forms[0].commonfields[6].checked = false;
} */
if(document.forms[0].plan[0].checked == false || document.forms[0].plan[1].checked == false)
{
 	document.forms[0].commonfields[1].checked = true;
}
else
{
 	document.forms[0].commonfields[1].checked = false;
}
if((!document.forms[0].augnew[0].checked || !document.forms[0].augnew[1].checked || !document.forms[0].augnew[2].checked))
{
 	document.forms[0].commonfields[2].checked = true;
}
else
{
 	document.forms[0].commonfields[2].checked = false;
}
if(document.forms[0].creport[0].checked)
{
	document.getElementById('admins').style.display="block";
	document.getElementById('techs').style.display="none";
	document.getElementById('sources').style.display="none";
	document.getElementById('contracts').style.display="none";
	document.getElementById('expenditures').style.display="none";
	document.getElementById('completions').style.display="none";
}
else if(document.forms[0].creport[1].checked)
{
	document.getElementById('admins').style.display="none";
	document.getElementById('techs').style.display="block";
	document.getElementById('sources').style.display="none";
	document.getElementById('contracts').style.display="none";
	document.getElementById('expenditures').style.display="none";
	document.getElementById('completions').style.display="none";
}
else if(document.forms[0].creport[2].checked)
{
	document.getElementById('admins').style.display="none";
	document.getElementById('techs').style.display="none";
	document.getElementById('sources').style.display="block";
	document.getElementById('contracts').style.display="none";
	document.getElementById('expenditures').style.display="none";
	document.getElementById('completions').style.display="none";
}
else if(document.forms[0].creport[3].checked)
{
	document.getElementById('admins').style.display="none";
	document.getElementById('techs').style.display="none";
	document.getElementById('sources').style.display="none";
	document.getElementById('contracts').style.display="block";
	document.getElementById('expenditures').style.display="none";
	document.getElementById('completions').style.display="none";
}
else if(document.forms[0].creport[4].checked)
{
	document.getElementById('admins').style.display="none";
	document.getElementById('techs').style.display="none";
	document.getElementById('sources').style.display="none";
	document.getElementById('contracts').style.display="none";
	document.getElementById('expenditures').style.display="block";
	document.getElementById('completions').style.display="none";
}
else if(document.forms[0].creport[5].checked)
{
	document.getElementById('admins').style.display="none";
	document.getElementById('techs').style.display="none";
	document.getElementById('sources').style.display="none";
	document.getElementById('contracts').style.display="none";
	document.getElementById('expenditures').style.display="none";
	document.getElementById('completions').style.display="block";
}
if(document.forms[0].program.value != '')
{
	document.forms[0].commonfields[4].disabled = true;
}
if(document.forms[0].subprogram.value != '')
{
	document.forms[0].commonfields[5].disabled = true;
}
if(document.forms[0].workcategory.value != '')
{
	document.forms[0].commonfields[0].disabled = true;
}
if(document.forms[0].scheme.value != '')
{
	document.forms[0].commonfields[3].disabled = true;
}
/* if(document.forms[0].expyear.value != '')
{
	document.forms[0].commonfields[6].disabled = true;
} */
if((document.forms[0].plan[0].checked  || document.forms[0].plan[1].checked))
{
	document.forms[0].commonfields[1].disabled = true;
}
if((document.forms[0].augnew[0].checked || document.forms[0].augnew[1].checked || document.forms[0].augnew[2].checked))
{
	document.forms[0].commonfields[2].disabled = true;
}
}
function check1()
{
	if(document.forms[0].creport[6].checked)
	{
		if(document.forms[0].division.value=="")
		{
			document.forms[0].creport[6].checked=false;
			alert("Division Required for Works List Report");

		}
	}
}
</script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/calendar.js'/>"></script>
<script language="javascript">

function flex_func()
{
if(formValidate() && !((document.forms[0].commonfields[7].checked || document.forms[0].commonfields[8].checked || document.forms[0].offices.value=="")))
{
document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=outFlex";
document.forms[0].submit();
}
}
function dist1()
{
	if(document.forms[0].offices.value != "")
	{
		alert("Choose Either Office Selection Criteria OR Location Selection Criteria");
		document.forms[0].district.value = "";
	}
	else
	{
		funcDistrictChanged();
	}
}
function funcDistrictChanged()
{
document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
document.forms[0].submit();
}
function fnSelectionChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnPanchayataChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function office1()
{
	if(document.forms[0].district.value != "")
	{
		alert("Choose Either Office Selection Criteria OR Location Selection Criteria");
		document.forms[0].offices.value = "";
	}
	else
	{
		fnCircleChanged();
	}
}

function fnCircleChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnConstituencyChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnMandalChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnDivisionChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnSubdivisionChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnProgramChanged()
{
	document.forms[0].commonfields[2].checked = true;
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnFinYearChanged()
{
	document.forms[0].commonfields[4].checked = true;
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}

function fnSubprogramChanged()
{
	document.forms[0].commonfields[1].disabled = false;
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}

function fnSchemeChanged()
{
	document.forms[0].commonfields[3].disabled = false;
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnWorkCategoryChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnBudgetChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function fnWorkChanged()
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi";
	document.forms[0].submit();
}
function disables(value)
{
	var val = value;
	for(var i=0;i<val.length;i++)
	{
		val[i].checked=false;
	}
}
function enables(value)
{
	var val = value;
	for(var i=0;i<val.length;i++)
	{
		val[i].checked=true;
		val[i].disabled=false;
	}
}
function divhide()
{

document.getElementById('a1').style.visibility="hidden";
document.getElementById('a2').style.visibility="hidden";
}
function disableField()
{
disables(document.forms[0].adminfields);
disables(document.forms[0].techfields);
disables(document.forms[0].sourcefields);
disables(document.forms[0].confields);
disables(document.forms[0].wrkexpfields);
disables(document.forms[0].wrkcompfields);
document.getElementById('admins').style.display="block";
document.getElementById('techs').style.display="none";
document.getElementById('sources').style.display="none";
document.getElementById('contracts').style.display="none";
document.getElementById('expenditures').style.display="none";
document.getElementById('completions').style.display="none";
//document.forms[0].checkall.checked = false;
}
function disableField1()
{
disables(document.forms[0].adminfields);
disables(document.forms[0].techfields);
disables(document.forms[0].sourcefields);
disables(document.forms[0].confields);
disables(document.forms[0].wrkexpfields);
disables(document.forms[0].wrkcompfields);
document.getElementById('admins').style.display="none";
document.getElementById('techs').style.display="block";
document.getElementById('sources').style.display="none";
document.getElementById('contracts').style.display="none";
document.getElementById('expenditures').style.display="none";
document.getElementById('completions').style.display="none";
//document.forms[0].checkall.checked = false;
}
function disableField2()
{
disables(document.forms[0].adminfields);
disables(document.forms[0].techfields);
disables(document.forms[0].sourcefields);
disables(document.forms[0].confields);
disables(document.forms[0].wrkexpfields);
disables(document.forms[0].wrkcompfields);
document.getElementById('admins').style.display="none";
document.getElementById('techs').style.display="none";
document.getElementById('sources').style.display="block";
document.getElementById('contracts').style.display="none";
document.getElementById('expenditures').style.display="none";
document.getElementById('completions').style.display="none";
//document.forms[0].checkall.checked = false;
}
function disableField3()
{
disables(document.forms[0].adminfields);
disables(document.forms[0].techfields);
disables(document.forms[0].sourcefields);
disables(document.forms[0].confields);
disables(document.forms[0].wrkexpfields);
disables(document.forms[0].wrkcompfields);
document.getElementById('admins').style.display="none";
document.getElementById('techs').style.display="none";
document.getElementById('sources').style.display="none";
document.getElementById('contracts').style.display="block";
document.getElementById('expenditures').style.display="none";
document.getElementById('completions').style.display="none";
//document.forms[0].checkall.checked = false;
}
function disableField4()
{
disables(document.forms[0].adminfields);
disables(document.forms[0].techfields);
disables(document.forms[0].sourcefields);
disables(document.forms[0].confields);
disables(document.forms[0].wrkexpfields);
disables(document.forms[0].wrkcompfields);
document.getElementById('admins').style.display="none";
document.getElementById('techs').style.display="none";
document.getElementById('sources').style.display="none";
document.getElementById('contracts').style.display="none";
document.getElementById('expenditures').style.display="block";
document.getElementById('completions').style.display="none";
//document.forms[0].checkall.checked = false;
}
function disableField5()
{
disables(document.forms[0].adminfields);
disables(document.forms[0].techfields);
disables(document.forms[0].sourcefields);
disables(document.forms[0].confields);
disables(document.forms[0].wrkexpfields);
disables(document.forms[0].wrkcompfields);
document.getElementById('admins').style.display="none";
document.getElementById('techs').style.display="none";
document.getElementById('sources').style.display="none";
document.getElementById('contracts').style.display="none";
document.getElementById('expenditures').style.display="none";
document.getElementById('completions').style.display="block";
//document.forms[0].checkall.checked = false;
}
function disableFieldTech()
{
disables(document.forms[0].adminfields);
disables(document.forms[0].techfields);
disables(document.forms[0].sourcefields);
disables(document.forms[0].confields);
disables(document.forms[0].wrkexpfields);
disables(document.forms[0].wrkcompfields);
document.getElementById('admins').style.display="block";
document.getElementById('techs').style.display="block";
document.getElementById('sources').style.display="none";
document.getElementById('contracts').style.display="none";
document.getElementById('expenditures').style.display="none";
document.getElementById('completions').style.display="none";
//document.forms[0].checkall.checked = false;
}

function enableField()
{
disables(document.forms[0].adminfields);
disables(document.forms[0].techfields);
disables(document.forms[0].sourcefields);
disables(document.forms[0].confields);
disables(document.forms[0].wrkexpfields);
disables(document.forms[0].wrkcompfields);
document.getElementById('admins').style.display="block";
document.getElementById('techs').style.display="block";
document.getElementById('sources').style.display="block";
document.getElementById('contracts').style.display="block";
document.getElementById('expenditures').style.display="block";
document.getElementById('completions').style.display="block";
//document.forms[0].checkall.checked = false;
}
function disableFields()
{
document.forms[0].creport[0].checked = true;
disableField();
document.forms[0].creport[1].disabled = true;
document.forms[0].creport[2].disabled = true;
document.forms[0].creport[3].disabled = true;
document.forms[0].creport[4].disabled = true;
document.forms[0].creport[5].disabled = true;
document.forms[0].creport[6].disabled = true;
}
function disableFields1()
{
disableFieldTech();
document.forms[0].creport[1].disabled = false;
document.forms[0].creport[1].checked = true;
document.forms[0].creport[2].disabled = true;
document.forms[0].creport[3].disabled = true;
document.forms[0].creport[4].disabled = true;
document.forms[0].creport[5].disabled = true;
document.forms[0].creport[6].disabled = true;
}

function disableFields2()
{
enableField();
document.forms[0].creport[0].disabled = false;
document.forms[0].creport[0].checked = false;
document.forms[0].creport[1].disabled = false;
document.forms[0].creport[1].checked = false;
document.forms[0].creport[2].disabled = false;
document.forms[0].creport[2].checked = false;
document.forms[0].creport[3].disabled = false;
document.forms[0].creport[3].checked = false;
document.forms[0].creport[4].disabled = false;
document.forms[0].creport[4].checked = false;
document.forms[0].creport[5].disabled = false;
document.forms[0].creport[5].checked = false;
document.forms[0].creport[6].disabled = false;
document.forms[0].creport[6].checked = false;
}
function disableFields3()
{
enableField();
document.forms[0].creport[0].disabled = false;
document.forms[0].creport[0].checked = false;
document.forms[0].creport[1].disabled = false;
document.forms[0].creport[1].checked = false;
document.forms[0].creport[2].disabled = false;
document.forms[0].creport[2].checked = false;
document.forms[0].creport[3].disabled = false;
document.forms[0].creport[3].checked = false;
document.forms[0].creport[4].disabled = false;
document.forms[0].creport[4].checked = false;
document.forms[0].creport[5].disabled = false;
document.forms[0].creport[5].checked = false;
document.forms[0].creport[6].disabled = false;
document.forms[0].creport[6].checked = false;
}
function disableFields4()
{
enableField();
document.forms[0].creport[0].disabled = false;
document.forms[0].creport[0].checked = false;
document.forms[0].creport[1].disabled = false;
document.forms[0].creport[1].checked = false;
document.forms[0].creport[2].disabled = false;
document.forms[0].creport[2].checked = false;
document.forms[0].creport[3].disabled = false;
document.forms[0].creport[3].checked = false;
document.forms[0].creport[4].disabled = false;
document.forms[0].creport[4].checked = false;
document.forms[0].creport[5].disabled = false;
document.forms[0].creport[5].checked = false;
document.forms[0].creport[6].disabled = false;
document.forms[0].creport[6].checked = false;
}
function disableFields5()
{
enableField();
document.forms[0].creport[0].disabled = false;
document.forms[0].creport[0].checked = false;
document.forms[0].creport[1].disabled = false;
document.forms[0].creport[1].checked = false;
document.forms[0].creport[2].disabled = false;
document.forms[0].creport[2].checked = false;
document.forms[0].creport[3].disabled = false;
document.forms[0].creport[3].checked = false;
document.forms[0].creport[4].disabled = false;
document.forms[0].creport[4].checked = false;
document.forms[0].creport[5].disabled = false;
document.forms[0].creport[5].checked = false;
document.forms[0].creport[6].disabled = false;
document.forms[0].creport[6].checked = false;
}
function disableFields6()
{
enableField();
document.forms[0].creport[0].disabled = false;
document.forms[0].creport[0].checked = false;
document.forms[0].creport[1].disabled = false;
document.forms[0].creport[1].checked = false;
document.forms[0].creport[2].disabled = false;
document.forms[0].creport[2].checked = false;
document.forms[0].creport[3].disabled = false;
document.forms[0].creport[3].checked = false;
document.forms[0].creport[4].disabled = false;
document.forms[0].creport[4].checked = false;
document.forms[0].creport[5].disabled = false;
document.forms[0].creport[5].checked = false;
document.forms[0].creport[6].disabled = false;
document.forms[0].creport[6].checked = false;
}
function mpvCheck()
{
if(((document.forms[0].offices.value=="") && (document.forms[0].district.value=="")))
{
alert("Circle Or District Required....");
}
else if((!document.forms[0].creport[0].checked && !document.forms[0].creport[1].checked && !document.forms[0].creport[2].checked && !document.forms[0].creport[3].checked && !document.forms[0].creport[4].checked && !document.forms[0].creport[5].checked && !document.forms[0].creport[6].checked))
{
	alert("Report Type Required");
}
else if(document.forms[0].offices.value=="all" && document.forms[0].workcategory.value=="")
{
	alert("Select Work Category");
}
else if(document.forms[0].offices.value=="all" && document.forms[0].workcategory.value=="2")
{
	alert("Select Work Category (PROJECTS/DISTRICT LEVEL)");
}
else if(!document.forms[0].offices.value=="")
{
	 if(!document.forms[0].division.value==""  || !document.forms[0].subdivision.value=="" || !document.forms[0].constituency.value=="" || !document.forms[0].mandal.value=="")
	 {
		 if(!document.forms[0].division.value==""  || !document.forms[0].subdivision.value=="")
		 {
			if(!document.forms[0].constituency.value=="" || !document.forms[0].mandal.value=="")
			{
				alert("Select Either Division,Subdivision Criteria OR Constituency,Mandal Criteria");
			}
			else
		 	{
				document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=outFlex";
				document.forms[0].submit();
		 	}
		 }
		 else
		 	{
				document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=outFlex";
				document.forms[0].submit();
		 	}
	 }
	 else
	 {
		document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=outFlex";
		document.forms[0].submit();
	 }
}
else
{
	document.forms[0].action="switch.do?prefix=/reports&page=/flexReport1.do?mode=outFlex";
	document.forms[0].submit();
}
}

    function selectAllCheckBoxes1()
    {
		if(!(document.getElementById('admins').style.display == 'none' || document.getElementById('techs').style.display == 'none' || document.getElementById('sources').style.display == 'none' || document.getElementById('contracts').style.display == 'none' || document.getElementById('expenditures').style.display == 'none' || document.getElementById('completions').style.display == 'none'))
		{
			enables(document.forms[0].adminfields);
			enables(document.forms[0].techfields);
			enables(document.forms[0].sourcefields);			
			enables(document.forms[0].confields);
			enables(document.forms[0].wrkexpfields);
			enables(document.forms[0].wrkcompfields);
		}
		else if(document.getElementById('admins').style.display == 'block' && document.getElementById('techs').style.display == 'block')
		{
			enables(document.forms[0].adminfields);
			enables(document.forms[0].techfields);
			disables(document.forms[0].sourcefields);			
			disables(document.forms[0].confields);
			disables(document.forms[0].wrkexpfields);
			disables(document.forms[0].wrkcompfields);
		}
		else if(document.getElementById('admins').style.display == 'block')
		{
			enables(document.forms[0].adminfields);
			disables(document.forms[0].techfields);
			disables(document.forms[0].sourcefields);			
			disables(document.forms[0].confields);
			disables(document.forms[0].wrkexpfields);
			disables(document.forms[0].wrkcompfields);
		}
		else if(document.getElementById('techs').style.display == 'block')
		{
			disables(document.forms[0].adminfields);
			enables(document.forms[0].techfields);
			disables(document.forms[0].sourcefields);			
			disables(document.forms[0].confields);
			disables(document.forms[0].wrkexpfields);
			disables(document.forms[0].wrkcompfields);
		}
		else if(document.getElementById('sources').style.display == 'block')
		{
			disables(document.forms[0].adminfields);
			disables(document.forms[0].techfields);
			enables(document.forms[0].sourcefields);			
			disables(document.forms[0].confields);
			disables(document.forms[0].wrkexpfields);
			disables(document.forms[0].wrkcompfields);
		}
		else if(document.getElementById('contracts').style.display == 'block')
		{		
			disables(document.forms[0].adminfields);
			disables(document.forms[0].techfields);
			disables(document.forms[0].sourcefields);			
			enables(document.forms[0].confields);
			disables(document.forms[0].wrkexpfields);
			disables(document.forms[0].wrkcompfields);
		}
		else if(document.getElementById('expenditures').style.display == 'block')
		{		
			disables(document.forms[0].adminfields);
			disables(document.forms[0].techfields);
			disables(document.forms[0].sourcefields);			
			disables(document.forms[0].confields);
			enables(document.forms[0].wrkexpfields);
			disables(document.forms[0].wrkcompfields);
		}
		else if(document.getElementById('completions').style.display == 'block')
		{
			disables(document.forms[0].adminfields);
			disables(document.forms[0].techfields);
			disables(document.forms[0].sourcefields);			
			disables(document.forms[0].confields);
			disables(document.forms[0].wrkexpfields);
			enables(document.forms[0].wrkcompfields);
		}
		
    }
    function uncheckAllCheckBoxes1()
    {
			disables(document.forms[0].adminfields);
			disables(document.forms[0].techfields);
			disables(document.forms[0].sourcefields);			
			disables(document.forms[0].confields);
			disables(document.forms[0].wrkexpfields);
			disables(document.forms[0].wrkcompfields);
    }
    
function playCheckBoxes()
{
var button=document.forms[0].checkall.checked;
if (button==true)
{
selectAllCheckBoxes1();
}
else
{
uncheckAllCheckBoxes1();
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
     if((document.forms[0].offices.value==""))
       {
      if(farr.length==25)
        {
         formstatus=false;
        }
       }
       }
	 if(formstatus==false)
	 {
	 alert("Circle Required");
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

function radioClick (s) {
init();
if(s=="1")
{
	document.forms[0].augnew[2].disabled=true;
	document.forms[0].augnew[0].checked=false;
	document.forms[0].augnew[1].checked=false;
}
if(s=="2")
{
	document.forms[0].augnew[2].checked=false;
	document.forms[0].augnew[0].disabled=true;
	document.forms[0].augnew[1].checked=false;
	//document.forms[0].augnew[0].disabled=true;document.forms[0].augnew[0].checked=false;
	//document.forms[0].augnew[1].disabled=true;document.forms[0].augnew[1].checked=false;
	//document.forms[0].augnew[2].disabled=false;document.forms[0].augnew[2].checked=true;
}
fnBudgetChanged();

    return true;
}

</script>
<center>
<html:form action="/flexReport1.do">
<table width="80%">
	<caption align="right" class="staticLabel"><b>(Amount in Rs. lakhs)</b></caption>
</table>
<jsp:include page="/commons/TableHeader.jsp">
<jsp:param name="TableName" value="Work-Free Format Report"/>
<jsp:param name="TWidth" value="785"/>
<jsp:param name="Tborder" value="0"/>
</jsp:include>



<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Office Details</legend>
		 <table  border=0  width="100%">
		 <tr><td width="35%"><font color="#000000" face=verdana size=2><B>Circle&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <html:select property="offices" style="width:135px"   onchange="javascript:office1()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <%if(userid.equals("admin") || userid.equals("100000")){%>
				<html:option value="all">ALL</html:option>
<%
}
 %>		 <!-- <html:option value="all">ALL</html:option> -->
		 <logic:present name="circles">
		 <html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:present>
    	 </html:select>
</td>
<td width="30%"><font color="#000000" face=verdana size=2><B>Division&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<html:select property="division" style="width:135px"    styleClass="mycombo" onchange="fnDivisionChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				 <logic:present name="divisions">
	<html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>
<td width="35%"><font color="#000000" face=verdana size=2><B>Sub Division&nbsp;
	<html:select property="subdivision" style="width:135px" styleClass="mycombo" onchange="fnSubdivisionChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				 <logic:present name="subdivisions">
	<html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>
</tr>
</TABLE>
</fieldset> 


<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Location Details</legend>
		 <table  border=0  width="100%">
<tr>
<td width="35%"><font color="#000000" face=verdana size=2><B>District&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <html:select property="district" style="width:135px"   onchange="javascript:dist1()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <!-- <html:option value="all">ALL</html:option> -->
		 <logic:present name="districts">
		 <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:present>
    	 </html:select>
</td>
<td width="30%"><font color="#000000" face=verdana size=2><B>Constituency&nbsp;&nbsp;
		 <html:select property="constituency" style="width:135px"   onchange="javascript:fnConstituencyChanged()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 <logic:present name="constituency">
		 <html:options collection="constituency" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:present>
    	 </html:select>
</td>
<td width="35%"><font color="#000000" face=verdana size=2><B>Mandal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<html:select property="mandal" style="width:135px"    styleClass="mycombo" onchange="fnMandalChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				 <logic:present name="mandals">
	<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>

</tr>
</TABLE>
</fieldset> 

<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Additional Details</legend>
		 <table  border=0  width="100%">
		 <tr>
		 <td width="35%"><font color="#000000" face=verdana size=2><B>WorkCategory&nbsp;
	<html:select property="workcategory" style="width:135px"    styleClass="mycombo" onchange="javascript:init();fnWorkCategoryChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
	<logic:present name="workcats">	
	<html:options collection="workcats" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>
<TD width="65%" colspan=2>
			 <html:radio property="plan" value="1" onclick="return radioClick(1)"/><font color="#000000" face=verdana size=2>Plan&nbsp;</font>
			 <html:radio property="plan" value="2" onclick="return radioClick(2)"/><font color="#000000" face=verdana size=2>Non Plan&nbsp;&nbsp;&nbsp;&nbsp;</font>
			 <html:radio property="augnew" value="1" onclick="return fnWorkChanged()"/><font color="#000000" face=verdana size=2>Main Scheme&nbsp;</font>
			 <html:radio property="augnew" value="2" onclick="return fnWorkChanged()"/><font color="#000000" face=verdana size=2>Augmentation&nbsp;</font>
			 <html:radio property="augnew" value="3" onclick="return fnWorkChanged()"/><font color="#000000" face=verdana size=2>Maintanance&nbsp;</font>
		 </td>
	
</tr>
		 <tr><td width="35%"><font color="#000000" face=verdana size=2><B>Scheme&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 <html:select property="scheme" style="width:135px" styleClass="mycombo" onchange="javascript:init();fnSchemeChanged()">
			 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			 <html:options collection="assets" name="labelValueBean" property="value" labelProperty="label" />
	    	 </html:select>

</td>
<td width="30%"><font color="#000000" face=verdana size=2><B>Program&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			 <html:select property="program" style="width:135px" styleClass="mycombo" onchange="javascript:fnProgramChanged()">
			 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			 <logic:present name="programs">
			 <html:options collection="programs" name="labelValueBean" property="value" labelProperty="label" />
			 </logic:present>
	    	 </html:select>
</td>
<td width="35%"><font color="#000000" face=verdana size=2><B>Sub Program
	<html:select property="subprogram" style="width:135px"    styleClass="mycombo" onchange="javascript:init();fnSubprogramChanged()">
	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
	<logic:present name="subprograms">	
	<html:options collection="subprograms" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
				</html:select>
</td>
</tr>
<tr>
<td width="35%"><font color="#000000" face=verdana size=2><B>Financial Year&nbsp;


    <html:select property="expyear" style="width:135px" styleClass="mycombo" onchange="javascript:init();fnFinYearChanged()">

	<logic:present name="expyears">	
	<html:options collection="expyears" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	 <html:option value="-1">ALL</html:option>	
	</html:select>
</td>
<td width="30%"><font color="#000000" face=verdana size=2><B>NO.Of Habs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT name="noh_condition">
			<OPTION value="&gt;=" selected>&gt;=</OPTION>
			<OPTION value="&lt;=">&lt;=</OPTION>
			<OPTION value="=">=</OPTION>
			<OPTION value="&gt;">&gt;</OPTION>
			<OPTION value="&lt;">&lt;</OPTION>
		</SELECT>
				<html:text property="nohabs" size="8" style="width:90px" onkeypress="return numeralsOnly()"></html:text>

</td>
<TD width="35%"></TD>
</tr>
</TABLE>

</fieldset> 

<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Work Stages</legend>
		 <table  border=0  width="100%">
		 <tr>
		 <td><font color="#000000" face=verdana size=2><B>Admin. Sanction</b></font></td>
		 <td><font color="#000000" face=verdana size=2><B>Date</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 <SELECT name="addate_condition">
			<OPTION value="&gt;=" selected>&gt;=</OPTION>
			<OPTION value="&lt;=">&lt;=</OPTION>
			<OPTION value="=">=</OPTION>
			<OPTION value="&gt;">&gt;</OPTION>
			<OPTION value="&lt;">&lt;</OPTION>
		</SELECT>
				<html:text property="adminSancDate" style="width:100px" readonly="true"/><a href="javascript:showCalendar(document.forms[0].adminSancDate);">
						       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>

</td>
<td>		<font color="#000000" face=verdana size=2><B>Amount</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					        <SELECT name="asa_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
					<html:text property="asa" size="8" style="width:100px" onkeypress="return numeralsOnly()"></html:text>
</td>
</tr>
<tr>
<td><font color="#000000" face=verdana size=2><B>Tech. Sanction</b></font></td>
<TD>
<font color="#000000" face=verdana size=2><B>Date</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT name="tsdate_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
<html:text property="techSancDate" style="width:100px" readonly="true"/><a href="javascript:showCalendar(document.forms[0].techSancDate);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
						  </td>
 
		<td><font color="#000000" face=verdana size=2><B>Amount</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					        <SELECT name="tsa_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
					<html:text property="tsa" style="width:100px" onkeypress="return numeralsOnly()"></html:text></font></td>

						  

	</tr>
<tr>
<td><font color="#000000" face=verdana size=2><B>Source Identification</b></font></td>
<TD>
<font color="#000000" face=verdana size=2><B>Date</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT name="sid_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
<html:text property="sidDate" style="width:100px" readonly="true"/><a href="javascript:showCalendar(document.forms[0].sidDate);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
						  </td>
<TD>
<font color="#000000" face=verdana size=2><B>HandOver Date</b>&nbsp;
<SELECT name="sidhand_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
<html:text property="sidhandDate" style="width:100px" readonly="true" /><a href="javascript:showCalendar(document.forms[0].sidhandDate);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
						  </td>
  						  

	</tr>
<tr>
<td><font color="#000000" face=verdana size=2><B>Contractor Mgmt.</b></font></td>
<TD>
<font color="#000000" face=verdana size=2><B>Agm.Date</b>
<SELECT name="condate_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
<html:text property="conDate" style="width:100px" readonly="true"/><a href="javascript:showCalendar(document.forms[0].conDate);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
						  </td>
<td><font color="#000000" face=verdana size=2><B>Agreement Dur.</b>
<SELECT name="condur_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
	<html:text property="conDur" style="width:100px" onkeypress="return numeralsOnly()"></html:text>						  </td>
	</td>
	</tr>
<tr>
<td><font color="#000000" face=verdana size=2><B>Work Expenditure</b></font></td>
<td><font color="#000000" face=verdana size=2><B>Total Exp.</b>
<SELECT name="wrkexp_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
	<html:text property="wrkExp" style="width:100px" onkeypress="return numeralsOnly()"></html:text>						  </td>
	</td>
	<td></td>
	</tr>
	<tr>
<td><font color="#000000" face=verdana size=2><B>Work Completion</b></font></td>
<TD>
<font color="#000000" face=verdana size=2><B>Date</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT name="wrkcompdt_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
<html:text property="wrkcompDate" style="width:100px" readonly="true"/><a href="javascript:showCalendar(document.forms[0].wrkcompDate);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
						  </td>
<TD>
<font color="#000000" face=verdana size=2><B>Comm. Date</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<SELECT name="wrkcommdt_condition">
								<OPTION value="&gt;=" selected>&gt;=</OPTION>
								<OPTION value="&lt;=">&lt;=</OPTION>
								<OPTION value="=">=</OPTION>
								<OPTION value="&gt;">&gt;</OPTION>
								<OPTION value="&lt;">&lt;</OPTION>
							</SELECT>
<html:text property="wrkcommDate" style="width:100px" readonly="true"/><a href="javascript:showCalendar(document.forms[0].wrkcommDate);">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
						  </td>
  						  

	</tr>	
</table>
</fieldset> 

<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Work Progess Upto Specified Stage</legend>
		 <table  border=0  width="100%">
		 <tr>
	<td width="25%"><input type="radio" name="creport1" value="admin" onclick="JavaScript:disableFields();"><font color="#000000" face=verdana size=2>Administrative Sanction</td>
	<td width="25%"><input type="radio" name="creport1" value="technical" onclick="JavaScript:disableFields1();"><font color="#000000" face=verdana size=2>Technical Sanction</td>
	<td width="25%"><input type="radio" name="creport1" value="contractor" onclick="JavaScript:disableFields2();"><font color="#000000" face=verdana size=2>Works Grounded</td>
	<td width="25%"><input type="radio" name="creport1" value="workcomp" onclick="JavaScript:disableFields3();"><font color="#000000" face=verdana size=2>Work Completion</td>
</tr>
</table>
</fieldset> 


<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="780" >	<tr>
		<tr><td class="mycborder">
		<fieldset>
		<legend>Work Stages</legend>
		

<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" width="820" >	<tr>
		<td class="mycborder">
		<fieldset>
		<legend><font color="blue"></font></legend>
		 <table  border=2  bordercolor= "#8A9FCD" width="100%">
<font color="#000000" face=verdana size=2><TR><TH WIDTH="25%">Report Selection<TH WIDTH="75%">Report Layout</TH></TR></font>

<tr>
<td ><font color="#000000" face=verdana size=2><B>Work Stages
<table>
<tr><td><input type="radio" name="creport" value="admin" onclick="JavaScript:disableField();"><font color="#000000" face=verdana size=2>Administrative Sanction</td></tr>
<tr><td><input type="radio" name="creport" value="technical" onclick="JavaScript:disableField1();"><font color="#000000" face=verdana size=2>Technical Sanction</td></tr>
<tr><td><input type="radio" name="creport" value="source" onclick="JavaScript:disableField2();"><font color="#000000" face=verdana size=2>Source Identification</td></tr>
<tr><td><input type="radio" name="creport" value="contractor" onclick="JavaScript:disableField3();"><font color="#000000" face=verdana size=2>Contractor Management</td></tr>
<tr><td><input type="radio" name="creport" value="workexp" onclick="JavaScript:disableField4();"><font color="#000000" face=verdana size=2>Work Expenditure</td></tr>
<tr><td><input type="radio" name="creport" value="workcomp" onclick="JavaScript:disableField5();"><font color="#000000" face=verdana size=2>Work Completion</td></tr>
</table>
</td>
<td rowspan="3">
<table>
<tr>
<td width="36%"><INPUT type="checkbox" name="commonfields" value="CIRCLE" checked><font color="#000000" face=verdana size=2><B>Circle</B></font></td>
<td width="31%"><INPUT type="checkbox" name="commonfields" value="DIVISION" checked><font color="#000000" face=verdana size=2><B>Division</B></font></td>
<td width="34%"><INPUT type="checkbox" name="commonfields" value="CONSTITUENCY"  checked><font color="#000000" face=verdana size=2><B>Constituency</B></font></td>
	
</tr>
<tr>
    <td width="36%"><INPUT type="checkbox" name="commonfields" value="WORK_CATEGORY" checked><font color="#000000" face=verdana size=2><B>Work Category</B></font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="BUDGET_TYPE" checked><font color="#000000" face=verdana size=2><B>Plan/Non Plan</B></font></td>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="WORK_TYPE" checked><font color="#000000" face=verdana size=2><B>MainSch/Aug./Main.</B></font></td>
</tr>
<tr>
	<td width="36%"><INPUT type="checkbox" name="commonfields" value="SCHEME" checked><font color="#000000" face=verdana size=2><B>Scheme</B></font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="PROGRAM" checked ><font color="#000000" face=verdana size=2><B>Program Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B></font></td>
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="SUBPROGRAM" checked><font color="#000000" face=verdana size=2><B>Sub Program Name</B></font></td>
</tr>
<tr>
	<td width="36%"><INPUT type="checkbox" name="commonfields" value="FIN_YEAR" checked><font color="#000000" face=verdana size=2><B>Financial Year</B></font></td>
	<td width="31%"><INPUT type="checkbox" name="commonfields" value="WORK_ID"  onClick="return false" checked><font color="#000000" face=verdana size=2><B>Work Id</B></font></td>	
	<td width="34%"><INPUT type="checkbox" name="commonfields" value="WORK_NAME"  checked><font color="#000000" face=verdana size=2><B>Work Name</B></font></td>
    	
</tr>
<tr>
	<td width="36%" colspan="1"><INPUT type="checkbox" name="commonfields" value="NO_OF_HABS"  checked><font color="#000000" face=verdana size=2><B>No. of Habs</B></font></td>
	<td width="65%" colspan="2"><INPUT type="checkbox" name="commonfields" value="REMARKS"  checked><font color="#000000" face=verdana size=2><B>Status</B></font></td>
	
</tr>

<tr>
	<td width="36%"></td>
	<TD width="31%"></TD> 
	<TD width="34%"></TD>
</tr>
<tr>
	<td width="36%"></td>
	<TD width="31%"></TD> 
	<TD width="34%"></TD>
</tr>
<tr>
<td class="mycborder" colspan="3">
<div id="admins">
	<INPUT type="checkbox" name="adminfields" value="ADMN_NO" ><font color="#000000" face=verdana size=2><B>Admn. Sanc. No</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="adminfields" value="ADMN_DATE" ><font color="#000000" face=verdana size=2><B>Admn. Sanc. Date</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="adminfields" value="ADMN_AMT" ><font color="#000000" face=verdana size=2><B>Admn. Sanc. Amount</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="adminfields" value="REV_ADMN_NO" ><font color="#000000" face=verdana size=2><B>Rev Admn. Sanc. No</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="adminfields" value="REV_ADMN_DATE" ><font color="#000000" face=verdana size=2><B>Rev Admn. Date</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="adminfields" value="REV_ADMN_AMT" ><font color="#000000" face=verdana size=2><B>Rev Admn. Amount</B></font>
</div>
<div id="techs">
	<INPUT type="checkbox" name="techfields" value="TECH_NO"><font color="#000000" face=verdana size=2><B>Tech. Sanc. No</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="techfields" value="TECH_DATE"><font color="#000000" face=verdana size=2><B>Tech. Sanc. Date</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="techfields" value="TECH_AMT"><font color="#000000" face=verdana size=2><B>Tech. Sanc. Amount</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="techfields" value="REV_TECH_NO"><font color="#000000" face=verdana size=2><B>Rev Tech. Sanc. No</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="techfields" value="REV_TECH_DATE"><font color="#000000" face=verdana size=2><B>Rev Tech. Date</B></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="techfields" value="REV_TECH_AMT"><font color="#000000" face=verdana size=2><B>Rev Tech. Amount</B></font>

</div>
<div id="sources">
	<INPUT type="checkbox" name="sourcefields" value="SOURCE_CODE"><font color="#000000" face=verdana size=2><B>Source Code&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="sourcefields" value="SOURCE_NAME"><font color="#000000" face=verdana size=2><B>Source Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="sourcefields" value="SOURCE_TYPE"><font color="#000000" face=verdana size=2><B>Source Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="sourcefields" value="SUB_SOURCE_TYPE"><font color="#000000" face=verdana size=2><B>Sub Source Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="sourcefields" value="HAB_LOCATION"><font color="#000000" face=verdana size=2><B>Habitaion Location&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="sourcefields" value="SID_DATE"><font color="#000000" face=verdana size=2><B>Source Iden. Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<INPUT type="checkbox" name="sourcefields" value="SID_HAND_DATE"><font color="#000000" face=verdana size=2><B>Source HandOver Date
</div>
<div id="contracts">
<INPUT type="checkbox" name="confields" value="AGREEMENT_REFERENCE_NO" ><font color="#000000" face=verdana size=2><B>Agreement. Ref. No.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="confields" value="AGREEMENT_VALUE" ><font color="#000000" face=verdana size=2><B>Agreement Value&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="confields" value="AGREEMENT_DATE" ><font color="#000000" face=verdana size=2><B>Agreement Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="confields" value="AGREEMENT_DUR" ><font color="#000000" face=verdana size=2><B>Agmt. Duration&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="confields" value="TENDER_PER" ><font color="#000000" face=verdana size=2><B>Tender Percentage&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="confields" value="EXP_DATE_OF_COMP" ><font color="#000000" face=verdana size=2><B>Stipulated Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="confields" value="PROB_DATE_OF_COMP" ><font color="#000000" face=verdana size=2><B>Probable Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="confields" value="CONT_NAME" ><font color="#000000" face=verdana size=2><B>Contractor Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="confields" value="START_DATE" ><font color="#000000" face=verdana size=2><B>Work Start Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="confields" value="REV_PROB_DATE" ><font color="#000000" face=verdana size=2><B>Revised Probable Date
</div>
<div id="expenditures">
<!-- <INPUT type="checkbox" name="wrkexpfields" value="EXPENDITURE_UPTO_THE_PRE_YEAR"><font color="#000000" face=verdana size=2><B>Exp. Upto Last Year&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
<!--    <INPUT type="checkbox" name="wrkexpfields" value="EXPENDITURE_CURRENT" ><font color="#000000" face=verdana size=2><B>Exp.Current Year-->
 <!--<INPUT type="checkbox" name="wrkexpfields" value="EXPENDITURE_DURING" ><font color="#000000" face=verdana size=2><B>Exp.Current Year&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -->
<!--<INPUT type="checkbox" name="wrkexpfields" value="VALUE_OF_WORK_NOT_PAID"><font color="#000000" face=verdana size=2><B>Value of Work Done But Not Paid-->
<INPUT type="checkbox" name="wrkexpfields" value="TOTAL_EXP" checked><font color="#000000" face=verdana size=2><B>Total Expeniture&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<div id="completions">
<INPUT type="checkbox" name="wrkcompfields" value="DATE_OF_COMPLETION" ><font color="#000000" face=verdana size=2><B>Completed Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="wrkcompfields" value="DATE_OF_COMM" ><font color="#000000" face=verdana size=2><B>Commissioned Date&nbsp;&nbsp;
<INPUT type="checkbox" name="wrkcompfields" value="BENFITTED_HABS"><font color="#000000" face=verdana size=2><B>Habitations Benifited&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="wrkcompfields" value="HAND_OVER_PRI"><font color="#000000" face=verdana size=2><B>Handover to PRI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<INPUT type="checkbox" name="wrkcompfields" value="HOUSECONNECTIONS">
<font color="#000000" face=verdana size=2><B>House Connections&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<INPUT type="checkbox" name="wrkcompfields" value="HOUSEHOLDS"><font color="#000000" face=verdana size=2><B>House Holds&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<INPUT type="checkbox" name="wrkcompfields" value="STANDPOSTS"><font color="#000000" face=verdana size=2><B>Standposts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<INPUT type="checkbox" name="wrkcompfields" value="PHY_REMARKS"><font color="#000000" face=verdana size=2><B>Physical Stage/Remarks of the Work&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</td>
</tr>
<tr>
<td ><INPUT type="checkbox" name="wrkcompfields" value="LANDAQUISITION"><font color="#000000" face=verdana size=2><B>Land Aquistion</td>
<td ><INPUT type="checkbox" name="wrkcompfields" value="WATERDRAWLPERMISSION"><font color="#000000" face=verdana size=2><B>Water Drawl Permission </td>
<td ><INPUT type="checkbox" name="wrkcompfields" value="RAILWAYCROSSINGPERMISSION"><font color="#000000" face=verdana size=2><B>Railway Crossing Permission</td>
</tr>
<tr>
<td><INPUT type="checkbox" name="wrkcompfields" value="ROADCROSSINGPERMISSIONSTATE "><font color="#000000" face=verdana size=2><B>State Road Crossing Permission</td>
<td>
<INPUT type="checkbox" name="wrkcompfields" value="ROADCROSSINGPERMISSIONNHAI  "><font color="#000000" face=verdana size=2><B>NNHAI Road Crossing Permission </td><td>
<INPUT type="checkbox" name="wrkcompfields" value="FORESTCLEARANCE"><font color="#000000" face=verdana size=2><B>Forest Clearance</td><td>
<INPUT type="checkbox" name="wrkcompfields" value="OTHERS"><font color="#000000" face=verdana size=2><B>OTHERS&nbsp;&nbsp;<INPUT type="checkbox" name="wrkcompfields" value="PARTA"><font color="#000000" face=verdana size=2><B>Part-A Amt
</td>

</tr>
<tr>
<td colspan="3" align="center">
		 <%if(userid.equals("admin") || userid.equals("100000")){%>
	<INPUT type="checkbox" name="checkall" value="true" onclick="javascript:playCheckBoxes();"><font color="indigo" face="verdana" size=2><B>Check All</B></font></td>
<%
}
 %>
<!-- <INPUT type="checkbox" name="checkall" value="true" onclick="javascript:playCheckBoxes();"><font color="indigo" face="verdana" size=2><B>Check All</B></font></td>
 --></tr>

<tr>


</table>
</td></tr>
<tr><td ><font color="#000000" face=verdana size=2><B>Detail Report
<table>
<tr><td><input type="radio" name="creport" value="detailed" onclick="JavaScript:enableField();"><font color="#000000" face=verdana size=2>Works List</font></td></tr>
</table></td>
</td></tr> 
</table>
	</fieldset>

	<center> <input type="button" value="Submit" name="Submit" class="btext"
		onclick="JavaScript:mpvCheck();">
		
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <INPUT type="reset" value="Reset"	readonly class="btext">
	</center>
	</table></table></table></table></table>
	</td>
	</tr></table>
<center>	
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="785" />
	</jsp:include>
	</center>
</html:form>
</center>
</body>
<center><%@ include file="/commons/rws_footer.jsp"%></center>
<%@ include file="/commons/rws_alert.jsp"%>
</html:html>