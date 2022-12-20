<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<script language="javascript">
	function getData(key){
		document.forms[0].action="switch.do?prefix=/masters&page=/repairlnk.do?mode=data&mode1="+key;
		document.forms[0].submit();
	}
	function save(){	
		var asttype=document.forms[0].asttype.value;
		var astComp=document.forms[0].astComp.value;
		var souType=document.forms[0].souType.value;
		var repairType=document.forms[0].repairType.value;		
		if(asttype==null || asttype==''){
			alert("please select asset type");
			return false;
		}
		else{
			if(asttype=='01' || asttype=='02' || asttype=='03'|| asttype=='09' ){				
			if(astComp==null || astComp==""){				
				alert("please Select Asset Componennt ");
				return false;
			}
			else if(astComp=='01'){
				if(souType==null || souType==''){					
					alert("please Select Source Type ");
					return false;
				}
			}
			}
		}
		if(repairType==null || repairType=='')
		{
			alert("please Select Repair Type ");
			return false;
		}
			document.forms[0].action="switch.do?prefix=/masters&page=/repairlnk.do?mode=save";
			document.forms[0].submit();					
	}	
	function hideorshowComp(){
		var asttype=document.forms[0].asttype.value;
		if(asttype==null || asttype==''){
			document.getElementById('show').style.display='none';
			document.getElementById('show1').style.display='none';	
			
		}else if(asttype=='01' || asttype=='02' || asttype=='03'|| asttype=='09'){			
			document.getElementById('show').style.display='block';
			document.getElementById('show1').style.display='block';			
		}else{
			document.getElementById('show').style.display='none';		
			document.getElementById('show1').style.display='none';
		}
	}
	function hideorshowSource(){
		var asttype=document.forms[0].asttype.value;
		var astComp=document.forms[0].astComp.value;
		if(astComp==null || astComp=='' || asttype==null || asttype==''){
			document.getElementById('showSource').style.display='none';
			document.getElementById('showSource1').style.display='none';		
			
		}else if(astComp=='01' && (asttype=='01' || asttype=='02'||asttype=='03'||asttype=='09')){			
			document.getElementById('showSource').style.display='block';
			document.getElementById('showSource1').style.display='block';
		}else{
			document.getElementById('showSource').style.display='none';		
			document.getElementById('showSource1').style.display='none';
		}
	}
</script>
<body onload="hideorshowComp();hideorshowSource();">
	<html:form action="repairlnk.do">
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />	
		<table border=0 cellspacing=0 cellpadding=0 width="50%" bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff" ALIGN=CENTER>
			<caption>
				<table border=0 rules=none style="border-collapse: collapse" align="RIGHT">
					<tr align="right">
						<td class="bwborder"><a	href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>
					</tr>
				</table>
			</caption>
		</table>
		<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
			<jsp:param name="TableName"
				value="Repair Types for Assets and Components Entry" />
			<jsp:param name="TWidth" value="400" />
		</jsp:include>
		<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1" style="border-collapse: collapse;" width="440">
			<tr>
				<td>
					<table border=0 width="300" align=center
						style="margin-bottom: 5; margin-top: 5">
						<tr>
							<td class="btext2"><FONT class=myfontclr>Asset Type<font
									color="#FF6666">*</font></FONT></td>
							<td><html:select property="asttype" styleClass="mycombo"
									style="width:140px;height:20px" onchange="getData('comps');hideorshowComp();hideorshowSource();">
									<html:option value="">
										<font class="myfontclr1">SELECT...</font>
									</html:option>
									<logic:present name="asttypes">
										<html:options collection="asttypes" property="asttype"
											labelProperty="asttypecode" />
									</logic:present>
								</html:select></td>
						</tr>
						<tr>
							<td class="btext2">
								<div id="show" style="display: none;">
									<FONT class=myfontclr>Asset Component<font color="red">*</font></FONT>
								</div>
							</td>
							<td class="btext2">
								<div id="show1" style="display: none;">
									<html:select property="astComp" styleClass="mycombo"
										style="width:140px;height:20px" onchange="getData('sourcTypes');hideorshowComp();hideorshowSource();">
										<html:option value="">
											<font class="myfontclr1">SELECT...</font>
										</html:option>
										<logic:present name="astComps">
											<html:options collection="astComps" property="astCompCode"
												labelProperty="astCompName" />
										</logic:present>
									</html:select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="btext2">
								<div id="showSource" style="display: none;">
									<FONT class=myfontclr>Source Type<font color="red">*</font></FONT>
								</div>
							</td>
							<td class="btext2">
								<div id="showSource1" style="display: none;">
									<html:select property="souType" styleClass="mycombo"
										style="width:140px;height:20px">
										<html:option value="">
											<font class="myfontclr1">SELECT...</font>
										</html:option>
										<logic:present name="sourceTypes">
											<html:options collection="sourceTypes" property="sourceTypeCode"
												labelProperty="sourceTypeName" />
										</logic:present>
									</html:select>
								</div>
							</td>
						</tr>
						<tr>
							<td class="btext2"><FONT class=myfontclr>Repair Type<font
									color="#FF6666">*</font></FONT></td>
							<td><html:select property="repairType" styleClass="mycombo"
									style="width:140px;height:20px" >
									<html:option value="">
										<font class="myfontclr1">SELECT...</font>
									</html:option>
									<logic:present name="repairTypes">
										<html:options collection="repairTypes" property="repairCode"
											labelProperty="repairName" />
									</logic:present>
								</html:select></td>
						</tr>


					</table>
			<tr>
				<td colspan="2" align="center"><html:button property="mode"
						title="Save the Fields" styleClass="btext" value="save"
						onclick="return save()" /> <%-- <html:reset
						title="Clear all the Fields" styleClass="btext" value="Reset" /> --%>
					<html:submit property="mode" title="View the Fields"
						styleClass="btext" value="View" /></td>
			</tr>
		</table>

		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="400" />
		</jsp:include>

	</html:form>


	<%@ include file="/commons/rws_footer.jsp"%>
	<%@ include file="/commons/rws_alert.jsp"%>