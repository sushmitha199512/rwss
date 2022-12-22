<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
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

.btext1 {
	text-transform: uppercase;
	color: green;
}

.btext3 {
	color: green;
	font-weight: bold;
}
</style>
<STYLE>
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
</STYLE>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<head>


<script language="JavaScript">
<%

RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
String source = request.getParameter("source");
String habCode=request.getParameter("habCode");
String radio1=request.getParameter("radio1");
String sourceTypeCode=request.getParameter("sourceTypeCode");
String sourceCode=request.getParameter("sourceCode");
session.setAttribute("sourceCode", sourceCode);
//System.out.println("sourceCode"+sourceCode);


//System.out.println("sourceCode"+sourceCode);
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String transdate=null;
	transdate=dateFormat.format(systemdate);
	String lbl="Aadhaar";
	String type="";
	
%>

 
function init()
{
	//.alert("onload");

		//var e=document.getElementsByName("dist")[0].value;
		//alert("e"+e);
		//if(e!=null && e!='')
		//{
		//alert("e in if"+e);
		//e="-1";
			//alert("document.forms[0].dist.value"+document.forms[0].dist.value);
			//document.getElementsByName("dist")[0].value.submit();
		//	return false;
			
		if(document.getElementById('dist').value=="-1")
	{
		
		}
	
	dCode='';
	mCode='';
	pCode='';
	vCode='';
	habCode='';
	
	
		
		
	
}
function AddHabs()
{
//alert("habs list");
		document.forms[0].action="switch.do?prefix=/wquality&page=/sourceHab.do&mode=pickmandals";
	    document.forms[0].submit();
		
}
	
function selectoptions()
{
	
	if(document.forms[0].dist.value=="-1" || document.forms[0].dist.value==null)
	 {
		 alert("Select District");
		 return false;
	 }
	 else if(document.forms[0].mcode.value=="-1" || document.forms[0].mcode.value==null)
	 {
		 alert("Select Mandal");
		 return false;
	 }
	 else if(document.forms[0].pcode.value=="-1" || document.forms[0].pcode.value==null)
	 {
		 alert("Select Panchayat");
		 return false;
	 }
	 else if(document.forms[0].vcode.value=="-1" || document.forms[0].vcode.value==null)
	 {
		 alert("Select Village");
		 return false;
	 }
	 else if(document.forms[0].habCode.value=="-1" || document.forms[0].habCode.value==null)
	 {
		 alert("Select Habitation");
		 return false;
	 }
	
	}



function setIdName()
{
	
 
	var type =document.getElementById('source').value;
	
	 
   if(type=="HP")
   {
	    
	   document.getElementById("lbl").innerText="HandPump Sources";
   }
   else
	   if(type=="OW")
	   {
		    
		   document.getElementById("lbl").innerText="OpenWell Sources";
	   }
   else
       if(type=="OHSR")
       {
	    
	   document.getElementById("lbl").innerText="OHSR Sources";
       }
   else
	   if(type=="GLSR")
	   {
		    
		   document.getElementById("lbl").innerText="GLSR Sources";
	   }
  else
		if(type=="SS")
		 {
			    
		   document.getElementById("lbl").innerText="Sub Surface Sources";
		}
   else
		if(type=="SU")
		 {
				    
		  document.getElementById("lbl").innerText="Surface Sources";
		 }	
   else
		if(type=="GLBR")
		{
					    
		document.getElementById("lbl").innerText="GLBR Sources";
		 }	

   else
	    if(type=="SHP")
		{
							    
		document.getElementById("lbl").innerText="Shallow HandPump Sources";
		 }	
    else
		if(type=="PO")
		{
									    
		document.getElementById("lbl").innerText="Ponds Sources";
	    }	

  
}


function getData2()
{
	//alert("onchange");
	document.forms[0].action="switch.do?prefix=/wquality&page=/sourceHab.do&mode=data";
    document.forms[0].submit();
}




function sourceSelected(index)
{

	var sourceCode=document.getElementById("SOURCESLIST["+index+"].sourceCode").value;
	
	var sourceTypeCode=document.getElementById("SOURCESLIST["+index+"].sourceTypeCode").value;
	

document.forms[0].action="../switch.do?prefix=/wquality&page=/sourceHab.do&mode=data"+"&sourceTypeCode="+sourceTypeCode+"&sourceCode="+sourceCode;

document.forms[0].submit();

}

function fnShowHabs()
{
	//alert("showhabs");
	
	//alert("anjali");
	var url = "switch.do?prefix=/wquality&page=/sourceHab.do&mode=adminhabs";
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);

		
}


function fnMandals()
{
	//alert("mandal show");
	
	var url = "switch.do?prefix=/wquality&page=/sourceHab.do&mode=pickmandals";
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
	
		
}


</script>

<body  onload="javascript:init();">


<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="/sourceHab.do">

<table>
<tr><td align="right">
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Single Source Multiple Habitations" />
	<jsp:param name="TWidth" value="760" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border="1" 
	   style="border-collapse:collapse;" width="800" >
		<tr>
			<td class="textborder" >
<table cellpadding="1" cellspacing="5" bordercolor="#8A9FCD" border=0 
					style="border-collapse: collapse;" width="800">
					
	   <tr>
<td>
   <fieldset>
   
   <legend><b><bean:message key="legend.habitationDetails"/></b><span class="mandatory">*</span></legend>
   <label>

   
  <table  width="100%" border=0 style="border-collapse:collapse;" >
  
		<tr>
		<td>

   	  

		<table  border=0   width="70%"  style="border-collapse:collapse;">
	
  

    <tr>
	    <!--<td class="btext2" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()"  >
		<html:option value="-1"><font class="myfontclr1">SELECT...</html:option>
		
         <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
		</td>
		
		-->
		
		<td class="bwborder"><FONT class=myfontclr color="purple">District&nbsp;<font color="#FF6666">*</font>:</FONT></td>
	<td class="bwborder">
		<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
		<html:select property="circleOfficeCode" onchange="javascript:getData2()" styleClass="combo">
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="districts">
			<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>			  
		</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
		<html:text property="circleOfficeName" name="RWS_USER" readonly="true" styleClass="text"/>
		<html:hidden property="circleOfficeCode" name="RWS_USER" />
		</logic:notEqual>
	 </td>
	 <!--
	
	
	 
	 <td class="btext2" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()"  >
		<html:option value="-1"><font class="myfontclr1">SELECT...</html:option>
		
      <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="value" labelProperty="label" />
     </logic:present >
		</html:select>
		</td>
	 

		-->
		<td class="btext2" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mcode" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()" >
			<html:option value="-1"><font class="myfontclr1">SELECT...</html:option>
             <logic:present name="mandals">
			<html:options collection="mandals" name="rwsLocationBean" property="value" labelProperty="label" />
            </logic:present>
			</html:select>
	</td>
	
	
	
	</tr>
	<tr>
		<td class="btext2" width="100">
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="pcode" styleClass="mycombo" style="width:130px"  onchange="javascript:getData2()" >
		<html:option value="-1">SELECT...</html:option>
        <logic:present name="panchayats">
		<html:options collection="panchayats" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
	</td>
	
	
	<td class="btext2" width="100">
	<bean:message key="app.village" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="vcode" styleClass="mycombo" style="width:130px"  onchange="javascript:getData2()" >
		<html:option value="-1">SELECT...</html:option>
        <logic:present name="villages">
		<html:options collection="villages" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
	</td>
		</tr>
		<tr>
		<td></td>
		<td></td>
		</tr>
		<tr>
		<td class="btext2" width="100">
		<bean:message key="app.Hab" /><font color="#FF6666">*</font></td>
	    <td class="textborder" width="150">
		<html:select property="habCode" styleClass="mycombo" style="width:300px"  onchange="javascript:getData2()" >
		<html:option value="-1">SELECT...</html:option>
        <logic:present name="habitations">
		<html:options collection="habitations" name="rwsLocationBean" property="value" labelProperty="labelValue" />
        </logic:present >
		</html:select>
	    </td>
		</tr>


	
	
</table>
</fiedset>
</label>
</td>
</tr>
 <tr><td colspan="5">&nbsp;</td></tr>
	<tr> 
<table width="100%" border=0 style="border-collapse:collapse;">

<tr>
		<td class="textborder" align="center" colspan="8"><font color=purple>Select Source<font color="#FF6666">*</font></font>
		<select name="source"  onclick="selectoptions()" onclick="setIdName()"  onchange="this.form.submit()" class="mycombo">
			<option value="">Select..</option>
			<%
				if(source!=null && source.equals("SS")){%>
				
				<option value="SS" selected>Sub Surface</option>
				<option value="SU">Surface</option>
				<option value="GLSR" >GLSR</option>
				<option value="GLBR" >GLBR</option>
				<option value="OHSR" >OHSR</option>
				<option value="HP">Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}
			else if(source!=null && source.equals("SU"))
			{%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" selected>Surface</option>
				<option value="GLSR" >GLSR</option>
				<option value="GLBR" >GLBR</option>
				<option value="OHSR" >OHSR</option>
				<option value="HP">Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}
			else if(source!=null && source.equals("HP")){%>
			
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="GLSR" >GLSR</option>
				<option value="GLBR" >GLBR</option>
				<option value="OHSR" >OHSR</option>
				<option value="HP" selected>Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}else if(source!=null && source.equals("OW")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="GLSR" >GLSR</option>
				<option value="GLBR" >GLBR</option>
				<option value="OHSR" >OHSR</option>
				<option value="HP" >Hand Pump</option>
				<option value="OW" selected>Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}else if(source!=null && source.equals("PO")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="GLSR" >GLSR</option>
				<option value="GLBR" >GLBR</option>
				<option value="OHSR" >OHSR</option>
				<option value="HP" >Hand Pump</option>
				<option value="OW" >Open Well</option>
				<option value="PO" selected>Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
				<%}else if(source!=null && source.equals("SHP")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="GLSR" >GLSR</option>
				<option value="GLBR" >GLBR</option>
				<option value="OHSR" >OHSR</option>
				<option value="HP" >Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO" >Ponds</option>
				<option value="SHP" selected>Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
				<%}
				else if(source!=null && source.equals("GLSR")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="HP" >Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO" >Ponds</option>
				<option value="GLSR" selected>GLSR</option>
				<option value="GLBR" >GLBR</option>
				<option value="OHSR" >OHSR</option>
				<!--<option value="OT">Others</option>-->
				<%}
				else if(source!=null && source.equals("GLBR")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="HP" >Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO" >Ponds</option>
				<option value="GLSR">GLSR</option>
				<option value="OHSR" >OHSR</option>
				<option value="GLBR" selected>GLBR</option>
				<!--<option value="OT">Others</option>-->
				<%}
				else if(source!=null && source.equals("OHSR")){%>
				<option value="SS" >Sub Surface</option>
				<option value="SU" >Surface</option>
				<option value="HP" >Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO" >Ponds</option>
				<option value="GLSR">GLSR</option>
				<option value="OHSR"  selected>OHSR</option>
				<option value="GLBR" >GLBR</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}
				else {%>
				<option value="SS" >Sub Surface</option>
				<option value="SU">Surface</option>
				<option value="GLSR" >GLSR</option>
				<option value="GLBR" >GLBR</option>
				<option value="OHSR" >OHSR</option>
				<option value="HP">Hand Pump</option>
				<option value="OW">Open Well</option>
				<option value="PO">Ponds</option>
				<option value="SHP">Shallow Hand Pump</option>
				<!--<option value="OT">Others</option>-->
			<%}
			%>
		</select>
		</td>
	</tr>
	
	
				<%
if(source!=null && !source.equals("")){
	nic.watersoft.wquality.SourceHabMasterData rwsdata=new  nic.watersoft.wquality.SourceHabMasterData(); 
	java.util.ArrayList sourcelist =new java.util.ArrayList();
	sourcelist=rwsdata.getSelectedSources(source, habCode);
	request.setAttribute("sourcelist",sourcelist);
	

//System.out.println("size:"+sourcelist.size());
int count=0;
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=60%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">
<br>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10  id="lbl">Sources</td>	
	</tr>
    <tr align = center>
		<td class=btext >Sl.No</td>
	    <td class=btext >select</td>
        <td class=btext >Scheme</td>
        <td class=btext >Code </td>
		<td class=btext >Name </td>
		<td class=btext >Location</td>
		<td class=btext >Status</td>
		<td class=btext >LATITUDE</td>
		<td class=btext >&nbsp;LONGITUDE </td>
	
		
	</tr>
<input type=hidden name=ftklab value="<%=request.getParameter("ftklab")%>">
<nested:iterate id="SOURCESLIST" name="sourcelist" indexId="ndx">

<% count=count+1;%>
<tr align="center" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >

<td  class="bwborder" > <%=count %></td>

<td  class="bwborder" >
<input type="radio" name="radio1" onclick="<%="javascript:sourceSelected("+ ndx +")"%>"></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="waterAssettype" /></td>

<td>
<nested:hidden name="SOURCESLIST" property="sourceCode" indexed="true"/> 
<nested:write name="SOURCESLIST"  property="sourceCode" /></td>

<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="waterSourcename" /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="location" /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="assetStatus" /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="latitude" /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="longitude" /></td>
<nested:hidden name="SOURCESLIST" property="sourceTypeCode" indexed="true" />
<nested:hidden name="SOURCESLIST" property="sourceTypeName" indexed="true" />

</tr>
</nested:iterate>
	<% if(count==0) 
		{%>
		<tr><td  align="center"  colspan=11>No Records</td></tr>
		<%}%>
</table>
<%}%>

<BR>
<BR>
<BR>


<% 
int count=0;
String sourcevalue="";

%>

<table border = 1 cellspacing = 0 cellpadding = 0 width=85%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">	

	<%if(sourceCode!=null && sourceCode!=""){ %>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10  id="lbl">Habitations</td>	
	</tr>
	<tr align = center>
		<td class=btext >Sl.No</td>
	   <td class=btext nowrap>Source code</td>
	  
			
	</tr>
	<%} %>
	

<% count=count+1;
//System.out.println("sourceCode"+sourceCode);
if(sourceCode!=null)
{
%>

<tr align="center" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >

<td  class="bwborder"><%=count%></td>
<td class="bwborder"><%=sourceCode%>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Show&nbsp;Habs" onclick="fnShowHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add&nbsp;Habs"  onclick="fnMandals();" /></td>
<!-- <td class="textborder" align="center" colspan=2><input type="button" class=btext value="Show&nbsp;Habs" onclick="fnShowHabs()" />&nbsp;&nbsp;&nbsp;<input type="button" class=btext value="Add&nbsp;Habs"  onclick="fnMandals();" /></td> -->
</tr>
<%} 

%>


	<% if(count==0) 
		{%>
		<tr><td  align="center"  colspan=11> No Records </td></tr>
		<%}%>
		

</table>

</table>


	
</fieldlist>
<%-- <table align="center">
<tr>
<td>
 <html:reset property="mode" styleClass="btext" onclick="javascript:init();">
					<bean:message key="button.clear" />
				</html:reset> 
				
				
			
</td>
</tr>
</table> --%>
</table>

	
	<jsp:include page="/commons/TableFotter.jsp">
	
	<jsp:param name="TWidth" value="760"/>
	
	
</jsp:include>

</html:form>
</html:html>

<p align="center">
<font face="verdana" size="2" color="red">
Note: District,Mandal,Panchayat,village,Habitation,Select Source Are Mandatory Fields.</font></p>



<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>

</p>


