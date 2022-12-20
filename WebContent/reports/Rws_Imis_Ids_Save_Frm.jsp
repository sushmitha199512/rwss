<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<head>
	<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js"></script>
	<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
	<title>WaterSoft</title>	
	<script language="JavaScript">
		function validateFileExtension(){
			var component = document.getElementById("inputFile");
			if(component==null){
		      return;
			} 
		    var ext=component.value.substring(component.value.lastIndexOf('.')+1);       
		    if(ext =="xls"){
	    	  	document.forms[0].action="switch.do?prefix=/reports&page=/imisIds.do&mode=data";
			  	document.forms[0].submit();
		    }
		    else{
	          	alert("Upload Excel Files only");
	          	return false;
		    }     

		}
	</script>
	<style>
		.mystyle{
			border-width:1;
			color:#000000;
			font-weight:bold;
			font-family:verdana;
			font-size:9pt;
		}
		
		.btext{
			border-width:1;
			color:#336600;
			font-weight:bold;
			font-family:verdana;
			font-size:9pt;
			background-color:#ffffff
		}
	</style>
</head>
<body bgcolor="#edf2f8">
<html:form action="imisIds.do" method="post" enctype="multipart/form-data">
<table border="1" align="center" cellspacing="0" cellpadding="0" rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
		<table  border="0" rules="none" style="border-collapse:collapse" width="100%" align="right" bgcolor="#edf2f8">
			<tr>
				<td align="right" class="bwborder"><a href="./home.jsp">Home</td> 
			</tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="textborder" colspan="2">
			 <font color="#FFFFFF">IMIS Scheme &amps; Source Ids Porting</font>
		</td>	
	</tr>
	<tr> 
		<td valign="top" align="center" height="25%" width="30%">
			<table bordercolor="navy" width="100%" height="100%" border="1" rules="rows" style="border-collapse:collapse" align = center>
				<tr>
					<td class=rptLabel>IMIS ID's&nbsp;<font color="red">*</font></td>
					<td class=btext> <input type="radio" name="imis"  value="schemes" checked="checked" >Schemes&nbsp;&nbsp;<input type="radio" name="imis" value="sources" >Sources&nbsp;</td>
				</tr>
				<tr>
					<td class="rptLabel">Upload Excel File&nbsp;<font color="red">*</font></td>
					<td class="btext"><html:file property="inputFile" /></td>        
				</tr>
			</table>
		</td>
	</tr>
	<tr>	
		<td colspan="2" align="center" valign="top" class="rptLabel">
			<table bordercolor="navy" width="40%" border="0" rules="none" style="border-collapse:collapse" align="center">
				<tr>
					<td colspan=2 align=center><input type="button" value="Start" class="btext" onclick="validateFileExtension()"></td>
				</tr>
			</table>	
		</td>
	</tr>
</table>
<br>
<div id="content" style="display:none" ><img src=<rws:context page='/images/LoadingNN.gif'/> alt="Loading Wait..." title="Loading Wait..."></div>
</html:form>
</body>
<script language="javascript">
	<% if(request.getAttribute("message")!=null) {%>
	 alert('<%=request.getAttribute("message")%>');
	<% request.removeAttribute("message"); }%>
</script>
<%@ include file="/commons/rws_footer.jsp" %>
</html>
