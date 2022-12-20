<%@page import="nic.watersoft.drought.RwsDroughtNewsItemForm"%>
<%@ include file="/commons/rws_SpecialHeader.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>


<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<%
	int count = 1;
%>
<style>
.thumbnail {
	position: relative;
	z-index: 0;
	margin-left: 20px;
}

.thumbnail:hover {
	z-index: 50;
	cursor: pointer;
}

.thumbnail span { /*CSS for enlarged image*/
	position: absolute;
	left: -9999px;
	background-color: #eae9d4;
	padding: 10px;
	font-family: 'Droid Sans', sans-serif;
	font-size: .9em;
	text-align: center;
	color: #495a62;
	-webkit-box-shadow: 0 0 20px rgba(0, 0, 0, .75));
	-moz-box-shadow: 0 0 20px rgba(0, 0, 0, .75);
	box-shadow: 0 0 20px rgba(0, 0, 0, .75);
	-webkit-border-radius: 8px;
	-moz-border-radius: 8px;
	border-radius: 8px;
}

.thumbnail span img {
	padding: 2px;
	background: #ccc;
}

.thumbnail:hover span {
	top: -280px;
	left: -250px;
	width: 50px;
	height: 50px;
}
</style>
<script lang="javascript">


function autocompletion() {
	for (i = 0; i < document.forms.length; i++) {
		document.forms[i].setAttribute("AutoComplete", "off");
	}
}

function fnDelete(newsId)
{

	if(newsId==""){
	alert("Data is not there");
	}
	else{
		document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=delete&newsId="+newsId;
		document.forms[0].submit();
	}
	
}
<%-- function showDivs1()
{
	var wCount = '<%=workCount%>';
	alert("hi--");
	var zeroExistsOrNot = false;
	alert("hi--");
	document.getElementById('OptionsDiv111').style.display='block';
	alert("hi--");
} --%>
function getLevels(){
	
	var len=document.getElementById("level").value;
	
	document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=level";
	document.forms[0].submit();
	
	
}
function getMandals(){
	
		document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=mandals";
		 document.forms[0].submit();

	
}

function getPanchayats(){
	
			document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=panchayats";
			 document.forms[0].submit();
		
	 
}
function getVillages(){
	
			document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=villages";
			 document.forms[0].submit();
		
	
}
function getHabitations(){
	
			document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=habitations";
			 document.forms[0].submit();
		
	
}
<%//System.out.println(request.getAttribute("level").toString());
			String level = request.getAttribute("level").toString();
			//System.out.println("level"+level);%>
function getHabData(){
	
	<%if (level.equals("State") || level.equals("") || level.equals(null)) {%>
	if(document.forms[0].paperDt.value=="")
	{
		alert("Please Select Date");
		document.forms[0].district.focus;
		return;
	}
	
	<%} else if (level.equals("District")) {%>
		
		if(document.forms[0].district.value=="")
		{
			alert("Please Select District");
			document.forms[0].district.focus;
			return;
		}
		else if(document.forms[0].paperDt.value=="")
		{
			alert("Please Select Date");
			document.forms[0].paperDt.focus;
			return;
		}
		<%} else if (level.equals("Mandal")) {%>
		if(document.forms[0].district.value=="")
		{
			alert("Please Select District");
			document.forms[0].district.focus;
			return;
		}
		else if(document.forms[0].mandal.value=="")
		{
			alert("Please Select Mandal");
			document.forms[0].mandal.focus;
			return;
		}
		else if(document.forms[0].paperDt.value=="")
		{
			alert("Please Select Date");
			document.forms[0].paperDt.focus;
			return;
		}
		<%} else if (level.equals("Panchayat")) {%>
		if(document.forms[0].district.value=="")
		{
			alert("Please Select District");
			document.forms[0].district.focus;
			return;
		}
		else if(document.forms[0].mandal.value=="")
		{
			alert("Please Select Mandal");
			document.forms[0].mandal.focus;
			return;
		}
		else if(document.forms[0].panchayat.value=="")
		{
			alert("Please Select Panchayat");
			document.forms[0].panchayat.focus;
			return;
		}
		else if(document.forms[0].paperDt.value=="")
		{
			alert("Please Select Date");
			document.forms[0].paperDt.focus;
			return;
		}
		<%} else if (level.equals("Village")) {%>
		if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		document.forms[0].district.focus;
		return;
	}
	else if(document.forms[0].mandal.value=="")
	{
		alert("Please Select Mandal");
		document.forms[0].mandal.focus;
		return;
	}
	else if(document.forms[0].panchayat.value=="")
	{
		alert("Please Select Panchayat");
		document.forms[0].panchayat.focus;
		return;
	}
	else if(document.forms[0].village.value=="")
	{
		alert("Please Select Village");
		document.forms[0].village.focus;
		return;
	}
	else if(document.forms[0].paperDt.value=="")
	{
		alert("Please Select Date");
		document.forms[0].paperDt.focus;
		return;
	}
		<%} else if (level.equals("Habitation")) {%>
		if(document.forms[0].district.value=="")
		{
			alert("Please Select District");
			document.forms[0].district.focus;
			return;
		}
		else if(document.forms[0].mandal.value=="")
		{
			alert("Please Select Mandal");
			document.forms[0].mandal.focus;
			return;
		}
		else if(document.forms[0].panchayat.value=="")
		{
			alert("Please Select Panchayat");
			document.forms[0].panchayat.focus;
			return;
		}
		else if(document.forms[0].village.value=="")
		{
			alert("Please Select Village");
			document.forms[0].village.focus;
			return;
		}
		else if(document.forms[0].habitation.value=="")
		{
			alert("Please Select Habitation");
			document.forms[0].habitation.focus;
			return;
		}
		else if(document.forms[0].paperDt.value=="")
		{
			alert("Please Select Date");
			document.forms[0].paperDt.focus;
			return;
		}
		<%}%>
	document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=reqHabData";
	 document.forms[0].submit();
	
}
function getHabData1(){
	
	<%if (level.equals("State") || level.equals("") || level.equals(null)) {%>
	if(document.forms[0].paperDt.value=="")
	{
		alert("Please Select Date");
		document.forms[0].district.focus;
		return;
	}
	
	<%} else if (level.equals("District")) {%>
		
		if(document.forms[0].district.value=="")
		{
			alert("Please Select District");
			document.forms[0].district.focus;
			return;
		}
		else if(document.forms[0].paperDt.value=="")
		{
			alert("Please Select Date");
			document.forms[0].paperDt.focus;
			return;
		}
		<%} else if (level.equals("Mandal")) {%>
		if(document.forms[0].district.value=="")
		{
			alert("Please Select District");
			document.forms[0].district.focus;
			return;
		}
		else if(document.forms[0].mandal.value=="")
		{
			alert("Please Select Mandal");
			document.forms[0].mandal.focus;
			return;
		}
		else if(document.forms[0].paperDt.value=="")
		{
			alert("Please Select Date");
			document.forms[0].paperDt.focus;
			return;
		}
		<%} else if (level.equals("Panchayat")) {%>
		if(document.forms[0].district.value=="")
		{
			alert("Please Select District");
			document.forms[0].district.focus;
			return;
		}
		else if(document.forms[0].mandal.value=="")
		{
			alert("Please Select Mandal");
			document.forms[0].mandal.focus;
			return;
		}
		else if(document.forms[0].panchayat.value=="")
		{
			alert("Please Select Panchayat");
			document.forms[0].panchayat.focus;
			return;
		}
		else if(document.forms[0].paperDt.value=="")
		{
			alert("Please Select Date");
			document.forms[0].paperDt.focus;
			return;
		}
		<%} else if (level.equals("Village")) {%>
		if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		document.forms[0].district.focus;
		return;
	}
	else if(document.forms[0].mandal.value=="")
	{
		alert("Please Select Mandal");
		document.forms[0].mandal.focus;
		return;
	}
	else if(document.forms[0].panchayat.value=="")
	{
		alert("Please Select Panchayat");
		document.forms[0].panchayat.focus;
		return;
	}
	else if(document.forms[0].village.value=="")
	{
		alert("Please Select Village");
		document.forms[0].village.focus;
		return;
	}
	else if(document.forms[0].paperDt.value=="")
	{
		alert("Please Select Date");
		document.forms[0].paperDt.focus;
		return;
	}
		<%} else if (level.equals("Habitation")) {%>
		if(document.forms[0].district.value=="")
		{
			alert("Please Select District");
			document.forms[0].district.focus;
			return;
		}
		else if(document.forms[0].mandal.value=="")
		{
			alert("Please Select Mandal");
			document.forms[0].mandal.focus;
			return;
		}
		else if(document.forms[0].panchayat.value=="")
		{
			alert("Please Select Panchayat");
			document.forms[0].panchayat.focus;
			return;
		}
		else if(document.forms[0].village.value=="")
		{
			alert("Please Select Village");
			document.forms[0].village.focus;
			return;
		}
		else if(document.forms[0].habitation.value=="")
		{
			alert("Please Select Habitation");
			document.forms[0].habitation.focus;
			return;
		}
		else if(document.forms[0].paperDt.value=="")
		{
			alert("Please Select Date");
			document.forms[0].paperDt.focus;
			return;
		}
		<%}%>
	document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=AddRow";
	 document.forms[0].submit();
	
}
function validateFeilds(){
	
	
	 var len=document.forms[0].resultCount.value;
	
	 //alert(len);
		len = len-1;
	    var yes=0;    
	    var n=0;
		for( var i=0;i<len;i++)
		{     
				if(document.getElementById("habData["+i+"].checks").checked==true)
				 {
					
					
					n++;
			     }
		}
		 

              
             				
             				if(n<1){	
             				
             					alert("Select atleast one check box to save");
             					 return false;
             				}
             				else if(n>1){
             					
             					alert("At a time we can  save only one record Please select only one check box");
             					 return false;
             				}
	
			 
               


             				var len=document.forms[0].resultCount.value;
             				len = len-1;
             			    var yes=0;    
             			    
             				for( var i=0;i<len;i++)
             				{     
             						if(document.getElementById("habData["+i+"].checks").checked==true)
             						 {
             							 //alert("Please "+document.getElementById("habData["+i+"].typeOfAdverseNewsItem").value);
             							var str=document.getElementById("habData["+i+"].actionReport").value;
             							//alert("str"+str);
             							var l=str.length;
             							//alert("length"+l);
             							var FileUploadPath = null;
             							if(document.getElementById("habData["+i+"].scannedCopyStatus").value=="no"){
             								var sourceImg = document.getElementById("habData["+i+"].scannedCopy");
             								FileUploadPath = sourceImg.value;
             							}else if(document.getElementById("habData["+i+"].scannedCopyStatus").value !=="no" && document.getElementById("habData["+i+"].scannedCopy").value !=="" ){
             								var sourceImg = document.getElementById("habData["+i+"].scannedCopy");
             								FileUploadPath = sourceImg.value;
             							}
             							
         								
         								
             							 if(document.getElementById("habData["+i+"].paperDate").value==""){
             								 alert("Please Select Paper Date");
             								 document.getElementById("habData["+i+"].paperDate").focus();
             										 return false;
             							 }
             							 if(document.getElementById("habData["+i+"].paperNews").value==""){
             								 alert("Please Enter Gist of Adverse News ");
             								 document.getElementById("habData["+i+"].paperNews").focus();
             										 return false;
             							 }
             							 
             							 /* if(document.getElementById("habData["+i+"].actionReport").value==""){
             								 alert("Please Enter Action Taken Report ");
             								 document.getElementById("habData["+i+"].actionReport").focus();
             										 return false;
             							 } */
             							 if(l>=300){
             								 alert("You have entered "+l+" Characters, but Action Taken Report Field will allow only 299 charecters only, Please Restrict That");
             								 document.getElementById("habData["+i+"].actionReport").focus();
             										 return false;
             							 }
             							/* if(document.getElementById("habData["+i+"].atrScannedCopy").value==""){
            								 alert("Please Select ATR Scanned copy");
            								 document.getElementById("habData["+i+"].atrScannedCopy").focus();
            										 return false;
            							 }  */
            						
            							 /*  var scannedcopyStatus =  document.getElementById("habData["+i+"].scannedCopyStatus").value;
            							 alert("scanned copy status :"+scannedcopyStatus);  */ 
            							
             							   if(document.getElementById("habData["+i+"].scannedCopy").value=="" && document.getElementById("habData["+i+"].scannedCopyStatus").value=="no"){
             								 alert("Please upload  Paper clipping Scanned copy");
             								 document.getElementById("habData["+i+"].scannedCopy").focus();
             										 return false;
             							 } 
            						if (FileUploadPath !== null && !fileMimeType(FileUploadPath)) {			
            									return false;
            								}
             						
             						 }
             				}
             				return true;
             			}
             			
             			
             			
function fnSave(){


	var selectedHab="";
	 var len=document.forms[0].resultCount.value;
	var path;
	// alert("len"+len);
		len = len-1;
	    var yes=0;    
	    var n=0;
	    var newsId=0;
		for( var i=0;i<len;i++)
		{     
				if(document.getElementById("habData["+i+"].checks").checked==true)
				 {
					/// document.getElementById("habData["+i+"].isChecked").value = true;
					newsId = document.getElementById("habData["+i+"].newsId").value;
					selectedHab=selectedHab+","+document.getElementById("habData["+i+"].habCode").value;
					path=document.getElementById("habData["+i+"].scannedCopy").value;
					n++;
			     }
				//alert(n);
		}
		  if(selectedHab=="")
		   {
			 alert("Select atleast one check box to save");
	       }
		  else{

                 if(validateFeilds()){
              				//alert(path);
              				if(n==1){	
              					//alert("selected news Id :"+newsId);
              				
			  if(confirm("Are You Sure To Save  The Selected Habitations(s)")) {
				 // document.getElementById("habData["+i+"].checks").innerHTML = "true";
	//document.forms[0].action="switch.do?prefix=/drought&page=/newsItem.do&mode=saveHabData";
	document.forms[0].action="/pred/drought/newsItem.do?mode=saveHabData&newsId="+newsId;
	
	 document.forms[0].submit();
			  }
              				}
              				else{
              					
              					alert("At a time we can  save only one record ");
              				}
	
			 } 
                 else{
                	 
                     return false;
                 }

                     
		  }
}
</script>


<html:form action="/newsItem.do" method="post"
	enctype="multipart/form-data">
	<body onload="autocompletion()">

		<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />



		<table align="center" cellpadding="0" cellspacing="0" border=0
			bordercolor=black>
			<thead>
				<tr>
					<td><jsp:include page="/commons/TableHeader.jsp">
							<jsp:param name="TableName"
								value="Adverse News Items In Papers -Drinking Water Problem In Rural Areas" />
							<jsp:param name="TWidth" value="100%" />

						</jsp:include></td>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td><jsp:include page="/commons/TableFotter.jsp">
							<jsp:param name="TWidth" value="100%" />
						</jsp:include></td>

				</tr>
				<tr align="center">
					<td class="rptValue"><font color="red"><b>Note:</b></font><font
						color="green"><b>Please Select only one Checkbox to
								save the Clipping</b></font></td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td></td>
				</tr>
				<tr>
					<td>
						<table align=center bgcolor="white" bordercolor="blue" border="1"
							style="border-collapse: collapse;" width="100%">
							<tr>
								<td class="mycborder">
									<fieldset>
										<legend></legend>
										<label>
											<table border=0 width="1200">
												<tr>
													<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Level<font
															color="red">*</font></font></td>
													<td class="textborder"><html:select property="level"
															styleClass="mycombo" style="width:150px"
															onchange="javascript:getLevels()">

															<html:option value="State">
																<font class="myfontclr1">State</font>
															</html:option>
															<html:option value="District">
																<font class="myfontclr1">District</font>
															</html:option>
															<html:option value="Mandal">
																<font class="myfontclr1">Mandal</font>
															</html:option>
															<html:option value="Panchayat">
																<font class="myfontclr1">Panchayat</font>
															</html:option>
															<html:option value="Village">
																<font class="myfontclr1">Village</font>
															</html:option>
															<html:option value="Habitation">
																<font class="myfontclr1">Habitation</font>
															</html:option>
														</html:select></td>


													<%
														if (level.equals("") || level.equals(null)) {

															}
															if (level.equals("State") || level.equals("")
																	|| level.equals(null)) {
																//System.out.println("inside state");
													%>
													<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Date<font
															color="red">*</font></font></td>
													<td><html:text property="paperDt" styleClass="mytext"
															style="width:70" /> <a
														href="javascript: showCalendarFuture(document.getElementById('paperDt'));">
															<IMG
															SRC="<rws:context page='/images/calendar.gif'/>
								   "
															width="20" border="0" height="17" align="absmiddle">
													</a></td>
													<td><input type=button value="Get Data"
														onclick="getHabData()"></td>
													<td width="200"></td>
												</tr>



												<tr>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td>
									<table width="100%" bgcolor="#ffffff" cellpadding="0"
										cellspacing="1" border="1" bordercolor="#8A9FCD"
										style="border-collapse: collapse">
										<tr>
											<td class="btext" rowspan="2">Select</td>
											<td class="btext" rowspan="2">Delete</td>
											<td class="btext" rowspan="2">Sno</td>

											<td class="btext" colspan="4" align="center">Details Of
												Paper Clipping <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Type of
												Adverse News Item <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Action
												Taken Report</td>
											<td class="btext" rowspan="2" align="center">Remarks <font
												color="red"><b></b></font></td>

											<td class="btext" rowspan="2" style="width: 150px;">Paper
												clipping Scanned copy <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2"  style="width: 150px;">ATR Scanned
												copy</td>
										</tr>
										<tr>
											<td class="btext" align="center">Date<font color="red"><b>*</b></font></td>
											<td class="btext" align="center">PaperName <font
												color="red"><b>*</b></font></td>
											<td class="btext" align="center">Edition <font
												color="red"><b>*</b></font><br></br>(District/State)
											</td>
											<td class="btext" align="center">Gist of Adverse News <font
												color="red"><b>*</b></font></td>


										</tr>

										<logic:iterate name="newsItemForm" id="habData"
											property="habData">
											<%
												//System.out.println("inside newsItemForm");
															count++;
											%>

											<tr>
												<td align="center" nowrap width="30"><html:checkbox
														name="habData" property="checks" indexed="true" /></td>
												<td class="locked" align="center" nowrap><img
													src="/pred/resources/images/deleteButton2.png"
													onclick="javascript:fnDelete('<bean:write name="habData" property="newsId"   />')" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="slNo" /></td>
												<%-- <html:hidden indexed="true" name="habData"
													property="isChecked"></html:hidden> --%>
													<html:hidden indexed="true" name="habData"
													property="habCode"></html:hidden>
												<html:hidden indexed="true" name="habData" property="newsId"></html:hidden>

												<td class="bwborder"><html:text name="habData"
														property="paperDate" styleClass="mytext" style="width:50"
														indexed="true" />&nbsp;<a
													href="javascript: showCalendarFuture(document.getElementById('habData[<%=count - 2%>].paperDate'));">
														<IMG
														SRC="<rws:context page='/images/calendar.gif'/>"
														width="20" border="0" height="17" align="absmiddle">
												</a></td>
												<td class="bwborder"><html:select name="habData"
														property="paperName" style="width:100px" indexed="true">
														<html:option value="Eenadu">Eenadu</html:option>
														<html:option value="Andhra Bhoomi">Andhra Bhoomi</html:option>
														<html:option value="Andhra Jyothi">Andhra Jyothi</html:option>
														<html:option value="Andhra Bhoomi">Andhra Prabha</html:option>
														<html:option value="Praja Sakthi">Praja Sakthi</html:option>
														<html:option value="Vaartha">Vaartha</html:option>
														<html:option value="Sakshi">Sakshi</html:option>
														<html:option value="Hindu">Hindu</html:option>
														<html:option value="Deccan Chronicle">Deccan Chronicle</html:option>
														<html:option value="The Times Of India">The Times Of India</html:option>
														<html:option value="Indian Express">Indian Express</html:option>
													</html:select></td>
												<td class="bwborder"><html:select name="habData"
														property="paperEdition" style="width:100px" indexed="true">
														<html:option value="District">District</html:option>
														<html:option value="State">State</html:option>
													</html:select></td>
												<td class="bwborder"><html:textarea name="habData"
														property="paperNews" rows="3" cols="20" indexed="true" /></td>

												<td class="bwborder"><html:select name="habData"
														property="typeOfAdverseNewsItem" style="width:150px"
														indexed="true">
														<html:option value="Water Availability">Water Availability[Scarcity]</html:option>
														<html:option value="Water Quality Related">Water Quality Related[Contamination]</html:option>
														<html:option value="Both WS AND WC">Both[WS&WC]</html:option>
														<html:option value="Maintenance Problem">Maintenance Problem</html:option>
														<html:option value="Others">Others</html:option>
													</html:select></td>
												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="actionReport" indexed="true" /></td>
												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="remarks" indexed="true" /></td>


												<html:hidden indexed="true" name="habData" property="scannedCopyStatus"></html:hidden>
												<nested:notEqual name="habData" property="scannedCopyStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> onchange="readURL(this);"  --%>
													<td class="bwborder" style="width: 150px;"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
																width="350px" height="230px" id="bigImage" /></span></a>
																<%-- <script type="text/javascript">
																var id = "dplay"+<%=count%>
																</script> --%>
														<!-- <input type="button"  class="btext"  value="Edit" style="margin-left:  25px;margin-bottom: 10px; "/> -->
														 <html:file
															name="habData" property="scannedCopy" styleClass="mytext"
															style="width:150"  indexed="true" styleId="id"/> 
															<!-- 
															 <script type="text/javascript">
													var x = document.getElementById("id");
													 x.style.display = "none";
													
													</script> --></td>
												</nested:notEqual>
												<nested:equal name="habData" property="scannedCopyStatus"
													value="no">
													<td class="bwborder"><html:file name="habData"
															property="scannedCopy" styleClass="mytext"
															style="width:150" indexed="true" /></td>
												</nested:equal>

												<%-- <td class="bwborder"><html:file name="habData"
														property="atrScannedCopy" styleClass="mytext"
														style="width:150" indexed="true" /></td> --%>
														
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													
													<nested:notEqual name="habData" property="atrimageStatus"
													value="no">
													<td class="bwborder" style="width: 150px;">
													<a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
																width="350px" height="230px" id="bigImage" /></span></a>
														<!-- <input type="button"  class="btext"  value="Edit" style="margin-left:  25px;margin-bottom: 10px;"/> -->
														 <html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" /> 
															<!--
															
															 <script
															type="text/javascript">
													var x = document.getElementById("atrdplay");
												/* 	 x.style.display = "none"; */
													</script> -->
													</td>
													</nested:notEqual>
													<nested:equal name="habData" property="atrimageStatus"
													value="no">
													<td class="bwborder" style="width: 150px;">
													<html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" />
													
														</td>	
												</nested:equal>
													
												
												


											</tr>


										</logic:iterate>




										<%
											} else if (level.equals("District")) {
										%>
										<td class=mycborder><font face=verdana size=2>District&nbsp;&nbsp;<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="district"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getMandals()">
												<html:option value="">
													<font class="myfontclr1">SELECT...
												</html:option>
												<logic:present name="districts">
													<html:options collection="districts" name="rwsLocationBean"
														property="value" labelProperty="label" />
												</logic:present>
											</html:select></td>
										<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Date<font
												color="red">*</font></font></td>
										<td><html:text property="paperDt" styleClass="mytext"
												style="width:70" /> <a
											href="javascript: showCalendarFuture(document.getElementById('paperDt'));">
												<IMG
												SRC="<rws:context page='/images/calendar.gif'/>
							   "
												width="20" border="0" height="17" align="absmiddle">
										</a></td>
										<td><input type=button value="Get Data"
											onclick="getHabData()"></td>
										<td width="200"></td>
										</tr>



										<tr>
									</table> </label>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td>
									<table width="100%" bgcolor="#ffffff" cellpadding="0"
										cellspacing="1" border="1" bordercolor="#8A9FCD"
										style="border-collapse: collapse">
										<tr>
											<td class="btext" rowspan="2">Select</td>
											<td class="btext" rowspan="2">Delete</td>
											<td class="btext" rowspan="2">Sno</td>
											<td class="btext" rowspan="2" align="center">District</td>
											<td class="btext" colspan="4" align="center">Details Of
												Paper Clipping <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Type of
												Adverse News Item <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Action
												Taken Report</td>
											<td class="btext" rowspan="2" align="center">Remarks <font
												color="red"><b></b></font></td>

											<td class="btext" rowspan="2" align="center">Paper
												clipping Scanned copy <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">ATR Scanned
												copy</td>
										</tr>
										<tr>
											<td class="btext" align="center">Date<font color="red"><b>*</b></font></td>
											<td class="btext" align="center">PaperName <font
												color="red"><b>*</b></font></td>
											<td class="btext" align="center">Edition <font
												color="red"><b>*</b></font><br></br>(District/State)
											</td>
											<td class="btext" align="center">Gist of Adverse News <font
												color="red"><b>*</b></font></td>


										</tr>

										<logic:iterate name="newsItemForm" id="habData"
											property="habData">
											<%
												count++;
											%>
											<tr>
												<td align="center" nowrap width="30"><html:checkbox
														name="habData" property="checks" indexed="true" /></td>
												<td class="locked" align="center" nowrap><img
													src="/pred/resources/images/deleteButton2.png"
													onclick="javascript:fnDelete('<bean:write name="habData" property="newsId"   />')" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="slNo" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="districtName" /></td>
												<html:hidden indexed="true" name="habData"
													property="habCode"></html:hidden>
												<html:hidden indexed="true" name="habData" property="newsId"></html:hidden>
												<td class="bwborder"><html:text name="habData"
														property="paperDate" styleClass="mytext" style="width:50"
														indexed="true" />&nbsp;<a
													href="javascript: showCalendarFuture(document.getElementById('habData[<%=count - 2%>].paperDate'));">
														<IMG
														SRC="<rws:context page='/images/calendar.gif'/>
							   "
														width="20" border="0" height="17" align="absmiddle">
												</a></td>
												<td class="bwborder"><html:select name="habData"
														property="paperName" style="width:100px" indexed="true">
														<html:option value="Eenadu">Eenadu</html:option>
														<html:option value="Andhra Bhoomi">Andhra Bhoomi</html:option>
														<html:option value="Andhra Jyothi">Andhra Jyothi</html:option>
														<html:option value="Andhra Bhoomi">Andhra Prabha</html:option>
														<html:option value="Praja Sakthi">Praja Sakthi</html:option>
														<html:option value="Vaartha">Vaartha</html:option>
														<html:option value="Sakshi">Sakshi</html:option>
														<html:option value="Hindu">Hindu</html:option>
														<html:option value="Deccan Chronicle">Deccan Chronicle</html:option>
														<html:option value="The Times Of India">The Times Of India</html:option>
														<html:option value="Indian Express">Indian Express</html:option>



													</html:select></td>
												<td class="bwborder"><html:select name="habData"
														property="paperEdition" style="width:100px" indexed="true">
														<html:option value="District">District</html:option>
														<html:option value="State">State</html:option>



													</html:select></td>
												<td class="bwborder"><html:textarea name="habData"
														property="paperNews" rows="3" cols="20" indexed="true" /></td>
												<td class="bwborder"><html:select name="habData"
														property="typeOfAdverseNewsItem" style="width:150px"
														indexed="true">
														<html:option value="Water Availability">Water Availability[Scarcity]</html:option>
														<html:option value="Water Quality Related">Water Quality Related[Contamination]</html:option>
														<html:option value="Both WS AND WC">Both[WS&WC]</html:option>
														<html:option value="Maintenance Problem">Maintenance Problem</html:option>
														<html:option value="Others">Others</html:option>


													</html:select></td>

												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="actionReport" indexed="true" /></td>
												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="remarks" indexed="true" /></td>

												<html:hidden indexed="true" name="habData" property="scannedCopyStatus"></html:hidden>
												<nested:notEqual name="habData" property="scannedCopyStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
																width="350px" height="230px" id="bigImage" /></span></a>
														<!-- <input type="button"  class="btext"  value="Edit" style="margin-left:  25px;margin-bottom: 10px; "/> -->
														 <html:file
															name="habData" property="scannedCopy" styleClass="mytext"
															style="width:150" styleId="dplay" indexed="true" />
															<!--
															
															  <script
															type="text/javascript">
													var x = document.getElementById("dplay");
													 x.style.display = "none";
													</script> -->
													</td>
												</nested:notEqual>
												<nested:equal name="habData" property="scannedCopyStatus"
													value="no">
													<td class="bwborder"><html:file name="habData"
															property="scannedCopy" styleClass="mytext"
															style="width:150" indexed="true" /></td>
												</nested:equal>

												<%-- <td class="bwborder"><html:file name="habData"
														property="atrScannedCopy" styleClass="mytext"
														style="width:150" indexed="true" /></td> --%>
														<nested:notEqual name="habData" property="atrimageStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
																width="350px" height="230px" id="bigImage" /></span></a>
														<!-- <input type="button"  class="btext" onclick="visibleAtrSelectImage()" value="Edit" style="margin-left:  25px;margin-bottom: 10px; "/> -->
														 <html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" /> 
															<!-- <script
															type="text/javascript">
													var x = document.getElementById("atrdplay");
													 x.style.display = "none";
													</script> -->
													</td>
												</nested:notEqual>
												<nested:equal name="habData" property="atrimageStatus"
													value="no">
													<td class="bwborder">
													<html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" />
													
															</td>
												</nested:equal>
											</tr>
										</logic:iterate>



										<%
											//System.out.println("sa"+request.getParameter("level"));
												} else if (level.equals("Mandal")) {
										%>
										<td class=mycborder><font face=verdana size=2>District&nbsp;&nbsp;<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="district"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getMandals()">
												<html:option value="">
													<font class="myfontclr1">SELECT...
												</html:option>
												<logic:present name="districts">
													<html:options collection="districts" name="rwsLocationBean"
														property="value" labelProperty="label" />
												</logic:present>
											</html:select></td>
										<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Mandal<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="mandal"
												styleClass="mycombo" style="width:150px">
												<html:option value="">
													<font class="myfontclr1">SELECT...</font>
												</html:option>
												<logic:present name="mandals">
													<html:options collection="mandals" name="rwsLocationBean"
														property="value" labelProperty="label" />
												</logic:present>
											</html:select></td>
										<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Date<font
												color="red">*</font></font></td>
										<td><html:text property="paperDt" styleClass="mytext"
												style="width:70" />&nbsp;<a
											href="javascript: showCalendarFuture(document.getElementById('paperDt'));">
												<IMG
												SRC="<rws:context page='/images/calendar.gif'/>
							   "
												width="20" border="0" height="17" align="absmiddle">
										</a></td>
										<td><input type=button value="Get Data"
											onclick="getHabData()"></td>
										<td width="200"></td>
										</tr>



										<tr>
									</table> </label>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td>
									<table width="100%" bgcolor="#ffffff" cellpadding="0"
										cellspacing="1" border="1" bordercolor="#8A9FCD"
										style="border-collapse: collapse">
										<tr>
											<td class="btext" rowspan="2">Select</td>
											<td class="btext" rowspan="2">Delete</td>
											<td class="btext" rowspan="2">Sno</td>
											<td class="btext" rowspan="2" align="center">District</td>
											<td class="btext" rowspan="2" align="center">Mandal</td>
											<td class="btext" colspan="4" align="center">Details Of
												Paper Clipping <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Type of
												Adverse News Item <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Action
												Taken Report</td>
											<td class="btext" rowspan="2" align="center">Remarks <font
												color="red"><b></b></font></td>

											<td class="btext" rowspan="2" align="center">Paper
												clipping Scanned copy <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">ATR Scanned
												copy</td>
										</tr>
										<tr>
											<td class="btext" align="center">Date<font color="red"><b>*</b></font></td>
											<td class="btext" align="center">PaperName <font
												color="red"><b>*</b></font></td>
											<td class="btext" align="center">Edition <font
												color="red"><b>*</b></font><br></br>(District/State)
											</td>
											<td class="btext" align="center">Gist of Adverse News <font
												color="red"><b>*</b></font></td>


										</tr>

										<logic:iterate name="newsItemForm" id="habData"
											property="habData">
											<%
												count++;
											%>
											<tr>
												<td align="center" nowrap width="30"><html:checkbox
														name="habData" property="checks" indexed="true" /></td>
												<td class="locked" align="center" nowrap><img
													src="/pred/resources/images/deleteButton2.png"
													onclick="javascript:fnDelete('<bean:write name="habData" property="newsId"   />')" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="slNo" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="districtName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="mandalName" /></td>
												<html:hidden indexed="true" name="habData"
													property="habCode"></html:hidden>
												<html:hidden indexed="true" name="habData" property="newsId"></html:hidden>
												<td class="bwborder"><html:text name="habData"
														property="paperDate" styleClass="mytext" style="width:50"
														indexed="true" />&nbsp;<a
													href="javascript: showCalendarFuture(document.getElementById('habData[<%=count - 2%>].paperDate'));">
														<IMG
														SRC="<rws:context page='/images/calendar.gif'/>
							   "
														width="20" border="0" height="17" align="absmiddle">
												</a></td>
												<td class="bwborder"><html:select name="habData"
														property="paperName" style="width:100px" indexed="true">
														<html:option value="Eenadu">Eenadu</html:option>
														<html:option value="Andhra Bhoomi">Andhra Bhoomi</html:option>

														<html:option value="Andhra Jyothi">Andhra Jyothi</html:option>
														<html:option value="Andhra Bhoomi">Andhra Prabha</html:option>
														<html:option value="Praja Sakthi">Praja Sakthi</html:option>
														<html:option value="Vaartha">Vaartha</html:option>
														<html:option value="Sakshi">Sakshi</html:option>
														<html:option value="Hindu">Hindu</html:option>
														<html:option value="Deccan Chronicle">Deccan Chronicle</html:option>
														<html:option value="The Times Of India">The Times Of India</html:option>
														<html:option value="Indian Express">Indian Express</html:option>



													</html:select></td>
												<td class="bwborder"><html:select name="habData"
														property="paperEdition" style="width:100px" indexed="true">
														<html:option value="District">District</html:option>
														<html:option value="State">State</html:option>



													</html:select></td>
												<td class="bwborder"><html:textarea name="habData"
														property="paperNews" rows="3" cols="20" indexed="true" /></td>
												<td class="bwborder"><html:select name="habData"
														property="typeOfAdverseNewsItem" style="width:150px"
														indexed="true">
														<html:option value="Water Availability">Water Availability[Scarcity]</html:option>
														<html:option value="Water Quality Related">Water Quality Related[Contamination]</html:option>
														<html:option value="Both WS AND WC">Both[WS&WC]</html:option>
														<html:option value="Maintenance Problem">Maintenance Problem</html:option>
														<html:option value="Others">Others</html:option>


													</html:select></td>

												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="actionReport" indexed="true" /></td>
												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="remarks" indexed="true" /></td>
												<html:hidden indexed="true" name="habData" property="scannedCopyStatus"></html:hidden>
												<nested:notEqual name="habData" property="scannedCopyStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
																width="350px" height="230px" id="bigImage" /></span></a>
														<!-- <input type="button"  class="btext" onclick="visibleSelectImage()" value="Edit" style="margin-left:  25px;margin-bottom: 10px; "/> -->
														 <html:file
															name="habData" property="scannedCopy" styleClass="mytext"
															style="width:150" styleId="dplay" indexed="true" /> 
															<!-- <script
															type="text/javascript">
													var x = document.getElementById("dplay");
													 x.style.display = "none";
													</script> -->
													</td>
												</nested:notEqual>
												<nested:equal name="habData" property="scannedCopyStatus"
													value="no">
													<td class="bwborder"><html:file name="habData"
															property="scannedCopy" styleClass="mytext"
															style="width:150" indexed="true" /></td>
												</nested:equal>
												<%-- <td class="bwborder"><html:file name="habData"
														property="atrScannedCopy" styleClass="mytext"
														style="width:150" indexed="true" /></td> --%>
														<nested:notEqual name="habData" property="atrimageStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
																width="350px" height="230px" id="bigImage" /></span></a>
														<!-- <input type="button"  class="btext" onclick="visibleAtrSelectImage()" value="Edit" style="margin-left:  25px;margin-bottom: 10px; "/> -->
														 <html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" />
															<!--  <script
															type="text/javascript">
													var x = document.getElementById("atrdplay");
													 x.style.display = "none";
													</script> -->
													</td>
												</nested:notEqual>
												<nested:equal name="habData" property="atrimageStatus"
													value="no">
													<td class="bwborder">
													<html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" />
													
															</td>
												</nested:equal>
											</tr>
										</logic:iterate>



										<%
											} else if (level.equals("Panchayat")) {
										%>
										<td class=mycborder><font face=verdana size=2>District&nbsp;&nbsp;<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="district"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getMandals()">
												<html:option value="">
													<font class="myfontclr1">SELECT...
												</html:option>
												<logic:present name="districts">
													<html:options collection="districts" name="rwsLocationBean"
														property="value" labelProperty="label" />
												</logic:present>
											</html:select></td>
										<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Mandal<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="mandal"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getPanchayats()">
												<html:option value="">
													<font class="myfontclr1">SELECT...</font>
												</html:option>
												<logic:present name="mandals">
													<html:options collection="mandals" name="rwsLocationBean"
														property="value" labelProperty="label" />
												</logic:present>
											</html:select></td>

										</tr>
										<tr>
											<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Panchayat<font
													color="red">*</font></font></td>
											<td class="textborder"><html:select property="panchayat"
													styleClass="mycombo" style="width:150px"
													onchange="javascript:getVillages()">
													<html:option value="">
														<font class="myfontclr1">SELECT...</font>
													</html:option>
													<logic:present name="panchayats">
														<html:options collection="panchayats"
															name="rwsLocationBean" property="value"
															labelProperty="label" />
													</logic:present>
												</html:select></td>
											<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Date<font
													color="red">*</font></font></td>
											<td><html:text property="paperDt" styleClass="mytext"
													style="width:70" /> <a
												href="javascript: showCalendarFuture(document.getElementById('paperDt'));">
													<IMG
													SRC="<rws:context page='/images/calendar.gif'/>"
													width="20" border="0" height="17" align="absmiddle">
											</a></td>
											<td><input type=button value="Get Data"
												onclick="getHabData()"></td>
											<td width="200"></td>
										</tr>



										<tr>
									</table> </label>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td>
									<table width="100%" bgcolor="#ffffff" cellpadding="0"
										cellspacing="1" border="1" bordercolor="#8A9FCD"
										style="border-collapse: collapse">
										<tr>
											<td class="btext" rowspan="2">Select</td>
											<td class="btext" rowspan="2">Delete</td>
											<td class="btext" rowspan="2">Sno</td>
											<td class="btext" rowspan="2" align="center">District</td>
											<td class="btext" rowspan="2" align="center">Mandal</td>
											<td class="btext" rowspan="2" align="center">Panchayat</td>

											<td class="btext" colspan="4" align="center">Details Of
												Paper Clipping <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Type of
												Adverse News Item <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Action
												Taken Report</td>
											<td class="btext" rowspan="2" align="center">Remarks <font
												color="red"><b></b></font></td>

											<td class="btext" rowspan="2" align="center">Paper
												clipping Scanned copy <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">ATR Scanned
												copy</td>
										</tr>
										<tr>
											<td class="btext" align="center">Date<font color="red"><b>*</b></font></td>
											<td class="btext" align="center">PaperName <font
												color="red"><b>*</b></font></td>
											<td class="btext" align="center">Edition <font
												color="red"><b>*</b></font><br></br>(District/State)
											</td>
											<td class="btext" align="center">Gist of Adverse News <font
												color="red"><b>*</b></font></td>


										</tr>

										<logic:iterate name="newsItemForm" id="habData"
											property="habData">
											<%
												count++;
											%>
											<tr>
												<td align="center" nowrap width="30"><html:checkbox
														name="habData" property="checks" indexed="true" /></td>
												<td class="locked" align="center" nowrap><img
													src="/pred/resources/images/deleteButton2.png"
													onclick="javascript:fnDelete('<bean:write name="habData" property="newsId"   />')" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="slNo" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="districtName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="mandalName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="panchayathName" /></td>

												<html:hidden indexed="true" name="habData"
													property="habCode"></html:hidden>
												<html:hidden indexed="true" name="habData" property="newsId"></html:hidden>
												<td class="bwborder"><html:text name="habData"
														property="paperDate" styleClass="mytext" style="width:50"
														indexed="true" />&nbsp;<a
													href="javascript: showCalendarFuture(document.getElementById('habData[<%=count - 2%>].paperDate'));">
														<IMG
														SRC="<rws:context page='/images/calendar.gif'/>
								   "
														width="20" border="0" height="17" align="absmiddle">
												</a></td>
												<td class="bwborder"><html:select name="habData"
														property="paperName" style="width:100px" indexed="true">
														<html:option value="Eenadu">Eenadu</html:option>
														<html:option value="Andhra Bhoomi">Andhra Bhoomi</html:option>
														<html:option value="Andhra Jyothi">Andhra Jyothi</html:option>
														<html:option value="Andhra Bhoomi">Andhra Prabha</html:option>
														<html:option value="Praja Sakthi">Praja Sakthi</html:option>
														<html:option value="Vaartha">Vaartha</html:option>
														<html:option value="Sakshi">Sakshi</html:option>
														<html:option value="Hindu">Hindu</html:option>
														<html:option value="Deccan Chronicle">Deccan Chronicle</html:option>
														<html:option value="The Times Of India">The Times Of India</html:option>
														<html:option value="Indian Express">Indian Express</html:option>



													</html:select></td>
												<td class="bwborder"><html:select name="habData"
														property="paperEdition" style="width:100px" indexed="true">
														<html:option value="District">District</html:option>
														<html:option value="State">State</html:option>



													</html:select></td>
												<td class="bwborder"><html:textarea name="habData"
														property="paperNews" rows="3" cols="20" indexed="true" /></td>
												<td class="bwborder"><html:select name="habData"
														property="typeOfAdverseNewsItem" style="width:150px"
														indexed="true">
														<html:option value="Water Availability">Water Availability[Scarcity]</html:option>
														<html:option value="Water Quality Related">Water Quality Related[Contamination]</html:option>
														<html:option value="Both WS AND WC">Both[WS&WC]</html:option>
														<html:option value="Maintenance Problem">Maintenance Problem</html:option>
														<html:option value="Others">Others</html:option>


													</html:select></td>
												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="actionReport" indexed="true" /></td>
												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="remarks" indexed="true" /></td>
												<html:hidden indexed="true" name="habData" property="scannedCopyStatus"></html:hidden>
												<nested:notEqual name="habData" property="scannedCopyStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
															width="30px" height="30px" border="0" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
																width="350px" height="230px" /></span></a>
														<!-- <button onclick="visibleSelectImage()">Edit</button> -->
														 <html:file
															name="habData" property="scannedCopy" styleClass="mytext"
															style="width:150" styleId="dplay" indexed="true" /> 
															<!-- <script	type="text/javascript">
																var x = document.getElementById("dplay");
																 x.style.display = "none";
																</script> -->
																</td>
												</nested:notEqual>
												<nested:equal name="habData" property="scannedCopyStatus"
													value="no">
													<td class="bwborder"><html:file name="habData"
															property="scannedCopy" styleClass="mytext"
															style="width:150" indexed="true" /></td>
												</nested:equal>
												<%-- <td class="bwborder"><html:file name="habData"
														property="atrScannedCopy" styleClass="mytext"
														style="width:150" indexed="true" /></td> --%>
														<nested:notEqual name="habData" property="atrimageStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
																width="350px" height="230px" id="bigImage" /></span></a>
														<!-- <input type="button"  class="btext" onclick="visibleAtrSelectImage()" value="Edit" style="margin-left:  25px;margin-bottom: 10px; "/> -->
														 <html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" />
															<!--  <script
															type="text/javascript">
													var x = document.getElementById("atrdplay");
													 x.style.display = "none";
													</script> -->
													</td>
												</nested:notEqual>
												<nested:equal name="habData" property="atrimageStatus"
													value="no">
													<td class="bwborder">
													<html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" />
													
															</td>
												</nested:equal>
											</tr>
										</logic:iterate>




										<%
											} else if (level.equals("Village")) {
										%>
										<td class=mycborder><font face=verdana size=2>District&nbsp;&nbsp;<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="district"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getMandals()">
												<html:option value="">
													<font class="myfontclr1">SELECT...
												</html:option>
												<logic:present name="districts">
													<html:options collection="districts" name="rwsLocationBean"
														property="value" labelProperty="label" />
												</logic:present>
											</html:select></td>
										<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Mandal<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="mandal"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getPanchayats()">
												<html:option value="">
													<font class="myfontclr1">SELECT...</font>
												</html:option>
												<logic:present name="mandals">
													<html:options collection="mandals" name="rwsLocationBean"
														property="value" labelProperty="label" />
												</logic:present>
											</html:select></td>
										<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Panchayat<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="panchayat"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getVillages()">
												<html:option value="">
													<font class="myfontclr1">SELECT...</font>
												</html:option>
												<logic:present name="panchayats">
													<html:options collection="panchayats"
														name="rwsLocationBean" property="value"
														labelProperty="label" />
												</logic:present>
											</html:select></td>
										</tr>
										<tr>
											<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Village<font
													color="red">*</font></font></td>
											<td class="textborder"><html:select property="village"
													styleClass="mycombo" style="width:150px">
													<html:option value="">
														<font class="myfontclr1">SELECT...</font>
													</html:option>
													<logic:present name="villages">
														<html:options collection="villages" name="rwsLocationBean"
															property="value" labelProperty="label" />
													</logic:present>
												</html:select></td>
											<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Date<font
													color="red">*</font></font></td>
											<td><html:text property="paperDt" styleClass="mytext"
													style="width:70" /> <a
												href="javascript: showCalendarFuture(document.getElementById('paperDt'));">
													<IMG
													SRC="<rws:context page='/images/calendar.gif'/>
							   "
													width="20" border="0" height="17" align="absmiddle">
											</a></td>
											<td><input type=button value="Get Data"
												onclick="getHabData()"></td>
											<td width="200"></td>
										</tr>



										<tr>
									</table> </label>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td>
									<table width="100%" bgcolor="#ffffff" cellpadding="0"
										cellspacing="1" border="1" bordercolor="#8A9FCD"
										style="border-collapse: collapse">
										<tr>
											<td class="btext" rowspan="2">Select</td>
											<td class="btext" rowspan="2">Delete</td>
											<td class="btext" rowspan="2">Sno</td>
											<td class="btext" rowspan="2" align="center">District</td>
											<td class="btext" rowspan="2" align="center">Mandal</td>
											<td class="btext" rowspan="2" align="center">Panchayat</td>
											<td class="btext" rowspan="2" align="center">Village</td>
											<td class="btext" colspan="4" align="center">Details Of
												Paper Clipping <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Type of
												Adverse News Item <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Action
												Taken Report</td>
											<td class="btext" rowspan="2" align="center">Remarks <font
												color="red"><b></b></font></td>

											<td class="btext" rowspan="2" align="center">Paper
												clipping Scanned copy <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">ATR Scanned
												copy</td>
										</tr>
										<tr>
											<td class="btext" align="center">Date<font color="red"><b>*</b></font></td>
											<td class="btext" align="center">PaperName <font
												color="red"><b>*</b></font></td>
											<td class="btext" align="center">Edition <font
												color="red"><b>*</b></font><br></br>(District/State)
											</td>
											<td class="btext" align="center">Gist of Adverse News <font
												color="red"><b>*</b></font></td>


										</tr>

										<logic:iterate name="newsItemForm" id="habData"
											property="habData">
											<%
												count++;
											%>
											<tr>
												<td align="center" nowrap width="30"><html:checkbox
														name="habData" property="checks" indexed="true" /></td>
												<td class="locked" align="center" nowrap><img
													src="/pred/resources/images/deleteButton2.png"
													onclick="javascript:fnDelete('<bean:write name="habData" property="newsId"   />')" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="slNo" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="districtName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="mandalName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="panchayathName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="villageName" /></td>
												<html:hidden indexed="true" name="habData"
													property="habCode"></html:hidden>
												<html:hidden indexed="true" name="habData" property="newsId"></html:hidden>
												<td class="bwborder"><html:text name="habData"
														property="paperDate" styleClass="mytext" style="width:50"
														indexed="true" />&nbsp;<a
													href="javascript: showCalendarFuture(document.getElementById('habData[<%=count - 2%>].paperDate'));">
														<IMG
														SRC="<rws:context page='/images/calendar.gif'/>
							   "
														width="20" border="0" height="17" align="absmiddle">
												</a></td>
												<td class="bwborder"><html:select name="habData"
														property="paperName" style="width:100px" indexed="true">
														<html:option value="Eenadu">Eenadu</html:option>
														<html:option value="Andhra Bhoomi">Andhra Bhoomi</html:option>
														<html:option value="Andhra Jyothi">Andhra Jyothi</html:option>
														<html:option value="Andhra Bhoomi">Andhra Prabha</html:option>
														<html:option value="Praja Sakthi">Praja Sakthi</html:option>
														<html:option value="Vaartha">Vaartha</html:option>
														<html:option value="Sakshi">Sakshi</html:option>
														<html:option value="Hindu">Hindu</html:option>
														<html:option value="Deccan Chronicle">Deccan Chronicle</html:option>
														<html:option value="The Times Of India">The Times Of India</html:option>
														<html:option value="Indian Express">Indian Express</html:option>



													</html:select></td>
												<td class="bwborder"><html:select name="habData"
														property="paperEdition" style="width:100px" indexed="true">
														<html:option value="District">District</html:option>
														<html:option value="State">State</html:option>



													</html:select></td>
												<td class="bwborder"><html:textarea name="habData"
														property="paperNews" rows="3" cols="20" indexed="true" /></td>
												<td class="bwborder"><html:select name="habData"
														property="typeOfAdverseNewsItem" style="width:150px"
														indexed="true">
														<html:option value="Water Availability">Water Availability[Scarcity]</html:option>
														<html:option value="Water Quality Related">Water Quality Related[Contamination]</html:option>
														<html:option value="Both WS AND WC">Both[WS&WC]</html:option>
														<html:option value="Maintenance Problem">Maintenance Problem</html:option>
														<html:option value="Others">Others</html:option>


													</html:select></td>

												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="actionReport" indexed="true" /></td>
												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="remarks" indexed="true" /></td>
												<html:hidden indexed="true" name="habData" property="scannedCopyStatus"></html:hidden>
												<nested:notEqual name="habData" property="scannedCopyStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
															width="30px" height="30px" border="0" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
																width="350px" height="230px" /></span></a>
													<!-- 	<button onclick="visibleSelectImage()">Edit</button> -->
													 <html:file
															name="habData" property="scannedCopy" styleClass="mytext"
															style="width:150" styleId="dplay" indexed="true" />
															<!--  <script
															type="text/javascript">
															var x = document.getElementById("dplay");
															 x.style.display = "none";
															</script> -->
															</td>
												</nested:notEqual>
												<nested:equal name="habData" property="scannedCopyStatus"
													value="no">
													<td class="bwborder"><html:file name="habData"
															property="scannedCopy" styleClass="mytext"
															style="width:150" indexed="true" /></td>
												</nested:equal>
												<%-- <td class="bwborder"><html:file name="habData"
														property="atrScannedCopy" styleClass="mytext"
														style="width:150" indexed="true" /></td> --%>
														<nested:notEqual name="habData" property="atrimageStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
																width="350px" height="230px" id="bigImage" /></span></a>
														<!-- <input type="button"  class="btext" onclick="visibleAtrSelectImage()" value="Edit" style="margin-left:  25px;margin-bottom: 10px; "/> -->
														 <html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" /> 
															<!-- <script
															type="text/javascript">
													var x = document.getElementById("atrdplay");
													 x.style.display = "none";
													</script> -->
													</td>
												</nested:notEqual>
												<nested:equal name="habData" property="atrimageStatus"
													value="no">
													<td class="bwborder">
													<html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" />
													
															</td>
												</nested:equal>
											</tr>
										</logic:iterate>




										<%
											} else if (level.equals("Habitation")) {
										%>
										<td class=mycborder><font face=verdana size=2>District&nbsp;&nbsp;<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="district"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getMandals()">
												<html:option value="">
													<font class="myfontclr1">SELECT...
												</html:option>
												<logic:present name="districts">
													<html:options collection="districts" name="rwsLocationBean"
														property="value" labelProperty="label" />
												</logic:present>
											</html:select></td>
										<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Mandal<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="mandal"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getPanchayats()">
												<html:option value="">
													<font class="myfontclr1">SELECT...</font>
												</html:option>
												<logic:present name="mandals">
													<html:options collection="mandals" name="rwsLocationBean"
														property="value" labelProperty="label" />
												</logic:present>
											</html:select></td>
										<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Panchayat<font
												color="red">*</font></font></td>
										<td class="textborder"><html:select property="panchayat"
												styleClass="mycombo" style="width:150px"
												onchange="javascript:getVillages()">
												<html:option value="">
													<font class="myfontclr1">SELECT...</font>
												</html:option>
												<logic:present name="panchayats">
													<html:options collection="panchayats"
														name="rwsLocationBean" property="value"
														labelProperty="label" />
												</logic:present>
											</html:select></td>
										</tr>
										<tr>
											<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Village<font
													color="red">*</font></font></td>
											<td class="textborder"><html:select property="village"
													styleClass="mycombo" style="width:150px"
													onchange="javascript:getHabitations()">
													<html:option value="">
														<font class="myfontclr1">SELECT...</font>
													</html:option>
													<logic:present name="villages">
														<html:options collection="villages" name="rwsLocationBean"
															property="value" labelProperty="label" />
													</logic:present>
												</html:select></td>
											<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Habitation<font
													color="red">*</font></font></td>
											<td class="textborder"><html:select
													property="habitation" styleClass="mycombo"
													style="width:150px">
													<html:option value="">
														<font class="myfontclr1">SELECT...</font>
													</html:option>
													<logic:present name="habitations">
														<html:options collection="habitations"
															name="rwsLocationBean" property="value"
															labelProperty="label" />
													</logic:present>
												</html:select></td>
											<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;Date<font
													color="red">*</font></font></td>
											<td><html:text property="paperDt" styleClass="mytext"
													style="width:70" /> <a
												href="javascript: showCalendarFuture(document.getElementById('paperDt'));">
													<IMG
													SRC="<rws:context page='/images/calendar.gif'/>
							   "
													width="20" border="0" height="17" align="absmiddle">
											</a></td>
											<td><input type=button value="Get Data"
												onclick="getHabData()"></td>
											<td width="200"></td>
										</tr>



										<tr>
									</table> </label>
									</fieldset>
								</td>
							</tr>

							<tr>
								<td>
									<table width="100%" bgcolor="#ffffff" cellpadding="0"
										cellspacing="1" border="1" bordercolor="#8A9FCD"
										style="border-collapse: collapse">
										<tr>
											<td class="btext" rowspan="2">Select</td>
											<td class="btext" rowspan="2">Delete</td>
											<td class="btext" rowspan="2">Sno</td>
											<td class="btext" rowspan="2" align="center">District</td>
											<td class="btext" rowspan="2" align="center">Mandal</td>
											<td class="btext" rowspan="2" align="center">Panchayat</td>
											<td class="btext" rowspan="2" align="center">Village</td>
											<td class="btext" rowspan="2" align="center">Hab
												Name(HabCode)</td>

											<td class="btext" colspan="4" align="center">Details Of
												Paper Clipping <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Type of
												Adverse News Item <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">Action
												Taken Report</td>
											<td class="btext" rowspan="2" align="center">Remarks <font
												color="red"><b></b></font></td>

											<td class="btext" rowspan="2" align="center">Paper
												clipping Scanned copy <font color="red"><b>*</b></font>
											</td>
											<td class="btext" rowspan="2" align="center">ATR Scanned
												copy</td>
										</tr>
										<tr>
											<td class="btext" align="center">Date<font color="red"><b>*</b></font></td>
											<td class="btext" align="center">PaperName <font
												color="red"><b>*</b></font></td>
											<td class="btext" align="center">Edition <font
												color="red"><b>*</b></font><br></br>(District/State)
											</td>
											<td class="btext" align="center">Gist of Adverse News <font
												color="red"><b>*</b></font></td>


										</tr>

										<logic:iterate name="newsItemForm" id="habData"
											property="habData">
											<%
count++;
%>
											<tr>
												<td align="center" nowrap width="30"><html:checkbox
														name="habData" property="checks" indexed="true" /></td>
												<td class="locked" align="center" nowrap><img
													src="/pred/resources/images/deleteButton2.png"
													onclick="javascript:fnDelete('<bean:write name="habData" property="newsId"   />')" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="slNo" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="districtName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="mandalName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="panchayathName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="villageName" /></td>
												<td class="bwborder"><bean:write name="habData"
														property="habName" />(<bean:write name="habData"
														property="habCode" />
													<html:hidden indexed="true" name="habData"
														property="habCode"></html:hidden>)</td>
												<html:hidden indexed="true" name="habData" property="newsId"></html:hidden>
												<td class="bwborder"><html:text name="habData"
														property="paperDate" styleClass="mytext" style="width:50"
														indexed="true" />&nbsp;<a
													href="javascript: showCalendarFuture(document.getElementById('habData[<%= count-2 %>].paperDate'));">
														<IMG
														SRC="<rws:context page='/images/calendar.gif'/>"
														width="20" border="0" height="17" align="absmiddle">
												</a></td>
												<td class="bwborder"><html:select name="habData"
														property="paperName" style="width:100px" indexed="true">
														<html:option value="Eenadu">Eenadu</html:option>
														<html:option value="Andhra Bhoomi">Andhra Bhoomi</html:option>
														<html:option value="Andhra Jyothi">Andhra Jyothi</html:option>
														<html:option value="Andhra Bhoomi">Andhra Prabha</html:option>
														<html:option value="Praja Sakthi">Praja Sakthi</html:option>
														<html:option value="Vaartha">Vaartha</html:option>
														<html:option value="Sakshi">Sakshi</html:option>
														<html:option value="Hindu">Hindu</html:option>
														<html:option value="Deccan Chronicle">Deccan Chronicle</html:option>
														<html:option value="The Times Of India">The Times Of India</html:option>
														<html:option value="Indian Express">Indian Express</html:option>



													</html:select></td>
												<td class="bwborder"><html:select name="habData"
														property="paperEdition" style="width:100px" indexed="true">
														<html:option value="District">District</html:option>
														<html:option value="State">State</html:option>



													</html:select></td>
												<td class="bwborder"><html:textarea name="habData"
														property="paperNews" rows="3" cols="20" indexed="true" /></td>
												<td class="bwborder"><html:select name="habData"
														property="typeOfAdverseNewsItem" style="width:150px"
														indexed="true">
														<html:option value="Water Availability">Water Availability[Scarcity]</html:option>
														<html:option value="Water Quality Related">Water Quality Related[Contamination]</html:option>
														<html:option value="Both WS AND WC">Both[WS&WC]</html:option>
														<html:option value="Maintenance Problem">Maintenance Problem</html:option>
														<html:option value="Others">Others</html:option>


													</html:select></td>
												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="actionReport" indexed="true" /></td>
												<td class="bwborder"><html:textarea name="habData"
														rows="3" cols="20" property="remarks" indexed="true" /></td>
												<html:hidden indexed="true" name="habData" property="scannedCopyStatus"></html:hidden>
												<nested:notEqual name="habData" property="scannedCopyStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
															width="30px" height="30px" border="0" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=clipImage"
																width="350px" height="230px" /></span></a>
														<!-- <button onclick="visibleSelectImage()">Edit</button> -->
														 <html:file
															name="habData" property="scannedCopy" styleClass="mytext"
															style="width:150" styleId="dplay" indexed="true" /> 
															<!-- <script
															type="text/javascript">
																	var x = document.getElementById("dplay");
																	 x.style.display = "none";
																	</script> -->
																	</td>
												</nested:notEqual>
												<nested:equal name="habData" property="scannedCopyStatus"
													value="no">
													<td class="bwborder"><html:file name="habData"
															property="scannedCopy" styleClass="mytext"
															style="width:150" indexed="true" /></td>
												</nested:equal>
												<%-- <td class="bwborder"><html:file name="habData"
														property="atrScannedCopy" styleClass="mytext"
														style="width:150" indexed="true" /></td> --%>
														<nested:notEqual name="habData" property="atrimageStatus"
													value="no">
													<%-- <td  ><a class="thumbnail"  href="#"><img src='<bean:write name="habData"  property="scannedCopyStatus"/>' width="30px" height="30px" border="0" /><span><img src='<bean:write name="habData"  property="scannedCopyStatus"/>'  width="350px" height="230px"/></span></a></td> --%>
													<%-- <html:file name="habData"  property="scannedCopy" styleClass="mytext" style="width:150"   indexed="true" /> --%>
													<td class="bwborder"><a class="thumbnail" href="#"><img
															src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
															width="30px" height="30px" border="1" id="thumbnail" /><span><img
																src="${pageContext.request.contextPath}/reports/rws_News_Paper_Clipping_Image.jsp?newsId=<bean:write name="habData"  property="newsId"/>&date=<bean:write name="habData"  property="paperDate"/>&mode=atrImage"
																width="350px" height="230px" id="bigImage" /></span></a>
														<!-- <input type="button"  class="btext" onclick="visibleAtrSelectImage()" value="Edit" style="margin-left:  25px;margin-bottom: 10px; "/> -->
														 <html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" /> 
															<!-- <script
															type="text/javascript">
													var x = document.getElementById("atrdplay");
													 x.style.display = "none";
													</script> -->
													</td>
												</nested:notEqual>
												<nested:equal name="habData" property="atrimageStatus"
													value="no">
													<td class="bwborder">
													<html:file
															name="habData" property="atrScannedCopy" styleClass="mytext"
															style="width:150" styleId="atrdplay" indexed="true" />
													
															</td>
												</nested:equal>
											</tr>
										</logic:iterate>



										<%	
}
%>

										<tr>
											<td colspan="11" align="center"><input type="button"
												class="btext" name="save" value="Save" onclick="fnSave()">
												<input type="button" class="btext" name="addRow"
												value="AddRow" id="addRow" onClick="getHabData1();">
												<input type="hidden" name="resultCount" value="<%=count%>"></td>
										</tr>
									</table>
								</td>


							</tr>

						</table> <script>
function visibleSelectImage() {
	alert(" edit :");
  var x = document.getElementById("dplay");
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
function visibleSelectImage(id) {
	//alert(" edit :"+id);
	  var x = document.getElementById(id);
	  if (x.style.display === "none") {
	    x.style.display = "block";
	  } else {
	    x.style.display = "none";
	  }
	}
function visibleAtrSelectImage() {
	  var x = document.getElementById("atrdplay");
	  if (x.style.display === "none") {
	    x.style.display = "block";
	  } else {
	    x.style.display = "none";
	  }
	}

/* function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function (e) {
            $('#bigImage')
                .attr('src', e.target.result);
            $('#thumbnail')
            .attr('src', e.target.result);
            
        };

        reader.readAsDataURL(input.files[0]);
    }
} */
</script>
	</body>
</html:form>

<%@ include file="/commons/rws_alert.jsp"%>


