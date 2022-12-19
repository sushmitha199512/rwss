<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<html:form action="/Panchayat.do">
<html:hidden property="init" value="false"/>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"   border=1 style="border-collapse:collapse" >
<tr><td bgcolor="#8A9FCD" colspan=3 class=myfontclr><B><font color="#FFFFFF">Panchayat List</font></B></td>
<tr>
<td colspan="3" class="clrborder">
<%if(request.getAttribute("selectedDistrict")!=null)%>
District Name: <%= request.getAttribute("selectedDistrict") %>&nbsp;&nbsp;&nbsp;
<%if(request.getAttribute("selectedMandal")!=null)%>
Mandal Name: <%= request.getAttribute("selectedMandal") %>
</td>



</tr>
<tr>
    <td  class="clrborder" align=left >Sl.No</td>
	
	<td  class="clrborder" align=center>Panchayat Code</td>
	<td  class="clrborder" align=center>Panchayat Name</td>
	
	  
</tr>

<% int count=0;%>
<logic:iterate id="panchayatList" name="panchayatDetails">

<% count=count+1;%>
<tr align="left" >
<td  class="bwborder" ><%=count %></td>
<td><bean:write name="panchayatList" property="pcode" /></td>
<td  class="bwborder" align=left>
<bean:write name="panchayatList" property="pname" /></td>


</tr>
</logic:iterate>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

