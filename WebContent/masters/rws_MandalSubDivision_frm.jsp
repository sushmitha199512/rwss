<%@ include file="/commons/rws_header1.jsp" %>
</head>
<body topmargin="0" leftmargin="0" bgcolor="#edf2f8">

<table align=center width="100%">
	<tr>
		<td align=right>
			<a href="javascript:window.close()">Close</a>
		</td>
	</tr>
	<tr>
	<td><FONT class=myfontclr><font color="#993366"><bean:message key="app.subdivision" />:</FONT>
	<font color=navy><%=(String)session.getAttribute("sdon")%></font>	
	</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff">
				<tr bgcolor="#8A9FCD">
					<td colspan=2 class="textborder">
						<font color="#ffffff">Mandal Sub Divisions List</font>
					</td>
				</tr>
				<tr>
					<td align=center class="clrborder">Mandal Code</td>
					<td align=center class="clrborder">Mandal Name</td>
				</tr>
				<logic:iterate id="mandalsubdivisons" name="mandalsubdivisons">
                 <tr align="left" bgcolor="#ffffff">
		           <td  class="bwborder" >
			        <bean:write name="mandalsubdivisons" property="mandalCode" />
				</td>
				<td  class="bwborder" >
				<bean:write name="mandalsubdivisons" property="mandalName" />
				 </td>
				</tr>
				 </logic:iterate>
			</table>
		</td>
	</tr>
</table>
 
</body>
</html>