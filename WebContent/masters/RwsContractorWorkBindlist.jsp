<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
<%

System.out.println("sss:");

%>
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
	
	 
	 var url = "/pred/masters/sarpanch.do?mod
sarpanchEdit&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+";
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
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
	 
	 var url = "/pred/masters/sarpanch.do?mode=excelView&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+";
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function fnDelete(dcode,mcode,pcode)
{
	
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
			alert("Record cannot be deleted as it has been freezed");
			return;
	}
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="/pred/masters/sarpanch.do?mode=delete&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+";
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
<html:form action="WorkContractorBind.do">
<html:hidden property="init" value="false"/>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
<a href="<rws:context page='/home.jsp'/>">Home</a>
 <a href="#1" onclick="openExcelWindow()" >|&nbsp;Excel&nbsp;</a>&nbsp;
</td>
</tr>
</table>
<table    width="75%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Sarpanch View Form </font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="75%" border=1 style="border-collapse:collapse" >

<tr>
    <td  class="btext" align=left>Sl.No
	
	<td  class="btext" align=center>Circle</td>
	<td  class="btext" align=center>Division</td>
	<td  class="btext" align=center>WorkId</td>
	<td  class="btext" align=center>Contratcor Name</td>
	<td  class="btext" align=center>Bank Name</td>
	<td  class="btext" align=center>Branch Name</td>
	<td  class="btext" align=center>IFSC Code</td>
	<td  class="btext" align=center>Account Number</td>

</tr>

<% int count=0;%>
<logic:iterate id="sarpanchList" name="sarpanchDetails">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td   ><%=count %></td>

<td   class="bwborder" align=left>
<bean:write name="sarpanchList" property="dname" /></td>
<td  class="bwborder" align=left>
<bean:write name="sarpanchList" property="mname" /></td>
<td  class="bwborder" align=left>
<bean:write name="sarpanchList" property="pname" /></td>




<td class="rptValue">&nbsp;<bean:write name="sarpanchList" property="sarpanchName" /></td>
<td class="rptValue"  align=left>

<bean:write name="sarpanchList" property="sarpanchMobile" /></td>
<td  class="rptValue" align=left>
<bean:write name="sarpanchList" property="status" /></td>

<td  class="rptValue" align=left>
<bean:write name="sarpanchList" property="frmDate" /></td>


<td  class="rptValue" align=left>
<bean:write name="sarpanchList" property="toDate" /></td>


<td  class="rptValue" nowrap align="center">

<!--  <a href="#1" onclick="openEditWindow('<bean:write name='sarpanchList' property='dcode' />','<bean:write name='sarpanchList' property='mcode' />','<bean:write name='sarpanchList' property='pcode' />','<bean:write name='sarpanchList' property='sarpanchMobile' />');toggleColor(this) " style="color:blue">Edit&nbsp;</a> -->
  
	<input type="hidden" name=dcode value='<bean:write name='sarpanchList' property='dcode' />' >
	<input type="hidden" name=mcode value='<bean:write name='sarpanchList' property='mcode' />' >
	<input type="hidden" name=pcode value='<bean:write name='sarpanchList' property='pcode' />' >
	
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

