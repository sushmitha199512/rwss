<%@ include file="/commons/rws_header1.jsp" %>
<%String value=request.getParameter("index");
 %>
<script language="JavaScript">

function addfun()
{
 	var index = document.getElementById("count").value;
	for(var i=0;i<index;i++)
	{
		//alert(document.getElementById("kpiHabList["+i+"].checks").value);
		//alert(document.getElementById("kpiHabList["+i+"].habCode").value);		
	}	
	var work_id="<%=request.getParameter("workid")%>";
	//alert(work_id);
	var habs="";
 	var noOfSelectedHabs=0;
 	for(var i=0; i<index; i++)
 	{
		 if(document.getElementById("kpiHabList["+i+"].check").checked)
		 {
			    noOfSelectedHabs++;	 
			    if(habs==""){
			    habs=document.getElementById("kpiHabList["+i+"].habCode").value;
			    }else{
			    	habs+="/"+document.getElementById("kpiHabList["+i+"].habCode").value;
			    }			    
		 }
		
	}	
 	// alert(habs);
	if(noOfSelectedHabs==0)
	{
  	   alert("Please select atleast one habitation."); 
  	   return false;
  	}
  	  
  		if(window.opener!=null&& !window.opener.closed){
  			window.opener.document.forms[0].elements["psWorks["+<%=value%>+"].kpiHabList"].value=habs;
  			window.opener.document.forms[0].action="switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=AddKpiHabs";
  			window.opener.document.forms[0].submit(); 
  		}
	self.close();
}
   
</script>

</head>
<body bgcolor="#edf2f8" topmargin="0" leftmargin="0" >
<form  method=post>
<table  bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="590" align=center>
<tr>
<td>
	<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
		<tr bgcolor="#8A9FCD">
		  <td class=mycborder colspan=5><FONT class=myfontclr><font color="#ffffff">Select the Habitations </font></td>
		</tr>
		<tr>
			<td class=clrborder align=center>Select</td>
			<td  class=clrborder align=center>Hab Code</td>
			<td  class=clrborder align=center>Hab Name</td>		
		</tr>
		<% int count=0; %>		
		<nested:iterate id="kpiHabList" name="kpiHabs" >		
		<%count=count+1;%>
		<tr>
		<td align=center class=bwborder>			
			<nested:checkbox name="kpiHabList" property="check" indexed="true" />			
		</td>		
		<td  class=bwborder align=center >
			<nested:text name="kpiHabList" property="habCode" styleClass="mytbltext" style="width:160px" readonly="true" indexed="true"/>
			<nested:hidden  name="kpiHabList" property="habCode" indexed="true"/>
		</td> 
	 	<td  class=bwborder align=center >
			<nested:text name="kpiHabList" property="habName" styleClass="mytbltext" style="width:120px" readonly="true" indexed="true"/>
		</td>		
		</tr>
		</nested:iterate>
		
		<input type="hidden" name="count" value="<%= count %>">
		</table>
	</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		 <input type="button" title="Save the Fields" value="Add" onclick="return addfun()" />
	     <!-- <input title="Close the Window" styleClass="btext" value="Close" onclick="javascript:window.close()"/> -->
		</td>
	</tr>
</table>
<script>
<!-- 
  var index = document.getElementById("count").value;
    for(var i=0; i<index; i++)
   {   
   if(document.getElementById("SOURCEHAB_LIST["+i+"].panchRajCode").value == "<c:out value='${baseHab}'/>")
 	  {
 	  
 	  	document.getElementById("SOURCEHAB_LIST["+i+"].habCode").checked = true;
 	  	document.getElementById("SOURCEHAB_LIST["+i+"].habCode").disabled = true; 	  	
 	  }
   
 	 /* <c:forEach items="${tempSelectedSourceHabs}" var="habs">
		if(document.getElementById("SOURCEHAB_LIST["+i+"].panchRajCode").value == "<c:out value='${habs.panchRajCode}'/>")
		{
		   document.getElementById("SOURCEHAB_LIST["+i+"].habCode").checked = true;
		}
		</c:forEach>	*/
	}
 
//-->
</script>
</form>
</body>
</html>
