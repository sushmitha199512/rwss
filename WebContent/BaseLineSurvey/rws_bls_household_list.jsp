<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function openDeleteWindow(url) {
	var width = 1;
	var height = 1;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
		 
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
function openEditWindow(url) {
	//alert(url);
	var width = 850;
	var height = 550;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
		 
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
</script>


<table width="100%" bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Household Hab Details  List</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr >
	<td align=center><FONT size="1" color="maroon" face=verdana ><b>S.No</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana ><b>Household Id</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Hab Code</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Family Details</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Status of Baseline</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Toilets Status</b></font></td>
	
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Drinking water Details</b></font></td>
	
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Survey Date</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Operation</b></font></td>
</tr>
<%int count=1; %>
<logic:iterate id="hablist" name="habdetails">
<tr align="left" >
<td  class=mycborder1 >
<FONT class=myfontclr1><%=count++ %></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="hablist" property="householdnum" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="hablist" property="habCode" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><font color=navy>Head Name:</font><bean:write name="hablist" property="hedname" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Husband/Father Name:</font><bean:write name="hablist" property="fathername" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Relation with Head:</font><bean:write name="hablist" property="hedrelation" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Gender:</font><bean:write name="hablist" property="gender" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Card Type:</font><bean:write name="hablist" property="cardtype" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Card No:</font><bean:write name="hablist" property="cardnum" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Aadhar Card No:</font><bean:write name="hablist" property="adharcardnum" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Job Card No:</font><bean:write name="hablist" property="jobcardnum" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Total Family Count:</font><bean:write name="hablist" property="familycount" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Female Count:</font><bean:write name="hablist" property="femalecount" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Male Count:</font><bean:write name="hablist" property="malecount" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Caste:</font><bean:write name="hablist" property="caste" /></FONT>
<FONT class=myfontclr1><font color=navy>Phone:</font><bean:write name="hablist" property="phonenum" /></FONT>

</td>

<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="hablist" property="blsstatus" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><font color=navy>Toilets available?:</font><bean:write name="hablist" property="toilets" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Constructed Department:</font><bean:write name="hablist" property="departmentnm" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Toilet Type:</font><bean:write name="hablist" property="toilettype" /></FONT><br>
<FONT class=myfontclr1><font color=navy>sanitary latrine serviced?:</font><bean:write name="hablist" property="latrineserviced" /></FONT><br>
<FONT class=myfontclr1><font color=navy>toilet being used?:</font><bean:write name="hablist" property="toiletsuse" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Reason for not using:</font><bean:write name="hablist" property="toiletsnotusereason" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Community toilets using?:</font><bean:write name="hablist" property="commtoiletsuse" /></FONT><br>
<FONT class=myfontclr1><font color=navy>toilets defunt?:</font><bean:write name="hablist" property="toiletsdefuntstatus" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Defunt Reason:</font><bean:write name="hablist" property="toiletsdefuntreason" /></FONT><br>

</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><font color=navy>available?:</font><bean:write name="hablist" property="drinkwateravail" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Source:</font><bean:write name="hablist" property="watersource" /></FONT><br>
<FONT class=myfontclr1><font color=navy>No of pots per Day:</font><bean:write name="hablist" property="usagewaterpots" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Pot capacity:</font><bean:write name="hablist" property="potcapacity" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Distance:</font><bean:write name="hablist" property="sourcedistance" /></FONT><br>
<FONT class=myfontclr1><font color=navy>No of Months Water Available:</font><bean:write name="hablist" property="wateravailmnths" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Quality:</font><bean:write name="hablist" property="waterquality" /></FONT><br>

</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="hablist" property="surveydt" /></FONT>
</td>
<td nowrap>
<a href="#1" onclick=openEditWindow('switch.do?prefix=/BaseLineSurvey&page=/household.do?hsehdnum=<bean:write name='hablist' property='householdnum' />&mode=edit')>
<font color="#6600CC"><b>Edit</b></font></a>&nbsp;|&nbsp;
<a href="#1" onclick=openDeleteWindow('switch.do?prefix=/BaseLineSurvey&page=/household.do?hsehdnum=<bean:write name='hablist' property='householdnum' />&mode=delete')><font color="#990066" ><b>Delete</b></font></a>

</td>
</tr>
</logic:iterate>

</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
