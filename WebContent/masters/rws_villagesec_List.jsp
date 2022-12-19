<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
var newWindow;
function openEditWindow(dcode,mcode,pcode)
{

	 
	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin" && ad!="100000")
	{
			alert("Record cannot be edited as it has been freezed");
			return;
		
	}
	
	 
	 var url = "/pred/masters/ceo.do?mode=ceoEdit&dcode="+dcode+" ";
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
	
}
function openExcelWindow()
{

	 
	 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var dcode=document.forms[0].dcode[0].value;
	 var mcode=document.forms[0].mcode[0].value;
	 var pcode=document.forms[0].pcode[0].value;
	 
	 var url = "/pred/masters/villagesec.do?mode=excelView&dcode="+dcode+" ";
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function fnDelete(dcode)
{
	
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
			alert("Record cannot be deleted as it has been freezed");
			return;
	}
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="/pred/masters/villagesec.do?mode=delete&dcode="+dcode+" ";
		document.forms[0].submit();
	}
}
function toggleColor(that)
{
if(that.style.color=="blue")
that.style.color="red";
else if(that.style.color=="red")
that.style.color="blue"
}

</script>
<html:form action="/villagesec.do">
<html:hidden property="init" value="false"/>
<table width="100%">

<tr>
<td align=right><a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;<a href="<rws:context page='/home.jsp'/>">Home</a>
 </td>
</tr>
</table>
<table    width="75%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Village Secretary Details</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="75%" border=1 style="border-collapse:collapse" >

<tr>
    <td  class="btext" align=left>Sl.No</td>
	<td  class="btext" align=center>District</td>
	<td  class="btext" align=center>Mandal</td>
	<td  class="btext" align=center>Panchayat</td>
	<td  class="btext" align=center>Village</td>
	<td  class="btext" align=center> Name</td>
	<td  class="btext" align=center> Mobile NO</td>
	<td  class="btext" align=center> Email Id</td>
	<td  class="btext" align=center> Status</td>
	<td  class="btext" align=center>From Date</td>
	<td  class="btext" align=center>To Date</td>
	<td  class="btext" align=center>Action</td>
</tr>

<% int count=0;%>
<logic:iterate id="VillageSecDetails" name="VillageSecDetails">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td   class="bwborder" align=left><%=count %></td>

<td   class="bwborder" align=left>
<bean:write name="VillageSecDetails" property="dname" /></td>

<td   class="bwborder" align=left>
<bean:write name="VillageSecDetails" property="mname" /></td>

<td   class="bwborder" align=left>
<bean:write name="VillageSecDetails" property="pname" /></td>

<td   class="bwborder" align=left>
<bean:write name="VillageSecDetails" property="vname" /></td>

<td class="rptValue" align=left>
<bean:write name="VillageSecDetails" property="villageSecName" /></td>

<td class="rptValue"  align=left>
<bean:write name="VillageSecDetails" property="villageSecMobile" /></td>

<td class="rptValue"  align=left>

<bean:write name="VillageSecDetails" property="villageSecEmailId" /></td>
<td  class="rptValue" align=left>
<bean:write name="VillageSecDetails" property="status" /></td>

<td  class="rptValue" align=left>
<bean:write name="VillageSecDetails" property="frmDate" /></td>


<td  class="rptValue" align=left>
<bean:write name="VillageSecDetails" property="toDate" /></td>

<td  class="rptValue" align=left>
<logic:equal name="VillageSecDetails" property="toDate" value="">
<a href="./villagesec.do?mode=villageSecEdit&dcode=<bean:write name='VillageSecDetails' property='dcode' />&mcode=<bean:write name='VillageSecDetails' property='mcode' />&pcode=<bean:write name='VillageSecDetails' property='pcode' />&vcode=<bean:write name='VillageSecDetails' property='vcode' />&frmDate=<bean:write name="VillageSecDetails" property="frmDate" />&toDate=<bean:write name="VillageSecDetails" property="toDate" />">Edit</a>
</logic:equal>
</td>


<td  class="rptValue" nowrap align="center">


  
	<input type="hidden" name=dcode value='<bean:write name='VillageSecDetails' property='dcode' />' >
	<input type="hidden" name=mcode value='<bean:write name='VillageSecDetails' property='mcode' />' >
	<input type="hidden" name=pcode value='<bean:write name='VillageSecDetails' property='pcode' />' >
	<input type="hidden" name=vcode value='<bean:write name='VillageSecDetails' property='vcode' />' >
	<input type="hidden" name=frmDate value='<bean:write name='VillageSecDetails' property='frmDate' />' >
	<input type="hidden" name=toDate value='<bean:write name='VillageSecDetails' property='toDate' />' >
	
</td>
</tr>
</logic:iterate>

<%
  if(count==0){
%>

<tr align="left"  onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  colspan="9" align="center" class="btext" > No Records</td>
</tr>
<%  } %>



</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

