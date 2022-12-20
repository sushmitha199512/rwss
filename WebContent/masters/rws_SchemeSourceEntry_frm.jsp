<%@ include file="/commons/rws_header1.jsp" %>
<link rel="stylesheet" type="text/css" href="../resources/style/rwsstyle.css">
<html:javascript formName="sourceForm" />
<script language="JavaScript">
<!--
function viewDet()
{
	location.href="/pred/Source.do?mode=view";
}
function getData()
{
	document.forms[0].action="./SourceData.do";
	document.forms[0].submit();
	
}
function EnableFields()
{
	if(sourceForm.waterQuality.value == "NSS")
	{
		sourceForm.contType.style.visibility="visible"
		sourceForm.levelOfCont.style.visibility="visible"
				
		contType.style.visibility="visible"
		levelOfCont.style.visibility="visible"
	}
	else
	{
		sourceForm.contType.style.visibility="hidden"
		sourceForm.levelOfCont.style.visibility="hidden"
				
		contType.style.visibility="hidden"
		levelOfCont.style.visibility="hidden"
	}
}
function showAsset(assetCode)
{
	var hc=sourceForm.habCode.value;
	
	var newWindow = window.open("././jsp/AssetSourceData.jsp?hcode="+hc,"","width=200,height=150");
	newWindow.moveTo(400,250);
}
function showAsset1(assetCode)
{
	var hc=sourceForm.habCode.value;
	
	var newWindow = window.open("././jsp/AssetSourceData1.jsp?hcode="+hc,"","width=300,height=250");
	newWindow.moveTo(400,250);
}
//-->
</script>
 
<%@ include file="/commons/rws_header2.jsp" %>
<tr height="96%">
<td  valign="middle">

<html:form action="Source.do?mode=insert" onsubmit="return validateSourceForm(this)" >

<jsp:include page="TableHeader.jsp">
	<jsp:param name="TableName" value="Scheme Source Entry Form" />
	<jsp:param name="TWidth" value="720" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="760" >
<tr>
<td>
<table  border=0  width="750"  align=center  >
<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.district" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="district" style="width:123px" styleClass="mycombo" onchange="javascript:getData()" >
	<html:option value=""><font class="myfontclr1">Select...</html:option>
	<html:options collection="dists" name="rwsMaster" property="dcode" labelProperty="dname" />
	</html:select>
		
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.mandal" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="mandal" styleClass="mycombo" style="width:123px" onchange="javascript:getData()" >
	<html:option value="">Select...</html:option>
	<html:options collection="mandals" name="rwsMaster" property="mandalCode" labelProperty="distNoName" />
	</html:select>
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.panchayat" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="pcode" styleClass="mycombo" style="width:123px" styleClass="mycombo"  onchange="javascript:getData()">
	<html:option value="">Select...</html:option>
	<html:options collection="panchyats" name="rwsMaster" property="mandalCode" labelProperty="distNoName" />
	</html:select>
	</td>
	</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.village" /><font color="#FF6666">*</font></FONT></td>
	<td  class=mycborder >
	<html:select property="vcode" styleClass="mycombo" style="width:123px" styleClass="mycombo"  onchange="javascript:getData()">
	<html:option value="">Select...</html:option>
	<html:options collection="villages" name="rwsMaster" property="mandalCode" labelProperty="distNoName" />
	</html:select>
	</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.habCode" /><font color="#FF6666">*</font></FONT>
		</td>
		
		<td  class=mycborder colspan=2>
		<html:select property="habCode" styleClass="mycombo" style="width:250px" styleClass="mycombo"  >
		<html:option value="0">Select...</html:option>
		<html:options collection="habs" name="rwsMaster" property="habName" labelProperty="distNoName" />
		</html:select>
		</td>
	</tr>
	</table>
	<hr style="color:#8A9FCD">
	<table  border=0  width="745"  align=center  >
	<tr>
	<td  class=mycborder >
		<FONT class=myfontclr>Source Type<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="sourceTypeCode" styleClass="mycombo" style="width:135px" onchange="javascript:getData()">
		<html:option value=" "><font class=myfontclr1>Select...</html:option>
		<html:options collection="sourceTypeCodes" name="rwsMaster" property="sourceTypeCode" labelProperty="sourceTypeNoName" />
		</html:select>
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr>Sub Source Type<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="subSourceTypeCode" style="width:155px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">Select...</html:option>
		<html:options collection="subSourceTypeCodes" name="rwsMaster" property="subSourceTypeCode" labelProperty="sourceTypeNoName" />
		</html:select>
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.sourceCode" /></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sourceCode" value="<%=(String)request.getAttribute(\"scode\")%>" styleClass="mytext" style="width:40px" maxlength="3" readonly="true" />
		</td>
				
		</tr><tr>
		<td  class=mycborder nowrap>
		<FONT class=myfontclr>Source Name<font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="sourceName" value="<%=(String)request.getAttribute("sourceName")%>" styleClass="mytext" style="width:135" maxlength="25" />
		</td>
		<td  class=mycborder colspan=2>
		<FONT class=myfontclr><bean:message key="app.noOfHab" /><font color="#FF6666">*</font></FONT>
		&nbsp;&nbsp;
		<html:text property="noOfHab" value="" style="width:70px" styleClass="mytext" maxlength="2" />&nbsp;&nbsp;
		<input type="button"  value="..." style="width:20px;height:18px"  onclick="window.open('./AssetHab.do')" >&nbsp;&nbsp;
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.popbenefited" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="popbenefited" value="" styleClass="mytext" style="width:50px" maxlength="5" />
		</td>
		</tr>
		</table>
		<hr style="color:#8A9FCD">
		<table  border=0  width="745"  align=center  >
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.seasonal" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="seasonal" styleClass="mycombo" >
		<html:option value="">Select...</html:option>
		<html:option value="YES">YES</html:option>
		<html:option value="NO">NO</html:option>
		</html:select>
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.presentCondition" /><font color="#FF6666">*</font></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="presentCondition" styleClass="mycombo" style="width:123px" >
		<html:option value="">Select...</html:option>
		<html:option value="W">WORKING</html:option>
		<html:option value="N">NOT WORKING</html:option>
		<html:option value="D">DRIED</html:option>
		</html:select>
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr>Water Quality</FONT>
		</td>
		<td  class=mycborder >
		<html:select property="waterQuality" style="width:90px" styleClass="mycombo" onchange="EnableFields()">
		<html:option value="">Select...</html:option>
		<html:option value="SS">Safe Source</html:option>
		<html:option value="NSS">NSS</html:option>
		</html:select>
		</td>
		</tr>
		<tr>
		<td  class=mycborder id="contType" style="visibility:hidden">
		<FONT class=myfontclr><bean:message key="app.contType" /></FONT>
		</td>
		<td  class=mycborder >
		<html:select property="contType" style="width:90px;visibility:hidden" styleClass="mycombo" >
		<html:option value="">Select...</html:option>
		<html:option value="FLORIDE">FLORIDE</html:option>
		<html:option value="BRAKISH">BRAKISH</html:option>
		<html:option value="IRON">IRON</html:option>
		<html:option value="OTHERS">OTHERS</html:option>
		</html:select>
		</td>
		<td  class=mycborder id="levelOfCont" style="visibility:hidden">
		<FONT class=myfontclr>Level of Contamination</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="levelOfCont" style="width:0px;visibility:hidden" styleClass="mytext" /></td>
		</tr>
		</table>
		<table  border=0  width="745"  align=center  id="spotSource" >
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Static Water Level</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="staticWaterLevel" styleClass="mytext" style="width:80px" />		
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr>Summer Water Level</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="summerWaterLevel" styleClass="mytext" style="width:80px" /></td>
		<td  class=mycborder >
		<FONT class=myfontclr>Year Of Drilling</FONT>
		</td>
		<td  class=mycborder >
		<html:text property="yearOfDrilling" style="width:80px" styleClass="mytext" maxlength="4"/>
		</td>
		</tr>
		<tr>
		<td  class=mycborder >
		<FONT class=myfontclr>Diameter Of Borewell&nbsp;&nbsp;<font color="#FF6666">(mts)</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="diameterOfBorewell" style="width:80px" styleClass="mytext" />
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr>Depth Of Borewell&nbsp;&nbsp;<font color="#FF6666">(mts)</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="depthOfBorewell" style="width:80px" styleClass="mytext" /></td>
		<td  class=mycborder >
		<FONT class=myfontclr>Yield&nbsp;&nbsp;<font color="#FF6666">(lpm)</font></FONT>
		</td>
		<td  class=mycborder >
		<html:text property="yield" style="width:80px" styleClass="mytext" /></td>
		</tr>
		</table>

		<tr >
			<td class="mycborder">
			<fieldset>
			<legend style="color:#6666FF;font-size:7pt">Asset Linkage</legend>
			<label>
			<table  width="100%" cellpadding="0" cellspacing="0" border="0" style="border-collapse:collapse">
			<tr>
			<td class="mycborder1">
			<FONT class=myfontclr1>Assets Located in the same Habitation as the Source &nbsp;<input type="button" value="..." style="width:20px;height:18px" onclick="showAsset('id1')">
			</td>
			<td class="mycborder1">
				<FONT class=myfontclr1>Assets Located in the different Habitation as the Source &nbsp;<input type="button" value="..." style="width:20px;height:18px" onclick="showAsset1('id1')">
			</td>
			</tr>
			</table>
			</label>
			</fieldset>
			
		</tr>
		<tr id="id1" style="display:none">
			<td class="mycborder">
			<fieldset>
			<legend style="color:#6666FF;font-size:7pt">Asset Details</legend>
			<label>
				<table id="assetTable" width="60%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse:collapse" bgcolor="#ffffff" >
				<thead class="gridLabel">
					<tr bgcolor="#8A9FCD">
						<td class=mycborder><font class=myfontclr><font color="#ffffff">Asset Code</font></td>
						<td class=mycborder><font class=myfontclr><font color="#ffffff">Asset Name</font></td>
						<td class=mycborder><font class=myfontclr><font color="#ffffff">Asset Type Name</font></td>
					</tr>
				</thead>
				<tbody class="gridText">
				</tbody>
				</table>
			</label>
			</fieldset>
			</td>
		</tr>


	<tr>
	<td colspan="2" align="center">
	<html:submit title="Save the Fields" styleClass="btext" value="Save" onclick="winView()" />
 
     <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 <html:button property="page" title="View the Fields" styleClass="btext" value="View"  onclick="viewDet()" />
	 
	</td>
</tr>
</table>

 <jsp:include page="TableFotter.jsp">
	<jsp:param name="TWidth" value="720"/>
</jsp:include>

</html:form>
</td>
</tr>
<iframe src="" name="rws_pred" border="0" frameborder="0" width="0" height="0"
	 marginwidth="1" marginheight="1" scrolling="no" style="visibility:hidden"></iframe>

<%@ include file="/commons/rws_footer.jsp"%>


