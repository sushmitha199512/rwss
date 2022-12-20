<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%System.out.println("DATA Entered"); %>
<script language="javascript">
function openDeleteWindow(url) {
	var width = 1;
		 var height = 1;
		 var left = parseInt((screen.availWidth/2)-(width/2));
		 var top = parseInt((screen.availHeight/2)-(height/2));
		 
		 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
		 var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
}

function openEditWindow(url) {
	var width = 850;
	var height = 550;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
		 
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
</script>
<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="99%">
<caption align=right>
<table align=right>
	<tr>
		<td	class="bwborder" align="right"><a href="../home.jsp" >Home </a>|</td>
		<td	class="bwborder" align="right"><a href="switch.do?prefix=/masters&page=/school.do&mode=data">Back</a></td>
	</tr>
</table>
</caption>
<tr><td colspan=18 class="textborder">Schools List</td></tr>
<%
if(request.getAttribute("dName")!=null){%>
<tr>
<td colspan="18">
<FONT class=myfontclr><font color="#993366">District:</font><%=request.getAttribute("dName")%> &nbsp;&nbsp;</font> 
<%}
  if(request.getAttribute("mName")!=null && !request.getAttribute("mName").equals("") ){%>
<FONT class=myfontclr><font color="#993366">Mandal:</font> <%=request.getAttribute("mName")%> &nbsp;&nbsp;</font>
<%}//System.out.println("pname in jsp "+request.getAttribute("pName"));
  if(request.getAttribute("pName")!=null && !request.getAttribute("pName").equals("") ){%>
<FONT class=myfontclr><font color="#993366">Panchayat:</font> <%=request.getAttribute("pName")%> &nbsp;&nbsp;</font>
<%}
//System.out.println("vname in jsp "+request.getAttribute("vName"));
  if(request.getAttribute("vName")!=null &&  !request.getAttribute("vName").equals("") ){%>
<FONT class=myfontclr><font color="#993366">Village:</font> <%=request.getAttribute("vName")%>  &nbsp;&nbsp;</font>
<%}%>
</td>
</tr>

<tr>
	<td align=center>
		<FONT class=myfontclr><font color="#993366">S.NO.</FONT></FONT>
		</td>
		<%
		if(request.getAttribute("dName")==null || request.getAttribute("dName").equals("") ){%>
		<td  align=center nowrap>
		<FONT class=myfontclr><font color="#993366" >District Name</FONT>
		</td>
		<%}
		if(request.getAttribute("mName")==null || request.getAttribute("mName").equals(""))
		{%>
		<td  align=center nowrap>
		<FONT class=myfontclr><font color="#993366">Mandal Name</FONT>
		</td>
		<%}
				if(request.getAttribute("pName")==null || request.getAttribute("pName").equals(""))
		{  %>
		<td  align=center nowrap>
		<FONT class=myfontclr ><font color="#993366">Panchayat Name</FONT>
		</td>
		<%}
				if(request.getAttribute("vName")==null || request.getAttribute("vName").equals("") )
		{ %>
		<td  align=center nowrap>
		<FONT class=myfontclr><font color="#993366">Village Name</FONT>
		</td>
		<%}%> 
	
		<td  align=center>
		<FONT class=myfontclr><font color="#993366">Habitation_Name</FONT>
		</td>
		
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">School_Code</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">school_Name</FONT></FONT>
		</td>
	
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">No_Of_Students</FONT></FONT>
		</td>
			
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">No_Of_Boys</FONT></FONT>/<br>
		<FONT class=myfontclr><font color="#993366">No_Of_Girls</FONT></FONT>
		</td>
	
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">School_Category</FONT></FONT>
		</td>
						
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">School Classification</FONT></FONT><br>
		</td>
		
	
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Facilities Available</FONT></FONT>
		</td>
		
		
		
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Separate Toilet</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Separate Urinal</FONT></FONT><br>
		</td>
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Running Water in Toilets</FONT></FONT>
		</td>			
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Reasons Non_Availibility<br>Drinking Water Facility</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Sanitation Facility</FONT></FONT><br>
		</td>
	
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Target Drinking water:<br>Month</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Year</FONT></FONT><br>
		</td>
			<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Completion Date Drinking water:</font>
			</td>
		
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Target Sanitation:<br>Month</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Year</FONT></FONT><br>
		</td>
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Completion Date Sanitation:</FONT>
		</td>
		
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Source of funding<br>Drinking water facility</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Sanitation facility</FONT></FONT><br>
		</td>
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Latitude-N</FONT></FONT></td>
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Longitude-E</FONT></FONT></td>
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Elevation</FONT></FONT></td>
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Way Point</FONT></FONT></td>
		
		
		
		
		
		
		<td colspan=2 align=center nowrap>
		<FONT class=myfontclr><font color="#993366">Action</FONT></FONT><br>
		</td>
	
		</tr>
<% int a=1; 
%>
<logic:iterate id="details" name="list">

<tr>
<td  class=mycborder1 align=center>
<FONT class="bwborder"><%=a++ %></FONT>
</td>

<%		
		if(request.getAttribute("dName")==null || request.getAttribute("dName").equals("") ){%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="distName"/></FONT><BR>
</td>
<%}
		if(request.getAttribute("mName")==null || request.getAttribute("mName").equals("") ){%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="mandName"/></FONT><BR>
</td>
<%}
		if(request.getAttribute("pName")==null || request.getAttribute("pName").equals("") ){%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="panchName"/></FONT><BR>
</td>
<%}

		if(request.getAttribute("vName")==null || request.getAttribute("vName").equals("") ){%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="villName"/></FONT><BR>
</td>
<%}%>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="habName"/></FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="schoolCode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="details" property="schoolName" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="noStudents" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="details" property="noBoys" /></FONT><br> 
<FONT class=myfontclr1><bean:write name="details" property="noGirls" /></FONT>
</td>
<td class=mycborder1>
<FONT class=myfontclr1><bean:write name="details" property="category" />&nbsp;</FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="classify" /></FONT><BR>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="facilities" />&nbsp;</FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="toilets" />&nbsp;</FONT><BR>
<FONT class=myfontclr1><bean:write name="details" property="urinals" />&nbsp;</FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="runningwater" />&nbsp;</FONT><BR>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="nonDrink" /></FONT><br>
<FONT class=myfontclr1><bean:write name="details" property="nonSani" /></FONT>
</td>
<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="drkMonth" /></FONT><br>
<FONT class=myfontclr1><bean:write name="details" property="drkYear" /></FONT>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="complDateDW" /></FONT><br>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="saniMonth" /></FONT><br>
<FONT class=myfontclr1><bean:write name="details" property="saniYear" /></FONT>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="complDateSanitation" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="sourceDrkFund" /></FONT><br>
<FONT class=myfontclr1><bean:write name="details" property="sourceSaniFund" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="schoolLatitude" /></FONT></td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="schoolLongitude" /></FONT></td>
<td  class=mycborder1 nowrap><FONT class=myfontclr1><bean:write name="details" property="schoolElevation" /></FONT></td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="schoolWaypoint" /></FONT></td>




<td  colspan=2 align=center nowrap>
<!-- <a href="./school.do?hab_code=<bean:write name='details' property='habitation'/>&school_code=<bean:write name='details' property='schoolCode'/>&mode=get"><font color="#6600CC">Edit </FONT>| -->
<!--  <a href="#1" onclick=openEditWindow('./school.do?hab_code=<bean:write name='details' property='habitation'/>&school_code=<bean:write name='details' property='schoolCode'/>&mode=get')> -->

<a href="#1" onclick=openEditWindow('./school.do?hab_code=<bean:write name='details' property='habitation'/>&school_code=<bean:write name='details' property='schoolCode'/>&mode=get')>

<font color="#6600CC"><b>Edit</b></font></a>&nbsp;

</td>




</tr>
</logic:iterate>

<%
if(a==1)
{ %>
		<tr>
		<td colspan=15 align=center nowrap>
		<FONT class=myfontclr><font color="#993366">NO RECORDS</FONT></FONT><br>
		</td>	
		</tr>


<%} %>
</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp"%></p>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
</body>
</html>




