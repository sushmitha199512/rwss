<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<table width=500>
	<tr>
		<td align=right>
			<html:link page="/repairlnk.do?mode=data">Back&nbsp;|&nbsp;</html:link>
			<a href="../admin/rws_general_admn_loginsuccess.jsp">Home</a>
		</td>
	</tr>
</table>
<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Asset Component Repair Types</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">S.No</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Asset Type Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Component Type  Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Source Type Name</FONT>
	</td>	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Repair Description</FONT>
	</td>
	<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Action</FONT>
	</td> 
	</tr>
<logic:present name="assetCompRepairLnkList">
<%int i=1;%>
<logic:iterate id="assetCompRepairLnkList" name="assetCompRepairLnkList">
<tr align="left" >
<td  class=mycborder1>
<FONT class=myfontclr1><%=i++%></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetCompRepairLnkList" property="ast" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetCompRepairLnkList" property="astCompName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetCompRepairLnkList" property="sourceTypeName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetCompRepairLnkList" property="repairName" /></FONT>
</td>

<td  class=mycborder1 align=center>
	<a href="./repairlnk.do?repairType=<bean:write name='assetCompRepairLnkList' property='repairType' />&asttype=<bean:write name='assetCompRepairLnkList' property='asttype' />&astComp=<bean:write name='assetCompRepairLnkList' property='astComp' />&souType=<bean:write name='assetCompRepairLnkList' property='souType' />&mode=delete"><font color="#6600CC">Delete&nbsp;</font></a>&nbsp;&nbsp;
</td> 

</tr>
</logic:iterate>
</logic:present>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
