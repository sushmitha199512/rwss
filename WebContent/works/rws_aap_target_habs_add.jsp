 
<%@ include file="/commons/rws_header1.jsp" %>
 
<script language="JavaScript">


function fnClose(){

	document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=close";
	document.forms[0].submit();

}

function fnDelete(){

			
var selectedHabs = 	document.forms[0].elements["deleteHabCode"];
alert("Ss");
var len;
var aapHabs="";
	var isAllowed = false;
	if(selectedHabs)
	{
		if(typeof selectedHabs.length != 'number')
			selectedHabs = [selectedHabs];
		
		len = selectedHabs.length;
		for(var i=0; i<len; i++)
		{
			if(selectedHabs[i].checked)
				isAllowed = true;
		}
		 
		if(isAllowed)
		{
			if(confirm("Do You Want To Delete The Selected Habitations?"))
			{
				 
				var totalHabitations = document.forms[0].elements["deleteHabCode"];
				 //alert(totalHabitations);
				var noOfSelectedHabs = "";
				if(totalHabitations)
				{
					if(typeof totalHabitations.length != "number")
					{
						totalHabitations = [totalHabitations];
					}
					var len = totalHabitations.length;
					
					for(var i=0; i<len; i++){
						if(totalHabitations[i].checked)
						{
						    //alert(totalHabitations[i].value)
						    
						     aapHabs+=totalHabitations[i].value;
						     aapHabs+=",";
							noOfSelectedHabs++;  
					    }
					}
				}

				if(confirm("Are you Confirm to Delete Seleted habitations:"+ noOfSelectedHabs+" hab(s)")){

				 parent.location.href="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=deleteHabs&selectedHabs="+aapHabs;
				}
		 	 	//document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=saveTarget";
				
			   //document.forms[0].submit();
			    
				return true;
			}
		}
		else
			alert("Please select atleast one habitation.");
	}
	return false;
	
}

function fnSave()
{


	var finYear=document.forms[0].elements["aapFinYear"].value;
	if(finYear==" "){
		alert("Please Select Target Financial Year");
		return;
	}
		
	var selectedHabs = 	document.forms[0].elements["selectedRevHabCode"];
	var len;
	var aapHabs="";
	var isAllowed = false;
	if(selectedHabs)
	{
		if(typeof selectedHabs.length != 'number')
			selectedHabs = [selectedHabs];
		
		len = selectedHabs.length;
		for(var i=0; i<len; i++)
		{
			if(selectedHabs[i].checked)
				isAllowed = true;
		}
		 
		if(isAllowed)
		{
			if(confirm("Do you want add the selected habitations?"))
			{
				 
				var totalHabitations = document.forms[0].elements["selectedRevHabCode"];
				 //alert(totalHabitations);
				var noOfSelectedHabs = "";
				if(totalHabitations)
				{
					if(typeof totalHabitations.length != "number")
					{
						totalHabitations = [totalHabitations];
					}
					var len = totalHabitations.length;
					
					for(var i=0; i<len; i++){
						if(totalHabitations[i].checked)
						{
						    //alert(totalHabitations[i].value)
						    
						     aapHabs+=totalHabitations[i].value;
						     aapHabs+=",";
							noOfSelectedHabs++;  
					    }
					}
				}

				alert("You have added "+ noOfSelectedHabs+" hab(s)");

				 parent.location.href="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=saveTarget&selectedHabs="+aapHabs+"&aapTargetYear="+finYear;
				 fnClose();
				return true;
			}
		}
		else
			alert("Please select atleast one habitation.");
	}
	return false;
}



 
</script>
</head>


<body onload="initData();" >
  	             
<html:form action="workUpdation"  method="POST"  >
<html:hidden property="workIdList" value="<%=request.getParameter(\"workId\")%>"/>
<logic:notEmpty name="habitations">
<center>
<font color="green"><h3>Admin Sanction Habitations</h3></font>
</center>
<br></br>


<font color="green"><h6>AAP&nbsp;TARGET&nbsp;YEAR:<font color="red"><b>*</b></font><html:select property="aapFinYear"
							style="width:83px" styleClass="mycombo"	>
							<html:option value=" ">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="finYears" property="value"
								labelProperty="label" />
						</html:select>
</h6></font>

<table width="100%" cellspacing="0" cellpadding="2"  
	   style="border-collapse:collapse;">
<thead >
<tr >
<td class="gridhdbg">Slno</td>
	<td class="gridhdbg">District</td>
	<td class="gridhdbg">Mandal</td>
	<td class="gridhdbg"><bean:message key="app.habitationCode" /></td>
	<td class="gridhdbg"  ><bean:message key="app.habitationName" /></td>
	<td class="gridhdbg" ><bean:message key="app.population" /></td>
	<td class="gridhdbg"><bean:message key="app.status" /></td>
	<td class="gridhdbg">AAP&nbsp;TARGET&nbsp;YEAR</td>
	<td class="gridhdbg">Select</td>
		
</tr>
</thead>
<tbody >

<%
String style="";
int styleCount=0;
int count=1;


%>
<c:forEach items="${habitations}" var="item" varStatus="status">

<%

if(styleCount%2==0){
	 style="gridbg1";
}else{
	 style="gridbg2";
}
styleCount++;

%>
<tr >
	
	<td class=<%=style %>  style="text-align: left;">
	<%=count++ %>
	</td>
	<td class=<%=style %>  style="text-align: left;">
	<c:out value="${item.districtName}" />
	</td>
	<td class=<%=style %> style="text-align: left;">
		<c:out value="${item.mandalName}" />
	</td>
	<td class=<%=style %> style="text-align: left;">
		<c:out value="${item.habCode}" />
	</td>
	<td class=<%=style %> style="text-align: left;">
		<c:out value="${item.habName}" />
	</td>
	
	<td class=<%=style %> style="text-align: right;">
		<c:out value="${item.population}" />
	</td>
	<td class=<%=style %> style="text-align: left;">
		<c:out value="${item.status}" />
	</td>
	<td class=<%=style %> style="text-align: left;">
		<c:out value="${item.facilities}" />
	</td>
	
	
	<td class=<%=style %> style="text-align: left;">
		<input type="checkbox" name="selectedRevHabCode" 
			   value="<c:out value='${item.habCode}' />" <c:out value='${item.habMatch}' />/>
	</td>
	
</tr>
</c:forEach>
</tbody>
</table>
 
<br>
<center>
	<input type="button" value="Save" class="btext" onclick="fnSave()"/>
	
	
	
	
</center>
</logic:notEmpty>

<logic:empty name="habitations">
<center>
<br></br>
<br></br>
<br></br>
<br></br>
 <font color="green"><h5>No Records</h5></font>
</center>
</logic:empty>
 
</html:form>

</body>

 