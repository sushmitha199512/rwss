<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/slidebox.js'/>"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/Tooltip1.js'/>"></script>
<script language="javaScript">

function getSourceDetails()
{
var work_id=document.getElementById('nwork').value;
if(work_id=="")
{
alert("Please Enter WorkId");
return;
} else if(work_id.length<14)
{
alert("WorkId Should  Be in 14 Didgit.");
return;
}
document.forms[0].action="switch.do?prefix=/works&page=/MultipleSource.do?mode=viewSource";
document.forms[0].submit();
}

function getFormmandal()
   {
	   document.forms[0].action="switch.do?prefix=/works&page=/MultipleSource.do&mode=habs";
	   document.forms[0].submit();
   }



function getFormSource()
 {
	   document.forms[0].action="switch.do?prefix=/works&page=/MultipleSource.do&mode=sourceTypes";
	   document.forms[0].submit();
 }

function  getFormSourcetype()
{
       document.forms[0].action="switch.do?prefix=/works&page=/MultipleSource.do&mode=subsourceTypes";
	   document.forms[0].submit();
}


function getForm()
	{	

       if(document.forms[0].subSourceType.value=="")
		 {
		 	alert("Select Subsource Type");
            return;
		 }

        if(document.forms[0].spradgroup[0].value!=""  && document.forms[0].spradgroup[0].checked)
           {
	        document.forms[0].action="/pred/works/MultipleSource.do?mode=sourceDetails&mode1=existSource";
			document.forms[0].submit();
           }
        else if(document.forms[0].spradgroup[0].value!="" && document.forms[0].spradgroup[1].checked)
           {
	        document.forms[0].action="/pred/works/MultipleSource.do?mode=sourceDetails&mode1=newSource";
			document.forms[0].submit();
           }
        
	}

function displaySourceEntry()
{
    var work_id=document.getElementById('nwork').value;
	if(work_id=="")
	{
	alert("Please Enter WorkId");
	return;
	} else if(work_id.length<14)
	{
	alert("WorkId Should  Be in 14 Didgit.");
	return;
	}
  document.getElementById('sourceEntry').style.display='block';
  document.forms[0].action="/pred/works/MultipleSource.do?mode=mandals";
  document.forms[0].submit();
}

function setSourceName()
	{   // alert("hello");
		var scode = document.forms[0].srcCode.value;
		var sname = scode.substring(25,scode.length);
		document.forms[0].srcName.value=sname;
	}



function sinsertForSourceIdentification()
   {
	   	 if(document.forms[0].mandalCode.value=="")
		 {
		 	alert("Select Mandal");
		 }
		 else if(document.forms[0].sitehab.value=="")
		 {
		 	alert("Select Source Habitation");
		 }
		 else if(document.forms[0].subcompType.value=="")
		 {
		 	alert("Select Source Type");
		 }
		 else if(document.forms[0].subSourceType.value=="")
		 {
		 	alert("Select Subsource Type");
		 }
		 else if(!(document.forms[0].spradgroup[0].checked || document.forms[0].spradgroup[1].checked))
		 {
		 	alert("Select Existing Source or New Source");
		 }
		 else if(document.forms[0].spradgroup[0].checked)
		 {
             // alert("hai i am existSource saving");
		 	if(document.forms[0].extSourceCode.value=="")
		 	{
		 		alert("Select Source Code");
		 	}
		 	else
		 	{
			 	document.forms[0].action ="/pred/works/MultipleSource.do?mode=save";
				document.forms[0].submit();
		 	}
		 }
		 else if(document.forms[0].spradgroup[1].checked)
		 {  // alert("hai i am newSource saving");
		 	if(document.forms[0].newSourceName.value=="")
		 	{
		 		alert("Enter Source Name");
		 	}
		 	else
		 	{
			 	document.forms[0].action ="/pred/works/MultipleSource.do?mode=save";
				document.forms[0].submit();
		 	}
		 }
	}
</script>
<body>



<html:form action="/MultipleSource.do" >
<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="965" ><tr>
<tr><td class="mycborder">
<jsp:include page="/commons/TableHeader.jsp">
<jsp:param name="TableName" value=" Multiple Source Entry Form"/>
<jsp:param name="TWidth" value="100%"/>
<jsp:param name="Tborder" value="0"/>
</jsp:include>

<table align=center bgcolor="#DEE3E0" bordercolor= "black"  border="0" style="border-collapse:collapse;" width="965" ><tr>
		<tr>
         <td class="mycborder">
		 <fieldset>
		 <legend>Work Details</legend>
		 <table  border=0  width="100%">
			 <tr>
	         <td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Enter WorkId:<font color="red">*</font></B></font>
				<html:text    property="nwork" maxlength="14"  styleClass="modeltextbox" onkeypress="return decimalsOnly(event)" ></html:text>
				 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="Get Details "  onclick="getSourceDetails()">
	         <input type="button" value="Add New Source "  onclick="displaySourceEntry()"> </td>
	         </tr>
	</table>
</fieldset>
</td>
</tr>
			<tr>
			<td>
			<fieldset>
					<legend><font color=#871D0E face=verdana size=2><b>Already Existing Source Details</b></font></legend>
				<label>
                <div id="sourceDetails" style="display:block">
				<table width="965" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"  style="border-collapse: collapse">			   
					<thead class="gridHeader">
					<tr>
					<th nowrap>S.No.</th>
					<th>Work Id</th>
					<th>Work Name</th>
					<th>Mandal</th>
	                <th>Panchayat</th>
					<th>Source Habitation</th>
				  	<th>Source Type</th>
				  	<th>Sub Source Type</th>
				  	<th>Source</th>
				  	<th>Source Name</th>			 
					</tr>
					</thead>
			 <%
 			   int sno=0;
 			 %>
 			
 			<%
try{
			java.util.ArrayList rows=(java.util.ArrayList)session.getAttribute("rows");
 			
 			int iter = 1;
 			int k =0;
 			if(rows!=null)
            {
 			 %>
 		
 			 <nested:iterate id="list_d" property="rows" indexId="ndx">
 				<tr bgcolor="#ffffff">
	    		<td class="rptValue"><font face="verdana" size="2"><%=++sno%></font></td>
				<td class="rptValue"><nested:write name="list_d" property="workid"/></td>
                <td class="rptValue"><nested:write name="list_d" property="workname"/></td>
				<td class="rptValue"><nested:write name="list_d" property="mandal"/></td>
				<td class="rptValue"><nested:write name="list_d" property="panchayat"/></td>
				<td class="rptValue"><nested:write name="list_d" property="sourcehab"/></td>
				<td class="rptValue"><nested:write name="list_d" property="sourcetype" /></td>
                <td class="rptValue"><nested:write name="list_d" property="subsourcetype"/></td>
				<td class="rptValue"><nested:write name="list_d" property="source"/></td>
				<td class="rptValue"><nested:write name="list_d" property="sourcename"/></td>
		        </tr>
             </nested:iterate>
</table>
</div>
</label>
</fieldset>

            
		    <%
              }
             else
             { 
               
             %>
 			 <tr bgcolor="#ffffff">
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
 			 <td class="rptValue"></td>
             </tr> 
	 <%} }catch(Exception e){
      e.printStackTrace();
  }



%>

<tr class="textborder">
		<td colspan=10>
		<fieldset>
        <legend><font color=#871D0E face=verdana size=2><b>Add New Source</b></font></legend>
        <label>
<div id="sourceEntry" style="display:block">
 <table>
        <tr class="textborder">
 	    <logic:present name="mandalCode">
 	    <td><font face=verdana size=2><b>Mandal</b></td>
 	    <td ><html:select property="mandalCode" style="width:183px" styleClass="mycombo"  onchange="getFormmandal()">
			<html:option value="">Please Select...</html:option>
			 <html:options collection="mandalCode" name="mandalCodes" property="mandalCode" labelProperty="mandalName" />
			</html:select>
			
		</td>
		</logic:present>
		<logic:notPresent name="mandalCode">
		<td><font face=verdana size=2><b>Mandal</b></td>
		<td><html:select property="mandalCode" style="width:183px" styleClass="mycombo" onchange="getFormmandal()">
			<html:option value="">Please Select...</html:option>
			</html:select>
			
		</td>
		</logic:notPresent>
 	    <tr class="textborder">
		<logic:present name="siteHab1">
		<td><font face=verdana size=2><b>Source Habitation</b></td>
		<td><html:select property="sitehab" style="width:200px" styleClass="mycombo"  onchange="getFormSource()">
			<html:option value="">Please Select...</html:option>
			<html:options collection="siteHab1" name="sitehabs" property="panchCode" labelProperty="panchName" /> 
			</html:select>
			
		</td>
		</logic:present>
		<logic:notPresent name="siteHab1">
		<td ><font face=verdana size=2><b>Source Habitation</b></td>
		<td ><html:select property="sitehab" style="width:183px" styleClass="mycombo" onchange="getFormSource()">
			<html:option value="">Please Select...</html:option>
			</html:select>
			
		</td>
		</logic:notPresent>

		<td><font face=verdana size=2><b>Source Type</b></td>
			<td width="150">
		<html:select property="subcompType" style="width:183px"  styleClass="mycombo"  onchange="getFormSourcetype()">
			  <html:option value="">Please Select...</html:option>
		     <logic:present name="scTypes">
			<html:options collection="scTypes" name="scType" property="subCompCode" labelProperty="subCompName" /> 
			</logic:present>
			</html:select>
			</td>
	  	 
	  	 		<td><font face=verdana size=2><b>Sub Source Type</b></td>
			<td width="150">
			<html:select property="subSourceType" style="width:183px"  styleClass="mycombo">
			  <html:option value="">Please Select...</html:option>
		     <logic:present name="subSources">
			<html:options collection="subSources" name="subSource" property="subCompCode" labelProperty="subCompName" /> 
			</logic:present>
			</html:select>
			</td>
		    </tr>
<tr>
<td colspan=2><html:radio property="spradgroup"  value="existSource" onclick="getForm()"/><font face=verdana size=2><b>Existing Source</b></td>
<td colspan=2><html:radio property="spradgroup"  value="newSource" onclick="getForm()"/><font face=verdana size=2><b>New Source</td>
</tr>


<%  
  String r=(String)request.getAttribute("spradgroup");

 if (r!=null && r.equals("existSource"))
		{
	    			
		%>
	 	<tr class="textborder">
	 	<td><font face=verdana size=2><b>Source</b></td>
			<td width="150"><html:select property="extSourceCode" style="width:300px" styleClass="mycombo" onchange="setSourceName()" >
		<html:option value="">Please Select...</html:option>
		<logic:present name="extSourceCodes">
			<html:options collection="extSourceCodes" name="sourceCode" property="sourceCode" labelProperty="sourceCode" /> 
			</logic:present></html:select>
			<td ><font face=verdana size=2><b>Source Name</b></td>
			<td width="160"><html:text property="extSourceName" readonly="true"/></td>
		</tr>
		<%
		}
   else if (r!=null && r.equals("newSource"))
		{
		%>
		<tr class="textborder">
			<td width="180"><font face=verdana size=2><b>Source Code</b></td>
			<td width="160"><html:text property="newSourceCode" readonly="true"  style="width:300px"/></td>
			<%
			String acode = (String)request.getAttribute("assetCodee");
			if(acode!=null && !acode.equals("04")){ %>
			<td width="160"><font face=verdana size=2><b>Source Name</b></td>
			<%}else if(acode!=null  && acode.equals("04")){ %>
			<td ><font face=verdana size=2><b>Location Name</b></td>
			<%} %>
			<td width="160"><html:text property="newSourceName"   /></td>
	 	</tr>
			<%
			}
%>

<tr class="textborder">
			<td><font face=verdana size=2><b>Site/Source Identified By</b></td>
			<td><html:text property="sourceIdentby" maxlength="25"/></td>

<td><font face=verdana size=2><b>Source Site Handing Over Date</b></td>
			<td><html:text property="siteHODate" maxlength="25" readonly="true"/><a href="javascript: showCalendar(document.forms[0].siteHODate);"><img src="/pred/resources/images/calendar.gif"  border="0" align="absmiddle"></a></td>

</tr>
<tr class="textborder">
		<td><b>Recommendations By<B> Geologist</b></td>
		<td colspan="2" ><html:text property="recommend"  style="width:400px" /></td>
</tr>
<tr>
			 <td align=center colspan=4>
			
 		<input type=button value=Save onclick="sinsertForSourceIdentification()" class="bText"/>
	 	</tr> 
				</table>
</div>
				</label>
				</fieldset>
				</td>
				</tr>


<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
	<jsp:param name="Tborder" value="0"/>
</jsp:include>
</table>
</td>
</tr>
</table>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="/commons/rws_alert.jsp" %>




