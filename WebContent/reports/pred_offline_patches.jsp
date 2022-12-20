<%System.out.println("in download.jsp"); %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<html>
<body>
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader1.jsp">
		<jsp:param name="TableName" value="Download Offline Patches" />
		<jsp:param name="TWidth" value="100%" />
		
	</jsp:include>
</td>
</tr>
</thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter1.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="279" >
<tr>
<td>
	
		<fieldset>
		<legend>&nbsp;</legend>
		<label>
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border="1" 
	   style="border-collapse:collapse;" width="279" >
		
		<tr>
			<td class="textborder"><div align="center"><a href="switch.do?prefix=/reports&page=/offlinePatch.do">Download Patch1</a></div></td>
		</tr>
		<tr>
			<td class="textborder"><div align="center"><a href="switch.do?prefix=/reports&page=/offlinePatch2.do">Download Patch2(11-06-07)</a></div></td>
		</tr>
		<tr>
			<td class="textborder"><div align="center"><a href="switch.do?prefix=/reports&page=/offlinePatch3.do">Download Patch3(21-06-07)</a></div></td>
		</tr>
		<tr>
			<td class="textborder"><div align="center"><a href="switch.do?prefix=/reports&page=/offlinePatch4.do">Download Patch4(20-09-07)</a></div></td>
		</tr>

		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		</table>
	  </td>
		</tr>
		</tbody>
		</table>
</body>
</html>
<%@ include file="/commons/rws_footer.jsp"%>