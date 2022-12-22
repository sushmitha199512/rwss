<%@ page buffer="16kb" autoFlush="true" %>
<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%
String aa = (String)session.getAttribute("leadvalue");
session.setAttribute("leadvalue",aa);
String scheme= request.getParameter("typeOfAsset");
session= request.getSession(true);
String proposalId=(String)session.getAttribute("proposalId");
ArrayList data=new ArrayList();
String sessionId=session.getId();
String tabName1="";
String[] habsarray=null;
if(proposalId!=null){ 
	int k=0;
	String code = proposalId.substring(6,8);
	if(!(code.equals("11")|| code.equals("12")|| code.equals("13")|| code.equals("14"))){
		tabName1 = "rws_hab_selected_temp_tbl";
	}
	else if(code.equals("11")){
		tabName1 = "rws_sch_selected_temp_tbl";
	}
	else if(code.equals("12")){
		tabName1 = "rws_lab_selected_temp_tbl";
	}else if(code.equals("13")){
		tabName1 = "RWS_ANGAN_SELECTED_TEMP_TBL";
	}else if(code.equals("14")){
		tabName1 = "RWS_pi_SELECTED_TEMP_TBL";
	}				
	try{
   		ps=conn.prepareStatement("select * from  "+tabName1+"  where proposal_id='"+proposalId+"' and sid='"+sessionId+"'");
  		ResultSet rr= ps.executeQuery();
		while(rr.next()){  
        	if(code.equals("12")){
				data.add(rr.getString(2));		
			}
			else{
				data.add(rr.getString(2)+"@"+rr.getString(3));	
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
}
habsarray=new String[data.size()];  
for(int i=0;i<data.size();i++){
	habsarray[i]=(String)data.get(i);    
}
String noOfHabs = "0";int lengthHab=0;
if(habsarray!=null){
	noOfHabs = ""+habsarray.length;
 	lengthHab = Integer.parseInt(noOfHabs); 
}  
%>
<html>
<head>
	<script type="text/javascript">
		 function reloadPage(){
			window.parent.location.reload();
		    window.location.reload()
		 }
		var dExist='N';
		function getWorkCategory(){
			document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=workCategory";
			document.forms[0].submit();
		}
		function showFields(){
			if(document.forms[0].wrktype[1].checked){
				document.getElementById('mains2').style.display = 'block';
			}
			else{
			 	document.getElementById('mains2').style.display = 'none';
				document.forms[0].augsch.value='';
			}
			if(document.forms[0].typeOfAsset.value=='10'){
				document.getElementById('sustainDetails').style.display='block';
			}
			else {
				document.getElementById('sustainDetails').style.display='none';
			}			
			<% if(request.getAttribute("resetForm") == null) { %>
				if(document.forms[0].typeOfAsset.value=="") {}
			<%}%>
			if (document.forms[0].plan[0].checked){
				document.forms[0].wrktype[0].disabled=false;
				document.forms[0].wrktype[1].disabled=false;
				document.forms[0].wrktype[2].disabled=true;		   	
			} else if (document.forms[0].plan[1].checked){
				document.forms[0].wrktype[0].disabled=true;
			    document.forms[0].wrktype[1].disabled=false;
				document.forms[0].wrktype[2].disabled=false;
			} else {
			    document.forms[0].wrktype[0].disabled=false;
				document.forms[0].wrktype[1].disabled=false;
				document.forms[0].wrktype[2].disabled=true;
			}
			<%	if(request.getAttribute("duplicateExist")!= null && request.getAttribute("duplicateExist").equals("Y"))	{		    %>
		 		if(confirm("WORK EXIST - With Same Plan,Category,\nScheme,Programme,SubProgramme,\nCircle,No.Of Habs,Amount and Date.\nDo You Still Want To Save It ?")){
			        document.forms[0].elements["save"].disabled=true;
			        document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=Save";
					document.forms[0].submit();
				}
			<%	} else if(request.getAttribute("duplicateExist")!= null && request.getAttribute("duplicateExist").equals("N")){		    %>
			    document.forms[0].elements["save"].disabled=true;
			    document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=Save";
				document.forms[0].submit();
			<%	}		%>
		}
		
		function checkMe(type){
			if(type==0)	{
				document.forms[0].wrktype[0].checked=true;
			}
			else if(type==1){
				document.forms[0].wrktype[1].checked=true;
		    }    
		}
		
		function chkAll(len){
			for(var i=1;i<=len;i++){   
				document.forms[0].elements["chk['+i+'].remove"].checked=true;
			}
		}
		
		function clrAll(len){
			for(var i=1;i<=len;i++) {
				document.forms[0].elements["chk['+i+'].remove"].checked=true;
			}
		}
	
		function fnSubmit(){
			var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do";
			var frm = document.forms["AdminstrativeSanctionForm"];
			frm.action = url;
			frm.submit();
		}
	
		function fnAddWork(){
			var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=Add";
			var frm = document.forms["AdminstrativeSanctionForm"];
			frm.action = url;
			frm.submit();
		}
	
		function fnRemove(that){
			var frm = that.form;
			var removeIds = frm.elements("remove");	
			if(removeIds){
				var len = removeIds.length;
				var count = 0;
				if(typeof len != "number")
					removeIds = [removeIds];
				for(var i=0; i<len; i++){
					if(removeIds[i].checked)
				 		count++;
				}
				if(count == 0)
					alert("Please select atleast one work to remove!");
				else if(count == len)
					alert("You cannot remove all works!\nPlease de-select one work.");
				else {
					var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do" + "&mode=Remove";
					frm.action = url;
					frm.submit();		  
				}
			}
		}
		function fnGetOffices(that){
			var field = that.name;
		
			var frm = that.form;
			var url;
			if(field == 'headOfficeCode')
		 		url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do" + "&mode=circles";
			else if(field == 'circleOfficeCode')
		 		url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do" + "&mode=divisions";
			else if(field == 'divisionOfficeCode')	
				url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do" + "&mode=subdivisions";	
			else if(field == 'subdivisionOfficeCode') 
		 		url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do" + "&mode=assign";
			else if(field == 'prooved')
		 		url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do" + "&mode=assign";
			else if(field == 'approoved')	
				url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do" + "&mode=assign";	
			else if(field == 'coreDashboardStatus')	
				url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do" + "&mode=assign";	
		    frm.action = url;
			frm.submit();
		}
		
		function getScheme(){
			showFields();
			document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=scheme";
			document.forms[0].submit();
		}
		
		function getProgrammes() {
			if(document.forms[0].typeOfAsset.value=='10') {
				document.forms[0].prooved.value='Sustainability';
				document.forms[0].elements["sustainDetails"].style.display='block';
			}
			else {
				document.forms[0].prooved.value='';
				document.forms[0].elements["sustainDetails"].style.display='none';
			}
			document.forms[0].action="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=programmes";
			document.forms[0].submit();
		}
		
		function fnGetSubprogrammes(elem){
			var index = elem.name.substr(5,1);
			var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=subprogrammes" + "&index="+index;
			var frm = document.forms["AdminstrativeSanctionForm"];
			frm.action = url;
			frm.submit();
		}
		
		function fnGetSubprogrammes1(elem){
			var index = elem.name.substr(5,1);
			var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=subprogrammes1" + "&index="+index;
			var frm = document.forms["AdminstrativeSanctionForm"];
			frm.action = url;
			frm.submit();
		}
	
		var newWindow;
		function fnPickHabitations(index) {
		    var hoc=document.forms[0].elements["headOfficeCode"].value;
		    var coc=document.forms[0].elements["circleOfficeCode"].value;    
		    var subdivisionOfficeCode=document.forms[0].elements["subdivisionOfficeCode"].value;
		    var prooved=document.forms[0].elements["prooved"].value; 
			if(coc == '')
				alert("Please select circle.");	 	
			else {	
				var proposalId=document.forms[0].elements["WORK["+index+"].proposalId"].value;
				var assetcode=proposalId.substring(6,8);
				var width = 1000;
				var height = 375;
				var left = parseInt((screen.availWidth/2)-(width/2));
				var top = parseInt((screen.availHeight/2)-(height/2));	
				var url = "switch.do?prefix=/proposals&page=/PickAdminHabitation.do&mode=pickhab"
						+ "&hoc="+hoc+"&coc="+coc+"&proposalId="+proposalId
						+ "&index="+index+"&assetcode="+assetcode+"&All=yes&subdivisionOfficeCode="+subdivisionOfficeCode+"&prooved="+prooved;
		    	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
						+ "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,"
						+ "resizable=no";
				if( !newWindow || newWindow.closed) {
					newWindow = window.open(url, "", properties);
				}
				else {
					newWindow.focus();
				}
			}
		}
		function fnShowAugmentationWork(index) {   
			var workId=document.forms[0].elements["WORK["+index+"].proposalId"].value;
	    	var workName=document.forms[0].elements["WORK["+index+"].proposalName"].value;
	    	if(workId!='')  {
	        	var checkField=document.forms[0].elements["WORK["+index+"].augmentation"];
				if(checkField.checked) {
					var proposalId=documents.forms[0].elements["WORK["+index+"].proposalId"].value;
					var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do?workId="+workId+"&workName="+workName+"&mode=Add New";
					var properties = "width=648,height=380,toolbar=no,status=no,menubar=no,location=no,directories=no," + "scrollbars=yes,copyhistory=no,resizable=no";
					newWindow = window.open(url, "", properties);
				}
			}
			else{
				alert("Enter WorkId & Name");
				document.forms[0].elements["WORK["+index+"].augmentation"].checked=false;
				return;
			}
		}
		
		function validateWorks() {
			var scheme=document.forms[0].typeOfAsset.value;
			var workCount=document.forms[0].elements["workCount"].value;
			var workName;
			var noOfHabs;
			var noOfLabs;
			var sancAmt;
			var adminNum;
			var adminDate;
			var estimateCostElem;
			var message ="";
			for(var i=0; i<workCount; i++) {
				workName=document.forms[0].elements["WORK["+i+"].proposalName"].value;
				noOfHabs=document.forms[0].elements["WORK["+i+"].noOfHabs"].value;
				sancAmt=document.forms[0].elements["WORK["+i+"].sanctionAmout"].value;
				adminNum=document.forms[0].elements["WORK["+i+"].adminiStrativeNum"].value;
				adminDate=document.forms[0].elements["WORK["+i+"].adminiStrativeDate"].value;
				estimateCostElem=document.forms[0].elements["WORK["+i+"].estimateCost"];
				if(workName.length == 0 || workName == '')
					message+="Work Name with S.No:" + (i+1) + " is required\n"; 
				if(sancAmt.length == 0 || sancAmt == '')
					message+="Sanction Amount with S.No:" + (i+1) + " is required\n"; 
				if(adminNum.length == 0 || adminNum == '')
					message+="Admin.Sanction Number with S.No:" + (i+1) + " is required\n"; 
				if(adminDate.length == 0 || adminDate == '')
					message+="Admin. Sanction Date with S.No:" + (i+1) + " is required\n"; 
				message+=securityCheck(workName);
		   }
	   	   var admDate=document.forms[0].elements["WORK[0].adminiStrativeDate"].value;
	   	   var dt=admDate.split('/');
	   	   var rdt=dt[1]+'/'+dt[0]+'/'+dt[2];
	       var revdt = new Date(rdt);
	       var sysdt = new Date();
	       if (revdt.getTime() > sysdt.getTime()) {
	 	 		message+="Admin Sanction Date cannont be greater than Current Date.";
	 	   }
	 	   if(document.forms[0].wrktype[1].checked) {
	   			if(document.forms[0].typeOfAsset.value!='10') {
					if(document.forms[0].augsch.value == null || document.forms[0].augsch.value == ""){
			   			message +="Please Select Augumentation Scheme";
			   		}
		   		}
			   	else {
			   		if(document.forms[0].sustainDetails.value==""){
			   			message += "Please Select Sustainability Options for Sustainability Scheme";
			   		}
			   	}
		   } 	   
		   if(message.length >0){
				alert(message);
				return false;
		   }
		   if(document.forms[0].typeOfAsset.value=='10'){
		   		if(document.forms[0].sustainDetails.value==""){
		   			message += "Please Select Sustainability Options for Sustainability Scheme";
		   		}
		   }
		   if(message.length >0){
				alert(message);
				return false;
		   }
		   var lengthHabs = <%=noOfHabs%>;
		   if(parseInt(lengthHabs)==0){
				alert("Please Add Habitations/Schools/Labs/Anganwadis/Public Institutes");
				return false;
		   }
	  	   return true;
		}
		
		function fnView(that){  
			var coc=document.forms[0].elements["circleOfficeCode"].value;
	
			if(coc=="")	{
				alert("Select Circle");
			}
			else {
				var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=View";
				document.forms[0].action=url;
				document.forms[0].submit();
			}
		}
		
		function fnSave(that){ 
			var scheme=document.forms[0].typeOfAsset.value;
			var leadradio;                                                     
		    var sub=false;
		    if(validateAdminstrativeSanctionForm(AdminstrativeSanctionForm)) {
				if(validateWorks()) {
				  	sub=true;
				}
			}
	    	if(sub) {
				if(dExist == 'N') {
					var checkLead = "false";
					var lengthHabs = <%=lengthHab%>;		
					if(lengthHabs!="1" && (document.forms[0].typeOfAsset.value!="11" && document.forms[0].typeOfAsset.value!="12"&& document.forms[0].typeOfAsset.value!="13"&& document.forms[0].typeOfAsset.value!="14")) {
						for(var v=0;v<document.forms[0].leads.length;v++) {				
							if(document.forms[0].leads[v].checked){				
								leadradio = document.forms[0].leads[v].value;
								checkLead="true";
							}
						}
						if(checkLead=="false"){
							alert("Select One of the Habitation as a Lead Habitation");
						}
						else{
							if(document.forms[0].wrktype[0].checked){
								if(confirm("Attention:\nDo you want Save this Work Under Main Scheme \nif this Work is under Augmentation Please Select Augmentation \nOnce it is Saved under MainScheme we can not convert MainScheme to Augmentation \nPress OK to continue or Press CANCEL to change the work type")){
									var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?leadhab="+leadradio+"&mode=Save";
									document.forms[0].action=url;
									document.forms[0].submit();
								}
							}
							else {
								var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save";
								document.forms[0].action=url;
								document.forms[0].submit();
							}
						}
					}
					else {
						if(document.forms[0].wrktype[0].checked){
							if(confirm("Attention:\nDo you want Save this Work Under Main Scheme \nif this Work is under Augmentation Please Select Augmentation \nOnce it is Saved under MainScheme we can not convert MainScheme to Augmentation \nPress OK to continue or Press CANCEL to change the work type")){
								leadradio = document.forms[0].leads.value;
								var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save";
								document.forms[0].action=url;
								document.forms[0].submit();
							}
						}
						else {
							leadradio = document.forms[0].leads.value;
							var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?leadlab="+leadradio+"&mode=Save";
							document.forms[0].action=url;
							document.forms[0].submit();
						}
					}			
				}
	    	}
		}
	
		function showWorks(){
			 var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do?mode=getWorks";
			 var width = 638;
			 var height = 332;
			 var left = parseInt((screen.availWidth/2)-(width/2));
			 var top = parseInt((screen.availHeight/2)-(height/2));	 		
		     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				 + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,resizable=yes,status=yes";
			 if( !newWindow || newWindow.closed){
				newWindow = window.open(url, "", properties);
			 }
			 else {
				newWindow.focus();
			 }
		}
		
		function securityCheck(str){
			var message ="";
			if(str.indexOf("img")!=-1){
				message+="img is not allowed in work Name\n";
			}
			if(str.indexOf("script")!=-1){
				message+="script is not allowed in work Name\n";
			}
			if(str.indexOf("src")!=-1){
				message+="src is not allowed in work Name\n";
			}
			if(str.indexOf("iframe")!=-1){
				message+="iframe is not allowed in work Name\n";
			}
			if(str.indexOf("EMBED")!=-1){
				message+="EMBED is not allowed in work Name\n";
			}
			if(str.indexOf("OBJECT")!=-1){
				message+="OBJECT is not allowed in work Name\n";
			}
			if(str.indexOf("alert")!=-1){
				message+="alert is not allowed in work Name\n";
			}
			if(str.indexOf("\\")!=-1){
				message+=" \\\\ is not allowed in work Name\n";
			}
			return message;
		}
	</script>
	<style>
		select11 {
		    border: 0 none;
		    color: green;
		    background: transparent;
		    font-size: 20px;
		    font-weight: bold;
		    padding: 2px 10px;
		    width: 378px;
		    *width: 350px;
		    *background: #58B14C;
		}
	</style>
</head>
<body onload="showFields();">
	<html:javascript formName="AdminstrativeSanctionForm" htmlComment="true" />
	<%@ include file="/commons/rws_header2.jsp" %>
	<html:form action="AdminstrativeSanctionSaveForm" method="post"> 
		<table cellpadding="0" cellspacing="0">
			<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;<br/><a href="./help/AdminSanctionHelp.doc" target="_new"><img src="/pred/images/new1.gif" align="right" border=0><b>&raquo;&raquo;&raquo;Click for Help&laquo;&laquo;&laquo;</a></caption>
			<thead>
				<tr>
					<th>
						<jsp:include page="/commons/TableHeader.jsp">
							<jsp:param name="TableName" value="Administrative Sanction Form" />
							<jsp:param name="TWidth" value="100%" />
						</jsp:include>
					</th>
				</tr>
			</thead>
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
				<tr>
					<td>
						<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
							<tr>
								<td>
									<fieldset>
										<legend><bean:message key="legend.rwsOffices"/></legend>
										<label>
											<table>
												<tbody class="formTBody">
													<tr>
														<td class="column1">
															<bean:message key="app.headoffice" />
															<span class="mandatory">*</span>
														</td>
														<td class="column2">
															<logic:equal name="RWS_USER" property="headOfficeCode" value="0"> 
																<html:select property="headOfficeCode" onchange="javascript: fnGetOffices(this)" styleClass="combo">
																	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																	<html:options collection="headOffices" name="labelValueBean" property="value" labelProperty="label" />
																</html:select>
															</logic:equal>
															<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
																<html:text property="headOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
																<html:hidden property="headOfficeCode" name="RWS_USER"/>
															</logic:notEqual> 
														</td>
												        <td class="column3">
												         	<html:radio value="1" property="plan" onclick="showFields();checkMe(0);getWorkCategory()"/>Plan
												        </td>
												        <td class="class4">
												         	<html:radio value="2" property="plan" onclick="showFields();getWorkCategory();"/>Non-Plan
												    	</td> 
    	 											</tr>
													<tr>
														<td class="column1"> Work Category <span class="mandatory">*</span></td>
												        <td class="class2">
													         <html:select property="workCat"  onchange="JavaScript:getScheme();">
													    		<html:option value="">SELECT...</html:option>
													    		<logic:notEmpty name="workcategory1">
													    		<html:options collection="workcategory1" name="labelValueBean" property="value" labelProperty="label" />
													    		</logic:notEmpty>
													    	</html:select>
												    	</td>
												    	<td class="column3"> Scheme	<span class="mandatory">*</span></td>
														<td class="column4">
													 		<html:select property="typeOfAsset" styleClass="combo" onchange="getProgrammes();">
																<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
														 		<logic:notEmpty name="assetTypes1">	<html:options collection="assetTypes1" name="labelValueBean" property="value" labelProperty="label" /></logic:notEmpty>
														 	</html:select>
											 		  	</td>
 		  											</tr>
											 		<tr>
											 		  	<td colspan=4>
											 		  		<div id="sustainDetails" style="display:none">
											 		  			<table align=right>
											 		  				<tr>
											 		  					<td><font face=verdana size=2><b>Sustainability Options<span class="mandatory">*</span></b></font></td>
											 		  					<td class="column3">
											 		  						<html:select property="sustainDetails" styleClass="mycombo">
																				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																				<html:option value="01">Infiltration Rings</html:option>
																				<html:option value="02">Recharge Pits</html:option>
																				<html:option value="03">Check Dams</html:option>
																				<html:option value="04">Percolation Tanks</html:option>
																				<html:option value="05">Sub-surface Dykes</html:option>
																				<html:option value="06">Injection Wells</html:option>
																				<html:option value="07">Rain Water Harvesting Structure</html:option>
																				<html:option value="08">Soak Pit for Handpump</html:option>
																				<html:option value="09">Removal of Defunct HP</html:option>
																				<html:option value="10">Revival of Traditional Water Harvesting Structures</html:option>
																				<html:option value="11">Ponds/Tanks</html:option>
																				<html:option value="12">Others</html:option>
													  						</html:select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													 					</td>
												  					</tr>
												  				</table>
												  			</div>
												  		</td>
												  	</tr>
											 		<tr>
											          <td colspan="2" nowrap>
														<html:radio value="1" property="wrktype" onclick="getProgrammes();"/>MainScheme
											           	<html:radio value="2" property="wrktype" onclick="checkMe(1);getProgrammes();"/>Augmentation
														<html:radio value="3" property="wrktype" onclick="getProgrammes();"/>Maintenance
											          </td>
											          <td colspan="2">
													     <div id="mains2" style="display:none">Augmentation Link<span class="mandatory">*</span>&nbsp;&nbsp;			
															<html:text property="augsch" style="width:120px" styleClass="thin-text-box" readonly="true"/>
															<html:button property="mode" value="..." style="width:25px" styleClass="btext" title="Click Here" onclick='<%= "javascript: showWorks()"%>' />
												         </div>
													  </td>
													<tr>
														<td class="column1">Programme<span class="mandatory">*</span></td>
														<td class="column2">
															<html:select property="programs" style="width:150px" styleClass="mycombo" onchange="javascript: fnGetSubprogrammes(this);checkLinkAug();" >
													           	<html:option value=""><font class="myfontclr1">SELECT...</html:option>
													            <logic:present name="programmes1" >
													             	<html:options collection="programmes1"  name="labelValueBean" property="value" labelProperty="label" />
												        	    </logic:present>
													        </html:select>
														</td>
													 	<td class="column3">Sub Programme <span class="mandatory">*</span></td>
														<td class="column4">
													 		<html:select property="subPrograms"  style="width:150px" onchange="javascript: fnGetSubprogrammes1(this)" styleClass="combo">
																<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																<logic:present name="SubPrograms1">
															 		<html:options collection="SubPrograms1" name="SubPrograms" property="value" labelProperty="label" />
																</logic:present>			  
													 		</html:select>
													 	</td>
													</tr>
													<tr>        
													 	<td class="column1">
															<bean:message key="app.circle" /><span class="mandatory">*</span>
														</td>
														<td class="column2">
													       <logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
														   <html:select property="circleOfficeCode" onchange="javascript:fnGetOffices(this)" styleClass="combo">
																<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																<logic:notEmpty name="circles1">
																	<html:options collection="circles1" name="labelValueBean" property="value" labelProperty="label" />
																</logic:notEmpty>			  
															</html:select>
													        </logic:equal>
													        <logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00"> 
																<html:text property="circleOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
																<html:hidden property="circleOfficeCode" name="RWS_USER" />
													        </logic:notEqual>
														</td>
														<td class="column3"><bean:message key="app.division"/>
															<span class="mandatory">*</span>
														</td>
														<td class="column4">
															<logic:equal name="RWS_USER" property="divisionOfficeCode"  value="0" >
																<html:select property="divisionOfficeCode" onchange="javascript:fnGetOffices(this);" styleClass="combo" >
																	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																	<logic:notEmpty name="divisions1">
																		<html:options collection="divisions1" name="labelValueBean" property="value" labelProperty="label" />
																	</logic:notEmpty>			  
																</html:select>
														    </logic:equal>
														    <logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0" > 
																<html:text property="divisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
																<html:hidden property="divisionOfficeCode" name="RWS_USER" />
														    </logic:notEqual>
														</td>
													</tr>
													<tr>	
														<td class="column1">SubDivision</td>
												        <td class="column2">
												    		<logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="0">
																<html:select property="subdivisionOfficeCode" styleClass="combo" onchange="javascript:fnGetOffices(this);">
																	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																	<logic:notEmpty name="subdivisions1">
																		<html:options collection="subdivisions1" name="labelValueBean" property="value" labelProperty="label" />
																	</logic:notEmpty>
																</html:select>
															</logic:equal>
															<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
																<html:text property="subdivisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
																<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
															</logic:notEqual>
														</td>
														<td class="column1">Approved Under<span class="mandatory">*</span></td>
												        <td class="column2">
															<html:select property="prooved" styleClass="combo" onchange="javascript:fnGetOffices(this);">
																<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																<html:option value="Normal Coverage">Normal Coverage</html:option>
																<html:option value="Submission">Submission(Water Quality)</html:option>
																<html:option value="Sustainability">Sustainability</html:option>
															</html:select>
														</td>
													</tr>
												`	<tr>
														<td class="column3">State Approved Under</td>
											           	<td class="column4">
															<html:select property="approoved" styleClass="combo" onchange="javascript:fnGetOffices(this);">
																<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																<html:option value="SVS">SVS</html:option>
																<html:option value="MVS">MVS</html:option>
																<html:option value="NTR Sujala">NTR Sujala</html:option>
																<html:option value="Natural Calamities">Natural Calamities</html:option>
																<html:option value="Drought">Drought</html:option>
															</html:select>
														</td>
														<td class="column3">CM-SEC Dashboard</td>
											           	<td class="column4">
															<html:select property="coreDashboardStatus" styleClass="combo" onchange="javascript:fnGetOffices(this);">
																<html:option value="Y">YES</html:option>
																<html:option value="N">NO</html:option>
														 	</html:select>
														</td>	
													</tr>	
												</tbody>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<tr>							
								<td>
									<fieldset>
										<legend><bean:message key="legend.workDetails" /></legend>
										<label>
											<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
												<thead class="gridHeader">
													<tr>
														<th rowspan="2" nowrap>S. No.</th>
														<th rowspan="2"><bean:message key="app.select" /></th>
														<th width="15%" rowspan="2">Work Id</th>
														<%if(request.getParameter("typeOfAsset")!=null && !((request.getParameter("typeOfAsset").equals("11") ||request.getParameter("typeOfAsset").equals("12")||request.getParameter("typeOfAsset").equals("14")||request.getParameter("typeOfAsset").equals("13")))){%>
														<th rowspan="2">Select Habs</th>
														<%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11")){%>
														<th rowspan="2" >Select Schools</th>
														<%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12")){%>
														<th rowspan="2" >Select Labs</th> 
														<%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("13")){%>
														<th rowspan="2" >Select Anganwadis</th> 
														<%} else if(request.getParameter("typeOfAsset")!=null && (request.getParameter("typeOfAsset").equals("14") )){%>
														<th rowspan="2">Select Public Institutions</th>
														<%}
														else {%>
														<th rowspan="2" >Select</th> 
														<%}%>
														<th rowspan="2"><bean:message key="app.workName" /></th>
													  	<th rowspan="2">Sanctioned Amount(Rs. in Lakhs)</th>
													 	<th colspan="2"  width="25%">Adminstrative Sanction </th>
												 		<th rowspan="2">More Than One Programme</th>
														<th rowspan="2"><bean:message key="app.remarks" /></th>
													</tr>
													<tr>
														<th width="15%">Number</th>
														<th>Date</th>
													</tr>
												</thead>
												<tbody>
													<% int workCount = 0; int count=0,index=1;%>
													<nested:iterate id="WORK" property="proposals" indexId="ndx">
														<% workCount++; %>
														<tr bgcolor="#ffffff">
															<td width="40px" align="center"><font face="verdana" size="2"><%=index++%></font></td>
															<td width="40px" align="center"><input type="checkbox" name="remove" value="<%= ndx%>"></td>
															<td><nested:text name="WORK" property="proposalId" indexed="true" readonly="true" style="width:100px;text-align: center" styleClass="noborder-text-box"/></td>
															<td nowrap>
																<nested:text name="WORK" property="noOfHabs" indexed="true" readonly="true" styleClass="noborder-text-box" style="width: 25px"/>
																<html:button property="addHab" value="..." styleClass="btext" onclick='<%= "javascript: fnPickHabitations(\" + ndx +\")"%>' />
															</td>
															<td>
																<nested:text name="WORK" property="proposalName" indexed="true" maxlength="300" style="width: 120px" styleClass="noborder-text-box" onkeypress="return textOnly(),securityCheck(this.value);" />
															</td>
															<td>
																<nested:text name="WORK" property="sanctionAmout" indexed="true" maxlength="9" style="width: 55px;text-align: right" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
															</td>
															<td>
																<nested:text name="WORK" property="adminiStrativeNum" indexed="true" maxlength="50" style="width: 100px;text-align: left" styleClass="noborder-text-box"/>
															</td>
															<td NOWRAP>
																<nested:text name="WORK" property="adminiStrativeDate" indexed="true" readonly="true" maxlength="15" style="width: 70px;text-align: right"/><a href="javascript:showCalendar(document.forms[0].elements['WORK[<%=count++%>].adminiStrativeDate']);">
													       		<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
											 				</td>
											 				<td align="center">
																<nested:checkbox name="WORK" property="augmentation" value="Y" indexed="true" onclick='<%= "javascript: fnShowAugmentationWork(\"+ndx+\")"%>'/>
																<nested:hidden name="WORK" property="workId" indexed="true"/>
															</td>
															<td>
																<nested:text name="WORK" property="remarks" indexed="true" style="width: 60px;" styleClass="noborder-text-box" onkeypress="return textOnly()"/>
															</td>
														</tr>
													</nested:iterate>
													<input type="hidden" name="workCount" value="<%= workCount %>">
												</tbody>
											</table>
											<table width="100%">
												<tbody>
													<tr>
														<td align="left"></td>
														<td align="right">
														<%
															int sp = 0;
															if(request.getAttribute("special") != null && !request.getAttribute("special").equals(""))sp = Integer.parseInt((String)request.getAttribute("special"));
														%>
														</td>
													</tr>
												</tbody>
											</table>
										</label>
									</fieldset>	
								</td>
							</tr>
							<%if(request.getParameter("typeOfAsset")!=null && !(request.getParameter("typeOfAsset").equals("11")  || request.getParameter("typeOfAsset").equals("12")|| request.getParameter("typeOfAsset").equals("13")|| request.getParameter("typeOfAsset").equals("14"))){ %>
							<tr>
								<td>
        							<fieldset>
										<legend><bean:message key="legend.habitationDetails" /></legend>
										<label>
											<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
												<thead class="gridHeader">
													<tr>
														<th><bean:message key="app.leadHabitation" /></th>
														<th><bean:message key="app.habitationCode" /></th>
														<th><bean:message key="app.habitationName" /></th>
													</tr>
												</thead>
												<tbody class="gridText">
													<%
														if(habsarray!=null){
															if(habsarray.length==1){
													%>
													<tr>
														<td><input type="radio" name="leads" value="<%=habsarray[0].substring(0,16)%>" checked></td>
														<td><%=habsarray[0].substring(0,16)%></td>
														<td><%=habsarray[0].substring(17,habsarray[0].length())%></td>
													</tr>
													<%	 	 } else {	
															 	for(int i=0;i<habsarray.length;i++){ 
													
													%>
													<tr>
														<td><input type="radio" name="leads" value="<%=habsarray[i].substring(0,16)%>"></td>
														<td><%=habsarray[i].substring(0,16)%></td>
														<td><%=habsarray[i].substring(17,habsarray[i].length())%></td>
													</tr>
													<%			}
															  } 
														}else { System.out.println("Getting null value");}
													%>
												</tbody>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							
							
							<%} if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("13")) { %>
							<tr>
								<td>
									<fieldset>
										<legend>Anganwadi Details</legend>
										<label>
											<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
											<thead class="gridHeader">
												<tr>
													<th><bean:message key="app.habitationCode" /></th>
													<th>Anganwadi Code-Hab Name-Anganwadi Name</th>
												</tr>
											</thead>
											<tbody class="gridText">
											<%
												if(habsarray!=null){
												     if(habsarray.length==1){
											%>
												<tr>
													<input type="hidden" name="leads" value="<%=habsarray[0].substring(0,16)%>" checked />
													<td><%=habsarray[0].substring(0,16)%></td>
													<td><%=habsarray[0].substring(17,habsarray[0].length())%></td>
												</tr>												
											<%		 } else { 
														for(int i=0;i<habsarray.length;i++){
											%>
												<tr>
													<input type="hidden" name="leads" value="<%=habsarray[i].substring(0,16)%>" />
													<td><%=habsarray[i].substring(0,16)%></td>
													<td><%=habsarray[i].substring(17,habsarray[i].length())%></td>
												</tr>
											<%			}
													} 
												}
											%>
											</tbody>
										</table>
									</label>
								</fieldset>
							</td>
						</tr>
							
							
							
							<%} if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11")) { %>
							<tr>
								<td>
									<fieldset>
										<legend>School Details</legend>
										<label>
											<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
											<thead class="gridHeader">
												<tr>
													<th><bean:message key="app.habitationCode" /></th>
													<th>School Code-Hab Name-School Name</th>
												</tr>
											</thead>
											<tbody class="gridText">
											<%
												if(habsarray!=null){
												     if(habsarray.length==1){
											%>
												<tr>
													<input type="hidden" name="leads" value="<%=habsarray[0].substring(0,16)%>" checked />
													<td><%=habsarray[0].substring(0,16)%></td>
													<td><%=habsarray[0].substring(17,habsarray[0].length())%></td>
												</tr>												
											<%		 } else { 
														for(int i=0;i<habsarray.length;i++){
											%>
												<tr>
													<input type="hidden" name="leads" value="<%=habsarray[i].substring(0,16)%>" />
													<td><%=habsarray[i].substring(0,16)%></td>
													<td><%=habsarray[i].substring(17,habsarray[i].length())%></td>
												</tr>
											<%			}
													} 
												}
											%>
											</tbody>
										</table>
									</label>
								</fieldset>
							</td>
						</tr>
						<%} if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12")) { %>	
						<tr>
							<td>
								<fieldset>
									<legend>Lab Details</legend>
									<label>
										<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
											<thead class="gridHeader">
												<tr>
													<th>Lab Code</th>
													<th>Lab Name-Location</th>
												</tr>
											</thead>
											<tbody class="gridText">
												<%	if(habsarray!=null){ 
														if(habsarray.length==1)	{
												%>
												<tr>
													<input type="hidden" name="leads" value="<%=habsarray[0].substring(0,3)%>" checked />
													<td><%=habsarray[0].substring(0,3)%></td>
													<td><%=habsarray[0].substring(3,habsarray[0].length())%></td>
												</tr>
												<%    	} else { 
															for(int i=0;i<habsarray.length;i++){
												%>
												<tr>
													<input type="hidden" name="leads" value="<%=habsarray[i].substring(0,3)%>" />
													<td><%=habsarray[i].substring(0,3)%></td>
													<td><%=habsarray[i].substring(3,habsarray[i].length())%></td>
												</tr>			
												<%			}
														}
													} 
												%>
											</tbody>
										</table>
									</label>
								</fieldset>
							</td>
						</tr>
						<%	}  if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("14")) { %>
							<tr>
								<td>
									<fieldset>
										<legend>Public Institutions Details</legend>
										<label>
											<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
											<thead class="gridHeader">
												<tr>
													<th><bean:message key="app.habitationCode" /></th>
													<th>PI Code-Hab Name-PI Name</th>
												</tr>
											</thead>
											<tbody class="gridText">
											<%
												if(habsarray!=null){
												     if(habsarray.length==1){
											%>
												<tr>
													<input type="hidden" name="leads" value="<%=habsarray[0].substring(0,16)%>" checked />
													<td><%=habsarray[0].substring(0,16)%></td>
													<td><%=habsarray[0].substring(17,habsarray[0].length())%></td>
												</tr>												
											<%		 } else { 
														for(int i=0;i<habsarray.length;i++){
											%>
												<tr>
													<input type="hidden" name="leads" value="<%=habsarray[i].substring(0,16)%>" />
													<td><%=habsarray[i].substring(0,16)%></td>
													<td><%=habsarray[i].substring(17,habsarray[i].length())%></td>
												</tr>
											<%			}
													} 
												}
											%>
											</tbody>
										</table>
									</label>
								</fieldset>
							</td>
						</tr>
						<%}%>		
						<tr>
							<td>
		 						<table width="100%">
		   	 						<tr>
		   	 							<td align="center">
		  									<input type="button" value="Save" name="save" class="btext" onclick="JavaScript:fnSave(this);">          
       										<html:reset property="mode" styleClass="btext" onclick="Reset();"><bean:message key="button.clear" /></html:reset>
	      									<input type="button" value="View" name="mode" class="btext" onclick="JavaScript:fnView(this);">    
             							</td>
		    						</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
 	<html:hidden property="init" />
	<html:hidden property="userId" name="RWS_USER" />
	<html:hidden property="officeCode" name="RWS_USER" />
	<input type="hidden" name="special" value="">
</html:form>

<% 
	if(session.getAttribute("adminflag")!=null && ((String)session.getAttribute("adminflag")).equals(session.getId()+"true")){
    	try{
    		session.setAttribute("adminflag",session.getId()+"false"); 
    	}catch(Exception e){ 
    		e.printStackTrace(); 
    	}
	} 
%>
<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />
<script>
	document.forms[0].elements["WORK[0].noOfHabs"].value='<%=noOfHabs%>';
</script>
</body>
</html>