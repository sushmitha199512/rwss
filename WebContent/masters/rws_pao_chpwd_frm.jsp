<%@ include file="/commons/rws_header1.jsp"%>
<% String uId=request.getParameter("userId");
String special=request.getParameter("special");%>
<script>
function fnSave()
	{
		document.forms[0].userId.value='<%=uId%>';
		if(document.forms[0].userId.value=="")
		{
			alert("User Id  Is Required");
			return false;
		}
		else if(document.forms[0].oldPassword.value=="")
		{
			alert("Old Password  Is Required");
			document.forms[0].oldPassword.focus();
			document.forms[0].userId.value='<%=uId%>';
			return false;
		}
		else if(document.forms[0].newPassword.value=="")
		{
			alert("New  Password  Is Required");
			document.forms[0].newPassword.focus();
			document.forms[0].userId.value='<%=uId%>';
			return false;
		}
		else if(document.forms[0].confirmPassword.value=="")
		{
			alert("Confirm Password  Is Required");
			document.forms[0].confirmPassword.focus();
			document.forms[0].userId.value='<%=uId%>';
			return false;
		}
		else if(document.forms[0].newPassword.value!=document.forms[0].confirmPassword.value)
		{
			alert("New Password and Confirm Password does not match");
			document.forms[0].newPassword.value="";
			document.forms[0].confirmPassword.value="";
			document.forms[0].newPassword.focus();
			document.forms[0].userId.value='<%=uId%>';
			return false;
		}
		 else{
			var user='<%=uId%>';
			document.forms[0].action="rws_pao_chpwd_process.jsp?user="+user;
			document.forms[0].submit();
		   }
	} 

function fnReset()
{
  document.forms[0].oldPassword.value="";
  document.forms[0].newPassword.value="";
  document.forms[0].confirmPassword.value="";
}
</script>

<html>
<form method="post"><BR><BR>
<div align="center" style="width: 80%; height: 322">
<table style="BORDER-COLLAPSE: collapse" borderColor="#4B72B1"  height=45 cellSpacing=0 cellPadding=0 
                  width="236" border=4 align="center">
	<TR>
          <TD width="100%" height=26 bgcolor="#99CC00" align="center"><B><FONT face=Verdana 
                        color=#ffffff size=1 >&nbsp;</FONT></B><FONT face=Verdana 
                        color="#000000" size=2><b>Bank Change Password Form</b></FONT></TD>
        </TR>
 <tr><td>
<table bgcolor="" cellpadding="5" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse" align="center">
	<tbody class="formTBody" >
	<tr>
		<td><font face=Verdana  size="2">User Id:<span class="mandatory">*</span></td>
		<td><font face=Verdana  size="2"><input type="text"  name="userId" value="<%=uId%>" styleClass="text-box"  readonly="true"/></td>
	</tr>
	<tr>
		<td nowrap><font face=Verdana  size="2">Old Password:</font><span class="mandatory">*</span></td>
		<td><input  type="password"  name="oldPassword" redisplay="false" styleClass="text-box" /></td>
	</tr>
	<tr>
		<td nowrap><font face=Verdana  size="2" >New Password:</font><span class="mandatory">*</span></td>
		<td><input  type="password"  name="newPassword" redisplay="false" styleClass="text-box" /></td>
	</tr>
	<tr>
		<td nowrap><font face=Verdana  size="2">Confirm Password:<span class="mandatory">*</span></td>
		<td><input  type="password"  name="confirmPassword" redisplay="false" styleClass="text-box" /></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<input type="button" class="btext" name="Save" value="Save" onclick="fnSave()">
			<input type="button" class="btext" name="Reset" value="Reset" onclick="fnReset()">
		</td>
	</tr>
	</tbody>
	</table>
</td>
</tr>
</tbody>
</table>
</p>
<input type="hidden" name="special" value="<%=special%>">
</form>
</html>
