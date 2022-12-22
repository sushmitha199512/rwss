<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="/commons/rws_admin_authorization_struts.jsp"%>
<%int count = 1;
	nic.watersoft.commons.RwsUser rwsusers=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String rwsuserid = users.getUserId();
	String ad=(String)session.getAttribute("userId");
	System.out.println("user:"+ad);
%>
<head>
<style type="text/css"> 
<!--
.style1 {color: #FF0000;
font-family: verdana;
font-size: 13px;}
-->
</style>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>

<style type="text/css">
  .checkboxWrapper {
    position: relative;
  }
  .checkboxOverlay {
    position: absolute;
    left: 0;
    right: 0;
    top: 0;
    bottom: 0;
  }
</style>
<script>
function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
function getDivisions()
	{
	 
	  document.forms[0].action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=divisions";
	  PSWorkForm.submit();
	}
function getWorkcategory()
	{
	  document.forms[0].action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=workcategory";
	  PSWorkForm.submit();
	}
function getSubDivisions()
	{
	
		document.forms[0].action="switch.do?prefix=/works&page=/aap.do&mode=data";
		PSWorkForm.submit();
	}
function getProgramme()
{

	document.forms[0].action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=programmes";
	PSWorkForm.submit();
	
}

function getPrograms()
{
	if(document.forms[0].divisionOfficeCode.value==''){
	  alert("Please Select Division");
		return false;
}
	document.forms[0].action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=getPrograms";
	document.forms[0].submit();
	
}
function getSubProgramme()
{
	
	document.forms[0].action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=subprogrammes";
	PSWorkForm.submit();
	
}
function getWorks1()
{
	
	document.forms[0].action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=getworks";
	PSWorkForm.submit();
	
}
function check(index){

var value=document.getElementById('WORKS['+index+'].checks').value;

//alert(value);

}
function checkMe()
{
	if(document.forms[0].type[0].checked)
	{
		document.forms[0].type[0].checked =true;
	}
	else if(document.forms[0].type[1].checked)
	{
		document.forms[0].type[1].checked =true;
	}
	else
	{
		document.forms[0].type[0].checked =true;
	}
}

function getWorks()
	{
	  if(document.forms[0].circleOfficeCode.value==''){
	  alert("Please Select Circle");
		return false;
      //document.PSWorkForm.action="switch.do?prefix=/works&page=/aap.do&mode=data";
	  //document.PSWorkForm.submit();		
	  }
	  else if(document.forms[0].divisionOfficeCode.value==''){
	  alert("Please Select Division");
		return false;
     // document.PSWorkForm.action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=programmes";
	 // document.PSWorkForm.submit();		
	  }
	//   else if(document.forms[0].type[0].checked == false && document.forms[0].type[1].checked == false ){
	//  alert("Please Select Plan/Non Plan");
	//	return false;
     // document.PSWorkForm.action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=programmes";
	 // document.PSWorkForm.submit();		
	//  }
	  else {
		document.forms[0].action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=getWorks";
		document.forms[0].submit();		
		}
	}
function fnShowHabs(workid)
{
	var workId=workid.name;
	var url = "switch.do?prefix=/works&page=/aap.do&mode=data&mode1=showHabs&workID="+workId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
</script>
</head>

<html:form action="aap.do">
<body onload="checkMe()">
<table width="100%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Works For Annual Action Plan" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Office Details</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2" border="0"bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tbody class="formTBody">
		<tr class="textborder">	
<%
java.util.Date systemdate= new java.util.Date(System.currentTimeMillis());
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
String transdate=null;
transdate=dateFormat.format(systemdate);
%>


	<td class="textborder">Circle<span class="mandatory">*</span></td>
	<td>
		<logic:equal name="RWS_USER" property="circleOfficeCode"  value="00" >
		<html:select property="circleOfficeCode" styleClass="combo" onchange="getDivisions()" >
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="circles">
		<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>			  
		</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00" > 
		<html:text property="circleOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
		<html:hidden property="circleOfficeCode" name="RWS_USER" />
		</logic:notEqual>
	</td>

	<td class="textborder">Division<span class="mandatory">*</span></td>
	<td>
		<logic:equal name="RWS_USER" property="divisionOfficeCode"  value="0" >
		<html:select property="divisionOfficeCode" styleClass="combo" >
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="divisions">
		<html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>			  
		</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0" > 
		<html:text property="divisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
		<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
	</td>
	<%if(ad!=null && (ad.equals("admin") || ad.equals("100000"))){%>
	<td><html:radio property="type" value="1" />Plan
	<html:radio property="type" value="2"/>Non Plan
	</td>
	<%}else{%>
		<td><html:radio property="type" value="1"  />Plan
		<html:radio property="type" value="2" disabled="true"/>Non Plan
		</td>
	<%}%>
<td>

&nbsp;
&nbsp;
&nbsp;Category:<html:select property="category"
							style="width:135px" styleClass="mycombo"
							onchange="javascript:getPrograms();">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
<html:option value="1">
								<font class="myfontclr1">Projects
							</html:option>
<html:option value="2">
								<font class="myfontclr1">Normal
							</html:option>
<html:option value="3">
								<font class="myfontclr1">District Level
							</html:option>
</html:select>
</td>


<logic:present name="programs">
						<td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Programs:</td>
						<td class="textborder"><html:select property="programCode"
							style="width:143px" styleClass="mycombo"
							>
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="programs" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present>

<logic:present name="schemes">
						<td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Schemes:</td>
						<td class="textborder"><html:select property="schemeCode"
							style="width:143px" styleClass="mycombo">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="schemes" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present>

</tr><tr ></tr><tr >
<td ></td><td ></td><td ></td><td ></td><td ></td>
	<td>
	<input type="button"  onclick="javascript:getWorks();" value="Get Works" class=btext id="savebutton">
	</td>
	</table>
	</label>
	</fieldset>
</td>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="13"><B><font color="#FFFFFF">Works For AAP </B></td>
<td align="center">
</td>
</tr>
<tr >
	<td class="clrborder" align="center">S.No.</td>
	<td class="clrborder" align="center">Work Name</td>	  
	<td class="clrborder" align="center">Work ID</td>
	<td class="clrborder" align="center">Program Name</td>
	<td class="clrborder" align="center">SubProgram Name</td>
	<td class="clrborder" align="center">Sanction No</td>
	<td class="clrborder" align="center">Sanction date</td>
	<td class="clrborder" align="center">Est. Cost<br>(in lakhs)</td>
	<td class="clrborder" align="center">Category</td>
	<td class="clrborder" align="center">Work Type</td>
	<td class="clrborder" align="center">Habs</td>
	<td class="clrborder" align="center">Source Code</td>
	<td class="clrborder" align="center">Grounding Date</td>
	<td class="clrborder" align="center">Check</td>
	</tr>
	<nested:iterate id="WORKS" property="psWorks" indexId="ndx">
	<tr align="left"  onclick="toggleRowColor(this)">
		<td class="bwborder"><%=count++%></td>
		<td> <input type="text" name="a" class="mytext" style="width:120px" readonly="true" onmouseover="Tip(this.value,TITLE,'')" value="<bean:write name="WORKS" property="workName" />
		"onmouseout="UnTip()"/></td>
		<td  class="bwborder" ><bean:write name="WORKS" property="workId" /></td>
		<nested:hidden name="WORKS" property="workId"  indexed="true"/>
		<td class="bwborder"><bean:write name="WORKS" property="progName" /></td>
		<td  class="bwborder" ><bean:write name="WORKS" property="subprogName" /></td>
		<td  class="bwborder" ><bean:write name="WORKS" property="admnNo" /></td>
		<td  class="bwborder" ><bean:write name="WORKS" property="admnDate" /></td>
		<td  class="bwborder" ><bean:write name="WORKS" property="admnAmnt" /></td>
		<td  class="bwborder" ><bean:write name="WORKS" property="main" /></td>
		<td  class="bwborder" ><bean:write name="WORKS" property="label" /></td>
		<td  class="bwborder" align="right" nowrap><bean:write name="WORKS" property="noofhabs" />
			&nbsp;<input type="button" value="..." title="Show Selected Habs"  class="btext" 
					name="<bean:write name="WORKS" property="workId" />" onclick="javascript:fnShowHabs(this)">
			</td>
		<td  class="bwborder" ><bean:write name="WORKS" property="sourceCode" /></td>
		<td  class="bwborder" ><bean:write name="WORKS" property="groundDate" /></td>
		<%boolean flag = false;%>
		<td class="bwborder" align=center>
		<nested:equal name="WORKS" property="sourceCode" value="-">
					<%flag = true;%>			
		</nested:equal>

	
					<%if(flag){%>
				<html:checkbox name="WORKS" property="checks" disabled="true"  onclick='<%= "check(" + ndx + ")" %>' indexed="true"/>
				<%}else{%>
				<html:checkbox name="WORKS" property="checks"  onclick='<%= "check(" + ndx + ")" %>' indexed="true"/>
<div class="checkboxOverlay" onclick='<%= "check(" + ndx + ")" %>' ></div>
				<%}%>
		</td>
	</tr>
</nested:iterate>
<%if(count==1){ %><tr><td colspan="13" align="center" class="btext">No Records</td></tr><%}
else{%><tr><td colspan="14" align="center"><input type=button value=Save onClick="fnSave();" class="btext"></td></tr><%}%>
<input type="hidden" name="resultCount" value="<%=count%>">
<html:hidden property="deldate" value='<%=transdate%>'/>
</table>
<script>
function fnSave(){
var selectedWorks='';
    var len=document.PSWorkForm.resultCount.value;
	len = len-1;
    var yes=0;    
	for( var i=0;i<len;i++)
	{     
			if(document.getElementById("WORKS["+i+"].checks").checked==true)
			{
				selectedWorks=selectedWorks+","+document.getElementById("WORKS["+i+"].workId").value;
		     }
	}
	//alert("selectedWorks:"+selectedWorks);
	  if(selectedWorks=="")
	   {
		 alert("Select atleast one check box to save");
       }
	  else{
	
		  if(confirm("Are You Sure To Save The Checked Work(s)")) {
			  document.forms[0].work.value = selectedWorks;
	document.forms[0].action="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=saveWorks";
         document.forms[0].submit();
			}
	  }
}
</script>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>
<input type=hidden name=work>
</html:form><p align=center>
<font face="verdana" size="2" color="red">
<b>Note********: In this Report All the Ongoing Works are Displayed </b></font>
<table align="center" cellpadding="0" cellspacing="0" border=0>
  <tr>
    <td><span class="style1"><li>The works to Send GOI - Source Details Mandatory, So you can select the works which are having these details</span></td>
  </tr>
  <tr>
    <td><span class="style1"><li>If you want send the work, Please Update the Source Details from 'WORK STATUS' form</span></td>
  </tr>
  <tr>
    <td><span class="style1"><li>'-' Represents NO DATA</span></td>
  </tr>
</table>
</p>
<br>
<script>
var ad='<%= (String)session.getAttribute("userId")%>';
if(ad=="admin" || ad=="100000")
{
	document.getElementById('savebutton').disabled=false;
}
else
{
	document.getElementById('savebutton').disabled=true;
	document.getElementById('savebutton').value='Freezed';
}
</script>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>