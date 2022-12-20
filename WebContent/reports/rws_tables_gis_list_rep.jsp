<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<head>
	<script language="JavaScript">
		function show(){
		    if(document.forms[0].district.value==""){
				alert("Please Select District");
				return;
			}
			else if(document.forms[0].mandal.value==""){
				alert("Please Select Mandal");
				return;
		     }
		    else{
				document.getElementById('demo').style.display='block';
				document.getElementById("d").disabled = true;
		    }
		}
		
		function hide(){
			document.getElementById('demo').style.display='none';
			document.getElementById("d").disabled = false;
			document.getElementById("s").disabled = true;
		}
		
		function getTablesData(){
		    if(document.forms[0].district.value==""){
				alert("Please Select District");
				return;
			}
			else if(document.forms[0].mandal.value==""){
				alert("Please Select Mandal");
				return;
		     }    
		   	else {
		     var d=document.forms[0].district.value;
		     var m=document.forms[0].mandal.value;     
		     document.forms[0].action="./rws_tables_gis_list_excel.jsp?district="+d+"&mandal="+m;     
		     document.forms[0].submit();
		     init();
		   }
		}
		function init(){
			document.forms[0].district.value='0';
			document.forms[0].mandal.value='0';
		}
		function funcDistrictChanged(){
			document.forms[0].action="/pred/reports/GisTables.do?mode=mandals";
			document.forms[0].submit();   
		}
	</script>
	<script type="text/javascript" src="progressbar/lib/prototype.js"></script>
	<script type="text/javascript" src="progressbar/lib/jsProgressBarHandler.js"></script>
	<link rel="stylesheet" type="text/css" href="jsProgressBarHandler.css" media="screen" />
	<style type = "text/css">
		/* General Links */
		a:link { text-decoration : none; color : #3366cc; border: 0px;}
		a:active { text-decoration : underline; color : #3366cc; border: 0px;}
		a:visited { text-decoration : none; color : #3366cc; border: 0px;}
		a:hover { text-decoration : underline; color : #ff5a00; border: 0px;}
		img { padding: 0px; margin: 0px; border: none;}

		body {
			margin : 0 auto;
			width:100%;
			font-family: 'Verdana';
			color: #40454b;
			font-size: 12px;
			text-align:center;
		}

		.content {
			margin:20px;
			line-height:20px;
		}

		body h1 {
			font-size:14px;
			font-weight:bold;
			color:#CC0000;
			padding:5px;
			margin-left:10px;
			border-bottom:solid;
			border-bottom-width:1px;
			border-bottom-color:#333333;
		}

		#demo {
			margin : 0 auto;
			width:100%;
			margin:20px;
		}

		#demo .extra {
			padding-left:30px;
		}

		#demo .options {
			padding-left:10px;
		}

		#demo .getOption {
			padding-left:10px;
			padding-right:20px;
		}

	</style>

</head>
<body>
	<html:form action="GisTables.do">
		<table border="1" align="center" cellspacing="0" cellpadding="0" rules="rows" width="32%"  bordercolor="navy" style="border-collapse:collapse" bgcolor="#ffffff">
			<caption>
				<table border="0" rules="none" style="border-collapse:collapse" width="100%" align="right" >		
					<tr>
						<td align="right" class="bwborder"><a href="/pred/home.jsp">Home</td> 
					</tr>
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class="textborder" colspan="2">
					<font color="#FFFFFF">GIS Data Download</font>
				</td>	
			</tr>
			<tr>
				<td>		
					<table bordercolor="navy" width="100%" height="100%" border="0" rules="rows" style="border-collapse:collapse" align="center">
						<tr>
							<td class="textborder">District<span class="mandatory">*</span>	</td>		
							<td class="textborder">
								<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
									<html:select property="district" style="width:140px"   onchange="javascript: funcDistrictChanged()"	 styleClass="mycombo">
										<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
										<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
									</html:select>			
								</logic:equal>
								<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
									<html:text property="districtName" styleClass="mytext" style="width:140px" readonly="true" />				
									<html:hidden property="district" />
								</logic:notEqual>
							</td>
						</tr>
						<tr>
							<td class="textborder">Mandal<span class="mandatory">*</span>
							</td>
							<td>				
								<html:select property="mandal" style="width:140px"    styleClass="mycombo" onchange="hide();" >
									<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
									<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
								</html:select>
							</td>
						</tr>
						<tr>
							<td class="textborder" align=center colspan="2">        
   								<div style="width:100%;margin : 0 auto; text-align:center;" >	
									<div id="demo" style="display:none;">
										<span style="color:#CC3300;font-weight:bold;">Upload Progress Bar</span> <br/>
										<span class="progressBar percentImage1" id="element4">100%</span>
										<div id="elementValue"></div>
										<br/><br/>						
									</div>
								</div>     
							</td>
						</tr>
						<tr>
							<td class="textborder" align=center colspan="2">			 
								<input type=button id="d" value="Download"  class="btext"  onclick="show();">
							</td>
						</tr>
						<tr>
							<td class="textborder" align=center colspan="2">        
  		 						<div style="width:100%;margin : 0 auto; text-align:center;" >	
									<div id="demo2" style="display:none;">
										<input type="button" id="s" disabled="disabled" name="done"  class="btext" value="Click Here to save the Downloaded Data" onclick="getTablesData();"/>
									</div>		
								</div>
     
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
</html>
