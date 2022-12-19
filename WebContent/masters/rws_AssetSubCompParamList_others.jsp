
<%@ include file="/commons/rws_header1.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
	
	function tankDisable(){
		
		var ss=document.getElementById('collectionTank').value;
		
		if(ss=='Y'){
			document.getElementById('collectionTankCapacity').disabled=false;
		}
		else{
			document.getElementById('collectionTankCapacity').disabled=true;
		}
	}
	
	var newWindow;
	
	function fnPickNewHabitations()
{
	var assetType="<%=request.getParameter("assetTypeCode")%>";
	var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	var assetCode="<%=request.getParameter("assetCode")%>";
	//alert("asset code testing 0  "+assetCode);
	//code modified by pranavi
	var location="<%=request.getParameter("location")%>";
	
	if(assetType=="05"||assetType=="06"||assetType=="07")
	{
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&assetTypeCode="+assetType+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&location="+location+"&toDo=newHab&assetCode="+assetCode;
	   	document.forms[0].action=url;
	   	document.forms[0].submit();				  
		
	}
	
	else
	{	   
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&assetTypeCode="+assetType+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&toDo=newHab";
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
					   + "resizable=yes";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
	}
}

	function fnPickHabitations(index)
{	
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var subCompCodeTemp= document.getElementById("subCompCode").value;
	   var subCompCode1=(document.getElementById(subCompCodeTemp).value);
		
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		
		 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=AddHabs&subCompCode1="+subCompCode1
				+ "&dcode="+dcode
				+ "&district="+district+"&mandal="+mandal;
				//alert(url);
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
					   + "resizable=yes";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
}
	
	function init()
	{
	var subCompCodeTemp= document.getElementById("subCompCode").value;
	if(subCompCodeTemp!="generalCode")
	{
		var subCompCode1=(document.getElementById(subCompCodeTemp).value);
		var code=document.getElementById(subCompCodeTemp).value;
		if(document.getElementById("waterQuality").value == "NSS")
		document.getElementById('conti').style.display='block';
		else
		document.getElementById('conti').style.display='none';
		if((code==null) || (code==""))
		{
		document.getElementById("add").disabled=false;
		}
		else
		{
		document.getElementById("add").disabled=true;
		}
	}
	else
		{
			var code=document.getElementById(subCompCodeTemp).value;
			if((code==null) || (code==""))
			{
			document.getElementById("add").disabled=false;
			}
			else
			{
			document.getElementById("add").disabled=true;
			}
		 document.getElementById("generalCode").value="<%=session.getAttribute("phCode")%>";
		 document.getElementById("assetCode").value="<%=session.getAttribute("assetCode")%>";
		}
	}
	
	function getContam(that)
	{	
	var optype = that.value;
	var option1 = assetForm.floride.value;
	var option2 = assetForm.brakish.value;
	var option3 = assetForm.iron.value;
	var option4 = assetForm.others.value;
	if(that.value == "FLOURIDE" || option1 != "0.0")
	{
	document.getElementById('FLOURIDE').style.display='block';
	}
	if(that.value == "BRAKISH" || option2  != "0.0" )
	document.getElementById('BRAKISH').style.display='block';
	if(that.value == "IRON" || option3 != "0.0" )
	document.getElementById('IRON').style.display='block';
	if(that.value == "OTHERS" || option4 != "0.0" )
	document.getElementById('OTHERS').style.display='block';
	}

	function qualityAffect()
	{
		if(document.getElementById("waterQuality").value == "NSS")
		{
		document.getElementById('conti').style.display='inline'
		}
	else
	{
	document.getElementById('conti').style.display='none'
	document.forms[0].floride.value="";
	document.forms[0].brakish.value="";
	document.forms[0].iron.value="";
	document.forms[0].othersType.value="";
	document.forms[0].others.value="";
	}
		
	}
	
	function addnew()
	{
		var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		 if((typeOfAsset=="05"||typeOfAsset=="06"||typeOfAsset=="07"||typeOfAsset=="08") && assetCompType=="01" && assetSubCompType=="001")
		   {
			 document.forms[0].action="/pred/masters/Asset.do?mode=addNew&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType;
	         document.forms[0].submit();
		   }
 	}
	
	  function closeFunc(){
		  opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=data";
		  opener.document.forms[0].submit();
		  opener.document.getElementById('docBody').innerHTML="<img align='center'src='./images/ajax-loader3.gif'style='position:absolute; left:350px; top:250px; height=100px; width=300px' ALT='Please wait..' border='0'></img>";
		  self.close();
	}
		
   function savefunc()
   {
   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
	   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
	   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
	  var assetCode=document.getElementById("assetCode").value="<%=session.getAttribute("assetCode")%>";
	    if((typeOfAsset=="05" || typeOfAsset=="06" || typeOfAsset=="07" || typeOfAsset=="08") && assetCompType=="01" && assetSubCompType=="001")
	   {
	    if(typeOfAsset=="05" && assetCompType=="01" && assetSubCompType=="001" ){
	      var yld=document.forms[0].yeild.value;
	      var shpcode=document.forms[0].shallowHandPumpCode.value;
	     if(shpcode=="" || shpcode==null){
	     } 
	     else if(yld=="" || yld==null){
	      alert("Yield is Mandatory");
	      document.forms[0].yeild.focus();
	      } else{
	      document.forms[0].action="/pred/masters/Asset.do?mode=addSubCompPump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
	       document.forms[0].submit();
	      }
	      } 
	    else if(typeOfAsset=="06" && assetCompType=="01" && assetSubCompType=="001"){
	      var openwellcode=document.forms[0].openWellCode.value;
	      if(openwellcode=="" || openwellcode==null){
	     alert("Click on AddNew button for OpenWell Code");
	     } else{
	      document.forms[0].action="/pred/masters/Asset.do?mode=addSubCompPump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
	      document.forms[0].submit();
	     }
	      } else if(typeOfAsset=="07" && assetCompType=="01" && assetSubCompType=="001"){
	      var pondCode=document.forms[0].pondCode.value;
	      if(pondCode=="" || pondCode==null){
	     alert("Click on AddNew button for Pond Code");
	     } else{
	      document.forms[0].action="/pred/masters/Asset.do?mode=addSubCompPump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
	      document.forms[0].submit();
	     }
	      }else{
	      document.forms[0].action="/pred/masters/Asset.do?mode=addSubCompPump&assetTypeCode="+typeOfAsset+"&assetCompTypeCode="+assetCompType+"&assetSubCompTypeCode="+assetSubCompType+"&assetCode="+assetCode;
	      document.forms[0].submit();
	      }
	      }    
   }
	function openFile(sourceno){
		 var assetcode = "<%=request.getParameter("assetCode")%>";
		   var habcode = "<%=request.getParameter("habCode")%>"
	 	   var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		   var assetCompType="<%=request.getParameter("assetCompTypeCode")%>";
		   var assetSubCompType="<%=request.getParameter("assetSubCompTypeCode")%>";
		   var pumCode ="<%=request.getParameter("PumpCode")%>"; 
			var url="switch.do?prefix=/masters&page=/Asset.do?mode=showCompImage&sourceid="+sourceno+"&assetCode="+assetcode;
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
	</SCRIPT>

</head>
<!--  <body bgcolor="#edf2f8" topmargin="0" leftmargin="0" onload="qualityAffect();getContam(this);drainCond(this);platformCond(this);init()">	-->
<body bgcolor="#edf2f8" topmargin="0" leftmargin="0" onload="init()">
	<%
					String csrfToken = "";
									nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
									csrfToken = valUtil.getCSRFCode();
									session.setAttribute("csrfToken", csrfToken);
				%>
	<table bordercolor="#8A9FCD" border="0" rules="none"
		style="border-collapse: collapse;" width="100%">
		<thead class="gridLabel" align="center">
			<tr bgcolor="#8A9FCD">
				<td colspan=4 align=left><b>Asset SubComponent Parameter
						Details </b></td>
			</tr>
		</thead>
		<c:if test="${sessionScope.assetsubCompParams=='Ponds'}">
			<html:form action="Asset.do?mode=Submit">
				<nested:iterate id="ASSETPONDS_LIST" property="assetPonds"
					indexId="ndx">
					<tr>
						<td align=left class="textborder"><bean:message
								key="app.pondCode" />&nbsp;&nbsp;</td>
						<td class="textborder" align=center><nested:text
								name="ASSETPONDS_LIST" property="assetCode" styleClass="mytext"
								style="width:0px" /> <nested:text name="ASSETPONDS_LIST"
								property="pondCode" styleClass="mytext" style="width:160px"
								readonly="true" /></td>
					</tr>
					<tr>
						<td align=left class="textborder"><bean:message
								key="app.habitation" /></td>
						<td class="textborder" align=center><nested:text
								name="ASSETPONDS_LIST" property="habitation" maxlength="30"
								styleClass="mytext" style="width:160px" readonly="true"
								onkeypress="upperOnly()" /> <nested:hidden
								name="ASSETPONDS_LIST" property="habCode" /></td>

						<td align=left class="textborder"><bean:message
								key="app.fedBy" />&nbsp;&nbsp;</td>
						<td class="textborder" align=center><html:select
								name="ASSETPONDS_LIST" property="fedBy" styleClass="mycombo"
								style="width:100px">
								<html:option value="">SELECT...</html:option>
								<html:option value="CANAL">CANAL</html:option>
								<html:option value="RAIN">RAIN</html:option>
								<html:option value="OTHERS">OTHERS</html:option>
							</html:select></td>
					</tr>
					<tr>
						<td align=left class="textborder"><bean:message
								key="app.hygeinity" />&nbsp;&nbsp;</td>
						<td class="textborder" align=center><html:select
								name="ASSETPONDS_LIST" property="hygeinity" styleClass="mycombo"
								style="width:160px">
								<html:option value="">SELECT...</html:option>
								<html:option value="GOOD">GOOD</html:option>
								<html:option value="BAD">BAD</html:option>
							</html:select></td>
						<td align=left class="textborder"><bean:message
								key="app.volumeOfStorage" />&nbsp;&nbsp;</td>
						<td class="textborder" align=center><nested:text
								name="ASSETPONDS_LIST" property="volumeOfStorage"
								styleClass="mytext" style="width:100px" readonly="false"
								onkeyup="extractNumber2(this,9,2,false);"
								onkeypress="return blockNonNumbers(this, event, true, false);" />
						</td>
					</tr>
					<tr>
						<td align=left class="textborder"><bean:message
								key="app.name" />&nbsp;&nbsp;</td>
						<td class="textborder" align=center>
							 <nested:text name="ASSETPONDS_LIST"
								property="name" maxlength="50" styleClass="mytext"
								style="width:160px" readonly="false" onkeypress="upperOnly()" />
						</td>
						<td align=left class="textborder"><bean:message
								key="app.purpose" />&nbsp;&nbsp;</td>

						<td class="textborder" align=center><html:select
								name="ASSETPONDS_LIST" property="purpose" styleClass="mycombo"
								style="width:100px">
								<html:option value="">SELECT...</html:option>
								<html:option value="DIRNKING">DIRNKING</html:option>
								<html:option value="ANIMALS">ANIMALS</html:option>
								<html:option value="OTHERS">OTHERS</html:option>
							</html:select></td>
					</tr>
					<tr>
						<td align=left class="textborder"><bean:message
								key="app.location" />&nbsp;&nbsp;</td>
						<td class="textborder" align=center><nested:text
								name="ASSETPONDS_LIST" property="location" maxlength="50"
								styleClass="mytext" style="width:160px" readonly="false"
								onkeypress="upperOnly()" /></td>
						<td align=left class="textborder"><bean:message
								key="app.areaSize" />&nbsp;&nbsp;</td>
						<td class="textborder" align=center><nested:text
								name="ASSETPONDS_LIST" property="areaSize" styleClass="mytext"
								style="width:100px" readonly="false"
								onkeyup="extractNumber2(this,11,2,false);"
								onkeypress="return blockNonNumbers(this, event, true, false);" />
						</td>
					<tr>
						<td align=left class="textborder"><bean:message
								key="app.waterQuality" />&nbsp;&nbsp;</td>
						<td class="textborder" align=center><html:select
								name="ASSETPONDS_LIST" property="waterQuality"
								styleClass="mycombo" style="width:160px"
								onchange="javaScript:qualityAffect()">
								<html:option value="">SELECT...</html:option>
								<html:option value="SAFE SOURCE">SAFE SOURCE</html:option>
								<html:option value="NSS">NSS</html:option>
							</html:select></td>
					</tr>
					<tr>
						<td class="textborder">Image</td>

						<td align=center><nested:equal name="ASSETPONDS_LIST"
								property="imageStatus" value="Yes">
								<a href="#"
									onclick="openFile('<bean:write name="ASSETPONDS_LIST" property="pondCode"/>')">View</a>&nbsp;
			</nested:equal> <nested:notEqual name="ASSETPONDS_LIST" property="imageStatus"
								value="Yes">
								<p styleClass="mytext" style="width: 150px">Image not Exist</p>
							</nested:notEqual></td>
					</tr>
					<td class="textborder">Latitude-N</td>
					<td align=center><nested:text name="ASSETPONDS_LIST"
							property="latitude" style="width:100px" styleClass="mytext"
							maxlength="10" onkeypress="decimalsOnly()" /></td>
					<td class="textborder">Longitude-E</td>
					<td align=center><nested:text name="ASSETPONDS_LIST"
							property="longitude" style="width:100px" styleClass="mytext"
							maxlength="10" onkeypress="decimalsOnly()" /></td>
				</nested:iterate>
				<tr>
					<table id="conti" border="0">
						<tr>
							<td>
								<div
									style="position: relative; overflow-n: auto; left: 0; height: 34; width: 500; top: 0; display: block">
									<fieldset>
										<legend>Contamination Details</legend>
										&nbsp; <input type="radio" name="opType1"
											style="width: 12px; height: 13px" styleClass="mytext"
											onclick="javascript:getContam(this)" value="FLOURIDE" /><font
											size="1" face="verdana"><b>&nbsp;Flouride</b></font>
										&nbsp;&nbsp; <input type="radio" name="opType2"
											style="width: 12px; height: 13px" styleClass="mytext"
											onclick="javascript:getContam(this)" value="BRAKISH" /><font
											size="1" face="verdana"><b>&nbsp;Brakish</b></font> <input
											type="radio" name="opType3" style="width: 12px; height: 13px"
											styleClass="mytext" onclick="javascript:getContam(this)"
											value="IRON" /><font size="1" face="verdana"><b>&nbsp;Iron</b></font>
										<input type="radio" name="opType4"
											style="width: 12px; height: 13px" styleClass="mytext"
											onclick="javascript:getContam(this)" value="OTHERS" /><font
											size="1" face="verdana"><b>&nbsp;Others</b></font>
									</fieldset>
								</div>
							</td>
						</tr>
					</table>
				</tr>
				<tr>
					<div id="FLOURIDE"
						style="position: relative; overflow-y: auto; left: 0; height: 34; width: 500; top: 0; display: none">
						<fieldset>
							<label>
								<table bordercolor="#000000" border="1"
									style="border-collapse: collapse;" width="100%" align=center>

									<tbody bgcolor="#FFFFFF">

										<nested:iterate id="ASSETPONDS_LIST" property="assetPonds"
											indexId="ndx">
											<td align=left class="textborder"><bean:message
													key="app.flouride" /></td>
											<td class="textborder" align=center><nested:text
													name="ASSETPONDS_LIST" property="floride"
													styleClass="mytext" style="width:150px"
													onkeyup="extractNumber2(this,5,2,false);"
													onkeypress="return blockNonNumbers(this, event, true, false);" />%
											</td>
										</nested:iterate>
									</tbody>
									</tbody>
								</table>
							</label>
						</fieldset>
					</div>
				</tr>
				<tr>
					<div id="BRAKISH"
						style="position: relative; overflow-y: auto; left: 0; height: 34; width: 500; top: 0; display: none">
						<fieldset>
							<label>
								<table bordercolor="#000000" border="1"
									style="border-collapse: collapse;" width="100%" align=center>
									<tbody bgcolor="#FFFFFF">
										<nested:iterate id="ASSETPONDS_LIST" property="assetPonds"
											indexId="ndx">
											<td align=left class="textborder"><bean:message
													key="app.brakish" /></td>
											<td class="textborder" align=center><nested:text
													name="ASSETPONDS_LIST" property="brakish"
													styleClass="mytext" style="width:150px"
													onkeyup="extractNumber2(this,5,2,false);"
													onkeypress="return blockNonNumbers(this, event, true, false);" />%
										</nested:iterate>
									</tbody>
									</tbody>
								</table>
							</label>
						</fieldset>
					</div>
				</tr>
				<tr>
					<div id="IRON"
						style="position: relative; overflow-y: auto; left: 0; height: 34; width: 500; top: 0; display: none">
						<fieldset>
							<label>
								<table bordercolor="#000000" border="1"
									style="border-collapse: collapse;" width="100%" align=center>
									<tbody bgcolor="#FFFFFF">
										<nested:iterate id="ASSETPONDS_LIST" property="assetPonds"
											indexId="ndx">
											<td align=left class="textborder"><bean:message
													key="app.iron" /></td>
											<td class="textborder" align=center><nested:text
													name="ASSETPONDS_LIST" property="iron" styleClass="mytext"
													style="width:150px"
													onkeyup="extractNumber2(this,5,2,false);"
													onkeypress="return blockNonNumbers(this, event, true, false);" />%
										</nested:iterate>
									</tbody>
									</tbody>
								</table>
							</label>
						</fieldset>
					</div>
				</tr>
				<tr>
					<div id="OTHERS"
						style="position: relative; overflow-y: auto; left: 0; height: 45; width: 500; top: 0; display: none">
						<fieldset>
							<legend>Please Specify Other Contamination Type</legend>
							<label>
								<table bordercolor="#000000" border="1"
									style="border-collapse: collapse;" width="100%" align=center>
									<tbody bgcolor="#FFFFFF">
										<nested:iterate id="ASSETPONDS_LIST" property="assetPonds"
											indexId="ndx">
											<td align=left width="140" class="textborder"><nested:text
													name="ASSETPONDS_LIST" property="othersType" maxlength="10"
													styleClass="gridText" style="width:130px"
													onkeypress="return upperOnly(event)" /></td>
											<td class="textborder" align=center><nested:text
													name="ASSETPONDS_LIST" property="others"
													styleClass="mytext" style="width:150px"
													onkeyup="extractNumber2(this,5,2,false);"
													onkeypress="return blockNonNumbers(this, event, true, false);" />%
										</nested:iterate>
									</tbody>
									</tbody>
								</table>
							</label>
						</fieldset>
					</div>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;</td>
				</tr>
				<tr>
					
				<html:hidden property="token" styleClass="mytext"
					value="${sessionScope.csrfToken}" />
					<td align="center" colspan=4>
						<div align="center">
							<html:button property="add" title="Add the Fields"
								styleClass="btext" value="Add New"
								onclick="javascript: fnPickNewHabitations()" />
							<html:button property="save" title="Save the Fields"
								styleClass="btext" value="Save" onclick="savefunc()" />
							<html:reset title="Close the Window" styleClass="btext"
								value="Close" onclick="closeFunc()" />
						</div>
					</td>
				</tr>
	</table>
	<input type="hidden" name="subCompCode" value="pondCode">
	</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='OpenWells'}">
		<html:form action="Asset.do?mode=Submit">
			<nested:iterate id="ASSETOPENWELLS_LIST" property="assetOpenWells"
				indexId="ndx">
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.openWellCode" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETOPENWELLS_LIST" property="assetCode"
							styleClass="mytext" style="width:0px" /> <nested:text
							name="ASSETOPENWELLS_LIST" property="openWellCode"
							styleClass="mytext" style="width:160px" readonly="true" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.habitation" /></td>
					<td class="textborder" align=center><nested:text
							name="ASSETOPENWELLS_LIST" property="habitation" maxlength="30"
							styleClass="mytext" style="width:160px" readonly="true"
							onkeypress="upperOnly()" /> <nested:hidden
							name="ASSETOPENWELLS_LIST" property="habCode" /></td>
					<td align=left class="textborder"><bean:message
							key="app.location" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETOPENWELLS_LIST" property="location" maxlength="50"
							styleClass="mytext" style="width:100px" readonly="false"
							onkeypress="upperOnly()" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.diameter" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETOPENWELLS_LIST" property="diameter"
							styleClass="mytext" style="width:100px" readonly="false"
							onkeyup="extractNumber2(this,9,2,false);"
							onkeypress="return blockNonNumbers(this, event, true, false);" />
					</td>
					<td align=left class="textborder"><bean:message
							key="app.depth" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETOPENWELLS_LIST" property="depth" styleClass="mytext"
							style="width:100px" readonly="false"
							onkeyup="extractNumber2(this,9,2,false);"
							onkeypress="return blockNonNumbers(this, event, true, false);" />
					</td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.normalWaterLevel" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETOPENWELLS_LIST" property="normalWaterLevel"
							styleClass="mytext" style="width:100px" readonly="false"
							onkeyup="extractNumber2(this,9,2,false);"
							onkeypress="return blockNonNumbers(this, event, true, false);" />
					</td>
					<td align=left class="textborder"><bean:message
							key="app.minimumWaterLevel" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETOPENWELLS_LIST" property="minimumWaterLevel"
							styleClass="mytext" style="width:100px" readonly="false"
							onkeyup="extractNumber2(this,9,2,false);"
							onkeypress="return blockNonNumbers(this, event, true, false);" />
					</td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.maximumWaterLevel" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETOPENWELLS_LIST" property="maximumWaterLevel"
							styleClass="mytext" style="width:100px" readonly="false"
							onkeyup="extractNumber2(this,9,2,false);"
							onkeypress="return blockNonNumbers(this, event, true, false);" />
					</td>
					<td align=left class="textborder"><bean:message
							key="app.platformExists" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><html:select
							name="ASSETOPENWELLS_LIST" property="platformExists"
							styleClass="mycombo" style="width:100px">
							<html:option value="">SELECT...</html:option>
							<html:option value="YES">YES</html:option>
							<html:option value="NO">NO</html:option>
						</html:select></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.purpose" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><html:select
							name="ASSETOPENWELLS_LIST" property="purpose"
							styleClass="mycombo" style="width:100px">
							<html:option value="">SELECT...</html:option>
							<html:option value="DIRNKING">DIRNKING</html:option>
							<html:option value="OTHERS">OTHERS</html:option>
						</html:select></td>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.quality" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><html:select
							name="ASSETOPENWELLS_LIST" property="waterQuality"
							styleClass="mycombo" style="width:100px"
							onchange="javaScript:qualityAffect()">
							<html:option value="">SELECT...</html:option>
							<html:option value="SAFE SOURCE">SAFE SOURCE</html:option>
							<html:option value="NSS">NSS</html:option>
						</html:select></td>
				</tr>
				<tr>
					<td class="textborder">Image</td>

					<td align=center><nested:equal name="ASSETOPENWELLS_LIST"
							property="imageStatus" value="Yes">
							<a href="#"
								onclick="openFile('<bean:write name="ASSETOPENWELLS_LIST" property="openWellCode"/>')">View</a>&nbsp;
			</nested:equal> <nested:notEqual name="ASSETOPENWELLS_LIST" property="imageStatus"
							value="Yes">
							<p styleClass="mytext" style="width: 150px">Image not Exist</p>
						</nested:notEqual></td>
				</tr>
				<tr>
					<td class="textborder">Latitude-N</td>
					<td align=center><nested:text name="ASSETOPENWELLS_LIST"
							property="latitude" style="width:100px" styleClass="mytext"
							maxlength="10" onkeypress="decimalsOnly()" /></td>
					<td class="textborder">Longitude-E</td>
					<td align=center><nested:text name="ASSETOPENWELLS_LIST"
							property="longitude" style="width:100px" styleClass="mytext"
							maxlength="10" onkeypress="decimalsOnly()" /></td>
				</tr>
				<tr>
					<td class="textborder">Elevation</td>
					<td align=center><nested:text name="ASSETOPENWELLS_LIST"
							property="elevation" style="width:100px" styleClass="mytext"
							maxlength="10" onkeypress="decimalsOnly()" /></td>
					<td class="textborder">Waypoint</td>
					<td align=center><nested:text name="ASSETOPENWELLS_LIST"
							property="waypoint" style="width:100px" styleClass="mytext"
							maxlength="4" onkeypress="decimalsOnly()" /></td>
				</tr>
			</nested:iterate>
			<tr>
				<table id="conti" border="0">
					<tr>
						<td>

							<div
								style="position: relative; overflow-n: auto; left: 0; height: 34; width: 500; top: 0; display: block">
								<fieldset>
									<legend>Contamination Details</legend>
									<input type="radio" name="opType1"
										style="width: 12px; height: 13px" styleClass="mytext"
										onclick="javascript:getContam(this)" value="FLOURIDE" /><font
										size="1" face="verdana"><b>&nbsp;Flouride</b></font>
									&nbsp;&nbsp; <input type="radio" name="opType2"
										style="width: 12px; height: 13px" styleClass="mytext"
										onclick="javascript:getContam(this)" value="BRAKISH" /><font
										size="1" face="verdana"><b>&nbsp;Brakish</b></font> <input
										type="radio" name="opType3" style="width: 12px; height: 13px"
										styleClass="mytext" onclick="javascript:getContam(this)"
										value="IRON" /><font size="1" face="verdana"><b>&nbsp;Iron</b></font>
									<input type="radio" name="opType4"
										style="width: 12px; height: 13px" styleClass="mytext"
										onclick="javascript:getContam(this)" value="OTHERS" /><font
										size="1" face="verdana"><b>&nbsp;Others</b></font>
								</fieldset>
							</div>
						</td>
					</tr>
				</table>
			</tr>
			<tr>
				<div id="FLOURIDE"
					style="position: relative; overflow-y: auto; left: 0; height: 34; width: 500; top: 0; display: none">
					<fieldset>
						<label>
							<table bordercolor="#000000" border="1"
								style="border-collapse: collapse;" width="100%" align=center>
								<tbody bgcolor="#FFFFFF">
									<nested:iterate id="ASSETOPENWELLS_LIST"
										property="assetOpenWells" indexId="ndx">
										<td align=left class="textborder"><bean:message
												key="app.floride" /></td>
										<td class="textborder" align=center><nested:text
												name="ASSETOPENWELLS_LIST" property="floride"
												styleClass="mytext" style="width:150px"
												onkeyup="extractNumber2(this,5,2,false);"
												onkeypress="return blockNonNumbers(this, event, true, false);" />%
										</td>
									</nested:iterate>
								</tbody>
								</tbody>
							</table>
						</label>
					</fieldset>
				</div>
			</tr>
			<tr>
				<div id="BRAKISH"
					style="position: relative; overflow-y: auto; left: 0; height: 34; width: 500; top: 0; display: none">
					<fieldset>
						<label>
							<table bordercolor="#000000" border="1"
								style="border-collapse: collapse;" width="100%" align=center>
								<tbody bgcolor="#FFFFFF">
									<nested:iterate id="ASSETOPENWELLS_LIST"
										property="assetOpenWells" indexId="ndx">
										<td align=left class="textborder"><bean:message
												key="app.brakish" /></td>
										<td class="textborder" align=center><nested:text
												name="ASSETOPENWELLS_LIST" property="brakish"
												styleClass="mytext" style="width:150px"
												onkeyup="extractNumber2(this,5,2,false);"
												onkeypress="return blockNonNumbers(this, event, true, false);" />%
									</nested:iterate>
								</tbody>
								</tbody>
							</table>
						</label>
					</fieldset>
				</div>
			</tr>
			<tr>
				<div id="IRON"
					style="position: relative; overflow-y: auto; left: 0; height: 34; width: 500; top: 0; display: none">
					<fieldset>
						<!-- <legend>Contamination Details</legend> -->
						<label>
							<table bordercolor="#000000" border="1"
								style="border-collapse: collapse;" width="100%" align=center>
								<tbody bgcolor="#FFFFFF">
									<nested:iterate id="ASSETOPENWELLS_LIST"
										property="assetOpenWells" indexId="ndx">
										<td align=left class="textborder"><bean:message
												key="app.iron" /></td>
										<td class="textborder" align=center><nested:text
												name="ASSETOPENWELLS_LIST" property="iron"
												styleClass="mytext" style="width:150px"
												onkeyup="extractNumber2(this,5,2,false);"
												onkeypress="return blockNonNumbers(this, event, true, false);" />%
									</nested:iterate>
								</tbody>
								</tbody>
							</table>
						</label>
					</fieldset>
				</div>
			</tr>
			<div id="OTHERS"
				style="position: relative; overflow-y: auto; left: 0; height: 45; width: 500; top: 0; display: none">
				<fieldset>
					<legend>Please Specify Other Contamination Type</legend>
					<label>
						<table bordercolor="#000000" border="1"
							style="border-collapse: collapse;" width="100%" align=center>
							<tbody bgcolor="#FFFFFF">
								<nested:iterate id="ASSETOPENWELLS_LIST"
									property="assetOpenWells" indexId="ndx">
									<td align=left width="140" class="textborder"><nested:text
											name="ASSETOPENWELLS_LIST" property="othersType"
											styleClass="gridText" style="width:90px" /></td>
									<td class="textborder" align=center><nested:text
											name="ASSETOPENWELLS_LIST" property="others"
											styleClass="mytext" style="width:150px"
											onkeyup="extractNumber2(this,5,2,false);"
											onkeypress="return blockNonNumbers(this, event, true, false);" />%
								</nested:iterate>
							</tbody>
							</tbody>
						</table>
					</label>
				</fieldset>
			</div>
			</tr>
			</div>
			<tr>
				<td>&nbsp;&nbsp;</td>
			</tr>
			<tr>
			<html:hidden property="token" styleClass="mytext"
					value="${sessionScope.csrfToken}" />
				<td align="center" colspan=4>
					<div align="center">
						<html:button property="add" title="Add the Fields"
							styleClass="btext" value="Add New"
							onclick="javascript: fnPickNewHabitations()" />
						<html:button property="save" title="Save the Fields"
							styleClass="btext" value="Save" onclick="savefunc()" />
						<html:reset title="Close the Window" styleClass="btext"
							value="Close" onclick="closeFunc()" />
					</div>
				</td>
			</tr>
			</table>
			<input type="hidden" name="subCompCode" value="openWellCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='Others'}">
		<html:form action="Asset.do?mode=Submit">
			<nested:iterate id="ASSETOTHERS_LIST" property="assetOthers"
				indexId="ndx">
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.generalCode" /></td>
					<td class="textborder" align=left><nested:text
							name="ASSETOTHERS_LIST" property="generalCode"
							styleClass="mytext" style="width:160px" readonly="true" /> <nested:text
							name="ASSETOTHERS_LIST" property="assetCode" styleClass="mytext"
							style="width:120px" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.selectHabs" /></td>
					<td align="left"><nested:text name="ASSETOTHERS_LIST"
							property="habCode" styleClass="mytext" style="width:130px"
							readonly="true" /> <html:button property="addHab" value="..."
							styleClass="btext"
							onclick='<%="javascript: fnPickNewHabitations()"%>' /></td>
					<td align=left class="textborder"><bean:message
							key="app.location" /></td>
					<td><nested:text name="ASSETOTHERS_LIST" property="location"
							maxlength="50" styleClass="mytext" style="width:160px"
							readonly="false" onkeypress="upperOnly()" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.componentName" /></td>
					<td><nested:text name="ASSETOTHERS_LIST"
							property="componentName" maxlength="50" styleClass="mytext"
							style="width:160px" readonly="false" onkeypress="upperOnly()" />
					</td>
					<td align=left class="textborder"><bean:message
							key="app.remarks" /></td>
					<td class="textborder" align=left><nested:text
							name="ASSETOTHERS_LIST" property="remarks" maxlength="50"
							styleClass="mytext" style="width:160px" readonly="false"
							onkeypress="upperOnly()" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.specialAssetType" /></td>
					<td><html:select name="ASSETOTHERS_LIST"
							property="specialAssetType" styleClass="mycombo"
							style="width:160px">
							<html:option value="">SELECT...</html:option>
							<html:option value="Spring">Spring</html:option>
							<html:option value="Solar">Solar</html:option>
							<html:option value="CTP">Community Treatment Plants </html:option>
						</html:select></td>
					<td align=left class="textborder"><bean:message
							key="app.yield" />(in LPD)</td>
					<td class="textborder" align=left><nested:text
							name="ASSETOTHERS_LIST" property="yield" maxlength="50"
							styleClass="mytext" style="width:160px" readonly="false"
							onkeypress="return numeralsOnly(event)" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.collectionTank" /></td>
					<td><html:select name="ASSETOTHERS_LIST"
							property="collectionTank" styleClass="mycombo"
							style="width:160px" onchange="tankDisable()">
							<html:option value="">SELECT...</html:option>
							<html:option value="Y">YES</html:option>
							<html:option value="N">NO</html:option>
						</html:select></td>
					<td align=left class="textborder"><bean:message
							key="app.collectionTankCapacity" /></td>
					<td class="textborder" align=left><nested:text
							name="ASSETOTHERS_LIST" property="collectionTankCapacity"
							maxlength="50" styleClass="mytext" style="width:160px"
							readonly="false" onkeypress="return numeralsOnly(event)" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.latitude" /></td>
					<td><nested:text name="ASSETOTHERS_LIST" property="latitude"
							maxlength="50" styleClass="mytext" style="width:160px"
							readonly="false" onkeypress="return decimalsOnly(event)" /></td>
					<td align=left class="textborder"><bean:message
							key="app.longitude" /></td>
					<td class="textborder" align=left><nested:text
							name="ASSETOTHERS_LIST" property="longitude" maxlength="50"
							styleClass="mytext" style="width:160px" readonly="false"
							onkeypress="return decimalsOnly(event)" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.elevation" /></td>
					<td><nested:text name="ASSETOTHERS_LIST" property="elevation"
							maxlength="50" styleClass="mytext" style="width:160px"
							readonly="false" onkeypress="return numeralsOnly(event)" /></td>
					<td align=left class="textborder"><bean:message
							key="app.wayPoint" /></td>
					<td class="textborder" align=left><nested:text
							name="ASSETOTHERS_LIST" property="wayPoint" maxlength="50"
							styleClass="mytext" style="width:160px" readonly="false"
							onkeypress="return numeralsOnly(event)" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.status" /></td>
					<td><html:select name="ASSETOTHERS_LIST" property="status"
							styleClass="mycombo" style="width:160px">
							<html:option value="">SELECT...</html:option>
							<html:option value="1">Working</html:option>
							<html:option value="2">Not Working</html:option>
						</html:select></td>
				</tr>
			</nested:iterate>
			<tr>
				<td>&nbsp;&nbsp;</td>
			</tr>
			<tr>
			<html:hidden property="token" styleClass="mytext"
					value="${sessionScope.csrfToken}" />
				<td align="center" colspan=4>
					<div align="center">
						<html:button property="add" title="Add the Fields"
							styleClass="btext" value="Add New"
							onclick="javascript: fnPickNewHabitations()" />
						<html:button property="save" title="Save the Fields"
							styleClass="btext" value="Save" onclick="savefunc()" />
						<html:reset title="Close the Window" styleClass="btext"
							value="Close" onclick="closeFunc()" />
					</div>
				</td>
			</tr>
			</table>
			<input type="hidden" name="subCompCode" value="generalCode">
		</html:form>
	</c:if>
	<c:if test="${sessionScope.assetsubCompParams=='SHP'}">
		<html:form action="Asset.do?mode=Submit">
			<nested:iterate id="ASSETSHP_LIST" property="assetSHP" indexId="ndx">
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.shallowHandPumpCode" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETSHP_LIST" property="assetCode" styleClass="mytext"
							style="width:0px" /> <nested:text name="ASSETSHP_LIST"
							property="shallowHandPumpCode" styleClass="mytext"
							style="width:160px" readonly="true" /></td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.habitation" /></td>
					<td class="textborder" align=center><nested:text
							name="ASSETSHP_LIST" property="habitation" maxlength="30"
							styleClass="mytext" style="width:160px" readonly="true"
							onkeypress="upperOnly()" /> <nested:hidden name="ASSETSHP_LIST"
							property="habCode" /></td>
					<td align=left class="textborder"><bean:message
							key="app.diameter" /></td>
					<td class="textborder" align=center><nested:text
							name="ASSETSHP_LIST" property="diameter" styleClass="mytext"
							style="width:100px" readonly="false"
							onkeyup="extractNumber2(this,9,2,false);"
							onkeypress="return blockNonNumbers(this, event, true, false);" />
					</td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.location" /></td>
					<td class="textborder" align=center><nested:text
							name="ASSETSHP_LIST" property="location" maxlength="50"
							styleClass="mytext" style="width:160px" readonly="false"
							onkeypress="upperOnly()" /></td>
					<td align=left class="textborder"><bean:message
							key="app.depth" /></td>
					<td class="textborder" align=center><nested:text
							name="ASSETSHP_LIST" property="depth" styleClass="mytext"
							style="width:100px" readonly="false"
							onkeyup="extractNumber2(this,9,2,false);"
							onkeypress="return blockNonNumbers(this, event, true, false);" />
					</td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.hygiene" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETSHP_LIST" property="hygiene" maxlength="5"
							styleClass="mytext" style="width:160px" readonly="false"
							onkeypress="return upperOnly()" /></td>
					<td align=left class="textborder"><bean:message
							key="app.avgNoOfHoursWorkingPerDay" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETSHP_LIST" property="avgNoOfHoursWorkingPerDay"
							styleClass="mytext" style="width:100px" readonly="false"
							onkeyup="extractNumber2(this,4,2,false);"
							onkeypress="return blockNonNumbers(this, event, true, false);" />
					</td>
				</tr>
				<tr>
					<td align=left class="textborder"><bean:message
							key="app.yeild" /><span class="mandatory">*</span>&nbsp;&nbsp;</td>
					<td class="textborder" align=center><nested:text
							name="ASSETSHP_LIST" property="yeild" styleClass="mytext"
							style="width:160px" readonly="false"
							onkeyup="extractNumber2(this,9,2,false);"
							onkeypress="return blockNonNumbers(this, event, true, false);" />
					</td>
					<td align=left class="textborder"><bean:message
							key="app.waterQuality" />&nbsp;&nbsp;</td>
					<td class="textborder" align=center><html:select
							name="ASSETSHP_LIST" property="waterQuality" styleClass="mycombo"
							style="width:100px" onchange="javaScript:qualityAffect()">
							<html:option value="">SELECT...</html:option>
							<html:option value="SAFE SOURCE">SAFE SOURCE</html:option>
							<html:option value="NSS">NSS</html:option>
						</html:select></td>
				</tr>
				<tr>
					<td class="textborder">Image</td>
					<td align=center><nested:equal name="ASSETSHP_LIST"
							property="imageStatus" value="Yes">
							<a href="#"
								onclick="openFile('<bean:write name="ASSETSHP_LIST" property="shallowHandPumpCode"/>')">View</a>&nbsp;
			</nested:equal> <nested:notEqual name="ASSETSHP_LIST" property="imageStatus"
							value="Yes">
							<p styleClass="mytext" style="width: 150px">Image not Exist</p>
						</nested:notEqual></td>
				</tr>
				<tr>
					<td class="textborder">Latitude-N</td>
					<td align=center><nested:text name="ASSETSHP_LIST"
							property="latitude" style="width:160px" styleClass="mytext"
							maxlength="10" onkeypress="decimalsOnly()" /></td>
					<td class="textborder">Longitude-E</td>
					<td align=center><nested:text name="ASSETSHP_LIST"
							property="longitude" style="width:100px" styleClass="mytext"
							maxlength="10" onkeypress="decimalsOnly()" /></td>
				</tr>
				<tr>
					<td class="textborder">Elevation</td>
					<td align=center><nested:text name="ASSETSHP_LIST"
							property="elevation" style="width:160px" styleClass="mytext"
							maxlength="10" onkeypress="decimalsOnly()" /></td>
					<td class="textborder">Waypoint</td>
					<td align=center><nested:text name="ASSETSHP_LIST"
							property="waypoint" style="width:100px" styleClass="mytext"
							maxlength="4" onkeypress="decimalsOnly()" /></td>
				</tr>
			</nested:iterate>
			<tr>
				<table id="conti" border="0">
					<tr>
						<td>
							<div
								style="position: relative; overflow-n: auto; left: 0; height: 34; width: 500; top: 0; display: block">
								<fieldset>
									<legend>Contamination Details</legend>
									<input type="radio" name="opType1"
										style="width: 12px; height: 13px" styleClass="mytext"
										onclick="javascript:getContam(this)" value="FLOURIDE" /><font
										size="1" face="verdana"><b>&nbsp;Flouride</b></font>
									&nbsp;&nbsp; <input type="radio" name="opType2"
										style="width: 12px; height: 13px" styleClass="mytext"
										onclick="javascript:getContam(this)" value="BRAKISH" /><font
										size="1" face="verdana"><b>&nbsp;Brakish</b></font> <input
										type="radio" name="opType3" style="width: 12px; height: 13px"
										styleClass="mytext" onclick="javascript:getContam(this)"
										value="IRON" /><font size="1" face="verdana"><b>&nbsp;Iron</b></font>
									<input type="radio" name="opType4"
										style="width: 12px; height: 13px" styleClass="mytext"
										onclick="javascript:getContam(this)" value="OTHERS" /><font
										size="1" face="verdana"><b>&nbsp;Others</b></font>
								</fieldset>
							</div>
						</td>
					</tr>
				</table>
			</tr>
			<tr>
				<div id="FLOURIDE"
					style="position: relative; overflow-y: auto; left: 0; height: 34; width: 500; top: 0; display: none">
					<fieldset>
						<label>
							<table bordercolor="#000000" border="1"
								style="border-collapse: collapse;" width="100%" align=center>

								<tbody bgcolor="#FFFFFF">

									<nested:iterate id="ASSETSHP_LIST" property="assetSHP"
										indexId="ndx">
										<td align=left class="textborder"><bean:message
												key="app.floride" /></td>
										<td class="textborder" align=center><nested:text
												name="ASSETSHP_LIST" property="floride" styleClass="mytext"
												style="width:150px"
												onkeyup="extractNumber2(this,5,2,false);"
												onkeypress="return blockNonNumbers(this, event, true, false);" />%
										</td>
									</nested:iterate>
								</tbody>
								</tbody>
							</table>
						</label>
					</fieldset>
				</div>
			</tr>
			<tr>
				<div id="BRAKISH"
					style="position: relative; overflow-y: auto; left: 0; height: 34; width: 500; top: 0; display: none">
					<fieldset>
						<label>
							<table bordercolor="#000000" border="1"
								style="border-collapse: collapse;" width="100%" align=center>
								<tbody bgcolor="#FFFFFF">
									<nested:iterate id="ASSETSHP_LIST" property="assetSHP"
										indexId="ndx">
										<td align=left class="textborder"><bean:message
												key="app.brakish" /></td>
										<td class="textborder" align=center><nested:text
												name="ASSETSHP_LIST" property="brakish" styleClass="mytext"
												style="width:150px"
												onkeyup="extractNumber2(this,5,2,false);"
												onkeypress="return blockNonNumbers(this, event, true, false);" />%
									</nested:iterate>
								</tbody>
								</tbody>
							</table>
						</label>
					</fieldset>
				</div>
			</tr>
			<tr>
				<div id="IRON"
					style="position: relative; overflow-y: auto; left: 0; height: 34; width: 500; top: 0; display: none">
					<fieldset>
						<!-- <legend>Contamination Details</legend> -->
						<label>
							<table bordercolor="#000000" border="1"
								style="border-collapse: collapse;" width="100%" align=center>

								<tbody bgcolor="#FFFFFF">
									<nested:iterate id="ASSETSHP_LIST" property="assetSHP"
										indexId="ndx">
										<td align=left class="textborder"><bean:message
												key="app.iron" /></td>
										<td class="textborder" align=center><nested:text
												name="ASSETSHP_LIST" property="iron" styleClass="mytext"
												style="width:150px"
												onkeyup="extractNumber2(this,5,2,false);"
												onkeypress="return blockNonNumbers(this, event, true, false);" />%
									</nested:iterate>
								</tbody>
								</tbody>
							</table>
						</label>
					</fieldset>
				</div>
			</tr>
			<tr>
				<div id="OTHERS"
					style="position: relative; overflow-y: auto; left: 0; height: 45; width: 500; top: 0; display: none">
					<fieldset>
						<legend>Please Specify Other Contamination Type</legend>
						<label>
							<table bordercolor="#000000" border="1"
								style="border-collapse: collapse;" width="100%" align=center>

								<tbody bgcolor="#FFFFFF">
									<nested:iterate id="ASSETSHP_LIST" property="assetSHP"
										indexId="ndx">
										<td align=left width="140" class="textborder"><nested:text
												name="ASSETSHP_LIST" property="othersType" maxlength="10"
												styleClass="gridText" style="width:130px"
												onkeypress="return upperOnly(event)" /></td>
										<td class="textborder" align=center><nested:text
												name="ASSETSHP_LIST" property="others" styleClass="mytext"
												style="width:150px"
												onkeyup="extractNumber2(this,5,2,false);"
												onkeypress="return blockNonNumbers(this, event, true, false);" />%
									</nested:iterate>
								</tbody>
								</tbody>
							</table>
						</label>
					</fieldset>
				</div>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<html:hidden property="token" styleClass="mytext"
					value="${sessionScope.csrfToken}" />
				<td align="center" colspan=4>
					<div align="center">
						<html:button property="add" title="Add the Fields"
							styleClass="btext" value="Add New"
							onclick="javascript: fnPickNewHabitations()" />
						<html:button property="save" title="Save the Fields"
							styleClass="btext" value="Save" onclick="savefunc()" />
						<html:reset title="Close the Window" styleClass="btext"
							value="Close" onclick="closeFunc()" />
					</div>
				</td>
			</tr>
			<input type="hidden" name="subCompCode" value="shallowHandPumpCode">
		</html:form>
	</c:if>

	<%@ include file="/commons/rws_alert.jsp"%>