<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%int count=0; %>

<%
 String query=null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
         

          String dataDate=(String)session.getAttribute("dataDate1");
%>

<head>
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0"> 
</head>
<script language="JavaScript" src="/pred/resources/javascript/jquery-1.4.2.js"></script>
<style type="text/css">
<!--
/* begin some basic styling here */
.text2bold {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: #338de8; FONT-SIZE: 9px;  TEXT-DECORATION: none
}
.text2bold1 {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: black; FONT-SIZE: 9px; FONT-WEIGHT: bold; TEXT-DECORATION: none
}
body {
background: #FFF;
color: #000;
font: normal normal 10px Verdana, Geneva, Arial, Helvetica, sans-serif;


}
table, td, a {
font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif
}
div#tbl-container22 {
width: 1100px;
height: 400px;
overflow: auto;
scrollbar-base-color:#C9C299;
}
div#tbl-container22 tr.normalRow td {
background: #fff;
font-size: 11px;
height: 28px;
}
div#tbl-container22 tr.alternateRow td {
background: #B6C9AD;

font-size: 8px;.
height: 21px;
}
div#tbl-container22 table {
table-layout: fixed;
border-collapse: collapse;
background-color: WhiteSmoke;
}
div#tbl-container22 table th {
height: 40px;


}
div#tbl-container22 thead th, div#tbl-container22 thead th.locked {
font-size: 10px;
font-weight: bold;
text-align: center;
background-color: #DEE3E0;
color: black;
position:relative;
cursor: default; 
}
div#tbl-container22 thead th {
top: expression(document.getElementById("tbl-container22").scrollTop-2); /* IE5+ only */
z-index: 10;
}
div#tbl-container22 thead th.locked {z-index: 30;}
div#tbl-container22 td.locked, div#tbl-container22 th.locked{
background-color: #ffeaff;
font-weight: bold;
left: expression(document.getElementById("tbl-container22").scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;

}     
-->
</style>
<script>


</script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<html:form action="TransportWaterDetail.do">
<body  onload="autocompletion()">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);

		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Transportation of drinking Water entry" />
		<jsp:param name="TWidth" value="100%"/>
		
	</jsp:include>
</td></tr></thead>
<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>
<tbody>
<tr><td></td>
</tr>
<tr>
<td>

<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	
<tr>
	<td class="mycborder">
		<fieldset>
			<legend></legend>
			<label>
<table  border=0  width="1100" >
<tr>
 	<td class="textborder"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="80">
		<html:select property="district" styleClass="mycombo" style="width:150px" onchange="javascript:fnDivisions()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
	</td>



<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Division&nbsp;&nbsp;<font color="red">*</font></font>&nbsp;&nbsp;</td>
		<td class="textborder">
	<html:select property="division" styleClass="mycombo" style="width:150px" onchange="javascript:fnMandals()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="divisions">
		<html:options collection="divisions" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
</td>


	<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Mandal&nbsp;&nbsp;</font></td>
		<td class="textborder">
		<html:select property="mandal" styleClass="mycombo" style="width:150px" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="mandals">
		<html:options collection="mandals" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
</td>
	<td class=mycborder>
		<td width="10" ><font face=verdana size=2><b>Date</b><font color="red">*</font></td>
		<td width="200"><html:text property="currentDate"   readonly="false" onchange="javascript:DateChanged()"/>
		<a href="javascript: showCalendarFuture(document.forms[0].elements['currentDate'])">
						<img src="/pred/resources/images/calendar.gif" 
							 border="0" align="absmiddle">
					</a></td>
<td>
<input type=button value="Get Data" onclick="getHabs()">
</td>	

<td width="200"></td>
				</tr>

	
	
<tr></table>	
</label>
		</fieldset>
	</td>
</tr>

</table>

			<tr>
			<td>
			<div id="tbl-container22">
			<table   width="100%" bgcolor="#ffffff" cellpadding="0" cellspacing="1" 
			border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
			<table  id="tbl" width="100%" bgcolor="#ffffff" cellpadding="0" cellspacing="1" 
			border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					<thead class="fixedHeader">
			<tr class="clrborder">
				<th class="locked" align="center" rowspan="2" width="30">Select</th>
				<th class="locked" align="center" rowspan="2" width="50">Delete</th>

			<th class="locked" align="center" rowspan="2" width="30" >S.No.</th>

			<th class="locked" align="center" rowspan="2" width="120" >Hab Code</th>
			<th class="locked" align="center"  rowspan="2" width="150" >Hab Name </th>
			<th class="clrborder" align="center" width="300"colspan="7">Transport </th>
			<th class="clrborder" align="center" width="300"colspan="7">Cattle </th>
			<th class="clrborder" align="center" width="600" colspan="6">Private Sources </th>
			<th class="clrborder" align="center" width="250" colspan="2">Power Supply </th>
			</tr>
			<tr>
			<th class="clrborder" align="center" width="50">Population Served</th>
			<th class="clrborder" align="center"width="50" >Tanker Capaacity(KL)</th>
			<th class="clrborder" align="center" width="50">No.of Trips </th>
			<th class="clrborder" align="center" width="50">Quantity(KL) </th>
			<th class="clrborder" align="center" width="50">Cost Per Trip</th>
			<th class="clrborder" align="center" width="50">Total Cost </th>
			<th class="clrborder" align="center" width="50">Remarks</th>
			
			<th class="clrborder" align="center" width="50">Population Served</th>
			<th class="clrborder" align="center"width="50" >Tanker Capaacity(KL)</th>
			<th class="clrborder" align="center" width="50">No.of Trips </th>
			<th class="clrborder" align="center" width="50">Quantity(KL) </th>
			<th class="clrborder" align="center" width="50">Cost Per Trip</th>
			<th class="clrborder" align="center" width="50">Total Cost </th>
			<th class="clrborder" align="center" width="50">Remarks</th>
			
			<th class="clrborder" align="center" width="50">Population Served </th>
			<th class="clrborder" align="center" width="130">Type</th>
			<th class="clrborder" align="center" width="50">No.of PriviteSources Hired</th>
			<th class="clrborder" align="center" width="150">Mode of Supply from hired Sources</th>
			<th class="clrborder" align="center" width="50">Quantity Supplied(KL)</th>
			<th class="clrborder" align="center" width="50">Remarks</th>
			<th class="clrborder" align="center" width="120">Irregular power<br>Supply</th>
			<th class="clrborder" align="center" width="120">Remarks</th>
			</tr>

			
					   
							  
<!-- End of  Details -->

<% int i=0;
%>

<logic:iterate id="item" name="transportDetails">
	<% 
	i=i+1;
%>
	<tr onmouseover="Tip('<%= dataDate %> Daily Transport Data ',TITLE,'Information')" onmouseout="UnTip()">
<td   class="locked" align="center" nowrap width="30">	<html:checkbox name="item" property="checks"   indexed="true" />

<td class="locked" align="center" nowrap><img src="/pred/resources/images/deleteButton2.png" onclick="javascript:fnDelete(<%=i-1 %>)"  onmouseover="Tip('<%= dataDate %> Daily Transport Data ',TITLE,'Information')" onmouseout="UnTip()"/></td>
	<td class="locked" align="center" nowrap><%=i%></td>
	

	<td   class="locked" class="bwborder" align="center"  height="30" nowrap width="120"><bean:write
		name="item" property="habCode"  />
<html:text name="item" maxlength="5" property="habCode" styleClass="gridtext" style="width:0px"
						  indexed="true"    onkeypress="return decimalsOnly(event)" readonly="false" disabled="true" />


</td>
	<td  class="locked" class="bwborder" nowrap width="150" height="30"><font color="#000000" face=verdana size=1><bean:write name="item" property="habName"/></td>
<td class="bwborder" align="center" nowrap>
 <html:text name="item" maxlength="5" property="transportPopulationServed" styleClass="gridtext" style="width:50px"
						  indexed="true"    onkeypress="return decimalsOnly(event)" readonly="false"/>
	
		</td>
<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="8" property="tanker_Capacity" indexed="true"   style="width:70px" styleClass="gridtext" 
								   onkeyup="addTankerQuantityValue();" onkeypress="return decimalsOnly(event)" /></td>
		<td class="bwborder" align="center" nowrap><html:text name="item" maxlength="5" property="noOfTrips"  indexed="true"  style="width:70px"  styleClass="gridtext" 
								   onkeyup="addTankerQuantityValue();" onkeypress="return decimalsOnly(event)"/></td>
								   

<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="9"  property="tanker_QTY"  style="width:70px" styleClass="readonlyfield"  indexed="true" /></td>
<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="9" property="tankerCostPerTrip"  style="width:70px" styleClass="gridtext"  indexed="true" /></td>
<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="9" property="tankerCost"  style="width:70px" styleClass="gridtext"  indexed="true" /></td>
<td class="bwborder" align="center" nowrap width="50"><html:text name="item" property="tanker_Remarks"  style="width:70px" styleClass="gridtext"  indexed="true" /></td>

<td class="bwborder" align="center" nowrap>
 <html:text name="item" maxlength="5" property="cattle_transportPopulationServed" styleClass="gridtext" style="width:50px"
						  indexed="true"    onkeypress="return decimalsOnly(event)" readonly="false"/>
	
		</td>
<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="8" property="cattle_tanker_Capacity" indexed="true"   style="width:70px" styleClass="gridtext" 
								   onkeyup="addCattleTankerQuantityValue()" onkeypress="return decimalsOnly(event)" /></td>
		<td class="bwborder" align="center" nowrap><html:text name="item" maxlength="5" property="cattle_noOfTrips"  indexed="true"  style="width:70px"  styleClass="gridtext" 
								  onkeyup="addCattleTankerQuantityValue()" onkeypress="return decimalsOnly(event)"/></td>

<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="9" property="cattle_tanker_QTY"  style="width:70px" styleClass="readonlyfield"  indexed="true" /></td>
<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="9" property="cattle_tankerCostPerTrip"  style="width:70px" styleClass="gridtext"  indexed="true" /></td>
<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="9" property="cattle_tankerCost"  style="width:70px" styleClass="gridtext"  indexed="true" /></td>
<td class="bwborder" align="center" nowrap width="50"><html:text name="item" property="cattle_tanker_Remarks"  style="width:70px" styleClass="gridtext"  indexed="true" /></td>

<td class="bwborder" align="center" nowrap  width="50">
 <html:text name="item" property="hiringPopulationServed" styleClass="gridtext" style="width:50px"
						  indexed="true"    onkeypress="return decimalsOnly(event)" readonly="false"/>
	
		</td>

<td class="bwborder" align="center" nowrap width="100">
							<html:select  name="item"  property="assetType"  style="width:100px" indexed="true"  >
							<html:option value="BW">BW</html:option>
							<html:option value="OW">OW</html:option>
						  <html:option value="BW & OW">BW & OW</html:option>
							<html:option value="Ot">Others</html:option>
							
							</html:select>
							
							
						</td>

<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="3" indexed="true" property="pvtSourceHiredNo"  style="width:95px"  styleClass="gridtext" 
								   onkeypress="return decimalsOnly(event)"/></td>
<td class="bwborder" align="center" nowrap width="130" >
							<html:select  name="item"  property="pvtModeOfSupply"  style="width:100px" indexed="true" >
							<html:option value="None">None</html:option>
							<html:option value="Existing scheme">Existing scheme</html:option>
							<html:option value="Extension">Extension</html:option>
							<html:option value="at spot">at spot</html:option>
							
							</html:select>
							
							
						</td>
<td class="bwborder" align="center" nowrap width="50"><html:text name="item" maxlength="11" indexed="true" property="pvtSourceQTY"  style="width:70px"  styleClass="gridtext" 
								   onkeypress="return decimalsOnly(event)"/></td>

						<td class="bwborder" align="center" nowrap width="50"><html:text name ="item" property="pvtRemarks"  style="width:70px" styleClass="gridtext" indexed="true" /></td>

<td class="bwborder" align="center" nowrap width="130">
							<html:select  name="item"  property="powerProblemType"  style="width:130px" indexed="true" >
							<html:option value="">-Select-</html:option>
							<html:option value="Low voltage">Low voltage</html:option>
							<html:option value="Insufficient Power">Insufficient Power</html:option>
							<html:option value="OTHERS">Others</html:option>
							
							</html:select>
							
							
						</td>
<td class="bwborder" align="center" nowrap width="130"><html:text name="item" property="powerSupplyRemarks"  style="width:100px" styleClass="gridtext"  indexed="true" /></td>
	</tr>
  </logic:iterate>
		<%if(i==0){ %>
								<tr><td colspan="20" align="center">No Records</td></tr>
							<%} %>


<tr>

</table>

</td></tr></tbody>
</div>
<tr></tr>
<tr><td align="center">


<input type="button" class="btext" name="save" value="Save" onclick="fixvalue()">&nbsp;&nbsp;&nbsp;</td>

<input type="hidden" name="resultCount" value="<%=i%>">
</tr></table>
</table>
</body>
</html:form>
<script language="javascript">
<%
if(session.getAttribute("message")!=null)
{
%>
alert('<%=session.getAttribute("message")%>');
<%}%>


</script>
<center>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


</center>

<script LANGUAGE="JavaScript">
function getData()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=get";
	document.forms[0].submit();
}
function getHabs()
{

 if(document.forms[0].elements['district'].value=="")
{
 alert("Please select Circle");
return;
}else if(document.forms[0].elements['division'].value=="")
{
 alert("Please select Division");
return ;
     
}
else if(document.forms[0].elements['currentDate'].value=="")
{
 alert("Please select Date");
return ;
     
}
	document.forms[0].action="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=get2";
	document.forms[0].submit();
}
function fixvalue(){
	var len=document.forms[0].resultCount.value;
	
	len = len-1;
	var re=new RegExp("^[1-9][0-9](\.[0-9][0-9]?)?$|^[0-9](\.[0-9][0-9]?)?$");
	  for(j=0;j<=len;j++){
		  var tanker_Capacity=document.getElementById("item["+j+"].tanker_Capacity").value;
		  var cattle_tanker_Capacity=document.getElementById("item["+j+"].cattle_tanker_Capacity").value;
		  
	   if(!re.test(tanker_Capacity) || !re.test(cattle_tanker_Capacity) ){
	 
        alert("Please enter Tanker Capacity in KL. Accept from (0.0 to 99.99)");
        
        return;
        
	   	}
	   }
	  	document.forms[0].action="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=save";
		document.forms[0].submit();
	   
	  
}

function fnSave()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=save";
	 document.forms[0].submit();
	
}

function fnDivisions()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=divisions";
	 document.forms[0].submit();
	
}
function fnMandals()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=mandals";
	 document.forms[0].submit();

}
function fnDelete(count)
{

 var habCode=document.forms[0].elements['item["+count+"].habCode'].value;
 var value=confirm("Are you sure want to delete this  <%=dataDate %>   Habitation");
 if(value==true){
	document.forms[0].action="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=delete&habCode="+habCode;
	document.forms[0].submit();
 
}
	
}
function fnChange(count)
{
 
   
}
function addNewRecord()
{
			document.forms[0].action="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=addNew";
			document.forms[0].submit();
		
}
function DateChanged()
{

alert("changing");
			document.forms[0].action="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=get2";
			document.forms[0].submit();

}
function readCookie(name) {

	var nameEQ;
	if(name==null)
	return "";
	else
	{
	nameEQ= name + "=";
	var ca = document.cookie.split(';');
	
	
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	}
	return null;
}

function eraseCookie(name) {
	createCookie(name,"",-1);
}
function addTankerQuantityValue(){
	var len=document.forms[0].resultCount.value;
		len = len-1;
		var tankerQunatity=0;
		for(j=0;j<=len;j++){
			
			var tanker_Capacity=parseFloat(document.forms[0].elements["item["+j+"].tanker_Capacity"].value);
			var noOfTrips=parseFloat(document.forms[0].elements["item["+j+"].noOfTrips"].value);
			
			if(tanker_Capacity!=0 && noOfTrips!=0)
			{
				
				tankerQunatity=tanker_Capacity*noOfTrips;
				
			}
			else{
				tankerQunatity=0;
				}
				
			document.forms[0].elements["item["+j+"].tanker_QTY"].value=tankerQunatity;
		}
	}
	function addCattleTankerQuantityValue(){
		var len=document.forms[0].resultCount.value;
			len = len-1;
			var CattletankerQunatity=0;
			for(j=0;j<=len;j++){
				
				var cattle_tanker_Capacity=parseFloat(document.forms[0].elements["item["+j+"].cattle_tanker_Capacity"].value);
				var cattle_noOfTrips=parseFloat(document.forms[0].elements["item["+j+"].cattle_noOfTrips"].value);
				if(cattle_tanker_Capacity!=0 && cattle_noOfTrips!=0)
				{
					
					CattletankerQunatity=cattle_tanker_Capacity*cattle_noOfTrips;
					
				}
				else{
					CattletankerQunatity=0;
					}
					
				document.forms[0].elements["item["+j+"].cattle_tanker_QTY"].value=CattletankerQunatity;
			}
		}


	function autocompletion()
	 {
	 	 for (i=0; i<document.forms.length; i++) {
	         document.forms[i].setAttribute("AutoComplete","off");
	        }
	 }
	
</script>



