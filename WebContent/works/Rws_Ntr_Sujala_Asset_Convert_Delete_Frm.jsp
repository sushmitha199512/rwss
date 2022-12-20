
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
    //alert("hai");
	document.forms[0].action="switch.do?prefix=/works&page=/ntrAssetConvert.do?mode=mandals";
	document.forms[0].submit();  
     
	
} 

function getYears()
{
    //alert("hai");
	document.forms[0].action="switch.do?prefix=/works&page=/ntrAssetConvert.do?mode=years";
	document.forms[0].submit();  
     
	
} 
function init()
{
 
	document.forms[0].action="switch.do?prefix=/works&page=/ntrAssetConvert.do?mode=init";
	document.forms[0].submit();
    
     
} 


function getData()
{

	//alert("hai");
	var ccode=document.forms[0].circleCode.value;
	var mcode=document.forms[0].mandal.value;
	
	var year=document.forms[0].year.value;
	
	if(ccode=="" || mcode=="" || year=="")
		{
		  alert("Please Select Mandatory Data");
		  return false;
		}
	else
		{
			document.forms[0].action="switch.do?prefix=/works&page=/ntrAssetConvert.do?mode=habList";
			document.forms[0].submit();
		}
	
}


function fnSave()
{    
	 var habitations1="";
	 var len=document.forms[0].resultCount.value;
	 var mydate=document.forms[0].currentDate.value
	 len = len-1;
	// alert("saving"+mydate+len);
	 var checkcnt=0;
	 
	 
	 
	 for( var j=0;j<len;j++)
	 {
		 //alert(habitations1);
		 if(document.getElementById("habList["+j+"].checks").checked==true)
		{
			habitations1=habitations1+document.getElementById("habList["+j+"].habCode").value;
			/* habitations1=habitations1+"@"+document.getElementById("habList["+j+"].habName").value;
			habitations1=habitations1+"@"+document.getElementById("habList["+j+"].habPop").value;
			 */habitations1=habitations1+"@"+document.getElementById("habList["+j+"].plantType").value;
			habitations1=habitations1+"@"+document.getElementById("habList["+j+"].plantCapacity").value;
			habitations1=habitations1+"@"+document.getElementById("habList["+j+"].agencyType").value;
			habitations1=habitations1+"@"+document.getElementById("habList["+j+"].instAgencyName").value;
			habitations1=habitations1+"@"+document.getElementById("habList["+j+"].maintenanceType").value;
			habitations1=habitations1+"@"+document.getElementById("habList["+j+"].mainAgencyname").value;
			//habitations1=habitations1+"@"+document.getElementById("habList["+j+"].currentDate").value;
			habitations1=habitations1+"@";
			//alert(habitations1);
			checkcnt++;
			
			
			if(document.getElementById("habList["+j+"].plantType").value=="")
			{
              alert("Please Select Plant Type");
              return;
			}
			 else if(document.getElementById("habList["+j+"].plantCapacity").value=="")
			{
               alert("Please Enter Plant Capacity");
               return;
			} 
			else if(document.getElementById("habList["+j+"].agencyType").value=="")
				{
	               alert("Please Select Installation Agency Type");
	               return;
				} 
			else if(document.getElementById("habList["+j+"].instAgencyName").value=="")
			{
               alert("Please Enter Installation Agency Name");
               return;
			} 
			else if(document.getElementById("habList["+j+"].maintenanceType").value=="")
			{
               alert("Please Select Maintenance Type");
               return;
			} 
			
			else if(document.getElementById("habList["+j+"].mainAgencyname").value=="")
			{
               alert("Please Enter Maintanence Agency Name");
               return;
			} 
			
		}
		 
	}
	habitations1=habitations1+"D,";
	
	//alert(habitations1);
	
	  if(habitations1=="")
	   {
		 alert("Select atleast one check box to save");
       }
	  else
	  {	  
		  
	     if(mydate=="")
	    	 {
	    	    alert("Select Implementation Date to  save");
	    	 }
	    else
			  {
			     if(confirm("Are You Sure To Save The Checked Habitation(s)")) 
			     {
					  document.forms[0].hab1.value = habitations1;
			          document.forms[0].action="switch.do?prefix=/works&page=/ntrAssetConvert.do&mode=save";
		              document.forms[0].submit();
				}
			  }
	  }
}

function fngetenable(index)
{
	//alert("yes");
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
function convertToAsset(habCode,implDate,typeOfplant)
{
	//alert("hi");
	//alert(habCode);
		var zURL = "switch.do?prefix=/works&page=/ntrAssetConvert.do&mode=ROConvertToAsset&habCode="+habCode+"&implDate="+implDate+"&typeOfplant="+typeOfplant;
		
		var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL,'habs',popFeatures);
		myWin.focus();
	
}
function convertToAssetEdit(habCode,implDate,typeOfplant)
{
	//alert(habCode);
		var zURL = "switch.do?prefix=/works&page=/ntrAssetConvert.do&mode=ROConvertToAssetEdit&habCode="+habCode+"&implDate="+implDate+"&typeOfplant="+typeOfplant;;
		
		var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL,'habs',popFeatures);
		myWin.focus();
	
}
</script>

<body>

<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="ntrAssetConvert.do">



<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="DONOR - RO Plant Conversion to Asset" />
	<jsp:param name="TWidth" value="900" />
</jsp:include>


<table  style="border-collapse:collapse;"  width="900">
<tr align="left">
<td>
   <fieldset>
   <legend>Office Details</legend>
   <label>
   <table  border=0  width="500"  align="left"  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="btext2" width="100">District<font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="circleCode" styleClass="mycombo" style="width:130px" onchange="javascript:getMandals()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="circles">
		<html:options collection="circles" name="rwsLocationBean" property="value" labelProperty="label" />
		</logic:present >
		</html:select>
		</td>
		<td class="btext2" width="100">Mandal<font color="#FF6666">*</font></td>
		
			<td class="bwborder" >
				<html:select property="mandal" styleClass="mycombo" style="width:140px" onchange="javascript:getYears()" >
				<html:option value="">SELECT...</html:option>
				<logic:notEmpty name="mandals">
				<html:options collection="mandals" name="labelValueBean"  property="value" labelProperty="label" />
				</logic:notEmpty>
				</html:select></td>
				
		<td class="btext2" width="100">Implementation Year<font color="#FF6666">*</font></td>
		
			<td class="bwborder" >
				<html:select property="year" styleClass="mycombo" style="width:140px">
				<html:option value="">SELECT...</html:option>
				<logic:notEmpty name="years">
				<html:options collection="years" name="labelValueBean"  property="value" labelProperty="value" />
				</logic:notEmpty>
				</html:select></td>
		<td class="btext2">
		<%-- <td class="btext2" width="10" >Implementation Year<font color="#FF6666">*</font></td>
		<td width="50"><html:text property="year"   readonly="false"  size="10" />
		<a href="javascript: showCalendarFuture(document.forms[0].elements['currentDate'])">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle" >
					</a></td> --%>
			<td class="btext2"></td><td class="btext2">&nbsp;&nbsp;<input type="button" name="saveButton" value="GetData" onclick="javascript:getData()"></td>		
		</tr>
	
    </table>   
		</label>
	</fieldset>
	</td>
</tr>


<tr>
<td>
   <fieldset>
   <legend>Habitation & Sponsor Details to Convert Asset</legend>
   <label>
   
<table  border=1  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
    
<tr align="center"  class="btext2">
     
     <td>SlNo</td>
     <td>District/<br>Mandal/<br>Panchayat/<br>Village</td>
     <td>Habitation Code/<br>Habitation Name</td>
     <td>Type of Plant Installed/<br>Implementation Year</td>
     <td>Asset Code</td> 
     <td>Source Code/<br>Location</td> 
</tr>

<tr align="center"  class="btext2">
<%
for(int k=1;k<10;k++)
{
%>
<td > <%=k %>  </td>


<%} %>

</tr>
 <%
  int count=1;
 %>
   
	<logic:notEmpty name="NtrAssetConvert" property="habList">
	<nested:iterate id="habList" name="NtrAssetConvert" property="habList" indexId="ndx">
	
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
	   <%--  <td  class="rptValue"><html:checkbox name="habList" property="checks"   indexed="true"  /></td> --%>
		<td class="rptValue"><%=count++%></td>		
	    <td  class="rptValue" ><bean:write name="habList" property="habCode" />/<br><bean:write name="habList" property="habName" />/<br><bean:write name="habList" property="habPop" />/<br><bean:write name="habList" property="habstatus" /></td>
	    <nested:hidden name="habList" property="habCode"  indexed="true"/>
	    <nested:hidden name="habList" property="implDate"  indexed="true"/>
	    <td  class="rptValue"> <bean:write name="habList" property="plantType" /></td>
	    <td  class="rptValue"> <bean:write name="habList" property="plantCapacity" /></td>
	   <td  class="rptValue"> <bean:write name="habList" property="agencyType" /></td>
	   <td  class="rptValue"> <bean:write name="habList" property="instAgencyName" /></td>
	   <td  class="rptValue"> <bean:write name="habList" property="maintenanceType" /></td>
	   <td  class="rptValue"> <bean:write name="habList" property="mainAgencyName" /></td>
	   <td  class="rptValue">
	    <logic:equal value="Y" property="convStatus" name="habList">
	     <input type=button value="....." id="sBtn"  onclick="convertToAsset('<bean:write name="habList" property="habCode" />','<bean:write name="habList" property="implDate" />','<bean:write name="habList" property="splantType" />')" >
	        </logic:equal>
	    <logic:equal value="N"  property="convStatus" name="habList">
	    Converted
	    <input type=button value="....." id="sBtn"  onclick="convertToAssetEdit('<bean:write name="habList" property="habCode" />','<bean:write name="habList" property="implDate" />','<bean:write name="habList" property="splantType" />')" >
	        </logic:equal>
	        </td>
	 </tr>
 </nested:iterate>
 </logic:notEmpty>
 <%-- <%if(count==1)
		{
		%><tr><td colspan="10" align="center" class="btext">No Records</td></tr><%}
		else{%><tr><td colspan="10" align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext"></td></tr><%}%>
		<input type="hidden" name="resultCount" value="<%=count%>"/> --%>
<input type=hidden name=hab1>
  
</table>
</label>
</fieldset>
</td>
</tr>


<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="900"/>
</jsp:include>
</table>   

</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
