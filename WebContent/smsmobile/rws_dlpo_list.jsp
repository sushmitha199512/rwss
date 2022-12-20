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
	 
	 var url = "/pred/masters/ceo.do?mode=excelView&dcode="+dcode+" ";
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
		document.forms[0].action="/pred/masters/ceo.do?mode=delete&dcode="+dcode+" ";
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
<html:form action="/dlpo.do">
<html:hidden property="init" value="false"/>
<table width="10%">

<tr><td align=right style="wi" ><a href="<rws:context page='/home.jsp'/>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Home|</a>
 </td><td align=right><a href="javascript:history.go(-1)">Back</a>
 </td>
</tr>
</table>
<table    width="75%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">DLPO View</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="75%" border=1 style="border-collapse:collapse" >

<tr>
    <td  class="btext" align=left>Sl.No
	<td  class="btext" align=center>Circle</td>
	<td  class="btext" align=center>Division</td>
	<!-- <td  class="btext" align=center>Mandal</td> -->
	
	<td  class="btext" align=center>DLPO Employee No</td>
	<td  class="btext" align=center>DLPO Name</td>
	<td  class="btext" align=center>DLPO Mobile NO</td>
	
</tr>

<% int count=0;%>
<logic:iterate id="ceoList" name="sarpanchDetails">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td   class="bwborder" align=left><%=count %></td>

<td   class="bwborder" align=left>
<bean:write name="ceoList" property="dname" /></td>

<td   class="bwborder" align=left>
<bean:write name="ceoList" property="mname" /></td>

<%-- <td   class="bwborder" align=left>
<bean:write name="ceoList" property="divmandals" /></td> --%>

<td   class="bwborder" align=left>
<bean:write name="ceoList" property="dlpoNo" /></td>

<td class="rptValue">&nbsp;<bean:write name="ceoList" property="sarpanchName" /></td>
<td class="rptValue"  align=left>

<bean:write name="ceoList" property="sarpanchMobile" /></td>



<td  class="rptValue" nowrap align="center">


  
	<input type="hidden" name=dcode value='<bean:write name='ceoList' property='dcode' />' >
	
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

