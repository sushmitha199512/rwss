<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	nic.watersoft.commons.RwsUser user=null;
   	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
   	String loggedUser = user.getUserId();
   	String fileName=(String)session.getAttribute("fname");	
%>
<html>
<body bgcolor="#edf2f8" >
	<table align=center cellspacing = 0 cellpadding = 0 rules="rows"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">Home&nbsp;|&nbsp;</a><a href="javascript:onclick=history.go(-1)">Back  </td> 
				</tr>
			</table>
		</caption>		
	</table>
	<br><br><br><br><br><br>
	<table bordercolor=navy width="50%" height="20%" border=1 rules="rows" style="border-collapse: collapse" align=center>
		<tr align=center>
			<td class=rptLabel><%=fileName %>&nbsp; FILE&nbsp;</td>
		</tr>
		<tr align=center>
			<td class=rptValue><html:link action="/DownloadIt.do">Click here for the MDB</html:link></td>
		</tr>
		<tr>
			<td class=rptValue>
				<html:messages id="msg" message="true">
					<ul>
			       		<li><bean:write name="msg" /></li>
			       	</ul>
			  	</html:messages>
		    </td>
		</tr>
	</table>
	<%@ include file = "/reports/footer.jsp" %>
</body>
</html>
