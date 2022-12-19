<%
 if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess)
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
