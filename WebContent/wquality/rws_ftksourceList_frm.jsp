<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@page import="java.io.*,java.sql.*,javax.servlet.*,javax.servlet.http.*"%>
<% int count=0;
		String habCode = (String)session.getAttribute("habitationCode");
        //System.out.println("habCode in .jsp:"+habCode);
        String ftklab=(String)request.getParameter("ftklab");
      // System.out.println("ftklab in .jsp:"+ftklab);
%>
<script language="javascript">


function sourceSelected(index)
{
if(document.forms[0].ftklab.value=="ftk"){
var sourceCode=document.getElementById("SOURCESLIST["+index+"].sourceCode").value;
var sourceTypeCode=document.getElementById("SOURCESLIST["+index+"].sourceTypeCode").value;
opener.document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=selectftkSource&ftklab=ftk&sourceTypeCode="+sourceTypeCode+"&sourceCode="+sourceCode;
opener.document.forms[0].submit();
self.close();}
else if(document.forms[0].ftklab.value=="lab"){
var sourceCode=document.getElementById("SOURCESLIST["+index+"].sourceCode").value;
var sourceTypeCode=document.getElementById("SOURCESLIST["+index+"].sourceTypeCode").value;
var ftktestid=document.getElementById("SOURCESLIST["+index+"].ftktestid").value;
opener.document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=selectftkSource&ftklab=lab&sourceTypeCode="+sourceTypeCode+"&sourceCode="+sourceCode+"&ftktestid="+ftktestid;
opener.document.forms[0].submit();
self.close();}


}
</script>
<html:form action="/WaterLabTesting.do">

<html:hidden property="init" value="false"/>

<%
String q = "",q1="";
java.util.ArrayList codes = new java.util.ArrayList();
codes = (java.util.ArrayList)session.getAttribute("codes");
int i = 0;
 %>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >

<tr><td class=myfontclr bgcolor="#8A9FCD" colspan=11><B><font color="#FFFFFF">Sources List</font></B></td>
<tr>
    <td  class="clrborder" align=left>Select</td>
    <%
    if((habCode == null || habCode == "" || habCode.equals("")))
		{
	%>
	<td  class="clrborder" align=left>Panchayat</td>
	<td  class="clrborder" align=left>Habitation</td>
	<%} %>
	<td  class="clrborder" align=center>Source Type</td>
	<td  class="clrborder" align=center>Source Code</td>
	<td  class="clrborder" align=center>Source Location</td>
	<td  class="clrborder" align=center>Ftk Test Id</td>
	
</tr>
<%
java.util.ArrayList sub = (java.util.ArrayList)session.getAttribute("subdivisions");
 //System.out.println("sub div code in source list:"+sub.size()); %>
<input type=hidden name=ftklab value="<%=request.getParameter("ftklab")%>">
<nested:iterate id="SOURCESLIST" name="sourcesList" indexId="ndx">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><!-- <%=count %> -->
<input type="radio" name="radio1" onclick="<%= "javascript: sourceSelected("+ ndx +")"%>" >

<nested:hidden name="SOURCESLIST" property="sourceTypeCode" indexed="true"/></td>

<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="panchName"/></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="habName"  /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="sourceTypeName"  /></td>
<td>
<nested:hidden name="SOURCESLIST" property="sourceCode" indexed="true"/> 
<nested:write name="SOURCESLIST" property="sourceCode" /></td>
<td  class="bwborder" align=left nowrap>
<nested:write name="SOURCESLIST" property="location" /></td>
<td  class="bwborder" align=left nowrap>
<nested:hidden name="SOURCESLIST" property="ftktestid" indexed="true"/>
<nested:write name="SOURCESLIST" property="ftktestid" /></td>


</tr>

<!-- </div> -->
</nested:iterate>
<%if(count==0){ %>
<tr><td colspan=4 align="center">No Records</td></tr>
<%}
%>

</table>
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

