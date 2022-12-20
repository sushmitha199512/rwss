<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="conn.jsp" %>
<%!
Statement statement;
ResultSet results;%>
</head>
<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.habitationCode" /></th>
	<th><bean:message key="app.habitationName" /></th>
	<th><bean:message key="app.population" /></th>
	<th><bean:message key="app.status" /></th>
</tr>
</thead>
<tbody class="gridText">
<%

String assetcode=request.getParameter("assetCode");
statement=conn.createStatement();
int index = 0;
String query="select p.panch_code,p.panch_name,(H.census_plain_popu + H.census_sc_popu + H.census_st_popu),h.coverage_status from rws_panchayat_raj_tbl p,rws_asset_hab_tbl a,rws_habitation_directory_tbl h where p.panch_code=a.hab_code and asset_code='"+assetcode+"' and h.hab_code=a.hab_code order by p.panch_name ";
results=statement.executeQuery(query);
while(results.next()){
index++;
 %>
 <tr bgcolor="#8A9FCD"><td><%=results.getString(1) %></td><td><%=results.getString(2) %></td>
 <td class="rptValue" align="right"><%=results.getString(3) %></td>
 <td align="center"><%=results.getString(4) %></td>
 </tr><%}%>
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="4" align="left">
		Total No. of Habitations:&nbsp;<%=index %>
	</th>
</tr>
</tfoot>
</table><br>
<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</body>
</html>

			
		
			 
</BODY>

