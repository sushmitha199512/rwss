<%@ include file="/commons/rws_header1.jsp" %>
<%
String checked = "";

String dis1=null,dis2=null,dis3=null,dis4=null;

if(request.getParameter("dis1")!=null)
{
 dis1 = request.getParameter("dis1");
 dis2 = request.getParameter("dis2");
 dis3 = request.getParameter("dis3");
 dis4 = request.getParameter("dis4");

if(dis1.equals(""))dis1 = null;
if(dis2.equals(""))dis2= null;
if(dis3.equals(""))dis3= null;
if(dis4.equals(""))dis4= null;
}
checked=request.getParameter("special");
System.out.println("checked"+checked);
%>
<%@ include file="/commons/rws_header2.jsp" %>

<script language="javascript">
<!--

function init()
{

var check=<%=checked%>;

var d1 = <%=dis1%>;
var d2 = <%=dis2%>;
var d3 = <%=dis3%>;
var d4 = <%=dis4%>;


if(d1 == "1")
	document.forms[0].district1[0].disabled = true;
if(d2 == "1")
	document.forms[0].district1[1].disabled = true;
if(d3 == "1")
	document.forms[0].district1[2].disabled = true;
if(d4 == "1")
	document.forms[0].district1[3].disabled = true;
	
if(check == null){
if(document.forms[0].district.value!="ALL" && document.forms[0].mandal.value=="ALL" && document.forms[0].panchayat.value=="ALL" && document.forms[0].village.value=="ALL")
{
	document.forms[0].district1[0].disabled=false;
    document.forms[0].district1[0].checked=true; 
}
else if(document.forms[0].mandal.value!="ALL" && document.forms[0].district.value!="ALL" && document.forms[0].panchayat.value=="ALL" && document.forms[0].village.value=="ALL")
{
    document.forms[0].district1[1].disabled=false;
    document.forms[0].district1[1].checked=true; 
    document.forms[0].district1[0].disabled=true;
    
}
else if(document.forms[0].panchayat.value!="ALL" && document.forms[0].mandal.value!="ALL" && document.forms[0].district.value!="ALL" && document.forms[0].village.value=="ALL")
{
	document.forms[0].district1[2].disabled=false;
    document.forms[0].district1[2].checked=true; 
    document.forms[0].district1[1].disabled=true;
    document.forms[0].district1[0].disabled=true;
}
else if(document.forms[0].village.value!="ALL" && document.forms[0].panchayat.value!="ALL" && document.forms[0].mandal.value!="ALL" && document.forms[0].district.value!="ALL")
{
	document.forms[0].district1[3].disabled=false;
    document.forms[0].district1[3].checked=true; 
    document.forms[0].district1[0].disabled=true;
    document.forms[0].district1[1].disabled=true;
    document.forms[0].district1[2].disabled=true;
}
else if(document.forms[0].village.value=="ALL" && document.forms[0].panchayat.value!="ALL")
{
    document.forms[0].district1[3].disabled=false; 
}
else if(document.forms[0].panchayat.value=="ALL" && document.forms[0].mandal.value!="ALL")
{
    document.forms[0].district1[2].disabled=false; 
}
else if(document.forms[0].mandal.value=="ALL" && document.forms[0].district.value!="ALL")
{
    document.forms[0].district1[1].disabled=false; 
}
else if(document.forms[0].district.value=="ALL")
{
    document.forms[0].district1[0].disabled=false; 
    document.forms[0].district1[1].disabled=false; 
    document.forms[0].district1[2].disabled=false; 
    document.forms[0].district1[3].disabled=false; 
}
}
}

function submitfrm()
{

var disNo1;var disNo2;var disNo3;var disNo4;
if(document.forms[0].district1[0].disabled){disNo1 = 1;}else{disNo1 = 0;}
if(document.forms[0].district1[1].disabled){disNo2 = 1;}else{disNo2 = 0;}
if(document.forms[0].district1[2].disabled){disNo3 = 1;}else{disNo3 = 0;}
if(document.forms[0].district1[3].disabled){disNo4 = 1;}else{disNo4 = 0;}


document.forms[0].dis1.value = disNo1;
document.forms[0].dis2.value = disNo2;
document.forms[0].dis3.value = disNo3;
document.forms[0].dis4.value = disNo4;

if(document.forms[0].district1[0].checked==false && document.forms[0].district1[1].checked==false && document.forms[0].district1[2].checked==false && document.forms[0].district1[3].checked==false)
{
 alert("Select One Radio Button");
}

if(document.forms[0].district.value=="ALL")
{
	alert("Select District Name");
}
if(document.forms[0].mandal.value=="ALL" && document.forms[0].district1[2].checked==true)
{
alert("It Takes Some Time..");
}

if(document.forms[0].district1[3].checked==true)
{
	if(document.forms[0].mandal.value=="ALL")
	{
		alert("Select Mandal Name");
	}
	else if(document.forms[0].panchayat.value=="ALL")
	{
		alert("Select Panchayat Name");
	}	
	else
	{
		document.forms[0].action="switch.do?prefix=/reports&page=/duplicates.do&mode=duplicates&special=1";
		document.forms[0].submit();
	}
}
else 
{
document.forms[0].action="switch.do?prefix=/reports&page=/duplicates.do&mode=duplicates&special=1";
document.forms[0].submit();
}
}


function funcInit()
{
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
		//if(document.forms[0].district.value=="14")
			document.forms[0].addNew.disabled="true";
	}

}
function funcClose()
{
	if(typeof(window.opener)!="undefined") 
	{
		//alert("child");
		self.close();
	}
	else
	{
		//alert("parent");
		winClose();
	}

}
function funcDistrictChanged()
{
	document.forms[0].action="/pred/reports/duplicates.do?mode=data";	
	document.forms[0].submit();
}

function selectionChanged(mode)
{
	document.forms[0].action="/pred/reports/duplicates.do?mode=data";
	document.forms[0].submit();
}



function fnSave()
{
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
		if(document.forms[0].district.value=="14" )
		{
			alert("Record Cannot be saved as it has been freezed");
			return;
		}
			
	}
	document.forms[0].action="/pred/masters/Habitation.do?mode=save";
	document.forms[0].submit();
	document.forms[0].save.disabled=true;


}

function fnSaveNew()
{
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
		if(document.forms[0].district.value=="14" )
		{
			alert("Record Cannot be saved as it has been freezed");
			return;
		}
	}
	if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		return;
	}
	if(document.forms[0].constituency.value=="")
	{
		alert("Please Select Constituency");
		return;
	}
	else if(document.forms[0].mandal.value=="")
	{
		alert("Please Select Mandal");
		return;
	}
	else if(document.forms[0].panchayat.value=="")
	{
		alert("Please Select Panchayat");
		return;
	}
	else if(document.forms[0].village.value=="")
	{
		alert("Please Select Village");
		return;
	}
	else if(document.forms[0].hcode.value=="")
	{
		alert("HCode is Required");
		return;
	}
	else if(document.forms[0].prcode.value=="")
	{
		alert("PRCode Is Required");
		return;
	}
	else if(document.forms[0].prHabName.value=="")
	{
		alert("PRHabName is Required");
		return;
	}
	else if(document.forms[0].hcode.value.length!=2)
	{
		alert("HCode Should be Of Length 2");
		return;
	}
	else if(document.forms[0].prcode.value.length!=2)
	{
		alert("PRCode Should be Of Length 2");
		return;
	}
	else{
		document.forms[0].save.disabled=true;
		document.forms[0].action="/pred/masters/Habitation.do?mode=saveNew";
		document.forms[0].submit();
	}
}
function viewfun()
{
	if(document.forms[0].district.value!=""  && document.forms[0].mandal.value!="")
	{
		var x=document.getElementById("mandal");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var mandalName=x.options[x.selectedIndex].text;
		else
		var mandalName="";
		
		var x=document.getElementById("constituency");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var constituencyName=x.options[x.selectedIndex].text;
		else
		var constituencyName="";
		
		var x=document.getElementById("panchayat");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var panchayatName=x.options[x.selectedIndex].text;
		else
		var panchayatName="";
		
		var x=document.getElementById("village");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var villageName=x.options[x.selectedIndex].text;
		else
		var villageName="";		
		document.forms[0].action="/pred/masters/Habitation.do?mode=view&mandalName="+mandalName+"&constituencyName="+constituencyName+"&panchayatName="+panchayatName+"&constituencyName="+constituencyName+"&villageName="+villageName;
		document.forms[0].submit();
	}
	else
	{
		alert("District is Required\nMandal is Required");

	}

}
function fnAddNew()
{
	if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		return;
	}
	if(document.forms[0].constituency.value=="")
	{
		alert("Please Select Constituency");
		return;
	}
	else if(document.forms[0].mandal.value=="")
	{
		alert("Please Select Mandal");
		return;
	}
	else if(document.forms[0].panchayat.value=="")
	{
		alert("Please Select Panchayat");
		return;
	}
	else if(document.forms[0].village.value=="")
	{
		alert("Please Select Village");
		return;
	}
	else{
		document.forms[0].action="/pred/masters/Habitation.do?mode=addNew";
		document.forms[0].submit();
	}

}

function showHabCode()
{
	if(document.forms[0].hcode && document.forms[0].prcode)
	{
	
		if(document.forms[0].hcode.value!="" && document.forms[0].prcode.value!="")
		{
				document.forms[0].habcode.value=document.forms[0].district.value+document.forms[0].constituency.value+document.forms[0].mandal.value+document.forms[0].village.value+document.forms[0].hcode.value+document.forms[0].panchayat.value+document.forms[0].prcode.value;
		}
		else
			document.forms[0].habcode.value="";
		}
	
}
//-->
</script>

</head>
<body onload="init()"> <!-- onload="showHabCode();funcInit()" -->
<html:form action="duplicates.do?mode=data">

<table width="70%">
<tr>
<td align="right"><a href="/pred/home.jsp">Home</a>
</tr>
</table>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="70%" >
<tr>
<td>
		<%-- <input type="hidden" name="prevMode" value=<%=request.getAttribute("mode") %> > --%>
		<fieldset>
		<legend>Select</legend>
		<label>
	<table  border=0  width="100%">
	<tr>
		<td class="textborder">District<font color="red">*</font></td>
		<td class="tex tborder">
			<html:select property="district" style="width:150px" onchange="javascript:funcDistrictChanged()" styleClass="mycombo">
			<html:option value="ALL">Select..</html:option>
			<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />  
			</html:select></td>
	
		<td class="textborder">Mandal</td>
		<td>
			<html:select property="mandal" style="width:150px" styleClass="mycombo" onchange="selectionChanged('panchayats')">
			<html:option value="ALL">ALL</html:option>
			<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" /> 
			</html:select></td>
	
		<td class="textborder">Panchayat</td>
		<td>
			<html:select property="panchayat" style="width:150px" styleClass="mycombo" onchange="selectionChanged('villages')">
			<html:option value="ALL">ALL</html:option>
			<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />  
			</html:select></td>
	</tr>

	<tr>
		<td class="textborder">Village</td>
		<td>
			<html:select property="village" style="width:150px" styleClass="mycombo" onchange="selectionChanged('habitations')">
			<html:option value="ALL">ALL</html:option>
			<html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" /> 
			</html:select></td>
	</tr>
		
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		
<tr>
<td>
		<%-- <input type="hidden" name="prevMode" value=<%=request.getAttribute("mode") %> > --%>
		<fieldset>
		<legend>Select Duplicates in</legend>
		<label>
		<table  border=0  width="100%">
		
		<tr>
			<td class="textborder">
			<html:radio property="district1" value="01">Mandal Names</html:radio></td>
			<td class="textborder">
			<html:radio property="district1" value="02">Panchayat Names</html:radio></td>
			<td class="textborder">
			<html:radio property="district1" value="03">village Names</html:radio></td>
			<td class="textborder">
			<html:radio property="district1" value="04">Habitation Names</html:radio></td>
	   </tr>
		
	</table>
	</label>
	</fieldset>
	
	<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;">
	<tr>
	</tr>
	
	<tr>
	   <td class="textborder" align="center">
	       <html:button property="duplicate" value="Duplicates" styleClass="btext" onclick="submitfrm();"/>
	    </td>
	</tr>
	<tr>
	</tr>
	</table>
	</td>
	</tr>

	</table>
<% 
	if(request.getAttribute("data")!=null && request.getAttribute("data").equals("true"))// && request.getParameter("district1")!=null && request.getParameter("district1").equals("01")
	{
		%>
		<%@ include file="rws_duplicates_records1_rpt.jsp" %>
		<%
	}
	%>

<input type="hidden" name="dis1">
<input type="hidden" name="dis2">
<input type="hidden" name="dis3">
<input type="hidden" name="dis4">

	</html:form>
	
	</body>
<%@ include file="/commons/rws_alert.jsp"%>		 

	