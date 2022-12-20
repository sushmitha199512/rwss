
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<style>
.readonlyfield {
	background-color: #EEEEEE !important;
}
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt;
	
}

.btext1 {
	text-transform: uppercase;
	color: green;
}
.btext3 {
	color: red;
	font-weight: bold;
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
.thumbnail{
position: relative;
z-index: 0;
}

.thumbnail:hover{
background-color: transparent;
z-index: 60;
}

.thumbnail span{ /*CSS for enlarged image*/
position: absolute;
background-color: lightyellow;
padding: 6px;
left: -1000px;
border: 1px dashed gray;
visibility: hidden;
color: black;
text-decoration: none;
}

.thumbnail span img{ /*CSS for enlarged image*/
border-width: 0;
padding: 2px;
}

.thumbnail:hover span{ /*CSS for enlarged image on hover*/
visibility: visible;
top: -120px;
left: 60px; /*position where enlarged image should offset horizontally */

}
</STYLE>
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<head>

<script language="javascript">
function autocompletion()
{
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
function getData(key){
	
	//document.forms[0].action="switch.do?prefix=/masters&page=/FuncRepair.do&mode=data&modeType=mandals";
	document.forms[0].action="switch.do?prefix=/masters&page=/FuncRepair.do&mode=data&type="+key;	
	document.forms[0].submit();
}
function fnSave(){
	var dcode=document.forms[0].dcode.value;
	var mcode=document.forms[0].mcode.value;
	var asttype=document.forms[0].asttype.value;
	var astComp=document.forms[0].astComp.value;
	var astSubComp=document.forms[0].astSubComp.value;
	var souType=document.forms[0].souType.value;
	var vcode=document.forms[0].vcode.value;
	var panchayat=document.forms[0].panchayat.value;
	
	if(dcode==null || dcode==""){
		alert("Please select district");
		return false;
	}
	if(asttype==null ||asttype==""){
		alert("please select asset type");
		return false;
	}
	else{
	if(asttype==09 || asttype==02|| asttype==01){
		if(mcode==null || mcode==""){
			alert("please select mandal");
			return false;
		}
		if(panchayat==null || panchayat==""){
			alert("please select village");
			return false;
		}		
		if(vcode==null || vcode==""){
			alert("please select village");
			return false;
		}
		if(astComp==null ||astComp==""){
			alert("please select asset Component Type");
			return false;
		}
		
		if(astSubComp==null ||astSubComp==""){
			alert("please select asset Subcomponent Type");
			return false;
		}
		if(astComp=='01'){
			if(souType==null ||souType==""){
				alert("please select Source Type");
				return false;
			}
		}	
	}
	if(asttype=="03"){		
		if(astSubComp==null ||astSubComp==""){
			alert("please select asset Subcomponent");
			return false;
		}
	}
	}
	document.forms[0].action="switch.do?prefix=/masters&page=/FuncRepair.do&mode=submit";	
	document.forms[0].submit();
	
}
function fnUpdate(){
	//alert("hello");
	var length= document.FunctionalRepair.resultCount.value;
	length= length-1;
	var flag=false;
//	alert("length"+length);
	for(var k=0;k<length;k++)
	{	
	//alert(document.forms[0].elements["sources["+k+"].checks"].checked);
		if(document.forms[0].elements["sources["+k+"].checks"].checked)
	 {		
			flag=true;
			/* var assetCode=document.forms[0].elements["sources["+k+"].assetCode"].value;
			var compCode=document.forms[0].elements["sources["+k+"].compCode"].value; */
			
			var inspectedBy=document.forms[0].elements["sources["+k+"].inspectedBy"].value;
		
			if(inspectedBy==null ||inspectedBy==""){
				alert("Please select Inspected By for Record No: "+(k+1));
				return;
			} 
			var status=document.forms[0].elements["sources["+k+"].status"].value;
			if(status==''){
				alert("Please Select Status for Record No: "+(k+1));
				return;
			}			
			var notfunctional=document.forms[0].elements["sources["+k+"].notFunctionalStatus"].value;
			if(status=='N' && (notfunctional==null ||notfunctional=="")){
				alert("Please Not Funtional Satus for Record No: "+(k+1));
				return;
			}
			if((status=='N' && notfunctional=='P') || status=='W' || status=='C'){	
			}else{
				var rc=document.forms[0].elements["sources["+k+"].compRepairCode"].value;
				if(rc==null ||rc==""){
					alert("Please select Repair Type for Record No: "+(k+1));
					return;
				}
				var rd=document.forms[0].elements["sources["+k+"].compRepairdate"].value;
				if(rd==null ||rd==""){
					alert("Please select Repair date for Record No: "+(k+1));
					return;
				} 
				var rt=parseFloat(document.forms[0].elements["sources["+k+"].compRepairCost"].value);
				if(rt==null ||rt==""){
					alert("Please enter Repair Cost for Record No: "+(k+1));
					return;
				} 
			} 		
	}	//end if
	}//for loop
	if(!flag){
		 alert("Please Select Check Box For Save The Record");
		 return;
	}else{
		document.forms[0].action="switch.do?prefix=/masters&page=/FuncRepair.do&mode=save";	
		document.forms[0].submit();
	}	
}
function changeColor(o){
    o.style.backgroundColor=(o.style.backgroundColor=='e0ffff')?('e0ffff'):('transparent');
}

function AstSubCompShow(){
	var asttype=document.forms[0].asttype.value;
	if(asttype=='01' || asttype=='02'||asttype=='03'||asttype=='09'){
		document.getElementById('show').style.display='block';
		document.getElementById('show1').style.display='block';
		document.getElementById('show2').style.display='block';
		document.getElementById('show3').style.display='block';
	}
	else if(asttype==null || asttype==''){
		document.getElementById('show').style.display='none';
		document.getElementById('show1').style.display='none';
		document.getElementById('show2').style.display='none';
		document.getElementById('show3').style.display='none';
	}
	else{
		document.getElementById('show').style.display='none';
		document.getElementById('show1').style.display='none';
		document.getElementById('show2').style.display='none';
		document.getElementById('show3').style.display='none';
	}		
}

function AstSouSubCompShow(){
	var astSubComp=document.forms[0].astComp.value;
	var asttype=document.forms[0].asttype.value;
	if(astSubComp=='01' && (asttype=='01' || asttype=='02'||asttype=='03'||asttype=='09')){
		document.getElementById('showSource').style.display='block';
		document.getElementById('showSource1').style.display='block';
		}
	else if(astSubComp==null || astSubComp=='' || asttype==null || asttype==''){
		document.getElementById('showSource').style.display='none';
		document.getElementById('showSource1').style.display='none';
		}
	else{
		document.getElementById('showSource').style.display='none';
		document.getElementById('showSource1').style.display='none';
		}	
}
function notFunctionalStatus(k){	
	if(document.forms[0].elements["sources["+k+"].status"].value=='N'){
		document.forms[0].elements["sources["+k+"].notFunctionalStatus"].disabled=false;		
		document.forms[0].elements["sources["+k+"].alterArangmts"].disabled=false;		
	}else{
		document.forms[0].elements["sources["+k+"].notFunctionalStatus"].disabled=true;		
		document.forms[0].elements["sources["+k+"].alterArangmts"].disabled=true;	
	}
}
function notFunctionalStatusLoad(){
	var length= document.FunctionalRepair.resultCount.value;
	length= length-1;	
	var flag=false;
	for(var k=0;k<length;k++)
	{		
		if(document.forms[0].elements["sources["+k+"].status"].value=='N'){
			document.forms[0].elements["sources["+k+"].notFunctionalStatus"].disabled=false;
			document.forms[0].elements["sources["+k+"].alterArangmts"].disabled=false;	
		}else{
			document.forms[0].elements["sources["+k+"].notFunctionalStatus"].disabled=true;		
			document.forms[0].elements["sources["+k+"].alterArangmts"].disabled=true;	
		}
		if(document.forms[0].elements["sources["+k+"].status"].value=='N' && document.forms[0].elements["sources["+k+"].notFunctionalStatus"].value=='P'  ){
			document.forms[0].elements["sources["+k+"].compRepairCode"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairdate"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairCost"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairCode"].value='';
			document.forms[0].elements["sources["+k+"].compRepairdate"].value='';
			document.forms[0].elements["sources["+k+"].compRepairCost"].value=0;
		}else if(document.forms[0].elements["sources["+k+"].status"].value=='W' || document.forms[0].elements["sources["+k+"].status"].value=='C'){	
			document.forms[0].elements["sources["+k+"].compRepairCode"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairdate"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairCost"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairCode"].value='';
			document.forms[0].elements["sources["+k+"].compRepairdate"].value='';
			document.forms[0].elements["sources["+k+"].compRepairCost"].value=0;			
		}
	}
}

function disableRepairs(k){	
	 if(document.forms[0].elements["sources["+k+"].status"].value=='N' && document.forms[0].elements["sources["+k+"].notFunctionalStatus"].value=='P' ){
			document.forms[0].elements["sources["+k+"].compRepairCode"].disabled=true;		
			document.forms[0].elements["sources["+k+"].compRepairdate"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairCost"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairCode"].value='';
			document.forms[0].elements["sources["+k+"].compRepairdate"].value='';
			document.forms[0].elements["sources["+k+"].compRepairCost"].value=0;			
		}else if(document.forms[0].elements["sources["+k+"].status"].value=='W' || document.forms[0].elements["sources["+k+"].status"].value=='C'){	
			document.forms[0].elements["sources["+k+"].compRepairCode"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairdate"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairCost"].disabled=true;
			document.forms[0].elements["sources["+k+"].compRepairCode"].value='';
			document.forms[0].elements["sources["+k+"].compRepairdate"].value='';
			document.forms[0].elements["sources["+k+"].compRepairCost"].value=0;			
		}else{		
			document.forms[0].elements["sources["+k+"].compRepairCode"].disabled=false;
			document.forms[0].elements["sources["+k+"].compRepairdate"].disabled=false;
			document.forms[0].elements["sources["+k+"].compRepairCost"].disabled=false;
		} 
}
</script>
</head>
	<body onload="autocompletion();AstSubCompShow();AstSouSubCompShow();notFunctionalStatusLoad();">	
		<html:form  method="post" action="/FuncRepair.do">
			<table align="center" cellpadding="0" cellspacing="0" border=0 >
			<thead>
			<tr>
			<td>
			<jsp:include page="/commons/TableHeader.jsp">
				<jsp:param name="TableName" value="Functional Status of Assets" />
				<jsp:param name="TWidth" value="1115"/>
			</jsp:include>
			</td>
			</tr>
			</thead>
			<tbody>
<tr>
<td>

<table bgcolor="" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="1135" >
<tr>
<td>
	<fieldset>
		<legend><bean:message key="legend.rwsOffices"/></legend>
		<label>
			<table  width="1135" border=0 style="border-collapse: collapse;" align="center">
			<tr>
				<td class="btext2">District<span class="mandatory">*</span></td>
				<td class="btext2">
				<html:select property="dcode" style="width:140px;height:20px"   onchange="javascript:getData('mandals');" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:present name="districts">
					<html:options collection="districts"  property="circleCode" labelProperty="circleName" />
			        </logic:present >
				</html:select>
				</td>
				
				<td class="btext2">Mandal<span class="mandatory">*</span></td>
				<td class="btext2">
				<html:select property="mcode" style="width:140px;height:20px"    styleClass="mycombo" onchange="javascript:getData('panchayats');">
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="mandals">
					<html:options collection="mandals"  property="mandalCode" labelProperty="mandalName"/>
				</logic:present>
				</html:select>
				</td>
			</tr>
			<tr>
				<td class="btext2">Panchayat<span class="mandatory">*</span></td>
				<td class="btext2">
					<html:select property="panchayat" style="width:140px;height:20px"    styleClass="mycombo"  onchange="javascript:getData('villages');">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:present name="panchayats">
					<html:options collection="panchayats"  property="pcode" labelProperty="pname" />
					</logic:present>
				</html:select>
			</td>
			<td class="btext2"  >Village<span class="mandatory">*</span></td>
				<td class="btext2">
					<html:select property="vcode" styleClass="mycombo"  style="width:140px;height:20px" >
					<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
					<logic:present name="villages">
					<html:options collection="villages"  property="villageCode" labelProperty="villageName"/>
					</logic:present>
					</html:select>
				</td>
				</tr>
				</table>
				</label>
			</fieldset>		
			<fieldset>
			<legend  >Asset Details</legend>
			<label>
			<table  width="980" border=0 style="border-collapse: collapse;" align="center">
				<tr>
				<td class="btext2" >Asset Type<font color="red">*</font></td>
				<td class="btext2">		     
					<html:select property="asttype" styleClass="mycombo"   style="width:140px;height:20px"  onchange="AstSubCompShow();getData('comps');AstSouSubCompShow();" >
					<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
					<logic:present name="asttypes">
					<html:options collection="asttypes"  property="assetTypeCode" labelProperty="assetType"/>
					</logic:present>
					</html:select>
				</td>
				<td class="btext2">
					<div id="show" style="display:none;">Component<font color="red">*</font></div>
				</td>
				<td class="btext2">
				<div id="show1" style="display:none;">
					<html:select property="astComp"
						styleClass="mycombo" style="width:140px;height:20px" onchange="AstSouSubCompShow();getData('subcomps');"  >
						<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
						<logic:present name="astComps">
							<html:options collection="astComps"	 property="astCompCode" labelProperty="astCompName" />
						</logic:present>
					</html:select>
					</div>
				</td>	
			</tr>
			<tr>
				<td class="btext2">
					<div id="show2" style="display:none;">SubComponent<font color="red">*</font></div>
				</td>
				<td class="btext2">
				<div id="show3" style="display:none;">
					<html:select property="astSubComp"
						styleClass="mycombo" style="width:140px;height:20px" onchange="getData('soutypes');" >
						<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
						<logic:present name="astSubComps">
							<html:options collection="astSubComps"	 property="astSubCompCode" labelProperty="astSubCompName" />
						</logic:present>
					</html:select>
					</div>
				</td>				
			<td   class="btext2">
					<div id="showSource" style="display:none;">Source Type<font color="red">*</font></div>
				</td>
				<td    class="btext2">
				<div id="showSource1" style="display:none;">
					<html:select property="souType"
						styleClass="mycombo" style="width:140px;height:20px">
						<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
						<logic:present name="souComps">
							<html:options collection="souComps"  property="sourceTypeCode" labelProperty="sourceTypeName" />
						</logic:present>
					</html:select>
					</div>
				</td>	
				</tr>
				<tr>		
				<td align="center" colspan="8">		
					 <input type="button" class="btext2" value="Get Data" style="width:80px;height:20px" id="sBtn" onClick="javascript:fnSave();" class="btext" > 
		    	 </td>
		    	 </tr>
				</table>
			</label>
			</fieldset>			
		</td>
		</tr>
			<tr>
			<td>			
			<table 	width="1135" border=1 style="border-collapse: collapse;">
			<thead>
			<tr align="">
				<td class="btext" align="center" rowspan="2">S.No</td>
				<td class="btext" align="center" rowspan="2">Asset Code/<br>Asset Name</td> 
				<td class="btext" align="center" rowspan="2">Source Code/<br>Location/<br>Source Name</td>	
				<td class="btext" align="center" rowspan="2">Image</td>
				<td class="btext" align="center" rowspan="2">Latitude&nbsp;/<br>Longitude</td>
				<td class="btext" align="center" rowspan="2">Inspected By<span class="mandatory">*</span></td> 
				<td class="btext" align="center" rowspan="2">Status<span class="mandatory">*</span></td>
				<td class="btext" align="center" rowspan="2">Not Functional Status</td>
				<td class="btext" align="center" rowspan="2">Alternative Arrangements</td>
				<td class="btext" align="center" rowspan="2">Repair<br>Type</td>
				<td class="btext" align="center" rowspan="2">Repair<br>Date</td>
				<td class="btext" align="center" rowspan="2">Repair<br>Cost(In&nbsp;Rupees)</td>
				<td class="btext" align="center" rowspan="2">Select</td>	
			</tr>
			</thead>
	<%
  int count=1;
%>
	<logic:notEmpty name="FunctionalRepair" property="sources">
	<logic:iterate id="sources" name="FunctionalRepair" property="sources" indexId="index">
	
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)">
		<td class="rptValue"><%=count++%></td>
		<td  class="rptValue" >
		<html:hidden name="sources" property="assetCode" indexed="true" />
			<bean:write name="sources" property="assetCode" />/<br>
			<bean:write name="sources" property="assetName"/>
		</td>
	<td  class="rptValue" >
		<html:hidden name="sources" property="compCode" indexed="true" />
			<bean:write name="sources" property="compCode" />/<br>
			<bean:write name="sources" property="location" />/<br>
			<bean:write name="sources" property="compName"/>
		</td>
		
		<td  class="rptValue" >
			<%--  <img src="masters/image.jsp?imgID=<bean:write name="sources" property="sourceCode"/>" onmouseover="this.width=200;this.height=150;" onmouseout="this.width=30;this.height=30;" width="30" height="30"> --%>
			<logic:equal value="Yes" property="imgStatus"  name="sources">
				<a class="thumbnail" href="#thumb"><img src="masters/image.jsp?imgID=<bean:write name="sources" property="compCode"/>"  width="30px" height="30px" border="0" /><span><img src="masters/image.jsp?imgID=<bean:write name="sources" property="compCode"/>"  /></span></a>
			</logic:equal>
			<logic:notEqual value="Yes" property="imgStatus" name="sources">
				<p><font style="font-size: 9px">Image not Exist</font>
			</logic:notEqual>
		</td>
		<%-- <td  class="rptValue" >
			<bean:write name="sources" property="compLat"/>
		</td>
		<td  class="rptValue" >
			<bean:write name="sources" property="compLong"/>
		</td>
		<td  align="center" >
		<html:select name="sources" property="status"  indexed="true" styleId="statusn" styleClass="mycombo" style="width:80px;height:20px" >
		<logic:equal value="04" name="FunctionalRepair" property="astComp">
			<html:option value="">Select..</html:option>
			<html:option value="W">WORKING</html:option>
			<html:option value="D">DILAPITATED</html:option>
		</logic:equal>
		<logic:notEqual value="04" name="FunctionalRepair" property="astComp">
			<html:option value="">Select..</html:option>
			<html:option value="W">WORKING</html:option>
			<html:option value="N">NOT WORKING</html:option>
			<html:option value="D">DRIED</html:option>
			<html:option value="S">SEASONAL</html:option>
			<html:option value="C">CONDEMED</html:option>	
		</logic:notEqual>
		</html:select>
			
		</td> --%>
		<td  class="rptValue" >
			<bean:write name="sources" property="compLat"/>&nbsp;/<br><bean:write name="sources" property="compLong"/>
		</td>
		<td  class="rptValue" >	
			<html:select name="sources" property="inspectedBy"  indexed="true" styleClass="mycombo" style="width:80px;height:20px" >		
				<html:option value="">Select..</html:option>
				<html:option value="SE">SE</html:option>
				<html:option value="EE">EE</html:option>
				<html:option value="DEE">DEE</html:option>
				<html:option value="AE">AE</html:option>
				<html:option value="Field Assistant">Field Assistant</html:option>		
			</html:select>
		</td>
		<td  align="center" >
		<html:select name="sources" property="status"  indexed="true"  styleClass="mycombo" style="width:80px;height:20px"  onchange='<%="notFunctionalStatus(" + index + ");disableRepairs(" + index + ")" %>'  >
			<html:option value="">Select..</html:option>
			<html:option value="W">WORKING</html:option>
			<html:option value="N">NOT WORKING</html:option>
			<html:option value="D">DRIED</html:option>
			<html:option value="S">SEASONAL</html:option>
			<html:option value="C">CONDEMED</html:option>	
		</html:select>
		</td>
		<td>
			<html:select name="sources" property="notFunctionalStatus" indexed="true" styleClass="mycombo" style="width:80px;height:20px"  onchange='<%="disableRepairs(" + index + ")" %>' >		
				<html:option value="">Select..</html:option>
				<html:option value="P">Permanent</html:option>
				<html:option value="T">Temporary</html:option>						
			</html:select>					
		</td>
		<td>
			<html:select name="sources" property="alterArangmts"  indexed="true" styleClass="mycombo" style="width:80px;height:20px"  onchange='<%="disableRepairs(" + index + ")" %>' >		
				<html:option value="">Select..</html:option>
				<html:option value="Through other scheme">Through other scheme</html:option>
				<html:option value="Direct Pumping">Direct Pumping</html:option>		
				<html:option value="Transportation">Transportation</html:option>
				<html:option value="Hiring of source">Hiring of source</html:option>							
			</html:select>					
		</td>
		<td  align="center" >		     
			<html:select name="sources" property="compRepairCode"  indexed="true" styleClass="mycombo" style="width:140px;height:20px">
				<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
				<logic:present name="repairTypes" >
					<html:options collection="repairTypes"  property="repairCode" labelProperty="repairName"/>
				</logic:present>
			</html:select>
	</td>
		<td>
			<html:text name="sources" property="compRepairdate"  styleId="repairdaten" indexed="true"  onkeypress="return decimalsOnly(event)" style="width: 70px" />
			<a href="javascript:showCalendar(document.getElementById('sources[<%=count-2%>].compRepairdate'));">
        	<img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
        </td>
        <td> <html:text name="sources" property="compRepairCost"  indexed="true"  onkeypress="return decimalsOnly(event)" /> </td>
		<td>			
		<html:checkbox name="sources" property="checks" indexed="true" onclick='<%="check(" + index + ")" %>' />
		</td>		
	</tr>
	
	</logic:iterate>
	</logic:notEmpty>
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
	<%if(count==1)
		{
		%><tr><td colspan="12" align="center" class="btext">No Records</td></tr><%}
		else{%><tr><td colspan="12" align="center">
		
		 <input type="button" value="Save" id="sBtn" onClick="fnUpdate();" class="btext" > 
		 <!-- <input type=button value=Save id="sBtn" onClick="fnSave();" class="btext" disabled="disabled">  -->
		<%-- <html:submit id="sBtn"  value="Save"  onClick="fnSave();" disabled="true"  class="btext"/>  --%>
		
		</td></tr><%}%>
	<input type="hidden" name="resultCount" value="<%=count%>"/>
	</table>
	</td>
	</tr>
	</table>
	</td>
	</tr>
	</tbody>
	<tfoot>
<tr>
<td>
			<jsp:include page="/commons/TableFotter.jsp">
				<jsp:param name="TWidth" value="1115" />
			</jsp:include>
			</td>
			</tr>
			</tfoot>
			</table>
			 <table>
		  			<tr>
					<td>
					<font color="green" size="2">Note:</font>					
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">1.For CPWS schemes District selection is sufficient.</font>
					</td>
					</tr>					
			</table> 
			
		<%@ include file="/commons/rws_footer.jsp"%>
	</html:form>
	</body>
	<%@ include file="/commons/rws_alert.jsp"%>
	
	
