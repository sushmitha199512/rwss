<%@ include file="/commons/rws_SpecialHeader.jsp" %>
</head>
<script>
function checkSp(val)
{
	if(parseInt(document.getElementById('hh'+val).value) < parseInt(document.getElementById('hc'+val).value)){
		alert("House Connections for the habitation is not greater than total house holds");
		document.getElementById('hc'+val).value = '0';
	}

}
function hideDefaultText(element, defaultVal)
	{
		if(element.value == defaultVal){
			element.value =	'';
		}
	}
	
	function showDefaultText(element, defaultVal)
	{
		if(element.value == ''){
			element.value =	defaultVal;
		}
	}
	
	function IsEmpty(aTextField) {
	
		var regexp = /^(\s)*$/
	
		if(regexp.test(aTextField.value)){
			return true;
	
		}else{
			return false;
		}
	}
	</script>
<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<form>
<p align=center>
<font face=verdana size=2 color=red>
Habitations Benefited for the Work : <%=request.getParameter("workName")%>
<%
int cyear = Calendar.getInstance().get(Calendar.YEAR);%>
</font>
</p>
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
		<th rowspan="3">S.No.</th>
	<th rowspan="3">Mandal</th>
	<th rowspan="3" ><bean:message key="app.habitationCode" /></th>
	<th rowspan="3"><bean:message key="app.habitationName" /></th>
	<th rowspan="3"><bean:message key="app.population" /></th>
	<th rowspan="3" ><bean:message key="app.status" /></th>
	<th rowspan="3" >Total House Holds as on 01-04-<%=cyear %></th>
	<th rowspan="3" >House Connections Provided as on 01-04-<%=cyear %></th>
	<th rowspan="3" >Balance House Connections to be Provided as on 01-04-<%=cyear %></th>
	<th rowspan="2" colspan="2">Total House Connections Provided during Current Year(FHTCs)</th>
	<th rowspan="1" colspan="6">Tap connections provided in public institutions</th>
	
	<!-- <th>Stand Posts</th>
	<th>Distribution Length<br>(In Meters)</th> -->
	
</tr>
<tr bgcolor="#8A9FCD">

<th rowspan="1" colspan="2">Functional tap connections provided in School</th>
	<th rowspan="1" colspan="2">Functional tap connections provided in Aganwadi</th>
	<th rowspan="1" colspan="2">Tap connections provided in Other PIs</th>
</tr>
<tr bgcolor="#8A9FCD">
<th>Till date</th>
<th>During the month</th>
<th>Till date</th>
<th>During the month</th>
<th>Till date</th>
<th>During the month</th>
<th>Till date</th>
<th>During the month</th>
</tr>
</thead>
<%int count = 1;

nic.watersoft.works.WorksData1 worksData = new nic.watersoft.works.WorksData1();
java.util.ArrayList selectedHabCodes = worksData.getHabsDetails(request.getParameter("workId"));
		if (selectedHabCodes != null)
			request.setAttribute("completedHabs", selectedHabCodes);		
%>
<tbody class="gridText">
	<c:forEach items="${requestScope.completedHabs}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}"/>
	<tr class="<c:out value='row${index%2}'/>">
		<td align="center"><%=count%></td>
		<td align="center"><c:out value='${item.mandalName}'/></td>
		<td align="center"><c:out value='${item.habCode}'/></td>
		<input type="hidden" name="hab<%=count%>" value="<c:out value='${item.habCode}'/>"/>
		<td><c:out value='${item.habName}'/></td>
		<td align="right"><c:out value='${item.population}'/></td>
		<td align="center"><c:out value='${item.status}'/></td>
		
		
		 <td align="right"><c:out value='${item.tothouseholdsIMIS}'/></td>
		 <td align="right"><c:out value='${item.tothouseconnIMIS}'/></td>
		
		<td align="right"><c:out value='${item.balHouseConn}'/>
		 <input type="text" name="hh<%=count%>" value="<c:out value='${item.houseHolds}'/>" style="width:0px" readonly="true" class="noborder-text-box"></td>
		 <td align="right"><c:out value='${item.houseCons}'/></td>
		
		 <td align="right"><a href="rws_functional_household_connection_frm.jsp?&scheme=<%=request.getParameter("workName")%>&habCode=${item.habCode}&mname=${item.mandalName}&pname=${item.panchayatName}&vname=${item.villageName}&hname=${item.habName}&hh=${item.houseHolds}" ><c:out value='${item.currMonthHC}'/></a>
		 </td>
		 
		  <td align="right"><c:out value='${item.schoolTapTot}'/></td>
		  <td align="right"><a href="switch.do?prefix=/works&page=/WorkStatus.do&mode=schoolTapsList&habCode=${item.habCode}&scheme=<%=request.getParameter("workName")%>&workId=<%= request.getParameter("workId")%>&mname=${item.mandalName}&pname=${item.panchayatName}&vname=${item.villageName}&hname=${item.habName}"><c:out value='${item.schoolTapCurr}'/></a></td>
		 <td align="right"><c:out value='${item.aganwadiTaptot}'/></td>
		   <td align="right"><c:out value='${item.aganwadiTapCurr}'/></td>
		 
		 <td align="right"><c:out value='${item.invTapTot}'/></td>
		<%--  <td align="right"><a href="rws_functional_household_connection_frm.jsp?&scheme=<%=request.getParameter("workName")%>&habCode=${item.habCode}&mname=${item.mandalName}&pname=${item.panchayatName}&vname=${item.villageName}&hname=${item.habName}&hh=${item.houseHolds}"><c:out value='${item.invTapTot}'/></a></td> --%>
		  <td align="right"><a href="individual_tap_conn_details.jsp?&scheme=<%=request.getParameter("workName")%>&habCode=${item.habCode}&mname=${item.mandalName}&pname=${item.panchayatName}&vname=${item.villageName}&hname=${item.habName}&hh=${item.houseHolds}&workId=<%= request.getParameter("workId")%>"><c:out value='${item.invTapCurr}'/></a></td>

	</tr>
	</c:forEach>
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="10" align="left">
		Total No. of Benefited Habitations:&nbsp;<c:out value="${index+1}" />
	</th>
</tr>
</tfoot>
</table><br>
<center>
	<%-- <html:button property="mode" styleClass="btext" onclick="saveDetails()">
		<bean:message key="button.save" />
	</html:button> --%>
	<html:button property="mode" styleClass="btext" onclick="javascript:self.close()">
		<bean:message key="button.close" />
	</html:button>
</center>
<input type="hidden" name="benHabsCount" value="<%=count-1%>">
<input type="hidden" name="work_id" value="<%=request.getParameter("workId")%>">
<input type="hidden" name="workName" value="<%=request.getParameter("workName")%>">
<script>
	function saveDetails()
	{
		var val = "false";
		var count = document.forms[0].benHabsCount.value;
		for(var ii = 1;ii<=count;ii++)
		{
			
			if(document.getElementById("hc"+ii).value!=0 || document.getElementById("sp"+ii).value!=0)
			{
				val = "true";
			}
		}
		if(val=="false")
		{
			alert("Please Enter the value for House Connections or Stand Posts for Benefited Habitation(s)");
		}
		else
		{
			document.forms[0].action="rws_habsToEnterStandPostsAndHouseConnsInsert.jsp";
			document.forms[0].submit();
		}
	}
	</script>

</form>
</body>
</html>
