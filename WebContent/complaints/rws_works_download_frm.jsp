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
	 
	  function hide()
{
//document.getElementById(id).style.visibility = "hidden";

	document.getElementById('text').style.display='none';
}
function show()
{
if(document.forms[0].habresult.value=="admn"  || document.forms[0].habresult.value=="workexpenditure") 
{

	
	document.getElementById('text').style.display='block';
	}
	else
	{
	document.getElementById('text').style.display='none';
	}
	

}
function getItem(id)
{
    var itm = false;
    if(document.getElementById)
        itm = document.getElementById(id);
    else if(document.all)
        itm = document.all[id];
    else if(document.layers)
        itm = document.layers[id];

    return itm;
}

	 
	 
	 
	 
	 



function isSaveAttended()
{
if(document.forms[0].habresult.value=="admn"  || document.forms[0].habresult.value=="workexpenditure")
{
if(document.forms[0].habresult.value=="" || document.forms[0].habresult.value==null)
{
alert("Select any  table for download");

return false;
}

else if(document.forms[0].dist.value=="" || document.forms[0].dist.value==null)
{
alert("select District");
return false;
}
else if(confirm("Do u want to download the data Y/N"))
{
document.forms[0].action="switch.do?prefix=/complaints&page=/Download.do&mode=workmode";
document.forms[0].submit();



}
else
{


 

 



document.forms[0].action="switch.do?prefix=/complaints&page=/Download.do&mode=workmode";
document.forms[0].submit();
}
}
else
{
if(document.forms[0].habresult.value=="" || document.forms[0].habresult.value==null)
{
alert("Select any  table for download");

return false;
}

else
{


 

 



document.forms[0].action="switch.do?prefix=/complaints&page=/Download.do&mode=workmode";
document.forms[0].submit();
}



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
		<html:select property="habresult" styleClass="mycombo" style="width:200px" onchange="show()" >
		<html:option value=""><font class="myfontclr1">Select</html:option>
		<html:option value="admn"><font class="myfontclr1">Work Admn Table</html:option>
		<html:option value="condet"><font class="myfontclr1">Work Contractor Details Table</html:option>
		<html:option value="admnhablnk"><font class="myfontclr1">Work Admn Hab Link Table</html:option>
		
		<html:option value="workcategory"><font class="myfontclr1">Work Category Table</html:option>
		<html:option value="workexpenditure"><font class="myfontclr1">Work Expenditure Table</html:option>
		<html:option value="workcommencement"><font class="myfontclr1">Work Commencement Table</html:option>
		<html:option value="workexpenditureprevious"><font class="myfontclr1">Work Expenditure Upto Previous Year Table</html:option>
		</html:select>
		</td>
			 		 
			 	
		
			</tr>
			
		
		
		
	</table>
	<tr>
    <td class="textborder">
   
    
    
    <div id="text"  style="display:none;">
    <table  border=0  width="340"  align=center  style="margin-bottom:0;margin-top:0"> 
<tr>
   <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:150px"  >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
		</logic:present>
		</html:select>
		</td>
		</tr>
		</table>
		</div>
	

	
	
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



