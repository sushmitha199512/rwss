<%@ include file="/commons/rws_prajapatham_header1.jsp" %>
  <%@ include file="/commons/rws_prajapatham_header2.jsp" %>
<%try{ %>
<table width="90%">
<tr><td align=right><html:link page="/prajapadam.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp?loginMode=prajapatham'/>">Home&nbsp;&nbsp;</a>
<!--<html:link page="/rws_TenderScheduleA_rpt.jsp" target="_new">&nbsp;&nbsp;</html:link>
<html:link page="/rws_TenderScheduleA_xls.jsp" target="_new"></html:link>-->
</tr>
</table>

<table   width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Prajapadam List</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClosePraja()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr >
	
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">District</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Mandal</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Hab Name</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Constituency</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Status</FONT>
	</td>
 
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">CPWS Exist</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">PWS Exist</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Direct Pumping Exist</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Bore Wells Exist</FONT>
	</td>
	
	<td class=mycborder align=center   colspan=7>
	<FONT class=myfontclr><font color="#993366" ><font color="#993366">Others </FONT>
	</td>
	
</tr>
<logic:iterate id="praja" name="prajapadamList" length="1">
<input type="hidden" name="districtCode" value=<bean:write name="praja" property="districtCode" />/>
<input type="hidden" name="mandalCode" value=<bean:write name="praja" property="districtCode" />/>
<input type="hidden" name="habCode" value=<bean:write name="praja" property="habCode" />/>
</logic:iterate>
<logic:iterate id="praja" name="prajapadamList" length="1">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="praja" property="districtName" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="praja" property="mandalName" /></FONT>
</td>

<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="praja" property="habName" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="praja" property="conName" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="statusAsOn" /></FONT>
</td>

 

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="cpws" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="pws" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="directPump" /></FONT>
</td>

<td  class=mycborder1  >
<FONT class=myfontclr1><bean:write name="praja" property="boreWells" /></FONT>
</td>

 

<td  class=mycborder1 align="right" colspan=7>
<FONT class=myfontclr1 ><bean:write name="praja" property="othersValue" /></FONT>
</td>

</tr>
</logic:iterate>
 
<tr><td class=myfontclr align=center colspan=20><B><font color="#993366">Work Details</font></B></td>
</tr>
 

<tr>	
	<td class=mycborder align=center width="50">
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Work Name</FONT>
	</td>
	 	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Estimate Cost</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Programme</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Sub Programme</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Admin Sanction Ref.No.</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Admin sanc Date </FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Sanctioning Authority</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Date Of Grounding</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Date Of Completion</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Expenditure Up To Previous Month :(Rs.in Lakhs)</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Expenditure During The Month:(Rs.in Lakhs)</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Value of Work done but not Paid:(Rs.in Lakhs)</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Physical Stage of Work </FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Remarks</FONT>
	</td>
	<td class=mycborder align=center  >
	<FONT class=myfontclr><font color="#993366" ><font color="#993366">Options</FONT>
	</td>
	 
   </tr>
<%try{ %>

 <logic:iterate id="praja" name="prajapadamList">
 
<tr align="left" >
<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="workName" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="estCost" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="programme" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="subProgramme" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="adminSancRefNo" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="adminSancDate" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="sanctionAt" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="dateOfGrounding" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="dateOfComple" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="expendetureUpTotheMonth" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="expendetureDuringMon" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="expendetureToBeIncurred" /></FONT>
</td>



<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="physycalStageOFWork" /></FONT>
</td>
 
<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="praja" property="remarks" /></FONT>
</td>


<td  class=mycborder1 align=center>
<a href="switch.do?prefix=/proposals&page=/prajapadam.do?workId=<bean:write name='praja' property='workId'/>&habCode=<bean:write name='praja' property='habCode'/>&mandalCode=<bean:write name='praja' property='mandalCode'/>&districtCode=<bean:write name='praja' property='districtCode'/>&mode=edit"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="switch.do?prefix=/proposals&page=/prajapadam.do?workId=<bean:write name='praja' property='workId' />&habCode=<bean:write name='praja' property='habCode'/>&mandalCode=<bean:write name='praja' property='mandalCode'/>&districtCode=<bean:write name='praja' property='districtCode'/>&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
<%}catch(Exception e){} %>
<%}catch(Exception e){} %>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
