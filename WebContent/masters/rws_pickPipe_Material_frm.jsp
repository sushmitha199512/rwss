<%@ include file="/commons/rws_header1.jsp" %>
<%="sadiq"%>
<script language="JavaScript">
<!--

function fnGetpipeClass(elem)
{
	alert("sadiq   " );
	alert(elem.name);
	var index = document.getElementById("pipeMaterial").value;
	//var index = elem.name.value
	/*document.forms[0].action="/pred/masters/Asset.do?mode=pipeclass&index="+index;
	document.forms[0].submit();*/

 var url = "switch.do?prefix=/masters&page=/Asset.do&mode=pickpipemat"
				
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
					  
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}

	/*document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=pickpipemat"
	+ "&index="+index;
	alert("ddddddddd");
	 document.forms[0].submit();*/
	   
}

function fnAdd(frm)
{
	var selectedHabs = 	frm.elements("selectedHabCode");
	var len;
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
	}
}
		
//-->
</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">

<form name=f1 action="<%= request.getRequestURI()%>">
<%int count=0; %>

<table width="50%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block" align="center">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	 <th> 
		<font size="1" face="verdana" color="black"><b>&nbsp;Pipe Mateiral</b></font>
		</th> 
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;Pipe Class</b></font>
		 </th> 
		  <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;Pipe Diameter</b></font>
	 </th>

</tr>
</thead>
<tbody class="gridText">

<tr>
 <td align=center >
		
<SELECT name="assetType" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>	

		</td>
 <td align=center >
		<SELECT name="assetType" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>	
		</td>
 <td align=center >
		<SELECT name="assetType" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>		
		</td>
		
	
		 </tr>



</tbody>
</table>

<br>
<center>
	<input type=submit  value="Add" styleClass="btext"/>
	<input type=button value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>




</form>
</body>
</html>
