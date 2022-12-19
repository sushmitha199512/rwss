<%@ include file="/commons/rws_header1.jsp" %>
<%
//System.out.println("in side the parameter list");
java.util.ArrayList carry = (java.util.ArrayList)session.getAttribute("carryResults");
if(carry!=null)
{
for(int i = -1;i<carry.size()-1;)
{
i = i + 3;
//System.out.println("I:"+i+"value:"+carry.get(i));
}
}
%>
<script language="javascript">

</script>
</head>
<body topmargin="0" leftmargin="0" bgcolor="#edf2f8" >
<html:form action="WaterSampleRes.do?mode=Save">

<table align=center width="100%">
	<tr>
		<td align=right>
			<a href="javascript:window.close()">Close</a>
		</td>
	</tr>
	<!-- source details -->
	<tr>
		<td>
			<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
				<tr bgcolor="#8A9FCD">
					<td  class="textborder" nowrap>
						District Name:&nbsp;<bean:write name="districtName" scope="request" />
					</td>
					<td  class="textborder" nowrap>
						Mandal Name:&nbsp;<bean:write name="mandalName" scope="request" />
					</td>
					<td  class="textborder" nowrap>
						Habitaiton Name:&nbsp;<bean:write name="habitationName" scope="request" />
					</td>
					<c:if test="${requestScope.sourceLocation!=''}">
					<td  class="textborder" nowrap>
						Source Location:&nbsp;<bean:write name="sourceLocation" scope="request" />
					</td>
					</c:if>
				</tr>
			</table>
		</td>
	</tr>
				
	
	
	
	
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
					<td align=center class="clrborder">Undesired Effect</td>
					<td align=center class="clrborder">Result</td>
				</tr>
				<%int count1=1; 
				  int val = -1;%>
				
				<nested:iterate id="TESTPARAM_LIST" property="wqtestParams">
				<tr align="left" bgcolor="#ffffff">
					<td  class="bwborder"><%=count1%></td>
					<td  class="bwborder" >
						<nested:hidden name="TESTPARAM_LIST" property="testId" indexed="true" />
						<bean:write name="TESTPARAM_LIST" property="testName"  />
					</td>
					<td  class="bwborder" >
						<nested:hidden name="TESTPARAM_LIST" property="testPCode" 
									   indexed="true" />
						<bean:write name="TESTPARAM_LIST" property="testPName"  />
					</td>
					<td  class="bwborder" align=center>
						<bean:write name="TESTPARAM_LIST" property="minPerVal" />
					</td>
					<td  class="bwborder" align=center>
					<bean:write name="TESTPARAM_LIST" property="maxPerVal" />
					</td>
					<td  class="bwborder" align=left width="200px">
						<bean:write name="TESTPARAM_LIST" property="undesirableEffect"/>
					</td>
					<%
					val = val + 3; %>
					<td class="bwborder" align=center>
					<%if(carry != null){ %>
						<nested:text name="TESTPARAM_LIST" property="result" styleClass="mytbltext" style="width:50px" indexed="true" maxlength="5" value="<%=(String)carry.get(val)%>"/>
						<%}
						else
						{
						 %>
						 <nested:text name="TESTPARAM_LIST" property="result" styleClass="mytbltext" style="width:50px" indexed="true" maxlength="5"/>
						 <%} %>
					</td>
				</tr>
				<%count1++; %>
				</nested:iterate>
				<tr>
					<td align=center colspan="7">
						 <html:submit title="Save Results" styleClass="btext" value="Save" />
					</td>
				</tr>
				
			</table>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
</table>
<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
	<tr bgcolor="#8A9FCD" >
		<td colspan=7 class="textborder">
			<font color="#ffffff">Water Quality Parameters Test(s) Last Updated</font>
		</td>
	</tr>
	<tr>
		<td align=center class="clrborder">SNo</td>
		<td align=center class="clrborder">Updated Date</td>
		<td align=center class="clrborder">Test Id</td>
		<td align=center class="clrborder">Test Name</td>
		<td align=center class="clrborder">Potable</td>
		<td align=center class="clrborder">Recommendations</td>
	</tr>
	<%int count=-1; 
	%>
	<logic:iterate id="waterPtestUpdateList" name="updateParameters">
    <%count++;
    int index = count+1;
    java.util.ArrayList testIds = new java.util.ArrayList();
    testIds = (java.util.ArrayList)session.getAttribute("testids");
     %>
    
    <tr align="left" bgcolor="#ffffff">
    <td  class="bwborder"><%=index%></td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="preparedOn" />
		</td>
		<td  class="bwborder" >
			<a href="switch.do?prefix=/wquality&page=/WaterSampleRes.do?mode=updateTests&testid=<%=testIds.get(count)%>" target="_blank" title="Click to get Water Quality Parameters List "><bean:write name="waterPtestUpdateList" property="testId"/></a>
		 </td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="testName" />
		</td>
		<td  class="bwborder" align="center" >
			<bean:write name="waterPtestUpdateList" property="condemnSource" />
		</td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="recommendations" />
		</td>
				
	</tr>
	</logic:iterate>
	<%if(count==-1){ %>
	<tr><td colspan="10" align="center">No Records</td></tr>
	<%} %>
</table>
</html:form>
</body>
</html> 