<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@page import="java.io.*,java.sql.*,javax.servlet.*,javax.servlet.http.*"%>
<% int count=0;
		Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft", "preduser", "preduser"); 
        Statement st=con.createStatement();
        Statement st1=con.createStatement();
        ResultSet rs = null,rs1=null;
        String habCode = (String)session.getAttribute("habitationCode");
        //System.out.println("habCode in .jsp:"+habCode);
        
%>
<script language="javascript">


function sourceSelected(index)
{
var sourceCode=document.getElementById("SOURCESLIST["+index+"].sourceCode").value;
var sourceTypeCode=document.getElementById("SOURCESLIST["+index+"].sourceTypeCode").value;
opener.document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=selectSource&sourceTypeCode="+sourceTypeCode+"&sourceCode="+sourceCode;
opener.document.forms[0].submit();
self.close();
}
</script>
<html:form action="/WaterSample.do">

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
	
</tr>
<%
java.util.ArrayList sub = (java.util.ArrayList)session.getAttribute("subdivisions");
 //System.out.println("sub div code in source list:"+sub.size()); %>

<nested:iterate id="SOURCESLIST" name="sourcesList" indexId="ndx">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><!-- <%=count %> -->
<input type="radio" name="radio1" onclick="<%= "javascript: sourceSelected(\" + ndx +"\)"%>" >

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

