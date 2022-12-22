<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table widht=500>
<tr>
<td align="right">
<html:link page="/Employee.do?mode=checklist">Back&nbsp;|&nbsp;</html:link>
<html:link page="/index.jsp">Home&nbsp;|&nbsp;</html:link>
</tr>
</table>

<table  width="2000" height="15"  bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><font color="#FFFFFF">Employee Form</font></td>
<td align=right>
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="760" border=1 style="border-collapse:collapse" CELLPADDING="75">
<tr>
		<td class=mycborder align=center align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.serialno" /></FONT></FONT>
		</td>
		<td  class=mycborder align=center colspan=2>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.sector" />&nbsp;/</FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.officecode1"/></FONT></td>
		<td  class=mycborder align=center colspan=2 >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empcode" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.surname" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.name" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.social" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.relation" />&nbsp;</FONT></FONT>
		</td>
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.gender" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dob" /></FONT></FONT>
		</td>

		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.religion" /></FONT></FONT>
		</td>
	
	
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.ndistrict" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.nmandal" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center colspan=2>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.appointdate" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.doj" /></FONT></FONT></td>

		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.moap" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.apcatog" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.zone" /></FONT></FONT>
		</td>

		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.nrevenue"/></FONT></FONT>
		</td>

		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qual" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.addqual21" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.deputation"/>/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.panno" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.apgli" /></FONT></FONT>

		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.narecruit" />&nbsp;</FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dacctest1" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.testpassed" />&nbsp;</FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dcommprob" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.empsddeclprob" /></FONT></FONT>
		</td>
			
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.tempdesig" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.perdesig" />&nbsp;/</FONT></FONT><BR>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.desgnCode" /></FONT></FONT><BR>
		</td>

		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.currentpostdate" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.presentstation" /></FONT></FONT>
		</td>
		
				
		<td  class=mycborder align=center >
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.diststudied4" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.diststudied5" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.diststudied6" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.diststudied7" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.diststudied8" />/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.diststudied9" />/</FONT></FONT>		
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.diststudied10" /></FONT></FONT>		 
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.localdist" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.noofyrs" />&nbsp;</FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.localzone" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.noofyrs1" />&nbsp;</FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.pvtdist" />&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.pvtzone" />&nbsp;</FONT></FONT>
		</td>
				
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.workSpecial" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.payscale"/>&nbsp;/</FONT></FONT>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.incrementdate" /></FONT></FONT>
		</td>
		
		<td  class=mycborder align=center colspan=6>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.otherDet" /></FONT></FONT>
		</td>
	
		<td  class=mycborder align=center colspan=2>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></FONT></td>
		</tr>
<% int a=1; %>
<logic:iterate id="emplist" name="emps">

<tr>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=a++ %></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="hoc"/></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="roc" /></FONT>
</td>

<td  class=mycborder1  align=center colspan=2 >
<FONT class=myfontclr1><bean:write name="emplist" property="empcode" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="surname" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="empname" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="social" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="relation" /></FONT><BR><BR>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="gender" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="dob" /></FONT><BR>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="religion" /></FONT><BR>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="ndist" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="nmand" /></FONT>
</td>

<td  class=mycborder1 align=center colspan=2>
<FONT class=myfontclr1><bean:write name="emplist" property="appointdate" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="doj" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="moap" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="apcatog" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="zone" /></FONT>
</td>

<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="emplist" property="nrevenue" /></FONT>
</td>


<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="qualName" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="addqual2" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="deputation" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="panno" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="apgli" /></FONT>
</td>


<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="emplist" property="narecruit" /></FONT><BR><BR>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="dacctest" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="testpassed" /></FONT><BR>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="dcommprob" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="ddeclprob" /></FONT><BR>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="tempdesig" /></FONT><BR><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="perdesig" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="desgnCode" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="currentpostdate" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="presentation" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="diststudied4" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="diststudied5" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="diststudied6" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="diststudied7" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="diststudied8" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="diststudied9" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="diststudied10" /></FONT><br><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="localdist" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="noofyrs" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="localzone" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="noofyrs1" /></FONT>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="pvtdist" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="pvtzone" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="workSpecial" /></FONT><BR>
</td>

<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="emplist" property="payscale" /></FONT><br><BR>
<FONT class=myfontclr1><bean:write name="emplist" property="incrementdate" /></FONT>
</td>


<td  class=mycborder1 colspan=6 align=center>
<FONT class=myfontclr1><bean:write name="emplist" property="otherDet" /></FONT>
</td>



</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>


