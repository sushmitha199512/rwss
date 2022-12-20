<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="tenderNotificationForm" />
<script language="JavaScript">
<!--

function addfun()
{
    var index = document.getElementById("count").value;
    var totalHabitations;
   	var noOfSelectedWorkIds = 0;
 	for(var i=0; i<index; i++){
		 if(document.getElementById("WORKID_LIST["+i+"].work").checked)
		    noOfSelectedWorkIds++;  
	}
	if(noOfSelectedWorkIds==0)
	 {
  	   alert("Please select atleast one Work."); 
  	   return false;
  	 }
  	 else
  	 {  
         opener.document.forms[0].noOfWorks.value = noOfSelectedWorkIds;
         return true;
      }
          
          
}
//-->
</script>

</head>

<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">
<html:form action="TenderNotification.do?mode=AddWorkId">

<table  bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="590" align=center>
<tr>
<td>

	<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
		<tr bgcolor="#8A9FCD">
		<td class=mycborder colspan=3><FONT class=myfontclr><font color="#ffffff">Select the Works For Tender Notification </font>
		</td>
		</tr>
		<tr>
		<td class=clrborder align=center>Select</td>
		<td  class=clrborder align=center>Work Id</td>
		<td  class=clrborder align=center>Work Name</td>
 		</tr>
		<% int count=0; %>
		<nested:iterate id="WORKID_LIST" property="workIds">
		<%count=count+1;%>
		<tr>
		<td align=center class=bwborder>
			<nested:checkbox name="WORKID_LIST" property="work" indexed="true" />
		</td>
		
		<td  class=bwborder align=center >
			<nested:text name="WORKID_LIST" property="workId" styleClass="mytbltext" style="width:120px" readonly="true" indexed="true"/>
		</td> 
	 	<td  class=bwborder align=center >
			<nested:text name="WORKID_LIST" property="workName" styleClass="mytbltext" style="width:120px" readonly="true" indexed="true"/>
		</td>
 		</tr>
		</nested:iterate>
		<input type="hidden" name="count" value="<%= count %>">
		</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Add" onclick="return addfun()"/> 
    <html:reset title="Close the Window" styleClass="btext" value="Close" onclick="javascript:window.close()"/>
 
	</td>
</tr>
</table>
 <script>
<!-- 
   var index = document.getElementById("count").value;
   var temp="<%=request.getParameter("form")%>";
   for(var i=0; i<index; i++)
   {
 	  <c:forEach items="${tempSelectedWorkIds}" var="workIds">
   	  	if(document.getElementById("WORKID_LIST["+i+"].workId").value == "<c:out value='${workIds.workId}'/>")
		{
		  document.getElementById("WORKID_LIST["+i+"].workId").checked = true;
  		}
		</c:forEach>	
	}
 
//-->
</script>
</html:form>
</body>
</html>



