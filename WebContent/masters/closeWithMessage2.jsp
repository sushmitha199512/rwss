<%
 if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess)
	var comp = '<%=componentName%>';
	//alert(comp);
	if(comp=="HandPumps" && mess!=null){
	//	alert("sssssssssssssssss");
		opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=data";
opener.document.forms[0].submit();
opener.document.getElementById('docBody').innerHTML="<img align='center'src='/pred/images/ajax-loader3.gif'style='position:absolute; left:350px; top:250px; height=100px; width=300px' ALT='Please wait..' border='0'></img>";

self.close();
	}
	</script>
<%
 }
 if(request.getAttribute("displaymess")!=null)
 {	
	 String mesg=(String)request.getAttribute("displaymess");
%>
	<script language=JavaScript>
	var mesg="<%=mesg%>";
	alert(mesg)
	</script>
<%
 }
%>
