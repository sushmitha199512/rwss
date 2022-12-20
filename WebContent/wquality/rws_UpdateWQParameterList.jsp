<%@ include file="/commons/rws_header1.jsp" %>
<script language="javascript">


</script>
</head>
<body topmargin="0" leftmargin="0" bgcolor="#edf2f8" >
<html:form action="WaterSampleRes.do?mode=updateTests">

<table align=center width="100%">
	<tr>
		<td align=right>
			<a href="javascript:window.close()">Close</a>
		</td>
	</tr>
	<!-- source details -->
	
				
	
	
	
	
	<!--  end of source details -->
	<tr>
		<td>
			<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
				<tr bgcolor="#8A9FCD">
					<td colspan=7 class="textborder">
						<font color="#ffffff">Water Quality Parameters List (As Per IS 10500:1991 Edition 2.2 (2003-09)</font>
					</td>
				</tr>
				<tr>
					<td align=center class="clrborder">SNo</td>
					<td align=center class="clrborder">Test Name</td>
					<td align=center class="clrborder">Parameter Name</td>
					<td align=center class="clrborder">Min Per Val</td>
					<td align=center class="clrborder">Max Per Val</td>
					<td align=center class="clrborder">Result</td>
				</tr>
				<%int count=0; %>
				<logic:iterate id="waterPtestUpdateList" name="updateParameters">
    <%count++; %>
    
    <tr align="left" bgcolor="#ffffff">
		<td  class="bwborder"><%=count%></td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="testName" />
		 </td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="testPName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="waterPtestUpdateList" property="minPerVal" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="waterPtestUpdateList" property="maxPerVal" />
		</td>
				<td  class="bwborder" align=center>
			<bean:write name="waterPtestUpdateList" property="result"/>
		</td>
		
	</tr>
	</logic:iterate>
			</table>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
</table>
</html:form>
</body>
</html> 