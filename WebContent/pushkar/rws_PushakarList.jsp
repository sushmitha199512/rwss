<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
var newWindow;
function openEditWindow(dcode,mcode,pcode,vcode,pushkartype)
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
	
	 
	 var url = "/pred/pushkar/PushkarGhat.do?mode=pushkarEdit&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+"&vcode="+vcode+"&pushkartype="+pushkartype;
	// alert("url"+url);
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
	 
	 var url = "/pred/pushkar/PushkarGhat.do?mode=excelView&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=yes,"
				   + "status=yes,menubar=yes,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function fnDelete(dcode,mcode,pcode,vcode,pushkartype)
{
	
	 var dcode=document.forms[0].dcode[0].value;
	 var mcode=document.forms[0].mcode[0].value;
	 var pcode=document.forms[0].pcode[0].value;
	
	
	
	  if(confirm("Are You Sure You Want To Delete The Selected Record")){
		document.forms[0].action="/pred/pushkar/PushkarGhat.do?mode=delete&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode+"&vcode="+vcode+"&pushkartype="+pushkartype;
		
		document.forms[0].submit();
}
	
}
/*
function fnDelete(dcode,mcode,pcode)
{

	 var width = 838;
	 var height = 600;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 var url = "/pred/masters/Panchayat.do?mode=delete&dcode="+dcode+"&mcode="+mcode+"&pcode="+pcode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
*/
function toggleColor(that)
{
if(that.style.color=="blue")
that.style.color="red";
else if(that.style.color=="red")
that.style.color="blue"

}



</script>
<html:form action="/PushkarGhat.do">
<html:hidden property="init" value="false"/>
<table width="100%">

<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
<a href="<rws:context page='/home.jsp'/>">Home</a>

</td>
</tr>
</table>
<table    width="55%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">PushkarGhat List</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >
<tr>
<td colspan="20" class="clrborder">
<%if(request.getAttribute("selectedDistrict")!=null)%>
District Name: <%= request.getAttribute("selectedDistrict") %>&nbsp;&nbsp;&nbsp;
<%if(request.getAttribute("selectedMandal")!=null)%>
Mandal Name: <%= request.getAttribute("selectedMandal") %>
<br>
<%if(request.getAttribute("selectedPanchayat")!=null)%>
Panchayat Name: <%= request.getAttribute("selectedPanchayat") %>
</td>
</tr>
<tr>
    <td  class="clrborder" align=left>Sl.No
	
	<td  class="clrborder" align=center>PushkarGhat Type</td>
	<td  class="clrborder" align=center>PushkarGhat Code</td>
	<td  class="clrborder" align=center>PushkarGhat Name</td>
	
	<td  class="clrborder" align=center ><bean:message key="app.op" /></td>
</tr>

<% int count=0;%>
<logic:iterate id="villageList" name="villageDetails">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
<td>&nbsp;<bean:write name="villageList" property="pushkartype" /></td>
<td>&nbsp;<bean:write name="villageList" property="vcode" /></td>
<td  class="bwborder" align=left>
<bean:write name="villageList" property="vname" /></td>

<td  class="bwborder" nowrap align="center">

 <a href="#1" onclick="openEditWindow('<bean:write name='villageList' property='dcode' />','<bean:write name='villageList' property='mcode' />','<bean:write name='villageList' property='pcode' />','<bean:write name='villageList' property='vcode' />','<bean:write name="villageList" property="pushkartype" />');toggleColor(this) " style="color:blue">Edit&nbsp;</a>
  
	<input type="hidden" name=dcode value='<bean:write name='villageList' property='dcode' />' >
	<input type="hidden" name=mcode value='<bean:write name='villageList' property='mcode' />' >
	<input type="hidden" name=pcode value='<bean:write name='villageList' property='pcode' />' >
	<input type="hidden" name=pushkartype value='<bean:write name='villageList' property='pushkartype' />' >
	
</td>

<td  class="bwborder" nowrap align="center">

<a href="#1" onclick="fnDelete('<bean:write name='villageList' property='dcode' />','<bean:write name='villageList' property='mcode' />','<bean:write name='villageList' property='pcode' />','<bean:write name='villageList' property='vcode' />','<bean:write name="villageList" property="pushkartype" />');toggleColor(this)" style="color:blue">Delete&nbsp;</a>
  
	<input type="hidden" name=dcode value='<bean:write name='villageList' property='dcode' />' >
	<input type="hidden" name=mcode value='<bean:write name='villageList' property='mcode' />' >
	<input type="hidden" name=pcode value='<bean:write name='villageList' property='pcode' />' >
	<input type="hidden" name=vcode value='<bean:write name='villageList' property='vcode' />' >
	<input type="hidden" name=pushkartype value='<bean:write name='villageList' property='pushkartype' />' >
</td>


</tr>
</logic:iterate>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

