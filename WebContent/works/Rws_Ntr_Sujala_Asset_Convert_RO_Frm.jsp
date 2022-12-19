
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
	
	
	
	
		
	if(document.forms[0].assetCode.value=="")
	{
      alert("Asset Code is Not Empty");
      return false;
	}
	if(document.forms[0].assetType.value=="")
	{
      alert("Asset Type is Not Empty");
      return false;
	}
	if(document.forms[0].assetName.value=="")
	{
      alert("Please Enter Asset Name");
      return false;
	}
	if(document.forms[0].location.value=="")
	{
      alert("Please Enter Location");
      return false;
	}
	if(document.forms[0].assetStatus.value=="")
	{
      alert("Please Enter Asset Status");
      return false;
	}
	if(document.forms[0].assetCost.value=="")
	{
      alert("Please Enter Asset Cost");
      return false;
	}
	if(document.forms[0].startYear.value=="")
	{
      alert("Start Year is Not Empty");
      return false;
	}
	if(document.forms[0].dateCreation.value=="")
	{
      alert("Date Of Creation is Not Empty");
      return false;
	}
	if(document.forms[0].sourceCode.value=="")
	{
      alert("Source Code is not Empty");
      return false;
	}
	if(document.forms[0].sourceLocation.value=="")
	{
      alert("Please Enter Source Location");
      return false;
	}
	if(document.forms[0].capacity.value=="")
	{
      alert("Please Enter Capacity");
      return false;
	}
	if(document.forms[0].noofUnits.value=="")
	{
      alert("Please Enter No Of Units");
      return false;
	}
	if(document.forms[0].noOfHoursUsage.value=="")
	{
      alert("Please Enter No Of Hours Usage");
      return false;
	}
	if(document.forms[0].noofStandByUnits.value=="")
	{
      alert("Please Enter No Of Stand By Units");
      return false;
	}
	if(document.forms[0].rawWaterStorageTankExisting.value=="")
	{
      alert("Please Enter raw Water Storage Tank Existing");
      return false;
	}
	if(document.forms[0].productWaterStorageTankExisting.value=="")
	{
      alert("Please Enter Product Water Storage Tank Existing");
      return false;
	}
	if(document.forms[0].shelterExisting.value=="")
	{
      alert("Please Enter Shelter Existing");
      return false;
	}
	if(document.forms[0].compCost.value=="")
	{
      alert("Please Enter Component Cost");
      return false;
	}
	if(document.forms[0].compImage.value!="")
	{
			if(document.forms[0].latitude.value==""){
				alert("Please Enter Latitude");
			      return false;
			}
			if(document.forms[0].longitude.value==""){
				alert("Please Enter Longitude");
			      return false;
			}
	}
		 document.forms[0].action="switch.do?prefix=/works&page=/ntrAssetConvert.do&mode=save";
         document.forms[0].submit();
         
         
		
}

function fngetenable(index)
{
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
function convertToAsset(habCode)
{
		var zURL = "switch.do?prefix=/works&page=/ntrAssetConvert.do&mode=ROConvertToAsset";
		
		var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL,'habs',popFeatures);
		myWin.focus();
	
}
function calcost(){
	
	var cost=parseInt(document.forms[0].compCost.value);
	var assetCost=parseInt(document.forms[0].assetCost.value);
	if(document.forms[0].compCost.value==""){
		cost=0;
	}
	
	document.forms[0].assetCost.value=assetCost+cost;
}
function openFile(){
	
	  var sourceno=document.forms[0].sourceCode.value;
	  var assetcode=document.forms[0].assetCode.value;
	  
	var url="switch.do?prefix=/masters&page=/Asset.do?mode=showCompImage&sourceid="+sourceno+"&assetCode="+assetcode;
	//alert(url);
	var width = 990;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";

	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}

function autocompletion()
{
    
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
</script>

<body  onload="autocompletion()">

<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="ntrAssetConvert.do" enctype="multipart/form-data">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="DONOR - RO Plant Conversion to Asset" />
	<jsp:param name="TWidth" value="900" />
</jsp:include>


<table  style="border-collapse:collapse;"  width="900">
<tr align="left">
<td>
   <fieldset>
   <legend>Asset Details</legend>
   <label>
   <table  border=0  width="500"  align="left"  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="btext2" >Asset&nbsp;Code:<font color="#FF6666">*</font></td>
		<td class="textborder" >
		<html:text property="assetCode"  readonly="true"  /></td>
		<html:hidden property="implDate" />
		<html:hidden property="habCode" />
		<td class="btext2" >Asset&nbsp;Type:<font color="#FF6666">*</font></td>
		<td class="textborder" >
				<html:select property="assetType" styleClass="mycombo" >
							<html:option value="08">OTHERS</html:option>
							
				</html:select></td>
		
		<td class="btext2" >Asset&nbsp;Name:<font color="#FF6666">*</font></td>
		<td class="textborder" >
		<html:text property="assetName"  maxlength="150" onkeypress="upperOnly()" readonly="true"/></td>
		
		</tr>
		
		<tr>
		<td class="btext2" >Location:<font color="#FF6666">*</font></td>
		<td class="textborder" >
		<html:text property="location"  maxlength="25" onkeypress="upperOnly()" readonly="true"/></td>
		
		<td class="btext2" >Asset&nbsp;Status:<font color="#FF6666">*</font></td>
		<td class="textborder" >
				<html:select property="assetStatus" styleClass="mycombo" >
							<html:option value="1">WORKING</html:option>
							<html:option value="2">NOT WORKING</html:option>
							<html:option value="3">DRIED</html:option>
							<html:option value="4">SEASONAL</html:option>
							<html:option value="5">CONDEMED</html:option>
				</html:select></td>
		
			<td class="btext2" >Date&nbsp;Of&nbsp;Creation:<font color="#FF6666">*</font></td>
		<td class="textborder" >
		<html:text property="dateCreation" readonly="true" /></td>
		
		
			</tr>
			<tr>
			<td class="btext2" >Start&nbsp;Year:<font color="#FF6666">*</font></td>
		<td class="textborder" >
		<html:text property="startYear"  readonly="true" /></td>
		
		
		<td class="btext2" >Asset&nbsp;Cost (Rs.&nbsp;in&nbsp;Lakhs):<font color="#FF6666">*</font></td>
		<td class="textborder" >
		<html:text property="assetCost" maxlength="10" onkeypress="return decimalsOnly(event)" readonly="true"/></td>
		
		
		<td class="btext2" >Source Count:<font color="#FF6666">*</font></td>
		<td class="textborder" >
		<html:text property="sourceCount" maxlength="10" onkeypress="return decimalsOnly(event)" readonly="true"/></td>
		
			</tr> 
	
    </table>   
		</label>
	</fieldset>
	</td>
</tr>
<tr align="left">
<td>
   <fieldset>
   <legend>Source Details</legend>
   <label>
   <table  border=0  width="500"  align="left"  style="margin-bottom:0;margin-top:0">
      <tr>
	   <td class="btext2">WTP&nbsp;Code:<font color="#FF6666">*</font></td>
		<td class="textborder"><html:text property="sourceCode"  readonly="true" style="width:150px;" /></td>
		
		<td class="btext2">Location:<font color="#FF6666">*</font></td>
		<td class="textborder"><html:text property="sourceLocation"  /></td>
		
		<td class="btext2" >Capacity(LPH):<font color="#FF6666">*</font></td>
		<td class="textborder"><html:text property="capacity"   onkeypress="return decimalsOnly(event)"/></td> 
		</tr><tr>
		<td class="btext2" >No&nbsp;of&nbsp;Units:<font color="#FF6666">*</font></td>
		<td class="textborder"><html:text property="noofUnits"  onkeypress="return decimalsOnly(event)"/></td>  
		
		<td class="btext2" >No&nbsp;Of&nbsp;Hours&nbsp;Usage:<font color="#FF6666">*</font></td>
		<td class="textborder"><html:text property="noOfHoursUsage"  onkeypress="return decimalsOnly(event)"/></td>
		
		<td class="btext2" >No&nbsp;of&nbsp;Stand&nbsp;By Units:<font color="#FF6666">*</font></td>
		<td class="textborder"><html:text property="noofStandByUnits" onkeypress="return decimalsOnly(event)"/></td>
		</tr><tr>
		<td class="btext2" >Average&nbsp;Cans Supplied per&nbsp;day:<font color="#FF6666">*</font></td>
		<td class="textborder"><html:text property="aveCanSupplied" onkeypress="return decimalsOnly(event)"/></td>
		
		<td class="btext2" >Cost (Rs.&nbsp;in&nbsp;Lakhs):<font color="#FF6666">*</font></td>
		<td class="textborder"><html:text property="compCost" onkeypress="return decimalsOnly(event)"  onkeyup="calcost();" /></td>
		
		<td class="btext2" >Raw&nbsp;Water Storage Tank Existing:<font color="#FF6666">*</font></td>
		<td class="textborder">
				<html:select property="rawWaterStorageTankExisting" styleClass="mycombo" >
							<html:option value="">Select</html:option>
							<html:option value="1">Yes</html:option>
							<html:option value="0">NO</html:option>
				</html:select>
		</td>
		
		
		</tr>
		<tr>
		<td class="btext2" >Product&nbsp;Water Storage Tank&nbsp;Existing:<font color="#FF6666">*</font></td>
		<td class="textborder">
				<html:select property="productWaterStorageTankExisting" styleClass="mycombo" >
							<html:option value="">Select</html:option>
							<html:option value="1">Yes</html:option>
							<html:option value="0">NO</html:option>
				</html:select>
		</td>
		
		<td class="btext2" >Shelter&nbsp;Existing:<font color="#FF6666">*</font></td>
		<td class="textborder">
				<html:select property="shelterExisting" styleClass="mycombo" >
							<html:option value="">Select</html:option>
							<html:option value="1">Yes</html:option>
							<html:option value="0">NO</html:option>
				</html:select>
		</td>
		
		
		
		
		
		<td class="btext2" >Image:<font color="#FF6666">*</font></td>
		<td class="textborder">
		<logic:equal name="NtrAssetConvert" value="No" property="compImageStatus">
		<html:file property="compImage" styleClass="mytext" style="width:150" />
		</logic:equal>
		<logic:equal name="NtrAssetConvert" value="Yes" property="compImageStatus">
		<a href="#" onclick="openFile()">View</a>&nbsp;
		<html:file property="compImage" styleClass="mytext" style="width:150" />
		</logic:equal>
		</td>
		</tr><tr>
		<td class="btext2" >Status:<font color="#FF6666">*</font></td>
		<td class="textborder">
				<html:select property="compStatus" styleClass="mycombo" >
							<html:option value="W">WORKING</html:option>
							<html:option value="N">NOT WORKING</html:option>
							<html:option value="D">DRIED</html:option>
							<html:option value="S">SEASONAL</html:option>
							<html:option value="C">CONDEMED</html:option>
				</html:select>
		</td>
		<td class="btext2" >Latitude-N:</td>
		<td class="textborder"><html:text property="latitude" onkeypress="return decimalsOnly(event)"/></td>
		
		<td class="btext2" >Longitude-E:</td>
		<td class="textborder"><html:text property="longitude" onkeypress="return decimalsOnly(event)"/></td>
		
		</tr><tr>
		<td class="btext2" >Elevation:</td>
		<td class="textborder"><html:text property="elivation" onkeypress="return decimalsOnly(event)"/></td>
		
		<td class="btext2" >Way Point:</td>
		<td class="textborder"><html:text property="wayPoint" onkeypress="return decimalsOnly(event)"/></td>
		
		</tr>
	
    </table>   
		</label>
	</fieldset>
	</td>
</tr>

<tr><td align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext"></td></tr>

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
