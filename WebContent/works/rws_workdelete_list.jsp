<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="9"><B><font color="#FFFFFF">Works For Deletion</B></td>
<td align="center">
</td>
</tr>
<tr >
	<td class="clrborder" align="center">S.No.</td>
	<td class="clrborder" align="center">Work Name</td>	  
	<td class="clrborder" align="center">Work ID</td>
	<td class="clrborder" align="center">Program Name</td>
	<td class="clrborder" align="center">SubProgram Name</td>
	<td class="clrborder" align="center">Sanction No</td>
	<td class="clrborder" align="center">Sanction date</td>
	<td class="clrborder" align="center">Sanction&nbsp;Amount<br>(in lakhs)</td>
	<td class="clrborder" align="center">No of Habitations</td>
	<td class="clrborder" align="center">Check</td>
	</tr>
	
	<%int count = 1;
%>
<nested:iterate id="WORKS_DELETE" property="worksforDelete" indexId="ndx">
<tr align="left" >
<td class="bwborder"><%=count++%></td>

<td class="bwborder"><bean:write name="WORKS_DELETE" property="workname" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETE" property="workid" /></td>
<td class="bwborder"><bean:write name="WORKS_DELETE" property="progName" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETE" property="subprogName" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETE" property="sanctionno" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETE" property="sanctiondt" /></td>
<td  class="bwborder" ><bean:write name="WORKS_DELETE" property="sanctionamount" /></td>
<td  class="bwborder" align="right" ><bean:write name="WORKS_DELETE" property="noofhabs" />
		&nbsp;<input type="button" value="..." title="Show Selected Habs"  class="btext" 
			name="<bean:write name="WORKS_DELETE" property="workid" />" onclick="javascript:fnShowHabs(this)">
	</td>
<td class="bwborder" align=center><input type=checkbox name=check<%=count%> value='<bean:write name="WORKS_DELETE" property="workid" />' ></td>

</tr>
</nested:iterate>

<%if(count==1)
			{ %>
			<tr><td colspan="9" align="center" class="btext">No Records</td></tr>
			<%} else{%>
			<tr><td colspan="9" align="center" ><input type=submit name=submit value=Delete onClick="return fnchkdelete();"></td></tr>
			<%}%>
			<input type="hidden" name="resultCount" value="<%=count%>">
			<html:hidden property="deldate" value='<%=transdate%>'/>
</table>