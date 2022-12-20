<%@ page trimDirectiveWhitespaces="true" %>
<script>
function fnRefresh(){
	var openRequest = getAjaxRequest();
	document.getElementById('refresh').style.display='none';
	document.getElementById('load').style.display='block';	
	var url = "<%=request.getContextPath()%>/admin/Captcha/form.jsp?refresh=Y";
	alert(url);
	openRequest.open("POST",url,false);
	postData="";
	openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	openRequest.send(postData);
	document.getElementById("captcha").innerHTML=openRequest.responseText;
	document.getElementById('refresh').style.display='block';
	document.getElementById('load').style.display='none';
}

function getAjaxRequest(){
	var openRequest;
	try {
		openRequest = new XMLHttpRequest();
		return openRequest;
	}
	catch (error) {
		try {
			openRequest = new ActiveXObject("Microsoft.XMLHTTP");
			return openRequest;
		}
		catch (error){
			if(isDebugOn)
			displayDebugError("Error");
		}			
	}
}
</script>
<table border="0" align="center">
 	<tr>
		<td align="center" colspan="2">
			<table>
				<tr>
					<td>
						<%if(request.getParameter("refresh")!=null && request.getParameter("refresh").equals("Y")) {%>
							<img src="<%=request.getContextPath()%>/admin/Captcha/Cap_Img.jsp?refresh=Y">&nbsp;&nbsp;&nbsp;
						<%System.out.println("if");}else{System.out.println("Else");%>
							<img src="<%=request.getContextPath()%>/admin/Captcha/Cap_Img.jsp">&nbsp;&nbsp;&nbsp;
						<%}%>
					</td>
					<td>
						<div id="refresh" style="display:block"><img src="<%=request.getContextPath()%>/admin/Captcha/refresh.gif" title="Get a New Security Code" onClick="fnRefresh()"></div>
						<div id="load" style="display:none"><img src="<%=request.getContextPath()%>/images/loading.gif"/></div>
					</td>
				</tr>
			</table>
</td></tr>
<tr>
	<td align="center" class=rptValue>Enter the string shown above<span class="mandatory">*</span></td>
</tr>
<tr>
	<td align="center"><input name="number" type="text" onkeypress="upperOnly()" maxlength=6></td>
</tr>
</table>
