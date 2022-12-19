<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<script language="javascript">

</script>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
</td>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td ><B><font color="#FFFFFF">Water Quality Trained Members List</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<!-- table column headings -->
<tr  class="clrborder" align=center>
<td  class="clrborder" align=left>SNO</td>
<td>District</td>
<td>Mandal</td>
<td>Panchayat</td>
<td>VWSC_MEMBERS_TRAINED</td>
<td>USAGE_OF_FTK_KITS</td>
<td>PREPARED_BY</td>
<td>PREPARED_On</td>
</tr>

<% int count=0;%>
<logic:iterate id="mylist" name="wqList">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>

<td  class="bwborder" align=left><bean:write name="mylist" property="distName" /></td>
<td  class="bwborder" align=left><bean:write name="mylist" property="mandalName" /></td>
<td  class="bwborder" align=left><bean:write name="mylist" property="panchayatName" /></td>
<td  class="bwborder" align=right><bean:write name="mylist" property="vwscAchmt" /></td>
<td  class="bwborder" align=right><bean:write name="mylist" property="ftkAchmt" /></td>
<td  class="bwborder" align=left><bean:write name="mylist" property="preparedBy" /></td>
<td  class="bwborder" align=left><bean:write name="mylist" property="updateDate" /></td>
</tr>
</logic:iterate>
<%if(count==0){ %>
<tr class="bwborder" ><td colspan="25" align="center">NO Records</td></tr>
<%} %>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

