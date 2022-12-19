
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>

<script language="JavaScript">

<%
	 
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	 String transdate=null;
	 transdate=dateFormat.format(systemdate);
	 
	 
	 %>
	 
	 
	 



function isSaveAttended()
{


if(document.forms[0].habresult.value=="" || document.forms[0].habresult.value==null)
{
alert("Select any  table for  download");

return false;
}


 
else
{
 



document.forms[0].action="switch.do?prefix=/complaints&page=/Download.do&mode=assetmode";
document.forms[0].submit();
}

}




  

</script>

<%@ include file="/commons/rws_header2.jsp" %>


<html:form action="Download.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
<jsp:include page="/commons/TableHeaderComplaints.jsp">
		<jsp:param name="TableName" value="DownLoad Tables Form" />
	 	
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
	
</td>
</tr>
</thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="400" >

<tr>
<td>
		
		<table  border=0  width="100%">
		
		
		<tr align="center">
		<td class="textborder" width="100">Select tables for download : <font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<html:select property="habresult" styleClass="mycombo" style="width:300px"  >
		<html:option value=""><font class="myfontclr1">Select</html:option>
		<html:option value="assethab"><font class="myfontclr1">Assets - Asset Hab Table</html:option>
		<html:option value="assetmast"><font class="myfontclr1">Assets - Asset Master Table</html:option>
		<html:option value="assetscheme"><font class="myfontclr1">Assets - Asset Scheme Table</html:option>
		<html:option value="source"><font class="myfontclr1">Assets Source Table</html:option>
		<html:option value="rw"><font class="myfontclr1">Assets RawWater Collection Well Table</html:option>
		<html:option value="sstank"><font class="myfontclr1">Assets SSTank Table</html:option>
		<html:option value="filter"><font class="myfontclr1">Assets Filters Table</html:option>
		
		<html:option value="sump"><font class="myfontclr1">Assets Sump Table</html:option>
		<html:option value="fp"><font class="myfontclr1">Assets Foot path Bridge Table</html:option>
		<html:option value="pumphouse"><font class="myfontclr1">Assets PumpHouse Table</html:option>
		<html:option value="watch"><font class="myfontclr1">Assets Watchman Quarter Table</html:option>
		<html:option value="cw"><font class="myfontclr1">Assets Clear Water Collection Well Table</html:option>
		
		
		<html:option value="pumpingmain"><font class="myfontclr1">Assets PumpingMain Table</html:option>
		<html:option value="gravity"><font class="myfontclr1">Assets Gravity Main Table</html:option>
		<html:option value="dis"><font class="myfontclr1">Assets Distribution Table</html:option>
		
		
		<html:option value="bpt"><font class="myfontclr1">Assets Bpt Table</html:option>
		<html:option value="glbr"><font class="myfontclr1">Assets GLBR Table</html:option>
		<html:option value="glsr"><font class="myfontclr1">Assets GLSR Table</html:option>
		
		
		<html:option value="ohbr"><font class="myfontclr1">Assets OHBR Table</html:option>
		<html:option value="ohsr"><font class="myfontclr1">Assets OHSR Table</html:option>
		<html:option value="cis"><font class="myfontclr1">Assets Cisterns Table</html:option>
		<html:option value="other"><font class="myfontclr1">Assets Others Table</html:option>
		<html:option value="cl"><font class="myfontclr1">Assets Chlorination Table</html:option>
		<html:option value="oandm"><font class="myfontclr1">Assets OandM Table</html:option>
		
		
		<html:option value="pumpset"><font class="myfontclr1">Assets Pumpsets Table</html:option>
		</html:select>
		</td>
			 		 
			 	
		
			</tr>
			
		
		
		
	</table>
	</td>
	</tr>

	
	
	<tr>
		<td class="textborder" align=center>			 
		<html:button property="mode" title="click for download" styleClass="btext" value="Download" onclick="isSaveAttended();" />
		
		</td>
	</tr>
	

</table>

</td>
</tr>
</tbody>
</table>


</html:form>

<%@ include file="/commons/rws_footer.jsp"%>

<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>



